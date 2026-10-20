

import UIKit
import SysBaseLib
import WebKit

class RatingUV: ParentViewUV, MyBtnClickDelegate, MyLabelClickDelegate, CMSwitchViewDelegate, RatingViewDelegate, ParentViewUVDelegate {
    
    /* Create IBOutlet */
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!

    @IBOutlet weak var totalFareVLbl: MyLabel!
    
    @IBOutlet weak var tripTimeLbl: MyLabel!
    @IBOutlet weak var thanksView: UIView!
    @IBOutlet weak var thanksViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var thanksHLbl: MyLabel!
    @IBOutlet weak var rideNoLbl: MyLabel!
    
    @IBOutlet weak var walletAmtLbl: MyLabel!
    @IBOutlet weak var walletAmtLblHeight: NSLayoutConstraint!

    @IBOutlet weak var tripDateVLbl: MyLabel!
    
    @IBOutlet weak var tripGeneralInfoLbl: MyLabel!
    
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var addressContainerViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var addressContainerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sourceAddressHLbl: MyLabel!
    @IBOutlet weak var sourceAddressVLbl: MyLabel!
    
    @IBOutlet weak var destAddHLbl: MyLabel!
    @IBOutlet weak var destAddVLbl: MyLabel!
    
    @IBOutlet weak var dashedView: UIView!
    
    @IBOutlet weak var sourceLocView: UIView!
    @IBOutlet weak var destLocView: UIView!
    
    @IBOutlet weak var chargesHLbl: MyLabel!

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vehicleTypeLbl: MyLabel!
    @IBOutlet weak var vTypeNameHeight: NSLayoutConstraint!
    @IBOutlet weak var fareDataContainerStkView: UIStackView!
    @IBOutlet weak var fareContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fareDataContainerView: UIView!
    
    @IBOutlet weak var howWasHLbl: MyLabel!
    
    // RatingView OutLets
    @IBOutlet weak var rateContainerView: UIView!
    @IBOutlet weak var rateContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ratingBar: RatingView!
    @IBOutlet weak var commentTxtView: KMPlaceholderTextView!
    
    // Give Tip OutLets
    @IBOutlet weak var tipHImgView: UIImageView!
    @IBOutlet weak var giveTipHLbl: MyLabel!
    @IBOutlet weak var giveTipNoteLbl: MyLabel!
    @IBOutlet weak var giveTipPLbl: MyLabel!
    @IBOutlet weak var giveTipNLbl: MyLabel!
    @IBOutlet weak var enterTipTxtField: MyTextField!

    /* FAV DRIVERS CHANGES */
    @IBOutlet weak var favContainerView: UIView!
    @IBOutlet weak var favContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var favHLbl: MyLabel!
    @IBOutlet weak var favSwitch: CMSwitchView!
    
    @IBOutlet weak var submitBtn: MyButton!
    
    @IBOutlet weak var skipBtn: MyButton!
    
    @IBOutlet weak var safetyRatingCloseView: UIView!
    @IBOutlet weak var safetyRatingView: UIView!
    @IBOutlet weak var tripRatingBar: RatingView!
    @IBOutlet weak var safetyRatingBar: RatingView!
    @IBOutlet weak var safetyConainerView: UIView!
    @IBOutlet weak var ratingSLbl: MyLabel!
    @IBOutlet weak var tripRatingBarXPosition: NSLayoutConstraint!
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoTitleLbl: MyLabel!
    @IBOutlet weak var videoImgView: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    var isFavSelected = false
    
    /* PAYMENT FLOW CHANGES */
    var webView = WKWebView()
    var activityIndicator:UIActivityIndicatorView!
    /* ................. */
    
    var currentTipMode = "OFF"
    
    let generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    
    var isPageLoad = false
    var window:UIWindow!
    
    var iTripId = ""
    
    var cntView:UIView!
    
    var PAGE_HEIGHT:CGFloat = 770
    
    var ENABLE_TIP_MODULE = ""
    
    var giveTipView:UIView!
    var bgTipView:UIView!
    
    var isBottomViewSet = false
    
//    var tripFinishView:UIView!
//    var tripFinishBGView:UIView!
    
    var isSafeAreaSet = false
    var iphoneXBottomView:UIView!
    
    var fareContainerViewHeightTemp:CGFloat = 0
    var detailsViewHeightTemp:CGFloat = 0
    
    var eTripType = ""

    var backShowsForWebView = true
    var userProfileJson:NSDictionary!
    
    var ratingBarTapGesture:UITapGestureRecognizer!
    var favSwipeGesture:UISwipeGestureRecognizer!
    
    var dataDic:NSDictionary!
    var isBidding = false
    var isRatingSkip = "No"
    var isSkipRatingEnable = false
    var finalDataDic = NSDictionary()
    var isMedical = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            window = Application.window!
            
            cntView = self.generalFunc.loadView(nibName: "RatingScreenDesign", uv: self, contentView: scrollView)
            cntView.backgroundColor = UIColor.clear
            
            self.scrollView.addSubview(cntView)
            
            self.setnavBarTintColor(color: SColors.Theme)
            
