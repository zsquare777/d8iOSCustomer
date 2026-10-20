

import UIKit
import GoogleMaps
import SysBaseLib
import CoreLocation
import WebKit
import LiveChat
class LiveTrackUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate, OnLocationUpdateDelegate, OnTaskRunCalledDelegate, OnDirectionUpdateDelegate,MyLabelClickDelegate, MyBtnClickDelegate, TextFieldDelegate, WKNavigationDelegate, ParentViewUVDelegate,MXParallaxHeaderDelegate,LiveChatDelegate{
    
    var MENU_ORDERDETAIL = "0"
    var MENU_HELP = "1"
    var MENU_TIP = "2"
    var LIVE_CHAT = "3"
    @IBOutlet weak var tableBottom: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var dragView: SDragViewForLiveTrack!
    var globlaPullContorleer = LiveTrackPullUpUV()
    
    //    @IBOutlet weak var googleMapContainerView: UIView!
    @IBOutlet weak var mapLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var deliveredView: UIView!
    @IBOutlet weak var notDeliveredView: UIView!
    @IBOutlet weak var orderDelBGView: UIView!
    @IBOutlet weak var enjoyYFoodLbl: MyLabel!
    @IBOutlet weak var orderDelCallDelLbl: MyLabel!
    @IBOutlet weak var orderDelOkLbl: MyLabel!
    @IBOutlet weak var ordernotDelLbl: MyLabel!
    
    @IBOutlet weak var orderDelOkTopSpace: NSLayoutConstraint!
    @IBOutlet weak var orderDelSubLbl: MyLabel!
    @IBOutlet weak var orderDelHLbl: MyLabel!
    @IBOutlet weak var orderDeliveredViewHeight: NSLayoutConstraint!
    @IBOutlet weak var orderDeliveredView: UIView!
    @IBOutlet weak var headerView: UIView!
    //    @IBOutlet weak var pickUpTimeView: UIView!
    //    @IBOutlet weak var ETATimeView: UIView!
    //    @IBOutlet weak var pickUPTimeHLbl: MyLabel!
    //    @IBOutlet weak var pickUpTimeSHLbl: MyLabel!
    //    @IBOutlet weak var ETATimeHLbl: MyLabel!
    //    @IBOutlet weak var ETATimeSHLbl: MyLabel!
    @IBOutlet weak var notDelLblHeight: NSLayoutConstraint!
    @IBOutlet weak var etaStackView: UIStackView!
    @IBOutlet weak var etaTimeView: UIView!
    
    @IBOutlet weak var tableHeaderTopView: UIView!
    @IBOutlet weak var tableBottomView: UIView!
    @IBOutlet weak var googleMapContainerView: UIView!
    
    @IBOutlet weak var pickUpTimeView: UIView!
    @IBOutlet weak var pickUPTimeHLbl: MyLabel!
    @IBOutlet weak var pickUpTimeSHLbl: MyLabel!
    @IBOutlet weak var ETATimeView: UIView!
    @IBOutlet weak var ETATimeHLbl: MyLabel!
    @IBOutlet weak var ETATimeSHLbl: MyLabel!
    
    //contactless outlets
    @IBOutlet weak var contactLesssDeliveryLbl: MyLabel!
    @IBOutlet weak var howItWorkLbl: MyLabel!
    @IBOutlet weak var contactLesssDeliveryView: UIView!
    @IBOutlet weak var contactLesssDeliveryHeight: NSLayoutConstraint!
    @IBOutlet weak var delliveredProofImg: UIImageView!
    @IBOutlet weak var delliveredProofImgHeight: NSLayoutConstraint!
    
    //takeaway outlets
    @IBOutlet weak var pickupOrderTimeLbl: MyLabel!
    @IBOutlet weak var pickupOrderTimeView: UIView!
    @IBOutlet weak var pickupOrderTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var resturantAddressLbl: MyLabel!
    @IBOutlet weak var resturantAddressView: UIView!
    @IBOutlet weak var resturantAddressHeight: NSLayoutConstraint!
    @IBOutlet weak var resturantAddressLblHeight: NSLayoutConstraint!
    @IBOutlet weak var navigateLbl: MyLabel!
    @IBOutlet weak var resturantAddressImg: UIImageView!
    
    @IBOutlet weak var reviewItemBGView: UIView!
    @IBOutlet weak var reviewItemPopupView: UIView!
    @IBOutlet weak var reviewItemDeclineBtn: MyButton!
    @IBOutlet weak var reviewItemConfBtn: MyButton!
    @IBOutlet weak var reviewItemImgView: UIImageView!
    @IBOutlet weak var reviewItemCancelImgView: UIImageView!
    @IBOutlet weak var reviewitemNameLbl: MyLabel!
    @IBOutlet weak var reviewitemPriceLbl: MyLabel!
    //contactless variable
    
    @IBOutlet weak var billDetailsCancelImgView: UIImageView!
    @IBOutlet weak var billDetailsView: UIView!
    @IBOutlet weak var billDetailsHLbl: MyLabel!
    @IBOutlet weak var billDetailsSubView: UIView!
    @IBOutlet weak var billDetailsViewHeight: NSLayoutConstraint!
    private var originalPullUpControllerViewSize: CGSize = .zero
    
    
    var isContactLess = false
    var isTakeAway = false
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var orderId = ""
    var assignedDriverId = ""
    
    var assignedDriverRotatedLocation:CLLocation!
    var isMapMoveToDriverLoc = false
    
    var rightButton: UIBarButtonItem!
    var menu:BTNavigationDropdownMenu!
    var getLocation:DeviceLocation!
    var isPageLoaded = false
    
    var gMapView:GMSMapView!
    var currentLocation:CLLocation!
    var destLocation:CLLocation!
    var driverLocation:CLLocation!
    
    var pickUpPointMarker:GMSMarker!
    var destPointMarker:GMSMarker!
    var pickUpCustomMarker:GMSMarker!
    var dropOffCustomMarker:GMSMarker!
    
    var driverMarker:GMSMarker!
    var feedBackQue = [NSDictionary]()
    var pickUpAddress = ""
    var destAddress = ""
    var ETATime = ""
    var driverPhone = ""
    
    var allowAnimation = true
    var isDirect = false
    
    var firstLoad = true
    var listOfPaths = [GMSPolyline]()
    var dataDict:NSDictionary!
    var polyline:GMSPolyline!
    
    /* To animate Line */
    var animTask:TaskScheduler!
    var animationPathOrig = GMSMutablePath()
    var animationPath = GMSMutablePath()
    var i_anim:Int = 0
    
    var animationPolylineOrig = GMSPolyline()
    var animationPolyline = GMSPolyline()
    
    var animLocationArr = [CLLocationCoordinate2D]()
    var animLocArrParts:[[CLLocationCoordinate2D]]!
    
    var arrivingNotificationCounter1 = false
    var arrivingNotificationCounter2 = false
    var arrivingNotificationCounter3 = false
    var lastArrivingNotificationTime:Int64!
    var updateFreqDriverLocTask:TaskScheduler!
    var updateDirection:UpdateDirections!
    var userProfileJson:NSDictionary!
    var kTableHeaderHeight:CGFloat = 280
    
    var orderStatusMessage = ""
    var showCancelView = false
    
    var tableHeaderView:UIView!
    var rowHeight = [CGFloat] ()
    
    var isOpenRestaurantDetail = "No"
    
    var tipView:TipLiveTrackView!
    var tipBGView:UIView!
    var tipAmount = ""
    var isShowTipView = false
    
    var tipPosition = ""
    let webView = WKWebView()
    var backImgView:UIImageView!
    
    var currentReviewItemTag = -1
    
    var genieFinalCardPayment = false
    var isWalletDebitAllow = ""
    
    var loaderView:UIView!
    var isfromBack = false
    var firstLoadPull = false
    var isFromRating = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            
            isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
            self.setnavBarTintColor(color: SColors.Theme)
            cntView = self.generalFunc.loadView(nibName: "LiveTrackScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            
            rightButton = UIBarButtonItem(image: UIImage(named: "ic_menu")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.menuClicked))
            self.navigationItem.rightBarButtonItem = rightButton
            
            GeneralFunctions.saveValue(key: "CART_UPDATE", value: false as AnyObject)
            
    //        if #available(iOS 11.0, *) {
    //
    //        } else {
    //            automaticallyAdjustsScrollViewInsets = true
    //        }
    //
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.userProfileJson = userProfileJson
            
            self.contentView.isHidden = true
            //self.activityIndicator.startAnimating()
            self.activityIndicator.color = SColors.Theme
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 25))
            customView.backgroundColor = UIColor.clear
            self.tableView.tableFooterView = customView
            
            self.tableView.register(UINib(nibName: "LiveTrackStatusTVCell", bundle: nil), forCellReuseIdentifier: "LiveTrackStatusTVCell")
            
            //        self.tableView.bounces = true
            
            let orderNotDelTapGesture = UITapGestureRecognizer()
            orderNotDelTapGesture.addTarget(self, action: #selector(self.orderNotDelTapped))
            self.notDeliveredView.isUserInteractionEnabled = true
            notDeliveredView.addGestureRecognizer(orderNotDelTapGesture)
            
            let orderDelOKGesture = UITapGestureRecognizer()
            orderDelOKGesture.addTarget(self, action: #selector(self.orderDelOkTapped))
            self.deliveredView.isUserInteractionEnabled = true
            deliveredView.addGestureRecognizer(orderDelOKGesture)
            
            self.enjoyYFoodLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERD_NOTE")
            self.orderDelCallDelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTDELIVERD_NOTE")
            self.orderDelOkLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK_GOT_IT").uppercased()
            self.ordernotDelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_DELIVERD").uppercased()
            self.orderDelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_DELIVERED")//.uppercased()
            self.orderDelHLbl.textColor = SColors.Theme
            self.orderDelSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_DELIVER_MSG")
            
            self.notDeliveredView.backgroundColor = SColors.ThemeTxt
            self.notDeliveredView.borderWidth = 1
            self.notDeliveredView.borderColor = SColors.blackColor
            self.deliveredView.backgroundColor = SColors.Theme
            self.orderDelCallDelLbl.textColor = SColors.blackColor
            self.ordernotDelLbl.textColor = SColors.blackColor
            self.orderDelOkLbl.textColor = SColors.ThemeTxt
            self.enjoyYFoodLbl.textColor = UIColor.white//UIColor(hex: 0x373737)
            
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            if isFromRating{
                self.close()
            }
            if GeneralFunctions.getMemberd() != "" {
                EventService.getInstance().buildConnection()
            }
            
            EventService.getInstance().iTripId = self.orderId
            
            if(genieFinalCardPayment == true){
                self.genieFinalCardPayment = false
                self.genieMakePayment()
            }
           

        }else if(type == 2){
            if(isPageLoaded == false){
                isPageLoaded = true
                
                self.cntView.frame.size = CGSize(width: Application.screenSize.width, height: self.cntView.frame.height)
                self.googleMapContainerView.frame.size = CGSize(width: Application.screenSize.width, height: self.googleMapContainerView.frame.height)
        
                
                self.setTableView()
                
                let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: Utils.defaultZoomLevel)
                
                gMapView = GMSMapView.map(withFrame: CGRect(x:0, y:0, width: Application.screenSize.width, height: self.googleMapContainerView.frame.height), camera: camera)
                self.googleMapContainerView.addSubview(gMapView)
                
                
                getData()
            }else{
                self.orderDelBGView.isHidden = true
                self.orderDeliveredView.isHidden = true
                
                //self.tableBottom.constant = -130
                self.orderDeliveredViewHeight.constant = 00
                self.tableView.reloadData()
                if !self.isFromRating {
                getData()
                self.isFromRating = false
                }
                if  !self.isfromBack {
                    getData()
                    self.isfromBack = false
                }
               // self.setTableView()
            }
            
        }
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        if scrollView.contentOffset.y <= -kTableHeaderHeight
        //        {
        //            self.tableView.contentOffset.y = -kTableHeaderHeight
        //        }
    }
    

    func setTableView(){
//        tableHeaderView = self.generalFunc.loadView(nibName: "LiveTrackHeaderView", uv: self, isWithOutSize: true)
//        tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 280)
//        tableHeaderView.backgroundColor = UIColor(hex: 0xf1f1f1)
//        self.tableBottomView.layer.shadowOpacity = 1.0
//        self.tableBottomView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.tableBottomView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
//        self.tableBottomView.layer.shadowRadius = 4.0
//        self.tableBottomView.layer.cornerRadius = 10
//        self.tableBottomView.layer.borderColor = UIColor.black.cgColor
//        self.tableBottomView.layer.borderWidth = 0
//
//        self.pickUpTimeSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICKED_UP")
//        self.ETATimeSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ETA_TXT")
//
//        //contactless and takeaway setup data
//
//        self.contactLesssDeliveryView.backgroundColor = SColors.Theme
//        self.contactLesssDeliveryLbl.textColor = SColors.ThemeTxt
//        self.howItWorkLbl.textColor = SColors.ThemeTxt
//        self.contactLesssDeliveryLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_LESS_DELIVERY_TXT")
//        self.howItWorkLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DIS_HOW_IT_WORKS")
//        self.howItWorkLbl.setClickDelegate(clickDelegate: self)
//        if(Configurations.isRTLMode()){
//            self.howItWorkLbl.textAlignment = .left
//        }else{
//            self.howItWorkLbl.textAlignment = .right
//        }
//        self.pickupOrderTimeView.backgroundColor = SColors.Theme
//        self.pickupOrderTimeLbl.textColor = SColors.ThemeTxt
//        GeneralFunctions.setImgTintColor(imgView: resturantAddressImg, color: SColors.Theme)
//        self.navigateLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NAVIGATE")
//        self.navigateLbl.borderColor = SColors.Theme
//        self.navigateLbl.clipsToBounds = true
//        self.navigateLbl.layer.cornerRadius = 5
//        self.navigateLbl.setClickDelegate(clickDelegate: self)
    }
    
    func myLableTapped(sender: MyLabel) {
        if(sender == self.howItWorkLbl){
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACTLESS_DELIVERYUSER_NOTE_TXT"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_LESS_DELIVERY_TXT"))
        }
        else if(sender == self.navigateLbl){
            let openNavOption = OpenNavOption(uv: self, containerView: self.view, placeLatitude: self.dataDict.get("CompanyLat"), placeLongitude: self.dataDict.get("CompanyLong"), address:self.dataDict.get("CompanyAddress"))
            openNavOption.chooseOption()
        }
    }
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func close() {
        if menu != nil{
            if(menu.isShown){
                menu.hideMenu()
            }
        }
        self.releaseAllTask()
        super.close()
    }
    
    @objc func orderNotDelTapped() {
        if self.dataDict.get("OrderCurrentStatusCode") == "9" || self.dataDict.get("OrderCurrentStatusCode") == "8" {
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if(ServiceModule.isDeliverAllOnly()) // For only DeliverAll app
            {
                let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
                if serviceCategoryArray.count > 1
                {
                    if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                    }
                    
                }else
                {
                    if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                    }
                    
                }
            }else{
                
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }
            return
        }
        
        
        //self.orderDelBGView.isHidden = true
       // self.orderDeliveredView.isHidden = true
        //self.orderDeliveredViewHeight.constant = 0
        //self.view.layoutIfNeeded()
        
