

import UIKit
import GoogleMaps
import SysBaseLib

class UFXCheckOutUV: ParentViewUV, MyBtnClickDelegate, UIScrollViewDelegate, ParentViewUVDelegate,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rideNowBtn: MyButton!
    @IBOutlet weak var rideLaterBtn: MyButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var bottomStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomStackViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var serviceHLbl: MyLabel!
    @IBOutlet weak var chargesHLbl: MyLabel!
    @IBOutlet weak var chargesView: UIView!
    @IBOutlet weak var chargesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bookingLocationView: UIView!
    @IBOutlet weak var bookingLocationHLbl: MyLabel!
    @IBOutlet weak var atUserLocationView: UIView!
    @IBOutlet weak var userLocationImgView: UIImageView!
    @IBOutlet weak var userLocationLbl: MyLabel!
    @IBOutlet weak var atProviderLocationView: UIView!
    @IBOutlet weak var providerLocationImgView: UIImageView!
    @IBOutlet weak var providerLocationLbl: MyLabel!
    @IBOutlet weak var bottomAddressViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noAddressView: UIView!
    @IBOutlet weak var noAddressHLbl: MyLabel!
    @IBOutlet weak var addAddressLbl: MyLabel!
    @IBOutlet weak var noAddressLocImgView: UIImageView!
    @IBOutlet weak var ratingLbl: MyLabel!

    @IBOutlet weak var bottomLocationSubView: UIView!
    @IBOutlet weak var ratingImgView: UIImageView!
    
    
    @IBOutlet weak var chargesParentView: UIView!
    var newScheduleView:ListBottomSheetViewTimePicker!
    // Cart itemView
    @IBOutlet weak var cartItemContainerView: UIView!
    @IBOutlet weak var cartItemContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cartItemContentMainView: UIView!

    
    // Apply PromoCode View
    @IBOutlet weak var applyPromoCodeView: UIView!
    @IBOutlet weak var applyPromoLbl: MyLabel!
    @IBOutlet weak var promoAppliedValueLbl: MyLabel!
    @IBOutlet weak var promoAppliedTxt: MyLabel!
    @IBOutlet weak var applyPromoIconImgView: UIImageView!
    @IBOutlet weak var promoArrowImgView: UIImageView!
    
    
    // Bottom Address View
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressHView: UIView!
    @IBOutlet weak var addressHLbl: MyLabel!
    @IBOutlet weak var addressTypeChangeLbl: MyLabel!
    @IBOutlet weak var locationImgView: UIImageView!
    @IBOutlet weak var addressTypeHLbl: MyLabel!
    @IBOutlet weak var addressChangeLbl: MyLabel!
    @IBOutlet weak var addressVLbl: MyLabel!
    
    @IBOutlet weak var newEditAdreessView: UIView!
    // RequestCab OutLets
    @IBOutlet weak var reqlocImgView: UIImageView!
    @IBOutlet weak var reqNoteLbl: MyLabel!
    @IBOutlet weak var retryReqBtn: MyButton!
    @IBOutlet weak var requestCabTitleLbl: MyLabel!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var radarMainView: UIView!
    @IBOutlet weak var radarSubView: UIView!
    @IBOutlet weak var cancleReqBtn: MyButton!
    @IBOutlet weak var radarLineView: UIView!
    @IBOutlet weak var radarMainViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var reqCabTitleLblTopSpace: NSLayoutConstraint!
    var radarViewObj : Radar!
    
    
    @IBOutlet weak var profileDetailView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileNameLbl: MyLabel!
    @IBOutlet weak var profileRatingView: RatingView!
    
    
    var isDriverAssigned = false
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var mainScreenUV:MainScreenUV!
    
    var promoTapGesture = UITapGestureRecognizer()
    var removePromoGesture:UITapGestureRecognizer!
    var paymentBCloseTapGesture = UITapGestureRecognizer()
    var paymentChangeTapGesture = UITapGestureRecognizer()
    var paymentBCashViewTapGesture = UITapGestureRecognizer()
    var paymentBCardViewTapGesture = UITapGestureRecognizer()
    var addressTypeChangeTapGesture = UITapGestureRecognizer()
    var addressChangeTapGesture = UITapGestureRecognizer()
   
    var subTotal = ""
    
    var currentLocation:CLLocation?
    var providerInfo:NSDictionary!
    var cartArray = [NSDictionary]()
    
    var dataDic = NSDictionary()
    var userProfileJson:NSDictionary!
    
    var promoCodeValue = ""
    var isPromoCodeAppliedManually = false
    var paymentMethod = "Cash"
    var locationType = "User"
   
    var confirmCardBGDialogView:UIView!
    
    // Request Variables
    var eWalletDebitAllow = false
    var requestCabView:UIView!
    var rippleView: SMRippleView?
    var reqSentErrorDialog:MTDialog!
    var isRequestExecuting = false
    var currDriverReqPosition = 0
    var driverRequestQueueTimer:Timer!
    var RIDER_REQUEST_ACCEPT_TIME = 30
    var isOutStandingAmtSkipped = false
    var checkCardMode = ""
    var isAutoContinue_payBox = false
    
    // Schedule Job Variables
    var slectedDate = ""
    var slectedTime = ""
    
    var ufxSelectedLatitude = ""
    var ufxSelectedLongitude = ""
    var ufxSelectedAddress = ""
    var ufxSelectedVehicleTypeId = ""
    var iVehicleTypeId = ""
    var addressId = ""
    var addressLat = ""
    var addressLong = ""
    var isCardValidated = false
    
    var loaderView:UIView!
    
    var isUFXLater = false
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
    var isCancelTrip = false
    var eForVideoConsultation = ""
    var providerInfoTabUV:UFXProviderInfoTabUV!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "UFXCheckOutScreenDesign", uv: self, contentView: scrollView)
            self.scrollView.delegate = self
            self.scrollView.addSubview(cntView)
            
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOKING_DETAILS_TXT")
            
            self.rideLaterBtn.clickDelegate = self
            self.rideNowBtn.clickDelegate = self
            self.rideNowBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_NOW"))
            self.rideLaterBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_LATER"))
            self.rideLaterBtn.setCustomColor(textColor: SColors.blackColor, bgColor: SColors.ThemeTxt, pulseColor: SColors.blackColor, borderColor: SColors.blackColor, borderWidth: 1, cornerRadius: 10)
            if (Configurations.isIponeXDevice() == true) {
                if #available(iOS 11.0, *) {
                    //self.bottomStackViewHeight.constant = self.bottomStackViewHeight.constant + 10
                }
            }
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
                
                self.cartArray = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            }
          
            self.contentView.isHidden = true
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            RIDER_REQUEST_ACCEPT_TIME = GeneralFunctions.getValue(key: Utils.RIDER_REQUEST_ACCEPT_TIME_KEY) == nil ? 30 : GeneralFunctions.parseInt(origValue: 30, data: (GeneralFunctions.getValue(key: Utils.RIDER_REQUEST_ACCEPT_TIME_KEY) as! String))
            
            self.loadfareDetails(true)
            self.profileNameLbl.text = self.providerInfo.get("Name") + " " + self.providerInfo.get("LastName")
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(self.providerInfo.get("driver_id"))/\(self.providerInfo.get("driver_img"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            self.shadowOnview(view: self.applyPromoCodeView)
//            self.profileImgView.layer.addShadow(opacity: 0.9, radius: 3.0, UIColor.lightGray)
//            self.profileImgView.layer.roundCorners(radius: 4)
            self.profileRatingView.rating = GeneralFunctions.parseFloat(origValue: 0, data: self.providerInfo.get("average_rating"))
            self.ratingLbl.text = self.providerInfo.get("average_rating")
            GeneralFunctions.setImgTintColor(imgView: self.ratingImgView, color: UIColor(hex: 0xEFCE4A))

            //Utils.createRoundedView(view: self.profileImgView, borderColor: UIColor.clear, borderWidth: 0)
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            isDriverAssigned = false
            
        }else if(type == 2){
            
        }
    }
   

    override func close() {
        
        self.providerInfoTabUV.skipCheckout = true
        if eForVideoConsultation.uppercased() != "YES" {
        self.providerInfoTabUV.setupCartView()
        }
        GeneralFunctions.removeValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS")
        super.close()
        
        
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y <= 0){
            self.profileDetailView.shadowOffset = CGSize(width: 0, height: 0)
            self.profileDetailView.shadowColor = UIColor.clear
            self.profileDetailView.shadowRadius = 0
            self.profileDetailView.shadowOpacity = 0.0
            
        }else{
            self.profileDetailView.shadowOffset = CGSize(width: 0.5, height: 0.5)
            self.profileDetailView.shadowColor = UIColor.lightGray
            self.profileDetailView.shadowRadius = 2
            self.profileDetailView.shadowOpacity = 1.0
            
        }
    }
    
    func loadfareDetails(_ fromViewDidLoad:Bool = false){
        
        if(self.loaderView != nil){
            self.loaderView.removeFromSuperview()
        }
               
       loaderView =  self.generalFunc.addMDloader(contentView: self.view)
       
       //loaderView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
       loaderView.backgroundColor = UIColor.clear
        
        var sendCartArray = [NSDictionary]()
        
        for i in 0..<self.cartArray.count{
            
            let dataDicArray = cartArray[i]
            
            let cartDataDic = ["iVehicleTypeId":dataDicArray.dictOf("vehicleData").get("iVehicleTypeId"), "fVehicleTypeQty":dataDicArray.get("itemCount")] as NSDictionary
            sendCartArray.append(cartDataDic)
        }
        

        self.iVehicleTypeId = sendCartArray[0].get("iVehicleTypeId")
       
        let parameters = ["type":"getVehicleTypeFareDetails", "iMemberId": GeneralFunctions.getMemberd(), "UserType":Utils.appUserType, "vCouponCode":self.promoCodeValue, "SelectedCabType": Utils.cabGeneralType_UberX, "OrderDetails": sendCartArray.convertToJson(), "iDriverId":self.providerInfo.get("driver_id"), "vSelectedLatitude":ufxSelectedLatitude, "vSelectedLongitude":ufxSelectedLongitude,"vSelectedAddress":ufxSelectedAddress, "iVehicleTypeId": self.cartArray.count > 1 ? "" : self.iVehicleTypeId, "iUserAddressId": addressId, "eForVideoConsultation": self.eForVideoConsultation]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(self.loaderView != nil){
                
                self.loaderView.isHidden = true
                self.loaderView.removeFromSuperview()
            }
            
            if(response != ""){
                let dataDic = response.toDict()
                
                if(dataDic.get("Action") == "1"){
                    
                    if self.promoCodeValue != ""
                    {
                        self.applyPromoLbl.isHidden = true
                        
                        self.promoAppliedTxt.isHidden = false
                        self.promoAppliedValueLbl.isHidden = false
                        
                        self.promoAppliedTxt.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLIED_COUPON_CODE")
                        self.promoAppliedValueLbl.text = self.promoCodeValue
                        self.promoAppliedValueLbl.textColor = SColors.Theme
                        
                        self.promoArrowImgView.image = UIImage.init(named: "ic_remove")
                        GeneralFunctions.setImgTintColor(imgView: self.promoArrowImgView, color: SColors.Theme)
                        
                        // self.applyPromoCodeView.removeGestureRecognizer(self.promoTapGesture)
                        self.removePromoGesture = UITapGestureRecognizer()
                        self.removePromoGesture.addTarget(self, action: #selector(self.removePromoTapped))
                        self.promoArrowImgView.isUserInteractionEnabled = true
                        self.promoArrowImgView.addGestureRecognizer(self.removePromoGesture)
                        
                    }else{
                        if(self.removePromoGesture != nil){
                            self.promoArrowImgView.removeGestureRecognizer(self.removePromoGesture)
                        }
                        
                        self.promoCodeValue = ""
                        self.applyPromoLbl.isHidden = false
                        self.promoAppliedTxt.isHidden = true
                        self.promoAppliedValueLbl.isHidden = true
                        
                        self.promoArrowImgView.image = UIImage.init(named: "ic_arrow_right")
                        if Configurations.isRTLMode() == true{
                            var arrowImg = UIImage(named: "ic_arrow_right")
                            arrowImg = arrowImg?.rotate(180)
                            self.promoArrowImgView.image = arrowImg?.tintTo(color: SColors.Theme)
                        }
                        GeneralFunctions.setImgTintColor(imgView: self.promoArrowImgView, color: SColors.Theme)
                    }
                    
                    self.contentView.isHidden = false
                    self.dataDic = dataDic
                    self.addressId = self.dataDic.get("iUserAddressId")
                    self.addressLat = self.dataDic.get("vServiceAddressLatitude")
                    self.addressLong = self.dataDic.get("vServiceAddressLongitude")
                    if(self.dataDic.get("vAvailability").uppercased() == "NO"){
                        self.rideNowBtn.isHidden = true
                    }else{
                        self.rideNowBtn.isHidden = false
                    }
                    
                    if(self.dataDic.get("vScheduleAvailability").uppercased() == "NO"){
                        self.rideLaterBtn.isHidden = true
                    }else{
                        self.rideLaterBtn.isHidden = false
                    }
                        
                    self.setData(fromViewDidLoad)
                    
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.loadfareDetails(fromViewDidLoad)
                    })
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    self.loadfareDetails(fromViewDidLoad)
                })
                
            }
            
        })
    }
    
    
    func setData(_ fromViewDidLoad:Bool = false){
        
        self.serviceHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICES")
        self.shadowOnview(view: self.cartItemContentMainView)
        // Cart Item View Setup
        for subView in self.cartItemContainerView.subviews{
            
            subView.removeFromSuperview()
        }
        
        self.cartItemContainerViewHeight.constant = 0
        
        let dataArray = self.dataDic.arrOf("items")
        print(dataArray)
        if(dataArray.count > 0){
            
            var yPosition = 0
            for i in 0..<dataArray.count
            {
                yPosition = (i * 110)
                let dataDic = dataArray[i] as! NSDictionary
                let itemView = UFXCheckOutItemView(frame: CGRect(x:0, y: yPosition , width: Int(Application.screenSize.width) - 60, height: 110))
                itemView.tag = i
                itemView.autoresizingMask = [.flexibleWidth]
                
                if Configurations.isRTLMode(){
                    itemView.itemName.textAlignment = .right
                }else{
                    itemView.itemName.textAlignment = .left
                    
                }
                itemView.itemName.text = dataDic.get("Title")
                Utils.createRoundedView(view: itemView.deleteView, borderColor: UIColor.clear, borderWidth: 0)
                itemView.deleteView.backgroundColor = SColors.Theme
                
                 let eFareType = dataDic.get("eFareType")
                itemView.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: dataDic.get("Qty"))
                if(eFareType == "Hourly"){
                                    
                                 itemView.itemPriceLbl.text = Configurations.convertNumToAppLocal(numStr: dataDic.get("Amount")) + "/" + (self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR"))
                               }else{
                               itemView.itemPriceLbl.text = Configurations.convertNumToAppLocal(numStr: dataDic.get("Amount"))
                               }
               // itemView.itemPriceLbl.text = Configurations.convertNumToAppLocal(numStr: dataDic.get("Amount"))
                
                if(dataDic.get("Qty") == "") || dataDic.get("Qty") == " "{
                    itemView.itemCountLbl.isHidden = true
                    itemView.itemNameY.constant = 25
                }
                if eForVideoConsultation == "Yes" {
                    itemView.itemNameY.constant = 30
                }
                
            
                
                
                itemView.deleteView.tag = i
                itemView.deleteView.handleClick { (instance) in
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_MSG"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT").uppercased(), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased(), completionHandler: { (btnClickedIndex) in

                        if btnClickedIndex == 0
                        {
                            self.removeItemFromCart(dataArray[instance.tag] as! NSDictionary)
                        }
                    })

                }
                
                itemView.containerView.clipsToBounds = true
                itemView.containerView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
                itemView.containerView.layer.roundCorners(radius: 10)
                
                self.cartItemContainerView.addSubview(itemView)
               
            }
        
            self.cartItemContainerViewHeight.constant = CGFloat(yPosition + 110)
          
            // Promo CodeView Setup
