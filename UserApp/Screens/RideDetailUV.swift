

import UIKit
import GoogleMaps
import SafariServices
import SysBaseLib

class RideDetailUV: ParentViewUV, MyBtnClickDelegate, OnDirectionUpdateDelegate, RatingViewDelegate, CMSwitchViewDelegate, ParentViewUVDelegate ,TextFieldDelegate{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userHeaderView: UIView!
    @IBOutlet weak var userHeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userPicBgView: UIView!
    @IBOutlet weak var userPicBgImgView: UIImageView!
    
    @IBOutlet weak var userPicImgView: UIImageView!
    @IBOutlet weak var userNameVLbl: MyLabel!
    @IBOutlet weak var ratingBar: RatingView!

    @IBOutlet weak var thanksView: UIView!
    @IBOutlet weak var thanksViewHeight: NSLayoutConstraint!
    @IBOutlet weak var thanksViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var thanksHLbl: MyLabel!
    @IBOutlet weak var rideNoLbl: MyLabel!
    @IBOutlet weak var rideNoLblTopMargin: NSLayoutConstraint!
    
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var textViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var serviceAreaTopMargine: NSLayoutConstraint!  // default 10
    @IBOutlet weak var serviceImageAreaView: UIView!
    @IBOutlet weak var serviceAreaCenterViewOffset: NSLayoutConstraint!
    @IBOutlet weak var serviceImageAreaHeight: NSLayoutConstraint!
    @IBOutlet weak var beforeServiceImgArea: UIView!
    @IBOutlet weak var afterServiceImgArea: UIView!
    @IBOutlet weak var beforeServiceImgView: UIImageView!
    @IBOutlet weak var beforeServiceLbl: MyLabel!
    @IBOutlet weak var afterServiceImgView: UIImageView!
    @IBOutlet weak var afterServiceLbl: MyLabel!

    @IBOutlet weak var tripReqDateVLbl: MyLabel!
    
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var addressContainerViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var addressContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pickUpLocHLbl: MyLabel!
    @IBOutlet weak var pickUpLocVLbl: MyLabel!
    @IBOutlet weak var destLocHLbl: MyLabel!
    @IBOutlet weak var destLocVLbl: MyLabel!
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var sourceLocView: UIView!
    @IBOutlet weak var destLocView: UIView!
    
    @IBOutlet weak var gMapView: GMSMapView!
    
    @IBOutlet weak var senderLocationView: UIView!
    @IBOutlet weak var senderLocationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var senderLocationViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var senderLocHLbl: MyLabel!
    @IBOutlet weak var senderLocHImgView: UIImageView!
    @IBOutlet weak var senderLocVLbl: MyLabel!
    @IBOutlet weak var senderLocLblHeight: NSLayoutConstraint!
    @IBOutlet weak var senderLocLblTopMargin: NSLayoutConstraint!
    
    @IBOutlet weak var chargesParentView: UIView!
    @IBOutlet weak var chargesHLbl: MyLabel!
    @IBOutlet weak var vehicleTypeLbl: MyLabel!
    @IBOutlet weak var vehicleTypeLblHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesDataContainerView: UIView!
    @IBOutlet weak var chargesContainerView: UIStackView!
    @IBOutlet weak var chargesContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesParentViewHeight: NSLayoutConstraint!

    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipInfoLbl: MyLabel!
    @IBOutlet weak var tipHLbl: MyLabel!
    @IBOutlet weak var tipAmountLbl: MyLabel!
    @IBOutlet weak var tipTopPlusLbl: MyLabel!
    @IBOutlet weak var tipViewTopMargin: NSLayoutConstraint!
    
    @IBOutlet weak var tipMainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipMainView: UIView!
    @IBOutlet weak var tipMainViewHLbl: MyLabel!
    @IBOutlet weak var tipHintImgView: UIImageView!
    @IBOutlet weak var tipSubView: UIView!
    @IBOutlet weak var tipSubViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipAmoVIew1: UIView!
    @IBOutlet weak var tipAmoView2: UIView!
    @IBOutlet weak var tipAmoView3: UIView!
    @IBOutlet weak var tipAmoLbl1: MyLabel!
    @IBOutlet weak var tipAmoLbl2: MyLabel!
    @IBOutlet weak var tipAmoLbl3: MyLabel!
    @IBOutlet weak var tipAmoOtherView: UIView!
    @IBOutlet weak var tipAmoOtherLbl: MyLabel!
    @IBOutlet weak var tipAmoOtherValueView: UIView!
    @IBOutlet weak var tipAmoTxtFiled: UITextField!
    @IBOutlet weak var tipAmoOtherConfImgView: UIImageView!
    @IBOutlet weak var tipAmoImgView1: UIImageView!
    @IBOutlet weak var tipAmoImgView2: UIImageView!
    @IBOutlet weak var tipAmoImgView3: UIImageView!
    @IBOutlet weak var tipAmoOtherImgView: UIImageView!
    @IBOutlet weak var tipRequiredLbl: MyLabel!
    @IBOutlet weak var giveTipButtonHight: NSLayoutConstraint!
    @IBOutlet weak var giveTipButton: MyButton!
    @IBOutlet weak var ratingLbl: MyLabel!
    @IBOutlet weak var ratingImgView: UIImageView!
    @IBOutlet weak var tipMainviewTop: NSLayoutConstraint!
    @IBOutlet weak var tipButtonTop: NSLayoutConstraint!
    var tipAmount = ""
    var tipPosition = ""
    var selectTip1 = false
    var selectTip2 = false
    var selectTip3 = false
    var selectTip4 = false
    @IBOutlet weak var deliveryDetailsHLbl: MyLabel!
    @IBOutlet weak var deliveryDetailsView: UIView!
    @IBOutlet weak var deliveryDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var deliveryDetailsVLbl: MyLabel!
    
    @IBOutlet weak var deliveryDetailsHLblHeight: NSLayoutConstraint!
    @IBOutlet weak var deliveryDetailsViewTopMargin: NSLayoutConstraint!
    @IBOutlet weak var deliveryDetailsHLblTopMargin: NSLayoutConstraint!
    @IBOutlet weak var mapTopMargin: NSLayoutConstraint!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingHintLbl: MyLabel!
    @IBOutlet weak var ufxRatingBar: RatingView!
    @IBOutlet weak var ratingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTxtView: KMPlaceholderTextView!
    @IBOutlet weak var submitRatingBtn: MyButton!
    @IBOutlet weak var favContainerView: UIView!
    @IBOutlet weak var favContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var favSwitch: CMSwitchView!
    @IBOutlet weak var favHLbl: MyLabel!

    @IBOutlet weak var viewMoreServicesLbl: MyLabel!
    @IBOutlet weak var viewMoreServicesTopMargin: NSLayoutConstraint!
    @IBOutlet weak var viewMoreServicesLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var orgTripReasonLbl: MyLabel!
    @IBOutlet weak var cancelTripReasonLBL: MyLabel!
    @IBOutlet weak var cancelTripTopMargin: NSLayoutConstraint!

    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var payImgView: UIImageView!
    @IBOutlet weak var paymentTypeLbl: MyLabel!
    @IBOutlet weak var paymentTypeLblTopMargin: NSLayoutConstraint!
    @IBOutlet weak var paymentTypeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentTypeReasonLbl: MyLabel!

    @IBOutlet weak var tripStatusView: UIView!
    @IBOutlet weak var tripStatusLbl: MyLabel!
    @IBOutlet weak var tripStautsLblTopMargin: NSLayoutConstraint!
    @IBOutlet weak var tripCancelReasonLbl: MyLabel!
    @IBOutlet weak var tripSatusViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var helpImgView: UIImageView!
    
    @IBOutlet weak var signShowLbl: MyLabel!
    
    
    
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
    
    var ratingBarTapGesture:UITapGestureRecognizer!
    var tripDetailDict:NSDictionary!
    
    let generalFunc = GeneralFunctions()
        
    var isPageLoaded = false
    
    var cntView:UIView!
    
    var PAGE_HEIGHT:CGFloat = 1200 /*TotalView to Minus 114*/
    
    var updateDirection:UpdateDirections!
    
    var CHARGES_PARENT_VIEW_OFFSET_HEIGHT:CGFloat = 50
    
    var iTripId = ""
    var fAmount = ""
    
    var isFavSelected = false
    
    var resForPayPerson = ""
    
    var endedDeliveryTripId = ""
    var mainScreenUv:MainScreenUV!

    var signatureDisplayView:UIView!
    var signatureDisplayBGView:UIView!
    
    var senderSigPath = ""
    var vReceiverName = ""
    var senderName = ""
    var isBidding = false
    var isCollectTip = "No"
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.setnavBarTintColor(color: SColors.Theme)
            
            cntView = self.generalFunc.loadView(nibName: "RideDetailScreenDesign", uv: self, contentView: scrollView)
            
            self.scrollView.addSubview(cntView)
           
            scrollView.bounces = false
            
            scrollView.backgroundColor = SColors.ThemeTxt
            