//
//        UIView.animate(withDuration: 0.2, animations: {
//            self.view.layoutIfNeeded()
//        }, completion:{ _ in})
      // self.isFromRating = true
      
       let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
       helpCategoryUv.iTripId =  orderId
        self.isfromBack = true
       self.navigationController?.pushViewController(helpCategoryUv, animated: true)

        //self.push(uv: helpCategoryUv)
    }
    
    @objc func orderDelOkTapped() {
       // let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if(ServiceModule.isDeliverAllOnly()) // For only DeliverAll app
        {
            let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
            if serviceCategoryArray.count > 1{
                
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }else{
                if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                }
            }
        }else{
            
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            }else{
                self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
            }
            
        }
    }
    
    
    
    func getData() {
        self.contentView.isUserInteractionEnabled = false
        
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = false
        }
        var parameters = ["type":"getOrderDeliveryLog", "iUserId": GeneralFunctions.getMemberd(),"iOrderId": orderId,"UserType": Utils.appUserType, "eSystem":"DeliverAll"]
        
        if(self.userProfileJson.get("DELIVERY_TIP_AMOUNT_TYPE_DELIVERALL").uppercased() == "PERCENTAGE"){
            
            if(self.tipPosition == "4"){
                parameters["fTipAmount"] = self.tipAmount
            }else{
                parameters["selectedTipPos"] = self.tipPosition
            }
        }else{
            parameters["fTipAmount"] = self.tipAmount
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                if self.firstLoad == true {
                    self.contentView.alpha = 0.0
                    self.contentView.isHidden = false
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.contentView.alpha = 1.0
                    }, completion: nil)
                }
                self.activityIndicator.stopAnimating()
                self.contentView.isUserInteractionEnabled = true
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                    
                    self.dataDict = dataDict
                    
                    if self.dataDict.get("isContactLessDeliverySelected") == "Yes" {
                        //self.tableHeaderView.frame.size.height = 330
                        self.kTableHeaderHeight = 330
                       // self.contactLesssDeliveryView.isHidden = false
                        self.isContactLess = true
                    }
                    
                    if self.dataDict.get("eTakeAway") == "Yes" && self.dataDict.get("prepareTime") != ""{
                       // self.pickupOrderTimeView.isHidden = false
                       // self.resturantAddressView.isHidden = false
                        //self.isTakeAway = true
                        //self.pickupOrderTimeLbl.text = self.dataDict.get("prepareTime")
                        //let resturantAddress = self.dataDict.get("CompanyAddress")
                        //self.resturantAddressLbl.text = resturantAddress
                        //self.resturantAddressLbl.fit()
                        //let addressHeight = resturantAddress.height(withConstrainedWidth: self.resturantAddressLbl.frame.size.width, font: UIFont(name: Fonts().semibold, size: 20)!)
                        //self.resturantAddressHeight.constant = 115 + self.resturantAddressLbl.frame.size.height
                        //self.tableHeaderView.frame.size.height = 320 + self.resturantAddressHeight.constant
                        //self.kTableHeaderHeight = 320 + self.resturantAddressHeight.constant
                    }
                    
                    
                    let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
                    
                    if self.dataDict.get("OrderPickedUpDate") != "" {
                        self.pickUPTimeHLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: self.dataDict.get("OrderPickedUpDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateTimeOnly)
                    }
                    if self.firstLoad == true {
                        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 250, height: 44.0))
                        label.backgroundColor = UIColor.clear
                        label.font = UIFont.boldSystemFont(ofSize: 13)
                        label.numberOfLines = 0
                        label.textAlignment = NSTextAlignment.center
                        label.text = "#" + Configurations.convertNumToAppLocal(numStr: self.dataDict.get("vOrderNo"))
                        