//            self.applyPromoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY_COUPON").uppercased()
            self.applyPromoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY_PROMO_TXT")
            self.applyPromoIconImgView.image = UIImage.init(named: "ic_new_promo_code")
            GeneralFunctions.setImgTintColor(imgView: self.applyPromoIconImgView, color: SColors.Theme)
            if(self.promoCodeValue == ""){
                if Configurations.isRTLMode() == true{
                    var arrowImg = UIImage(named: "ic_arrow_right")
                    arrowImg = arrowImg?.rotate(180)
                    promoArrowImgView.image = arrowImg?.tintTo(color: UIColor.lightGray)
                }
            }
            
            GeneralFunctions.setImgTintColor(imgView: self.promoArrowImgView, color: UIColor.lightGray)
            promoTapGesture.addTarget(self, action: #selector(self.applyPromoTapped))
            self.applyPromoCodeView.isUserInteractionEnabled = true
            self.applyPromoCodeView.addGestureRecognizer(promoTapGesture)
//            self.applyPromoCodeView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
            self.applyPromoCodeView.layer.roundCorners(radius: 10)
            
           
            // Address View Setup
            if Configurations.isRTLMode() == true{
                self.addressHLbl.textAlignment = .right
                self.addressChangeLbl.textAlignment = .left
                
                self.addressTypeHLbl.textAlignment = .right
                self.addressTypeChangeLbl.textAlignment = .left
            }
            
            self.addressView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            //self.addressView.layer.roundCorners(radius: 14)
            //self.addressView.roundCorners([.topLeft, .topRight], radius: 14)
            
            self.addressHView.backgroundColor = SColors.Theme
            self.addressHLbl.textColor = SColors.ThemeTxt
            self.addressTypeChangeLbl.textColor = SColors.ThemeTxt
            self.addressChangeLbl.textColor = SColors.Theme
            self.addressHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_BOOKING_LOCATION").uppercased()
            
            var extraHeight:CGFloat = 520
            if(self.dataDic.get("eEnableServiceAtProviderLocation") != "Yes"){
                self.bookingLocationView.isHidden = true
                self.bookingLocationHLbl.isHidden = true
                extraHeight = extraHeight - 120
            }
            
            self.locationImgView.image = UIImage.init(named: "ic_new_mapPin")
            self.newEditAdreessView.backgroundColor = SColors.Theme
            Utils.createRoundedView(view: self.newEditAdreessView, borderColor: UIColor.clear, borderWidth: 0)
           // GeneralFunctions.setImgTintColor(imgView: self.locationImgView, color: SColors.Theme)
           
          
            self.newEditAdreessView.handleClick { (instance) in
               
                if(GeneralFunctions.parseInt(origValue: 0, data: self.dataDic.get("totalAddressCount")) == 0){
                    let addAddressUv = GeneralFunctions.instantiateViewController(pageName: "AddAddressUV") as! AddAddressUV
                    addAddressUv.ufXProviderFlow = true
                    addAddressUv.ufxSelectedLatitude = self.ufxSelectedLatitude
                    addAddressUv.ufxSelectedLongitude = self.ufxSelectedLongitude
                    addAddressUv.ufxSelectedAddress = self.ufxSelectedAddress
                    self.push(uv: addAddressUv)
                   
                }else{
                    let chooseAddressUv = GeneralFunctions.instantiateViewController(pageName: "ChooseAddressUV") as! ChooseAddressUV
                    chooseAddressUv.ufXProviderFlow = true
                    chooseAddressUv.iDriverID = self.providerInfo.get("driver_id")
                    chooseAddressUv.ufxSelectedLatitude = self.ufxSelectedLatitude
                    chooseAddressUv.ufxSelectedLongitude = self.ufxSelectedLongitude
                    chooseAddressUv.ufxSelectedAddress = self.ufxSelectedAddress
                    chooseAddressUv.selectedAddressID = self.addressId
                    self.push(uv: chooseAddressUv)
                }
             
            }
           
            self.addFareDetails()
            self.shadowOnview(view: self.bookingLocationView)
            self.shadowOnview(view: self.bottomLocationSubView)
            self.setBookingLocationView()
            
            if(self.eForVideoConsultation.uppercased() != "YES"){
                self.addressTypeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICE_LOCATION").uppercased()
                self.addressVLbl.isHidden = false
                self.addressChangeLbl.isHidden = false
            }
            
            self.cntView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height: self.cartItemContainerViewHeight.constant + self.chargesViewHeight.constant + extraHeight)
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.cartItemContainerViewHeight.constant + self.chargesViewHeight.constant + extraHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    func removeItemFromCart(_ dataDict:NSDictionary){
        var selectedItemIdIndex = -1
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
                
                for i in 0..<array.count{
                    let dataDicArray_tmp = array[i] as NSDictionary
                    
                    if(dataDicArray_tmp.dictOf("vehicleData").get("iVehicleTypeId") == dataDict.get("iVehicleTypeId")){
                        selectedItemIdIndex = i
                    }
                }
            }
        }
        
        if(selectedItemIdIndex != -1){
            var array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            array.remove(at: selectedItemIdIndex)
            GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
            self.cartArray = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
        
            if(self.cartArray.count == 0){
                self.close()
            }else{
                self.loadfareDetails(true)
            }
        }
        
        
    }
    
    func setBookingLocationView(){
        
        if(GeneralFunctions.parseInt(origValue: 0, data: self.dataDic.get("totalAddressCount")) == 0){
            
            self.bottomAddressViewHeight.constant = 110
            self.addressView.isHidden = false
            self.noAddressHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_SERVICE_LOCATION").uppercased()
            self.noAddressView.isHidden = false
            self.addressVLbl.text = ""
            self.addAddressLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ADDRESS_TXT").uppercased()
            self.addAddressLbl.textColor = SColors.Theme
            self.addAddressLbl.layer.borderColor = SColors.Theme.cgColor
            self.addAddressLbl.layer.borderWidth = 1.0
            self.noAddressLocImgView.image = UIImage.init(named: "ic_new_mapPin")
            GeneralFunctions.setImgTintColor(imgView: self.noAddressLocImgView, color: SColors.Theme)
            self.addAddressLbl.handleClick { (instance) in
                let addAddressUv = GeneralFunctions.instantiateViewController(pageName: "AddAddressUV") as! AddAddressUV
                addAddressUv.ufXProviderFlow = true
                addAddressUv.ufxSelectedLatitude = self.ufxSelectedLatitude
                addAddressUv.ufxSelectedLongitude = self.ufxSelectedLongitude
                addAddressUv.ufxSelectedAddress = self.ufxSelectedAddress
                self.push(uv: addAddressUv)
            }
            
        }else{
            self.bottomAddressViewHeight.constant = 125
            self.addressView.isHidden = false
            self.noAddressView.isHidden = true
            self.addressChangeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE").uppercased()//addImage(originalText: "  ", image: UIImage(named: "ic_edit")!.resize(toWidth: 22)!.resize(toHeight: 22)!, color: SColors.Theme, position: IconPosition.right)
            self.addressVLbl.text = self.dataDic.get("vServiceAddress")
            
        }
        
        self.bookingLocationHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_BOOKING_LOCATION")
        //self.bookingLocationView.clipsToBounds = true
        //self.bookingLocationView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        //self.bookingLocationView.layer.roundCorners(radius: 10)
        
        self.userLocationLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AT_USER_LOCATION")
        self.providerLocationLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AT_PROVIDER_LOCATION")
        
        self.userLocationImgView.image = UIImage(named:"ic_select_true")
        GeneralFunctions.setImgTintColor(imgView: self.userLocationImgView, color: SColors.Theme)
        
        self.providerLocationImgView.image = UIImage(named:"ic_select_false")
        GeneralFunctions.setImgTintColor(imgView: self.userLocationImgView, color: SColors.Theme)
        
        self.atUserLocationView.handleClick { (instance) in
            self.addressView.isHidden = false
            self.view.layoutIfNeeded()
            if(self.noAddressView.isHidden == false){
                self.bottomAddressViewHeight.constant = 110
            }else{
                self.bottomAddressViewHeight.constant = 125
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.locationType = "User"
            self.userLocationImgView.image = UIImage(named:"ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.userLocationImgView, color: SColors.Theme)
            
            self.providerLocationImgView.image = UIImage(named:"ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.providerLocationImgView, color: SColors.Theme)
            
            let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
          
        }
        
        self.atProviderLocationView.handleClick { (instance) in
            
            self.view.layoutIfNeeded()
            self.addressView.isHidden = true
            self.bottomAddressViewHeight.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            self.locationType = "Provider"
            self.userLocationImgView.image = UIImage(named:"ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.userLocationImgView, color: SColors.Theme)
            
            self.providerLocationImgView.image = UIImage(named:"ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.providerLocationImgView, color: SColors.Theme)
    
        }
    
        if(self.eForVideoConsultation.uppercased() == "YES"){
            self.bottomAddressViewHeight.constant = 0
            self.noAddressView.isHidden = true
            self.addressVLbl.isHidden = true
            self.addressView.isHidden = true
        }
        
    }
    
    func addFareDetails(){
        
        self.chargesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHARGES_TXT")
        self.shadowOnview(view: chargesView)

        chargesView.layer.roundCorners(radius: 10)
        self.shadowOnview(view: self.chargesParentView)
        
        for fareSubView in self.chargesView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        
        let fareDetailsNewArr = self.dataDic.arrOf("vehiclePriceTypeArrCubex")
        
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        
        for i in 0..<fareDetailsNewArr.count {
            _ = fareDetailsNewArr[i] as! NSDictionary
            let item = fareDetailsNewArr[i] as! NSDictionary
            let totalSubViewCounts = self.chargesView.subviews.count
            let viewWidth = Application.screenSize.width - 60
            if item.get("eDisplaySeperator") == "Yes" {
                let viewWidth = Application.screenSize.width - 60

                let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))

                viewCus.backgroundColor = UIColor(hex: 0xdedede)
                self.chargesView.addSubview(viewCus)
                totalSeperatorViews = totalSeperatorViews + 1
            }
            else{
                let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 50))
                let titleStr = item.get("Title")
                let valueStr = Configurations.convertNumToAppLocal(numStr: item.get("Amount"))
                
                var font:UIFont!
                if(i == fareDetailsNewArr.count - 1){
                    font = UIFont(name: Fonts().semibold, size: 18)!
                }else{
                    font = UIFont(name: Fonts().regular, size: 14)!
                }
                var widthOfTitle = titleStr.width(withConstrainedHeight: 50, font: font) + 15
                var widthOfvalue = valueStr.width(withConstrainedHeight: 50, font: font) + 20
                
                if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                    widthOfvalue = ((viewWidth * 80) / 100)
                    widthOfTitle = ((viewWidth * 20) / 100)
                }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                    widthOfvalue = viewWidth - widthOfTitle
                }
                
                let widthOfParentView = viewWidth - widthOfvalue
                
                var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 50))
                var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 50))
                
                if(Configurations.isRTLMode()){
                    lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 50))
                    lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 50))
                    
                    lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                    lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                }else{
                    lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                    lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                }
                
                lblTitle.textColor = UIColor(hex: 0x656565)
                lblValue.textColor = UIColor(hex: 0x272727)
                
                lblTitle.font = font
                lblValue.font = font
                
                lblTitle.fontFamilyWeight = "Regular"
                lblValue.fontFamilyWeight = "Regular"
                lblTitle.setFontFamily()
                lblValue.setFontFamily()
                
                lblTitle.numberOfLines = 2
                lblValue.numberOfLines = 2
                
                lblTitle.minimumScaleFactor = 0.5
                lblValue.minimumScaleFactor = 0.5
                
                lblTitle.text = titleStr
                lblValue.text = valueStr
                
                viewCus.addSubview(lblTitle)
                viewCus.addSubview(lblValue)
                
                //                    self.chargesContainerView.addArrangedSubview(viewCus)
                
                self.chargesView.addSubview(viewCus)
                
                if(Configurations.isRTLMode()){
                    lblValue.textAlignment = .left
                }else{
                    lblValue.textAlignment = .right
                }
                
                if(i == fareDetailsNewArr.count - 1){
                    lblTitle.font = UIFont(name: Fonts().semibold, size: 16)!
                    lblValue.font = UIFont(name: Fonts().semibold, size: 16)!
                    lblTitle.fontFamilyWeight = "Medium"
                    lblValue.fontFamilyWeight = "Medium"
                    lblTitle.setFontFamily()
                    lblValue.setFontFamily()
                    lblTitle.textColor = UIColor.black
                    lblValue.textColor = SColors.Theme
                    
                }
            }
        }
        self.chargesViewHeight.constant = CGFloat((self.chargesView.subviews.count - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight))
        
    }
   
    func showPaymentBox(_ isForRideLater:Bool = false){
        
        let openConfirmCardView = OpenConfirmCardView(uv: self, containerView: self.navigationController != nil ? self.navigationController!.view : self.view)
        openConfirmCardView.isFromUFXCheckOut = true
        openConfirmCardView.show(checkCardMode: self.checkCardMode) { (isCheckCardSuccess, dataDict) in
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            if(self.checkCardMode != "OUT_STAND_AMT"){
                //self.selectCard()
            }
            
            if(self.isAutoContinue_payBox == true){
                if(self.checkCardMode != "OUT_STAND_AMT"){
                    self.isOutStandingAmtSkipped = false
                    if(isForRideLater == true){
                        self.rideLaterBtn.btnTapped()
                    }else{
                        self.rideNowBtn.btnTapped()
                    }
                    
                }else{
                    self.isOutStandingAmtSkipped = false
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        if(isForRideLater == true){
                            self.rideLaterBtn.btnTapped()
                        }else{
                            self.rideNowBtn.btnTapped()
                        }
                    })
                }
                
            }else{
                if(self.checkCardMode == "OUT_STAND_AMT"){
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")))
                }
            }
        }
    }
    
    
    @objc func applyPromoTapped()
    {
        let selectPromoCodeUV = GeneralFunctions.instantiateViewController(pageName: "SelectPromoCodeUV") as! SelectPromoCodeUV
        selectPromoCodeUV.appliedPromoCode = self.promoCodeValue
        selectPromoCodeUV.isFromUFXCheckOut = true
        selectPromoCodeUV.eForVideoConsultation = self.eForVideoConsultation
        selectPromoCodeUV.isPromoCodeAppliedManually = isPromoCodeAppliedManually
        selectPromoCodeUV.selectedLat = self.addressLat
        selectPromoCodeUV.selectedLong = self.addressLong
        self.push(uv: selectPromoCodeUV)
        
    }
    
    @objc func removePromoTapped()
    {
        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_COUPON_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
            
            if(btnClickedIndex == 0){
                
                self.promoCodeValue = ""
                self.loadfareDetails()
                
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUPON_REMOVE_SUCCESS"))
                
            }
        })
    }
   
    func myBtnTapped(sender: MyButton) {
       
        if(sender == self.rideNowBtn){
           
            if (UserDefaults.standard.string(forKey: "guestTap")!.lowercased() == "yes"){//suleman
                
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Register first to use this feature", key: "LBL_GUEST_USER_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGNUP"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: ""), completionHandler: { (btnClickedIndex) in

                  if btnClickedIndex == 0
                  {
                      let signUpUv = GeneralFunctions.instantiateViewController(pageName: "SignUpUV") as! SignUpUV
                    //  signUpUv.isFromAppLogin = false
                      self.push(uv: signUpUv)
                  }

               })
                return
                
            }
            self.isUFXLater = false
            if self.eForVideoConsultation.uppercased() != "YES" {
            if(self.locationType == "User" && self.addressVLbl.text == ""){

                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                return
            }
            }
