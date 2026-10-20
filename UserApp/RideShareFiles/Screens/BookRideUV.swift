//
//  PublishRideUV.swift
//  UserApp
//
//  Created by # Admin on 26/11/22.
//

import UIKit
import SysBaseLib
class BookRideUV: ParentViewUV,ParentViewUVDelegate,UITextViewDelegate,MyTxtFieldOnTextChangeDelegate,MyBtnClickDelegate,MyTxtFieldClickDelegate,DTCalendarActionDelegate {
   
    
    
    
   
    
    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerViewHight: NSLayoutConstraint!
    
   
    @IBOutlet weak var startAddTextFiled: MyTextField!
    @IBOutlet weak var endAdressTextFiled: MyTextField!
    @IBOutlet weak var dateTextFiled: MyTextField!
    @IBOutlet weak var selectDataLbl: MyLabel!
    @IBOutlet weak var selectPersonLbl: MyLabel!
    @IBOutlet weak var personTextFiled: MyTextField!
   
    @IBOutlet weak var headerLbl: MyLabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var btnSearch: MyButton!
    
    @IBOutlet weak var dottedView: UIView!
    var startLat = ""
    var startLong = ""
    var startAdd = ""
    var endLat = ""
    var endLong = ""
    var endAdd = ""
    var curentSelectedDate = Date()
    var selectedToDate = ""
    var startTimeDate = ""
    var displayDate = ""
    var enteredSeat = "1"
    var seatsList = [String]()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
    }()
    
    fileprivate lazy var dateFormatterForAPI: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "BookRideScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            self.selectedToDate = self.dateFormatterForAPI.string(from: curentSelectedDate)
            scrView.backgroundColor = SColors.Theme
            self.headerView.backgroundColor = SColors.Theme
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.setData()
        }else if (type == 1){
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationItem.setHidesBackButton(true, animated: false)
            
        }else if (type == 2){
            self.personTextFiled.setText(text: enteredSeat)
            self.personTextFiled.setEnable(isEnabled: false)
            self.personTextFiled.myTxtFieldDelegate = self
            self.personTextFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_arrow_down",  15,15) { (imageView) in
            }
            self.dateTextFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_new_calender",  22,22) { (imageView) in
            }
        }else if(type == 3){
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationItem.setHidesBackButton(false, animated: false)
        }
    }
    func setData()  {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_BOOK_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_BOOK_TXT")
        self.addBack()
        self.cardView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)

        
        self.imageView.backgroundColor = SColors.Theme
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.dottedView.createDashedLine(color: UIColor(hex: 0xDDDDDD), lineWidth: 2, true)
        })
       
        let img = UIImage(named: "ic_new_right_arrow")!
        if !Configurations.isRTLMode() {
                let img1 = img.rotate(180)
                self.backImgView.image = img1
        }else {
            self.backImgView.image = img
        }
        
        self.headerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_RIDE_HEADER_TXT")
        
        self.backImgView.handleClick { instance in
            self.close()
        }
        self.configRTL()
        self.headerViewHight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
       

        self.selectDataLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select Date", key: "LBL_RIDE_SHARE_SELECT_DATE")
        
        self.seatsList = self.userProfileJson.arrOf("RIDE_SHARE_PASSENGER_NOS") as! [String]
        self.dateTextFiled.setEnable(isEnabled: false)
        self.dateTextFiled.myTxtFieldDelegate = self
        self.dateTextFiled.custextColor = UIColor(hex: 0x1B2A3B)
        self.dateTextFiled.setText(text: self.dateFormatter.string(from: curentSelectedDate))
       
        self.dateTextFiled.setEnable(isEnabled: false)
        self.dateTextFiled.myTxtFieldDelegate = self

        
        
        selectPersonLbl.text = self.generalFunc.getLanguageLabel(origValue: "Person", key: "LBL_RIDE_SHARE_PERSON")
        self.btnSearch.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Search", key: "LBL_RIDE_SHARE_SEARCH"))
        self.btnSearch.clickDelegate = self
        self.startAddTextFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_START_LOC_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.startAddTextFiled.setEnable(isEnabled: false)
        self.startAddTextFiled.myTxtFieldDelegate = self
        self.endAdressTextFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_END_LOC_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.endAdressTextFiled.setEnable(isEnabled: false)
        self.endAdressTextFiled.myTxtFieldDelegate = self

        self.startAddTextFiled.custextColor = UIColor(hex: 0x1B2A3B)
        self.endAdressTextFiled.custextColor = UIColor(hex: 0x1B2A3B)
        self.personTextFiled.custextColor = UIColor(hex: 0x1B2A3B)
        self.dateTextFiled.custextColor = UIColor(hex: 0x1B2A3B)
    }
    func getStratAddress()  {
        
        self.startAddTextFiled.setText(text: self.startAdd)
    }
    func getEndAdress()  {
      
        self.endAdressTextFiled.setText(text: endAdd)
    }
    func onTextChanged(sender: MyTextField, text: String) {
        if(sender == personTextFiled){
            if(text == ""){
                self.enteredSeat = "\(1)"
            }else{
                self.enteredSeat = text
            }
        }
    }
    func myBtnTapped(sender: MyButton) {

        
        if self.startAddTextFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" || self.endAdressTextFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
            return
        }
        let searchRideUV = GeneralFunctions.instantiateViewController(pageName: "SearchRideUV") as! SearchRideUV
        let dataDic = ["tStartLat" : self.startLat,"tStartLong" : self.startLong, "tEndLat" : self.endLat, "tEndLong" : self.endLong, "dStartDate" : self.selectedToDate, "NoOfSeats" : self.enteredSeat  ]
            
        searchRideUV.dataDic = dataDic as NSDictionary
        self.push(uv: searchRideUV)
        
    }
    func myTxtFieldTapped(sender: MyTextField) {
        view.endEditing(true)
        
        if sender == dateTextFiled{
            self.openCalender()
        }
        if sender == personTextFiled{
             
            let openListView = OpenListView(uv: self, containerView: self.view)
            openListView.selectedItem = self.enteredSeat
            openListView.show(listObjects: self.seatsList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PERSON"), currentInst: openListView, handler: { (selectedItemId) in
                self.enteredSeat = self.seatsList[selectedItemId]
                self.personTextFiled.setText(text: self.enteredSeat)
            })
        }
        if sender == startAddTextFiled{
            let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
            addDestinationUv.SCREEN_TYPE = "BookStartLocation"
            addDestinationUv.isFromRecentLocView = true
            addDestinationUv.bookRideUV = self
            self.push(uv: addDestinationUv)
        }
        if sender == endAdressTextFiled{
            let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
                       addDestinationUv.SCREEN_TYPE = "BookEndLocation"
                       addDestinationUv.isFromRecentLocView = true
                       addDestinationUv.bookRideUV = self
                       self.push(uv: addDestinationUv)
        }
    }
   
    func openCalender()  {
        
      
        
        let cView = OpenCalendarView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
        cView.cLocale = "en"
        cView.dtCalendarActionDelegate = self
        cView.startDate = Date()
        var dayComponent    = DateComponents()
        dayComponent.day = 60
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
       
        cView.endDate = nextDate
        cView.allowsMultipleSelection = false
        cView.selDate = self.curentSelectedDate
        cView.themeColor = SColors.Theme
        cView.dotColor = SColors.Theme
        cView.setUpView()
        
        Application.window!.addSubview(cView)
    }
    func cancelTapped() {
        
    }
    
    func okTapped(selectedDate: Date?, selectedDates: [Date]?) {
       
           self.displayDate = self.dateFormatter.string(from: selectedDate!)
           self.selectedToDate = self.dateFormatterForAPI.string(from: selectedDate!)
           self.curentSelectedDate = selectedDate!
           self.dateTextFiled.setText(text: self.displayDate )
            
        
    }
  
}