//                        "\(Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dic.get("tOrderRequestDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: "dd MMM, yyyy (EEE)"))"
                        label.textColor = SColors.ThemeTxt
                        self.navigationItem.titleView = label
                        
                        self.setData()
                        self.firstLoad = false
                    }else{
                        if self.polyline != nil{
                            self.polyline.map = nil
                        }
                       
                        self.perform(#selector(self.displayMapAccordingState), with: self, afterDelay: 0.5)
                         //self.displayMapAccordingState()
                    }
                    
                    
                    
                    //                    DispatchQueue.main.async {
                    //                        let indexPath = IndexPath(row: self.dataDict.arrOf("message").count-1, section: 0)
                    //                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    //                    }
                    
                    if ((self.dataDict.get("OrderCurrentStatusCode") == "6" || self.dataDict.get("OrderCurrentStatusCode") == "9" || self.dataDict.get("OrderCurrentStatusCode") == "8") && self.showCancelView == true) {
                        //self.orderDelBGView.isHidden = false
                        self.orderDeliveredView.isHidden = false
                        if self.dataDict.get("eTakeAway") == "Yes" {
                            //self.notDeliveredView.isHidden = true
                        }
                        self.view.layoutIfNeeded()
                        
                        let lastElement = dataDict.arrOf("message").count - 1
                        let dict = dataDict.arrOf("message")[lastElement] as? NSDictionary
                        let imageDeliverdProof = dict?.get("vImageDeliveryPref")
                        if self.isfromBack == false{
                        if GeneralFunctions.getSafeAreaInsets().bottom > 0 {
                            self.orderDeliveredViewHeight.constant = 165
                        }else{
                            self.orderDeliveredViewHeight.constant = 160
                        }
                        }
                        //delivery preferences
                        if imageDeliverdProof != ""{
                            self.orderDeliveredViewHeight.constant = self.orderDeliveredViewHeight.constant + 135
                            self.delliveredProofImg.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: imageDeliverdProof!, width: Int(self.delliveredProofImg.frame.width), height: Int(self.delliveredProofImg.frame.height))), placeholderImage:UIImage(named:""))
                        }
                        else{
                            self.delliveredProofImg.isHidden = true
                            self.delliveredProofImgHeight.constant = 0
                        }
                        
                        //takeaway
                        
                        if self.dataDict.get("eTakeAwayPickedUpNote") != ""{
                            self.orderDelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TAKE_AWAY_ORDER_PICKEDUP_TXT").uppercased()
                            self.orderDelSubLbl.text = self.dataDict.get("eTakeAwayPickedUpNote")
                            self.ordernotDelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TAKE_AWAY_HELP_TXT").uppercased()
                           // self.pickupOrderTimeView.isHidden = true
                           // self.resturantAddressView.isHidden = true
                            //self.resturantAddressHeight.constant = 0
                            //self.tableHeaderView.frame.size.height = 320 + self.resturantAddressHeight.constant
                           // self.kTableHeaderHeight = 300 + self.resturantAddressHeight.constant
                        }
                        
                        if (self.dataDict.get("OrderCurrentStatusCode") == "9" || self.dataDict.get("OrderCurrentStatusCode") == "8"){
                            
                            self.deliveredView.isHidden = true
                            self.orderDelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_CANCELLED")//.uppercased()
                            self.orderDelHLbl.textColor = SColors.Red
                            self.orderDelSubLbl.text = self.orderStatusMessage
                            self.orderDelCallDelLbl.isHidden = true
                            self.notDeliveredView.backgroundColor = SColors.ThemeTxt
                            self.ordernotDelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK_GOT_IT")//.uppercased()
                            self.notDelLblHeight.constant = 40
                            DispatchQueue.main.async {
                                if  self.tableHeaderView != nil {
                                self.tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: self.kTableHeaderHeight)
                                self.tableView.tableHeaderView = self.tableHeaderView
                                self.tableView.layoutIfNeeded()
                                self.tableView.setNeedsLayout()
                                self.tableBottomView.isHidden = true
                                self.tableView.reloadData()
                                }
                            }
                            
                        }
                        
                        self.ETATimeHLbl.text = "--"
                        if self.pickUPTimeHLbl.text == ""{
                        self.pickUPTimeHLbl.text = "--"
                        }
                        UIView.animate(withDuration: 0.2, animations: {
                            self.view.layoutIfNeeded()
                        }, completion:{ _ in})
                    }
                    
                    self.rowHeight.removeAll()
                    
                    for i in 0..<statusArray.count{
                        
                        if(statusArray[i].get("eBuyAnyService") == "Yes"){
                            self.enjoyYFoodLbl.isHidden = true
                            self.orderDelOkTopSpace.constant = 18
                        }
                        
                        var height:CGFloat = 0.0
                        height = height + statusArray[i].get("vStatus").height(withConstrainedWidth: Application.screenSize.width - 10, font: UIFont.init(name: Fonts().semibold, size: 15)!)
                        height = height + statusArray[i].get("vStatus_Track").height(withConstrainedWidth: Application.screenSize.width - 10, font: UIFont.init(name: Fonts().regular, size: 13)!) + 40
                        
                        // For Genie
                        if(statusArray[i].get("iStatusCode") == "13" && statusArray[i].get("OrderCurrentStatusCode") == "13" && statusArray[i].get("genieUserApproved") != "Yes"){
                            height = height + 300
                        }
                        
                        if(statusArray[i].get("iStatusCode") == "14" && statusArray[i].get("OrderCurrentStatusCode") == "14"){
                            if(statusArray[i].get("showPaymentButton").uppercased() == "YES"){
                                height = height + 65
                            }
                            
                            if(statusArray[i].get("showViewBillButton").uppercased() == "YES"){
                                height = height + 65
                            }
                        }
                    
                        //self.rowHeight.append((height > 120 ? height : 120 - 20))
                        self.rowHeight.append(height)
                    }
                    
                    if(self.dataDict.get("showTipAddArea").uppercased()  == "YES"){
                        self.isShowTipView = true
                    }else{
                        self.isShowTipView = false
                    }
                    
                    
                    self.tableView.reloadData()
                    self.addPullUpController(animated: false)
                    
                }else{
                    _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if(btnClickedIndex == 0){
                            self.getData()
                        }
                    })
                }
            }else{
                _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.getData()
                    }
                })
            }
            self.loaderView.isHidden = true
        })
    }
    
    func openReviewItemPopupView(dataDic:NSDictionary, indexTag:Int){
        
        self.currentReviewItemTag = indexTag
        
        self.reviewItemBGView.isHidden = false
        self.reviewItemPopupView.isHidden = false
        //globlaPullContorleer.pullUpControllerDidDrag(to: globlaPullContorleer.viewHeader.frame.size.height)
        let data = dataDic.dictOf("itemForReview")
        self.reviewItemImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: data.get("vImage"), width: Utils.getValueInPixel(value: Application.screenSize.width - 50), height: Utils.getValueInPixel(value: 380/*415*/))), placeholderImage:UIImage(named:"ic_no_icon"))
        
        self.reviewitemNameLbl.text = data.get("iQty") + "X " + data.get("MenuItem")

        self.reviewItemConfBtn.clickDelegate = self
        self.reviewItemDeclineBtn.clickDelegate = self
        self.reviewItemConfBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_TXT"))
        self.reviewItemDeclineBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TXT"))
        self.reviewItemDeclineBtn.setCustomColor(textColor: UIColor.black, bgColor: .clear, pulseColor: SColors.Theme, borderColor: UIColor.black, borderWidth: 1, cornerRadius: 5)
        
        //        self.reviewitemPriceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_PRICE") + ": " + data.get("fTotPrice")
        var finalString = ""
        finalString = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_PRICE") + ": " + data.get("fTotPrice")
        let attrStri = NSMutableAttributedString.init(string: finalString)
        let nsRange = NSString(string: finalString).range(of: data.get("fTotPrice"))
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : SColors.Theme, NSAttributedString.Key.font: UIFont.init(name: Fonts().regular, size: 15.0) as Any], range: nsRange)
        self.reviewitemPriceLbl.attributedText = attrStri
        
        if(data.get("eExtraPayment").uppercased() != "YES"){
            self.reviewitemPriceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_NOT_REQUIRED")
        }
       
        GeneralFunctions.setImgTintColor(imgView: self.reviewItemCancelImgView, color: SColors.ThemeTxt)
        self.reviewItemCancelImgView.backgroundColor =  SColors.Theme//.white
        self.reviewItemCancelImgView.cornerRadius = 55/2
        self.reviewItemCancelImgView.handleClick { (instance) in
            self.closeReviewitemPopupView()
        }
    }
    
    func genieMakePayment(_ eWalletIgnor:Bool = false){
        
        var parameters = ["type":"CollectPaymentBuyAnything", "iUserId": GeneralFunctions.getMemberd(), "iOrderId": self.orderId, "CheckUserWallet": self.isWalletDebitAllow, "eSystem":"DeliverAll"]
        
        // NEWPayment Changes
        let paymentData = GetPaymentProfileData.getInstance()
        if(paymentData.PAYMENT_OPTION != "Cash"){
            parameters["eWalletIgnore"] = eWalletIgnor == true ? "Yes" : "No"
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    if(dataDict.get("WebviewPayment").uppercased() == "YES"){
                        GeneralFunctions.addPayment(url: dataDict.get("message"), uv: self)
                    }else{
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btn_id) in
                            self.getData()
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
                        
                        var nagativeBtnTxt = ""
                        if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() == "YES"){
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                        }else{
                            nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")
                        }
                        
                        
                        
                        if(nagativeBtnTxt == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")){
                            self.generalFunc.setAlertMsg(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtnLBL: nagativeBtnTxt, naturalBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                                if(btnClickedIndex == 0){
                                    
                                   
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else if(btnClickedIndex == 1){
                                    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.genieMakePayment(true)
                                    }else{
                                        
                                    }
                                    
                                }else{
                                   
                                }
                            })
                        }else{
                            
                            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: nagativeBtnTxt, completionHandler: { (btnClickedIndex) in
    
                                if(btnClickedIndex == 0){
    
                                  
                                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                    (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                                }else{
    
                                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                        self.genieMakePayment(true)
                                    }else{
    
    
                                    }
    
                                }
    
                            })
                        }
                    
                        return
                    }/* .............. */
 
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    func closeReviewitemPopupView(){
        self.reviewItemBGView.isHidden = true
        self.reviewItemPopupView.isHidden = true
        if  self.globlaPullContorleer != nil {
        
            self.globlaPullContorleer.pullUpControllerMoveToVisiblePoint(self.globlaPullContorleer.hightOfHeader , animated: true) {
                                self.globlaPullContorleer.tblPullUp.isHidden = false
                                self.globlaPullContorleer.mainView.isHidden = false
                            }
            
            
               
            }
           
    
        
    }
    
    func confirmReviewItems(dataDic:NSDictionary, eConfirm:String, eDecline:String){
         
        let data = dataDic.dictOf("itemForReview")

        let parameters = ["type":"ConfirmReviewItems", "iOrderId": data.get("iOrderId"), "iMemberId": GeneralFunctions.getMemberd(), "iItemDetailsId": data.get("iItemDetailsId"), "eConfirm": eConfirm, "eDecline": eDecline, "eSystem": "DeliverAll"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let userDic = dataDict.dictOf("message1")
                    
                    print("GENIE:\(userDic)")
                    self.closeReviewitemPopupView()
                    self.getData()
                
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                
                _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.confirmReviewItems(dataDic:dataDic, eConfirm:eConfirm, eDecline:eDecline)
                    }
                })
            }
        })
        
    }
    
    func openBillDetailsView(data:NSDictionary){
        
        self.showPaymentDetails(data: data)
    
        self.billDetailsView.isHidden = false
        self.reviewItemBGView.isHidden = false
        
        self.billDetailsHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_BILL_DETAILS")
//        self.reviewItemBGView.handleClick { (instance) in
//            self.closeBillDetailsView()
//        }
        
        GeneralFunctions.setImgTintColor(imgView: self.billDetailsCancelImgView, color: SColors.Theme)
        self.billDetailsCancelImgView.handleClick { (instance) in
            self.closeBillDetailsView()
        }
        
    }
    
    func closeBillDetailsView(){
        self.billDetailsView.isHidden = true
        self.reviewItemBGView.isHidden = true
    }
    
    func showPaymentDetails(data:NSDictionary){
         
        let parameters = ["type":"GetBuyAnyServiceBillDetails", "iOrderId": data.get("iOrderId"), "iMemberId": GeneralFunctions.getMemberd(), "eSystem": "DeliverAll"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.addFareDetails(dic:dataDict)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                
                _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.showPaymentDetails(data:data)
                    }
                })
            }
        })
        
    }
    
    func addFareDetails(dic:NSDictionary){

        for fareSubView in self.billDetailsSubView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        

        let fareDetailsNewArr = dic.arrOf("FareDetailsArr")
        
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
                
        for i in 0..<fareDetailsNewArr.count {
            
            let dict_temp = fareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
//                print("\(key): \(value)")
                
                let totalSubViewCounts = self.billDetailsSubView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 40
                    
                    let viewCus = UIView(frame: CGRect(x: 10, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth - 20, height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)
                    
                                      //  self.fareContainerView.addArrangedSubview(viewCus)
                    self.billDetailsSubView.addSubview(viewCus)
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 40
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font:UIFont!
                    if(i == fareDetailsNewArr.count - 1){
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
                    
//                    self.fareContainerStackView.addArrangedSubview(viewCus)
                    self.billDetailsSubView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    if(i == fareDetailsNewArr.count - 1){
                        lblTitle.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblValue.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        lblTitle.textColor = UIColor.black
                        lblValue.textColor = SColors.Theme
                        
                    }
                }
            }
            self.billDetailsViewHeight.constant = CGFloat((self.billDetailsSubView.subviews.count - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight))
        }
        
       
        self.billDetailsViewHeight.constant = self.billDetailsViewHeight.constant + 70
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataDict != nil{
            return self.dataDict.arrOf("message").count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "LiveTrackStatusTVCell") as! LiveTrackStatusTVCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
        
        if statusArray[indexPath.row].get("iStatusCode") == "1" {
            cell.statusImgView.image = UIImage(named: "ic_orderPlaced")
        }else if statusArray[indexPath.row].get("iStatusCode") == "2" {
            cell.statusImgView.image = UIImage(named:"ic_track_store")
        }else if statusArray[indexPath.row].get("iStatusCode") == "4" {
            //            if(self.dataDict.get("iServiceId") == "1" || self.dataDict.get("iServiceId") == "") {
            //                cell.statusImgView.image = UIImage(named:"ic_acceptDelivryDriver")
            //            }else{
            //                cell.statusImgView.image = UIImage(named:"ic_store_track")
            //            }
            cell.statusImgView.image = UIImage(named:"ic_store_track")
            
        }else if statusArray[indexPath.row].get("iStatusCode") == "5" {
            cell.statusImgView.image = UIImage(named:"ic_pickByDriver")
        }else if statusArray[indexPath.row].get("iStatusCode") == "9" || statusArray[indexPath.row].get("iStatusCode") == "8" {
            cell.statusImgView.image = UIImage(named:"ic_cancelDel")
        }else if statusArray[indexPath.row].get("iStatusCode") == "13" {
            cell.statusImgView.image = UIImage(named:"ic_review_item")
        }else if statusArray[indexPath.row].get("iStatusCode") == "14" {
            cell.statusImgView.image = UIImage(named:"ic_make_payment")
        }else{
            cell.statusImgView.image = UIImage(named:"ic_liveTrackTrue")
            
        }
                
        if(statusArray[indexPath.row].get("iStatusCode") == "13" && statusArray[indexPath.row].get("OrderCurrentStatusCode") == "13" && statusArray[indexPath.row].get("genieUserApproved") != "Yes"){
            let dataDic = statusArray[indexPath.row].dictOf("itemForReview")
            cell.reviewGenieItemView.isHidden = false
            cell.genieItemReviewBtn.tag = indexPath.row
            cell.genieItemReviewBtn.btnType = "REVIEW_ITEM"
            cell.genieItemReviewBtn.clickDelegate = self
            cell.genieItemReviewBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_REVIEW"))
            cell.genieItemDetailsLbl.text = dataDic.get("iQty") + "X " + dataDic.get("MenuItem")
            
            cell.genieItemImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: dataDic.get("vImage"), width: Utils.getValueInPixel(value: Application.screenSize.width - 40), height: Utils.getValueInPixel(value: 250))), placeholderImage:UIImage(named:"ic_no_icon"))
            
            cell.reviewGenieItemViewHeight.constant = 300
        }else{
            cell.reviewGenieItemViewHeight.constant = 0
            cell.reviewGenieItemView.isHidden = true

        }

        if(Configurations.isRTLMode()){
            cell.statusHLbl.textAlignment = NSTextAlignment.right
           // cell.callViewTopConstraint.constant = -5

        }else{

            cell.statusHLbl.textAlignment = NSTextAlignment.left
            //cell.callViewTopConstraint.constant = 5

        }
        
        if(statusArray[indexPath.row].get("iStatusCode") == "14" && statusArray[indexPath.row].get("OrderCurrentStatusCode") == "14"){
            
            cell.makePaymentFareLbl.tag = indexPath.row
            cell.makePaymentFareLbl.handleClick { (instance) in
                
                self.openBillDetailsView(data: statusArray[instance.tag])
            }
            cell.makePaymentFareLbl.textColor = SColors.Theme
            cell.makePaymentFareLbl.addImage(originalText: Configurations.isRTLMode() ? " \(statusArray[indexPath.row].get("fStoreBillAmount"))" : "\(statusArray[indexPath.row].get("fStoreBillAmount")) ", image: UIImage(named: "ic_fare_detail")!.resize(toWidth: 18)!.resize(toHeight: 18)!, color: SColors.Theme, position:  Configurations.isRTLMode() ? .left : .right)

            cell.genieMakePaymenyBtn.btnType = "MAKE_PAYMENT"
            cell.genieMakePaymenyBtn.clickDelegate = self
            cell.genieMakePaymenyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MAKE_PAYMENT"))
        
            cell.genieMakePaymentView.isHidden = false
            
            if(statusArray[indexPath.row].get("showViewBillButton").uppercased() == "YES"){
                cell.makePaymentFareLbl.isHidden = false
            }else{
                cell.makePaymentFareLbl.isHidden = true
            }
            
            if(statusArray[indexPath.row].get("showPaymentButton").uppercased() == "YES"){
                cell.genieMakePaymenyBtn.isHidden = false
            }else{
                cell.genieMakePaymenyBtn.isHidden = true
            }
            
            if(statusArray[indexPath.row].get("showViewBillButton").uppercased() == "YES" && statusArray[indexPath.row].get("showPaymentButton").uppercased() != "YES"){
                cell.genieMakePaymentViewHeight.constant = 40
                cell.makePaymentBtnHeight.constant = 0
            }else if(statusArray[indexPath.row].get("showViewBillButton").uppercased() != "YES" && statusArray[indexPath.row].get("showPaymentButton").uppercased() == "YES"){
                cell.makePaymentBtnHeight.constant = 45
                cell.genieMakePaymentViewHeight.constant = 45
            }else{
                cell.makePaymentBtnHeight.constant = 45
                cell.genieMakePaymentViewHeight.constant = 90
            }
        }else{
            
            cell.genieMakePaymentViewHeight.constant = 0
            cell.genieMakePaymentView.isHidden = true
        }
        
