//
//  PublishRideUV.swift
//  UserApp
//
//  Created by # Admin on 26/11/22.
//

import UIKit
import SysBaseLib
import GoogleMaps
import CoreLocation
class PublishRideUV: ParentViewUV,ParentViewUVDelegate,MyTxtFieldClickDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,DTCalendarActionDelegate,MyTxtFieldOnTextChangeDelegate,MyBtnClickDelegate,OnDirectionUpdateDelegate {
    
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var topHeaderViewHight: NSLayoutConstraint!
    @IBOutlet weak var btnPublishRide: MyButton!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var loaderView:UIView!
    var updateDirection:UpdateDirections!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var catLbl: MyLabel!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubVIew: UIView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var priviousView: UIView!
    @IBOutlet weak var nextImgView: UIImageView!
    @IBOutlet weak var priviousImgView: UIImageView!
    
    // Step1
    
    @IBOutlet weak var stepCountLbl: MyLabel!
    @IBOutlet weak var icFilterImageView: UIImageView!
    @IBOutlet weak var step1TopView: UIView!
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step1StartLbl: MyLabel!
    @IBOutlet weak var step1StratTextView: KMPlaceholderTextView!
    @IBOutlet weak var step1FromLbl: MyLabel!
    @IBOutlet weak var step1FromTextView: KMPlaceholderTextView!
    @IBOutlet weak var step1gMap: GMSMapView!
    @IBOutlet weak var step1EndPressView: UIView!
    @IBOutlet weak var step1StartPressView: UIView!
    @IBOutlet weak var step1dotStratView: UIView!
    @IBOutlet weak var step1dotEndView: UIView!
    @IBOutlet weak var step1LineView: UIView!
    @IBOutlet weak var step1StartTxtFiled: MyTextField!
    @IBOutlet weak var step1EndTxtFiled: MyTextField!
    @IBOutlet weak var step1LocationFlipView: UIView!
    
    // Step2
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step2ScrollView: UIScrollView!
    @IBOutlet weak var step2DateLbl: MyLabel!
    @IBOutlet weak var step2DateTxtFiled: MyTextField!
    @IBOutlet weak var step2MaxPassengerLbl: MyLabel!
    @IBOutlet weak var step2MaxPassengerView: UIView!
    @IBOutlet weak var step2PriceLbl: MyLabel!
    @IBOutlet weak var step2PriceView: UIView!
    @IBOutlet weak var step2priceTxtFiled: MyTextField!
    @IBOutlet weak var step2PassengerTxtFiled: MyTextField!
    @IBOutlet weak var step2RecomedendPriceLbl: MyLabel!
    @IBOutlet weak var step2CardView: UIView!
    @IBOutlet weak var step2CurrencyView: UIView!
    @IBOutlet weak var step2CurrencyLbl: MyLabel!
    // Step3
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var step3ScrollView: UIScrollView!
    @IBOutlet weak var step3ScrollHight: NSLayoutConstraint!
    @IBOutlet weak var step3DriverNameLbl: MyLabel!
    @IBOutlet weak var step3DriverView: UIView!
    @IBOutlet weak var step3DriverNameTxtFiled: MyTextField!
    @IBOutlet weak var step3DriverContactLbl: MyLabel!
    @IBOutlet weak var step3DriverContactShadowView: UIView!
    @IBOutlet weak var step3CarDetialsLbl: MyLabel!
    @IBOutlet weak var step3CarView: UIView!
    @IBOutlet weak var step3CarMakeLbl: MyLabel!
    @IBOutlet weak var step3CarMakeTxtFiled: MyTextField!
    @IBOutlet weak var step3CarModelLbl: MyLabel!
    @IBOutlet weak var step3CarModelTxtFiled: MyTextField!
    @IBOutlet weak var step3CarPlateLbl: MyLabel!
    @IBOutlet weak var step3CarPlateTxtFiled: MyTextField!
    @IBOutlet weak var step3CarColorLbl: MyLabel!
    @IBOutlet weak var step3CarColorTxtFiled: MyTextField!
    @IBOutlet weak var step3CarImageLbl: MyLabel!
    @IBOutlet weak var step3CarImageView: UIView!
    @IBOutlet weak var step3CarImageDottedView: UIView!
    @IBOutlet weak var step3AdditionalNoteLbl: MyLabel!
    @IBOutlet weak var step3AdditionalNoteTxtView: KMPlaceholderTextView!
    @IBOutlet weak var step3ImageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var step3ChoseImageLbl: MyLabel!
    @IBOutlet weak var step3CarImage: UIImageView!
    @IBOutlet weak var step3CountryCodeTxtFiled: MyTextField!
    @IBOutlet weak var step3PhoneNoTxtFiled: MyTextField!
    
    @IBOutlet weak var step3CountryCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var step3PhonoNoSepratorView: UIView!
    
    
    // Step4
    @IBOutlet weak var step4ScrollView: UIScrollView!
    @IBOutlet weak var step4DocumentLbl: MyLabel!
    @IBOutlet weak var step4View: UIView!
    @IBOutlet weak var step4TblHight: NSLayoutConstraint!
    @IBOutlet weak var step4TblView: UITableView!
    @IBOutlet weak var step4TblMainView: UIView!
    @IBOutlet weak var step4RidePlanLbl: MyLabel!
    @IBOutlet weak var step4TimeLbl: MyLabel!
    @IBOutlet weak var step4ToFromView: UIView!
    @IBOutlet weak var step4StartCity: MyLabel!
    @IBOutlet weak var step4endCity: MyLabel!
    @IBOutlet weak var step4StartAddress: MyLabel!
    @IBOutlet weak var step4endAddress: MyLabel!
    @IBOutlet weak var step4StartView: UIView!
    @IBOutlet weak var step4EndView: UIView!
    @IBOutlet weak var step4StartTimeLbl: MyLabel!
    @IBOutlet weak var step4EndTimeLbl: MyLabel!
    @IBOutlet weak var step4LocationView: UIView!
    @IBOutlet weak var step4TblContainerView: UIView!
    
    
    @IBOutlet weak var bottomViewHight: NSLayoutConstraint!
    // Step Details
    
    @IBOutlet weak var detialsScrollView: UIScrollView!
    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var dataContainerHight: NSLayoutConstraint!
    
    @IBOutlet weak var documentAnchorMainView: UIView!
    @IBOutlet weak var documentTblView: UITableView!
    @IBOutlet weak var documentTblContentView: UIView!
    @IBOutlet weak var documentTblContentHight: NSLayoutConstraint!
    @IBOutlet weak var documentLbl: MyLabel!
    @IBOutlet weak var documentSubAnchiorView: UIView!
    @IBOutlet weak var documentAnchorView: UIView!
    //Sucess View
    @IBOutlet weak var sucessView: UIView!
    @IBOutlet weak var sucessContainerView: UIView!
    @IBOutlet weak var sucessCongratulAtionsLbl: MyLabel!
    @IBOutlet weak var sucessMsgLbl: MyLabel!
    @IBOutlet weak var sucessRouteImgView: UIImageView!
    var currentStep = 0
    var steeperArray = ["Step 1" ,"Step 2", "Step 3", "Step 4"]
    var bannersItemList = [String]()
    