//            if(self.locationType == "User" && self.addressVLbl.text == ""){
//
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
//                return
//            }
//            self.checkSurgePrice(false, isOpenOutStandingView: true)
            if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
                self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                    
                    GeneralFunctions.logOutUser()
                    
                    GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                    
                    GeneralFunctions.restartApp(window: Application.window!)
                }
                return
            }
            
            /* Help note changes for UFX*/
            if (self.userProfileJson.get("ENABLE_SAFETY_FEATURE_UFX").uppercased() == "YES" && self.userProfileJson.get("ENABLE_SAFETY_CHECKLIST").uppercased() == "YES"){
                let helpNoteForRideUV = GeneralFunctions.instantiateViewController(pageName: "HelpNoteForRideUV") as! HelpNoteForRideUV
                helpNoteForRideUV.isRideLater = false
                helpNoteForRideUV.passengerLimitText = ""
                helpNoteForRideUV.isFromUFX = true
                self.push(uv: helpNoteForRideUV)
                return
            }/* Help note changes for UFX*/
            
            //print(self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=UberX&eForVideoConsultation=\(self.eForVideoConsultation)")
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=UberX&eForVideoConsultation=\(self.eForVideoConsultation)" + "&iDriverId=\(self.providerInfo.get("driver_id"))", uv: self)

