

import UIKit
import SysBaseLib

class BidInfromationUV: ParentViewUV,ParentViewUVDelegate,MyTxtFieldClickDelegate,MyBtnClickDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var txtFiledCategory: MyTextField!
    @IBOutlet weak var txtFiledName: MyTextField!
    @IBOutlet weak var txtFiledLocation: MyTextField!
    @IBOutlet weak var txtFiledAmount: MyTextField!
    @IBOutlet weak var commentTextView: KMPlaceholderTextView!
    @IBOutlet weak var dateAndTimeView: UIView!
    @IBOutlet weak var btnSubmit: MyButton!
    
    @IBOutlet weak var btnCancel: MyButton!
    @IBOutlet weak var selectDateLbl: MyLabel!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var selectLbl: MyLabel!
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var rideLaterImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryHLbl: MyLabel!
    @IBOutlet weak var categoryVLbl: MyLabel!
    @IBOutlet weak var locationHLbl: MyLabel!
    @IBOutlet weak var amountHLbl: MyLabel!
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var selectDateView: UIView!
    var userProfileJson:NSDictionary!
    var generalFunc = GeneralFunctions()
    var cntView:UIView!
    var bidCategory = ""
    var bidID = ""
    var currentselectedLat = ""
    var currentselectedLong = ""
    var currentAddress = ""
    var required_str = ""
    var userSelectedAddressDic:NSDictionary!
    
    var newScheduleView:ListBottomSheetViewTimePicker!
    var datesAr = [String]()
    var dayAr = [String]()
    var datesDisplay = [String]()
    var datesPass = [String]()
    var selectedIndexCollection = 0
    var selectedIndexPriviousCollection = 0
    var ridelaterNew = false
    var selctedIndex = 0
    var selectedDateTimeNew = ""
    var selectedDateTimeNewPass = ""
    var strPassDate = ""
    var isTimeSelected = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if(type == 0){
            
            cntView = self.generalFunc.loadView(nibName: "BidInfromationScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            self.addBack()
            
        }else if (type == 1){
            self.configRTL()
            self.setData()
            self.getLocation()
        }
        else if (type == 2) {
            self.txtFiledLocation.setEnable(isEnabled: false)
            self.txtFiledLocation.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage : true,  "ic_arrow_right", 20, 20)
            self.txtFiledLocation.myTxtFieldDelegate = self
            
        }
    }
    
    func setData(){
        
        
        required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Bid Information", key: "LBL_BIDDING_POST_TASK_TITLE")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Bid Information", key: "LBL_BIDDING_POST_TASK_TITLE")
        
//        self.txtFiledCategory.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_CATEGORY_TXT")
//        self.txtFiledCategory.setText(text: bidCategory)
//        self.txtFiledCategory.setEnable(isEnabled: false)
        
//        self.txtFiledLocation.setEnable(isEnabled: false)
        
        self.categoryHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_CATEGORY_TXT")
        self.categoryVLbl.text = bidCategory
        
        self.locationHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_SERVICE_ADDRESS_TXT")
        self.amountHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_BUDGET_TXT") + " ( " + userProfileJson.get("CurrencySymbol") + " )"
        
