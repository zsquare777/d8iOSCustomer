
import UIKit
import SysBaseLib

class HomeScreenContainerUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var containerView: UIView!
    
    var mainScreenUV:MainScreenUV!
    var ufxHomeUV:UFXHomeUV!
    var ufxProUV:UFXProUV!
    
    var delAllUfxHomeUV:DelAllUFXHomeUV!
    var deliveryAllUV:DeliveryAllUV!
    
    var isPageLoad = false
    
    var userProfileJson:NSDictionary!
    
    let generalFunc = GeneralFunctions()
    
    var deliveryTripId = ""
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            
            if(ServiceModule.isDeliverAllOnly())
            {
                
                let homeScreenTabBar = HomeScreenTabBarUV()
                homeScreenTabBar.navItem = self.navigationItem
                
                //                    ufxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "UFXHomeUV") as! UFXHomeUV)
                //                    ufxHomeUV.navItem = self.navigationItem
                //                    self.addChild(ufxHomeUV)
                //                    self.addSubview(subView: ufxHomeUV.view, toView: self.containerView)
                
                self.addChild(homeScreenTabBar)
                self.addSubview(subView: homeScreenTabBar.view, toView: self.containerView)
                
                //self.checkPendingPayment()
                Utils.delayWithSeconds(4) {
                    self.checkPendingPayment()
                }
                
            }else
            {
                if(ServiceModule.serviceProviderProduct || ServiceModule.rideDeliveryUbexProduct) {
                    
                    if userProfileJson.dictOf("TripDetails").get("eType") == "Multi-Delivery" && deliveryTripId == ""
                    {
                        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                            ufxProUV = (GeneralFunctions.instantiateViewController(pageName: "UFXProUV") as! UFXProUV)
                            //ufxHomeUV.navItem = self.navigationItem
                            self.addChild(ufxProUV)
                            self.addSubview(subView: ufxProUV.view, toView: self.containerView)
                        }else{
                            ufxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "UFXHomeUV") as! UFXHomeUV)
                            //ufxHomeUV.navItem = self.navigationItem
                            self.addChild(ufxHomeUV)
                            self.addSubview(subView: ufxHomeUV.view, toView: self.containerView)
                        }
                        
                      
                        self.loadAdvertisementView()
                        NotificationCenter.default.addObserver(self, selector: #selector(self.releaseAllTask), name: NSNotification.Name(rawValue: Utils.releaseAllTaskObserverKey), object: nil)
                        
                        //self.checkPendingPayment()
                        Utils.delayWithSeconds(4) {
                            self.checkPendingPayment()
                        }
                        return
                    }
                    
                    let vTripStatus = userProfileJson.get("vTripStatus")
                    let eFly = userProfileJson.dictOf("TripDetails").get("eFly") // Fly Changes
                    if((vTripStatus == "Active" || (vTripStatus == "Arrived" && eFly.uppercased() == "YES") || vTripStatus == "On Going Trip") && userProfileJson.dictOf("TripDetails").get("eType").uppercased() != "UBERX"){
                        mainScreenUV = (GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV)
                        mainScreenUV.view.frame = self.containerView.frame
                        mainScreenUV.liveTrackTripId = self.deliveryTripId
                        mainScreenUV.navItem = self.navigationItem
                        
                        self.addChild(mainScreenUV)
                        self.addSubview(subView: mainScreenUV.view, toView: self.containerView)
                    }else{
                        
                
                        let homeScreenTabBar = HomeScreenTabBarUV()
                        homeScreenTabBar.navItem = self.navigationItem
    //                    ufxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "UFXHomeUV") as! UFXHomeUV)
    //                    ufxHomeUV.navItem = self.navigationItem
    //                    self.addChild(ufxHomeUV)
    //                    self.addSubview(subView: ufxHomeUV.view, toView: self.containerView)
                        
                        self.addChild(homeScreenTabBar)
                        self.addSubview(subView: homeScreenTabBar.view, toView: self.containerView)
                        
                        //self.checkPendingPayment()
                        Utils.delayWithSeconds(4) {
                            self.checkPendingPayment()
                        }
                        
                    }
                    
                }else if(ServiceModule.rideDeliveryProduct || ServiceModule.deliveryProduct){
                    
                    if userProfileJson.dictOf("TripDetails").get("eType") == "Multi-Delivery" && deliveryTripId == ""
                    {
                        let moreDeliveriesUv = GeneralFunctions.instantiateViewController(pageName: "MoreDeliveriesUV") as! MoreDeliveriesUV
                        moreDeliveriesUv.navItem = self.navigationItem
                        moreDeliveriesUv.iVehicleCategoryId = userProfileJson.get("DELIVERY_CATEGORY_ID")
                        moreDeliveriesUv.isMenuAdded = true
                        moreDeliveriesUv.vCategoryName = ""
                        self.addChild(moreDeliveriesUv)
                        self.addSubview(subView: moreDeliveriesUv.view, toView: self.containerView)
                        
                        self.loadAdvertisementView()
                        NotificationCenter.default.addObserver(self, selector: #selector(self.releaseAllTask), name: NSNotification.Name(rawValue: Utils.releaseAllTaskObserverKey), object: nil)
                        
                        //self.checkPendingPayment()
                        Utils.delayWithSeconds(4) {
                            self.checkPendingPayment()
                        }
                        return
                    }
                    
                    let vTripStatus = userProfileJson.get("vTripStatus")
                    let eFly = userProfileJson.dictOf("TripDetails").get("eFly") // Fly Changes
                    if((vTripStatus == "Active" || (vTripStatus == "Arrived" && eFly.uppercased() == "YES") || vTripStatus == "On Going Trip") && userProfileJson.dictOf("TripDetails").get("eType").uppercased() != "UBERX"){
                        mainScreenUV = (GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV)
                        mainScreenUV.view.frame = self.containerView.frame
                        mainScreenUV.liveTrackTripId = self.deliveryTripId
                        mainScreenUV.navItem = self.navigationItem
                        
                        self.addChild(mainScreenUV)
                        self.addSubview(subView: mainScreenUV.view, toView: self.containerView)
                    }else{
                        
    //                    if(userProfileJson.get("PACKAGE_TYPE").uppercased() == "STANDARD" &&
                        
                        let homeScreenTabBar = HomeScreenTabBarUV()
                        homeScreenTabBar.navItem = self.navigationItem
                        //                    ufxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "UFXHomeUV") as! UFXHomeUV)
                        //                    ufxHomeUV.navItem = self.navigationItem
                        //                    self.addChild(ufxHomeUV)
                        //                    self.addSubview(subView: ufxHomeUV.view, toView: self.containerView)
                                            
                        self.addChild(homeScreenTabBar)
                        self.addSubview(subView: homeScreenTabBar.view, toView: self.containerView)
                        
                        //self.checkPendingPayment()
                        Utils.delayWithSeconds(4) {
                            self.checkPendingPayment()
                        }
                     
                    }
                  
                }else{
                    
                    
                    
                    
                    
                    if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES") {
                        let vTripStatus = userProfileJson.get("vTripStatus")
                        if(vTripStatus == "Active" || vTripStatus == "Arrived"  || vTripStatus == "On Going Trip") {
                            
                            
                            mainScreenUV = (GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV)
                            mainScreenUV.view.frame = self.containerView.frame
                            mainScreenUV.navItem = self.navigationItem
                            mainScreenUV.liveTrackTripId = self.deliveryTripId
                            
                            self.addChild(mainScreenUV)
                            self.addSubview(subView: mainScreenUV.view, toView: self.containerView)
                            
                        }else{
                            let homeScreenTabBar = HomeScreenTabBarUV()
                            homeScreenTabBar.navItem = self.navigationItem
                            
                            self.addChild(homeScreenTabBar)
                            self.addSubview(subView: homeScreenTabBar.view, toView: self.containerView)
                            
                            //self.checkPendingPayment()
                            Utils.delayWithSeconds(4) {
                                self.checkPendingPayment()
                            }
                        }
                    }else{
                        mainScreenUV = (GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV)
                        mainScreenUV.view.frame = self.containerView.frame
                        mainScreenUV.navItem = self.navigationItem
                        mainScreenUV.liveTrackTripId = self.deliveryTripId
                        
                        self.addChild(mainScreenUV)
                        self.addSubview(subView: mainScreenUV.view, toView: self.containerView)
                    }
                }
            }
            
            self.loadAdvertisementView()
           
            NotificationCenter.default.addObserver(self, selector: #selector(self.releaseAllTask), name: NSNotification.Name(rawValue: Utils.releaseAllTaskObserverKey), object: nil)
            
        }else if(type == 1){
            
            self.configRTL()
            self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.zPosition = 1
            
            if(mainScreenUV != nil && mainScreenUV.isDriverAssigned != true && ServiceModule.rideDeliveryUbexProduct == false){
                self.navigationController?.navigationBar.isHidden = true

                UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            }
            
            if(ServiceModule.rideProduct){
                
                if(deliveryTripId != ""){
                    if(Configurations.isRTLMode()){
                        self.navigationDrawerController?.isRightPanGestureEnabled = false
                    }else{
                        self.navigationDrawerController?.isLeftPanGestureEnabled = false
                    }
                }else{
                    if(Configurations.isRTLMode()){
                        self.navigationDrawerController?.isRightPanGestureEnabled = true
                    }else{
                        self.navigationDrawerController?.isLeftPanGestureEnabled = true
                    }
                }
            }
            
        }else if(type == 2){
            if(isPageLoad == false){
                if(ufxHomeUV != nil){
                    ufxHomeUV.view.frame = self.containerView.frame
                }
                
                if(ufxProUV != nil){
                    ufxProUV.view.frame = self.containerView.frame
                }
                
                if(mainScreenUV != nil){
                    mainScreenUV.view.frame = self.containerView.frame
                }
                
                isPageLoad = true
            }
            
        }else if(type == 3){
            self.navigationController?.navigationBar.isHidden = false
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
            if(ServiceModule.rideProduct){
                if(Configurations.isRTLMode()){
                    self.navigationDrawerController?.isRightPanGestureEnabled = false
                }else{
                    self.navigationDrawerController?.isLeftPanGestureEnabled = false
                }
            }
        }
    }
    
    
    
    // New PaymentFlow Changes
    func checkPendingPayment(){
        
        if(GeneralFunctions.parseDouble(origValue: 0.0, data: userProfileJson.get("fOutStandingAmount")) > 0){
            
            let dismissBtn = Utils.showSnakeBar(msg: userProfileJson.get("PaymentPendingMsg"), uv: self, btnTitle: self.generalFunc.getLanguageLabel(origValue: "Pay", key: "LBL_BTN_PAYMENT_TXT"), delayShow: 1, delayHide: 60)
            dismissBtn.addTarget(self, action: #selector(self.payBtn), for: UIControl.Event.touchUpInside)
        }
    }
    
    @objc func payBtn(){
        self.snackbarController?.animate(snackbar: .hidden, delay: 0)
        GeneralFunctions.addPayment(url: self.userProfileJson.get("OUTSTANDING_PAYMENT_URL"), uv: self)
    }
    
    func loadAdvertisementView(){
        /* Load AdvertisementView */
        let advDataDic = userProfileJson.get("advertise_banner_data")
        let dataDict = advDataDic.toDict()
        if (userProfileJson.get("ENABLE_RIDER_ADVERTISEMENT_BANNER").uppercased() == "YES" && dataDict.get("image_url") != "" && deliveryTripId == ""){
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            let advDataDic = userProfileJson.get("advertise_banner_data")
            let dataDict = advDataDic.toDict()
            var width:CGFloat = 0.0
            let wi = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDict.get("vImageWidth"))
            width = CGFloat.init(wi) / UIScreen.main.scale
            
            var height:CGFloat = 0.0
            let hi = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDict.get("vImageHeight"))
            height = CGFloat.init(hi) / UIScreen.main.scale
            
            if(width < 100){
                width = 100.0
            }
            
            if (height < 100){
                height = 100
            }
            let bgView = UIView()
            bgView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
            bgView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            Application.keyWindow!.addSubview(bgView)
            Application.keyWindow!.addSubview(AdvertisementView.init(withImgUrlString: dataDict.get("image_url"), withRedirectUrlString: dataDict.get("tRedirectUrl"), vImageWidth: width, vImageHeight: height, bgView: bgView))
        }
        /* Load AdvertisementView */
    }
    
    func openMenu(){
        if(Configurations.isRTLMode()){
            self.navigationDrawerController?.toggleRightView()
        }else{
            self.navigationDrawerController?.toggleLeftView()
        }
    }
    
    deinit {
//        print("HomeDeinit")
    }
    
    @objc func releaseAllTask(){
        if(self.ufxHomeUV != nil){
            self.ufxHomeUV.close()
            self.ufxHomeUV.view.removeFromSuperview()
            self.ufxHomeUV.removeFromParent()
            self.ufxHomeUV.dismiss(animated: true, completion: nil)
            self.ufxHomeUV = nil
        }
        
        if(self.ufxProUV != nil){
            self.ufxProUV.close()
            self.ufxProUV.view.removeFromSuperview()
            self.ufxProUV.removeFromParent()
            self.ufxProUV.dismiss(animated: true, completion: nil)
            self.ufxProUV = nil
        }
        
        if(mainScreenUV == nil){
            return
        }
//        print("HomeScreenReleased")
        mainScreenUV.getAddressFrmLocation?.addressFoundDelegate = nil
        mainScreenUV.getAddressFrmLocation = nil
        
        mainScreenUV.gMapView?.clear()
        mainScreenUV.gMapView?.delegate = nil
        mainScreenUV.gMapView?.removeFromSuperview()
        mainScreenUV.gMapView = nil
        
        mainScreenUV.releaseAllTask()
        mainScreenUV.view.removeFromSuperview()
        mainScreenUV.removeFromParent()
        mainScreenUV.dismiss(animated: true, completion: nil)
        
        mainScreenUV = nil
        
        GeneralFunctions.removeObserver(obj: self)
        
        self.navigationDrawerController?.dismiss(animated: true, completion: nil)
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        
        subView.frame = parentView.frame
        subView.center = CGPoint(x: parentView.bounds.midX, y: parentView.bounds.midY)
        
        parentView.addSubview(subView)
    }


}