//            let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//            selectPaymentProfileUV.isFromUFXCheckout = true
//            selectPaymentProfileUV.isFromRideLater = false
//            self.push(uv: selectPaymentProfileUV)
            
        }else if(sender == self.rideLaterBtn){
            
        
            self.isUFXLater = true
            if self.eForVideoConsultation.uppercased() != "YES" {
            if(self.locationType == "User" && self.addressVLbl.text == ""){

                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                return
            }
            }
            if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
                self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                    
                    GeneralFunctions.logOutUser()
                    
                    GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                    
                    GeneralFunctions.restartApp(window: Application.window!)
                }
                return
            }
            
            /* Help note changes for UFX*/
            if (self.userProfileJson.get("ENABLE_SAFETY_FEATURE_UFX").uppercased() == "YES" && self.userProfileJson.get("ENABLE_SAFETY_CHECKLIST").uppercased() == "YES"){
                let helpNoteForRideUV = GeneralFunctions.instantiateViewController(pageName: "HelpNoteForRideUV") as! HelpNoteForRideUV
                helpNoteForRideUV.isRideLater = true
                helpNoteForRideUV.isFromUFX = true
                helpNoteForRideUV.passengerLimitText = ""
                self.push(uv: helpNoteForRideUV)
                return
            }/* Help note changes for UFX*/
            

            
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=UberX&eForVideoConsultation=\(self.eForVideoConsultation)" + "&iDriverId=\(self.providerInfo.get("driver_id"))", uv: self)
            