//        self.txtFiledAmount.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_BUDGET_TXT") + " ( " + userProfileJson.get("CurrencySymbol") + " )"
//self.txtFiledName.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NAME_TXT")
        
        self.txtFiledAmount.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_BUDGET_TXT") + " ( " + userProfileJson.get("CurrencySymbol") + " )"
        self.txtFiledLocation.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_SERVICE_ADDRESS_TXT")

        self.txtFiledAmount.getTextField()!.keyboardType = .numberPad
        self.btnSubmit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_POST_BID_TXT"))
        self.btnSubmit.clickDelegate = self
        self.btnSubmit.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.btnCancel.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
        self.btnCancel.setCustomColor(textColor: SColors.ThemeTxt, bgColor: UIColor.lightGray, pulseColor: UIColor.lightGray, borderColor: UIColor.lightGray, borderWidth: 1, cornerRadius: 5)
        self.btnCancel.clickDelegate = self
        
        self.btnCancel.setCustomColor(textColor: SColors.blackColor, bgColor: SColors.ThemeTxt, pulseColor: SColors.blackColor, borderColor: SColors.blackColor, borderWidth: 1, cornerRadius: 10)
        self.btnSubmit.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.blackColor, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        self.commentTextView.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_DETAILS_TXT")
        
        self.commentTextView.layer.borderColor = UIColor.lightGray.cgColor//SColors.Theme.cgColor
        self.commentTextView.layer.borderWidth = 0.5
        self.commentTextView.layer.cornerRadius = 8.0
        
        self.rideLaterImageView.image = UIImage(named: "ic_fly_later")
        GeneralFunctions.setImgTintColor(imgView: self.rideLaterImageView, color: SColors.ThemeTxt)
        // self.rightArrow.image = UIImage(named: "ic_arrow_right")!.rotate(90)
        //GeneralFunctions.setImgTintColor(imgView: self.rightArrow, color: UIColor(hex: 0x202020))
        self.selectDateLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_DATE_TIME_TXT")
        //self.selectLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TXT")
        //        self.selectDateView.layer.borderColor =  UIColor.lightGray.cgColor
        //        self.selectDateView.layer.borderWidth = 1.0
        //        self.selectDateView.layer.cornerRadius = 5.0
        //
        self.selectDateView.backgroundColor = SColors.Theme
        Utils.createRoundedView(view: self.selectDateView, borderColor: SColors.Theme, borderWidth: 0)
        self.selectDateView.handleClick { (instance) in
            self.schdeuleLater()
        }
        
        self.containerView.shadowOnCustomview()
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
        if sender == txtFiledLocation {
            let addAddressUv = GeneralFunctions.instantiateViewController(pageName: "ChooseAddressUV") as! ChooseAddressUV
            addAddressUv.ufxSelectedLatitude = self.currentselectedLat
            addAddressUv.ufxSelectedLongitude = self.currentselectedLong
            addAddressUv.ufxSelectedAddress = self.currentAddress
            addAddressUv.isFromBid = true
            addAddressUv.selectedAddressID = userSelectedAddressDic == nil ? "" : self.userSelectedAddressDic.get("UserSelectedAddressId")
            self.push(uv: addAddressUv)
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        if sender == btnSubmit {
            self.checkData()
        }else if sender == btnCancel {
            self.close()
        }
        else if self.newScheduleView.buttonNegative == sender {
            if !isTimeSelected {
                selectedIndexCollection = 0
                selectedIndexPriviousCollection = 0
            }
            self.newScheduleView.removeFromSuperview()
        }else if self.newScheduleView.buttonPositive == sender {
            
            
            
            let min_hour = Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BIDDING")) ?? 1
            let max_hour = Int(self.userProfileJson.get("MAXIMUM_HOURS_LATER_BIDDING")) ?? 60
            let maxDate = Calendar.current.date(byAdding: .hour, value: max_hour, to: Date())
            let minDate = Calendar.current.date(byAdding: .hour, value: min_hour, to: Date())
            
            
            
            let date = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " + self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + ":00" , dateFormate: "yyyy-MM-dd hh:mm:ss")
            let dateCompare = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " +  self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + " " + self.newScheduleView.amPmLbl.text! , dateFormate: "yyyy-MM-dd hh:mm aa")
            
            //let datFinal = date.toLocalTime()
            
            var stringtTemp = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_BIDDING_MAX_NOTE_MSG")
            let strMin = stringtTemp.replace("#####", withString: self.userProfileJson.get("MAXIMUM_HOURS_LATER_BIDDING")  + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR_TXT"))
            let strMax = strMin.replace("####", withString: self.userProfileJson.get("MINIMUM_HOURS_LATER_BIDDING") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR_TXT"))
            
            if dateCompare.toLocalTime() < minDate!.toLocalTime() {
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_BIDDING_MAX_NOTE_MSG") )
                return
            }
            if dateCompare.toLocalTime() > maxDate!.toLocalTime() {
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_BIDDING_MAX_NOTE_MSG"))
                return
            }
            
            self.dateLbl.text = self.selectedDateTimeNew + " " + self.newScheduleView.timeLbl.text!
            
            let stringFinalDate = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " + self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + ":00" + self.newScheduleView.amPmLbl.text! , dateFormate: "yyyy-MM-dd hh:mm:ssa")
            let tempDateFinal =  stringFinalDate.toLocalTime()
            print(tempDateFinal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            dateFormatter.locale = Locale(identifier: "en_US")
            strPassDate = dateFormatter.string(from: tempDateFinal)
            //stringFinalDate
            isTimeSelected = true
            //selectedIndexCollection = 0
            //selectedIndexPriviousCollection = 0
            self.newScheduleView.removeFromSuperview()
        }
    }
    
    func getLocation(){
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_latitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_longitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_Address")){
            currentselectedLat = GeneralFunctions.getValue(key: "user_current_latitude") as! String
            currentselectedLong = GeneralFunctions.getValue(key: "user_current_longitude") as! String
            currentAddress = GeneralFunctions.getValue(key: "user_current_Address") as! String
            
        }
    }
    
    @IBAction func unwindToBiddinInformation(_ segue:UIStoryboardSegue) {
        if(segue.source.isKind(of:ChooseAddressUV.self)){
            
            let uv = segue.source as! ChooseAddressUV
            
            let data = uv.dataArrList[uv.selectedAddressPosition]
            
            let address = data.get("vBuildingNo") + ", " + data.get("vLandmark") + "\n" + data.get("vServiceAddress")
            self.userSelectedAddressDic = ["UserSelectedAddress":address, "UserSelectedLatitude":data.get("vLatitude"), "UserSelectedLongitude":data.get("vLongitude"), "UserSelectedAddressId":data.get("iUserAddressId")]
            self.txtFiledLocation.setText(text:  data.get("vBuildingNo") + ", " + data.get("vLandmark") + " " + data.get("vServiceAddress"))
            
            
        }
    }
    
    func checkData(){
        
        
        // let fNameEntered = Utils.checkText(textField: self.txtFiledName.getTextField()!) ? true : Utils.setErrorFields(textField: self.txtFiledName.getTextField()!, error: required_str)
        let fLocationEnterd = Utils.checkText(textField: self.txtFiledLocation.getTextField()!) ? true : Utils.setErrorFields(textField: self.txtFiledLocation.getTextField()!, error: required_str)
        let famountEnterd = Utils.checkText(textField: self.txtFiledAmount.getTextField()!) ? true : Utils.setErrorFields(textField: self.txtFiledAmount.getTextField()!, error: required_str)
        
        if (fLocationEnterd == false ||  famountEnterd == false)
        {
            return;
        }
        if strPassDate == "" {
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_DATE_TIME") , uv: self)
            return
        }
        self.bidPost()
    }
    
    func schdeuleLater()  {
        
        let date = Date()
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BIDDING")) ?? 1)
        let minute = (minDate * 3600) / 60
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minute + 1, to: date)!
        //print(modifiedDate)
        
        
        self.datesAr = Date.getDates2(forLastNDays: 90, formate: "dd", startDate: modifiedDate)
        self.dayAr = Date.getDates2(forLastNDays: 90, formate: "E", startDate: modifiedDate)
        self.datesDisplay = Date.getDates2(forLastNDays: 90, formate: "E, MMM dd", startDate: modifiedDate)
        self.datesPass = Date.getDates2(forLastNDays: 90, formate: "dd MMM, yyyy",startDate: modifiedDate)
        
        let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd",startDate: modifiedDate)
        if !isTimeSelected {
            self.newScheduleView = ListBottomSheetViewTimePicker(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height:Application.screenSize.height - 90 - GeneralFunctions.getSafeAreaInsets().bottom))
            self.getCurentTime()
            self.selectedDateTimeNewPass = tempAr[0]
            self.selectedDateTimeNew = self.datesPass[0]
        }
        
        
        self.newScheduleView.collectionView.register(UINib(nibName: "dateTimeCVC", bundle: nil), forCellWithReuseIdentifier: "dateTimeCVC")
        self.newScheduleView.collectionView.dataSource = self
        self.newScheduleView.collectionView.delegate = self
        Utils.delayWithSeconds(0.2) {
            self.newScheduleView.collectionView.reloadData()
        }
        //
        
        
        self.newScheduleView.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Schedule", key: "LBL_SCHEDULE")
        self.newScheduleView.viewHour.cornerRadius = 5
        self.newScheduleView.viewMinuts.cornerRadius = 5
        self.newScheduleView.viewAmPm.cornerRadius = 5
        self.newScheduleView.viewHour.backgroundColor = SColors.ThemeTxt
        self.newScheduleView.viewMinuts.backgroundColor = SColors.ThemeTxt
        self.newScheduleView.viewAmPm.backgroundColor = SColors.ThemeTxt
        self.newScheduleView.viewHour.borderWidth = 1
        self.newScheduleView.viewHour.layer.borderColor = UIColor(hex: 0xE0E0E0).cgColor
        self.newScheduleView.viewMinuts.borderWidth = 1
        self.newScheduleView.viewMinuts.layer.borderColor = UIColor(hex: 0xE0E0E0).cgColor
        self.newScheduleView.viewAmPm.borderWidth = 1
        self.newScheduleView.viewAmPm.layer.borderColor = UIColor(hex: 0xE0E0E0).cgColor
        self.newScheduleView.buttonPositive.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 10)
        self.newScheduleView.buttonNegative.setCustomColor(textColor: SColors.blackColor, bgColor: SColors.ThemeTxt, pulseColor: SColors.blackColor, borderColor: SColors.blackColor, borderWidth: 1, cornerRadius: 10)
        self.newScheduleView.buttonPositive.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Set", key: "LBL_SET"))
        self.newScheduleView.buttonNegative.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"))
        self.newScheduleView.buttonNegative.clickDelegate = self
        self.newScheduleView.buttonPositive.clickDelegate = self
        self.newScheduleView.viewHour.handleClick { (view) in
            self.handleRideLater()
        }
        self.newScheduleView.viewMinuts.handleClick { (view) in
            self.handleRideLater()
        }
        self.newScheduleView.viewAmPm.handleClick { (view) in
            self.handleRideLater()
        }
        self.cntView.addSubview(self.newScheduleView)
        let window = Application.window
        //window?.addSubview(self.newScheduleView)
    }
    
    func handleRideLater(){
        let timeSelector = TimeSelector()
        timeSelector.timeSelected = {
            (timeSelector) in
            print(timeSelector.date)
            if timeSelector.hours.digitCount == 1 {
                self.newScheduleView.hourLbl.text = "0" + String(timeSelector.hours)
            }else{
                self.newScheduleView.hourLbl.text =  String(timeSelector.hours)
                // self.newScheduleView.minutsLbl.text = String(timeSelector.minutes
            }
            if timeSelector.minutes.digitCount == 1 {
                self.newScheduleView.minutsLbl.text = "0" + String(timeSelector.minutes)
            }else{
                self.newScheduleView.minutsLbl.text =  String(timeSelector.minutes)
            }
            if timeSelector.isAm {
                self.newScheduleView.amPmLbl.text = "AM"//self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AM_TXT")
            }else{
                self.newScheduleView.amPmLbl.text = "PM" //self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PM_TXT")
            }
            
            self.newScheduleView.timeLbl.text = self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text!  + " " + self.newScheduleView.amPmLbl.text!
            //self.newScheduleView.hourLbl.text ?? "" + ":" +  self.newScheduleView.minutsLbl.text ?? "" + " " + self.newScheduleView.amPmLbl.text ?? ""
            //self.setLabelFromDate(timeSelector.date)
        }
        timeSelector.overlayAlpha = 0.4
        
        timeSelector.clockTint = SColors.Theme
        timeSelector.minutes = Int(self.newScheduleView.minutsLbl.text ?? "0") ?? 00
        timeSelector.hours = Int(self.newScheduleView.hourLbl.text ?? "12") ?? 12
        if  self.newScheduleView.amPmLbl.text?.uppercased() == "AM" {
            timeSelector.isAm = true
        }else{
            timeSelector.isAm = false
        }
        timeSelector.presentOnView(view: self.view)
    }
    
    func getCurentTime(){
        let date = Date()
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BIDDING")) ?? 1)
        let minute = (minDate * 3600) / 60
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minute + 1, to: date)!
        print(modifiedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh"
        let result = dateFormatter.string(from: modifiedDate)
        self.newScheduleView.hourLbl.text = result
        dateFormatter.dateFormat = "mm"
        let result2 = dateFormatter.string(from: modifiedDate)
        self.newScheduleView.minutsLbl.text = result2
        dateFormatter.dateFormat = "a"
        let result3 =  dateFormatter.string(from: modifiedDate)
        self.newScheduleView.amPmLbl.text = result3
        dateFormatter.dateFormat = "hh:mm a"
        self.newScheduleView.timeLbl.text = dateFormatter.string(from: modifiedDate)
        dateFormatter.dateFormat = "E, MMM dd"
        self.newScheduleView.dayDateLbl.text =  dateFormatter.string(from: modifiedDate)
        print(result)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.datesAr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateTimeCVC", for: indexPath) as! dateTimeCVC
        //            cell.parentView.layer.shadowOpacity = 1.0
        //            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        //            cell.parentView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
        //            cell.parentView.layer.shadowRadius = 4.0
        cell.parentView.layer.cornerRadius = 10
        //            cell.parentView.layer.borderColor = UIColor.black.cgColor
        //            cell.parentView.layer.borderWidth = 0
        cell.dateLbl.text = self.datesAr[indexPath.item]
        cell.dayLbl.text = self.dayAr[indexPath.item]
        if selectedIndexCollection == indexPath.row {
            cell.parentView.backgroundColor = SColors.Theme
            cell.dateLbl.textColor = SColors.ThemeTxt
            cell.dayLbl.textColor = SColors.ThemeTxt
            cell.parentView.layer.borderWidth = 1
            cell.parentView.layer.borderColor = SColors.Theme.cgColor
        }else{
            cell.parentView.backgroundColor = SColors.ThemeTxt
            cell.dateLbl.textColor = UIColor(hex: 0x707070)
            cell.dayLbl.textColor = UIColor(hex: 0x222B45)
            cell.parentView.layer.borderWidth = 1
            cell.parentView.layer.borderColor = UIColor(hex: 0xE0E0E0).cgColor
        }
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexCollection = indexPath.row
        self.newScheduleView.dayDateLbl.text = self.datesDisplay[indexPath.row]
        self.selectedDateTimeNew = self.datesPass[indexPath.row]
        let date = Date()
        let minDate = (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BIDDING")) ?? 1)
        let minute = (minDate * 3600) / 60
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minute + 1, to: date)!
        let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd", startDate: modifiedDate)
        self.selectedDateTimeNewPass = tempAr[indexPath.row]
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        let indexpathPrivious = IndexPath(item: selectedIndexPriviousCollection, section: 0)
        let reloadsIdexpath = [indexPath,indexpathPrivious]
        selectedIndexPriviousCollection = indexPath.row
        self.newScheduleView.collectionView.reloadItems(at: reloadsIdexpath)
        // self.newScheduleView.collectionView.reloadData()
        
        
    }
    
    func bidPost() {
        
        //let parameters = ["type":"PostBid","iBiddingId": bidID, "vContactName" : Utils.getText(textField: self.txtFiledName.getTextField()!) , "tDescription": self.commentTextView.text! ,"fBiddingAmount": Utils.getText(textField: self.txtFiledAmount.getTextField()!),"dBiddingDate": self.strPassDate ,"iAddressId": self.userSelectedAddressDic.get("UserSelectedAddressId")]
        //"vServiceName": Utils.getText(textField: self.txtFiledCategory.getTextField()!)
        
        let parameters = ["type":"PostBid","iBiddingId": bidID, "vContactName" : "" , "tDescription": self.commentTextView.text! ,"fBiddingAmount": Utils.getText(textField: self.txtFiledAmount.getTextField()!),"dBiddingDate": self.strPassDate ,"iAddressId": self.userSelectedAddressDic.get("UserSelectedAddressId")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let opnTripFinishView = OpenTripFinishView(uv: self)
                    
                    opnTripFinishView.ufxDriverAcceptedReqNow = true
                    
                    opnTripFinishView.ufxReqLater = false
                    opnTripFinishView.isFromBid = true
                    opnTripFinishView.isFromUFXCheckOut = false
                    opnTripFinishView.show(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_POSTED"), desc: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), true, .bottom){
                        
                    }
                    //                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    //                            let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                    //                            //rideOrderHistoryTabUV.homeTabBar = self.homeTabBar
                    //                            rideOrderHistoryTabUV.isFromViewProfile = true
                    //                            rideOrderHistoryTabUV.isDirectPush = true
                    //                            rideOrderHistoryTabUV.isFromUFXCheckOut = false
                    //                            rideOrderHistoryTabUV.isFromBidding = true
                    //                            self.push(uv: rideOrderHistoryTabUV)
                    //                        })
                    //
                    return
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
        })
    }
}