            self.scrollView.isHidden = true
            self.submitBtn.isHidden = true
            
            scrollView.bounces = false
            
            scrollView.backgroundColor = SColors.ThemeTxt
            
            if(PAGE_HEIGHT < self.contentView.frame.height){
                PAGE_HEIGHT = self.contentView.frame.height
            }
            
            /* PAYMENT FLOW CHANGES */
            self.webView.isHidden = true
            /* ........... */
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            setData()
            self.ratingBar.fullStarColor = SColors.selected_rate_color
            self.ratingBar.emptyStarColor = SColors.unSelected_rate_color
            
            self.safetyRatingBar.fullStarColor = SColors.selected_rate_color
            self.safetyRatingBar.emptyStarColor = SColors.unSelected_rate_color
            self.safetyRatingBar.delegate = self

            self.safetyRatingBar.backgroundColor = UIColor.clear
            
            self.tripRatingBar.fullStarColor = SColors.selected_rate_color
            self.tripRatingBar.emptyStarColor = SColors.unSelected_rate_color
            self.tripRatingBar.delegate = self


            GeneralFunctions.removeValue(key: "isDriverAssigned")
            
        }else if(type == 1){
            
            self.configRTL()
            self.navigationController?.navigationBar.layer.zPosition = -1
            
        }else if(type == 2){
            if(isPageLoad == false){

                cntView.frame.size = CGSize(width: cntView.frame.width, height: PAGE_HEIGHT)
                
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
                
                if(iTripId != ""){
                    self.addBack()
                }else{
                    backShowsForWebView = true
                    self.navigationItem.leftBarButtonItems = []
                }
                
                /* FAV DRIVERS CHANGES */
                if isBidding {
                    self.rateContainerViewHeight.constant = 193
                    self.favContainerView.isHidden = true
                    self.favContainerViewHeight.constant = 0
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT - 45
                }else{
                if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES" && self.userProfileJson.dictOf("TripDetails").get("eFly").uppercased() != "YES"){
                    
                    self.ratingBar.delegate = self
                    self.favHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAVE_AS_FAV_DRIVER")
                    self.favSwitch.dotColor = UIColor(hex: 0xFF0000)
                    self.favSwitch.isUserInteractionEnabled = true
                    self.favSwitch.color = UIColor(hex: 0xFFFFFF)
                    self.favSwitch.tintColor = UIColor(hex: 0xFFFFFF)
                    self.favSwitch.layer.borderColor = UIColor(hex: 0xdedede).cgColor
                    self.favSwitch.layer.borderWidth = 1
                    self.favSwitch.layer.cornerRadius = favSwitch.frame.height / 2
                    self.favSwitch.delegate = self

                }else{
                    self.rateContainerViewHeight.constant = 193
                    self.favContainerView.isHidden = true
                    self.favContainerViewHeight.constant = 0
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT - 45
                }
                }
                /* ............... */
                
                
                getTripData()
                
                isPageLoad = true
                
                
               
            }
            UIApplication.shared.isStatusBarHidden = false
        }else if(type == 3){
            self.navigationController?.navigationBar.layer.zPosition = 0
        }
    }
  
  
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            if(cntView != nil){
                scrollView.frame.size.height = scrollView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
            }
            
            if(Configurations.isIponeXDevice()){
                
                if(iphoneXBottomView == nil){
                    iphoneXBottomView = UIView()
                    self.view.addSubview(iphoneXBottomView)
                }
                
                iphoneXBottomView.backgroundColor = SColors.Theme
                iphoneXBottomView.frame = CGRect(x: 0, y: self.stackView.frame.maxY - GeneralFunctions.getSafeAreaInsets().bottom, width: Application.screenSize.width, height: GeneralFunctions.getSafeAreaInsets().bottom)
               // btnAreaBottomMargin.constant = GeneralFunctions.getSafeAreaInsets().bottom
            }
            
            isSafeAreaSet = true
        }
    }
    
    override func close() {
      
        let window = Application.window
        
        if(self.finalDataDic.count == 0){
            let getUserData = GetUserData(uv: self, window: window!)
            getUserData.getdata()
            return
        }
        _ = OpenMainProfile(uv: self, userProfileJson: self.finalDataDic.toJsonStr(), window: window!)
    }
    
  
    func setData(){
    
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAY_SUMMARY")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAY_SUMMARY")
        
        self.headerView.backgroundColor = SColors.Theme
        
        self.thanksView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.thanksView.layer.roundCorners(radius: 10)
        
        self.detailsView.layer.addShadow(opacity: 1, radius: 1, UIColor.lightGray)
        self.detailsView.layer.roundCorners(radius: 10)
        
        self.addressContainerView.layer.addShadow(opacity: 1, radius: 1, UIColor.lightGray)
        self.addressContainerView.layer.roundCorners(radius: 10)
        
        self.rateContainerView.layer.addShadow(opacity: 1, radius: 1, UIColor.lightGray)
        self.rateContainerView.layer.roundCorners(radius: 10)

        tripGeneralInfoLbl.layer.shadowOpacity = 0.5
        tripGeneralInfoLbl.layer.shadowRadius = 2.5
        tripGeneralInfoLbl.layer.shadowOffset = CGSize(width: 0, height: 6)
        tripGeneralInfoLbl.layer.shadowColor = UIColor.lightGray.cgColor
        
        Utils.createRoundedView(view: self.tripGeneralInfoLbl, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        self.sourceLocView.backgroundColor = SColors.SourceAddColor
        self.destLocView.backgroundColor = SColors.DestAddColor
        
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_SUBMIT_TXT"))
        
        self.submitBtn.clickDelegate = self
        self.skipBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SKIP"))
        self.skipBtn.setCustomColor(textColor: UIColor(hex: 0x1B2A3B), bgColor: SColors.ThemeTxt, pulseColor: UIColor(hex: 0x1B2A3B), borderColor: UIColor(hex: 0x1B2A3B), borderWidth: 1, cornerRadius: 10)
        self.skipBtn.clickDelegate = self
        
        self.commentTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Tap to Write Comment...", key: "LBL_USER_FEEDBACK_NOTE")
        self.commentTxtView.layer.borderColor = UIColor(hex: 0xdedede).cgColor
        self.commentTxtView.layer.borderWidth = 1.5
        self.commentTxtView.layer.cornerRadius = 5
        self.commentTxtView.clipsToBounds = true
        
        self.chargesHLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHARGES_TXT"))"
        
        
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == self.submitBtn){
            self.isRatingSkip = "No"
            if(self.dataDic.get("ShowSafetyRating").uppercased() == "YES"){
                
               if(self.tripRatingBar.rating <= 0.0 || self.safetyRatingBar.rating <= 0.0){
                    if(self.tripRatingBar.rating <= 0.0){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_RATING_DIALOG_TXT"), uv: self)
                    }
                    
                    if(self.safetyRatingBar.rating <= 0.0){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_SAFETY_RATING_DIALOG_TXT"), uv: self)
                    }
                
               }else{
                    if(self.ENABLE_TIP_MODULE == "Yes"){
                        currentTipMode = "OFF"
                        self.loadTipView()

                    }else{
                        if isBidding {
                          submitRatingBidding()
                        }else{
                        submitRating(fAmount: "", isCollectTip: "No")
                        }
                    }
                
               }
               
            }else{
                if(self.ratingBar.rating > 0.0){
                    if(self.ENABLE_TIP_MODULE == "Yes"){
                        self.loadTipView()
                    }else{
                        if isBidding {
                            submitRatingBidding()
                        }else{
                        submitRating(fAmount: "", isCollectTip: "No")
                        }
                    }
                }else{
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_RATING_DIALOG_TXT"), uv: self)
                }
            }
            
        }
        else if sender == self.skipBtn {
            self.isRatingSkip = "Yes"
            if isBidding{
           submitRatingBidding()
            }else{
            submitRating(fAmount: "", isCollectTip: "No")
            }
        }
    }
    
    func getTripData(){
        scrollView.isHidden = true
        self.submitBtn.isHidden = true
        
        loaderView =  self.generalFunc.addMDloader(contentView: self.view)
        loaderView.backgroundColor = UIColor.clear
        var parameters = [String:String]()
        if isBidding {
            parameters = ["type": "displayFareBiddingService", "UserType": Utils.appUserType, "memberId": GeneralFunctions.getMemberd(), "iBiddingPostId": iTripId]
        }else{
         parameters = ["type":"displayFare","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iTripId": iTripId]
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.eTripType = dataDict.dictOf(Utils.message_str).get("eType")
                    
                    /* FAV DRIVERS CHANGES */
                    if(dataDict.dictOf(Utils.message_str).get("eFavDriver").uppercased() == "YES" && self.userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES" && dataDict.dictOf(Utils.message_str).get("eFly").uppercased() != "YES"){
                        self.favSwitch.configSwitchState(true, animated: false)
                        self.isFavSelected = true
                        if (dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Deliver || dataDict.dictOf(Utils.message_str).get("eType") == "Multi-Delivery"){
                        self.favHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAVE_FAVOUTITE_CARRIER")
                        }
                    }/* ........... */
                    // skip related changes
                    if self.userProfileJson.get("ENABLE_SKIP_RATING_RIDE").uppercased() == "YES"  {
                       
                        self.skipBtn.isHidden = false
                        self.isSkipRatingEnable = true
                        
                    }else{
                        self.isSkipRatingEnable = false
                        self.skipBtn.isHidden = true
                    }
                    //self.skipBtn.isHidden = true
                    self.totalFareVLbl.text = Configurations.convertNumToAppLocal(numStr: dataDict.dictOf(Utils.message_str).get("FareSubTotal"))
                    
                    self.thanksHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_THANKS_TXT")
                    
                    if self.isBidding {
                        self.rideNoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_TXT") + " #" + dataDict.dictOf(Utils.message_str).get("vBiddingPostNo")
                    }else{
                    self.rideNoLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Ride ? "LBL_RIDE" : (dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_UberX ? "LBL_SERVICES" : "LBL_DELIVERY"))) #\(Configurations.convertNumToAppLocal(numStr: dataDict.dictOf(Utils.message_str).get("vRideNo")))"
                        print(dataDict.get("eType"))
                    }
                    //let tripDateHStr = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("eType").uppercased() == Utils.cabGeneralType_Deliver.uppercased() || dataDict.get("eType") == "Multi-Delivery" ? "LBL_DELIVERY_DATE_TXT" : (dataDict.get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_JOB_REQ_DATE" : "LBL_TRIP_DATE_TXT")).uppercased()
                    
                    self.tripDateVLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dataDict.dictOf(Utils.message_str).get("tTripRequestDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateForateDateWithDay)
                    self.tripTimeLbl.text  = Utils.convertDateToFormate(date: Utils.convertDateGregorianToAppLocale(date: dataDict.dictOf(Utils.message_str).get("tTripRequestDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), formate: Utils.dateFormateTimeOnly)
                    self.tripTimeLbl.textColor = SColors.Theme
                    if self.isBidding {
                        self.sourceAddressHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICE_LOCATION")
                    }else{
                    self.sourceAddressHLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_UberX ? "Job Location" : (dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Deliver ? "Sender's location" : "Pick up location"), key: dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_UberX ? "LBL_JOB_LOCATION_TXT" : (dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Deliver || dataDict.dictOf(Utils.message_str).get("eType") == "Multi-Delivery" ? "LBL_SENDER_LOCATION" : "LBL_PICK_UP_LOCATION")).uppercased()
                    }
                    self.destAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Deliver || dataDict.dictOf(Utils.message_str).get("eType") == "Multi-Delivery" ? "Receiver's location" : "Destination location", key: dataDict.dictOf(Utils.message_str).get("eType") == Utils.cabGeneralType_Deliver || dataDict.dictOf(Utils.message_str).get("eType") == "Multi-Delivery" ? "LBL_RECEIVER_LOCATION" : "LBL_DEST_LOCATION").uppercased()
                    
                    if self.isBidding {
                        self.howWasHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_RATE_HEADING_DRIVER_TXT")
                    }else{
                    self.howWasHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.dictOf(Utils.message_str).get("eType").uppercased() == Utils.cabGeneralType_Deliver.uppercased() || self.eTripType == "Multi-Delivery"
                        ? "LBL_HOW_WAS_YOUR_DELIVERY" : (dataDict.dictOf(Utils.message_str).get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_HOW_WAS_YOUR_BOOKING" : "LBL_HOW_WAS_RIDE"))
                    }
                    
                    self.walletAmtLbl.isHidden = true
                    self.headerViewHeight.constant = 160
                    self.thanksViewTopConstraint.constant = 105
                    self.walletAmtLblHeight.constant = 0
                   
                    if(dataDict.dictOf(Utils.message_str).get("eWalletAmtAdjusted").uppercased() == "YES"){
                        self.totalFareVLbl.font = UIFont(name: Fonts().light, size: 45)!
                        
                        self.headerViewHeight.constant = 170
                        self.thanksViewTopConstraint.constant = 125
                        self.walletAmtLblHeight.constant = 17
                        
//                        self.walletAmtLbl.isHidden = false
//                        self.walletAmtLbl.text = self.generalFunc.getLanguageLabel(origValue: "Money deducted from Wallet", key: "LBL_DEDUCTED_MONEY_WALLET_TXT")
                        
                        self.walletAmtLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_AMT_ADJUSTED")): \(Configurations.convertNumToAppLocal(numStr: dataDict.dictOf(Utils.message_str).get("fWalletAmountAdjusted")))"
                        self.walletAmtLbl.isHidden = false
                    }
                    
                    let fDiscount = dataDict.dictOf(Utils.message_str).get("fDiscount")
                    _ = dataDict.dictOf(Utils.message_str).get("CurrencySymbol")
                    _ = dataDict.dictOf(Utils.message_str).get("vTripPaymentMode")
                    
                    let eCancelled = dataDict.dictOf(Utils.message_str).get("eCancelled")
                    let vCancelReason = dataDict.dictOf(Utils.message_str).get("vCancelReason")

                    if (fDiscount != "" && fDiscount != "0" && fDiscount != "0.00") {

                    }else{

                    }

                    self.vehicleTypeLbl.text = dataDict.dictOf(Utils.message_str).get("vServiceDetailTitle")
                    
                    let vTypeNameHeight = self.vehicleTypeLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont(name: Fonts().semibold, size: 18)!)
                    
//                    self.vTypeNameHeight.constant = vTypeNameHeight
                    
                    self.detailsViewHeight.constant = 30 + vTypeNameHeight

                    self.ENABLE_TIP_MODULE = dataDict.dictOf(Utils.message_str).get("ENABLE_TIP_MODULE")
                    
                    self.addFareDetails(dataDict: dataDict)
                    
                    let tSaddress = dataDict.dictOf(Utils.message_str).get("tSaddress").trim()
                    let tDAddress = dataDict.dictOf(Utils.message_str).get("tDaddress").trim()
                    
                    self.sourceAddressVLbl.text = tSaddress
                    self.destAddVLbl.text = tDAddress
                    self.sourceAddressVLbl.numberOfLines = 0
                    self.destAddVLbl.numberOfLines = 0
                    
                    let sourceAddHeight = tSaddress.height(withConstrainedWidth: Application.screenSize.width - 90, font: UIFont(name: Fonts().semibold, size: 14)!)
                    let destAddHeight = tDAddress.height(withConstrainedWidth: Application.screenSize.width - 90, font: UIFont(name: Fonts().semibold, size: 14)!)
                    
//                    self.addressContainerViewHeight.constant = 95 + sourceAddHeight + destAddHeight
                    
                    self.addressContainerViewHeight.constant = 90 + sourceAddHeight + destAddHeight + 60
                    if self.isBidding {
                        self.iTripId = dataDict.dictOf(Utils.message_str).get("iBiddingPostId")
                    }else{
                    self.iTripId = dataDict.dictOf(Utils.message_str).get("iTripId")
                    }
                    
                    if(tDAddress.trim() == ""){
                        self.destAddHLbl.isHidden = true
                        self.destAddVLbl.text = ""
                        self.destAddVLbl.fit()
                        self.dashedView.isHidden = true
                        self.destLocView.isHidden = true
                        self.addressContainerViewHeight.constant = sourceAddHeight + 100
                    }
                    if(dataDict.dictOf(Utils.message_str).get("isVideoCall").uppercased() == "YES"){
                        self.addressContainerViewHeight.constant = 120
                    }
                    
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.addressContainerViewHeight.constant
                    
                    if(eCancelled == "Yes"){
                        
                        self.tripGeneralInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.dictOf(Utils.message_str).get("eType").uppercased() == Utils.cabGeneralType_Deliver.uppercased() || self.eTripType == "Multi-Delivery" ? "LBL_PREFIX_DELIVERY_CANCEL_DRIVER" : ( dataDict.dictOf(Utils.message_str).get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_PREFIX_JOB_CANCEL_PROVIDER" : "LBL_PREFIX_TRIP_CANCEL_DRIVER")) + " \(vCancelReason)"
                        self.tripGeneralInfoLbl.isHidden = false
//                        self.tripGeneralInfoLbl.fit()
                        self.tripGeneralInfoLbl.numberOfLines = 0
                    }else{
                        self.tripGeneralInfoLbl.isHidden = true
                        self.addressContainerViewTopMargin.constant = self.addressContainerViewTopMargin.constant - 55
                        self.PAGE_HEIGHT = self.PAGE_HEIGHT - 85
                    }

                    self.dataDic = dataDict.dictOf(Utils.message_str)
                    
                    if(dataDict.dictOf(Utils.message_str).get("ShowSafetyRating").uppercased() == "YES"){
                    
                        self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING")
                        self.ratingBar.isHidden = true
                        self.safetyRatingView.isHidden = false
                        self.ratingSLbl.isHidden = false
                        self.safetyRatingCloseView.handleClick { (instance) in
                            self.performSwipeAction()
                        }
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                        self.dashedView.createDashedLine(color: UIColor(hex: 0x141414), lineWidth: 2, true)
                        self.setPageHeight()
                        
                    
                    })
                    
                    if(self.dataDic.get("isVideoCall").uppercased() == "YES"){
                        self.videoView.isHidden = false
                        self.videoTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIDEO_CONSULT_AT_YOUR_LOC")
                        self.sourceAddressVLbl.isHidden = true
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
            self.loaderView.isHidden = true
            self.scrollView.isHidden = false
            self.submitBtn.isHidden = false
        })
    }
    
    func setPageHeight(){
        self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT + 50)
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 50)
    }
    
    func addFareDetails(dataDict:NSDictionary){
        
        let FareDetailsNewArr = dataDict.dictOf(Utils.message_str).arrOf("FareDetailsNewArr")
        self.fareDataContainerView.borderWidth = 1
        self.fareDataContainerView.borderColor = UIColor(hex: 0xDDDDDD)
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        
        for i in 0..<FareDetailsNewArr.count {
            
            let dict_temp = FareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
                
                let totalSubViewCounts = self.fareDataContainerView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    
                    let viewWidth = Application.screenSize.width - 70
                    
                    let viewCus = UIView(frame: CGRect(x:0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth , height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)
                    
                    self.fareDataContainerView.addSubview(viewCus)
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 70
                    
                     let viewCus = UIView(frame: CGRect(x: 0, y:  CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font:UIFont!
                    
                    if(i == FareDetailsNewArr.count - 1){
                        font = UIFont(name: Fonts().semibold, size: 18)!
                    }else{
                        font = UIFont(name: Fonts().regular, size: 14)!
                    }
                    
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 15
                    
                    if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                        widthOfvalue = ((viewWidth * 80) / 100)
                        widthOfTitle = ((viewWidth * 20) / 100)
                    }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }
                    
                    let widthOfParentView = viewWidth - widthOfvalue
                    
                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 40))
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView - 5, y: 0, width: widthOfvalue, height: 40))
                    
                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                        lblValue = MyLabel(frame: CGRect(x: 5, y: 0, width: widthOfvalue, height: 40))
                        
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.textColor = UIColor(hex: 0x646464)
                    lblValue.textColor = UIColor(hex: 0x090909)
                    
                    if(i == FareDetailsNewArr.count - 1){
                        lblTitle.textColor = SColors.Theme_1
                        lblValue.textColor = SColors.Theme
                    }
                    
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
                    
                    self.fareDataContainerView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    if(i == FareDetailsNewArr.count - 1){
                        lblTitle.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblValue.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        lblTitle.textColor = UIColor(hex: 0x141414)
                        lblValue.textColor = SColors.Theme
                        
                    }
                }
            }
        }
        
        self.fareDataContainerStkView.layoutIfNeeded()
        
        self.fareContainerViewHeightTemp = CGFloat((self.fareDataContainerView.subviews.count - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight))
        
        self.fareContainerViewHeight.constant = self.fareContainerViewHeightTemp
        
        self.detailsViewHeight.constant = self.detailsViewHeight.constant +  self.fareContainerViewHeight.constant + 15

        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.detailsViewHeight.constant
        
        self.setPageHeight()
        
