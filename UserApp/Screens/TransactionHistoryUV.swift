

import UIKit
import SysBaseLib

class TransactionHistoryUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, ParentViewUVDelegate,XFSCalendarDelegate,XFSCalendarDataSource,MyBtnClickDelegate,XFSCalendarDelegateAppearance{
    
    
    
    @IBOutlet weak var contentView: UIView!
    
    var tableView:UITableView!
    var btnOk:MyButton!
    var btnCancel:MyButton!
   
    var calendar: XFSCalendar!
   
    var LIST_TYPE = "All"
    var DATE_RANGE = ""

    let generalFunc = GeneralFunctions()
    var navItem:UINavigationItem!
    var loaderView:UIView!
    
    var dataArrList = [NSDictionary]()
    var filterDataTitleListGlobal = [String]()
    var nextPage_str = 1
    var isLoadingMore = false
    var isNextPageAvail = false
    var selectedFilter = ""
    var cntView:UIView!
    var isPageLoad = false
    var isSafeAreaSet = false
    var startDate = Date()
    var endDate = Date()
    var startDateString = ""
    var endDateString = ""
    var ViewGlobal = UIView()
    var calanderBottomView = UIView()
    let messageLbl = MyLabel()
    var weekGlobal = [Date]()
    var tapCount = 0
    var tempDate = Date()
    var isFromSeeAll = false
    