//        if(Configurations.isRTLMode()){
//            cell.callViewTopConstraint.constant = -5
//        }else{
//            cell.callViewTopConstraint.constant = 5
//        }
        
        if statusArray[indexPath.row].get("eShowCallImg") == "Yes" {
            cell.callView.isHidden = false
            cell.statusLblTrailingSpace.constant = 50
            
        }else{
            cell.callView.isHidden = true
            cell.statusLblTrailingSpace.constant = 15
        }
        
        if indexPath.row == 0 {
            if indexPath.row != statusArray.count - 1 {
                if statusArray[indexPath.row + 1].get("eCompleted") == "Yes" {
                    cell.statusDownJointView.backgroundColor = UIColor(hex: 0xD8D8D8)//SColors.Theme
                }else{
                    cell.statusDownJointView.backgroundColor = UIColor(hex: 0xD8D8D8)
                }
            }
            cell.statusUpperJointView.isHidden = true
        }else{
            if statusArray[indexPath.row].get("eCompleted") == "Yes" {
                cell.statusUpperJointView.backgroundColor = UIColor(hex: 0xD8D8D8)//SColors.Theme
            }else{
                cell.statusUpperJointView.backgroundColor = UIColor(hex: 0xD8D8D8)
            }
            cell.statusUpperJointView.isHidden = false
        }
        
        if indexPath.row == statusArray.count - 1 {
            cell.statusDownJointView.isHidden = true
        }else{
            if statusArray[indexPath.row + 1].get("eCompleted") == "Yes" {
                cell.statusDownJointView.backgroundColor = UIColor(hex: 0xD8D8D8)//SColors.Theme
            }else
            {
                cell.statusDownJointView.backgroundColor = UIColor(hex: 0xD8D8D8)
            }
            cell.statusDownJointView.isHidden = false
            
        }
        
        cell.statusHLbl.text = statusArray[indexPath.row].get("vStatus")
        if statusArray[indexPath.row].get("eCompleted") == "Yes" {
            if statusArray[indexPath.row].get("dDate") != "" {
                
                
                print(Utils.convertDateGregorianToAppLocale(date: statusArray[indexPath.row].get("dDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"))
               
                let mainDateStr = Utils.convertDateToFormate(date: Utils.convertStringToDate(dateStr: statusArray[indexPath.row].get("dDate"), dateFormat: "yyyy-MM-dd HH:mm:ss"), formate: "hh:mm aa")
                
                let newDateString = mainDateStr.components(separatedBy: " ")
                
                let attributedString = NSMutableAttributedString(string: mainDateStr)
                let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: SColors.Theme, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                attributedString.addAttributes(yourOtherAttributes, range: NSMakeRange(0, newDateString[0].count))
                
                let yourOtherAttributes2 = [NSAttributedString.Key.foregroundColor: SColors.Theme, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
                attributedString.addAttributes(yourOtherAttributes2, range: NSMakeRange(newDateString[0].count, newDateString[1].count))
                
                cell.timeLbl.attributedText = attributedString
            }
            
            cell.timeLbl.isHidden = false
            cell.timeView.isHidden = false
                print(statusArray[indexPath.row].get("dDate"))
            if statusArray[indexPath.row].get("iStatusCode") == statusArray[indexPath.row].get("OrderCurrentStatusCode") {
                cell.statusImgParentView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }else{
                cell.statusImgParentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            
            cell.statusImgParentView.backgroundColor = SColors.Theme
            cell.statusImgParentView.layer.borderColor = SColors.Theme.cgColor
            cell.statusHLbl.textColor = SColors.blackColor//SColors.Theme
            cell.timeLbl.textColor = SColors.Theme
            cell.highLiteView.backgroundColor = SColors.blackColor
            GeneralFunctions.setImgTintColor(imgView: cell.statusImgView, color: SColors.ThemeTxt)
        }else{
            cell.timeView.isHidden = true
            cell.timeLbl.isHidden = true
            cell.statusImgParentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            cell.statusImgParentView.backgroundColor = UIColor(hex: 0xEEF1F1)
            
            cell.statusHLbl.textColor = SColors.blackColor
            cell.timeLbl.textColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: cell.statusImgView, color: UIColor.black)
        }
        cell.statusLbl.text = statusArray[indexPath.row].get("vStatus_Track")
        
        
        GeneralFunctions.setImgTintColor(imgView: cell.callImgView, color: SColors.Theme)
        
        cell.callImgView.handleClick { (instance) in
            let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
            if statusArray[indexPath.row].get("eShowCallImg") == "Yes"
            {
                /* IF SYNCH ENABLE CALL DIRECTLY TO THE APP.*/
                if self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == "VOIP"{
                    //  if SinchCalling.getInstance().client.isStarted(){
                    
                    var imgName = ""
                    if(statusArray.count > 0){
                        imgName = statusArray[0].get("driverImage")
                    }
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType]
                    let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver"]
                    SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
                    
                    return
                    // }
                }else if(self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == Utils.VIDEOCALL){
                    var imgName = ""
                    if(statusArray.count > 0){
                        imgName = statusArray[0].get("driverImage")
                    }
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType, "isVideoCall":"Yes"]
                    let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver", "isVideoCall":"Yes"]
                    SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
                    
                    return
                }else if (self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == Utils.VOIP_VIDEOCALL) {
                    let openListView = OpenListView(uv: self, containerView: self.view)
                    openListView.openNewList = true
                    openListView.isFromDate = true
                    openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                                   // 0 for video 1 for camera
                    if selectedItemId == 0 {

                                                var imgName = ""
                                                if(statusArray.count > 0){
                                                    imgName = statusArray[0].get("driverImage")
                                                }
                                                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                                        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType, "isVideoCall":"Yes"]
                                                let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver", "isVideoCall":"Yes"]
                                                SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
                        //
                        //                        return
                    }else {
                        var imgName = ""
                        if(statusArray.count > 0){
                            imgName = statusArray[0].get("driverImage")
                        }
                        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType]
                        let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver"]
                        SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
                        
                        return
                        
                    }
                    
                    })
                    return
                }
                
                if(self.userProfileJson.get("CALLMASKING_ENABLED").uppercased() == "YES"){
                    let parameters = ["type":"getCallMaskNumber","iOrderId": self.orderId, "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
                    
                    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
                    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                        if(response != ""){
                            let dataDict = response.toDict()
                            
                            if(dataDict.get("Action") == "1"){
                                
                                if let PhoneNo = NSURL(string:"telprompt:" + dataDict.get(Utils.message_str)){
                                    UIApplication.shared.openURL(PhoneNo as URL)
                                }else{
                                    UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                                }
                            }else{
                                UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                            }
                            
                        }else{
                            self.generalFunc.setError(uv: self)
                        }
                    })
                }else{
                    UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if(Application.screenSize.height > 568){
        //            return 120
        //        }else{
        //            return 120
        //        }
        return  self.rowHeight[indexPath.row] - 10
    }
    
    @objc func displayMapAccordingState() {
        if self.dataDict.get("OrderCurrentStatusCode") != "9" {
            if self.dataDict.get("eDisplayDottedLine") == "Yes" {
                buildArcPath(fromLoc: self.currentLocation, toLoc: self.destLocation, arcCurvature: 0.20)
            }else{
                self.assignedDriverId = self.dataDict.get("iDriverId")
                self.driverPhone = self.dataDict.get("DriverPhone")
                
                if self.polyline != nil{
                    self.polyline.map = nil
                }
                if(self.driverMarker != nil){
                    self.driverMarker.map = nil
                }
                
                var driverLat = self.dataDict.get("DriverLat")
                var driverLong = self.dataDict.get("DriverLong")
                
                if self.dataDict.get("eTakeAway") == "Yes"{
                    driverLat = self.dataDict.get("CompanyLat")
                    driverLong = self.dataDict.get("CompanyLong")
                }
                
                if(driverLat != "" && driverLong != ""){
                    self.driverLocation = CLLocation(latitude: Double(driverLat)!, longitude: Double(driverLong)!)
                    self.driverMarker = GMSMarker()
                    self.driverMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    self.driverMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                    self.driverMarker.isFlat = true
                    self.driverMarker.icon = UIImage(named: "ic_delBike")
                    self.driverMarker.position = CLLocation(latitude: Double(driverLat)!, longitude: Double(driverLong)!).coordinate
                    self.driverMarker.map = self.gMapView
                    
                    let firstLocation = self.driverMarker.position
                    var bounds = GMSCoordinateBounds.init(coordinate: firstLocation, coordinate: firstLocation);
                    
                    bounds = bounds.includingCoordinate(self.destPointMarker.position)
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 45.0)
                    
                    if(self.gMapView != nil){
                        self.gMapView.animate(with: update)
                    }
                    
                }
                

                if(self.driverMarker != nil){
                    let firstLocation = self.driverMarker.position
                    var bounds = GMSCoordinateBounds.init(coordinate: firstLocation, coordinate: firstLocation);
                    
                    bounds = bounds.includingCoordinate(self.destPointMarker.position)
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 45.0)
                    if(self.gMapView != nil){
                        self.gMapView.animate(with: update)
                    }
                }
                
                

            }
            
            if self.dataDict.get("eDisplayRouteLine") == "No" && self.dataDict.get("eDisplayDottedLine") == "No"{
                self.drawRouteAfterDriverPickedFood(drawRoute:false)
                if isContactLess == false && isTakeAway == false{
                    self.kTableHeaderHeight = 280 - 40
                }
                DispatchQueue.main.async {
                   // self.tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: self.kTableHeaderHeight)
                   // self.tableBottomView.isHidden = true
                    
                    //self.tableView.tableHeaderView = self.tableHeaderView
                    //self.tableView.layoutIfNeeded()
                   // self.tableView.setNeedsLayout()
                }
                //self.tableView.reloadData()
                
            }else if self.dataDict.get("eDisplayRouteLine") == "Yes"{
                if isContactLess == false && isTakeAway == false{
                    self.kTableHeaderHeight = 280 - 40
                }
//                DispatchQueue.main.async {
//                    self.tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: self.kTableHeaderHeight)
//                    self.tableBottomView.isHidden = false
//                    self.tableView.tableHeaderView = self.tableHeaderView
//                    self.tableView.layoutIfNeeded()
//                    self.tableView.setNeedsLayout()
//                }
                //self.tableView.reloadData()
                self.drawRouteAfterDriverPickedFood(drawRoute:true)
            }else{
                //self.kTableHeaderHeight = 240
                if isContactLess == false && isTakeAway == false{
                    self.kTableHeaderHeight = 280 - 40
                }
                DispatchQueue.main.async {
                    //self.tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: self.kTableHeaderHeight)
                    //self.tableView.tableHeaderView = self.tableHeaderView
                    self.tableView.layoutIfNeeded()
                    self.tableView.setNeedsLayout()
                    //self.tableBottomView.isHidden = true
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func setData(){
        
        self.destLocation = CLLocation(latitude: Double(self.dataDict.get("CompanyLat"))!, longitude: Double(self.dataDict.get("CompanyLong"))!)
        
        var passengerLat = self.dataDict.get("PassengerLat")
        var passengerLong = self.dataDict.get("PassengerLong")
        
        if self.dataDict.get("eTakeAway") == "Yes"{
            passengerLat = self.dataDict.get("CompanyLat")
            passengerLong = self.dataDict.get("CompanyLong")
        }
        
        if passengerLat != "" && passengerLong != ""{
            self.currentLocation = CLLocation(latitude: Double(passengerLat)!, longitude: Double(passengerLong)!)
            let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude, zoom: Utils.defaultZoomLevel)
            let cameraUpdate = GMSCameraUpdate.setCamera(camera)
            
            if(self.gMapView != nil){
                self.gMapView.moveCamera(cameraUpdate)
                self.gMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
            }
        }
        
        
        pickUpAddress = self.dataDict.get("DeliveryAddress")
        destAddress = self.dataDict.get("CompanyAddress")
        
        addPickUpMarker()
        
        addPickupAddressView(displayEta:false)
        addDestAddressView()
        
        addPickUpMarker()
        addDestMarker()
        
        self.perform(#selector(self.displayMapAccordingState), with: self, afterDelay: 0.5)
        //displayMapAccordingState()
    }
    
    
    func addPickupAddressView(displayEta:Bool){
        
        let pickUpMarkerView = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
        pickUpMarkerView.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 40))
        
        
        label.textAlignment = .center
        if displayEta == false{
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(hex: 0x1e5b99)
            label.text = self.pickUpAddress
        }else
        {
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(hex: 0x1e5b99)
            label.text = self.pickUpAddress
            //label.font = UIFont.systemFont(ofSize: 14)
            //label.textColor = UIColor.black
            // label.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ETA_TXT") + ": " + self.ETATime
            self.ETATimeHLbl.text = self.ETATime
        }
        
        
        label.numberOfLines = 2
        pickUpMarkerView.addSubview(label)
        
        let markerImage = pickUpMarkerView.getImage()
        
        let markerView = UIImageView(image: markerImage)
        markerView.layer.shadowOpacity = 0.2
        markerView.layer.shadowColor = UIColor.black.cgColor
        markerView.layer.shadowRadius = 15
        
        let groundAnchorPoint = CGPoint(-0.05, 1.95)

        //        if(self.pickUpCustomMarker != nil){
        //            groundAnchorPoint = self.pickUpCustomMarker.groundAnchor
        //            self.pickUpCustomMarker.map = nil
        //        }
        
        if self.pickUpCustomMarker != nil
        {
            self.pickUpCustomMarker.map = nil
        }
        self.pickUpCustomMarker = GMSMarker()
        self.pickUpCustomMarker.groundAnchor = groundAnchorPoint
        if(self.currentLocation != nil){
            self.pickUpCustomMarker.position = CLLocationCoordinate2D(latitude: self.currentLocation!.coordinate.latitude, longitude: self.currentLocation!.coordinate.longitude)
        }
            
        
        //        self.pickUpCustomMarker.position = CLLocationCoordinate2D(latitude: self.currentLocation1.coordinate.latitude, longitude: self.currentLocation1.coordinate.longitude)
        
        self.pickUpCustomMarker.iconView = markerView
        
        self.pickUpCustomMarker.map = self.gMapView
    }
    
    func addDestAddressView(){
        let pickUpMarkerView = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
        pickUpMarkerView.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
        
        pickUpMarkerView.backgroundColor = UIColor(hex: 0x373737)
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 40))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = self.destAddress
        label.textColor = UIColor.white
        label.numberOfLines = 2
        pickUpMarkerView.addSubview(label)
        
        let markerImage = pickUpMarkerView.getImage()
        
        let markerView = UIImageView(image: markerImage)
        markerView.layer.shadowOpacity = 0.2
        markerView.layer.shadowColor = UIColor.black.cgColor
        markerView.layer.shadowRadius = 15
        
        let groundAnchorPoint = CGPoint(0.5, 0)
        //        if(self.dropOffCustomMarker != nil){
        //            groundAnchorPoint = self.dropOffCustomMarker.groundAnchor
        //            self.dropOffCustomMarker.map = nil
        //        }
        
        self.dropOffCustomMarker = GMSMarker()
        self.dropOffCustomMarker.groundAnchor = groundAnchorPoint
        self.dropOffCustomMarker.position = CLLocationCoordinate2D(latitude: self.destLocation!.coordinate.latitude, longitude: self.destLocation!.coordinate.longitude)
        self.dropOffCustomMarker.iconView = markerView
        
        self.dropOffCustomMarker.map = self.gMapView
    }
    
    func onLocationUpdate(location: CLLocation) {
        
    }
    
    func buildArcPath(fromLoc:CLLocation, toLoc:CLLocation, arcCurvature:Double){
        if self.gMapView == nil{
            return
        }
        var fromLocation = fromLoc
        var toLocation = toLoc
        let maxZoomLevel = self.gMapView.maxZoom
        self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: self.gMapView.maxZoom - 5)
        
        
        var distance = SphericalUtil.computeDistanceBetween(from: fromLocation, to: toLocation)
        var heading = SphericalUtil.computeHeading(from: fromLocation, to: toLocation)
        
        if(heading < 0){
            let tmpFromLoc = fromLocation
            fromLocation = toLocation
            toLocation = tmpFromLoc
            
            distance = SphericalUtil.computeDistanceBetween(from: fromLocation, to: toLocation)
            heading = SphericalUtil.computeHeading(from: fromLocation, to: toLocation)
        }
        
        let midPointLnt = SphericalUtil.computeOffset(from: fromLocation, distance: distance * 0.5, heading: heading)
        
        let x:Double = ((1 - (arcCurvature * arcCurvature)) * (distance * 0.5)) / (2 * arcCurvature)
        let r:Double = ((1 + (arcCurvature * arcCurvature)) * (distance * 0.5)) / (2 * arcCurvature)
        
        let centerLnt = SphericalUtil.computeOffset(from: midPointLnt, distance: x, heading: heading + 90.0)
        
        let heading1 = SphericalUtil.computeHeading(from: centerLnt, to: fromLocation)
        let heading2 = SphericalUtil.computeHeading(from: centerLnt, to: toLocation)
        
        let numPoints = 100.0
        let step = (heading2 - heading1) / numPoints
        
        let path = GMSMutablePath()
        var bounds = GMSCoordinateBounds()
        
        for i in 0 ..< Int(numPoints) {
            let tempLoc = SphericalUtil.computeOffset(from: centerLnt, distance: r, heading: heading1 + (Double(i) * step))
            Utils.printLog(msgData: "TempLocation::\(tempLoc)")
            path.addLatitude(tempLoc.coordinate.latitude, longitude: tempLoc.coordinate.longitude)
            bounds =  bounds.includingCoordinate(tempLoc.coordinate)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 45)
        polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 2.0
        polyline.geodesic = true
        let dist  = self.currentLocation.distance(from: self.destLocation)
        
        let styles: [Any] = [GMSStrokeStyle.solidColor(UIColor.black), GMSStrokeStyle.solidColor(UIColor.clear)]
        let lengths: [Any] = [dist/40,dist/65]
        polyline.spans = GMSStyleSpans(polyline.path!, styles as! [GMSStrokeStyle], lengths as! [NSNumber], GMSLengthKind.rhumb)
        polyline.map = self.gMapView
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: maxZoomLevel)
        }
        
        //        self.gMapView.animate(with: update)
        self.gMapView.moveCamera(update)
        CATransaction.commit()
    }
    
    func boundMapFromSourceToDest(){
        let maxZoomLevel = self.gMapView.maxZoom
        self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: self.gMapView.maxZoom - 5)
        
        var bounds = GMSCoordinateBounds()
        
        if(self.currentLocation != nil && self.currentLocation.coordinate.latitude != 0.0){
            bounds =  bounds.includingCoordinate(self.currentLocation.coordinate)
        }
        
        if(self.destLocation != nil && self.destLocation.coordinate.latitude != 0.0){
            bounds =  bounds.includingCoordinate(self.destLocation.coordinate)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        
        if(self.currentLocation != nil && self.currentLocation.coordinate.latitude != 0.0 && self.destLocation != nil && self.destLocation.coordinate.latitude != 0.0 ){
            
            let path = GMSMutablePath()
            path.addLatitude(self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
            path.addLatitude(self.destLocation.coordinate.latitude, longitude: self.destLocation.coordinate.longitude)
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 2.0
            polyline.geodesic = true
            let distance  = self.currentLocation.distance(from: self.destLocation)
            let styles: [Any] = [GMSStrokeStyle.solidColor(UIColor.black), GMSStrokeStyle.solidColor(UIColor.clear)]
            let lengths: [Any] = [distance/15,distance/35]
            Utils.printLog(msgData: "Lengths::\(lengths)")
            polyline.spans = GMSStyleSpans(polyline.path!, styles as! [GMSStrokeStyle], lengths as! [NSNumber], GMSLengthKind.rhumb)
            polyline.map = self.gMapView
        }
        
        if(self.gMapView != nil){
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: maxZoomLevel)
            }
            
            //        self.gMapView.animate(with: update)
            self.gMapView.moveCamera(update)
            CATransaction.commit()
        }
    }
    
    func addPickUpMarker(){
        if( self.currentLocation != nil){
            if(self.pickUpPointMarker != nil){
                self.pickUpPointMarker.map = nil
            }
            self.pickUpPointMarker = GMSMarker()
            self.pickUpPointMarker.icon = UIImage(named: "ic_user_marker")
            self.pickUpPointMarker.position = self.currentLocation.coordinate
            self.pickUpPointMarker.map = self.gMapView
            
        }
    }
    
    func addDestMarker(){
        if( self.destLocation != nil){
            if(self.destPointMarker != nil){
                self.destPointMarker.map = nil
            }
            self.destPointMarker = GMSMarker()
            self.destPointMarker.icon = UIImage(named: "ic_restaurant_marker")
            self.destPointMarker.position = self.destLocation.coordinate
            self.destPointMarker.map = self.gMapView
            
        }
    }
    
    
    func drawRouteAfterDriverPickedFood(drawRoute:Bool){
        
        subscribeToDriverLocChannel()
        
        if(drawRoute == true && self.gMapView != nil){
            self.updateDirection = UpdateDirections(uv: self, gMap: self.gMapView, fromLocation: driverLocation, destinationLocation: self.currentLocation, isCurrentLocationEnabled: false)
            self.updateDirection.onDirectionUpdateDelegate = self
            self.updateDirection.scheduleDirectionUpdate(eTollSkipped: "")
        }
        
        updateAssignedDriverMarker(driverLocation: driverLocation, dataDict: nil)
       // if self.currentLocation != nil{
            addWaitingMarker(fromLocation: driverLocation, toLocation: self.currentLocation, waitingTime: "")
       // }
        
        if(self.toPubNub().uppercased() == "NO" && drawRoute == true){
            
            let DRIVER_LOC_FETCH_TIME_INTERVAL = GeneralFunctions.parseDouble(origValue: 5, data: self.userProfileJson.get("DRIVER_LOC_FETCH_TIME_INTERVAL"))
            updateFreqDriverLocTask = TaskScheduler(interval: DRIVER_LOC_FETCH_TIME_INTERVAL)
            updateFreqDriverLocTask.currInst = updateFreqDriverLocTask
            updateFreqDriverLocTask.setTaskRunListener(onTaskRunCalled: self)
            updateFreqDriverLocTask.startRepeatingTask()
        }
        
    }
    
    func addWaitingMarker(fromLocation:CLLocation, toLocation:CLLocation, waitingTime:String){
        
        var minTime = "--"
        if(waitingTime != ""){
            
            minTime = Utils.formateSecondsToHours(seconds: waitingTime)
            
            
        }else{
            var DRIVER_ARRIVED_MIN_TIME_PER_MINUTE:Double = 3
            DRIVER_ARRIVED_MIN_TIME_PER_MINUTE = GeneralFunctions.parseDouble(origValue: 3, data: userProfileJson.get("DRIVER_ARRIVED_MIN_TIME_PER_MINUTE"))
            
            var distance = fromLocation.distance(from: toLocation) / 1000
            
            if(fromLocation.coordinate.latitude == 0.0 || fromLocation.coordinate.longitude == 0.0 || toLocation.coordinate.latitude == 0.0 || toLocation.coordinate.longitude == 0.0){
                distance = 0
            }
            
            let lowestTime = distance * DRIVER_ARRIVED_MIN_TIME_PER_MINUTE
            
            let lowestTime_int = Int(lowestTime)
            
            if(lowestTime_int < 1){
                minTime = "--"
            }else{
                //                minTime = "\(lowestTime_int)"
                minTime = Utils.formateSecondsToHours(seconds: "\(lowestTime_int)")
                
            }
        }
        
        self.ETATime = minTime.replace("\n", withString: " ")
        if self.globlaPullContorleer != nil {
            self.globlaPullContorleer.etaTimeLbl.text = self.ETATime
        }
        self.addPickupAddressView(displayEta: true)
    }
    
    func onTaskRun(currInst: TaskScheduler) {
        if(currInst == self.animTask){
            
            if (self.i_anim < self.animLocationArr.count) {
                
                self.animationPath.add(self.animLocationArr[i_anim])
                self.animationPolyline.path = self.animationPath
                
                self.animationPolyline.strokeColor = UIColor.gray
                self.animationPolyline.strokeWidth = 5
                
                self.animationPolyline.map = self.gMapView
                
                self.i_anim += 1
            }
            else {
                self.i_anim = 0
                self.animationPath = GMSMutablePath()
                self.animationPolyline.map = nil
            }
            
            return
        }
        checkDriverLocation()
    }
    
    func subscribeToDriverLocChannel(){
        var channels =  [String]()
        channels += [Utils.PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_DRIVER+self.assignedDriverId]
        
        for i in 0..<channels.count{
            
            AppService.getInstance().executeService(data: EventInformationBuilder().setChanelList(channel_list: channels[i]).build(), event: .SUBSCRIBE)
        }
        
    }
    
    func unSubscribeToDriverLocChannel(){
        var channels =  [String]()
        channels += [Utils.PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_DRIVER+self.assignedDriverId]
        for i in 0..<channels.count{
            
            AppService.getInstance().executeService(data: EventInformationBuilder().setChanelList(channel_list: channels[i]).build(), event: .UNSUBSCRIBE)
        }
    }
    
    
    
    func checkDriverLocation(){
        
        let parameters = ["type":"getDriverLocations", "iUserId": GeneralFunctions.getMemberd(), "iDriverId": self.assignedDriverId, "UserType": Utils.appUserType, "eSystem":"DeliverAll"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let vLatitude = dataDict.get("vLatitude")
                    let vLongitude = dataDict.get("vLongitude")
                    _ = dataDict.get("vTripStatus")
                    
                    
                    if(vLatitude != "" && vLatitude != "0.0" && vLatitude != "-180.0" && vLongitude != "" && vLongitude != "0.0" && vLongitude != "-180.0"){
                        
                        self.updateAssignedDriverMarker(driverLocation: CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: vLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: vLongitude)), dataDict: nil)
                    }
                }else{
                    //                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                //                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    func updateAssignedDriverMarker(driverLocation:CLLocation, dataDict:NSDictionary?){
        
        self.driverLocation = driverLocation
        
        
        if self.updateDirection != nil{
            self.updateDirection.userLocation = self.driverLocation
        }
        if(self.driverMarker == nil){
            let driverMarker = GMSMarker()
            self.driverMarker = driverMarker
        }
        
        var rotationAngle:Double = -1
        if(assignedDriverRotatedLocation != nil){
            rotationAngle = assignedDriverRotatedLocation.bearingToLocationDegrees(destinationLocation: driverLocation, currentRotation: self.driverMarker.rotation)
            if(rotationAngle != -1){
                assignedDriverRotatedLocation = driverLocation
            }
        }else{
            assignedDriverRotatedLocation = driverLocation
        }
        
        
        Utils.updateMarkerOnTrip(marker: self.driverMarker, googleMap: self.gMapView, coordinates: driverLocation.coordinate, rotationAngle: rotationAngle, duration: 0.8, iDriverId: self.assignedDriverId, LocTime: "", isMoveMapToLocation: true)
        
        
        self.driverMarker.icon = UIImage(named: "ic_delBike")
        self.driverMarker.map = self.gMapView
        self.driverMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        self.driverMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        self.driverMarker.isFlat = true
        
        if(isMapMoveToDriverLoc == false && self.gMapView != nil){
            
            let firstLocation = self.driverMarker.position
            var bounds = GMSCoordinateBounds.init(coordinate: firstLocation, coordinate: firstLocation);
            
            //if self.currentLocation != nil{
                bounds = bounds.includingCoordinate(self.pickUpPointMarker.position)
            //}
            
            let update = GMSCameraUpdate.fit(bounds, withPadding: 45.0)
            self.gMapView.animate(with: update)
            
            isMapMoveToDriverLoc = true
        }
        
    }
    
    func onDirectionUpdate(directionResultDict: NSDictionary) {
        
        let value = 0.0
        if(directionResultDict.arrOf("pointsArray").count > 0){
            
            let value = directionResultDict.get("duration")
            addWaitingMarker(fromLocation: self.driverLocation, toLocation: self.currentLocation, waitingTime: "\(value)")
        }
        
        
        if(lastArrivingNotificationTime != nil && (Utils.currentTimeMillis() - lastArrivingNotificationTime) > 59000){
            return
        }
        if(value == 0.0 && arrivingNotificationCounter1 == false)
        {
            
            arrivingNotificationCounter1 = true
        }
        else if(value <= 3.0 && arrivingNotificationCounter2 == false)
        {
            setArrivingNotification()
            arrivingNotificationCounter2 = true
        }
        else if(value <= 1.0 && arrivingNotificationCounter3 == false)
        {
            setArrivingNotification()
            arrivingNotificationCounter3 = true
        }
        
    }
    
    func setArrivingNotification()
    {
        let localNotification = UILocalNotification()
        localNotification.fireDate =  NSDate(timeIntervalSinceNow: 2) as Date
        localNotification.alertBody = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_ARRIVING_TXT")
        
        //localNotification.timeZone = NSTimeZone.init(name: "GMT") as TimeZone?
        
        if(GeneralFunctions.getValue(key: Utils.USER_NOTIFICATION) as! String != ""){
            localNotification.soundName = GeneralFunctions.getValue(key: Utils.USER_NOTIFICATION) as? String
        }else{
            localNotification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
        lastArrivingNotificationTime = Utils.currentTimeMillis()
    }
    
    @objc func menuClicked(){
        openPopUpMenu()
    }
    
    func openPopUpMenu(){
        initializeMenu()
        if(menu.isShown){
            menu.hideMenu()
            return
        }else{
            menu.showMenu()
        }
    }
    
    func initializeMenu(){
        
        var items = [NSDictionary]()
        
        items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_ORDER_DETAILS"),"ID" : MENU_ORDERDETAIL] as NSDictionary)
        
        if(self.userProfileJson.get("ENABLE_TIP_MODULE_DELIVERALL").uppercased() == "YES" && self.isShowTipView == true){
            items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_TIP_TITLE_TXT"),"ID" : MENU_TIP] as NSDictionary)
        }
        if(self.userProfileJson.get("ENABLE_LIVE_CHAT_TRACK_ORDER").uppercased() == "YES"){
        self.configLiveChat()
        items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LIVE_CHAT"),"ID" : LIVE_CHAT] as NSDictionary)
           
        }
        items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HELP"),"ID" : MENU_HELP] as NSDictionary)
        
        if(self.menu == nil){
            menu = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "", items: items)
            
            menu.cellHeight = 50
            menu.cellBackgroundColor = SColors.Theme
            menu.cellSelectionColor = SColors.Theme
            menu.cellTextLabelColor = SColors.ThemeTxt
            menu.cellTextLabelFont = UIFont(name: Fonts().regular, size: 16)
            menu.cellSeparatorColor = SColors.Theme
            
            if(Configurations.isRTLMode()){
                menu.cellTextLabelAlignment = NSTextAlignment.right
            }else{
                menu.cellTextLabelAlignment = NSTextAlignment.left
            }
            menu.arrowPadding = 15
            menu.animationDuration = 0.5
            menu.maskBackgroundColor = UIColor.black
            menu.maskBackgroundOpacity = 0.5
            menu.menuStateHandler = { (isMenuOpen: Bool) -> () in
                
            }
            menu.didSelectItemAtIndexHandler = {(indexID: String) -> () in
                
                if(indexID == self.MENU_ORDERDETAIL){
                    let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
                    orderDetailsUv.orderId =  self.orderId
                    orderDetailsUv.isShowTip = self.isShowTipView
                    self.push(uv: orderDetailsUv)
                }else if(indexID == self.MENU_HELP)
                {
                    let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
                    helpCategoryUv.iTripId =  self.orderId
                    helpCategoryUv.eSystem = "DeliverAll"
                    self.push(uv: helpCategoryUv)
                }else if(indexID == self.MENU_TIP)
                {
                    self.openTipView()
                }
                else if (indexID == self.LIVE_CHAT){
                    self.openLiveChat()
                }
            }
        }else{
            menu.updateItems(items)
        }
       
    }
    
    func openTipView(){
        
        self.tipBGView = UIView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
        self.tipBGView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Application.window?.addSubview(self.tipBGView)
        
        self.tipView = TipLiveTrackView(frame: CGRect(x: 15, y: Int((Application.screenSize.height / 2) - (500 / 2)), width: Int(Application.screenSize.width - 30), height: 400))
        
        self.tipView.tipHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_TIP_TITLE_TXT")
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipHintImgView, color: SColors.Theme)
        
        self.tipView.submiBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIVE_TIP"))
        self.tipView.closeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_THANKS")
        self.tipView.closeLbl.textColor = UIColor(hex: 0x284552)
        
        self.tipView.submiBtn.clickDelegate = self
        
        Application.window?.addSubview(self.tipView)
        
        self.tipView.closeLbl.handleClick { (instance) in
            self.tipAmount = ""
            self.closeTipView()
        }
        
        self.tipView.tipHintImgView.handleClick { (instance) in
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.isTip = true
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIP_DESC"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_DIALOG_TITLE"))
        }
        
        self.setTipSubView()
        
    }
    
    func setTipSubView(){
        
        self.tipView.tipSubViewHeight.constant = 100
        
        self.tipView.tipAmoOtherConfImgView.backgroundColor = SColors.Theme
        self.tipView.tipAmoOtherConfImgView.image = UIImage(named:"ic_btn_rightarrow")?.addImagePadding(x: 150, y: 150)
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipAmoOtherConfImgView, color: SColors.ThemeTxt)
        
        self.tipView.tipAmoTxtFiled.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT")
        self.tipView.tipAmoTxtFiled.delegate = self
        self.tipView.tipAmoTxtFiled.keyboardType = .decimalPad
    
        if(self.userProfileJson.get("DELIVERY_TIP_AMOUNT_TYPE_DELIVERALL").uppercased() == "PERCENTAGE"){
            self.tipView.tipAmoLbl1.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_1"))
            self.tipView.tipAmoLbl2.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_2"))
            self.tipView.tipAmoLbl3.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_3"))
        }else{
            self.tipView.tipAmoLbl1.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_1"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
                //userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_1"))
            self.tipView.tipAmoLbl2.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_2"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
                //userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_2"))
            self.tipView.tipAmoLbl3.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_3"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
            //userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_3"))
        }
        
        
        
        self.tipView.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
        self.tipView.tipRequiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REQUIRED")
        
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipAmoImgView1, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipAmoImgView2, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipAmoImgView3, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipView.tipAmoOtherImgView, color: UIColor.black)
        
        self.tipView.tipAmoOtherConfImgView.handleClick { (instance) in
            
            if(self.tipView.tipAmoTxtFiled.text != "" && GeneralFunctions.parseDouble(origValue: 0, data: self.tipView.tipAmoTxtFiled.text!) > 0){
                self.tipAmount = self.tipView.tipAmoTxtFiled.text!
                self.tipView.tipAmoOtherLbl.text = self.userProfileJson.get("CurrencySymbol") + self.tipAmount
                self.tipView.tipAmoOtherImgView.isHidden = false
                
                self.tipPosition = "4"
                self.tipView.tipAmoTxtFiled.text = ""
                self.setTipAmountValue()
                
            }else{
                
                self.tipView.tipRequiredLbl.isHidden = false
                self.tipView.tipAmoOtherValueView.borderColor = SColors.red
                
            }
        }
        
        self.tipView.tipAmoImgView1.handleClick { (instance) in
            self.tipView.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipView.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView1.isHidden = true
            
            self.tipAmount = ""
            self.tipPosition = ""
            self.tipView.tipAmountLbl.isHidden = true
        }
        
        self.tipView.tipAmoImgView2.handleClick { (instance) in
            self.tipView.tipAmoView2.borderColor = UIColor.lightGray
            self.tipView.tipAmoView2.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView2.isHidden = true
            
            self.tipAmount = ""
            self.tipPosition = ""
            self.tipView.tipAmountLbl.isHidden = true
        }
        
        self.tipView.tipAmoImgView3.handleClick { (instance) in
            self.tipView.tipAmoView3.borderColor = UIColor.lightGray
            self.tipView.tipAmoView3.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView3.isHidden = true
            
            self.tipAmount = ""
            self.tipPosition = ""
            self.tipView.tipAmountLbl.isHidden = true
        }
        
        self.tipView.tipAmoOtherImgView.handleClick { (instance) in
            self.tipView.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipView.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipView.tipAmoOtherImgView.isHidden = true
            self.tipView.tipAmoOtherValueView.isHidden = true
            self.tipAmount = ""
            self.tipPosition = ""
            self.tipView.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
            self.tipView.tipAmoTxtFiled.text = ""
            self.tipView.tipSubViewHeight.constant = 100
            self.tipView.tipAmountLbl.isHidden = true
        }
        
        self.tipView.tipAmoVIew1.handleClick { (instance) in
            
            self.tipView.tipAmoVIew1.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipView.tipAmoVIew1.borderColor = SColors.Theme
            self.tipView.tipAmoImgView1.isHidden = false
            self.tipView.tipAmoLbl1.paddingLeft = 20
            self.tipView.tipAmoLbl1.paddingRight = 20
            
            self.tipView.tipAmoView2.borderColor = UIColor.lightGray
            self.tipView.tipAmoView2.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView2.isHidden = true
            
            self.tipView.tipAmoView3.borderColor = UIColor.lightGray
            self.tipView.tipAmoView3.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView3.isHidden = true
            
            self.tipView.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipView.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipView.tipAmoOtherImgView.isHidden = true
            
            self.tipView.tipSubViewHeight.constant = 100
            self.tipView.tipAmoOtherValueView.isHidden = true
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_1")
            self.tipPosition = "1"
            
            self.setTipAmountValue()
        }
        
        self.tipView.tipAmoView2.handleClick { (instance) in
            self.tipView.tipAmoView2.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipView.tipAmoView2.borderColor = SColors.Theme
            
            self.tipView.tipAmoImgView2.isHidden = false
            self.tipView.tipAmoLbl2.paddingLeft = 20
            self.tipView.tipAmoLbl2.paddingRight = 20
            
            self.tipView.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipView.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView1.isHidden = true
            
            self.tipView.tipAmoView3.borderColor = UIColor.lightGray
            self.tipView.tipAmoView3.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView3.isHidden = true
            
            self.tipView.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipView.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipView.tipAmoOtherImgView.isHidden = true
            
            self.tipView.tipSubViewHeight.constant = 100
            self.tipView.tipAmoOtherValueView.isHidden = true
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_2")
            self.tipPosition = "2"
            
            self.setTipAmountValue()
        }
        
        self.tipView.tipAmoView3.handleClick { (instance) in
            self.tipView.tipAmoView3.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipView.tipAmoView3.borderColor = SColors.Theme
            self.tipView.tipAmoImgView3.isHidden = false
            self.tipView.tipAmoLbl3.paddingLeft = 20
            self.tipView.tipAmoLbl3.paddingRight = 20
            
            self.tipView.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipView.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView1.isHidden = true
            
            self.tipView.tipAmoView2.borderColor = UIColor.lightGray
            self.tipView.tipAmoView2.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView2.isHidden = true
            
            self.tipView.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipView.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipView.tipAmoOtherImgView.isHidden = true
            
            self.tipView.tipSubViewHeight.constant = 100
            self.tipView.tipAmoOtherValueView.isHidden = true
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_3")
            self.tipPosition = "3"
            
            self.setTipAmountValue()
        }
        
        self.tipView.tipAmoOtherView.handleClick { (instance) in
            self.tipView.tipAmoOtherView.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipView.tipAmoOtherView.borderColor = SColors.Theme
            if(self.tipAmount != ""){
                self.tipView.tipAmoOtherImgView.isHidden = false
            }else{
                self.tipView.tipAmoOtherImgView.isHidden = false
            }
            self.tipPosition = "4"
            self.tipView.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipView.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView1.isHidden = true
            
            self.tipView.tipAmoView2.borderColor = UIColor.lightGray
            self.tipView.tipAmoView2.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView2.isHidden = true
            
            self.tipView.tipAmoView3.borderColor = UIColor.lightGray
            self.tipView.tipAmoView3.backgroundColor = UIColor.clear
            self.tipView.tipAmoImgView3.isHidden = true
            
            self.tipView.tipSubViewHeight.constant = 150
            self.tipView.tipAmoOtherValueView.isHidden = false
            self.tipView.tipAmountLbl.isHidden = true
        }
       
        
    }
    
    func setTipAmountValue(){
        
        
       
        self.tipView.tipAmountLbl.isHidden = false
        if(self.tipPosition == "1"){
            
            self.tipView.tipAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT") + ": " + GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.dataDict.get("TIP_AMOUNT_1_VALUE"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))//self.dataDict.get("userCurrencySymbol") + " " + self.dataDict.get("TIP_AMOUNT_1_VALUE")
            
        }else if(self.tipPosition == "2"){
            
            self.tipView.tipAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT") + ": " + GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.dataDict.get("TIP_AMOUNT_2_VALUE"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
            //self.dataDict.get("userCurrencySymbol") + " " + self.dataDict.get("TIP_AMOUNT_2_VALUE")
        }else if(self.tipPosition == "3"){
            
            self.tipView.tipAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT") + ": " + GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.dataDict.get("TIP_AMOUNT_3_VALUE"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
            //self.dataDict.get("userCurrencySymbol") + " " + self.dataDict.get("TIP_AMOUNT_3_VALUE")
        }else{
            self.tipView.tipAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT") + ": " + GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.tipAmount, addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
            //self.dataDict.get("userCurrencySymbol") + " " + self.tipAmount
           // self.tipView.tipAmountLbl.isHidden = true
        }
    }
    
    func closeTipView(){
        
        if(self.tipView != nil){
            self.tipView.removeFromSuperview()
            self.tipBGView.removeFromSuperview()
        }
    }
    
    
    var activityIndicatorWeb:UIActivityIndicatorView!
    
    func updateTipValue(){
        //self.closeTipView()
        var parameters = ["type": "OrderCollectTip", "UserType": Utils.appUserType, "eSystem":"DeliverAll", "iOrderId": self.orderId, "iMemberId": GeneralFunctions.getMemberd()]

        if(self.userProfileJson.get("DELIVERY_TIP_AMOUNT_TYPE_DELIVERALL").uppercased() == "PERCENTAGE"){
            
            if(self.tipPosition == "4"){
                if self.tipView.tipAmoTxtFiled.text != "" {
                parameters["fTipAmount"] = self.tipView.tipAmoTxtFiled.text
                }else{
                    parameters["fTipAmount"] = self.tipAmount
                }//self.tipAmount
            }else{
                parameters["selectedTipPos"] = self.tipPosition
            }
        }else{
            if(self.tipPosition == "4") {
                if self.tipView.tipAmoTxtFiled.text != "" {
                parameters["fTipAmount"] = self.tipView.tipAmoTxtFiled.text
                }else{
                    parameters["fTipAmount"] = self.tipAmount
                }
            }else{
            parameters["fTipAmount"] = self.tipAmount
            }
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.tipView, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in

            if(response != ""){
                let dataDict = response.toDict()

                
                if(dataDict.get("Action") == "1"){
                    self.closeTipView()
                    if(dataDict.get("paymentUrl") != ""){
                        self.webView.isHidden = false
                        self.webView.frame = Application.screenSize
                        self.webView.backgroundColor = UIColor.white
                        self.webView.navigationDelegate = self
                        Application.window?.addSubview(self.webView)
                        
//                        self.backImgView = UIImageView.init(frame: CGRect(x: 20, y:20, width: 30, height:30))
//                        self.backImgView.image = UIImage(named: "ic_cancel_forgotpass")
//                        self.contentView.addSubview(self.backImgView)
//                        self.backImgView.handleClick { (instance) in
//                            self.closeWebView()
//                        }
                        
                        self.activityIndicatorWeb = UIActivityIndicatorView.init(frame: CGRect(x:(self.webView.frame.width / 2) - 10, y:(self.webView.frame.height / 2) - 10, width: 20, height:20))
                        self.activityIndicatorWeb.style = .gray
                        self.activityIndicatorWeb.hidesWhenStopped = true
                        self.webView.addSubview(self.activityIndicatorWeb)
                        
                        let urlString = dataDict.get("paymentUrl").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let url = URL.init(string: urlString!)
                        self.webView.load(URLRequest(url: url!))
                        
                        
                    }else{
                        self.closeTipView()
                        self.openTipThanksView()
                        //self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                        self.getData()
                    }
                    
                }else{
                    
                    if(dataDict.get(Utils.message_str) == "LBL_SELECT_ENTER_TIP_AMOUNT_TXT"){
                        self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                    }else{
                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Add Card", key: "LBL_ADD_CARD"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                
                                self.closeTipView()
                                
                                let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
                                self.push(uv: paymentUV)
                            }
                            
                        })
                    }
                    
                }
              
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }

    func closeWebView(){


       
        self.webView.isHidden = true
        self.webView.navigationDelegate = nil
        self.webView.removeFromSuperview()
        
        
        if(backImgView != nil){
            self.backImgView.removeFromSuperview()
        }
    }
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
    
            
      
            if (urlString.contains(find: "success=1") || urlString.contains(find: "payfast_success.php?success=1") || urlString.contains(find: "payfast_thanks.php?success=1")){
                
                self.closeWebView()
                self.closeTipView()
                self.openTipThanksView()
                self.getData()
                
                
            }else if (urlString.contains(find: "success=0") || urlString.contains(find: "result.php?success=0")){
                
                self.closeWebView()

            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicatorWeb.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicatorWeb.stopAnimating()
        }
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(self.tipView.tipAmoTxtFiled == textField){
            
            self.tipView.tipAmoOtherValueView.borderColor = SColors.Theme
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(self.tipView.tipAmoTxtFiled == textField){
            self.tipView.tipAmoOtherValueView.borderColor = UIColor.lightGray
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(self.tipView.tipAmoTxtFiled == textField){
            let newStr = textField.text! + string
            if(newStr != "" && GeneralFunctions.parseDouble(origValue: 0, data: newStr) <= 0){
                self.tipView.tipRequiredLbl.isHidden = false
                self.tipView.tipAmoOtherValueView.borderColor = UIColor.red
                self.tipView.tipRequiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_GRATER_ZERO_VALUE_TXT")
            }else{
                self.tipView.tipAmoOtherValueView.borderColor = SColors.Theme
                self.tipView.tipRequiredLbl.isHidden = true
            }
            let maxLength = 10
                let currentString: NSString = (textField.text ?? "") as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
        }
        return true
    }
    
    func myBtnTapped(sender: MyButton) {
      
        if(sender.btnType == "REVIEW_ITEM"){
            
            let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
            let dataDic = statusArray[sender.tag]
            self.openReviewItemPopupView(dataDic: dataDic, indexTag: sender.tag)
            if  self.globlaPullContorleer != nil {
                self.globlaPullContorleer.tblPullUp.isHidden = true
                self.globlaPullContorleer.mainView.isHidden = true
           
                self.globlaPullContorleer.pullUpControllerMoveToVisiblePoint(0 , animated: true) {
                    self.globlaPullContorleer.tblPullUp.isHidden = true
                    self.globlaPullContorleer.mainView.isHidden = true
                }
//                self.globlaPullContorleer.pullUpControllerMoveToVisiblePoint(self.globlaPullContorleer.hightOfHeader , animated: true) {
//                    self.globlaPullContorleer.tblPullUp.isHidden = true
//                    self.globlaPullContorleer.mainView.isHidden = true
//                }

            }
            return
        }else if(sender == self.reviewItemDeclineBtn){
            
            let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
            let dataDic = statusArray[self.currentReviewItemTag]
            
            self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_REVIEW_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                
                if(btnClickedIndex == 0){
                    
                    self.confirmReviewItems(dataDic: dataDic, eConfirm: "No", eDecline: "Yes")
                }
                
            })
           
            
            
        }else if(sender == self.reviewItemConfBtn){
            let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
            let dataDic = statusArray[self.currentReviewItemTag]
            
            self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_REVIEW_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                
                if(btnClickedIndex == 0){
                    
                    self.confirmReviewItems(dataDic: dataDic, eConfirm: "Yes", eDecline: "No")
                }
                
            })
            
        }else if(sender.btnType == "MAKE_PAYMENT"){
            
            self.genieMakePayment()
            //GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=DeliverAll", uv: self)
            
//            let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//
//            selectPaymentProfileUV.liveTrackUV = self
//            selectPaymentProfileUV.hideCashForGenie = true
//            selectPaymentProfileUV.isForGenie = true
//            //selectPaymentProfileUV.disableCashPayValue = self.disableCashPayValue
//            self.push(uv: selectPaymentProfileUV)
        }
        
        if(self.tipView != nil && sender == self.tipView.submiBtn){
            self.updateTipValue()
        }
    }
    
    func releaseAllTask(){
        
        if(gMapView != nil){
            gMapView!.removeFromSuperview()
            gMapView!.clear()
            gMapView!.delegate = nil
            gMapView = nil
        }
        
        if(self.getLocation != nil){
            self.getLocation!.locationUpdateDelegate = nil
            self.getLocation!.releaseLocationTask()
            self.getLocation = nil
        }
        
        GeneralFunctions.removeObserver(obj: self)
        
        if(self.updateDirection != nil){
            self.updateDirection.releaseTask()
            self.updateDirection.onDirectionUpdateDelegate = nil
            self.updateDirection = nil
        }
        
        if(self.updateFreqDriverLocTask != nil){
            self.updateFreqDriverLocTask.stopRepeatingTask()
            self.updateFreqDriverLocTask.onTaskRunCalled = nil
            self.updateFreqDriverLocTask = nil
        }
    }
    
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func openTipThanksView() {
        let opnTripFinishView = OpenTripFinishView(uv: self)
        opnTripFinishView.isFromTip = true
        opnTripFinishView.show(title: " ", desc: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIP_SUCCESS_TXT"), handler: {
            
        })
    }
    private func addPullUpController(animated: Bool) {

        let pullUpController = makeSearchViewControllerIfNeeded()
        self.globlaPullContorleer = pullUpController
        _ = pullUpController.view
       
        var xPos = 0
        let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
        var widhth = (globlaPullContorleer.stackView.frame.size.width / CGFloat(self.dataDict.arrOf("message").count)) - 10 //-  CGFloat(( 5 * self.dataDict.arrOf("message").count))
          var hightOfHeader = 150
        for view in  self.globlaPullContorleer.stackView.subviews {
            view.removeFromSuperview()
        }

        for i in 0..<self.dataDict.arrOf("message").count {
            if statusArray[i].get("iStatusCode") == self.dataDict.get("OrderCurrentStatusCode") {
                let viewCus = UIView(frame: CGRect(x: xPos, y : 0, width: Int(widhth), height: 5))
                xPos = xPos + Int(widhth) + 5
               

                viewCus.backgroundColor = SColors.Theme
                self.globlaPullContorleer.lblOrderStatus.text = statusArray[i].get("vStatus")
                //let mainDateStr = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: statusArray[i].get("dDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: "HH:mm a")
                let mainDateStr = Utils.convertDateToFormate(date: Utils.convertStringToDate(dateStr: statusArray[i].get("dDate"), dateFormat: "yyyy-MM-dd HH:mm:ss"), formate: "hh:mm aa")
                
                self.globlaPullContorleer.lblOrderTime.text = mainDateStr
                self.globlaPullContorleer.lblOrderTime.textColor = SColors.blackColor
                self.globlaPullContorleer.itemNameLbl.text = Configurations.convertNumToAppLocal(numStr: self.dataDict.get("TotalOrderItems"))
                self.globlaPullContorleer.priceLbl.text = self.dataDict.get("fNetTotal")
                self.globlaPullContorleer.dateLbl.text = Utils.convertDateToFormate(date: Utils.convertStringToDate(dateStr: self.dataDict.get("tOrderRequestDate"), dateFormat: "yyyy-MM-dd HH:mm:ss"), formate: "dd MMM, yyyy (EEE)")
                self.globlaPullContorleer.priceLbl.textColor = SColors.Theme
                self.globlaPullContorleer.dateLbl.textColor = SColors.Theme
                self.globlaPullContorleer.stackView.addSubview(viewCus)
                
                //viewCus.frame = CGRect(x: xPos, y : 0, width: Int(widhth + 5), height: 5)
            }else{
                let viewCus = UIView(frame: CGRect(x: xPos, y : 0, width: Int(widhth), height: 5))
                xPos = xPos + Int(widhth) + 5
                viewCus.backgroundColor = UIColor.lightGray
                self.globlaPullContorleer.stackView.addSubview(viewCus)
                //viewCus.frame = CGRect(x: xPos, y : 0, width: Int(widhth - 3), height: 5)
            }
        }

            if self.dataDict.get("isContactLessDeliverySelected") == "Yes" {
                self.globlaPullContorleer.howsWrokLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DIS_HOW_IT_WORKS")
                self.globlaPullContorleer.contactLessDeliveryLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_LESS_DELIVERY_TXT")
                self.globlaPullContorleer.howsWrokLbl.textColor = SColors.ThemeTxt
                self.globlaPullContorleer.contactLessDeliveryLbl.textColor = SColors.ThemeTxt
                self.globlaPullContorleer.contactLessDeliveryView.backgroundColor = SColors.Theme
                self.globlaPullContorleer.contactLessDeliveryView.isHidden = false
                self.globlaPullContorleer.ContactLessDeliveryViewHight.constant = 55
                hightOfHeader += 70
                self.isContactLess = true
                self.globlaPullContorleer.howsWrokLbl.handleClick { instance in
                    let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
                    openUserPreferences.customImgName = "ic_delivery_preferences"
                    openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACTLESS_DELIVERYUSER_NOTE_TXT"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_LESS_DELIVERY_TXT"))
                }
            }else{
                self.globlaPullContorleer.contactLessDeliveryView.isHidden = true
                self.globlaPullContorleer.ContactLessDeliveryViewHight.constant = 0
                self.isContactLess = false
            }
            if self.dataDict.get("eTakeAway") == "Yes" && self.dataDict.get("prepareTime") != ""{
                self.globlaPullContorleer.pickUpOrderView.backgroundColor = SColors.Theme
                self.globlaPullContorleer.pickUpTimeLbl.textColor = SColors.ThemeTxt
                GeneralFunctions.setImgTintColor(imgView: globlaPullContorleer.restAddresImgView, color: SColors.Theme)
                globlaPullContorleer.navigateLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NAVIGATE")
                self.globlaPullContorleer.navigateLbl.borderColor = SColors.Theme
                self.globlaPullContorleer.navigateLbl.clipsToBounds = true
                self.globlaPullContorleer.navigateLbl.layer.cornerRadius = 5
             
                self.globlaPullContorleer.navigateLbl.handleClick { instance in
                    let openNavOption = OpenNavOption(uv: self, containerView: self.view, placeLatitude: self.dataDict.get("CompanyLat"), placeLongitude: self.dataDict.get("CompanyLong"), address:self.dataDict.get("CompanyAddress"))
                    openNavOption.chooseOption()
                }
                self.globlaPullContorleer.restaurentAdresslLbl.text = self.dataDict.get("CompanyAddress")
                self.globlaPullContorleer.pickUpTimeLbl.text = self.dataDict.get("prepareTime")
                self.globlaPullContorleer.restaurentAdressView.isHidden = false
                self.globlaPullContorleer.pickUpOrderView.isHidden = false
                self.globlaPullContorleer.pickUpTimeLblHight.constant = 50
                self.globlaPullContorleer.restAdressViewHight.constant = 125 + globlaPullContorleer.restaurentAdresslLbl.frame.size.height
                self.globlaPullContorleer.restaurentAdresslLbl.fit()
                hightOfHeader =  hightOfHeader + 160 + Int(globlaPullContorleer.restaurentAdresslLbl.frame.size.height)

 
            }else{
                self.globlaPullContorleer.restaurentAdressView.isHidden = true
                self.globlaPullContorleer.pickUpOrderView.isHidden = true
                self.globlaPullContorleer.pickUpTimeLblHight.constant = 0
                self.globlaPullContorleer.restAdressViewHight.constant = 0
            }
              
        if self.dataDict.get("OrderCurrentStatusCode") == "5" && self.dataDict.get("eTakeAway") != "Yes" {
                self.globlaPullContorleer.providerView.backgroundColor = SColors.Theme
                self.globlaPullContorleer.providerNameLbl.textColor = SColors.ThemeTxt
                self.globlaPullContorleer.providerRatingLbl.textColor = SColors.ThemeTxt
                self.globlaPullContorleer.providerNameLbl.text = self.dataDict.get("driverName")
                self.globlaPullContorleer.providerRatingLbl.text = self.dataDict.get("driverAvgRating")
                self.globlaPullContorleer.ViewTopHight.constant = 180
                self.globlaPullContorleer.providerView.isHidden = false
                self.globlaPullContorleer.isPickedorder = true
                hightOfHeader += 70
                Utils.createRoundedView(view: self.globlaPullContorleer.providerImageView, borderColor: UIColor.clear, borderWidth: 0)
                self.globlaPullContorleer.providerImageView.sd_setImage(with: URL(string: self.dataDict.get("driverImage")), placeholderImage: UIImage(named: "ic_no_pic_user")!,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                })
                self.globlaPullContorleer.callImageView.image = UIImage.init(named: "ic_eme_call")
                //pullUpController.callImageView.handleClick(clickHandler: OnClickedHandler)
                self.globlaPullContorleer.callImageView.handleClick { instance in
                    self.callingDriver()
                }
                GeneralFunctions.setImgTintColor(imgView: self.globlaPullContorleer.callImageView, color: SColors.ThemeTxt)
                
                //pullUpController.providerView.roundTo(corners:[.topLeft,.topRight] , radius: 10)
            }else{
                self.globlaPullContorleer.providerView.isHidden = true
                self.globlaPullContorleer.ViewTopHight.constant = 128
            }
            
        //}
        if self.dataDict.get("eDisplayRouteLine") == "Yes" {
            self.globlaPullContorleer.etaView.backgroundColor = UIColor.white
            Utils.createRoundedView(view: globlaPullContorleer.etaView , borderColor: SColors.Theme, borderWidth: 2, cornerRadius: 5)
            self.globlaPullContorleer.etaSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ETA_TXT")
            self.globlaPullContorleer.etaTimeLbl.text = self.ETATime
            self.globlaPullContorleer.etaTimeLbl.textColor = SColors.Theme
            self.globlaPullContorleer.etaMainViewHight.constant = 70
            self.globlaPullContorleer.etaView.isHidden = false
            if self.ETATime == "" {
                self.globlaPullContorleer.etaTimeLbl.text = "--"
            }
           
        }else{
            self.globlaPullContorleer.etaMainViewHight.constant = 0
            self.globlaPullContorleer.etaView.isHidden = true
            //pullUpController.etaMainViewHight.constant = 0

        }
        
        if ((self.dataDict.get("OrderCurrentStatusCode") == "6" || self.dataDict.get("OrderCurrentStatusCode") == "9" || self.dataDict.get("OrderCurrentStatusCode") == "8") && self.showCancelView == true) {
            self.globlaPullContorleer.isOrderDeliverd = true
        }
      

        if !self.globlaPullContorleer.orderDeliveredView.isHidden {
            self.globlaPullContorleer.etaMainViewHight.constant = 00
        }else{
            //self.globlaPullContorleer.isOrderDeliverd = true
            self.globlaPullContorleer.orderDeliveredView.isHidden = true//self.orderDeliveredView.isHidden
        }
        
        if self.orderDeliveredViewHeight.constant > 0 {
        self.globlaPullContorleer.orderDeliveredViewHeight.constant = 0//self.orderDeliveredViewHeight.constant + 5
        self.globlaPullContorleer.hightOfDeliverdView = self.orderDeliveredViewHeight.constant + 5
        }else{
            self.globlaPullContorleer.orderDeliveredViewHeight.constant = 0//self.orderDeliveredViewHeight.constant
            self.globlaPullContorleer.hightOfDeliverdView = self.orderDeliveredViewHeight.constant
        }
        
        //self.globlaPullContorleer.orderDeliveredView.isHidden = true
        self.globlaPullContorleer.notDeliveredView.backgroundColor = self.notDeliveredView.backgroundColor
        self.globlaPullContorleer.notDeliveredView.borderWidth = 1
        self.globlaPullContorleer.notDeliveredView.borderColor = SColors.blackColor
        let orderNotDelTapGesture = UITapGestureRecognizer()
        orderNotDelTapGesture.addTarget(self, action: #selector(self.orderNotDelTapped))
        self.globlaPullContorleer.notDeliveredView.isUserInteractionEnabled = true
        self.globlaPullContorleer.notDeliveredView.addGestureRecognizer(orderNotDelTapGesture)
        self.globlaPullContorleer.notDeliveredView.isHidden = self.notDeliveredView.isHidden
        
        self.globlaPullContorleer.enjoyYFoodLbl.text = self.enjoyYFoodLbl.text
        self.globlaPullContorleer.enjoyYFoodLbl.isHidden = self.enjoyYFoodLbl.isHidden
        self.globlaPullContorleer.enjoyYFoodLbl.textColor = self.enjoyYFoodLbl.textColor
        
        self.globlaPullContorleer.orderDelCallDelLbl.text = self.orderDelCallDelLbl.text
        self.globlaPullContorleer.orderDelCallDelLbl.isHidden = self.orderDelCallDelLbl.isHidden
        self.globlaPullContorleer.orderDelCallDelLbl.textColor = self.orderDelCallDelLbl.textColor
        
        self.globlaPullContorleer.orderDelOkLbl.text = self.orderDelOkLbl.text
        self.globlaPullContorleer.orderDelOkLbl.isHidden = self.orderDelOkLbl.isHidden
        self.globlaPullContorleer.orderDelOkLbl.textColor = self.orderDelOkLbl.textColor
        
        self.globlaPullContorleer.ordernotDelLbl.text =  self.ordernotDelLbl.text
        self.globlaPullContorleer.ordernotDelLbl.isHidden = self.ordernotDelLbl.isHidden
        self.globlaPullContorleer.ordernotDelLbl.textColor = self.ordernotDelLbl.textColor
        
        self.globlaPullContorleer.orderDelSubLbl.text = self.orderDelSubLbl.text
        self.globlaPullContorleer.orderDelSubLbl.isHidden = self.orderDelSubLbl.isHidden
        self.globlaPullContorleer.orderDelSubLbl.textColor = self.orderDelSubLbl.textColor
        
        self.globlaPullContorleer.orderDelHLbl.text = self.orderDelHLbl.text
        self.globlaPullContorleer.orderDelHLbl.isHidden = self.orderDelHLbl.isHidden
        self.globlaPullContorleer.orderDelHLbl.textColor = self.orderDelHLbl.textColor
        
        let orderDelOKGesture = UITapGestureRecognizer()
        orderDelOKGesture.addTarget(self, action: #selector(self.orderDelOkTapped))
        self.globlaPullContorleer.deliveredView.isUserInteractionEnabled = true
        self.globlaPullContorleer.deliveredView.addGestureRecognizer(orderDelOKGesture)
        self.globlaPullContorleer.deliveredView.isHidden = self.deliveredView.isHidden
        self.globlaPullContorleer.deliveredView.backgroundColor = self.deliveredView.backgroundColor
        self.globlaPullContorleer.rateView.backgroundColor = SColors.ThemeTxt
        self.globlaPullContorleer.rateLbl.textColor = SColors.ThemeTxt//SColors.blackColor
        self.globlaPullContorleer.rateView.backgroundColor = SColors.Theme
        self.globlaPullContorleer.rateLbl.text = self.generalFunc.getLanguageLabel(origValue: "Rate Your Order", key: "LBL_RATE_ORDER_COMPLETED")
        //self.feedBackQue = dataDict.arrOf("DRIVER_FEEDBACK_QUESTIONS") as! [NSDictionary]
        self.globlaPullContorleer.rateView.handleClick { (instance) in
//            let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
//            orderDetailsUv.orderId =  self.orderId
//            self.push(uv: orderDetailsUv)
            
            
            
            let foodRatingUv = GeneralFunctions.instantiateViewController(pageName: "FoodRatingUV") as! FoodRatingUV
            foodRatingUv.ratingData = ["LastOrderId":self.orderId, "LastOrderCompanyId":self.dataDict.get("iCompanyId"),"LastOrderCompanyName":self.dataDict.get("vCompany"), "LastOrderDriverId":self.dataDict.get("driverId"), "LastOrderDriverName":self.dataDict.get("driverName"), "LastOrderNo":self.dataDict.get("vOrderNo"), "isLastOrderTakeAway" : self.dataDict.get("eTakeAway")]
            print(foodRatingUv.ratingData)
            foodRatingUv.isOpenFromOrderList = true
            foodRatingUv.isFromTracking = true
            foodRatingUv.liveTrackUv = self
            foodRatingUv.queArray = self.userProfileJson.arrOf("DRIVER_FEEDBACK_QUESTIONS") as! [NSDictionary]
            if(self.dataDict.get("ENABLE_FOOD_RATING_DETAIL_FLOW").uppercased() == "YES"){
                foodRatingUv.isDetailFlow = true
            }
            //foodRatingUv.isDetailFlow = true
            self.isFromRating = true
            self.push(uv: foodRatingUv)
        }
        
       
        
        self.globlaPullContorleer.delliveredProofImg.image = self.delliveredProofImg.image
        self.globlaPullContorleer.delliveredProofImgHeight.constant = self.delliveredProofImgHeight.constant
        
        self.globlaPullContorleer.notDelLblHeight.constant = self.notDelLblHeight.constant
        self.globlaPullContorleer.orderDelOkTopSpace.constant = self.orderDelOkTopSpace.constant
        
//        self.globlaPullContorleer.orderDeliveredView.backgroundColor = SColors.Theme
        self.globlaPullContorleer.orderDelSubLbl.textColor = SColors.grey_image_tint_color
        self.globlaPullContorleer.orderDelHLbl.textColor = SColors.blackColor//SColors.red
        self.globlaPullContorleer.notDeliveredView.backgroundColor = SColors.ThemeTxt //SColors.blackColor
        self.globlaPullContorleer.ordernotDelLbl.textColor = SColors.blackColor
        self.globlaPullContorleer.orderDelCallDelLbl.textColor = SColors.blackColor
        self.globlaPullContorleer.deliveredView.backgroundColor = SColors.Theme
        self.globlaPullContorleer.enjoyYFoodLbl.textColor = SColors.ThemeTxt
        self.globlaPullContorleer.orderDelOkLbl.textColor = SColors.ThemeTxt
        if self.dataDict.get("eTakeAway").uppercased() == "YES" {
            
            self.globlaPullContorleer.orderDeliveredViewHeight.constant = 0//self.orderDeliveredViewHeight.constant + 25
            self.globlaPullContorleer.notDeliveredView.isHidden = true
        }
        
        if !firstLoad {
          
            self.globlaPullContorleer.tblPullUp.layer.cornerRadius = 15
            self.globlaPullContorleer.tblPullUp.register(UINib(nibName: "LiveTrackStatusTVCell", bundle: nil), forCellReuseIdentifier: "LiveTrackStatusTVCell")
            self.globlaPullContorleer.tblPullUp.clipsToBounds = true
            self.globlaPullContorleer.tblPullUp.parallaxHeader.delegate = self
            self.globlaPullContorleer.tblPullUp.delegate = self
            self.globlaPullContorleer.tblPullUp.dataSource = self
            self.globlaPullContorleer.tblPullUp.parallaxHeader.view = self.globlaPullContorleer.tblHeaderView
            self.globlaPullContorleer.tblPullUp.isScrollEnabled = false
            self.globlaPullContorleer.tblPullUp.parallaxHeader.minimumHeight =  0
        }else{
          
        }
        
       
        if self.orderDeliveredView.isHidden == false{
            self.orderDeliveredView.isHidden = true
        }
        
        self.globlaPullContorleer.ratingImgView.image = UIImage(named: "ic_filled_rating")?.tintTo(color: UIColor.yellow)?.resize(toHeight: 12)?.resize(toWidth: 12)
      
        self.globlaPullContorleer.tblPullUp.parallaxHeader.mode = .bottom
        self.globlaPullContorleer.tblPullUp.parallaxHeader.height = CGFloat(hightOfHeader)
        
        self.globlaPullContorleer.tblPullUp.separatorStyle = .none
       
        self.globlaPullContorleer.tblPullUp.reloadData()
        self.globlaPullContorleer.tblPullUp.isHidden = false
        self.globlaPullContorleer.mainView.isHidden = false
       
        self.globlaPullContorleer.isFirstLoad = !firstLoadPull
        removePullUpController(self.globlaPullContorleer, animated: true) { has in
            self.addPullUpController(self.globlaPullContorleer,
                                     initialStickyPointOffset: self.globlaPullContorleer.initialPointOffset,
                                animated: animated)
        }
       
        firstLoadPull = true
    }
    private func makeSearchViewControllerIfNeeded() -> LiveTrackPullUpUV {
        let currentPullUpController = children
            .filter({ $0 is LiveTrackPullUpUV })
            .first as? LiveTrackPullUpUV
        let pullUpController: LiveTrackPullUpUV = currentPullUpController ?? UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "LiveTrackPullUpUV") as! LiveTrackPullUpUV
            pullUpController.initialState = .expanded
        
        if originalPullUpControllerViewSize == .zero {
            originalPullUpControllerViewSize = pullUpController.view.bounds.size
        }

        return pullUpController
    }
    func callingDriver(){
        
            let statusArray = self.dataDict.arrOf("message") as! [NSDictionary]
            
                /* IF SYNCH ENABLE CALL DIRECTLY TO THE APP.*/
                if self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == "VOIP"{
                    //  if SinchCalling.getInstance().client.isStarted(){
                    
                    var imgName = ""
                    if(statusArray.count > 0){
                        imgName = statusArray[0].get("driverImage")
                    }
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType]
                    let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver"]
                    SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
                    
                    return
                    // }
                }else if(self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == Utils.VIDEOCALL){
                    var imgName = ""
                    if(statusArray.count > 0){
                        imgName = statusArray[0].get("driverImage")
                    }
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType, "isVideoCall":"Yes"]
                    let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver", "isVideoCall":"Yes"]
                    SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
                    
                    return
                }else if (self.userProfileJson.get("RIDE_DRIVER_CALLING_METHOD").uppercased() == Utils.VOIP_VIDEOCALL) {
                    let openListView = OpenListView(uv: self, containerView: self.view)
                    openListView.openNewList = true
                    openListView.isFromDate = true
                    openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                                   // 0 for video 1 for camera
                    if selectedItemId == 0 {

                                                var imgName = ""
                                                if(statusArray.count > 0){
                                                    imgName = statusArray[0].get("driverImage")
                                                }
                                                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                                        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType, "isVideoCall":"Yes"]
                                                let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver", "isVideoCall":"Yes"]
                                                SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
                        //
                        //                        return
                    }else {
                        var imgName = ""
                        if(statusArray.count > 0){
                            imgName = statusArray[0].get("driverImage")
                        }
                        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type":Utils.appUserType]
                        let assignedDic = ["Id":self.dataDict.get("iDriverId"), "Name": self.dataDict.get("driverName"), "PImage": imgName, "type":"Driver"]
                        SinchCalling.getInstance().makeACall(IDString:"Driver" + "_" + self.dataDict.get("iDriverId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
                        
                        return
                        
                    }
                    
                    })
                    return
                }
                
                if(self.userProfileJson.get("CALLMASKING_ENABLED").uppercased() == "YES"){
                    let parameters = ["type":"getCallMaskNumber","iOrderId": self.orderId, "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
                    
                    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
                    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                        if(response != ""){
                            let dataDict = response.toDict()
                            
                            if(dataDict.get("Action") == "1"){
                                
                                if let PhoneNo = NSURL(string:"telprompt:" + dataDict.get(Utils.message_str)){
                                    UIApplication.shared.openURL(PhoneNo as URL)
                                }else{
                                    UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                                }
                            }else{
                                UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                            }
                            
                        }else{
                            self.generalFunc.setError(uv: self)
                        }
                    })
                }else{
                    UIApplication.shared.openURL(NSURL(string:"telprompt:" + self.driverPhone)! as URL)
                }
            
        
    }
        
    func openLiveChat(){
        LiveChat.presentChat()
        //closeLiveChatSetup()

    }
    @objc func clearChat()
    {
        LiveChat.clearSession()
        LiveChat.dismissChat()
        btnClearsession.removeFromSuperview()

    }
    let btnClearsession = UIButton(frame: CGRect(60 , 25, 60, 60))

    func closeLiveChatSetup(){
        
        btnClearsession.frame.origin.x = (self.view.frame.size.width - 70)
        btnClearsession.setImage(UIImage(named: "ic_close_detail"), for: .normal)

        GeneralFunctions.setImgTintColor(imgView: btnClearsession.imageView!, color: UIColor(hex: 0x000000))
        btnClearsession.backgroundColor = .white
        btnClearsession.addTarget(self, action: #selector(clearChat), for: .touchUpInside)
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(btnClearsession)
    }/* Live Chat Settings .*/
        
    /* Live Chat Settings .*/
    func configLiveChat(){
        LiveChat.licenseId = userProfileJson.get("LIVE_CHAT_LICENCE_NUMBER")
        LiveChat.name = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
        LiveChat.email = userProfileJson.get("vEmail")
        LiveChat.setVariable(withKey:"FNAME", value:userProfileJson.get("vName"))
        LiveChat.setVariable(withKey:"LNAME", value:userProfileJson.get("vLastName"))
        LiveChat.setVariable(withKey:"EMAIL", value:userProfileJson.get("vEmail"))
        LiveChat.setVariable(withKey:"USERTYPE", value:Utils.appUserType)
        
        LiveChat.delegate = self
    }
    
    // MARK: LiveChatDelegate
    func received(message: LiveChatMessage) {
        if (!LiveChat.isChatPresented) {
            // Notifying user
            let alert = UIAlertController(title: "Support", message: message.text, preferredStyle: .alert)
            let chatAction = UIAlertAction(title: "Go to Chat", style: .default) { alert in
                // Presenting chat if not presented:
                if !LiveChat.isChatPresented {
                    LiveChat.presentChat()
                }
            }
            alert.addAction(chatAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
extension UIViewController {
        
  func removeChild() {
    self.children.forEach {
      $0.willMove(toParent: nil)
      $0.view.removeFromSuperview()
      $0.removeFromParent()
    }
  }
}