    var finalStrTerms:NSMutableAttributedString!
    var fieldObjArray = [[String : Any]]()
    var documentList = [NSDictionary]()
    var step4DataDic = NSDictionary()
    var seatsList = [String]()
    var startLat = ""
    var startLong = ""
    var startAdd = ""
    var endLat = "0.0"
    var endLong = "0.0"
    var endAdd = ""
    var curentSelectedDate = Date()
    var selectedToDate = ""
    var startTimeDate = ""
    var displayDate = ""
    var enteredAmount = "1.00"
    var enteredSeat = "1"
    var isDriverDetailsLoad = false
    var editData : NSDictionary!
    var PAGE_TYPE = ""
    var PAGE_TITILE = ""
    var duration = ""
    var distance = ""
    var currentLocation = CLLocation()
    var destLocation = CLLocation()
    var itemInfoArray = [NSMutableDictionary]()
    var isBackStep = false
    var driverMarket : GMSMarker = GMSMarker()
    var dropOffCustomMarker:GMSMarker!
    var userMarker : GMSMarker = GMSMarker()
    var pickUpCustomMarker:GMSMarker!
    var isFromBook = false
    var isBtnBlock = false
    var finalStrRP:NSMutableAttributedString!
    var countryListArr:NSArray!
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    var cuntryUrl = ""
    public var openImgSelection:OpenFileSelector!
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
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "PublishRideScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            self.openImgSelection = OpenFileSelector(uv: self)
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.setData()
            if GeneralFunctions.getSafeAreaInsets().bottom != 0 {
                self.bottomViewHight.constant = 70
            }else{
                self.bottomViewHight.constant = 60
            }
        }else if (type == 1){
            if  currentStep == 3 {
                Utils.delayWithSeconds(1) {
                    self.step4ScrollView.contentSize = CGSize(width: self.step4ScrollView.contentSize.width, height: CGFloat(self.step4TblHight.constant + self.step4LocationView.frame.size.height + 150))
                }
            }
           
        }else if( type == 2) {
            
           
            
        }else if ( type == 3) {
            
        }
    }
    func setData()  {
        self.setNavigationBar(title: "")
        self.addBack()
        self.configRTL()
        self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.anchorSubVIew.backgroundColor = SColors.Theme
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "Publish", key: "LBL_RIDE_SHARE_PUBLISH_TITLE_TXT")
        self.setBottomButton()
        self.btnPublishRide.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Publish Ride", key: "LBL_RIDE_SHARE_PUBLISH_BTN_TXT"))
        self.btnPublishRide.setCustomColor(textColor: UIColor(hex: 0x1B2A3B), bgColor: SColors.ThemeTxt, pulseColor: SColors.ThemeTxt, borderColor: SColors.ThemeTxt, borderWidth: 1, cornerRadius: 5)
        self.btnPublishRide.clickDelegate = self
        if editData == nil {
        self.boundMapFromSourceToDest()
            self.setSteps()
        }else{
            if PAGE_TYPE == "Location"{
                self.step1()
            }else if PAGE_TYPE == "Price"{
                Utils.delayWithSeconds(0.1) {
                    self.step2()
                }
            }else {
                self.setDetialsView()
            }
        }
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 3.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
   
  
    func setBottomButton() {
        if editData == nil {
        
        priviousView.backgroundColor = SColors.ThemeTxt
        bottomView.backgroundColor = SColors.Theme
        priviousView.cornerRadius  = 5
        self.priviousView.handleClick { (view) in
            self.isBackStep = true
            self.currentStep -= 1
            
            self.setSteps()
            
          
        }
        
        nextView.cornerRadius  = 5
        nextView.backgroundColor = SColors.ThemeTxt
        self.nextView.handleClick { (view) in
            if !self.validateData(){return}
            self.isBackStep = false
            self.currentStep += 1
            self.setSteps()
           
        }
        self.nextImgView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 0, y: 0)
        self.priviousImgView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 0, y: 0)
        
        GeneralFunctions.setImgTintColor(imgView: self.nextImgView, color: SColors.blackColor)
        GeneralFunctions.setImgTintColor(imgView: self.priviousImgView, color: SColors.blackColor)
        if(Configurations.isRTLMode()){
            self.nextImgView.image = nextImgView.image?.rotate(180)
            GeneralFunctions.setImgTintColor(imgView: self.nextImgView, color: SColors.blackColor)
            
        }else{
            self.priviousImgView.image = priviousImgView.image?.rotate(180)
            GeneralFunctions.setImgTintColor(imgView: self.priviousImgView, color: SColors.blackColor)
        }
        }else{
            self.bottomView.isHidden = true
        }
    }
    func setNavigationBar(title : String) {
      
       
       
        if editData == nil {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PUBLISH_TXT")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PUBLISH_TXT")
            let rightButtonItem = UIBarButtonItem.init(
            title: self.generalFunc.getLanguageLabel(origValue: "Step", key: "LBL_STEP_TXT") + " " + String(self.currentStep + 1) + " / " + String(self.steeperArray.count),
              style: .done,
              target: self,
              action: nil
        )

        self.navigationItem.rightBarButtonItem = nil
        self.stepCountLbl.text = self.generalFunc.getLanguageLabel(origValue: "Step", key: "LBL_STEP_TXT") + " " + String(self.currentStep + 1) + " / " + String(self.steeperArray.count)
        }else{
            self.navigationItem.title = PAGE_TITILE
            self.title = PAGE_TITILE
        }
    }

    func step1() {
        self.hideShowSteps(passedView: self.step1View)
        self.step1StartTxtFiled.isCardViewBorderEnabled = false
        self.step1EndTxtFiled.isCardViewBorderEnabled = false
        self.step1StartTxtFiled.cusTxtFiledBgColor = UIColor(hex: 0xf6f6f6)
        self.step1EndTxtFiled.cusTxtFiledBgColor = UIColor(hex: 0xf6f6f6)
        self.step1StartTxtFiled.custextColor = UIColor(hex: 0x232733)
        self.step1EndTxtFiled.custextColor = UIColor(hex: 0x232733)
        self.step1LocationFlipView.handleClick { instance in
            let tempStrat = self.step1StratTextView.text
            self.step1StratTextView.text = self.step1FromTextView.text
            self.step1StartTxtFiled.setText(text:  self.step1FromTextView.text)
            self.step1FromTextView.text = tempStrat
            self.step1EndTxtFiled.setText(text: tempStrat ?? "")
            let tempStratLat = self.startLat
            let tempStartLong = self.startLong
            self.startLat = self.endLat
            self.startLong = self.endLong
            self.endLat = tempStratLat
            self.endLong = tempStartLong
            let tempStrAdd = self.startAdd
            self.startAdd = self.endAdd
            self.endAdd = tempStrAdd
            self.boundMapFromSourceToDest()
        }
        self.step1dotStratView.backgroundColor = UIColor(hex: 0x008000)
        self.step1dotEndView.backgroundColor = UIColor(hex: 0xCA3939)
        self.step1LineView.backgroundColor = SColors.Theme
       
        self.step1LineView.createDashedLine(color: UIColor(hex: 0xDDDDDD), lineWidth: 2, true)
        
        Utils.createRoundedView(view: self.step1dotEndView, borderColor: UIColor.clear, borderWidth: 0)
        Utils.createRoundedView(view: self.step1dotStratView, borderColor: UIColor.clear, borderWidth: 0)
        GeneralFunctions.setImgTintColor(imgView: self.icFilterImageView , color: SColors.ThemeTxt)
        self.step1TopView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
       
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "Location Detials", key: "LBL_RIDE_SHARE_LOCATION_DETAILS_TITLE")
        self.step1StratTextView.placeholderColor = .lightGray
        self.step1StratTextView.delegate = self
        self.step1StratTextView.placeholder =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_START_LOC_TXT")
        //self.step1StartTxtFiled.setPlaceHolder(placeHolder:  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_START_LOC_TXT"))
        self.step1StartTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_START_LOC_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step1StartTxtFiled.setEnable(isEnabled: false)
        //self.step1StartLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_START_LOC_TXT")
        self.step1StratTextView.isUserInteractionEnabled = false
        self.step1StratTextView.textContainer.maximumNumberOfLines = 1
        self.step1StratTextView.textContainer.lineBreakMode = .byTruncatingTail
        self.step1FromTextView.placeholderColor = .lightGray
        self.step1FromTextView.delegate = self
        self.step1FromTextView.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_END_LOC_TXT")
        
        self.step1EndTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_END_LOC_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step1EndTxtFiled.setEnable(isEnabled: false)
       
        self.step1FromTextView.textContainer.maximumNumberOfLines = 1
        self.step1FromTextView.textContainer.lineBreakMode = .byTruncatingTail
      

        if editData == nil {
            self.step1StartPressView.handleClick{ (instance) in
                let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
                addDestinationUv.SCREEN_TYPE = "PublishStartLocation"
                addDestinationUv.isFromRecentLocView = true
                addDestinationUv.publishRideUV = self
                self.push(uv: addDestinationUv)
                }
            self.step1EndPressView.handleClick{ (instance) in
                let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
                addDestinationUv.SCREEN_TYPE = "PublishEndLocation"
                addDestinationUv.isFromRecentLocView = true
                addDestinationUv.publishRideUV = self
                self.push(uv: addDestinationUv)
                }
        }else{
            self.step1StratTextView.text = self.editData.get("tStartLocation")
            self.step1StartTxtFiled.setText(text: self.editData.get("tStartLocation"))
            self.step1FromTextView.text = self.editData.get("tEndLocation")
            self.step1EndTxtFiled.setText(text: self.editData.get("tEndLocation"))
            self.startLat = self.editData.get("tStartLat")
            self.startLong = self.editData.get("tStartLong")
            self.endLat = self.editData.get("tEndLat")
            self.endLong = self.editData.get("tEndLong")
            self.startAdd = self.step1StratTextView.text
            self.endAdd = self.step1FromTextView.text
            self.boundMapFromSourceToDest()
            //self.addUserLocMarker(location: self.currentLocation)
            //self.destLocMarker(location: self.destLocation)
            self.step1View.isUserInteractionEnabled = true
            self.step1StratTextView.isUserInteractionEnabled = false
            self.step1FromTextView.isUserInteractionEnabled = false
            self.step1LocationFlipView.isHidden = true
            //self.addUserLocMarker(location: )
           // self.addUserLocMarker(location: )
        }
        
        if(Configurations.isRTLMode()){
            self.catLbl.textAlignment = .right
        }
    }
    func step2() {
        self.hideShowSteps(passedView: self.step2View)
        self.step2CardView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "Price & Avalibilty", key: "LBL_RIDE_SHARE_PRICE_AVAILABILITY_TITLE")
        self.step2DateTxtFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_new_calender",  22,22) { (imageView) in
        }
        self.step2DateLbl.text = self.generalFunc.getLanguageLabel(origValue: "Date & Time", key: "LBL_RIDE_SHARE_DATE_TIME_TXT")
        self.step2DateTxtFiled.setEnable(isEnabled: false)
        self.step2DateTxtFiled.myTxtFieldDelegate = self
        self.step2DateTxtFiled.custextColor = UIColor(hex: 0x1B2A3B)
        if self.step2DateTxtFiled.text == "" {
            self.step2DateTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
                string: self.generalFunc.getLanguageLabel(origValue: "Date & Time", key: "LBL_RIDE_SHARE_ADD_DATE_TIME_TXT"),
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
            )
        }else{
            self.step2DateTxtFiled.setPlaceHolder(placeHolder: "")
        }
        
        self.step2MaxPassengerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PASSENGER_AVAILABLE_SEAT")
        self.step2PassengerTxtFiled.getTextField()?.isDividerHidden = true
        self.step2PassengerTxtFiled.setEnable(isEnabled: false)
        self.step2PassengerTxtFiled.myTxtFieldDelegate = self
        self.step2PassengerTxtFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_arrow_down",  15,15) { (imageView) in
        }
        self.step2PassengerTxtFiled.onTextChangedDelegate = self
        self.step2PassengerTxtFiled.myTxtFieldDelegate = self
        self.step2PassengerTxtFiled.setText(text: self.enteredSeat)
        self.step2PassengerTxtFiled.getTextField()!.keyboardType = .numberPad
        self.step2PassengerTxtFiled.custextColor = UIColor(hex: 0x1B2A3B)
        self.step2PassengerTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "Select", key: "LBL_RIDE_SHARE_AND_SELECT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        if(Configurations.isRTLMode()){
            self.step2CurrencyView.roundTo(corners: [.topLeft,.bottomLeft], radius: 8)
            step2RecomedendPriceLbl.textAlignment = .right
        }else{
            self.step2CurrencyView.roundTo(corners: [.topRight,.bottomRight], radius: 8)
            step2RecomedendPriceLbl.textAlignment = .left
        }
        self.step2CurrencyView.backgroundColor = UIColor(hex: 0x8FA1B4)
        self.step2CurrencyView.layer.shadowOpacity = 0.8
        self.step2CurrencyView.layer.shadowRadius = 2
        self.step2CurrencyView.layer.shadowOffset = CGSize.zero
        self.step2CurrencyView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        self.step2priceTxtFiled.getTextField()?.isDividerHidden = true
        self.step2priceTxtFiled.onTextChangedDelegate = self
        self.step2priceTxtFiled.setText(text: self.enteredAmount)
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        self.step2CurrencyLbl.text = userSelectedCurrency
        self.step2PriceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PRICE_PER_SEAT_TXT")
        self.step2priceTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "Enter Amount", key: "LBL_RIDE_SHARE_ENATER_AMOUNT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step2priceTxtFiled.custextColor = UIColor(hex: 0x1B2A3B)
        step2priceTxtFiled.getTextField()!.keyboardType = .decimalPad
        
        step2RecomedendPriceLbl.layer.masksToBounds = true
        step2RecomedendPriceLbl.layer.cornerRadius = 8
        step2RecomedendPriceLbl.backgroundColor = UIColor(hex: 0xF2FEFE)
        step2RecomedendPriceLbl.layer.borderWidth = 1
        step2RecomedendPriceLbl.layer.borderColor = UIColor(red: 0.912, green: 0.912, blue: 0.912, alpha: 1).cgColor
        
       
       
        if editData != nil {
            self.step2View.isUserInteractionEnabled = false
            self.step2priceTxtFiled.setText(text: self.editData.get("fPrice"))
            self.step2PassengerTxtFiled.setText(text: self.editData.get("AvailableSeats"))
            self.step2DateTxtFiled.setText(text: self.editData.get("StartDate") + " " + self.editData.get("StartTime"))
            self.step2DateTxtFiled.setPlaceHolder(placeHolder: "")
            self.step2RecomedendPriceLbl.isHidden = true
            
        }
       
    }
    func step3()  {
        self.hideShowSteps(passedView: self.step3View)
        self.step3DriverView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.step3CarView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.step3DriverContactShadowView.layer.shadowOpacity = 0.8
        self.step3DriverContactShadowView.layer.shadowRadius = 2
        self.step3DriverContactShadowView.layer.shadowOffset = CGSize.zero
        self.step3DriverContactShadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        self.step3DriverContactShadowView.masksToBounds = false
        self.step3AdditionalNoteTxtView.layer.shadowOpacity = 0.8
        self.step3AdditionalNoteTxtView.layer.shadowRadius = 2
        self.step3AdditionalNoteTxtView.layer.shadowOffset = CGSize.zero
        self.step3AdditionalNoteTxtView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        self.step3AdditionalNoteTxtView.masksToBounds = false
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_DRIVER_DETAILS_TITLE")
        self.step3DriverView.backgroundColor = UIColor(hex: 0xf6f6f6)
        self.step3CarView.backgroundColor = UIColor(hex: 0xf6f6f6)
        
        self.step3PhonoNoSepratorView.backgroundColor = UIColor(hex: 0x8FA1B4)
        self.step3DriverView.cornerRadius = 10
        self.step3DriverNameLbl.text = self.generalFunc.getLanguageLabel(origValue: "Driver's Name", key: "LBL_RIDE_SHARE_DRIVER_NAME_TXT") + " *"
        self.step3DriverContactLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_DRIVER_PHONE_NO_TXT") + " *"
        self.step3CountryCodeTxtFiled.isPaddingRequeird = false
        
        
        
        
        if(Configurations.isRTLMode()){
            self.step3CountryCodeTxtFiled.getTextField()?.textAlignment = .right
        }
        
        step3CountryCodeTxtFiled.setText(text: "+" + userProfileJson.get("vPhoneCode"))
        step3PhoneNoTxtFiled.setText(text: userProfileJson.get("vPhone"))
        step3DriverNameTxtFiled.setText(text: userProfileJson.get("vName") + " " + userProfileJson.get("vLastName"))

        self.step3CountryCodeTxtFiled.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 10,15) { (imageView) in

            if(self.countryPrefixImgView == nil){
                self.countryPrefixImgView = imageView
                self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 15), height: Utils.getValueInPixel(value: 10))), placeholderImage:nil)
            }
          
        }
        self.step3CountryCodeTxtFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
        self.step3CountryCodeTxtFiled.myTxtFieldDelegate = self
        self.step3CountryCodeTxtFiled.getTextField()!.adjustsFontSizeToFitWidth = true
        self.step3CountryCodeTxtFiled.getTextField()!.minimumFontSize = 14
        self.step3CountryCodeTxtFiled.setEnable(isEnabled: false)
        self.step3CountryCodeTxtFiled.onTextChangedDelegate = self
        CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
            if(isSuccess){
                self.countryListArr = dataArray
            }
        }
        self.step3CarDetialsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RIDE_SHARE_CAR_DETAILS_TITLE")
        self.step3CarMakeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MAKE_TXT") + " *"
        self.step3CarModelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MODEL") + " *"
        self.step3CarPlateLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_CAR_NUMBER_PLATE_TXT") + " *"
        self.step3CarColorLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_CAR_COLOR_TXT") + " *"
        
        self.step3CarImageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_CAR_IMAGE_TXT") + " *"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.step3CarImageDottedView.createDashedBorderForWholeView()
        })
        
        self.step3CarImage.handleClick { instance in
            self.openImgPicker()
        }
        
        self.step3AdditionalNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_ADDITIONAL_NOTES_TXT") + " *"
        self.step3ChoseImageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_FILE")
        // Plache HolderSet
        self.step3DriverNameTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_DRIVER_NAME_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step3PhoneNoTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_DRIVER_PHONE_NO_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step3CarMakeTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MAKE_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step3CarModelTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MODEL_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step3CarPlateTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_CAR_NUMBER_PLATE_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        self.step3CarColorTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_CAR_COLOR_HINT_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        step3AdditionalNoteTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_ADDITIONAL_NOTES_HINT_TXT")
        step3AdditionalNoteTxtView.placeholderColor = UIColor(hex: 0x8FA1B4)
    }
    func step4()  {
        self.hideShowSteps(passedView: self.step4View)
        self.step4LocationView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.step4TblView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.step4TblContainerView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "Review", key: "LBL_RIDE_SHARE_REVIEW_PUBLISH_DETAILS_TXT")
        self.step4TblView.register(UINib(nibName: "RideShareDocTVCell", bundle: nil), forCellReuseIdentifier: "RideShareDocTVCell")
        self.step4TblView.dataSource = self
        self.step4TblView.delegate = self
        self.step4DocumentLbl.text = self.generalFunc.getLanguageLabel(origValue: "Verify Document", key: "LBL_RIDE_SHARE_VERIFY_DOCS_TITLE")
        //self.shadowOnview(view: self.step4TblMainView)
        step4RidePlanLbl.text = self.generalFunc.getLanguageLabel(origValue: "Ride Plan", key: "LBL_RIDE_SHARE_RIDE_PLAN_TITLE")
        self.getDocList()
        step4StartView.layer.masksToBounds = true
        step4StartView.layer.cornerRadius = self.step4StartView.frame.width / 2
        step4EndView.layer.masksToBounds = true
        step4EndView.layer.cornerRadius = self.step4EndView.frame.width / 2
        self.step4StartView.backgroundColor = UIColor(hex: 0x008000)
        self.step4EndView.backgroundColor = UIColor(hex: 0xCA3939)
       
        
        
    }

    func step4DataSet()  {
        self.step4TimeLbl.text = self.step4DataDic.get("StartDate")
        self.step4StartTimeLbl.text = self.step4DataDic.get("StartTime")
        self.step4StartTimeLbl.textColor = SColors.Theme
        self.step4EndTimeLbl.text = self.step4DataDic.get("EndTime")
        self.step4EndTimeLbl.textColor = SColors.Theme
        
        self.step4StartCity.text = self.generalFunc.getLanguageLabel(origValue: "Start Location", key: "LBL_RIDE_SHARE_DETAILS_START_LOC_TXT") //self.step4DataDic.get("StartCity")
        self.step4StartAddress.text = self.step4DataDic.get("StartAddress")
        self.step4endCity.text = self.generalFunc.getLanguageLabel(origValue: "End Location", key: "LBL_RIDE_SHARE_DETAILS_END_LOC_TXT") //self.step4DataDic.get("EndCity")
        self.step4endAddress.text = self.step4DataDic.get("EndAddress")
        Utils.delayWithSeconds(1) {
            self.step4ScrollView.contentSize = CGSize(width: self.step4ScrollView.contentSize.width, height: CGFloat(self.step4TblHight.constant + self.step4LocationView.frame.size.height + 150))
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.step4ToFromView.createDashedLine(color: UIColor(hex: 0xDDDDDD), lineWidth: 2, true)
        })
    }
    func getFormDetails(){
        self.setLoader(ishidden: false)
        self.step3ScrollView.isHidden = true
        var parameters = ["type":"getRideShareDriverFields","iMemberId": GeneralFunctions.getMemberd()]
        if editData != nil {
            parameters["iPublishedRideId"] = self.editData.get("iPublishedRideId")
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            self.step3ScrollView.isHidden = false
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if self.PAGE_TYPE != "" {
                        self.loadDetials(array: dataDict.arrOf("message"))
                        self.sucessView.isHidden = false
                    }else{
                    self.loadAndSetData(array: dataDict.arrOf("message"))
                    }
                    
                }else{
                    if(dataDict.get(Utils.message_str) == ""){
                        self.generalFunc.setError(uv: self)
                    }else{
                       
                        self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str), key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                          
                         
                                    })
                    }
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    func loadAndSetData(array:NSArray)
    {
       
        var txtAreaCount = 0
        for i in 0..<array.count{
            
            var item = NSDictionary.init()

                item = array[i] as! NSDictionary
            
            
            let y = i * 65 + ((txtAreaCount * 28) + (txtAreaCount * 28))
            let y1 = i * 30
            
            
            if item.get("eInputType") == "Textarea"{
                
                let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.step3ScrollView.frame.size.width - 30), height: 20))
                headerLbl.textColor = UIColor.black
                headerLbl.text = item.get("vFieldName")
                if item.get("eRequired").uppercased() == "YES" {
                    
                    finalStrTerms = NSMutableAttributedString.init(string: "")
                    finalStrTerms.append(self.getAttributedString(str: item.get("vFieldName"),color:UIColor.black))
                    finalStrTerms.append(self.getAttributedString(str: " " + "*",color:SColors.red))
                  
                    
                    //self.termsConditionLbl.attributedText = finalStrTerms
                    headerLbl.attributedText = finalStrTerms//item.get("vFieldName") + " *"
                }
                headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = KMPlaceholderTextView.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.step3ScrollView.frame.size.width - 30), height: 90))
                obj.placeholder = item.get("tFieldName")
                obj.text = item.get("vAddedValue")
                obj.placeholderColor = .lightGray
                obj.delegate = self