//        self.detailsViewHeightTemp = self.detailsViewHeight.constant +  self.fareContainerViewHeightTemp
        
//        self.detailsViewHeight.constant = self.detailsViewHeight.constant +  self.fareContainerViewHeight.constant
        
//        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.detailsViewHeight.constant
        
//        self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT)
//        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT)
    }
    
    func submitRating(fAmount:String, isCollectTip:String){
        
        if(bgTipView != nil){
            bgTipView.removeFromSuperview()
        }
        
        if(giveTipView != nil){
            giveTipView.removeFromSuperview()
        }
        
        var parameters = ["type":"submitRating","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "tripID": iTripId, "message": "\(commentTxtView.text!)", "fAmount": fAmount, "isCollectTip": isCollectTip, "eFavDriver": self.isFavSelected == true ? "Yes" : "No"]  /* FAV DRIVERS CHANGES */
        
        if(self.dataDic.get("ShowSafetyRating").uppercased() == "YES"){
            
            parameters["rating"] = "\(self.tripRatingBar.rating)"
            parameters["safetyRating"] = "\(self.safetyRatingBar.rating)"
            
        }else{
            parameters["rating"] = "\(self.ratingBar.rating)"
        }
        if isSkipRatingEnable {
            parameters["isSkipRating"] = isRatingSkip
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if dataDict.get("isMedicalServiceTrip").uppercased() == "YES" {
                        self.isMedical = true
                    }
                    self.loadTripFinishView()
                    self.finalDataDic = dataDict.dictOf("USER_DATA")
                    
                }else{
                    
                    if(dataDict.get("isCollectTip").uppercased() == "YES"){
                        
                        let url = dataDict.get(Utils.message_str)
                        GeneralFunctions.addPayment(url: url, uv: self)
                        
                        return
                    }
                    if(dataDict.get(Utils.message_str) == "LBL_REQUIRED_MINIMUM_AMOUT"){
                        
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)) + " " + dataDict.get("minValue"))
                        
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    self.currentTipMode = "OFF"
                }
            }else{
                self.generalFunc.setError(uv: self)
                self.currentTipMode = "OFF"
            }
        })
    }
    func submitRatingBidding(){
        if(bgTipView != nil){
            bgTipView.removeFromSuperview()
        }
        
        if(giveTipView != nil){
            giveTipView.removeFromSuperview()
        }
           var key = "tripID"
        if isBidding {
            key = "iBiddingPostId"
        }
        var  parameters = ["type":"submitRatingBiddingService","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, key: iTripId, "message": "\(commentTxtView.text!)" ]
        if(self.dataDic.get("ShowSafetyRating").uppercased() == "YES"){
            parameters["rating"] = "\(self.tripRatingBar.rating)"
            parameters["safetyRating"] = "\(self.safetyRatingBar.rating)"
        }else{
            parameters["rating"] = "\(self.ratingBar.rating)"
        }
        if isSkipRatingEnable {
            parameters["isSkipRating"] = isRatingSkip
        }
           
           let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
           exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
           exeWebServerUrl.currInstance = exeWebServerUrl
           exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
               if(response != ""){
                   let dataDict = response.toDict()
                   
                   if(dataDict.get("Action") == "1"){
                       
                       self.loadTripFinishView()
                       self.finalDataDic = dataDict.dictOf("USER_DATA")
                   }else{
                       
                       if(dataDict.get("isCollectTip").uppercased() == "YES"){
                           
                           let url = dataDict.get(Utils.message_str)
                           GeneralFunctions.addPayment(url: url, uv: self)
                           
                           return
                       }
                       if(dataDict.get(Utils.message_str) == "LBL_REQUIRED_MINIMUM_AMOUT"){
                           
                           self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)) + " " + dataDict.get("minValue"))
                           
                       }else{
                           self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                       }
                       self.currentTipMode = "OFF"
                   }
               }else{
                   self.generalFunc.setError(uv: self)
                   self.currentTipMode = "OFF"
               }
           })
              
       }
    
    
    func loadTripFinishView(){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        var title =  self.generalFunc.getLanguageLabel(origValue: "", key: eTripType.uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_JOB_FINISHED" : (eTripType.uppercased() == Utils.cabGeneralType_Deliver.uppercased() || eTripType == "Multi-Delivery" ? "LBL_DELIVERY_SUCCESS_FINISHED" : "LBL_SUCCESS_FINISHED"))
        var desc = self.generalFunc.getLanguageLabel(origValue: "", key: eTripType.uppercased() == Utils.cabGeneralType_Deliver.uppercased() || eTripType == "Multi-Delivery" ? "LBL_DELIVERY_FINISHED_USER_TXT" : (eTripType.uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_JOB_FINISHED_USER_TXT" : "LBL_TRIP_FINISHED_USER_TXT"))

        
        if isBidding{
            title =   self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_TASK_COMPLETED_TXT")
            desc = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_TASK_FINISHED_TXT")
        }
        if self.isMedical {
            title =   self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_SUCCESS_FINISHED")
            desc = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MEDICAL_TRIP_FINISHED_TXT")
        }
        
        opnTripFinishView.show(title: title, desc:desc ) {
            GeneralFunctions.saveValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED, value: false as AnyObject)
            self.close()
        }
    }
  
    func loadTipView(){
        giveTipView = self.generalFunc.loadView(nibName: "GiveTipView", uv: self, isWithOutSize: true)
        
        let width = Application.screenSize.width  > 380 ? 370 : Application.screenSize.width - 50
        
        giveTipView.frame.size = CGSize(width: width, height: 300)
        giveTipView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        
        bgTipView = UIView()
        bgTipView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height)
        
        bgTipView.backgroundColor = UIColor.black
        bgTipView.alpha = 0.4
        bgTipView.isUserInteractionEnabled = true
        
        giveTipView.layer.shadowOpacity = 0.5
        giveTipView.layer.shadowOffset = CGSize(width: 0, height: 3)
        giveTipView.layer.shadowColor = UIColor.black.cgColor
        
        if(self.navigationController != nil){
            self.navigationController?.view.addSubview(bgTipView)
            self.navigationController?.view.addSubview(giveTipView)
        }else{
            self.view.addSubview(bgTipView)
            self.view.addSubview(giveTipView)
        }
        
        Utils.createRoundedView(view: giveTipView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        GeneralFunctions.setImgTintColor(imgView: tipHImgView, color: SColors.Theme)
        
        self.giveTipNLbl.setClickDelegate(clickDelegate: self)
        self.giveTipPLbl.setClickDelegate(clickDelegate: self)
        
        self.giveTipPLbl.backgroundColor = SColors.Theme
        self.giveTipPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIVE_TIP_TXT").uppercased()
        self.giveTipNLbl.layer.borderWidth = 1
        self.giveTipNLbl.borderColor = SColors.Theme
        self.giveTipNLbl.layer.borderColor = UIColor.black.cgColor// SColors.Theme.cgColor
        self.giveTipNLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_THANKS").uppercased()
        self.giveTipNLbl.textColor = UIColor.black
        
        self.giveTipNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_TXT")
        if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S){
            self.giveTipNLbl.font = UIFont(name: Fonts().regular, size: 15)!
        }
        self.giveTipHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_TITLE_TXT")
        self.giveTipNoteLbl.fit()
        self.enterTipTxtField.isHidden = true
        self.enterTipTxtField.getTextField()!.keyboardType = .decimalPad
        
        self.enterTipTxtField.getTextField()!.keyboardType = .numberPad
        
        self.giveTipView.layoutIfNeeded()
    }
    
    /* FAV DRIVERS CHANGES */
    func ratingView(_ ratingView: RatingView, didChangeRating newRating: Float) {
       
        if(ratingView == self.tripRatingBar){
            self.perform(#selector(performSwipeAction), with: self, afterDelay: 0.5)
        }
        
    }


    @objc func performSwipeAction(){
       
        if(tripRatingBarXPosition.constant == 0){
            
            ratingBarTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(performSwipeAction))
            self.ratingBar.isUserInteractionEnabled = true
            self.ratingBar.addGestureRecognizer(ratingBarTapGesture)
            
            view.layoutIfNeeded()
            
            let xConstant = self.tripRatingBar.frame.origin.x + ((self.tripRatingBar.frame.width / 2) + (self.tripRatingBar.frame.width / 2) - 15)
            if(Configurations.isRTLMode()){
                tripRatingBarXPosition.constant = xConstant
            }else{
                tripRatingBarXPosition.constant = 0 - xConstant
            }
            
            self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAFETY_RATING_TXT")
            self.tripRatingBar.isHidden = true
            self.ratingBar.editable = false
            self.safetyConainerView.isHidden = false
           
            
            UIView.animate(withDuration: 0.3,
                          delay: 0.05,
                          options: .curveEaseInOut,
                          animations:
            {
                         self.view.layoutIfNeeded()
                        
            },
            completion: { _ in
                   
                self.safetyRatingBar.isHidden = false
                           
            })
            
        }else{
            
            self.ratingBar.removeGestureRecognizer(ratingBarTapGesture)
            view.layoutIfNeeded()
            
            self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING")
            tripRatingBarXPosition.constant = 0
            self.ratingBar.editable = true
            self.safetyConainerView.isHidden = true
            self.safetyRatingBar.isHidden = true
            self.tripRatingBar.isHidden = false
            UIView.animate(withDuration: 0.3,
               delay: 0.05,
               options: .curveEaseInOut,
               animations:
            {
              self.view.layoutIfNeeded()
              
                
            },
            completion: { _ in
                
                
                
            })
            
          
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if(Configurations.isRTLMode()){
                    if(tripRatingBarXPosition.constant == 0){
                        self.performSwipeAction()
                    }
                }else{
                    if(tripRatingBarXPosition.constant != 0){
                        self.performSwipeAction()
                    }
                }
                
                break
            case UISwipeGestureRecognizer.Direction.left:
                if(Configurations.isRTLMode()){
                    if(tripRatingBarXPosition.constant != 0){
                        self.performSwipeAction()
                    }
                }else{
                    if(tripRatingBarXPosition.constant == 0){
                        self.performSwipeAction()
                    }
                }
               
                break
            default:
                break
            }
        }
    }
    
    
    func myLableTapped(sender: MyLabel) {
        if(sender == self.giveTipPLbl){
            
            if(currentTipMode == "ON"){
                let tipEntered = Utils.checkText(textField: self.enterTipTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.enterTipTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD"))
                
                if(tipEntered){
                    
                    /* PAYMENT FLOW CHANGES */
                    if isBidding {
                        submitRatingBidding()
                    }else{
                    submitRating(fAmount: self.enterTipTxtField.getTextField()!.text!, isCollectTip: "Yes")
                    }
                    
                    /* .............. */
                    
                }
            }else{
                self.giveTipNoteLbl.isHidden = true
                self.enterTipTxtField.placeHolder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_AMOUNT")
                self.enterTipTxtField.isHidden = false
                self.enterTipTxtField.backgroundColor = UIColor(hex: 0xf6f6f6)
                self.enterTipTxtField.textPadding = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
                self.enterTipTxtField.cornerRadius = 5

                self.giveTipPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")
                self.giveTipNLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SKIP_TXT")
                self.giveTipHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT_ENTER_TITLE")
                
                currentTipMode = "ON"
            }
            
        }else if(sender == self.giveTipNLbl){
            if isBidding{
              submitRatingBidding()
            }else{
            submitRating(fAmount: "", isCollectTip: "No")
            }
        }
    }
    
    @objc func tripFinishOkTapped(){
      
        
        GeneralFunctions.saveValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED, value: false as AnyObject)
        self.close()
    }
    
    func switchValueChanged(_ sender: Any!, andNewValue value: Bool) {
        if (value == true) {  
            self.isFavSelected = true
            self.favSwitch.dotColor = UIColor(hex: 0x009900)
        } else {
            self.isFavSelected = false
            self.favSwitch.dotColor = UIColor(hex: 0xFF0000)
        }
    }/* ........... */
    
    
    
    @IBAction func unwindToRatingUV(_ segue:UIStoryboardSegue) {
        
        if isBidding {
        submitRatingBidding()
        }else{
        submitRating(fAmount: "", isCollectTip: "No")
        }
    }
    
    /*@objc func performSwipeAction(){
        if(ratingBarXPosition.constant == 0){
            ratingBarTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(performSwipeAction))
            self.ratingBar.isUserInteractionEnabled = true
            self.ratingBar.addGestureRecognizer(ratingBarTapGesture)
            
            view.layoutIfNeeded()
            
            let xConstant = self.ratingBar.frame.origin.x + ((self.ratingBar.frame.width / 2) + (self.ratingBar.frame.width / 2) - 35)
            if(Configurations.isRTLMode()){
                ratingBarXPosition.constant = xConstant
            }else{
                ratingBarXPosition.constant = 0 - xConstant
            }
            
            self.ratingBar.editable = false
            self.favSwitchView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            self.ratingBar.removeGestureRecognizer(ratingBarTapGesture)
            view.layoutIfNeeded()
            
            ratingBarXPosition.constant = 0
            self.ratingBar.editable = true
            self.favSwitchView.isHidden = true
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }*/
    
    /*@objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if(Configurations.isRTLMode()){
                    if(ratingBarXPosition.constant == 0){
                        self.performSwipeAction()
                    }
                }else{
                    if(ratingBarXPosition.constant != 0){
                        self.performSwipeAction()
                    }
                }
                break
            case UISwipeGestureRecognizer.Direction.left:
                if(Configurations.isRTLMode()){
                    if(ratingBarXPosition.constant != 0){
                        self.performSwipeAction()
                    }
                }else{
                    if(ratingBarXPosition.constant == 0){
                        self.performSwipeAction()
                    }
                }
                break
            default:
                break
            }
        }
    }*/
}