            self.scrollView.isHidden = true

            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT)
            
            self.addBack()
            let getReceiptBtn = UIBarButtonItem(image: UIImage(named: "ic_receipt"), style: .plain, target: self, action:#selector(self.getReceiptBtnTapped))
            self.navigationItem.rightBarButtonItem = getReceiptBtn
            
            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
            blurEffectView.frame = userPicBgView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.userPicBgView.addSubview(blurEffectView)
            self.safetyRatingBar.fullStarColor = SColors.selected_rate_color
            self.safetyRatingBar.emptyStarColor = SColors.unSelected_rate_color
            self.safetyRatingBar.delegate = self

            self.tripRatingBar.fullStarColor = SColors.selected_rate_color
            self.tripRatingBar.emptyStarColor = SColors.unSelected_rate_color
            self.tripRatingBar.delegate = self
            self.scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
            GeneralFunctions.setImgTintColor(imgView: helpImgView, color: SColors.Theme)
            
            
        }else if(type == 1){
            PAGE_HEIGHT = 1200
            getDtata()
            self.configRTL()
//            paymentTypeView.shadowColor = UIColor.lightGray
//            paymentTypeView.shadowOffset = CGSize(width: 0, height: -10)
//            paymentTypeView.shadowRadius = 0.5
//            paymentTypeView.shadowOpacity = 0.5
//            paymentTypeView.masksToBounds = false
        }else if(type == 2){
            self.navigationController?.navigationBar.layer.zPosition = -1
            self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
        }else if(type == 3){
            self.navigationController?.navigationBar.layer.zPosition = 1
        }
    }
    
    
    func getDtata(){
        scrollView.isHidden = true
        
        /*tripStatusView.isHidden = true
        paymentTypeView.isHidden = true
        helpImgView.isHidden = true*/
        var parameters = NSDictionary()
        if isBidding {
            parameters = ["type": "displayFareBiddingService", "UserType": Utils.appUserType, "memberId": GeneralFunctions.getMemberd(), "iBiddingPostId": iTripId]
        }else{
        parameters = ["type": "getMemberBookings", "UserType": Utils.appUserType, "memberId": GeneralFunctions.getMemberd(), "iTripId": iTripId]
        
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters as! [String : String], currentView: self.view, isOpenLoader: true)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                   
                      if self.isBidding {
                        let dateTemp  = dataDict.dictOf(Utils.message_str)
                         self.tripDetailDict = dateTemp
                         self.setData(tripDetailDict: dateTemp)
                    // let dateTemp = dataDict.getO(Utils.message_str)
                      } else{
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    let dataTemp = dataArr[0] as! NSDictionary
                   
                  self.tripDetailDict = dataTemp
                          if dataTemp.dictOf(Utils.message_str).get("ENABLE_TIP_MODULE").uppercased()  == "YES" {
                              self.setTipView()
                          }else{
                              self.tipMainView.isHidden = true
                              self.tipMainViewHeight.constant = 0
                          }
                    if(dataTemp.dictOf(Utils.message_str).get("ShowSafetyRating").uppercased() == "YES"){
                        
                            self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING_TXT")
                       
                                            self.ufxRatingBar.isHidden = true
                                            self.safetyRatingView.isHidden = false
                                            self.safetyRatingCloseView.handleClick { (instance) in
                                                self.performSwipeAction()
                                            }
                                            self.ratingSLbl.isHidden = false
                                       }
                    self.setData(tripDetailDict: dataTemp)
                      }
                    /*for i in 0 ..< dataArr.count{
                    }*/
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }

            self.scrollView.isHidden = false
        })
    }
    
    func setData(tripDetailDict:NSDictionary){

        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIPT_HEADER_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIPT_HEADER_TXT")
        
        self.userHeaderView.backgroundColor = SColors.ThemeTxt
        
        self.thanksView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.thanksView.layer.roundCorners(radius: 10)
        
        self.chargesParentView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.chargesParentView.layer.roundCorners(radius: 10)
        
        self.shadowOnview(view: self.ratingView)
        self.shadowOnview(view: self.chargesParentView)
        self.shadowOnview(view: self.chargesDataContainerView)
        self.shadowOnview(view: self.addressContainerView)
        self.shadowOnview(view: self.thanksView)
        self.shadowOnview(view: self.senderLocationView)
        self.shadowOnview(view: self.deliveryDetailsView)
        self.shadowOnview(view: self.shadowView)
        self.deliveryDetailsView.backgroundColor = UIColor(hex: 0xf6f6f6)
        self.tipView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.tipView.layer.roundCorners(radius: 10)

        //self.senderLocationView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.senderLocationView.layer.roundCorners(radius: 10)
        
//        self.deliveryDetailsView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
//        self.deliveryDetailsView.layer.roundCorners(radius: 10)
        
        
        GeneralFunctions.setImgTintColor(imgView: self.ratingImgView, color: UIColor(hex: 0xFBB100))
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            //self.paymentTypeView.roundTo(corners: [.topLeft, .topRight], radius: 15.0)
//            self.paymentTypeView.clipsToBounds = true
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if(Configurations.isIponeXDevice()){
                self.tripStatusView.roundTo(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], radius: 15.0)
                self.tripStatusView.clipsToBounds = true
            }else{
                self.tripStatusView.roundTo(corners: [.bottomLeft, .bottomRight, .topRight, .topLeft], radius: 15.0)
                self.tripStatusView.clipsToBounds = true
            }
        }
        
        self.tripStatusView.backgroundColor = SColors.Theme
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        userPicImgView.sd_setImage(with: URL(string: tripDetailDict.get("vImage")), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
       // Utils.createRoundedView(view: userPicImgView, borderColor: UIColor.white, borderWidth: 1)
        
        let driverDetails = tripDetailDict.dictOf("DriverDetails")

        let userNameHStr = self.generalFunc.getLanguageLabel(origValue: "", key: self.tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver || self.tripDetailDict.get("eType") == "Multi-Delivery" ? "LBL_CARRIER" : (self.tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_SERVICE_PROVIDER_TXT" : "LBL_DRIVER")).capitalized
        
        self.userNameVLbl.text = String(format: "%@ %@ (%@)", driverDetails.get("vName").capitalized, driverDetails.get("vLastName").capitalized, userNameHStr)
//        self.ratingBar.fullStarColor = SColors.selected_rate_color
//        self.ratingBar.emptyStarColor = SColors.unSelected_rate_color

        self.ratingBar.rating = GeneralFunctions.parseFloat(origValue: 0.0, data: tripDetailDict.get("TripRating"))
        self.ratingLbl.text = tripDetailDict.get("TripRating")
        if tripDetailDict.get("TripRating") == "0" || tripDetailDict.get("TripRating") == "0.0"{
            self.ratingLbl.text = ""
            self.ratingImgView.isHidden = true
        }
//        self.thanksHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType").uppercased() == Utils.cabGeneralType_Deliver.uppercased() || tripDetailDict.get("eType") == "Multi-Delivery" ? "LBL_THANKS_DELIVERY_TXT" : (tripDetailDict.get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() ? "LBL_THANKS_JOB_TXT" : "LBL_THANKS_RIDING_TXT")).capitalized
        
        
     
        var driverhVal = ""
        var noVal = ""
        
        if ( self.tripDetailDict.get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased()) {
            // headerLable = generalFunc.retrieveLangLBl("", "LBL_THANKS_UFX_DRIVER");
            self.thanksHLbl.text = generalFunc.getLanguageLabel(origValue:"", key: "LBL_THANKS_TXT");
            noVal = generalFunc.getLanguageLabel(origValue:"", key: "LBL_SERVICES") + "#";
            driverhVal = generalFunc.getLanguageLabel(origValue:"",key:  "LBL_SERVICE_PROVIDER_TXT");
        } else if (self.tripDetailDict.get("eType").uppercased() == "Deliver".uppercased() || self.tripDetailDict.get("eType").uppercased() == Utils.cabGeneralType_Multi_Delivery.uppercased()) {
            // headerLable = generalFunc.retrieveLangLBl("", "LBL_THANKS_DELIVERY_DRIVER");
            self.thanksHLbl.text = generalFunc.getLanguageLabel(origValue:"",key:  "LBL_THANKS_TXT");
            noVal = generalFunc.getLanguageLabel(origValue:"",key:  "LBL_DELIVERY") + "#";
            driverhVal = generalFunc.getLanguageLabel(origValue:"",key:  "LBL_CARRIER");
        } else {
            // headerLable = generalFunc.retrieveLangLBl("", "LBL_THANKS_RIDING_DRIVER");
            self.thanksHLbl.text = generalFunc.getLanguageLabel(origValue:"", key: "LBL_THANKS_TXT");
            noVal = generalFunc.getLanguageLabel(origValue:"",key:  "LBL_RIDE") + "# ";
            driverhVal = generalFunc.getLanguageLabel(origValue:"", key: "LBL_DRIVER");
        }
       self.rideNoLbl.text = "\(noVal) \(Configurations.convertNumToAppLocal(numStr: tripDetailDict.get("vRideNo")))"
       self.userNameVLbl.text = driverDetails.get("vName").capitalized + " " + driverDetails.get("vLastName").capitalized + " (\(driverhVal))"
 
        self.tripReqDateVLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: tripDetailDict.get("tTripRequestDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime).uppercased()
        
        self.pickUpLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ? "Sender's Location" : "PickUp Location", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ? "LBL_SENDER_LOCATION" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_JOB_LOCATION_TXT" : "LBL_PICKUP_LOCATION_TXT")).uppercased()
        
        self.destLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ? "LBL_DELIVERY_DETAILS_TXT" : "LBL_DEST_LOCATION").uppercased()
        
        self.chargesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHARGES_TXT")
        
        let tSaddress = tripDetailDict.dictOf(Utils.message_str).get("tSaddress").trim()
        let tDAddress = tripDetailDict.dictOf(Utils.message_str).get("tDaddress").trim()

        let sourceAddHeight = tripDetailDict.get("tSaddress").height(withConstrainedWidth: Application.screenSize.width - 90, font: UIFont(name: Fonts().regular, size: 14)!)
        let destAddHeight = tripDetailDict.get("tDaddress").height(withConstrainedWidth: Application.screenSize.width - 90, font: UIFont(name: Fonts().regular, size: 14)!)

        self.pickUpLocVLbl.text = tSaddress //tripDetailDict.get("tSaddress")
        
        if(tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver){
            
            self.addressContainerViewHeight.constant = 0
            self.addressContainerViewTopMargin.constant = -15
            self.addressContainerView.isHidden = true
            
            self.senderLocationView.isHidden = false
            self.senderLocHLbl.isHidden = false
            
            self.senderLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SENDER_LOCATION")
            self.senderLocVLbl.text = tDAddress == "" ? "----" :  tDAddress
            self.senderLocVLbl.numberOfLines = 0
            
            let senderLocHeight = tripDetailDict.get("tDaddress").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont(name: Fonts().regular, size: 14)!) - 20

            self.senderLocationViewHeight.constant = self.senderLocationViewHeight.constant + senderLocHeight
            
            self.deliveryDetailsHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Delivery Details", key: "LBL_DELIVERY_DETAILS")
            
            let deliveryDetailVStr = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIVER_NAME")): \(tripDetailDict.get("vReceiverName"))\n\n\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIVER_LOCATION")): \(tripDetailDict.get("tDaddress"))\n\n\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PACKAGE_TYPE_TXT")): \(tripDetailDict.get("PackageType"))\n\n\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PACKAGE_DETAILS")): \(tripDetailDict.get("tPackageDetails"))"
            
            self.deliveryDetailsVLbl.text = deliveryDetailVStr.uppercased()
            
            self.deliveryDetailsViewHeight.constant = self.deliveryDetailsViewHeight.constant + deliveryDetailVStr.height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont(name: Fonts().regular, size: 14)!)
            
            self.PAGE_HEIGHT = (self.PAGE_HEIGHT + self.senderLocationViewHeight.constant + self.deliveryDetailsViewHeight.constant) - 130 /*AddressContainerView Releted Minus Height*/
            
            self.deliveryDetailsVLbl.fit()
            
        }else if(tripDetailDict.get("eType") == "Multi-Delivery"){
            
            self.addressContainerViewHeight.constant = 0
            self.addressContainerViewTopMargin.constant = -15
            self.addressContainerView.isHidden = true
            
            self.deliveryDetailsViewHeight.constant = 0
            self.deliveryDetailsViewTopMargin.constant = 0
            self.deliveryDetailsHLblTopMargin.constant = 0
            self.deliveryDetailsHLblHeight.constant = 0
            
            self.deliveryDetailsView.isHidden = true
            self.deliveryDetailsHLbl.isHidden = true
            
            self.senderLocationView.isHidden = false
            self.senderLocHLbl.isHidden = false
            
            self.senderLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SENDER_LOCATION")
            self.senderLocVLbl.text = tDAddress == "" ? "----" :  tDAddress
            self.senderLocVLbl.numberOfLines = 0
            
            let senderLocHeight = tripDetailDict.get("tDaddress").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont(name: Fonts().regular, size: 14)!) - 20
            self.senderLocationViewHeight.constant = self.senderLocationViewHeight.constant + senderLocHeight
            
            self.PAGE_HEIGHT = (self.PAGE_HEIGHT + self.senderLocationViewHeight.constant) - 140 //- 50 /*AddressContainerView & DeliveryDetailsView Releted Minus Height*/
            
        } else if isBidding {
            
            self.thanksHLbl.text = generalFunc.getLanguageLabel(origValue:"", key: "LBL_THANKS_BIDING_SERVICE_TXT")
            self.rideNoLbl.text = generalFunc.getLanguageLabel(origValue:"", key: "LBL_TASK_TXT") + " #" + tripDetailDict.get("vBiddingPostNo")
            self.userNameVLbl.text = tripDetailDict.get("driverName")
            self.ratingBar.rating = GeneralFunctions.parseFloat(origValue: 0.0, data: tripDetailDict.get("driverAvgRating"))
            self.ratingLbl.text = tripDetailDict.get("driverAvgRating")
            self.pickUpLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_SERVICE_ADDRESS_TXT").capitalized
            self.tripReqDateVLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: tripDetailDict.get("dBiddingDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime).uppercased()
            userPicImgView.sd_setImage(with: URL(string: tripDetailDict.get("driverImage")), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            })
            self.addressContainerViewHeight.constant = 0
            self.addressContainerViewTopMargin.constant = 0
            self.addressContainerView.isHidden = true
            self.senderLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_SERVICE_ADDRESS_TXT")
            self.senderLocVLbl.text = tripDetailDict.get("tSaddress")
            self.senderLocVLbl.numberOfLines = 0
            let senderLocHeight = tripDetailDict.get("tDaddress").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont(name: Fonts().regular, size: 14)!) - 20

            self.senderLocationViewHeight.constant = self.senderLocationViewHeight.constant + senderLocHeight + 40
        self.PAGE_HEIGHT = (self.PAGE_HEIGHT + self.senderLocationViewHeight.constant) - 140
        self.deliveryDetailsViewHeight.constant = 0
        self.deliveryDetailsViewTopMargin.constant = 0
        self.deliveryDetailsHLblTopMargin.constant = 0
        self.deliveryDetailsHLblHeight.constant = 0
        
        self.deliveryDetailsView.isHidden = true
        self.deliveryDetailsHLbl.isHidden = true
        self.paymentTypeLbl.textColor = SColors.Theme
        
    }
        else{
            self.senderLocationViewTopMargin.constant = 00
            self.senderLocationViewHeight.constant = 0
            self.senderLocLblHeight.constant = 0
            self.senderLocLblTopMargin.constant = 0
            self.senderLocationView.isHidden = true
            self.senderLocHLbl.isHidden = true
            
            self.deliveryDetailsViewHeight.constant = 0
            self.deliveryDetailsViewTopMargin.constant = 0
            self.deliveryDetailsHLblTopMargin.constant = 0
            self.deliveryDetailsHLblHeight.constant = 0
            self.deliveryDetailsView.isHidden = true
            self.deliveryDetailsHLbl.isHidden = true

            self.destLocVLbl.text = tDAddress == "" ? "----" :  tDAddress //tripDetailDict.get("tDaddress") == "" ? "----" :  tripDetailDict.get("tDaddress")
          
            self.addressContainerViewHeight.constant = 71 + sourceAddHeight + destAddHeight

            if(tDAddress.trim() == ""){
                self.destLocHLbl.isHidden = true
                self.destLocVLbl.isHidden = true
                self.destLocVLbl.text = ""
                self.destLocVLbl.fit()
                self.dashedView.isHidden = true
                self.destLocView.isHidden = true
                self.addressContainerViewHeight.constant = sourceAddHeight + 40
            }
            self.PAGE_HEIGHT = (self.PAGE_HEIGHT + self.addressContainerViewHeight.constant) - 215 //165 /*SenderLocationView Releted Minus Height*/
        }
        
        self.pickUpLocVLbl.fit()
        self.destLocVLbl.fit()
        
        self.dashedView.backgroundColor = UIColor.clear
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.dashedView.createDashedLine(color: UIColor(hex: 0x141414), lineWidth: 2, true)
        })
        
        self.resForPayPerson = tripDetailDict.get("PaymentPerson")
        
        if(tripDetailDict.get("eType") == "Multi-Delivery"){
            self.paymentTypeLblTopMargin.constant = 18
            
            if(self.tripDetailDict.get("vTripPaymentMode") == "Cash"){
                if(tripDetailDict.get("iActive") == "Cancelled"){
                    self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_PAYMENT_TXT").uppercased()
                    self.paymentTypeReasonLbl.isHidden = true
                }else{
                    self.paymentTypeLblTopMargin.constant = 12
                    self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_PAYMENT_TXT").uppercased()
                    self.paymentTypeReasonLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_BY_TXT") + " " + resForPayPerson
                    self.paymentTypeReasonLbl.isHidden = false
                    
                }
                self.payImgView.image = UIImage(named: "ic_cash_new")!
            }else{
                /* PAYMENT FLOW CHANGES */
                if(self.tripDetailDict.get("ePayWallet").uppercased() != "YES"){
                   
                    if (tripDetailDict.get("iActive") == "Cancelled"){
                        self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT").uppercased()
                        self.paymentTypeReasonLbl.isHidden = true
                    }else{
                        self.paymentTypeLblTopMargin.constant = 12
                        self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT").uppercased()
                        self.paymentTypeReasonLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_BY_TXT") + " " + resForPayPerson
                        self.paymentTypeReasonLbl.isHidden = false
                    }
                    self.payImgView.image = UIImage(named: "ic_card_new")!
                }else{
                    if(tripDetailDict.get("iActive") == "Cancelled"){
                        self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA_WALLET").uppercased()
                        self.paymentTypeReasonLbl.isHidden = true
                    }else{
                        self.paymentTypeLblTopMargin.constant = 12
                        self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA_WALLET").uppercased()
                        self.paymentTypeReasonLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_BY_TXT") + " " + resForPayPerson
                        self.paymentTypeReasonLbl.isHidden = false
                        
                    }
                    self.payImgView.image = UIImage(named: "ic_wallet_pay")!
                }/*.........*/
                
            }
        }else{
            self.paymentTypeLblTopMargin.constant = 18
            self.paymentTypeReasonLbl.isHidden = true
            
            if(tripDetailDict.get("vTripPaymentMode") == "Cash"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_PAYMENT_TXT").uppercased()
                self.payImgView.image = UIImage(named: "ic_cash_new")!
            }else if(tripDetailDict.get("vTripPaymentMode") == "Organization"){
                self.paymentTypeLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_BY_TXT").uppercased()) \(tripDetailDict.get("OrganizationName"))"
                self.payImgView.image = UIImage(named: "ic_sel_organization")!
            }else if(tripDetailDict.get("vTripPaymentMode") == "Card"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT").uppercased()
                self.payImgView.image = UIImage(named: "ic_card_new")!
            }else{
                self.paymentTypeLbl.text = "--"
                self.payImgView.image = UIImage(named: "ic_card_new")!
            }
            
            /* PAYMENT FLOW CHANGES */
            if(tripDetailDict.get("ePayWallet").uppercased() == "YES"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA_WALLET").uppercased()
                self.payImgView.image = UIImage(named: "ic_wallet_pay")!
                
            }/*.........*/
        }
        
        self.orgTripReasonLbl.text = tripDetailDict.get("vReasonTitle")

        self.viewMoreServicesLbl.layer.shadowOpacity = 0.5
        self.viewMoreServicesLbl.layer.shadowRadius = 2.5
        self.viewMoreServicesLbl.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.viewMoreServicesLbl.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewMoreServicesLbl.backgroundColor = UIColor(hex: 0xf6f6f6)
        Utils.createRoundedView(view: self.viewMoreServicesLbl, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        if((tripDetailDict.get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() && userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER") || (tripDetailDict.get("eType") == "Multi-Delivery")){
            self.viewMoreServicesLblHeight.constant = 45
            self.viewMoreServicesLbl.isHidden = false
            
            if(tripDetailDict.get("eType") == "Multi-Delivery"){
                self.viewMoreServicesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_DELIVERY_DETAILS")
            }else{
                self.viewMoreServicesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_REQUESTED_SERVICES")
            }

            self.viewMoreServicesLbl.textColor = SColors.Theme
            
            self.viewMoreServicesLbl.setClickHandler { (Instance) in
                if(tripDetailDict.get("eType") == "Multi-Delivery"){
                    let multiDeliveryListUV = GeneralFunctions.instantiateViewController(pageName: "MultiDeliveryListUV") as! MultiDeliveryListUV
                    multiDeliveryListUV.iTripID = tripDetailDict.get("iTripId")
                    self.push(uv: multiDeliveryListUV)

                }else{
                    let viewMoreServiceUV = GeneralFunctions.instantiateViewController(pageName: "UFXProviderViewMoreServicesUV") as! UFXProviderViewMoreServicesUV
                    viewMoreServiceUV.iTripID = tripDetailDict.get("iTripId")
                    self.push(uv: viewMoreServiceUV)
                }
            }
        }else{
            self.viewMoreServicesLbl.isHidden = true
            self.viewMoreServicesLblHeight.constant = 0
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 45 /*viewMoreServicesLbl Releted Minus Height*/
        }
        
        self.vehicleTypeLbl.text = tripDetailDict.get("vServiceDetailTitle")
        
        let vTypeNameHeight = self.vehicleTypeLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 19)!) - 25
        self.CHARGES_PARENT_VIEW_OFFSET_HEIGHT = self.CHARGES_PARENT_VIEW_OFFSET_HEIGHT + vTypeNameHeight
        self.vehicleTypeLbl.textAlignment = .left
        
        var tripStatus = tripDetailDict.get("iActive")
       
        if(tripStatus == "Cancelled"){
            if(tripDetailDict.get("eCancelledBy").uppercased() == "DRIVER"){
                self.tripStatusLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ? "LBL_PREFIX_DELIVERY_CANCEL_DRIVER_TXT" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_PREFIX_JOB_CANCEL_PROVIDER_TXT" : "LBL_PREFIX_TRIP_CANCEL_DRIVER_TXT")).uppercased()
                self.tripStatusLbl.numberOfLines = 0
                
                let tripStatusHeight = self.tripStatusLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
                
                self.tripCancelReasonLbl.text = tripDetailDict.get("vCancelReason")
                self.tripCancelReasonLbl.numberOfLines = 0
                
                let tripCancelReasonHeight = self.tripCancelReasonLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().regular, size: 14)!) //- 17
                
                self.tripSatusViewHeight.constant = 35 + tripStatusHeight + tripCancelReasonHeight
            }else{
                self.tripStatusLbl.text = self.generalFunc.getLanguageLabel(origValue: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "" : "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "LBL_CANCELED_DELIVERY_TXT" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_CANCELED_JOB" : "LBL_CANCELED_TRIP_TXT")).uppercased()
               self.tripStatusLbl.numberOfLines = 0
                
                self.tripCancelReasonLbl.text = ""
                self.tripCancelReasonLbl.isHidden = true
                
                let tripStatusHeight = self.tripStatusLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
                self.tripSatusViewHeight.constant = 35 + tripStatusHeight

            }

            self.navigationItem.rightBarButtonItem = nil

        }else if(tripStatus == "Finished"){
            self.tripStatusLbl.text = self.generalFunc.getLanguageLabel(origValue: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "This delivery was successfully finished" : "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "LBL_FINISHED_DELIVERY_TXT" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_FINISHED_JOB_TXT" : "LBL_FINISHED_TRIP_TXT")).uppercased()
            self.tripStatusLbl.numberOfLines = 0
            
            if tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ||  tripDetailDict.get("eType") == Utils.cabGeneralType_Multi_Delivery {
                self.tripStatusLbl.text = self.generalFunc.getLanguageLabel(origValue: "" , key: "LBL_FINISHED_DELIVERY_TXT"  ).uppercased()
            }
            self.tripCancelReasonLbl.text = ""
            self.tripCancelReasonLbl.isHidden = true
            
            let tripStatusHeight = self.tripStatusLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
            self.tripSatusViewHeight.constant = 35 + tripStatusHeight

            if(tripDetailDict.get("tEndLat") != "" && tripDetailDict.get("tEndLong") != "" && (tripDetailDict.get("eType") != Utils.cabGeneralType_UberX || tripDetailDict.get("eFareType") == "Regular")){
                drawRoute()
            }
        }else{
            self.tripStatusLbl.text = tripStatus
            self.tripStatusLbl.numberOfLines = 0
            
            self.tripCancelReasonLbl.text = ""
            self.tripCancelReasonLbl.isHidden = true
            
            let tripStatusHeight = self.tripStatusLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
            self.tripSatusViewHeight.constant = 35 + tripStatusHeight
        }
        
        if isBidding {
            let tripStatus = tripDetailDict.get("eStatus")
            if tripStatus == "Completed" {
                self.tripStatusLbl.text = self.generalFunc.getLanguageLabel(origValue: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "This delivery was successfully finished" : "", key: "LBL_FINISHED_TASK_TXT")
            }
            self.paymentTypeLblTopMargin.constant = 18
            self.paymentTypeReasonLbl.isHidden = true
            
            if(tripDetailDict.get("vBiddingPaymentMode") == "Cash"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_PAYMENT_TXT").uppercased()
                self.payImgView.image = UIImage(named: "ic_cash_new")!
            }else if(tripDetailDict.get("vBiddingPaymentMode") == "Organization"){
                self.paymentTypeLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_BY_TXT").uppercased()) \(tripDetailDict.get("OrganizationName"))"
                self.payImgView.image = UIImage(named: "ic_sel_organization")!
            }else if(tripDetailDict.get("vBiddingPaymentMode") == "Card"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD_PAYMENT").uppercased()
                self.payImgView.image = UIImage(named: "ic_card_new")!
            }else if(tripDetailDict.get("vBiddingPaymentMode") == "Wallet"){
                self.paymentTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA_WALLET").uppercased()
                self.payImgView.image = UIImage(named: "ic_wallet_pay")!
            }
            else{
                self.paymentTypeLbl.text = "--"
                self.payImgView.image = UIImage(named: "ic_card_new")!
            }
        }
        GeneralFunctions.setImgTintColor(imgView: self.payImgView, color: SColors.Theme)
        
        var bounds = GMSCoordinateBounds()
        
        let sourceMarker = GMSMarker()
        sourceMarker.position = (CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tStartLat")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tStartLong")))).coordinate
        sourceMarker.icon = UIImage(named: "ic_source_marker")!
        
        sourceMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        sourceMarker.map = self.gMapView
        
        bounds = bounds.includingCoordinate(sourceMarker.position)
        
        if(tripDetailDict.get("tEndLat") != ""){
            let destMarker = GMSMarker()
            destMarker.position = (CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tEndLat")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tEndLong")))).coordinate
            destMarker.icon = UIImage(named: "ic_destination_place_image")!

            destMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            destMarker.map = self.gMapView
            
            bounds = bounds.includingCoordinate(destMarker.position)
        }
        
        if(tripDetailDict.get("eHailTrip") == "Yes"){
            self.userHeaderView.isHidden = true
            self.userHeaderViewHeight.constant = 0
            self.thanksViewTopMargin.constant = 0
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 178 /*UserHeaderView Releted Minus Height*/
        }
        
        if(tripDetailDict.get("fTipPrice") != "" && tripDetailDict.get("fTipPrice") != "0" && tripDetailDict.get("fTipPrice") != "0.00"){
            self.tipAmountLbl.text = Configurations.convertNumToAppLocal(numStr: tripDetailDict.get("fTipPrice"))
            self.tipInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_TIP_INFO_SHOW_USER" : (tripDetailDict.get("eType") == Utils.cabGeneralType_Ride ? "LBL_TIP_INFO_SHOW_RIDER" : "LBL_TIP_INFO_SHOW_DELIVERY"))
            self.tipHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT")
            self.tipViewHeight.constant = self.tipViewHeight.constant + (self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_TIP_INFO_SHOW_USER" : (tripDetailDict.get("eType") == Utils.cabGeneralType_Ride ? "LBL_TIP_INFO_SHOW_RIDER" : "LBL_TIP_INFO_SHOW_DELIVERY")).height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().regular, size: 16)!) - 20)
            
                self.tipViewHeight.constant = self.tipViewHeight.constant + (self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_TIP_INFO_SHOW_USER" : (tripDetailDict.get("eType") == Utils.cabGeneralType_Ride ? "LBL_TIP_INFO_SHOW_RIDER" : "LBL_TIP_INFO_SHOW_DELIVERY")).height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().regular, size: 16)!) - 20)
            if self.tipViewHeight.constant < 100 {
                self.tipViewHeight.constant = 105
            }
                self.tipInfoLbl.fit()
                self.tipTopPlusLbl.text = "+"
                self.tipView.isHidden = false
                self.tipViewTopMargin.constant = 50
                self.PAGE_HEIGHT = (self.PAGE_HEIGHT + self.tipViewHeight.constant)
            
            //- 80 /*TipView Releted Minus Height*/
        }else{
            self.tipView.isHidden = true
            self.tipViewHeight.constant = 0
            self.tipViewTopMargin.constant = 0
            self.tipTopPlusLbl.text = ""
            self.tipTopPlusLbl.fit()
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 127 /*TipView Releted Minus Height*/
        }
        
        if(tripDetailDict.get("vBeforeImage") != "" || tripDetailDict.get("vAfterImage") != "" ){
            self.serviceImageAreaView.isHidden = false
            self.serviceAreaTopMargine.constant = 10
            self.beforeServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BEFORE_SERVICE")
            self.afterServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AFTER_SERVICE")
            
            let vBeforeImage = Utils.getResizeImgURL(imgUrl: tripDetailDict.get("vBeforeImage"), width: Utils.getValueInPixel(value: 100), height: Utils.getValueInPixel(value: 90))
            let vAfterImage = Utils.getResizeImgURL(imgUrl: tripDetailDict.get("vAfterImage"), width: Utils.getValueInPixel(value: 100), height: Utils.getValueInPixel(value: 90))
            beforeServiceImgView.cornerRadius = 10
            beforeServiceImgView.masksToBounds = true
            afterServiceImgView.cornerRadius = 10
            afterServiceImgView.masksToBounds = true
            beforeServiceImgView.sd_setImage(with: URL(string: vBeforeImage), placeholderImage: UIImage(named: "ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            afterServiceImgView.sd_setImage(with: URL(string: vAfterImage), placeholderImage: UIImage(named: "ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            if(tripDetailDict.get("vBeforeImage") == ""){
                self.beforeServiceImgArea.isHidden = true
                self.serviceAreaCenterViewOffset.constant = -60
            }
            
            if(tripDetailDict.get("vAfterImage") == ""){
                self.afterServiceImgArea.isHidden = true
                self.serviceAreaCenterViewOffset.constant = 60
            }
            
            let beforeTapGue = UITapGestureRecognizer()
            let afterTapGue = UITapGestureRecognizer()
            
            beforeTapGue.addTarget(self, action: #selector(self.openBeforeImage))
            afterTapGue.addTarget(self, action: #selector(self.openAfterImage))
            
            self.beforeServiceImgArea.isUserInteractionEnabled = true
            self.beforeServiceImgArea.addGestureRecognizer(beforeTapGue)
            
            self.afterServiceImgArea.isUserInteractionEnabled = true
            self.afterServiceImgArea.addGestureRecognizer(afterTapGue)
            
        }else{
            self.serviceImageAreaHeight.constant = 0
            self.serviceAreaTopMargine.constant = 0
            self.serviceImageAreaView.isHidden = true
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 150 /*ServiceImageView Releted Minus Height*/
        }
        
        self.commentTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Provide your feedback.", key: "LBL_WRITE_COMMENT_HINT_TXT")
        self.commentTxtView.layer.borderColor = UIColor(hex: 0xdedede).cgColor
        self.commentTxtView.layer.borderWidth = 1.5
        self.commentTxtView.layer.cornerRadius = 5
        self.commentTxtView.clipsToBounds = true
        
//        if(tripDetailDict.get("is_rating") == "No" && tripStatus == "Finished"){
//            self.ratingView.isHidden = false
//
//            if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
//                self.ufxRatingBar.delegate = self
//                self.ufxRatingBar.fullStarColor = SColors.selected_rate_color
//                self.ufxRatingBar.emptyStarColor = SColors.unSelected_rate_color
//
//                self.favHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAVE_AS_FAV_DRIVER")
//                self.favSwitch.dotColor = UIColor(hex: 0xFF0000)
//                self.favSwitch.isUserInteractionEnabled = true
//                self.favSwitch.color = UIColor(hex: 0xFFFFFF)
//                self.favSwitch.tintColor = UIColor(hex: 0xFFFFFF)
//                self.favSwitch.layer.borderColor = UIColor(hex: 0xdedede).cgColor
//                self.favSwitch.layer.borderWidth = 1
//                self.favSwitch.layer.cornerRadius = favSwitch.frame.height / 2
//                self.favSwitch.delegate = self
//            }else{
//                self.ratingViewHeight.constant = 207 /*RatinvViewHeight Set when ENABLE_FAVORITE_DRIVER_MODULE - Yes/No */
//                self.favContainerView.isHidden = true
//                self.favContainerViewHeight.constant = 0
//                self.PAGE_HEIGHT = self.PAGE_HEIGHT - 45 /*FavoriteDriver Releted Minus Height*/
//            }
//            self.ratingHintLbl.isHidden = false
//            self.ratingHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_RATE_HEADING_PROVIDER" : (tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver || tripDetailDict.get("eType") == "Multi-Delivery" ? "LBL_RATE_HEADING_CARRIER" : "LBL_RATE_HEADING_DRIVER")).trim()
//
//            self.submitRatingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE"))
//            self.submitRatingBtn.clickDelegate = self
//        }else{
//            self.ratingHintLbl.isHidden = true
//            self.ratingViewHeight.constant = 0
//            self.ratingView.isHidden = true
//            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 305 /*RatingView Releted Minus Height*/
//        }
        if isBidding{
            if tripDetailDict.get("is_rating") == "No" &&  tripDetailDict.get("vTaskStatus") == "Finished" {
                self.ratingView.isHidden = false
                
                if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
                    self.ufxRatingBar.delegate = self
                    self.ufxRatingBar.fullStarColor = SColors.selected_rate_color
                    self.ufxRatingBar.emptyStarColor = SColors.unSelected_rate_color

//                    self.favHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAVE_AS_FAV_DRIVER")
//                    self.favSwitch.dotColor = UIColor(hex: 0xFF0000)
//                    self.favSwitch.isUserInteractionEnabled = true
//                    self.favSwitch.color = UIColor(hex: 0xFFFFFF)
//                    self.favSwitch.tintColor = UIColor(hex: 0xFFFFFF)
//                    self.favSwitch.layer.borderColor = UIColor(hex: 0xdedede).cgColor
//                    self.favSwitch.layer.borderWidth = 1
//                    self.favSwitch.layer.cornerRadius = favSwitch.frame.height / 2
//                    self.favSwitch.delegate = self
                    self.textViewTop.constant = -25
                    self.favContainerView.isHidden = true
                    self.favContainerViewHeight.constant = 0
                    self.ratingViewHeight.constant = 207
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT + 45
                }else{
                    self.ratingViewHeight.constant = 207 /*RatinvViewHeight Set when ENABLE_FAVORITE_DRIVER_MODULE - Yes/No */
                    self.favContainerView.isHidden = true
                    self.favContainerViewHeight.constant = 0
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT + 45 /*FavoriteDriver Releted Minus Height*/
                }
                self.ratingHintLbl.isHidden = false
                self.ratingHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_RATE_HEADING_DRIVER_TXT")

                self.submitRatingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE"))
                self.submitRatingBtn.clickDelegate = self
            }else{
                self.ratingHintLbl.isHidden = true
                self.ratingViewHeight.constant = 0
                self.ratingView.isHidden = true
                self.PAGE_HEIGHT = self.PAGE_HEIGHT - 305 /*RatingView Releted Minus Height*/
            }
        }else{
            if(tripDetailDict.get("is_rating") == "No" && tripStatus == "Finished"){
                self.ratingView.isHidden = false
                
                if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
                    self.ufxRatingBar.delegate = self
                    self.ufxRatingBar.fullStarColor = SColors.selected_rate_color
                    self.ufxRatingBar.emptyStarColor = SColors.unSelected_rate_color

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
                    self.ratingViewHeight.constant = 220 /*RatinvViewHeight Set when ENABLE_FAVORITE_DRIVER_MODULE - Yes/No */
                    self.favContainerView.isHidden = true
                    self.favContainerViewHeight.constant = 0
                    self.PAGE_HEIGHT = self.PAGE_HEIGHT - 30 /*FavoriteDriver Releted Minus Height*/
                }
                self.ratingHintLbl.isHidden = false
                self.ratingHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_RATE_HEADING_PROVIDER" : (tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver || tripDetailDict.get("eType") == "Multi-Delivery" ? "LBL_RATE_HEADING_CARRIER" : "LBL_RATE_HEADING_DRIVER")).trim()

                self.submitRatingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE"))
                self.submitRatingBtn.clickDelegate = self
            }else{
                self.ratingHintLbl.isHidden = true
                self.ratingViewHeight.constant = 0
                self.ratingView.isHidden = true
                self.PAGE_HEIGHT = self.PAGE_HEIGHT - 305 /*RatingView Releted Minus Height*/
            }
        }
        if(tripDetailDict.get("eFavDriver").uppercased() == "YES" && userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
            self.favSwitch.configSwitchState(true, animated: false)
            self.isFavSelected = true
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 10)
        gMapView.animate(with: update)
        
        if(tripDetailDict.get("eChargeViewShow").uppercased() == "YES") || isBidding{
            self.addFareDetails()
        }else{
            self.userHeaderViewHeight.constant = 168 /*UserHeaderView Hieght Set When eChargeViewShow Yes/No*/
            
//            self.thanksHLbl.text = ""
            self.chargesHLbl.text = ""
            
//            self.thanksViewHeight.constant = 65
            self.rideNoLblTopMargin.constant = 0
            
            self.chargesParentViewHeight.constant = 0
            self.chargesParentView.isHidden = true
            
            self.paymentTypeView.isHidden = true
            self.paymentTypeViewHeight.constant = 0
            self.paymentTypeLbl.text = ""
            self.payImgView.isHidden = true
            
            self.viewMoreServicesTopMargin.constant = -10
            
            self.helpImgView.isHidden = true

            PAGE_HEIGHT = PAGE_HEIGHT - 55
            
            self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
        }
        if(tripDetailDict.get("eCancelled") == "Yes"){
            cancelTripReasonLBL.paddingTop = 20
            cancelTripReasonLBL.paddingBottom = 20
            cancelTripReasonLBL.numberOfLines = 0
            cancelTripReasonLBL.isHidden = false
            if tripDetailDict.get("eChargeViewShow").uppercased() == "NO" {
                cancelTripTopMargin.constant = -20
            }
            if(tripDetailDict.get("eCancelledBy").uppercased() == "DRIVER"){
                let cancelBy = self.generalFunc.getLanguageLabel(origValue: "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ? "LBL_PREFIX_DELIVERY_CANCEL_DRIVER_TXT" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_PREFIX_JOB_CANCEL_PROVIDER_TXT" : "LBL_PREFIX_TRIP_CANCEL_DRIVER_TXT")).uppercased()
                self.tripStatusLbl.numberOfLines = 0
                let tripStatusHeight = cancelBy.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
                let cancelReason = tripDetailDict.get("vCancelReason")
                self.tripCancelReasonLbl.numberOfLines = 0
                self.viewMoreServicesTopMargin.constant = 10
                let tripCancelReasonHeight = cancelReason.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().regular, size: 14)!) //- 17
                self.tripSatusViewHeight.constant = 0//35 + tripStatusHeight + tripCancelReasonHeight
                cancelTripReasonLBL.text = cancelBy + "\n" +  cancelReason
                self.PAGE_HEIGHT = self.PAGE_HEIGHT + 40 + tripStatusHeight + tripCancelReasonHeight
            }else{
               let cancelBy = self.generalFunc.getLanguageLabel(origValue: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "" : "", key: tripDetailDict.get("eType") == Utils.cabGeneralType_Deliver ?  "LBL_CANCELED_DELIVERY_TXT" : (tripDetailDict.get("eType") == Utils.cabGeneralType_UberX ? "LBL_CANCELED_JOB" : "LBL_CANCELED_TRIP_TXT")).capitalized
                self.tripStatusLbl.numberOfLines = 0
                
                self.tripCancelReasonLbl.text = ""
                self.tripCancelReasonLbl.isHidden = true
                
                let tripStatusHeight = cancelBy.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().semibold, size: 16)!) //- 19
                self.tripSatusViewHeight.constant = 0 //35 + tripStatusHeight
                cancelTripReasonLBL.text = cancelBy
                self.viewMoreServicesTopMargin.constant = 10
                self.PAGE_HEIGHT = self.PAGE_HEIGHT + 40 + tripStatusHeight
            }
            self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
        }else {
            cancelTripTopMargin.constant = -5
        }
        
        let helpTapGue = UITapGestureRecognizer()
        helpTapGue.addTarget(self, action: #selector(self.helpTapped))
        self.helpImgView.addGestureRecognizer(helpTapGue)
        self.helpImgView.isUserInteractionEnabled = true
        
        /*Signature Releted Set Data*/
        self.vReceiverName = tripDetailDict.get("vReceiverName")
        self.senderSigPath = tripDetailDict.get("vSignImage")
        self.signShowLbl.isHidden = true
        
        if(self.tripDetailDict.get("eType") == "Multi-Delivery" && self.senderSigPath != ""){
            self.signShowLbl.isHidden = false
            self.signShowLbl.cornerRadius = 5
            self.signShowLbl.clipsToBounds = true
            
            self.signShowLbl.text = self.generalFunc.getLanguageLabel(origValue: "View Sender Signature", key: "VIEW_MULTI_SENDER_SIGN")
            
            self.signShowLbl.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.signShowLbl.textColor = SColors.Theme_1

            self.signShowLbl.handleClick { (instance) in
                self.loadSignatureDisplayView()
            }
        }
        
        if(self.tripDetailDict.get("isVideoCall").uppercased() == "YES"){
            self.videoView.isHidden = false
            self.videoTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIDEO_CONSULT_AT_YOUR_LOC")
        }
        if(tripDetailDict.get("iActive") == "Canceled") || (tripDetailDict.get("iActive") == "Cancelled"){
            self.ratingBar.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
        }
       
    }
    
    func loadSignatureDisplayView(){
        let signatureDisplayView = self.generalFunc.loadView(nibName: "SignatureDisplayView", uv: self, isWithOutSize: true)
        
        self.signatureDisplayView = signatureDisplayView
        
        let width = Application.screenSize.width  > 380 ? 370 : Application.screenSize.width - 50
        
        signatureDisplayView.frame.size = CGSize(width: width, height: 200)
        
        signatureDisplayView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)

        let bgView = UIView()
        self.signatureDisplayBGView = bgView
        
        bgView.frame = CGRect(x:0, y:0, width:Application.screenSize.width, height: Application.screenSize.height)
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.4
        bgView.isUserInteractionEnabled = true
        
        signatureDisplayView.layer.shadowOpacity = 0.5
        signatureDisplayView.layer.shadowOffset = CGSize(width: 0, height: 3)
        signatureDisplayView.layer.shadowColor = UIColor.black.cgColor
        
        let currentWindow = Application.window
        
        if(currentWindow != nil){
            currentWindow?.addSubview(bgView)
            currentWindow?.addSubview(signatureDisplayView)
        }else if(self.navigationController != nil){
            self.navigationController?.view.addSubview(bgView)
            self.navigationController?.view.addSubview(signatureDisplayView)
        }else{
            self.view.addSubview(bgView)
            self.view.addSubview(signatureDisplayView)
        }
        
        bgView.alpha = 0
        signatureDisplayView.alpha = 0
        
        UIView.animate(withDuration: 0.5,delay: 0, options: .curveEaseInOut, animations: {
                bgView.alpha = 0.4
                signatureDisplayView.alpha = 1
        })
        
        Utils.createRoundedView(view: signatureDisplayView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)

        (signatureDisplayView.subviews[2]).backgroundColor = UIColor(hex: 0xe6e6e6)
        (signatureDisplayView.subviews[2]).cornerRadius = 10.0
        (signatureDisplayView.subviews[2]).borderWidth = 0.5
        (signatureDisplayView.subviews[2]).borderColor = UIColor(hex: 0xd9d9da)

        (signatureDisplayView.subviews[0] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SENDER_SIGN")
        
        (signatureDisplayView.subviews[1] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECIPIENT_NAME_HEADER_TXT") + " " + ":" + " " + self.vReceiverName
        (signatureDisplayView.subviews[1] as! MyLabel).isHidden = true

        ((signatureDisplayView.subviews[2]).subviews[0]).borderWidth = 0.5
        ((signatureDisplayView.subviews[2]).subviews[0]).borderColor = UIColor(hex: 0xd9d9da)
        ((signatureDisplayView.subviews[2]).subviews[0].subviews[0] as! UIImageView).sd_setImage(with: URL(string:self.senderSigPath), placeholderImage:UIImage(named:""))
        
        let closeSignTapGue = UITapGestureRecognizer()
        closeSignTapGue.addTarget(self, action: #selector(self.closeSignViewTapped))
        (signatureDisplayView.subviews[3] as! UIImageView).isUserInteractionEnabled = true
        (signatureDisplayView.subviews[3] as! UIImageView).addGestureRecognizer(closeSignTapGue)
        
        GeneralFunctions.setImgTintColor(imgView: (signatureDisplayView.subviews[3] as! UIImageView), color: UIColor.black)
    }
    
    @objc func closeSignViewTapped(){
        if(signatureDisplayBGView != nil){
            signatureDisplayBGView.removeFromSuperview()
        }
        
        if(signatureDisplayView != nil){
            signatureDisplayView.removeFromSuperview()
        }
    }
    
    @objc func helpTapped(){
        let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
        helpCategoryUv.iTripId =  self.tripDetailDict.get("iTripId")
        self.push(uv: helpCategoryUv)
    }
    
    @objc func openBeforeImage(){
        let url = URL(string: self.tripDetailDict.get("vBeforeImage"))!
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    
    @objc func openAfterImage(){
        let url = URL(string: self.tripDetailDict.get("vAfterImage"))!
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    
    func addFareDetails(){
        
        //let HistoryFareDetailsNewArr = self.tripDetailDict.dictOf(Utils.message_str).arrOf("HistoryFareDetailsNewArr")
        var  HistoryFareDetailsNewArr = self.tripDetailDict.dictOf(Utils.message_str).arrOf("HistoryFareDetailsNewArr")
        if isBidding {
            HistoryFareDetailsNewArr = self.tripDetailDict.arrOf("FareDetailsNewArr")
        }
        for fareSubView in self.chargesDataContainerView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        
        for i in 0..<HistoryFareDetailsNewArr.count {
            
            let dict_temp = HistoryFareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
                
                let totalSubViewCounts = self.chargesDataContainerView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 60
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)

                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 60
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font:UIFont!
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
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
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 40))
                    
                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 40))
                        
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.textColor = UIColor(hex: 0x646464)
                    lblValue.textColor = UIColor(hex: 0x090909)
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
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
                    
                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
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
            self.chargesContainerViewHeight.constant = CGFloat((self.chargesDataContainerView.subviews.count - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight))
        }
        
        self.chargesParentViewHeight.constant = self.chargesContainerViewHeight.constant + self.CHARGES_PARENT_VIEW_OFFSET_HEIGHT + 20
        
        self.tipMainviewTop.constant = self.ratingView.isHidden == true ? -40 : 15
        self.chargesDataContainerView.layoutIfNeeded()
        self.chargesContainerView.layoutIfNeeded()
        
        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.chargesParentViewHeight.constant + (self.tipMainView.isHidden == false ? 240 : 0)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT)
        })
    }
    
    /* FAV DRIVERS CHANGES */
    func ratingView(_ ratingView: RatingView, didChangeRating newRating: Float) {
        /*if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
         
         }*/
        if(ratingView == self.tripRatingBar){
            self.perform(#selector(performSwipeAction), with: self, afterDelay: 0.5)
        }
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
    
    @objc func getReceiptBtnTapped(){
        var key = "iTripId"
        if isBidding {
            key = "iBiddingPostId"
        }
        let parameters = ["type":"getReceipt","iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iTripId": iTripId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
        
            if(response != ""){
                let dataDict = response.toDict()
                
                 self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str), key: dataDict.get(Utils.message_str)))
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.submitRatingBtn){
            self.isCollectTip = "No"
            if(self.tripDetailDict.get("ShowSafetyRating").uppercased() == "YES"){
                            if(self.tripRatingBar.rating <= 0.0 || self.safetyRatingBar.rating <= 0.0){
                                 if(self.tripRatingBar.rating <= 0.0){
                                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_RATING_DIALOG_TXT"), uv: self)
                                    return
                                 }
                                 
                                 if(self.safetyRatingBar.rating <= 0.0){
                                     Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_SAFETY_RATING_DIALOG_TXT"), uv: self)
                                    return
                                 }
                            }else{
                                if isBidding {
                                    self.submitRatingBidding()
                                }else {
                                self.submitRating()
                                }
                            }
                        }else{
                            if(self.ufxRatingBar.rating <= 0.0){
                                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_RATING_DIALOG_TXT"), uv: self)
                                return
                            }else{
                                if isBidding {
                                    self.submitRatingBidding()
                                }else{
                                self.submitRating()
                                }
                            }
                        }
            
        }
        if sender == self.giveTipButton {
            if (!self.selectTip1 && !self.selectTip2 && !self.selectTip3 && self.tipPosition != "4") {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TIP_AMOUNT_TXT"), uv: self)
        }else{
            if self.tipPosition == "4" && tipAmoTxtFiled.text == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TIP_AMOUNT_TXT"), uv: self)
                return
            }
            isCollectTip = "Yes"
            self.submitRating()
            
        }
    }
    }
    override func close() {
        if self.tripDetailDict != nil {
            if(self.tripDetailDict.get("eType") == "Multi-Delivery"){
                if (self.mainScreenUv != nil) {
                    self.dismiss(animated: true, completion: {
                        
                        if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                            GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                        }
                        self.mainScreenUv.liveTrackTripId = ""
                        self.mainScreenUv.dismiss(animated: false, completion: {
                            
                        })
                    })
                    return
                }else{
                    super.close()
                }
            }else{
                super.close()
            }
        }else {
            super.close()
        }
    }
    
    func drawRoute(){
//        let fromLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tStartLat")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tStartLong")))
//        let toLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tEndLat")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tripDetailDict.get("tEndLong")))
//        
//        updateDirection = UpdateDirections(uv: self, gMap: self.gMapView, fromLocation: fromLocation, destinationLocation: toLocation, isCurrentLocationEnabled: false)
//        updateDirection.onDirectionUpdateDelegate = self
//        updateDirection.setCurrentLocEnabled(isCurrentLocationEnabled: false)
//        updateDirection.scheduleDirectionUpdate(eTollSkipped: tripDetailDict.get("eTollSkipped"))
    }
    
    func onDirectionUpdate(directionResultDict: NSDictionary) {
        if(updateDirection != nil){
            updateDirection.releaseTask()
            updateDirection.onDirectionUpdateDelegate = nil
            updateDirection = nil
        }
    }
    
    @objc func performSwipeAction(){
       
        if(tripRatingBarXPosition.constant == 0){
            
            ratingBarTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(performSwipeAction))
            self.ufxRatingBar.isUserInteractionEnabled = true
            self.ufxRatingBar.addGestureRecognizer(ratingBarTapGesture)
            
            view.layoutIfNeeded()
            
            let xConstant = self.tripRatingBar.frame.origin.x + ((self.tripRatingBar.frame.width / 2) + (self.tripRatingBar.frame.width / 2) - 15)
            if(Configurations.isRTLMode()){
                tripRatingBarXPosition.constant = xConstant
            }else{
                tripRatingBarXPosition.constant = 0 - xConstant
            }
            
            self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAFETY_RATING_TXT")
            self.tripRatingBar.isHidden = true
            //self.ratingBar.editable = false
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
            
            self.ufxRatingBar.removeGestureRecognizer(ratingBarTapGesture)
            view.layoutIfNeeded()
            
            self.ratingSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING")
            tripRatingBarXPosition.constant = 0
            self.ufxRatingBar.editable = true
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
    func submitRating(){
           var key = "tripID"
        if isBidding {
            key = "iBiddingPostId"
        }
        if isCollectTip == "Yes" {
            if selectTip4 {
                self.fAmount =  tipAmoTxtFiled.text ?? ""
            }
        }
       
        var parameters = ["type":"submitRating","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, key: iTripId, "message": "\(commentTxtView.text!)", "eFavDriver": self.isFavSelected == true ? "Yes" : "No", "isCollectTip": isCollectTip,"fAmount": fAmount]
           
           if(self.tripDetailDict.get("ShowSafetyRating").uppercased() == "YES"){
               parameters["rating"] = "\(self.tripRatingBar.rating)"
               parameters["safetyRating"] = "\(self.safetyRatingBar.rating)"
           }else{
               parameters["rating"] = "\(self.ufxRatingBar.rating)"
           }
           
           let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
           exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
           exeWebServerUrl.currInstance = exeWebServerUrl
           exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
               
               if(response != ""){
                   let dataDict = response.toDict()
                  
                   if(dataDict.get("Action") == "1"){
                       //self.isCollectTip = "No"
                       if self.isCollectTip.uppercased() == "YES" {
                           self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str) , key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                               if self.ratingView.isHidden {
                                   self.close()
                               }else{
                                   self.isCollectTip = "No"
                                   self.PAGE_HEIGHT = 1200
                                   self.getDtata()
                               }
                               
                               
                           })
                           return
                       }
                      
                       
                       self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING_FINISHED_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                           
                           if (self.endedDeliveryTripId != ""){ //Multi-Delivery Releted Changes*/
                               self.dismiss(animated: true, completion: {
                                   if(self.mainScreenUv != nil){
                                       
                                       if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                                           GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                                       }
                                       self.mainScreenUv.liveTrackTripId = ""
                                       self.mainScreenUv.dismiss(animated: false, completion: {
                                       })
                                   }
                               })
                           } else if self.isBidding {
                               self.close()
                           }
                           else{
                               if !self.tipMainView.isHidden {
                                   self.PAGE_HEIGHT = 1200
                                   self.getDtata()
                               }else{
                               self.performSegue(withIdentifier: "unwindToRideHistoryScreen", sender: self)
                                   }
                           }
                       })
                   }
                   else if  dataDict.get("Action") == "0"{
                       
                       if(dataDict.get("isCollectTip").uppercased() == "YES"){
                           
                           let url = dataDict.get(Utils.message_str)
                           GeneralFunctions.addPayment(url: url, uv: self)
                           
                           return
                       }
                   }
                       else{
                       self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                   }
               }else{
                   self.generalFunc.setError(uv: self)
               }
           })
       }
    func submitRatingBidding(){
           var key = "tripID"
        if isBidding {
            key = "iBiddingPostId"
        }
        var  parameters = ["type":"submitRatingBiddingService","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, key: iTripId, "message": "\(commentTxtView.text!)" ]
        if(self.tripDetailDict.get("ShowSafetyRating").uppercased() == "YES"){
            parameters["rating"] = "\(self.tripRatingBar.rating)"
            parameters["safetyRating"] = "\(self.safetyRatingBar.rating)"
        }else{
            parameters["rating"] = "\(self.ufxRatingBar.rating)"
        }
          
           
           let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
           exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
           exeWebServerUrl.currInstance = exeWebServerUrl
           exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
               
               if(response != ""){
                   let dataDict = response.toDict()
                   
                   if(dataDict.get("Action") == "1"){
                       self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING_FINISHED_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                           
                           if (self.endedDeliveryTripId != ""){ //Multi-Delivery Releted Changes*/
                               self.dismiss(animated: true, completion: {
                                   if(self.mainScreenUv != nil){
                                       
                                       if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                                           GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                                       }
                                       self.mainScreenUv.liveTrackTripId = ""
                                       self.mainScreenUv.dismiss(animated: false, completion: {
                                       })
                                   }
                               })
                           } else if self.isBidding {
                               self.close()
                           }
                           else{
                               self.performSegue(withIdentifier: "unwindToRideHistoryScreen", sender: self)
                           }
                       })
                   }else{
                       self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                   }
               }else{
                   self.generalFunc.setError(uv: self)
               }
           })
       }
    
    func setTipView()
    {
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        //self.tipMainViewBottomSpace.constant = 20
        self.giveTipButton.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIVE_TIP"))
        self.giveTipButton.clickDelegate = self
        self.giveTipButtonHight.constant = 35
        self.tipMainViewHeight.constant = 200
        self.tipMainView.isHidden = false
        self.giveTipButton.isHidden = false
        self.tipSubView.clipsToBounds = true
        //self.tipSubView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.shadowOnview(view: tipSubView)
        self.tipSubView.layer.roundCorners(radius: 10)
        self.tipAmoOtherValueView.isHidden = true
        self.tipAmoOtherConfImgView.isHidden = true
        self.tipAmoTxtFiled.delegate = self
        self.tipAmoTxtFiled.keyboardType = .decimalPad
        
        GeneralFunctions.setImgTintColor(imgView: self.tipHintImgView, color: SColors.Theme)
        
        self.tipAmoOtherConfImgView.backgroundColor = SColors.Theme
        self.tipAmoOtherConfImgView.image = UIImage(named:"ic_btn_rightarrow")?.addImagePadding(x: 150, y: 150)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoOtherConfImgView, color: SColors.ThemeTxt)
        
        self.tipMainViewHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_TITLE_TXT")
        
        self.tipAmoTxtFiled.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT")
        
         
            self.tipAmoLbl1.text =  GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: userProfileJson.get("RIDE_TIP_AMOUNT_1"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
                //userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_1"))
            self.tipAmoLbl2.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: userProfileJson.get("RIDE_TIP_AMOUNT_2"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))//userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_2"))
            self.tipAmoLbl3.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: userProfileJson.get("RIDE_TIP_AMOUNT_3"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))//userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_3"))
        
        
        
        
        self.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
        self.tipRequiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REQUIRED")
        
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView1, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView2, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView3, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoOtherImgView, color: UIColor.black)
        
        self.tipHintImgView.handleClick { (instance) in
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            
            openUserPreferences.isTip = true
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_TXT"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_TITLE_TXT"))
        }
        
        self.tipAmoOtherConfImgView.handleClick { (instance) in
            
            if(self.tipAmoTxtFiled.text != "" && GeneralFunctions.parseDouble(origValue: 0, data: self.tipAmoTxtFiled.text!) > 0){
                self.tipAmount = self.tipAmoTxtFiled.text!
                self.tipAmoOtherLbl.text = userProfileJson.get("CurrencySymbol") + self.tipAmount
                self.tipAmoOtherImgView.isHidden = false
                
                self.tipPosition = "4"
               // self.getCheckOutPrice()
                
                self.tipAmoTxtFiled.text = ""
            }else{
                
                self.tipRequiredLbl.isHidden = false
                self.tipAmoOtherValueView.borderColor = SColors.red
                
            }
        }
        
        self.tipAmoImgView1.handleClick { (instance) in
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmount = ""
            self.tipPosition = ""
           // self.getCheckOutPrice()
            
        }
        
        self.tipAmoImgView2.handleClick { (instance) in
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            self.tipAmount = ""
            
            self.tipPosition = ""
         
            
            
        }
        
        self.tipAmoImgView3.handleClick { (instance) in
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
           self.tipAmount = ""
            
           self.tipPosition = ""
          //  self.getCheckOutPrice()
        }
        
        self.tipAmoOtherImgView.handleClick { (instance) in
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            self.tipAmount = ""
            //self.tipPosition = ""
            
            self.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
            self.tipAmoTxtFiled.text = ""
            self.tipMainViewHeight.constant = 250
            
           // self.getCheckOutPrice()
        }
        
        self.tipAmoVIew1.handleClick { (instance) in
            if !self.selectTip1 {
            self.selectTip2 = false
            self.selectTip3 = false
            self.selectTip4 = false
            self.tipAmoVIew1.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
                self.tipAmoVIew1.borderColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            self.tipAmoLbl1.paddingLeft = 20
            self.tipAmoLbl1.paddingRight = 20
            self.tipButtonTop.constant = 15
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            self.tipAmoOtherValueView.isHidden = true
            self.tipAmoOtherConfImgView.isHidden = true
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 200
            
            self.tipAmount = userProfileJson.get("RIDE_TIP_AMOUNT_1")
            self.fAmount = userProfileJson.get("RIDE_TIP_AMOUNT_1")
            self.tipPosition = "1"
            self.selectTip1 = true
            }else{
                self.tipAmount = ""
                self.fAmount = ""
                self.tipPosition = ""
                self.selectTip1 = false
                self.tipAmoVIew1.borderColor = UIColor.lightGray
                self.tipAmoVIew1.backgroundColor = UIColor.clear
            }
           // self.getCheckOutPrice()
        }
        
        self.tipAmoView2.handleClick { (instance) in
            if !self.selectTip2 {
                self.selectTip1 = false
                self.selectTip3 = false
                self.selectTip4 = false
            self.tipAmoView2.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoView2.borderColor = SColors.Theme
            
            self.tipAmoImgView2.isHidden = true
            self.tipAmoLbl2.paddingLeft = 20
            self.tipAmoLbl2.paddingRight = 20
            self.tipButtonTop.constant = 15
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            self.tipAmoOtherValueView.isHidden = true
            self.tipAmoOtherConfImgView.isHidden = true
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 200
            
            self.tipAmount = userProfileJson.get("RIDE_TIP_AMOUNT_2")
            self.fAmount = userProfileJson.get("RIDE_TIP_AMOUNT_2")
            self.tipPosition = "2"
            self.selectTip2 = true
            }else{
                self.tipAmount = ""
                self.tipPosition = ""
                self.fAmount = ""
                self.selectTip2 = false
                self.tipAmoView2.borderColor = UIColor.lightGray
                self.tipAmoView2.backgroundColor = UIColor.clear
            }
           // self.getCheckOutPrice()
        }
        
        self.tipAmoView3.handleClick { (instance) in
            if !self.selectTip3 {
                self.selectTip1 = false
                self.selectTip2 = false
                self.selectTip4 = false
            self.tipAmoView3.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoView3.borderColor = SColors.Theme
            self.tipAmoImgView3.isHidden = true
            self.tipAmoLbl3.paddingLeft = 20
            self.tipAmoLbl3.paddingRight = 20
            self.tipAmoOtherValueView.isHidden = true
            self.tipAmoOtherConfImgView.isHidden = true
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            self.tipButtonTop.constant = 15
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 200
            
            self.tipAmount = userProfileJson.get("RIDE_TIP_AMOUNT_3")
            self.fAmount = userProfileJson.get("RIDE_TIP_AMOUNT_3")
            self.tipPosition = "3"
            self.selectTip3 = true
            }else{
                self.tipAmount = ""
                self.fAmount = ""
                self.tipPosition = ""
                self.selectTip3 = false
                self.tipAmoView3.borderColor = UIColor.lightGray
                self.tipAmoView3.backgroundColor = UIColor.clear
            }
//            self.getCheckOutPrice()
        }
        
        self.tipAmoOtherView.handleClick { (instance) in
            if !self.selectTip4 {
            self.tipAmoOtherView.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoOtherView.borderColor = SColors.Theme
            self.selectTip1 = false
            self.selectTip2 = false
            self.selectTip3 = false
            self.tipAmoOtherValueView.isHidden = false
            self.tipAmoOtherConfImgView.isHidden = true
            if(self.tipAmoOtherLbl.text == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")){
                self.tipAmoOtherImgView.isHidden = true
            }else{
                self.tipAmoOtherImgView.isHidden = false
            }
            self.tipButtonTop.constant = 65
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            self.selectTip1 = false
            self.selectTip2 = false
            self.selectTip3 = false
            self.selectTip4 = true
            self.tipPosition = "4"
            self.tipMainViewHeight.constant = 250
            }else{
                self.tipMainViewHeight.constant = 200
                self.tipButtonTop.constant = 15
                self.tipAmoOtherValueView.isHidden = true
                self.tipAmount = ""
                self.tipPosition = ""
                self.selectTip4 = false
                self.fAmount = ""
            }
            
        }
        
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
}