//            let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//            selectPaymentProfileUV.isFromUFXCheckout = true
//            selectPaymentProfileUV.isFromRideLater = true
//            self.push(uv: selectPaymentProfileUV)
//            if(self.locationType == "User" && self.addressVLbl.text == ""){
//
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
//                return
//            }
//            let chooseServiceDateUV = GeneralFunctions.instantiateViewController(pageName: "ChooseServiceDateUV") as! ChooseServiceDateUV
//            chooseServiceDateUV.selectedProviderId = self.providerInfo.get("driver_id")
//            chooseServiceDateUV.isFromUFXProviderFlow = true
//            self.push(uv: chooseServiceDateUV)
           // self.checkSurgePrice(true, isOpenOutStandingView: true)
         
        }else if(retryReqBtn != nil && sender == retryReqBtn){
            self.startDriverRequestQueue()
        }else if(self.requestCabView != nil && sender == self.cancleReqBtn){
            if(self.reqNoteLbl != nil){
                self.reqNoteLbl.isHidden = true
            }
            
            cancelCabRequest()
        }else if self.newScheduleView.buttonNegative == sender {
            selectedIndexCollection = 0
            selectedIndexPriviousCollection = 0
            self.newScheduleView.removeFromSuperview()
        }else if self.newScheduleView.buttonPositive == sender {
            self.newScheduleView.removeFromSuperview()
            
             let min_hour = Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1
           let max_hour = Int(self.userProfileJson.get("MAXIMUM_HOURS_LATER_BOOKING")) ?? 60
            let maxDate = Calendar.current.date(byAdding: .minute, value: max_hour, to: Date())
           let minDate = Calendar.current.date(byAdding: .minute, value: min_hour, to: Date())


            let date = Utils.convertDateGregorianToAppLocale(date: self.selectedDateTimeNewPass + " " + self.newScheduleView.timeLbl.text! , dateFormate: "yyyy-MM-dd hh:mm aa")
            let datFinal = date.toLocalTime()
            let datMin = minDate?.toLocalTime()
            let datMax = maxDate?.toLocalTime()
            let stringtTemp = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_PICKUP_MAX_NOTE_MSG")
           let  strMin = stringtTemp.replace("#####", withString: self.userProfileJson.get("MAXIMUM_HOURS_LATER_BOOKING") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINUTES_TXT"))
            let strMax = strMin.replace("####", withString: self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING") + " " +  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINUTES_TXT"))
            
            if datFinal < datMin! {

                //Utils.showSnakeBar(msg: strMax , uv: self)
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_PICKUP_MAX_NOTE_MSG"))
                return
            }
            if datFinal > datMax! {
                //Utils.showSnakeBar(msg: strMax , uv: self)
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_PICKUP_MAX_NOTE_MSG"))
                  return
            }
            
           
            let stringFinalDate = Utils.convertDateFormateInAppLocal(date: datFinal, toDateFormate: "yyyy-MM-dd HH:mm")
            //self.ridelaterNew = true
            self.slectedDate = stringFinalDate
            self.checkSurgePrice(true, isOpenOutStandingView: true)
            selectedIndexCollection = 0
            selectedIndexCollection = 0
            selectedIndexPriviousCollection = 0
        }
        
        
    }

    @objc func openAccountVerify(){
        
        self.snackbarController?.animate(snackbar: .hidden, delay: 0)
        
        let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
        accountVerificationUv.isForMobile = true
        accountVerificationUv.requestType = "DO_PHONE_VERIFY"
        
        accountVerificationUv.isFromUFXCheckOut = true
        self.push(uv: accountVerificationUv)
    }
    
    func addDriverNotificationObserver(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.driverCallBack(sender:)), name: NSNotification.Name(rawValue: Utils.driverCallBackNotificationKey), object: nil)
    }
    
    @objc func driverCallBack(sender: NSNotification){
        
        
        let userInfo = sender.userInfo
        let msgData = (userInfo!["body"] as! String).toDict()
        
        let msgStr = msgData.get("Message")
    
        Utils.hideKeyboard(uv: self)
        
        if(self.reqSentErrorDialog != nil){
            self.reqSentErrorDialog.disappear()
            self.reqSentErrorDialog = nil
        }
        
        if(msgStr == "CabRequestAccepted"){
            
            GeneralFunctions.removeObserver(obj: self)
            
            if(isDriverAssigned == true){
                return
            }
            
            isDriverAssigned = true
            // For UFX Provider
            GeneralFunctions.removeValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS")
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
                GeneralFunctions.saveValue(key: "UFXCartData", value: [[NSDictionary]]() as AnyObject)
            }
            
            self.closeCabReqView()
            self.stopDriverRequestQueue()
            self.loadBookingFinishView()
            
        }
    }
    
    func getNavBarHeight() -> CGFloat{
        var navigationBarHeight: CGFloat = self.navigationController != nil ? (self.navigationController!.navigationBar.frame.height) : 64
        navigationBarHeight = navigationBarHeight + UIApplication.shared.statusBarFrame.height
    
        return navigationBarHeight
    }
    
    @objc func cancelCabRequest(){
        
        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_REQUEST_CANCEL_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Confirm", key: "LBL_BTN_TRIP_CANCEL_CONFIRM_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
            
            if(btnClickedIndex == 0){
                self.continueCancelCabReq()
            }
        })
        
    }
    
    
    func startDriverRequestQueue(){
        
        stopDriverRequestQueue()
        
        currDriverReqPosition = 0
        isRequestExecuting = false
        
        noDriverAvailView(isHidden: true)
        initializeDrverReqQue()
        
        driverRequestQueueTimer.fire()
        if(self.reqNoteLbl != nil){
            self.reqNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FINDING_PROVIDER_HEADER_TXT")
        }
        
    }
    
    func initializeDrverReqQue()
    {
        stopDriverRequestQueue()
        driverRequestQueueTimer =  Timer.scheduledTimer(timeInterval: Double(RIDER_REQUEST_ACCEPT_TIME + 5), target: self, selector: #selector(continueDriverRequestQueue), userInfo: nil, repeats: true)
    }
    
    func stopDriverRequestQueue(){
        if(self.reqNoteLbl != nil){
            //self.reqNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTE_NO_PROVIDER_REQUEST")
            if isCancelTrip {
                self.reqNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROVIDER_DECLINED_REQUEST_MSG")
            }else{
                self.reqNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTE_NO_PROVIDER_REQUEST")
            }
        }
        
        if(driverRequestQueueTimer != nil){
            driverRequestQueueTimer!.invalidate()
            driverRequestQueueTimer = nil
        }
    }
    
    @objc func continueDriverRequestQueue(){
        if(isRequestExecuting){
            return
        }
        
        if(currDriverReqPosition < 1){
            
            
            if(userProfileJson.get("DRIVER_REQUEST_METHOD").uppercased() == "ALL"){
                currDriverReqPosition = 1
                self.sendRequestToDrivers(driverIds:self.providerInfo.get("driver_id"),  tollPrice: "", tollPriceCurrencyCode: "", isTollSkipped: "")
                
            }else{
                self.sendRequestToDrivers(driverIds: self.providerInfo.get("driver_id"),  tollPrice: "", tollPriceCurrencyCode: "", isTollSkipped: "")
                currDriverReqPosition = currDriverReqPosition + 1
                
                initializeDrverReqQue()
            }
        }else{
            stopDriverRequestQueue()
            noDriverAvailView(isHidden: false)
        }
    }
    
    func noDriverAvailView(isHidden:Bool){
        if(requestCabView != nil){
            
            retryReqBtn.isHidden = isHidden
        }
    }
    
    func getRetryTextHeight() -> CGFloat{
        
        var retryTxtHeight = self.reqNoteLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 130, font: self.reqNoteLbl.font!)
        
        if(retryTxtHeight < 60){
            retryTxtHeight = 60
        }
        retryTxtHeight = retryTxtHeight + 10
        //        Utils.printLog(msgData: "retryTxtHeight::\(retryTxtHeight)")
        return retryTxtHeight
    }
    
    func closeCabReqView(){
        
        if(requestCabView != nil){
           
            self.requestCabView.removeFromSuperview()
            
            //setApplicationStatusBar()
            
//            if(self.APP_TYPE.uppercased() != "UBERX" && isDriverAssigned != true){
//                self.menuImgView.isHidden = self.isFromUFXhomeScreen == true ? true : false
//            }
            requestCabView = nil
        }
        self.navigationController?.navigationBar.layer.zPosition = 1
    }
    
    func continueCancelCabReq(){
        let parameters = ["type":"cancelCabRequest", "iUserId": GeneralFunctions.getMemberd()]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.stopDriverRequestQueue()
                    self.closeCabReqView()
                    
                }else{
                    if(dataDict.get(Utils.message_str) == "DO_RESTART" || dataDict.get("message") == "LBL_SERVER_COMM_ERROR" || dataDict.get("message") == "GCM_FAILED" || dataDict.get("message") == "APNS_FAILED"){

                        self.stopDriverRequestQueue()
                        self.closeCabReqView()
                    }
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
        func checkSurgePrice(_ isRideLater:Bool = false, isOpenOutStandingView:Bool = true){

        let parameters = ["type":"checkSurgePrice","SelectedCarTypeID": self.iVehicleTypeId, "SelectedTime": "", "PickUpLatitude": "", "PickUpLongitude": "", "DestLatitude": "", "DestLongitude": "", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType , "iRentalPackageId" : "", "iUserProfileId": "", "iOrganizationId": "", "vProfileEmail": "", "ePaymentBy": "", "ePool":""]
        
        //        , "TimeZone": selectedTimeZone
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("ShowContactUsBtn").uppercased() == "YES"){
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("outstanding_restriction_label")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if(btnClickedIndex == 0){
                            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                            self.push(uv: contactUsUv)
                        }
                        
                    })
                    return
                }
                
                if(GeneralFunctions.parseDouble(origValue: 0.0, data: dataDict.get("fOutStandingAmount")) > 0 && isOpenOutStandingView == true){
                    self.openOutStandingAmountBox(isRideLater, dataDict: dataDict)
                }else{
                    self.checkFlatFareExist(isRideLater: isRideLater, dataDict: dataDict)
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func checkFlatFareExist(isRideLater:Bool, dataDict:NSDictionary){
        
        if(dataDict.get("Action") == "1"){
            
            if(isRideLater == true){
                self.continueRideLaterSchedule()
            }else{
                self.requestCab(isWalletCheck: false)
            }
            
        }else{
            self.openSurgeConfirmDialog(isSurgeFromAddDestination: false, isRideLater: isRideLater, dataDict: dataDict)
        }
    }
    func openSurgeConfirmDialog(isSurgeFromAddDestination:Bool, isRideLater:Bool, dataDict:NSDictionary){
        
        let currentFare = ""
      
        let dataLoaded = false
        
        let openSurgeChargeView = OpenSurgePriceView(uv: self, containerView: self.view)
        openSurgeChargeView.show(userProfileJson: self.userProfileJson, currentFare: currentFare, dataDict: dataDict) { (isSurgeAccept, isSurgeLater) in
            if(isSurgeAccept){
                if(isRideLater == true){
                    self.continueRideLaterSchedule()
                }else{
                    self.requestCab(isWalletCheck: false)
                }
                
            }else if(isSurgeLater){
               
            }
        }
    }
    
    func openOutStandingAmountBox(_ isForRideLater:Bool = false, dataDict:NSDictionary){
        let openOutStandingAmtView = OpenOutStandingView(uv: self, containerView: self.view)
        openOutStandingAmtView.show(userProfileJson: self.userProfileJson, currentCabGeneralType: Utils.cabGeneralType_UberX, dataDict: dataDict) { (isPayNow, isAdjustAmount) in
            
            if(isPayNow){
                
                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=UberX&ePaymentType=ChargeOutstandingAmount&eForVideoConsultation=\(self.eForVideoConsultation)" + "&iDriverId=\(self.providerInfo.get("driver_id"))", uv: self)
                
//                /* PAYMENT FLOW CHANGES */
//                if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
//                    self.checkCardMode = "OUT_STAND_AMT"
//                    self.isAutoContinue_payBox = false
//                    self.checkCardConfig()
//
//                }else if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
//                    self.checkCard(checkCardMode: "OUT_STAND_AMT", isForRideLater: isForRideLater)
//                }/*.........*/
                
            }else if(isAdjustAmount){
                self.isAutoContinue_payBox = false
                self.isOutStandingAmtSkipped = true
                self.checkFlatFareExist(isRideLater: isForRideLater, dataDict: dataDict)

            }
        }
    }
    
    /* PAYMENT FLOW CHANGES */
    func checkCard(checkCardMode:String, isForRideLater:Bool){
        
        
        let parameters = ["type": "\(checkCardMode == "OUT_STAND_AMT" ? "ChargePassengerOutstandingAmount" : "CheckCard")","\(checkCardMode == "OUT_STAND_AMT" ? "iMemberId" : "iUserId")": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if(checkCardMode == "OUT_STAND_AMT"){
                        GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                        
                        self.userProfileJson =  (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            if(isForRideLater == true){
                                self.continueRideLaterSchedule()
                            }else{
                                self.requestCab(isWalletCheck: false)
                            }
                        })
                        
                    }
                    
                }else{
                    
                    /* PAYMENT FLOW CHANGES */
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        
                        var msgtxt = ""
                        if(dataDict.get("low_balance_content_msg") == ""){
                            msgtxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BAL")
                        }else{
                            msgtxt = dataDict.get("low_balance_content_msg")
                        }
                        
                        self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased(), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                            }
                        })
                        
                        return
                    }/* .............. */
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }/*.........*/
    
    func checkCardConfig(_ isForRideLater:Bool = false){
        if(GeneralFunctions.isUserCardExist(userProfileJson: self.userProfileJson)){
            showPaymentBox(isForRideLater)
        }else{
            let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
            paymentUV.isFromUFXPayMode = true
            self.push(uv: paymentUV)
        }
    }
    
    func requestCab(isWalletCheck:Bool){
        
        self.navigationController?.navigationBar.layer.zPosition = -1
        
        if((userProfileJson.get("ePhoneVerified").uppercased() != "YES" && userProfileJson.get("RIDER_PHONE_VERIFICATION").uppercased() == "YES") ){
            
            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_VERIFY_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                
                self.openAccountVerify()
                
            })
            
            return
        }
        
