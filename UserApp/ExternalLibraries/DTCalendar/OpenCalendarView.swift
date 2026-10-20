//
//  OpenCalendarView.swift
//  CalendarViewTesting
//
//  Created by Apple on 11/10/22.
//
import UIKit
import Foundation



@objc
public protocol DTCalendarActionDelegate:AnyObject{
    
    func cancelTapped()
    func okTapped(selectedDate:Date?, selectedDates:[Date]?)
}

public class OpenCalendarView: UIView, DTCalendarDelegate, DTCalendarDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var bottomBtnView: UIView!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var okLbl: UILabel!
    @IBOutlet weak var cancelLbl: UILabel!
    @IBOutlet weak var calParentView: UIView!
    @IBOutlet weak var selDateLbl: UILabel!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var yearLbl: UILabel!
    
    var pButton:UIButton!
    var nButton:UIButton!
    
    public var themeColor = UIColor.brown
    public var headerTextColor = UIColor.white
    public var cancelTxtColor = UIColor.black
    public var dotColor = UIColor.red
    public var startDate:Date!
    public var endDate:Date!
    public var calendar: DTCalendar!
    
    public var eventDateArray = [Date]()
    public var allowsMultipleSelection = false
    
    public var yearsArray = [Any]()
    public var selectedYearIndex:Int!
    
    public var selDate = Date()
    public var cLocale = "en"
    
    
    public weak var dtCalendarActionDelegate:DTCalendarActionDelegate?
    
    var view = UIView()
    
    let generalFunc = GeneralFunctions()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        xibSetup()

    }
  
    public override func layoutSubviews() {
        
        setNeedsDisplay()
    }
    public required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OpenCalendarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            //self.closeView()
        }

        if UIDevice.current.orientation.isPortrait {
            //self.closeView()
        }
    }

    public func setUpView(){
        
        
        let bgTapGue = UITapGestureRecognizer()
        bgTapGue.addTarget(self, action: #selector(self.handleTap))
        self.mainBgView.addGestureRecognizer(bgTapGue)
        
        self.mainView.layer.cornerRadius = 4
        self.mainView.clipsToBounds = true
        self.topHeaderView.backgroundColor = self.themeColor
        self.yearLbl.textColor = self.headerTextColor.withAlphaComponent(0.8)
        self.selDateLbl.textColor = self.headerTextColor
        
        self.okLbl.textColor = self.themeColor
        self.cancelLbl.textColor = self.cancelTxtColor
        self.cancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT")
        self.okLbl.text = self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT")
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.cancelTapped(_:)))
        self.cancelLbl.addGestureRecognizer(tap1)

        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.okTapped(_:)))
        self.okLbl.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.scrollToDateTapped(_:)))
        self.selDateLbl.addGestureRecognizer(tap3)
    
        
        
        let calendar = DTCalendar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: self.mainViewHeight.constant - 180))
        calendar.locale = Locale(identifier: self.cLocale)
        calendar.backgroundColor = .white
        self.calendar = calendar
        self.calendar.locale = Locale(identifier: self.cLocale)
        calendar.dataSource = self
        calendar.delegate = self
      
        calendar.headerHeight = 50.0
        calendar.scrollEnabled = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleSelectionColor  = .white
        calendar.appearance.selectionColor = self.themeColor
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .black
        calendar.placeholderType = .none
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.allowsMultipleSelection = self.allowsMultipleSelection
        calendar.locale = Locale(identifier: self.cLocale)
        calendar.select(selDate)
        if self.eventDateArray.contains(selDate) {
            calendar.appearance.eventSelectionColor = self.dotColor
        }else{
            calendar.appearance.eventSelectionColor = UIColor.clear
            
        }
        
        pButton = UIButton(frame: CGRect(x: 16, y: 8, width: 30, height: 30))
        pButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        pButton.tintColor = UIColor.black
        pButton.addTarget(self, action: #selector(previousMonthAction), for: .touchUpInside)
        nButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 82, y: 8, width: 30, height: 30))
        nButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nButton.tintColor = UIColor.black
        nButton.addTarget(self, action: #selector(nextMonthAction), for: .touchUpInside)
        calendar.addSubview(pButton)
        calendar.addSubview(nButton)
        
        self.calParentView.addSubview(calendar)
        
        self.setHeaderDate()
                
        self.setPickerData()
        self.checknextPreEnable()
    }
    
    public func checknextPreEnable(){
        let currentDay = calendar.currentPage
        self.calendar.locale = Locale(identifier: self.cLocale)
        var components = DateComponents()
        components.calendar?.locale = Locale(identifier: self.cLocale)
        var calendarD = Calendar(identifier: .gregorian)
        calendarD.locale = Locale(identifier: self.cLocale)
        components.month = 1
        let nextDay = calendarD.date(byAdding: components, to: currentDay)!
        self.calendar.locale = Locale(identifier: self.cLocale)
        let ndate = self.calendar.gregorian.startOfDay(for: nextDay)
        if(!self.calendar.isPage(inRange: ndate)){
            nButton.isHidden = true
        }else{
            nButton.isHidden = false
        }
        
        let currentDayP = calendar.currentPage
        var componentsP = DateComponents()
        components.calendar?.locale = Locale(identifier: self.cLocale)
        var calendarP = Calendar(identifier: .gregorian)
        calendarP.locale = Locale(identifier: self.cLocale)
        componentsP.month = -1
        let preDay = calendarP.date(byAdding: componentsP, to: currentDayP)!
        self.calendar.locale = Locale(identifier: self.cLocale)
        let pdate = self.calendar.gregorian.startOfDay(for: preDay)
        if(!self.calendar.isPage(inRange: pdate)){
            pButton.isHidden = true
        }else{
            pButton.isHidden = false
        }
        
        
    }
    
    @objc func previousMonthAction(sender: UIButton!) {
        let currentDay = calendar.currentPage
        var components = DateComponents()
        components.calendar?.locale = Locale(identifier: self.cLocale)
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: self.cLocale)
        components.month = -1
        let preDay = calendar.date(byAdding: components, to: currentDay)!
        self.calendar.setCurrentPage(preDay, animated: true)
        self.checknextPreEnable()
    }
    
    @objc func nextMonthAction(sender: UIButton!) {
        let currentDay = calendar.currentPage
        var components = DateComponents()
        components.calendar?.locale = Locale(identifier: self.cLocale)
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: self.cLocale)
        components.month = 1
        let nextDay = calendar.date(byAdding: components, to: currentDay)!
        self.calendar.setCurrentPage(nextDay, animated: true)
        
        self.checknextPreEnable()
    }
    
    public func setHeaderDate(){
        let currentDate = self.selDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: self.cLocale)
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "EEE, MMM d"
        self.selDateLbl.text = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "yyyy"
        self.yearLbl.text = dateFormatter.string(from: currentDate)
        
    }
    
    public func closeView(){
        self.calendar = nil
        self.removeFromSuperview()
    }
    
    @objc func handleTap() {
        self.dtCalendarActionDelegate?.cancelTapped()
        self.closeView()
    }
    
    @objc func cancelTapped(_ sender: UITapGestureRecognizer) {
        
        self.dtCalendarActionDelegate?.cancelTapped()
        self.closeView()
        
    }
    
    @objc func okTapped(_ sender: UITapGestureRecognizer) {
        if(self.yearPicker.isHidden == false){
            self.calParentView.isHidden = false
            self.yearPicker.isHidden = true
            self.cancelLbl.isHidden = false
            self.okLbl.text = self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT")
           
        }else{
            
            print(self.calendar.selectedDate)
            self.dtCalendarActionDelegate?.okTapped(selectedDate: self.calendar.selectedDate, selectedDates: self.calendar.selectedDates)
            self.closeView()
        }
        
    }
    
    @objc func scrollToDateTapped(_ sender: UITapGestureRecognizer) {
        if(self.yearPicker.isHidden == false){
            self.calParentView.isHidden = false
            self.yearPicker.isHidden = true
            self.cancelLbl.isHidden = false
            self.okLbl.text = self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT")
            self.setDateOfYearPicker()
        }else{
            
            self.calendar.select(self.selDate, scrollToDate: true)
        }
        
    }
    
    public func calendar(_ calendar: DTCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame = self.calParentView.bounds
        self.layoutIfNeeded()
    }
    
    public func calendar(_ calendar: DTCalendar, shouldSelect date: Date, at monthPosition: DTCalendarMonthPosition) -> Bool {
        calendar.appearance.eventSelectionColor = UIColor.clear
        return true
    }
    
    public func calendar(_ calendar: DTCalendar, didSelect date: Date, at monthPosition: DTCalendarMonthPosition) {
        
        self.selDate = date
        
        self.setHeaderDate()
        
        Utils.delayWithSeconds(0.25) {
            self.calendar.reloadData()
            if self.eventDateArray.contains(self.selDate) {
                calendar.appearance.eventSelectionColor = self.dotColor
            }else{
                calendar.appearance.eventSelectionColor = UIColor.clear
                
            }
        }

    }

    public func calendarCurrentPageDidChange(_ calendar: DTCalendar) {
        self.checknextPreEnable()
    }
    
    public func maximumDate(for calendar: DTCalendar) -> Date {
        return self.endDate ?? self.calendar.maximumDate
        
    }
    
    public func minimumDate(for calendar: DTCalendar) -> Date {
        return self.startDate ?? self.calendar.minimumDate
    }
    

    /* Year Picker Methods*/
    public func setPickerData(){
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.yearTapped(_:)))
        self.yearLbl.addGestureRecognizer(tap4)
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        
        let currentDate = self.endDate == nil ? self.calendar.maximumDate : self.endDate!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: self.cLocale)
        dateFormatter.dateFormat = "yyyy"
        
        let year = dateFormatter.string(from: currentDate)
        if(Int(year) != nil && Int(year)! >= 0){
            let sYear = self.startDate == nil ? dateFormatter.string(from: self.calendar.minimumDate) : dateFormatter.string(from: self.startDate!)
            if(Int(sYear) != nil && Int(sYear)! >= 0 ){
                for i in Int(sYear)!..<Int(year)! + 1{
                    let currentDateStr = "\(i)"
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.locale = Locale(identifier: self.cLocale)
                    dateFormatter1.dateFormat = "yyyy"
                    yearsArray.append(dateFormatter1.string(from: dateFormatter1.date(from: currentDateStr)!))
                 
                }
            }
        }
        
        self.yearPicker.reloadComponent(0)
        
        
        for i in 0..<self.yearsArray.count{
            let currentDateStr1 = self.yearLbl.text!
            let dateFormatter1 = DateFormatter()
            dateFormatter1.locale = Locale(identifier: self.cLocale)
            dateFormatter1.dateFormat = "yyyy"
            if(self.yearsArray[i] as! String == (dateFormatter1.string(from: dateFormatter1.date(from: currentDateStr1)!))){
                
                self.selectedYearIndex = i
                break
            }
            
        }
        
        
        
    }
    
    @objc func yearTapped(_ sender: UITapGestureRecognizer) {
        if(self.yearsArray.count > 0){
            self.okLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONE")
            self.cancelLbl.isHidden = true
            self.calParentView.isHidden = true
            self.yearPicker.isHidden = false
            if(self.selectedYearIndex != nil){
                self.yearPicker.selectRow(self.selectedYearIndex, inComponent: 0, animated: true)
            }
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.yearsArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.yearsArray[row])"
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        self.setDateOfYearPicker()
        
    }
    
    public func setDateOfYearPicker(){
        self.selectedYearIndex = self.yearPicker.selectedRow(inComponent: 0)
        
        self.yearLbl.text = "\(self.yearsArray[self.yearPicker.selectedRow(inComponent: 0)])"
        
        let currentDateStr = self.selDateLbl.text! + ", " + self.yearLbl.text!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: self.cLocale)
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        let selPickerDate = dateFormatter.date(from: currentDateStr)
        if(selPickerDate != nil){
            self.selDate = selPickerDate!
            self.calendar.select(self.selDate, scrollToDate: true)
        }
    }
}


extension OpenCalendarView : DTCalendarDelegateAppearance {

    public func calendar(_ calendar: DTCalendar, appearance: DTCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {

        if self.eventDateArray.contains(date) {
            return [self.dotColor]
        }else{
            return [UIColor.clear]
        }
        
    }
    
    public func calendar(_ calendar: DTCalendar, numberOfEventsFor date: Date) -> Int {

      
        if(date >= self.startDate && date <= self.endDate){
           
            return 1
        }else{
            return 0
        }
    }
    
    
}