    var tempIdentifier = "en"
    var originalIdentifier = "en"
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        if(LIST_TYPE == "All"){
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALL"))
        }else if(LIST_TYPE == "Credit"){
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CREDIT"))
        }else{
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DEBIT"))
        }
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.originalIdentifier = GeneralFunctions.getValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY) as! String
            GeneralFunctions.saveValue(key: "G_L_C", value: self.originalIdentifier as AnyObject)
            
            if(GeneralFunctions.getValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY) as! String == "ar"){
                self.tempIdentifier = "ar"
                GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: "en" as AnyObject)
            }else{
                self.tempIdentifier = GeneralFunctions.getValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY) as! String
            }
            
            cntView = self.generalFunc.loadView(nibName: "TransactionHistoryScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            self.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
            
            self.addBack()
            
            setData()
            
           
           
            
        }else if(type == 1){
            
            self.configRTL()
            self.removeCalenderView()
            if isFromSeeAll {
            let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filter")!.resize(toWidth: 20)!.resize(toHeight: 20)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.filterDataTapped))
            self.navItem.rightBarButtonItem = rightButton
            }
            
        }else if(type == 2){
            if(isPageLoad == false){
                self.cntView.frame = self.view.frame
               
                self.cntView.frame = CGRect(x: 20, y:0 , width: Application.screenSize.width - 40 , height: self.view.frame.height - 30)
                
                //self.tableView.frame = CGRect(x: 20, y:2 , width: Application.screenSize.width - 40 , height: self.view.frame.height - 100)
                self.tableView = UITableView.init(frame:  CGRect(x: 20, y:2 , width: Application.screenSize.width - 40 , height: self.view.frame.height - 30))
                 
             

                 self.contentView.addSubview(tableView)
                 self.tableView.layer.cornerRadius = 15
                    
//                 self.tableView.backgroundColor = UIColor.white
                 self.tableView.separatorStyle = .none
                
                self.tableView.clipsToBounds = true
                 self.tableView.delegate = self
                 self.tableView.bounces = false
                 self.tableView.dataSource = self
                 self.tableView.tableFooterView = UIView()
                if #available(iOS 15.0, *) {
                    self.tableView.sectionHeaderTopPadding = 0
                } else {}
                 self.tableView.register(UINib(nibName: "TransactionHistoryListTVCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryListTVCell")
                 self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 8 + GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
                 self.dataArrList.removeAll()
                 
                 
                self.tableView.tableFooterView = UIView.init(frame: CGRect(x:0, y:0, width: self.view.frame.size.width, height: GeneralFunctions.getSafeAreaInsets().bottom))
                self.cntView.layer.masksToBounds = true
               // self.tableView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
               
                //self.shadowOnview(view: self.tableView)
              
               // self.cntView.setNeedsLayout()
                //self.tableView.setNeedsLayout()
//                self.cntView.shadowColor = UIColor.lightGray
//                self.cntView.shadowOffset = CGSize(width: 0, height: 0.0)
//                self.cntView.shadowRadius = 5.0
//                self.cntView.shadowOpacity = 0.5
//                self.cntView.masksToBounds = false
//                self.cntView.shadowPath = UIBezierPath(roundedRect:self.tableView.bounds, cornerRadius:self.tableView.layer.cornerRadius).cgPath
                
                self.messageLbl.frame.size = CGSize(width: self.contentView.frame.size.width - 25, height: 80)
                self.messageLbl.numberOfLines = 4
                self.messageLbl.font = UIFont(name: Fonts().regular, size: 17)!
                self.messageLbl.textAlignment = .center
                self.messageLbl.center = CGPoint(x: tableView.width/2, y: tableView.height/2)
                self.messageLbl.frame = self.tableView.bounds
                self.messageLbl.setPadding(paddingTop: 10, paddingBottom: 10, paddingLeft: 10, paddingRight: 10)
                self.messageLbl.isHidden = true
                self.tableView.addSubview(self.messageLbl)
        
                getDtata()
                isPageLoad = true
              
            }
        }
    }
   
  
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            isSafeAreaSet = true
        }
    }
    
 
    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECENT_TRANSACTION")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECENT_TRANSACTION")
        
        
    }
    @objc func filterDataTapped(){

        var filterDataTitleList = [String]()
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.openNewList = true
        openListView.isFromDate = true
        openListView.transactionHistoryUV = self
        openListView.selectedItem = selectedFilter
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "Today", key: "LBL_TODAY_TXT"))
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "This Week", key: "LBL_THIS_WEEK_TXT"))
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "This Month", key: "LBL_THIS_MONTH"))
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "Select Date Range", key: "LBL_SELECT_DATE_RANGE"))
        filterDataTitleListGlobal = filterDataTitleList
        openListView.show(listObjects: filterDataTitleList, title: self.generalFunc.getLanguageLabel(origValue: "Select Date Range", key: "LBL_SELECT_DATE_RANGE"), currentInst: openListView, .bottom , handler: { (selectedItemId) in
            if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "Today", key: "LBL_TODAY_TXT") {
                self.selectedFilter = filterDataTitleList[selectedItemId]
                self.DATE_RANGE = "today"
                self.dataArrList.removeAll()
                self.nextPage_str = 1
                self.getDtata()
                
            }else if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "This Week", key: "LBL_THIS_WEEK_TXT") {
                self.selectedFilter = filterDataTitleList[selectedItemId]
                self.DATE_RANGE = "week"
                self.nextPage_str = 1
                self.dataArrList.removeAll()
                self.getDtata()
            }else if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "This Month", key: "LBL_THIS_MONTH") {
                self.selectedFilter = filterDataTitleList[selectedItemId]
                self.DATE_RANGE = "month"
                self.nextPage_str = 1
                self.dataArrList.removeAll()
                self.getDtata()
            }else {
               // self.selectedFilter = filterDataTitleList[selectedItemId]
               self.setCalaenderView()
                
            }
            
          
        })
    }
    
    func getDtata(){
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.contentView)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil && isLoadingMore == false){
            loaderView.isHidden = false
        }
        
        
        var parameters = ["type": "getTransactionHistory", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "page": self.nextPage_str.description, "ListType": LIST_TYPE,"dateRange" : self.DATE_RANGE]
        if self.DATE_RANGE == "range" {
            parameters["startDate"] = self.startDateString
            parameters["endDate"] = self.endDateString
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList += [dataTemp]
                        
                    }
                    let NextPage = dataDict.get("NextPage")
                    
                    if(NextPage != "" && NextPage != "0"){
                        self.isNextPageAvail = true
                        self.nextPage_str = Int(NextPage)!
                        
                        self.addFooterView()
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
                    
                    self.tableView.reloadData()
                    
                    self.tableView.isScrollEnabled = true
                    self.messageLbl.isHidden = true
                    if  self.dataArrList.count == 0 {
                        self.messageLbl.isHidden = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }
                    self.setTableHight()
                }else{
                    
                    if(self.isLoadingMore == false){
                        self.messageLbl.isHidden = false
                        self.tableView.isScrollEnabled = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.messageLbl.isHidden = true
                        self.tableView.isScrollEnabled = true
                        
                        self.removeFooterView()
                    }
                }
            }else{
                if(self.isLoadingMore == false){
                    self.messageLbl.isHidden = true
                    self.tableView.isScrollEnabled = true
                    
                    self.generalFunc.setError(uv: self)
                }
            }
            
            self.isLoadingMore = false
            
            self.loaderView.isHidden = true
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryListTVCell", for: indexPath) as! TransactionHistoryListTVCell
        
        let item = self.dataArrList[indexPath.item]
       
        cell.moneyLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("iBalance"))
        cell.descriptionLbl.text = item.get("tDescription")
      
        let tTripBookingDateOrig = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: item.get("dDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime)
        
        let tTripBookingDateOrigNameStr = tTripBookingDateOrig.components(separatedBy: ",")[0]
        
        let tTripBookingDayMonthStr = tTripBookingDateOrig.components(separatedBy: ",")[1].components(separatedBy: " ")
        let tTripBookingMonthStr = tTripBookingDayMonthStr[1]
        let tTripBookingDayStr = tTripBookingDayMonthStr[2]
        
        let tTripBookingTimeYearStr = tTripBookingDateOrig.components(separatedBy: ",")[2].components(separatedBy: " ")
        
        let tTripBookingYearStr = tTripBookingTimeYearStr[1]
        
        cell.dateLbl.text = String(format: "%@ %@, %@ (%@)", tTripBookingDayStr, tTripBookingMonthStr, tTripBookingYearStr, tTripBookingDateOrigNameStr)
        
        if(item.get("eType").uppercased() == "CREDIT"){
//            cell.indicatorImgView.image = UIImage(named: "ic_debit")?.addImagePadding(x: 15, y: 15)
//            GeneralFunctions.setImgTintColor(imgView: cell.indicatorImgView, color: UIColor(hex: 0x56a031))
//            cell.indicatorImgView.backgroundColor = UIColor(hex: 0xdbf2c0)
//            cell.highLightView.backgroundColor = UIColor(hex: 0x56a031)
            cell.indicatorImgView.image = UIImage.init(named: "ic_credit_new")
        }else{
//             cell.indicatorImgView.image = UIImage(named: "ic_debit")?.rotate(180).addImagePadding(x: 15, y: 15)
//             GeneralFunctions.setImgTintColor(imgView: cell.indicatorImgView, color: UIColor(hex: 0xb22316))
//            cell.indicatorImgView.backgroundColor = UIColor(hex: 0xf7d5d6)
//            cell.highLightView.backgroundColor = UIColor(hex: 0xb22316)
            cell.indicatorImgView.image = UIImage.init(named: "ic_debit_new")
            
        }
        
        cell.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.containerView.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.containerView.layer.shadowRadius = 2.0
        cell.containerView.layer.shadowOpacity = 1.0
        cell.containerView.layer.cornerRadius = 0
        cell.containerView.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.containerView.layer.cornerRadius).cgPath
    
        
        cell.containerView.clipsToBounds = true
        
        cell.indicatorImgView.layer.cornerRadius = 15
        cell.indicatorImgView.isHidden = false
        cell.highLightView.isHidden = true
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        if indexPath.row == self.dataArrList.count - 1 {
            cell.sepratorLbl.isHidden = true
        }else {
            cell.sepratorLbl.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        
        if (maximumOffset - currentOffset <= 15) {
            
            if(isNextPageAvail==true && isLoadingMore==false){
                
                isLoadingMore=true
                
                getDtata()
            }
        }
    }
    
    func addFooterView(){
        let loaderView =  self.generalFunc.addMDloader(contentView: self.tableView, isAddToParent: false)
        loaderView.backgroundColor = UIColor.clear
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.tableView.tableFooterView  = loaderView
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
    func setCalaenderView()  {
       
    self.setCalnder()
                
    }
    func setTableHight(){
      
            let dynamicHightTable = self.dataArrList.count * 95
            let staticHight = self.view.frame.height - 30
            if CGFloat(dynamicHightTable) < staticHight && self.dataArrList.count > 0 {
                self.tableView.height = CGFloat(dynamicHightTable)
            }else {
                self.tableView.height = staticHight
            }
     
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnOk {
            if self.tapCount == 2 {
                self.selectedFilter = filterDataTitleListGlobal[3]
                self.removeCalenderView()
                self.DATE_RANGE = "range"
                self.nextPage_str = 1
                self.dataArrList.removeAll()
                self.startDateString = Utils.convertDateToFormate(date: self.startDate, formate: "yyyy-MM-dd")
                self.endDateString = Utils.convertDateToFormate(date: self.endDate, formate: "yyyy-MM-dd")
                
                self.getDtata()
            }else{
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DATE_VALIDATION_TXT"), uv: self)
            }
        }else if sender == self.btnCancel {
            self.removeCalenderView()
        }
    }
    // Set calander and delgates method
    func setCalnder()  {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0.4
        ViewGlobal = view
        ViewGlobal.handleClick { (view) in
            //self.removeCalenderView()
        }
        let window = UIApplication.shared.keyWindow!
        window.addSubview(view)
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = XFSCalendar(frame: CGRect(x: 20, y: self.view.center.y - 50, width: view.frame.size.width - 40, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        window.addSubview(calendar)
        self.calendar = calendar
        self.calendar.backgroundColor = UIColor.white
        self.calendar.round(corners: [.topLeft,.topRight], cornerRadius: 10)
        self.calendar.locale = Locale(identifier: self.tempIdentifier)
        calendar.calendarHeaderView.backgroundColor = SColors.Theme
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.weekdayTextColor = UIColor.white
        
        calendar.calendarWeekdayView.backgroundColor = SColors.Theme
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.placeholderType = .none
        calendar.firstWeekday = 2
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today =  nil
        calendar.select(Date())
        self.startDate = Date()
        self.tempDate = Date()
        self.maximumDate(for: calendar)
        self.minimumDate(for: calendar)
        self.tapCount = 1
        
        let viewCalenderBottom = UIView(frame: CGRect(x: 20, y: (calendar.frame.origin.y + calendar.frame.size.height) - 10 , width: view.frame.size.width - 40, height: 60))
        viewCalenderBottom.backgroundColor = UIColor.white
        viewCalenderBottom.round(corners: [.bottomLeft,.bottomRight], cornerRadius: 10)
        calanderBottomView = viewCalenderBottom
        window.addSubview(viewCalenderBottom)
        
        let buttonCancel = MyButton(frame: CGRect(x: 20, y: 10 , width: (viewCalenderBottom.frame.size.width / 2) - 30, height: 40))
        buttonCancel.setCustomColor(textColor: SColors.ThemeTxt, bgColor: UIColor.lightGray, pulseColor: UIColor.lightGray, borderColor: UIColor.lightGray, borderWidth: 2, cornerRadius: 5)
        buttonCancel.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
        buttonCancel.clickDelegate = self
       
        viewCalenderBottom.addSubview(buttonCancel)
        let buttonOk = MyButton(frame: CGRect(x: (buttonCancel.frame.origin.x + buttonCancel.frame.size.width) + 20, y: 10 , width: buttonCancel.frame.size.width, height: 40))
        buttonOk.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 2, cornerRadius: 5)
        buttonOk.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_GENERAL"))
        buttonOk.clickDelegate = self
        viewCalenderBottom.addSubview(buttonOk)
        btnOk = buttonOk
        btnCancel = buttonCancel
        calendar.swipeToChooseGesture.isEnabled = true
    }
    func removeCalenderView()  {
        
        self.ViewGlobal.removeFromSuperview()
        if self.calendar != nil {
        self.calendar.removeFromSuperview()
        }
        if self.btnOk != nil {
            self.btnOk.removeFromSuperview()
        }
        if self.btnCancel != nil {
            self.btnCancel.removeFromSuperview()
        }
        self.calanderBottomView.isHidden = true
    }
    func calendar(_ calendar: XFSCalendar, didSelect date: Date, at monthPosition: XFSCalendarMonthPosition) {
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
      
        if tapCount == 0 {
            self.tempDate = date
            tapCount = 1
        }else if tapCount == 1 {
            let isSmaller = date < self.tempDate
            if isSmaller {
                self.weekGlobal = Date.dates(from: date, to: self.tempDate)
                self.startDate = date
            }else{
                self.weekGlobal = Date.dates(from: self.tempDate, to: date)
            }
            self.tapCount = 2
            for d in weekGlobal {
            self.calendar.select(d)
            }
        }else if self.tapCount == 2 {
            self.tempDate = date
            tapCount = 1
            for d in weekGlobal {
            self.calendar.deselect(d)
            }
          self.calendar.select(date)
        }

        
    }
    
    func calendar(_ calendar: XFSCalendar, appearance: XFSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return UIColor.white
    }
    func calendar(_ calendar: XFSCalendar, didDeselect date: Date, at monthPosition: XFSCalendarMonthPosition) {
        
        if weekGlobal.count != 0 {
            for d in weekGlobal {
                self.calendar.deselect(d)
                    }
            self.calendar.select(date)
            self.tempDate = date
            self.tapCount = 1
            
        }
    }
    
    internal func maximumDate(for calendar: XFSCalendar) -> Date {
        return Date()
    }
    internal func minimumDate(for calendar: XFSCalendar) -> Date {

            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            let registrationDate = userProfileJson.get("RegistrationDate")
            return Utils.convertStringToDate(dateStr: registrationDate, dateFormat: "yyyy-MM-dd")

    }
    
}
extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    func isSmallerThan(_ date: Date) -> Bool {
         return self < date
      }
}