//        if(userProfileJson.get("eWalletBalanceAvailable").uppercased() == "YES" && isWalletCheck == false && GeneralFunctions.getPaymentMethod(userProfileJson: userProfileJson) != "2"){
//
//            /* PAYMENT FLOW CHANGES*/
//            if(self.paymentMethod == "Card" && GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
//            }else{
//                let contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_BALANCE_EXIST_JOB").replace("####", withString: userProfileJson.get("user_available_balance"))
//                self.generalFunc.setAlertMessage(uv: self, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
//
//                    if(btnClickedIndex == 0){
//                        self.eWalletDebitAllow = true
//                    }else{
//                        self.eWalletDebitAllow = false
//                    }
//
//                    self.requestCab(isWalletCheck: true)
//                })
//                return
//            }
//
//        }
        
        addDriverNotificationObserver()
        
        requestCabView = self.generalFunc.loadView(nibName: "RequestCabView", uv: self, contentView: contentView)
        
        //        requestCabView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.view.frame.height)
        //        requestCabView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height)
        requestCabView.frame = self.view.frame
        
        requestCabView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        
        //        if(self.currentCabGeneralType.uppercased() == Utils.cabGeneralType_UberX.uppercased()){
        //            requestCabHeaderViewHeightOffset = 20
        //        }
        
        //        if(Configurations.isIponeXDevice()){
        //            self.requestCabHeaderBarHeight.constant = 44 + GeneralFunctions.getSafeAreaInsets().top - requestCabHeaderViewHeightOffset
        //        }
        
        requestCabView.frame.size.height = requestCabView.frame.size.height + getNavBarHeight()
        requestCabView.frame.origin.y = requestCabView.frame.origin.y - getNavBarHeight()
        
        if(Application.screenSize.height <= 568){
            self.reqCabTitleLblTopSpace.constant = 10
            self.radarMainViewTopSpace.constant = 20
        }
        
        self.view.addSubview(requestCabView)
        
        requestView.backgroundColor = SColors.Theme
        radarMainView.backgroundColor = SColors.Theme.light()
        radarSubView.backgroundColor = SColors.Theme
        
        self.cancleReqBtn.clickDelegate = self
        self.cancleReqBtn.bgColor = SColors.Theme
        self.cancleReqBtn.titleColor = UIColor.white
        self.cancleReqBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
        
        let titlePadding = getNavBarHeight() - 30
        self.requestCabTitleLbl.setPadding(paddingTop: titlePadding - 5, paddingBottom: 5, paddingLeft: 10, paddingRight: 10)
        
        //        if(!Configurations.isIponeXDevice()){
        //            self.requestCabTitleLbl.setPadding(paddingTop: self.requestCabTitleLbl.paddingTop, paddingBottom: self.requestCabTitleLbl.paddingBottom + 10, paddingLeft: self.requestCabTitleLbl.paddingLeft, paddingRight: self.requestCabTitleLbl.paddingRight)
        //        }
        
        self.requestCabTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REQUESTING_TXT")
        //        self.requestCabTitleLbl.fit()
        self.requestCabTitleLbl.textColor = SColors.ThemeTxt
        
        self.reqNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FINDING_PROVIDER_HEADER_TXT")
        
        self.reqNoteLbl.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 10)
        
        self.retryReqBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT"))
        self.retryReqBtn.borderColor = SColors.Theme
        self.retryReqBtn.clickDelegate = self
        retryReqBtn.setCustomColor(textColor: SColors.Theme ,bgColor: UIColor.white, pulseColor: SColors.requestRetryBtnPulseColor)
        
        self.reqNoteLbl.fit()
        self.reqNoteLbl.textColor = SColors.Theme
        
        requestCabView.backgroundColor = UIColor.white
        
        GeneralFunctions.setImgTintColor(imgView: reqlocImgView, color: SColors.ThemeTxt)
    
        
        Configurations.setStatusBarStyle(style: SColors.ThemeSBStyle.uppercased() == "LIGHT" ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default)
        
        if(Configurations.isIponeXDevice()){
            let tmpView = UIView()
            tmpView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            tmpView.frame = CGRect(x: 0, y: requestCabView.frame.size.height, width: requestCabView.frame.size.width, height: 50)
            requestCabView.addSubview(tmpView)
        }
        
        
        self.radarMainView.layer.cornerRadius = self.radarMainView.frame.size.width / 2
        self.radarMainView.clipsToBounds = true
        
        self.radarSubView.layer.cornerRadius = self.radarSubView.frame.size.width / 2
        self.radarSubView.clipsToBounds = true
        
        radarViewObj = Radar.init(frame: CGRect(x: 3, y: 3, width: radarMainView.frame.size.width-6, height: radarMainView.frame.size.height-6))
        radarViewObj.layer.contentsScale = UIScreen.main.scale
        radarViewObj.alpha = 0.68;
        
        radarMainView.addSubview(radarViewObj)
        
        self.spinRadar()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addArc()
        })
        
        startDriverRequestQueue()
      
    }
    
    func addArc() {
        
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: -100, y: ((Application.screenSize.height * 60) / 100) - 50, width: Application.screenSize.width + 200, height: 100))
        UIColor.gray.setFill()
        ovalPath.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.zPosition = -1
        shapeLayer.fillColor = SColors.Theme.cgColor
        shapeLayer.path = ovalPath.cgPath
        self.requestView.layer.addSublayer(shapeLayer)
    }
    
    func spinRadar(){
        
        //        spin.toValue = [NSNumber numberWithFloat:-M_PI];
        //        radarLine.layer.anchorPoint = CGPointMake(-0.18, 0.5); //this is for distance from center
        
        let spin : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        spin.duration = 2.0
        spin.toValue = NSNumber(floatLiteral: .pi)
        spin.isCumulative = true
        spin.isRemovedOnCompletion = false // this is to keep on animating after application pause-resume
        spin.repeatCount = MAXFLOAT
        self.radarLineView.layer.anchorPoint = CGPoint(x: 0, y: 0);
        
        self.radarLineView.layer.add(spin, forKey: "spinRadarLine")
        self.radarViewObj.layer.add(spin, forKey: "spinRadarView")
    }
    
    func sendRequestToDrivers(driverIds:String, tollPrice: String, tollPriceCurrencyCode: String, isTollSkipped: String, _ eWalletIgnor:Bool = false){
        
        
        
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                self.closeCabReqView()
                self.stopDriverRequestQueue()
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
       
        var sendCartArray = [NSDictionary]()
        
        for i in 0..<self.cartArray.count{
            
            let dataDicArray = cartArray[i]
            
            //let cmntStr = dataDicArray.get("SpecialInstruction") == "" ? "" : String(describing: dataDicArray.get("SpecialInstruction").cString(using: String.Encoding.utf8)!)
            let cartDataDic = ["iVehicleTypeId":dataDicArray.dictOf("vehicleData").get("iVehicleTypeId"), "fVehicleTypeQty":dataDicArray.get("itemCount"), "tUserComment":dataDicArray.get("SpecialInstruction")] as NSDictionary
            sendCartArray.append(cartDataDic)
        }
    
        var parameters = ["type":"sendRequestToDrivers", "driverIds": driverIds, "userId": GeneralFunctions.getMemberd(), "SelectedCarTypeID": self.iVehicleTypeId, "DestLatitude": "", "DestLongitude": "", "DestAddress": "", "PickUpLatitude":"", "PickUpLongitude": "", "eType": "UberX", "PromoCode": self.promoCodeValue,"PickUpAddress": "", "iPackageTypeId": "", "vReceiverName": "", "vReceiverMobile": "", "tPickUpIns": "", "tDeliveryIns": "", "tPackageDetails": "", "fTollPrice": "", "vTollPriceCurrencyCode": "", "eTollSkipped": "", "Quantity": "", "iUserAddressId": addressId, "tUserComment":"" , "iRentalPackageId" : "", "delivery_arr":"", "total_del_dist":"", "total_del_time":"", "ePaymentBy":"", "iTripReasonId": "", "vReasonTitle": "", "vDistance": "", "vDuration": "", "iUserProfileId": "", "iOrganizationId": "", "vProfileEmail": "", "iPersonSize": "", "ePoolRequest":"", "eBookSomeElseNumber": "", "eBookSomeElseName": "", "eBookForSomeOneElse": "", "OrderDetails":sendCartArray.convertToJson()]
        
        
        // NEWPayment Changes
        let paymentData = GetPaymentProfileData.getInstance()
        if(paymentData.PAYMENT_OPTION != "Cash"){
            parameters["eWalletIgnore"] = eWalletIgnor == true ? "Yes" : "No"
        }
        
        //        "PickUpAddGeoCodeResult": self.pickUpAddGeoCodeResult.condenseWhitespace(), "DestAddGeoCodeResult": self.destAddGeoCodeResult.condenseWhitespace()
        //        , "TimeZone": "\(DateFormatter().timeZone.identifier)"
        
        if(self.eForVideoConsultation.uppercased() == "YES"){
            parameters["isVideoCall"] = "Yes"
            parameters["eServiceLocation"] = "Driver"
        }else{
            parameters["eServiceLocation"] = self.locationType == "User" ? "Passenger":"Driver"
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            //            Utils.printLog(msgData: "response:\(response)")
            
            if(response != ""){
               
                self.isRequestExecuting = false
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") != "1"){
                    if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                        self.closeCabReqView()
                        self.stopDriverRequestQueue()
                        GeneralFunctions.logOutUser()
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                         
                        })
                        
                        return
                    }
                    
                    if(dataDict.get(Utils.message_str) == "DO_RESTART" || dataDict.get("message") == "LBL_SERVER_COMM_ERROR" || dataDict.get("message") == "GCM_FAILED" || dataDict.get("message") == "APNS_FAILED"){
                        self.closeCabReqView()
                       self.stopDriverRequestQueue()
                        return
                    }
                    
                    if(dataDict.get(Utils.message_str) == "NO_CARS" || dataDict.get(Utils.message_str) == "LBL_PICK_DROP_LOCATION_NOT_ALLOW" || dataDict.get(Utils.message_str) == "LBL_DROP_LOCATION_NOT_ALLOW" || dataDict.get(Utils.message_str) == "LBL_PICKUP_LOCATION_NOT_ALLOW"){
                        
                        self.stopDriverRequestQueue()
                        self.closeCabReqView()
                        
                        //self.ufxSelectedServiceProviderId = ""
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str) == "NO_CARS" ? "LBL_NO_PROVIDERS_AVAIL_TXT" : dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                         
                        })
                        
                        return
                    }
                    
                    if(dataDict.get(Utils.message_str) == "DO_EMAIL_PHONE_VERIFY" || dataDict.get(Utils.message_str) == "DO_PHONE_VERIFY" || dataDict.get(Utils.message_str) == "DO_EMAIL_VERIFY"){
                        
                      self.stopDriverRequestQueue()
                        self.closeCabReqView()
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_VERIFY_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
                            if(dataDict.get(Utils.message_str) == "DO_EMAIL_PHONE_VERIFY"){
                                accountVerificationUv.requestType = "DO_EMAIL_PHONE_VERIFY"
                            }else if(dataDict.get(Utils.message_str) == "DO_EMAIL_VERIFY"){
                                accountVerificationUv.isForMobile = false
                                accountVerificationUv.requestType = "DO_EMAIL_VERIFY"
                            }else if(dataDict.get(Utils.message_str) == "DO_PHONE_VERIFY"){
                                accountVerificationUv.isForMobile = true
                                accountVerificationUv.requestType = "DO_PHONE_VERIFY"
                            }
                            
                            accountVerificationUv.isFromUFXCheckOut = true
                            accountVerificationUv.requestType = dataDict.get(Utils.message_str)
                            self.push(uv: accountVerificationUv)
                            
                        })
                        
                        return
                    }
                    
                    /* PAYMENT FLOW CHANGES */
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        
                        self.isRequestExecuting = true
                        
                        var msgtxt = ""
                        if(dataDict.get("low_balance_content_msg") == ""){
                            msgtxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BAL")
                        }else{
                            msgtxt = dataDict.get("low_balance_content_msg")
                        }
                        
                        var nagativeBtnTxt = ""
                        if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() == "YES"){
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                        }else{
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")
                        }
                        
                        
                        if(nagativeBtnTxt == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")){
                            self.generalFunc.setAlertMsg(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtnLBL: nagativeBtnTxt, naturalBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                                if(btnClickedIndex == 0){
                                    
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                    
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else if(btnClickedIndex == 1){
                                    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.sendRequestToDrivers(driverIds: driverIds, tollPrice: tollPrice, tollPriceCurrencyCode: tollPriceCurrencyCode, isTollSkipped: isTollSkipped, true)
                                    }else{
                                        self.stopDriverRequestQueue()
                                        self.closeCabReqView()
                                    }
                                    
                                }else{
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                }
                            })
                        }else{
                            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: nagativeBtnTxt, completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                                    
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                    
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else{
                                    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.sendRequestToDrivers(driverIds: driverIds, tollPrice: tollPrice, tollPriceCurrencyCode: tollPriceCurrencyCode, isTollSkipped: isTollSkipped, true)
                                    }else{
                                        self.stopDriverRequestQueue()
                                        self.closeCabReqView()
                                    }
                                    
                                }
                                
                            })
                        }
                        
                        
                        return
                    }/* .............. */
                    
                    if(dataDict.get(Utils.message_str) != ""){  /* LBL_RIDER_BLOCK */
                        
                        self.stopDriverRequestQueue()
                        self.closeCabReqView()
                        if(dataDict.get("isShowContactUs") == "Yes"){
                            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                                    let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                                    self.push(uv: contactUsUv)
                                }
                                
                            })
                            
                        }else{
                            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str) , key: dataDict.get(Utils.message_str)))
                        }
                        
                    }else{
                        
                        self.closeCabReqView()
                        self.stopDriverRequestQueue()
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REQUEST_FAILED_PROCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            
                            GeneralFunctions.restartApp(window: Application.window!)
                            
                        })
                    }
                }
              
                
            }else{
                //                self.generalFunc.setError(uv: self)
                
                if(self.reqSentErrorDialog != nil){
                    self.reqSentErrorDialog.disappear()
                    self.reqSentErrorDialog = nil
                }
                self.reqSentErrorDialog = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.sendRequestToDrivers(driverIds: driverIds, tollPrice: tollPrice, tollPriceCurrencyCode: tollPriceCurrencyCode, isTollSkipped: isTollSkipped)
                    }else{
                        self.closeCabReqView()
                       
                    }
                })
                
                
                //                if(self.userProfileJson.get("DRIVER_REQUEST_METHOD").uppercased() == "ALL"){
                //                    self.currDriverReqPosition = 0
                //                }else if(self.currDriverReqPosition > 0){
                //                    self.currDriverReqPosition = self.currDriverReqPosition - 1
                //                }
            }
        })
    }
    
    func loadBookingFinishView(_ isRideLater:Bool = false){
        
        // For UFX Provider
        GeneralFunctions.removeValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS")
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            GeneralFunctions.saveValue(key: "UFXCartData", value: [[NSDictionary]]() as AnyObject)
        }
        
        if(self.mainScreenUV != nil){
            self.mainScreenUV.releaseAllTask()
        }
        let opnTripFinishView = OpenTripFinishView(uv: self)
        if(isRideLater == false){
            opnTripFinishView.ufxDriverAcceptedReqNow = true
        }else{
            opnTripFinishView.ufxReqLater = true
        }
        opnTripFinishView.isFromUFXCheckOut = true
        opnTripFinishView.show(title: "", desc:"", true,.bottom ) {
        }
        
        
    }
    
    
    func continueRideLaterSchedule(_ isFromWalletChk:Bool = false, _ eWalletIgnor:Bool = false){
        
        
        
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
        
      
//        if(userProfileJson.get("eWalletBalanceAvailable").uppercased() == "YES" && isFromWalletChk == false && GeneralFunctions.getPaymentMethod(userProfileJson: userProfileJson) != "2"){
//
//            /* PAYMENT FLOW CHANGES*/
//            if(self.paymentMethod == "Card" && GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
//            }else{
//                let contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_BALANCE_EXIST_JOB").replace("####", withString: userProfileJson.get("user_available_balance"))
//                self.generalFunc.setAlertMessage(uv: self, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
//
//                    if(btnClickedIndex == 0){
//                        self.eWalletDebitAllow = true
//                    }else{
//                        self.eWalletDebitAllow = false
//                    }
//
//                    self.continueRideLaterSchedule(true)
//                })
//                return
//            }
//        }
        
        var sendCartArray = [NSDictionary]()
        
        for i in 0..<self.cartArray.count{
            
            let dataDicArray = cartArray[i]
            
           // let cmntStr = dataDicArray.get("SpecialInstruction") == "" ? "" : String(describing: dataDicArray.get("SpecialInstruction").cString(using: String.Encoding.utf8)!)
            let cartDataDic = ["iVehicleTypeId":dataDicArray.dictOf("vehicleData").get("iVehicleTypeId"), "fVehicleTypeQty":dataDicArray.get("itemCount"), "tUserComment":dataDicArray.get("SpecialInstruction")] as NSDictionary
            sendCartArray.append(cartDataDic)
        }
        
        
        let window = Application.window
     
        var parameters = ["type":"ScheduleARide", "iUserId": GeneralFunctions.getMemberd(),"pickUpLocAdd":"", "pickUpLongitude": "", "destLocAdd": "","destLatitude":"", "destLongitude": "", "scheduleDate": self.slectedDate, "iVehicleTypeId":"", "eType": "UberX", "PromoCode": self.promoCodeValue,"PickUpAddress": "", "iPackageTypeId": "", "vReceiverName": "", "vReceiverMobile": "", "tPickUpIns": "", "tDeliveryIns": "", "tPackageDetails": "", "fTollPrice": "", "vTollPriceCurrencyCode": "", "eTollSkipped": "", "Quantity": "", "iUserAddressId": addressId, "tUserComment":"" , "iRentalPackageId" : "", "delivery_arr":"", "total_del_dist":"", "total_del_time":"", "ePaymentBy":"", "iTripReasonId": "", "vReasonTitle": "", "vDistance": "", "vDuration": "", "iUserProfileId": "", "iOrganizationId": "", "vProfileEmail": "", "iPersonSize": "", "ePoolRequest":"", "eBookSomeElseNumber": "", "eBookSomeElseName": "", "eBookForSomeOneElse": "", "OrderDetails":sendCartArray.convertToJson(), "SelectedDriverId":self.providerInfo.get("driver_id"), "SelectedCarTypeID": self.iVehicleTypeId]
        
        // NEWPayment Changes
        let paymentData = GetPaymentProfileData.getInstance()
        if(paymentData.PAYMENT_OPTION != "Cash"){
            parameters["eWalletIgnore"] = eWalletIgnor == true ? "Yes" : "No"
        }
        
        //        "PickUpAddGeoCodeResult": self.pickUpAddGeoCodeResult.condenseWhitespace(), "DestAddGeoCodeResult": self.destAddGeoCodeResult.condenseWhitespace()
        //        , "TimeZone": self.selectedTimeZone
        if(self.eForVideoConsultation.uppercased() == "YES"){
            parameters["isVideoCall"] = "Yes"
            parameters["eServiceLocation"] = "Driver"
        }else{
            parameters["eServiceLocation"] = self.locationType == "User" ? "Passenger":"Driver"
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
                
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") != "1"){
                    if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                        GeneralFunctions.logOutUser()
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            
                            GeneralFunctions.restartApp(window: window!)
                        })
                        
                        return
                    }
                    
                    if(dataDict.get(Utils.message_str) == "DO_RESTART" || dataDict.get("message") == "LBL_SERVER_COMM_ERROR" || dataDict.get("message") == "GCM_FAILED" || dataDict.get("message") == "APNS_FAILED"){
                        
                        let window = Application.window
                        
                        let getUserData = GetUserData(uv: self, window: window!)
                        getUserData.getdata()
                        
                        return
                    }
                    
                    
                    if(dataDict.get(Utils.message_str) == "NO_CARS"){
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str) == "NO_CARS" ? "LBL_NO_PROVIDERS_AVAIL_TXT" : dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                        })
                    }
                    
                    if(dataDict.get(Utils.message_str) == "DO_EMAIL_PHONE_VERIFY" || dataDict.get(Utils.message_str) == "DO_PHONE_VERIFY" || dataDict.get(Utils.message_str) == "DO_EMAIL_VERIFY"){
                        
                        self.stopDriverRequestQueue()
                        self.closeCabReqView()
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_VERIFY_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
                            if(dataDict.get(Utils.message_str) == "DO_EMAIL_PHONE_VERIFY"){
                                accountVerificationUv.requestType = "DO_EMAIL_PHONE_VERIFY"
                            }else if(dataDict.get(Utils.message_str) == "DO_EMAIL_VERIFY"){
                                accountVerificationUv.isForMobile = false
                                accountVerificationUv.requestType = "DO_EMAIL_VERIFY"
                            }else if(dataDict.get(Utils.message_str) == "DO_PHONE_VERIFY"){
                                accountVerificationUv.isForMobile = true
                                accountVerificationUv.requestType = "DO_PHONE_VERIFY"
                            }
                            
                            accountVerificationUv.isFromUFXCheckOut = true
                            accountVerificationUv.requestType = dataDict.get(Utils.message_str)
                            self.push(uv: accountVerificationUv)
                            
                           
                        })
                        
                        return
                    }
                    
                    /* PAYMENT FLOW CHANGES */
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        
                        var msgtxt = ""
                        if(dataDict.get("low_balance_content_msg") == ""){
                            msgtxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BAL")
                        }else{
                            msgtxt = dataDict.get("low_balance_content_msg")
                        }
                        
                        var nagativeBtnTxt = ""
                        if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() == "YES"){
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                        }else{
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")
                        }
                        
                        if(nagativeBtnTxt == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")){
                            self.generalFunc.setAlertMsg(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtnLBL: nagativeBtnTxt, naturalBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                                if(btnClickedIndex == 0){
                                    
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                    
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else if(btnClickedIndex == 1){
                                    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.continueRideLaterSchedule(isFromWalletChk, true)
                                    }else{
                                        self.stopDriverRequestQueue()
                                        self.closeCabReqView()
                                    }
                                    
                                }else{
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                }
                            })
                        }else{
                            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: nagativeBtnTxt, completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                                    
                                    self.stopDriverRequestQueue()
                                    self.closeCabReqView()
                                    
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else{
                                    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.continueRideLaterSchedule(isFromWalletChk, true)
                                    }else{
                                        self.stopDriverRequestQueue()
                                        self.closeCabReqView()
                                    }
                                    
                                }
                                
                            })
                        }
                       
                        return
                    }/* ............... */
                    
                    if(dataDict.get(Utils.message_str) != "" && dataDict.get("isShowContactUs") == "Yes"){  /* LBL_RIDER_BLOCK */
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                                self.push(uv: contactUsUv)
                            }
                            
                        })
                        
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                    }
                    
                }else{
                    self.loadBookingFinishView(true)
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    @IBAction func unwindToUFXCheckOut(_ segue:UIStoryboardSegue) {
        
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        if(segue.source.isKind(of:ChooseServiceDateUV.self)){
            
            let chooseServiceDateUV = segue.source as! ChooseServiceDateUV
            
            self.slectedDate = chooseServiceDateUV.finalDate
            //self.continueRideLaterSchedule()
            
//            let date = Utils.convertDateAppLocaleToGregorian(date: Utils.convertDateToFormate(date: chooseServiceDateUV.selectedDate, formate: "yyyy-MM-dd"), dateFormate: "yyyy-MM-dd")
//            self.slectedTime = chooseServiceDateUV.selectedTime
//            self.bookingdateVLbl.text = Configurations.convertNumToEnglish(numStr: Utils.convertDateToFormate(date: date, formate: "dd MMM yyyy"))
//            self.bookingTimeVLbl.text = self.slectedTime
            
            self.checkSurgePrice(true, isOpenOutStandingView: true)
            
        }else if(segue.source.isKind(of: AddPaymentUV.self)){
            
            if(self.isUFXLater != true){
                if self.eForVideoConsultation.uppercased() != "YES" {
                if(self.locationType == "User" && self.addressVLbl.text == ""){
    
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                    return
                }
                }
                self.checkSurgePrice(false, isOpenOutStandingView: true)
                
            }else{
                if self.eForVideoConsultation.uppercased() != "YES"{
                if(self.locationType == "User" && self.addressVLbl.text == ""){
    
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                    return
                }
            }
                //self.schdeuleLater()
                let chooseServiceDateUV = GeneralFunctions.instantiateViewController(pageName: "ChooseServiceDateUV") as! ChooseServiceDateUV
                chooseServiceDateUV.selectedProviderId = self.providerInfo.get("driver_id")
                chooseServiceDateUV.isFromUFXProviderFlow = true
                self.push(uv: chooseServiceDateUV)
                
            }
            
        }else if(segue.source.isKind(of: SelectPromoCodeUV.self)){
            let selectPromoCodeUV = segue.source as! SelectPromoCodeUV
            
            self.promoCodeValue = selectPromoCodeUV.appliedPromoCode
            self.isPromoCodeAppliedManually = selectPromoCodeUV.isPromoCodeAppliedManually
            self.loadfareDetails()
        }else if(segue.source.isKind(of: ChooseAddressUV.self)){
            
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS") == true){
                
                let dataDic = GeneralFunctions.getValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS") as! NSDictionary
                if addressId != dataDic.get("iUserAddressId") {
                    self.promoCodeValue = ""
                }
                addressId = dataDic.get("iUserAddressId")
            }
            
            self.loadfareDetails()
            
        }else if(segue.source.isKind(of: AddAddressUV.self)){
            
            self.addressId = ""
            self.promoCodeValue = ""
            self.loadfareDetails()
        }else if(segue.source.isKind(of: PaymentUV.self)){
            
            //self.selectCard()
        }else if(segue.source.isKind(of: SelectPaymentProfileUV.self)){
            let selectPaymentProfileUV = segue.source as! SelectPaymentProfileUV
            if(selectPaymentProfileUV.isCashPayment == true){
                self.paymentMethod = "Cash"
            }else{
                self.isCardValidated = true
                self.paymentMethod = "Card"
            }
            
            self.eWalletDebitAllow = selectPaymentProfileUV.useWalletChkBox.on
            
            if(selectPaymentProfileUV.isFromRideLater == false){
                if self.eForVideoConsultation.uppercased() != "YES"{
                if(self.locationType == "User" && self.addressVLbl.text == ""){
    
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                    return
                }
                }
                self.checkSurgePrice(false, isOpenOutStandingView: true)
                
            }else{
                if self.eForVideoConsultation.uppercased() != "YES"{
                if(self.locationType == "User" && self.addressVLbl.text == ""){
    
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ADDRESS_TITLE_TXT"), uv: self)
                    return
                }
                }
                let chooseServiceDateUV = GeneralFunctions.instantiateViewController(pageName: "ChooseServiceDateUV") as! ChooseServiceDateUV
                chooseServiceDateUV.selectedProviderId = self.providerInfo.get("driver_id")
                chooseServiceDateUV.isFromUFXProviderFlow = true
                self.push(uv: chooseServiceDateUV)
                
            }
           
        }else if(segue.source.isKind(of: HelpNoteForRideUV.self)){ /* Help note changes for Ride*/
            
            
            
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=UberX&eForVideoConsultation=\(self.eForVideoConsultation)" + "&iDriverId=\(self.providerInfo.get("driver_id"))" , uv: self)
            
//            let helpNoteForRideUV = segue.source as! HelpNoteForRideUV
//            if(helpNoteForRideUV.isRideLater == false){
//                let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//                selectPaymentProfileUV.isFromUFXCheckout = true
//                selectPaymentProfileUV.isFromRideLater = false
//                self.push(uv: selectPaymentProfileUV)
//            }else{
//                let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//                selectPaymentProfileUV.isFromUFXCheckout = true
//                selectPaymentProfileUV.isFromRideLater = true
//                self.push(uv: selectPaymentProfileUV)
//            }
        }
    }
    func schdeuleLater()  {
        self.newScheduleView = ListBottomSheetViewTimePicker(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height:Application.screenSize.height))
        self.getCurentTime()
        let date = Date()
        
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
        
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
        
        self.datesAr = Date.getDates2(forLastNDays: 90, formate: "dd", startDate: modifiedDate )
        self.dayAr = Date.getDates2(forLastNDays: 90, formate: "E", startDate: modifiedDate)
        self.datesDisplay = Date.getDates2(forLastNDays: 90, formate: "E, MMM dd",startDate: modifiedDate)
        self.datesPass = Date.getDates2(forLastNDays: 90, formate: "dd MMM (EEE)", startDate: modifiedDate)
        self.selectedDateTimeNew = self.datesPass[0]
        let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd", startDate: modifiedDate)
        self.selectedDateTimeNewPass = tempAr[0]
        self.newScheduleView.collectionView.register(UINib(nibName: "dateTimeCVC", bundle: nil), forCellWithReuseIdentifier: "dateTimeCVC")
        self.newScheduleView.collectionView.dataSource = self
        self.newScheduleView.collectionView.delegate = self
        Utils.delayWithSeconds(0.2) {
            self.newScheduleView.collectionView.reloadData()
        }
        //self.newScheduleView.collectionView.reloadData()
        

        self.newScheduleView.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Schedule", key: "LBL_SCHEDULE")
        self.newScheduleView.viewHour.cornerRadius = 5
        self.newScheduleView.viewMinuts.cornerRadius = 5
        self.newScheduleView.viewAmPm.cornerRadius = 5
        self.newScheduleView.viewHour.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.viewMinuts.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.viewAmPm.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.buttonPositive.setCustomColor(textColor: SColors.ThemeTxt, bgColor: UIColor(hex: 0x00a9b8), pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.newScheduleView.buttonNegative.setCustomColor(textColor: SColors.ThemeTxt, bgColor: UIColor(hex: 0x5A5A5A), pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
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
        //self.contentView.addSubview(self.newScheduleView)
        let window = Application.window
        window?.addSubview(self.newScheduleView)
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
                self.newScheduleView.amPmLbl.text = "AM"
            }else{
                self.newScheduleView.amPmLbl.text = "PM"
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
        
        
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
        
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
        let dateFormatter = DateFormatter()
         
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
            cell.parentView.layer.shadowOpacity = 1.0
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.parentView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            cell.parentView.layer.shadowRadius = 4.0
            cell.parentView.layer.cornerRadius = 10
            cell.parentView.layer.borderColor = UIColor.black.cgColor
            cell.parentView.layer.borderWidth = 0
            cell.dateLbl.text = self.datesAr[indexPath.item]
            cell.dayLbl.text = self.dayAr[indexPath.item]
                if selectedIndexCollection == indexPath.row {
                    cell.parentView.backgroundColor = UIColor(hex: 0xdffdff)
                    cell.dateLbl.textColor = UIColor(hex: 0x00a9b8)
                    cell.dayLbl.textColor = UIColor(hex: 0x1ECCDC)
                }else{
                    cell.parentView.backgroundColor = UIColor(hex: 0xFFFFFF)
                    cell.dateLbl.textColor = UIColor(hex: 0x030303)
                    cell.dayLbl.textColor = UIColor.black
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
                let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
                let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
                let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd", startDate: modifiedDate)
                self.selectedDateTimeNewPass = tempAr[indexPath.row]
                let indexPath = IndexPath(item: indexPath.row, section: 0)
                let indexpathPrivious = IndexPath(item: selectedIndexPriviousCollection, section: 0)
                let reloadsIdexpath = [indexPath,indexpathPrivious]
                selectedIndexPriviousCollection = indexPath.row
                self.newScheduleView.collectionView.reloadItems(at: reloadsIdexpath)
                //self.newScheduleView.collectionView.reloadData()
           
        
    }
    
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }

}