//                obj.borderColor = UIColor.lightGray
//                obj.borderWidth = 1
                obj.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
                obj.layer.cornerRadius = 6
                let bottomView = UIView.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.step3ScrollView.frame.size.width - 20), height: 0))
                bottomView.backgroundColor = UIColor.lightGray
                
                let requiredLbl = UILabel.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.step3ScrollView.frame.size.width - 20), height: 20))
                requiredLbl.font = UIFont.systemFont(ofSize: 12, weight:UIFont.Weight.thin)
                requiredLbl.textColor = UIColor.red
                requiredLbl.isHidden = true
                requiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                
                
                
                self.step3ScrollView.addSubview(bottomView)
                self.step3ScrollView.addSubview(headerLbl)
                self.step3ScrollView.addSubview(requiredLbl)
                
                // obj.placeholder = item.get("vFieldName")
                txtAreaCount = txtAreaCount + 1
                self.step3ScrollView.addSubview(obj)
                
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.text = text
                }
                let dic2 = ["Object":obj,"bottomView":bottomView, "headerLbl":headerLbl,"requiredLbl":requiredLbl, "vFieldName":item.get("vFieldName"), "eInputType":"Textarea", "iFieldId":item.get("iFieldId"), "text":text, "eRequired":item.get("eRequired")] as [String : Any]
                self.fieldObjArray.append(dic2)
                
            }else if item.get("eInputType") == "Text" ||   item.get("eInputType") == "Number"{
                
               
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.step3ScrollView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = UIColor.black
                    headerLbl.text = item.get("tFieldName")
                    if item.get("eRequired").uppercased() == "YES" {
                        //headerLbl.text = item.get("vFieldName") + " *"
                        finalStrTerms = NSMutableAttributedString.init(string: "")
                        finalStrTerms.append(self.getAttributedString(str: item.get("vFieldName"),color:UIColor.black))
                        finalStrTerms.append(self.getAttributedString(str: " " + "*",color:SColors.red))
                      
                        
                        //self.termsConditionLbl.attributedText = finalStrTerms
                        headerLbl.attributedText = finalStrTerms
                    }
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                    
                let obj = MyTextField.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.step3ScrollView.frame.size.width - 30), height: 60))
                    obj.isCardView = true
                    obj.myTxtFieldDelegate = self
                    obj.onTextChangedDelegate = self

                    if item.get("value") == "" {
                   obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                    }else{
                        obj.setText(text:item.get("value") )
                    }
               
                self.step3ScrollView.addSubview(headerLbl)
                self.step3ScrollView.addSubview(obj)
                if item.get("eInputType") == "Number" {
                    if item.get("eAllowFloat") == "No"
                    {
                        (obj ).getTextField()!.keyboardType = .numberPad
                    }else
                    {
                        (obj ).getTextField()!.keyboardType = .decimalPad
                    }
                }
               
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.setText(text: text)
                }
                    var tempPut = ""
                    if item.get("tempInput") == ""{
                        tempPut = item.get("eInputType")
                    }else{
                        tempPut = item.get("tempInput")
                    }
                let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iFieldId":item.get("iFieldId"), "text":text, "eRequired":item.get("eRequired"),"tempInput" : tempPut ] as [String : Any]
                self.fieldObjArray.append(dic2)
                
            }
            self.step3ScrollView.contentSize = CGSize(width: self.step3ScrollView.contentSize.width, height: CGFloat(15 + y1 + y + 100))
            self.step3ScrollHight.constant = self.step3ScrollView.contentSize.height + 70
            self.step3ScrollView.isHidden = false
            
            }
            isDriverDetailsLoad = true
        
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        if ishidden {
            //self.nextView.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
        }else{
            self.view.isUserInteractionEnabled = false
           // self.nextView.isUserInteractionEnabled = false
        }
    }
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    func setSteps(){
        if self.currentStep == 0 {
            self.step1()
        }
        if self.currentStep == 1 {
            if isBackStep {
            self.step2()
            }else{
                self.hideShowSteps(passedView: self.step2View)
                self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "Price & Avalibilty", key: "LBL_RIDE_SHARE_PRICE_AVAILABILITY_TITLE")
                self.getRecomededPrice()
            }
        }
        if self.currentStep == 2 {
           
            self.step3()
        }
        if self.currentStep == 3 {
            self.step4()
            
        }
        self.setNavigationBar(title: "")
        self.priviousView.isHidden = currentStep == 0 ? true : false
        if self.steeperArray.count - 1 == self.currentStep {
            self.btnPublishRide.isHidden = false
            
        }else{
            self.btnPublishRide.isHidden = true
        }
        if currentStep == 0 {
            self.topHeaderView.isHidden = true
            self.topHeaderViewHight.constant = 0
        }else{
            self.topHeaderView.isHidden = false
            self.topHeaderViewHight.constant = 35
        }
        self.nextView.isHidden = !self.btnPublishRide.isHidden
    }
   
    func hideShowSteps(passedView : UIView)   {
        let tempViewArray = [step1View,step2View,step3View,step4View,sucessView]
        for val in tempViewArray{
            
            val?.isHidden = passedView == val ? false : true
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.documentList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideShareDocTVCell", for: indexPath) as! RideShareDocTVCell
        let item = self.documentList[indexPath.item]
        cell.descriptionLbl.text = item.get("doc_name")
        //Utils.createRoundedView(view: cell.arrowView, borderColor: .clear, borderWidth: 0)
        //cell.arrowView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        cell.containerView.backgroundColor = UIColor.white
        cell.containerView.tag = indexPath.row
        cell.descriptionLbl.textColor = SColors.blackColor
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value:35), height: Utils.getValueInPixel(value:35))
        cell.imgCategory.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        if  self.documentList.count - 1 == indexPath.row {
            cell.sepratorLbl.isHidden = true
        }else{
            cell.sepratorLbl.isHidden = false
        }
        cell.arrowView.tag = indexPath.row
        cell.arrowView.handleClick { instance in
            let uploadDocUv = GeneralFunctions.instantiateViewController(pageName: "UploadDocUV") as! UploadDocUV
            uploadDocUv.dataDict = self.documentList[indexPath.item]
            uploadDocUv.publishRideUV = self
            uploadDocUv.DOC_TYPE = "User"
            uploadDocUv.documentName = self.documentList[indexPath.item].get("doc_name")
            uploadDocUv.iDriverVehicleId =  self.documentList[indexPath.item].get("doc_masterid")
            if tableView == self.documentTblView {
                uploadDocUv.isOnlyView = true
            }
            self.push(uv: uploadDocUv)
        }
        if tableView == self.documentTblView {
            cell.arrowView.backgroundColor = SColors.ThemeTxt
            cell.arrowViewWidth.constant = 20
            cell.arrowViewHight.constant = 20
            if(Configurations.isRTLMode()){
                cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")?.rotate(180)
            }else{
                cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")
            }
            cell.containerView.handleClick { instance in
                let uploadDocUv = GeneralFunctions.instantiateViewController(pageName: "UploadDocUV") as! UploadDocUV
                uploadDocUv.dataDict = self.documentList[indexPath.item]
                uploadDocUv.publishRideUV = self
                uploadDocUv.DOC_TYPE = "User"
                uploadDocUv.documentName = self.documentList[indexPath.item].get("doc_name")
                
                uploadDocUv.iDriverVehicleId =  self.documentList[indexPath.item].get("doc_masterid")
                //if tableView == self.documentTblView {
                    uploadDocUv.isOnlyView = true
                //}
                self.push(uv: uploadDocUv)
            }
            GeneralFunctions.setImgTintColor(imgView: cell.arrowImageView, color: SColors.blackColor)
            
        }else{
            cell.arrowViewWidth.constant = 15
            cell.arrowViewHight.constant = 15
        if item.get("isUploaded") == "Yes"{
            cell.arrowView.backgroundColor = SColors.ThemeTxt
            cell.arrowImageView.image = UIImage(named:"ic_new_edit")
        }else{
            cell.arrowImageView.image = UIImage(named:"ic_new_upload")
            cell.arrowView.backgroundColor = SColors.ThemeTxt
        }
       
        
        }
        return cell
    }
    func getDocList()  {
        
        
        self.setLoader(ishidden: false)
        self.step4ScrollView.isHidden = true
        let parameters = ["type":"GetVerificationDocuments", "iMemberId":GeneralFunctions.getMemberd(), "tStartLat" : self.startLat  , "tStartLong" : self.startLong ,"tEndLat" : self.endLat , "tEndLong" : self.endLong , "dStartDate" :  self.startTimeDate]
    
    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
    exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
    exeWebServerUrl.currInstance = exeWebServerUrl
    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
        self.setLoader(ishidden: true)
        self.step4ScrollView.isHidden = false
        if(response != ""){
            let dataDict = response.toDict()
            if(dataDict.get("Action") == "1"){
              
                self.step4DataDic = dataDict
                self.step4DataSet()
                self.documentList = dataDict.arrOf("message") as! [NSDictionary]
                UIView.animate(withDuration: 0.2, animations: {
                    self.step4TblHight.constant = CGFloat(self.documentList.count * 60) + 58
                    //self.step4TblHight.contentSize.height + 80
                   
                    self.step4TblView.reloadData()
                }, completion:{ _ in
                })
             
            }else{
            }
            
        }else{
            self.generalFunc.setError(uv: self)
            
            
        }
    })
}
    func validateData() -> Bool  {
        if currentStep == 0 {
            if self.isBtnBlock{
                return false
            }
            if self.step1FromTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" || self.step1StratTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                return false
            }
        }
         if currentStep == 1 {
             if self.step2DateTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                 Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                 return false
             }
         }
        
        
        if currentStep == 2 {
            var verified = ""
           
            if self.step3DriverNameTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
               
                verified = "-1"
            }
            if  self.step3PhoneNoTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3CarMakeTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3CarModelTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3CarPlateTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3CarColorTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3CarColorTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if  self.step3AdditionalNoteTxtView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
                
                verified = "-1"
            }
            if !self.step3CarImageDottedView.isHidden {
                verified = "-1"
            }
            if verified == "-1"
            {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                
                return false
            }
            
            
        }
        if  currentStep == 3 {
            
            }
       
        
        
        return true
    }
    func getStratAddress()  {
        self.step1StratTextView.text = self.startAdd
        self.step1StartTxtFiled.setText(text: self.startAdd)
        self.boundMapFromSourceToDest()
    }
    func getEndAdress()  {
        self.step1FromTextView.text = self.endAdd
        self.step1EndTxtFiled.setText(text: self.endAdd)
        self.boundMapFromSourceToDest()
    }
    func openCalender()  {
        
      
        
        let cView = OpenCalendarView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
        cView.cLocale = "en"
        cView.dtCalendarActionDelegate = self
        cView.startDate = Date()
        var dayComponent    = DateComponents()
        dayComponent.day    = 60
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
    func openTimePicker() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh"
        let hours = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "mm"
        let mins = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "a"
        let amPm =  dateFormatter.string(from: date)
            let timeSelector = TimeSelector()
            timeSelector.timeSelected = {
                (timeSelector) in
                let tempValue = timeSelector.isAm == true ? " AM" : " PM"
                
                var tempMin = String(timeSelector.minutes)
                    if tempMin.count == 1 {
                    tempMin = "0" + tempMin
                }
               
                
                self.startTimeDate = self.selectedToDate + " " + String(timeSelector.hours) + ":" + tempMin + tempValue
                
                let minDate = Calendar.current.date(byAdding: .minute, value: 0, to: Date())
                let dateCompare = Utils.convertDateAppLocaleToGregorian(date: self.startTimeDate, dateFormate: "yyyy-MM-dd hh:mm aa")
                if dateCompare.toLocalTime() < minDate!.toLocalTime() {
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_INVALID_PUBLISH_TIME_MSG"), uv: self)
                    return
                }
                
                
                
                self.step2DateTxtFiled.setText(text: self.displayDate + " " + String(timeSelector.hours) + ":" +  tempMin + tempValue)
                self.step2DateTxtFiled.setPlaceHolder(placeHolder: "")
            }
            timeSelector.overlayAlpha = 0.4
            timeSelector.clockTint = SColors.Theme
            timeSelector.minutes = Int(mins) ?? 12
            timeSelector.hours = Int(hours) ?? 12
            timeSelector.isAm = amPm.uppercased() == "AM" ? true : false
            timeSelector.presentOnView(view: self.view)
        }
    func cancelTapped() {
        
    }
    
    func okTapped(selectedDate: Date?, selectedDates: [Date]?) {
       
        self.displayDate = self.dateFormatter.string(from: selectedDate!)
        self.selectedToDate = self.dateFormatterForAPI.string(from: selectedDate!)
        self.curentSelectedDate = selectedDate!
        self.openTimePicker()
    }
    func myTxtFieldTapped(sender: MyTextField) {
        view.endEditing(true)
        
        if sender == step2DateTxtFiled{
            self.openCalender()
        }
        if sender == step2PassengerTxtFiled{
             
            let openListView = OpenListView(uv: self, containerView: self.view)
            openListView.selectedItem = self.enteredSeat
            openListView.show(listObjects: self.seatsList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_PASSENGER_AVAILABLE_SEAT"), currentInst: openListView, handler: { (selectedItemId) in
                self.enteredSeat = self.seatsList[selectedItemId]
                self.step2PassengerTxtFiled.setText(text: self.enteredSeat)
            })
        }
        
       
         
            if(sender == self.step3CountryCodeTxtFiled){
                 let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
                 countryListUv.publsihRideUV = self
                 if(countryListArr != nil){
                     countryListUv.countryListArr = countryListArr
                 }
                 countryListUv.modalPresentationStyle = .overCurrentContext
                 self.present(countryListUv, animated: true) {
                 }
            }
           
        
        
    }
    func onTextChanged(sender: MyTextField, text: String) {
//        if(sender == step2priceTxtFiled){
//
//            if(text == ""){
//                self.enteredAmount = "\(0.00)"
//            }else{
//                self.enteredAmount = text
//            }
//        }
//        if(sender == step2PassengerTxtFiled){
//            if(text == ""){
//                self.enteredSeat = "\(1)"
//            }else{
//                self.enteredSeat = text
//            }
//        }
    }
    func getDoc()  {
        self.getDocList()
    }
    func postRide() {
       
            //self.setLoader(ishidden: false)
            var selDocID = ""
            if self.documentList.count > 0 {
                for i in 0..<self.documentList.count{
                    let id = self.documentList[i].get("doc_id")
                    if self.documentList[i].get("isUploaded") == "No" {
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please upload all Document.", key: "LBL_RIDE_SHARE_UPLOAD_ALL_DOCUMENT"), uv: self)
                        return 
                    }
                    if id != "" {
                    if(selDocID == ""){
                        selDocID = id
                    }else{
                        selDocID = selDocID + "," + id
                    }
                }
                }
            }

        self.itemInfoArray.append(self.getDic(key: "dName", value: self.step3DriverNameTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "dPhoneCode", value: self.step3CountryCodeTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "dPhone", value: self.step3PhoneNoTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "cMake", value: self.step3CarMakeTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "cModel", value: self.step3CarModelTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "cNumberPlate", value: self.step3CarPlateTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "cColor", value: self.step3CarColorTxtFiled.text))
        self.itemInfoArray.append(self.getDic(key: "cNote", value: self.step3AdditionalNoteTxtView.text))
        
        var parameters = ["type":"PublishRide", "GeneralMemberId":GeneralFunctions.getMemberd(),"tStartCity" : self.step4StartCity.text! , "tEndCity" : self.step4endCity.text!]
        // Step1 Data
        parameters["tStartLat"] = self.startLat
        parameters["tStartLong"] = self.startLong
        parameters["tEndLat"] = self.endLat
        parameters["tEndLong"] = self.endLong
        // Step2 Data
        parameters["dStartDate"] = self.startTimeDate
        parameters["iAvailableSeats"] = self.enteredSeat
        parameters["fPrice"] = self.step2priceTxtFiled.text
        // step3Data
        parameters["tDriverDetails"] = self.itemInfoArray.convertToJson().condenseWhitespace()
        // step4Data
        parameters["documentIds"] = selDocID
        let temp_file_name = self.openImgSelection.fileName as String
        let temp_file_data = self.openImgSelection.selectedFileData as Data
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.uploadImage(fileData: temp_file_data, fileName: temp_file_name) { (response) -> Void in
            
            //self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                  
                    self.loadTripFinishView(title: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message_title"), key: dataDict.get("message_title")) , des: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")))
                    
                }else if (dataDict.get("Action") == "0"){
                    
                    if dataDict.get("LOW_WALLET_BAL").uppercased() == "YES" {
                        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content:self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                self.push(uv: manageWalletUV)

                            }
                        })
                        
                    }
                    
                }
                
                
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        }
        
    }
   
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnPublishRide {
            self.postRide()
        }
    }
    func setDetialsView()  {
        self.sucessView.isHidden = true
        self.shadowOnview(view: self.dataContainerView)
        self.shadowOnview(view: self.documentTblContentView)
        self.documentList = self.editData.arrOf("tDocumentIds") as! [NSDictionary]
        self.documentTblContentHight.constant = CGFloat(self.documentList.count * 55) + 22
        self.documentTblView.register(UINib(nibName: "RideShareDocTVCell", bundle: nil), forCellReuseIdentifier: "RideShareDocTVCell")
        self.documentTblView.dataSource = self
        self.documentTblView.delegate = self
        self.step1View.isHidden = true
        self.getFormDetails()
        self.catLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_DRIVER_DETAILS_TITLE")
        self.documentLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_VERIFY_DOCS_TITLE")
        self.documentAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.documentSubAnchiorView.backgroundColor = SColors.Theme
        if isFromBook{
            self.documentAnchorMainView.isHidden = true
            self.documentTblView.isHidden = true
            self.documentTblContentView.isHidden = true
        }else{
            self.documentAnchorMainView.isHidden = false
            self.documentTblView.isHidden = false
            self.documentTblContentView.isHidden = false
            self.shadowOnview(view: documentTblContentView)
            self.documentTblView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        }
    }
    func loadDetials(array:NSArray)
    {
        self.dataContainerView.isUserInteractionEnabled = false
       
        var txtAreaCount = 0
        var hight = 0
        for i in 0..<array.count{
            
            var item = NSDictionary.init()

                item = array[i] as! NSDictionary
            
            
            let y = i * 65 + ((txtAreaCount * 28) + (txtAreaCount * 28))
            let y1 = i * 30
            
            
            if item.get("eInputType") == "Textarea"{
                
                let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                headerLbl.textColor = UIColor.black
                headerLbl.text = item.get("vFieldName")
              
                headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = KMPlaceholderTextView.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 90))
                obj.placeholder = item.get("tFieldName")
                obj.text = item.get("value")
                obj.placeholderColor = .lightGray
                obj.delegate = self
                obj.borderColor = UIColor.lightGray
                obj.borderWidth = 1
                obj.layer.cornerRadius = 6
                let bottomView = UIView.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.dataContainerView.frame.size.width - 20), height: 0))
                bottomView.backgroundColor = UIColor.lightGray
                
                
                
                
                
                self.dataContainerView.addSubview(bottomView)
                self.dataContainerView.addSubview(headerLbl)
                
                
                
                txtAreaCount = txtAreaCount + 1
                self.dataContainerView.addSubview(obj)
                
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.text = text
                }
                
                
            }else if item.get("eInputType") == "Text" ||   item.get("eInputType") == "Number"{
                
               
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = UIColor.black
                    headerLbl.text = item.get("tFieldName")
                    
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                    
                let obj = MyTextField.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 60))
                    obj.isCardView = true
                    obj.myTxtFieldDelegate = self
                    obj.onTextChangedDelegate = self

                    if item.get("value") == "" {
                   obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                    }else{
                        obj.setText(text:item.get("value") )
                    }
               
                self.dataContainerView.addSubview(headerLbl)
                self.dataContainerView.addSubview(obj)
                if item.get("eInputType") == "Number" {
                    if item.get("eAllowFloat") == "No"
                    {
                        (obj ).getTextField()!.keyboardType = .numberPad
                    }else
                    {
                        (obj ).getTextField()!.keyboardType = .decimalPad
                    }
                }
               
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.setText(text: text)
                }
                    var tempPut = ""
                    if item.get("tempInput") == ""{
                        tempPut = item.get("eInputType")
                    }else{
                        tempPut = item.get("tempInput")
                    }
               
                
            }
            self.detialsScrollView.contentSize = CGSize(width: self.detialsScrollView.contentSize.width, height: CGFloat(150 + y1 + y + 130 + Int(self.documentTblContentHight.constant)))
            self.dataContainerView.isHidden = false
            self.detialsScrollView.isScrollEnabled = true
            self.dataContainerHight.constant = CGFloat(15 + y1 + y + 160)
            
            }
            isDriverDetailsLoad = true
        
    }
    func boundMapFromSourceToDest(){
        self.currentLocation = CLLocation(latitude: Double(self.startLat)!, longitude: Double(self.startLong)!)
        self.destLocation = CLLocation(latitude: Double(self.endLat)!, longitude: Double(self.endLong)!)
        if startLat != "" && endLat != "0.0" {
            self.step1gMap.clear()
            userMarker.map = nil
            driverMarket.map = nil

           
            updateDirection = UpdateDirections(uv: self, gMap: self.step1gMap, fromLocation: currentLocation, destinationLocation: destLocation, isCurrentLocationEnabled: false)
            self.isBtnBlock = true
            updateDirection.onDirectionUpdateDelegate = self
            updateDirection.setCurrentLocEnabled(isCurrentLocationEnabled: false)
            updateDirection.scheduleDirectionUpdate(eTollSkipped: "Yes")
            let maxZoomLevel:Float = 17
            if(self.step1gMap != nil && self.step1gMap.minZoom < maxZoomLevel - 3.5){
                self.step1gMap.setMinZoom(self.step1gMap.minZoom, maxZoom: maxZoomLevel - 3.5)
            }
            
            var bounds = GMSCoordinateBounds()
            let orgLocation = CLLocation(latitude: self.currentLocation.coordinate.latitude, longitude:  self.currentLocation.coordinate.longitude)
            let destLocationTemp = CLLocation(latitude: self.destLocation.coordinate.latitude, longitude:  self.destLocation.coordinate.longitude)
            bounds =  bounds.includingCoordinate(orgLocation.coordinate)
            bounds =  bounds.includingCoordinate(destLocationTemp.coordinate)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if(self.step1gMap != nil){
                    if(self.step1gMap.minZoom < maxZoomLevel){
                        self.step1gMap.setMinZoom(self.step1gMap.minZoom, maxZoom: maxZoomLevel)
                    }
                    
                }
                
            }
            
            if(self.step1gMap != nil){
                self.step1gMap.animate(with: update)
            }
            
            
            CATransaction.commit()
        }else {
            if startLat != "" {
            let location = CLLocation(latitude: Double(startLat)!, longitude: Double(startLong)!)
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Utils.defaultZoomLevel)
            self.step1gMap.camera = camera
            
            let marker = GMSMarker(position: location.coordinate)
            marker.map = self.step1gMap
            }else if endLat != "0.0" {
                let location = CLLocation(latitude: Double(endLat)!, longitude: Double(endLong)!)
                let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Utils.defaultZoomLevel)
                self.step1gMap.camera = camera
                
                let marker = GMSMarker(position: location.coordinate)
                marker.map = self.step1gMap
            }
        }
    }
    func onDirectionUpdate(directionResultDict: NSDictionary) {
        duration = directionResultDict.get("duration")
        distance = directionResultDict.get("distance")
        self.addUserLocMarker(location: self.currentLocation)
        self.destLocMarker(location: self.destLocation)
        self.isBtnBlock = false
        if(updateDirection != nil){
            updateDirection.releaseTask()
            updateDirection.onDirectionUpdateDelegate = nil
            updateDirection = nil
        }
        
    }
    func addUserLocMarker(location: CLLocation){
        
        

        let dropPin = UIImageView(image:UIImage.init(named: ("ic_new_marker_pick")))
        
        self.userMarker = GMSMarker()
        self.userMarker.iconView = dropPin
        self.userMarker.zIndex = -1
        self.userMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        self.userMarker.position = location.coordinate
        self.userMarker.map = self.step1gMap
        let pickUpMarkerView = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
        pickUpMarkerView.frame = CGRect(x: 0, y: 0, width: 137, height: 40)
        
        let timeLbl = UILabel(frame: CGRect(x: 2, y: 0, width: 36, height: 40))
        timeLbl.font = UIFont.systemFont(ofSize: 10)
        timeLbl.textAlignment = .center
        if distance == ""{
            timeLbl.text = "--"
        }else{
            //timeLbl.text = distance
            var distance_final = GeneralFunctions.parseDouble(origValue: 0.0, data: distance)
            
            if(self.userProfileJson != nil && self.userProfileJson.get("eUnit") != "KMs"){
                distance_final = distance_final * 0.000621371
            }else{
                distance_final = distance_final * 0.00099999969062399994
            }
            
            distance_final = distance_final.roundTo(places: 2)

            
            var distance_str = ""
            
            if(self.userProfileJson != nil && self.userProfileJson.get("eUnit") != "KMs"){
                distance_str = "\(String(format: "%.02f", distance_final)) \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MILE_DISTANCE_TXT"))"
            }else{
                distance_str = "\(String(format: "%.02f", distance_final)) \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_KM_DISTANCE_TXT"))"
            }
            timeLbl.text = distance_str
        }
       
        timeLbl.textColor = UIColor.white
        timeLbl.backgroundColor = UIColor.black
        timeLbl.numberOfLines = 2
        pickUpMarkerView.addSubview(timeLbl)
        
        let label = UILabel(frame: CGRect(x: 42, y: 0, width: 66, height: 40))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.text = self.startAdd
        label.textColor = UIColor(hex: 0x1B2A3B)
        label.numberOfLines = 2
        pickUpMarkerView.addSubview(label)
        
        let markerImage = pickUpMarkerView.getImage()
        
        let markerView = UIImageView(image: markerImage)
        markerView.layer.shadowOpacity = 0.2
        markerView.layer.shadowColor = UIColor.black.cgColor
        markerView.layer.shadowRadius = 15
        
        var groundAnchorPoint = CGPoint(-0.0, -0.0) //CGPoint(-0.05, 1.05) Top-Right CGPoint(1.05, -0.05)// Bottom-Left //CGPoint(1.05, 1.05) Top-Left //CGPoint(-0.05, -0.05) Bootom-Right
        if(self.pickUpCustomMarker != nil){
            groundAnchorPoint = self.pickUpCustomMarker.groundAnchor
            self.pickUpCustomMarker.map = nil
        }
        
        self.pickUpCustomMarker = GMSMarker()
        self.pickUpCustomMarker.groundAnchor = groundAnchorPoint
        self.pickUpCustomMarker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.pickUpCustomMarker.iconView = markerView
        self.pickUpCustomMarker.zIndex = 1
        self.pickUpCustomMarker.appearAnimation = GMSMarkerAnimation.pop
        self.pickUpCustomMarker.map = self.step1gMap
        }
    func destLocMarker(location: CLLocation){
        
        

        let dropPin = UIImageView(image:UIImage.init(named: ("ic_new_marker_dest")))
        
        self.driverMarket = GMSMarker()
        self.driverMarket.iconView = dropPin
        self.driverMarket.zIndex = -1
        self.driverMarket.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        self.driverMarket.position = location.coordinate
        self.driverMarket.map = self.step1gMap
        let dropOffMarkerview = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
        dropOffMarkerview.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        let label2 = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 40))
        label2.font = UIFont.systemFont(ofSize: 10)
        label2.textAlignment = .center
        label2.textColor = UIColor(hex: 0x1B2A3B)
        label2.text = self.endAdd
        dropOffMarkerview.addSubview(label2)
        
        // I have taken a pin image which is a custom image
        let dropmarkerImage = dropOffMarkerview.getImage()
        //creating a marker view
        let dropmarkerView = UIImageView(image: dropmarkerImage)
        dropmarkerView.layer.shadowOpacity = 0.5
        dropmarkerView.layer.shadowColor = UIColor.black.cgColor
        dropmarkerView.layer.shadowRadius = 10
        self.dropOffCustomMarker = GMSMarker()
        self.dropOffCustomMarker.groundAnchor = CGPoint(1.0, 1.0) //CGPoint(-0.05, 1.05) Top-Right CGPoint(1.05, -0.05)//
        self.dropOffCustomMarker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.dropOffCustomMarker.iconView = dropmarkerView
        self.dropOffCustomMarker.zIndex = 1
        self.dropOffCustomMarker.appearAnimation = GMSMarkerAnimation.pop
        self.dropOffCustomMarker.map = self.step1gMap
        }

    override func close(){
        if editData == nil {
        generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: generalFunc.getLanguageLabel(origValue: "", key: ""), content: generalFunc.getLanguageLabel(origValue: "", key: "LBL_PUBLISHED_RIDE_EXIT_TXT") , positiveBtn:generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: {(btnClickedId) in
            
            if(btnClickedId == 0){
                if(self.navigationController == nil || self.navigationController?.viewControllers.count == 1){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            if(btnClickedId == 1)
            {
            }
        })
        return
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
        
    func getRecomededPrice() {
        self.setLoader(ishidden: false)
        self.step2ScrollView.isHidden = true
        let parameters = ["type":"GetRideShareRecommendedPrice","iMemberId": GeneralFunctions.getMemberd(),"tStartLat" : self.startLat, "tStartLong" : self.startLong, "tEndLat" : self.endLat, "tEndLong" : self.endLong,"tStartLocation" : self.startAdd,"tEndLocation": self.endAdd ,"distance" : self.distance, "duration" : self.duration]
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            self.step2ScrollView.isHidden = false
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.step2RecomedendPriceLbl.text = dataDict.get(Utils.message_str)
                    self.step2priceTxtFiled.setText(text: dataDict.get("RecommdedPrice"))
                    self.finalStrRP = NSMutableAttributedString.init(string: "")
                    self.finalStrRP.append(self.getAttributedString(str: dataDict.get("RecommdedPriceText") ,color:SColors.blackColor))
                    self.finalStrRP.append(self.getAttributedString(str: " " +  dataDict.get("RecommdedPriceRange") ,color:SColors.Theme))
                    self.step2RecomedendPriceLbl.attributedText = self.finalStrRP
                    self.enteredAmount = dataDict.get("RecommdedPrice")
                    self.seatsList = dataDict.arrOf("PassengerNo") as! [String]
                    self.step2()
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str), key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                          
                         
                                    })
                    }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    func loadTripFinishView(title : String, des: String){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        opnTripFinishView.isNewDialouge = true
        opnTripFinishView.isFromMyRide = true
        opnTripFinishView.newbtnNegativeTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK")
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: "View my Ride", key: "LBL_RIDE_SHARE_VIEW_MY_RIDES_TXT")
        opnTripFinishView.show(title: title, desc:des ) {
            
        }
    }
    func openImgPicker(){
        self.openImgSelection.show(type: .ImageFileType) { (isImageUpload) in
            if(isImageUpload == true){
                
                self.openImgSelection.closeSlectionView()
               
                if(self.openImgSelection.selectedFileData != nil){
                    self.step3CarImageDottedView.isHidden = true
                    self.step3CarImage.contentMode = .scaleAspectFill
                    self.step3ImageViewBottom.constant = 0
                    self.step3CarImage.image = self.openImgSelection.pickedImage
                    self.step3ChoseImageLbl.isHidden = true
                }
            }
        }
    }
    func setCountry() {
        
          self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: cuntryUrl, width: Utils.getValueInPixel(value: 15), height: Utils.getValueInPixel(value: 10))), placeholderImage:nil)
          
          self.step3CountryCodeTxtFiled.setText(text: "+\(selectedPhoneCode)")

          self.isCountrySelected = true
        Utils.delayWithSeconds(2) {
       
        }
          self.step3CountryCodeTxtFiled.getTextField()!.sendActions(for: .editingChanged)
        
   }
    func getDic(key : String , value : String) -> NSMutableDictionary {
        let dic2 = NSMutableDictionary.init()
        dic2["value"] = value
        dic2["iData"] = key
        return dic2
    }
}
extension UITextView {

    func centerVerticalText() {
        self.textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}

