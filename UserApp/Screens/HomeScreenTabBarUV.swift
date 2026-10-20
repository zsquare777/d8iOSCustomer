
import UIKit
import CoreLocation

class HomeScreenTabBarUV: UITabBarController {
    
    var tabbarHidden = false {
        didSet {
            var frame = self.view.bounds;
            
            if (tabbarHidden) {
                frame.size.height += self.tabBar.bounds.size.height + 4;
            }else{
                frame.size.height -= (self.tabBar.bounds.size.height + 4);
            }
            
            self.view.frame = frame;
        }
    }
    
    lazy var bannerAd: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: 0xf1f1f1)
        return view
    }()
    
    var navItem:UINavigationItem!
    var kBarHeight:CGFloat = 64
    var bannerAdHeight:CGFloat = 4
    
    let generalFunc = GeneralFunctions()
    
    var ufxHomeUV:UFXHomeUV!
    var ufxProUV:UFXProUV!
    var rideOrderHistoryTabUV:RideOrderHistoryTabUV!
    var manageWalletUV:ManageWalletUV!
    var manageProfileUv:ViewProfileUV!
    var mainScreenUV:UFXHomeUV!
    var rideDeliveryNewServicesUV:RideDeliveryNewServicesUV!
    var delAllUfxHomeUV:DelAllUFXHomeUV!
    var deliveryAllUV:DeliveryAllUV!
    var uFXServicesUV:UFXServicesUV!
    var tabBarViewHeight:CGFloat!
    var isFirstLoad = false
    
    var isOpenRestaurantDetail = "No"
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
    }
    
    override func viewDidLayoutSubviews() {
    
        self.tabBar.invalidateIntrinsicContentSize()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = kBarHeight
        tabFrame.origin.y = self.view.frame.size.height - bannerAdHeight - kBarHeight
        self.tabBar.frame = tabFrame
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Configurations.setLightStatusBar()
        self.setnavBarTintColor(color: SColors.Theme)
        
        if(isFirstLoad == false){
            isFirstLoad = true
            delegate = self
            kBarHeight = kBarHeight + GeneralFunctions.getSafeAreaInsets().bottom
            
            if #available(iOS 15.0, *) {
               let appearance = UITabBarAppearance()
               appearance.configureWithOpaqueBackground()
               appearance.backgroundColor = UIColor(hex: 0xf1f1f1)
               
                self.tabBar.standardAppearance = appearance
                self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
            }else{
                self.tabBar.barTintColor = UIColor(hex: 0xf1f1f1)
                self.tabBar.isTranslucent = false
            }
            
            
            //self.tabBar.tintColor = SColors.Theme
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && ServiceModule.rideProduct {
                self.tabBar.tintColor = SColors.blackColor
            }else{
                self.tabBar.tintColor = SColors.Theme
            }
            
            
            
            
            // Add bottom blank space view
            view.addSubview(bannerAd)
            bannerAd.heightAnchor.constraint(equalToConstant: bannerAdHeight).isActive = true
            bannerAd.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            bannerAd.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            /////////
            
            //Mark:- You can also set any custom fonts in the code
            let fontAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts().regular, size: 13.0)!]
            UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
            
            let fontAttributes2 = [NSAttributedString.Key.font: UIFont(name: Fonts().regular, size: 14.0)!]
            UITabBarItem.appearance().setTitleTextAttributes(fontAttributes2, for: .selected)
            
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && !ServiceModule.isDeliverAllOnly()){
                ufxProUV = (GeneralFunctions.instantiateViewController(pageName: "UFXProUV") as! UFXProUV)
                ufxProUV.homeTabBar = self
                let icon1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                ufxProUV.tabBarItem = icon1
            }else{
                ufxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "UFXHomeUV") as! UFXHomeUV)
                ufxHomeUV.homeTabBar = self
                let icon1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                ufxHomeUV.tabBarItem = icon1
            }
            
        
            var BOOKINGS_SECTION = false
            var ORDER_SECTION = false
            var BIDDING_SECTION = false
            
            if(ServiceModule.rideM || ServiceModule.deliveryM || ServiceModule.ufxM || ServiceModule.vcM){
                BOOKINGS_SECTION = true
            }
            
            if(ServiceModule.deliverallM || ServiceModule.runnerM || ServiceModule.genieM){
                ORDER_SECTION = true
            }
            
            if(ServiceModule.biddingM){
                BIDDING_SECTION = true
            }
            
            var mArray = [Bool]()
            if(BOOKINGS_SECTION == true){ mArray.append(BOOKINGS_SECTION) }
            if(ORDER_SECTION == true){ mArray.append(ORDER_SECTION) }
            if(BIDDING_SECTION == true){ mArray.append(BIDDING_SECTION) }
          
            var ordersListUV:OrdersListUV!
            var rideHistoryUV:RideHistoryUV!
            if(ServiceModule.isDeliverAllOnly()){
                ordersListUV = GeneralFunctions.instantiateViewController(pageName: "OrdersListUV") as? OrdersListUV
                let icon2 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_MY_ORDERS"), image: UIImage(named: "ic_bookings_new_unselcted"), selectedImage: UIImage(named: "ic_booking_new_selected"))
                ordersListUV.homeTabBar = self
                ordersListUV.tabBarItem = icon2
                ordersListUV.navItem = self.navigationItem
            }else{
                if(mArray.count > 1){
                    rideOrderHistoryTabUV = (GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV)
                    let icon2 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_BOOKINGS"), image: UIImage(named: "ic_bookings_new_unselcted"), selectedImage: UIImage(named: "ic_booking_new_selected"))
                    rideOrderHistoryTabUV.homeTabBar = self
                    rideOrderHistoryTabUV.tabBarItem = icon2
                    
                }else{
                    
                    rideHistoryUV = (GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV)
                    let icon2 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_BOOKINGS"), image: UIImage(named: "ic_bookings_new_unselcted"), selectedImage: UIImage(named: "ic_booking_new_selected"))
                    rideHistoryUV.homeTabBar = self
                    rideHistoryUV.tabBarItem = icon2
                }
            }
            
         
            manageWalletUV = (GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV)
            manageWalletUV.homeTabBar = self
            let icon3 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_WALLET"), image: UIImage(named: "ic_wallet_new_unselected"), selectedImage: UIImage(named: "ic_wallet_new_selected"))
            manageWalletUV.tabBarItem = icon3
            
            var profileTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_PROFILE")
            if ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct{
                profileTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_TXT")
            }
            manageProfileUv = (GeneralFunctions.instantiateViewController(pageName: "ViewProfileUV") as! ViewProfileUV)
            manageProfileUv.homeTabBar = self
            let icon4 = UITabBarItem(title: profileTitle, image: UIImage(named: "ic_profile_new_unselected"), selectedImage: UIImage(named: "ic_profile_new_selected"))
            manageProfileUv.tabBarItem = icon4
            
            let historyForNoLogIn = (GeneralFunctions.instantiateViewController(pageName: "ViewProfileUV") as! ViewProfileUV)
             historyForNoLogIn.homeTabBar = self
            let ico = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_MY_ORDERS"), image: UIImage(named: "ic_bookings_new_unselcted"), selectedImage: UIImage(named: "ic_booking_new_selected"))
            historyForNoLogIn.tabBarItem = ico
            
            let walletNoLogIn = (GeneralFunctions.instantiateViewController(pageName: "ViewProfileUV") as! ViewProfileUV)
            walletNoLogIn.homeTabBar = self
            let ico1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_WALLET"), image: UIImage(named: "ic_wallet_new_unselected"), selectedImage: UIImage(named: "ic_wallet_new_selected"))
            walletNoLogIn.tabBarItem = ico1
            
            var restaurantDetailsUV:RestaurantDetailsUV!
            let itemsArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! [NSDictionary]
            if(itemsArray.count > 0){
                let item = itemsArray[0].dictOf("STORE_DATA")
                restaurantDetailsUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantDetailsUV") as! RestaurantDetailsUV
                let iconR = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                restaurantDetailsUV.tabBarItem = iconR
                restaurantDetailsUV.homeTabBar = self
                restaurantDetailsUV.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
                restaurantDetailsUV.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
                restaurantDetailsUV.restaurantName =  item.get("vCompany")
                restaurantDetailsUV.companyId = item.get("iCompanyId")
                restaurantDetailsUV.restaurantcoverImagePath = item.get("vCoverImage")
                restaurantDetailsUV.restaurantAddress = item.get("vCaddress")
                restaurantDetailsUV.favSelected = item.get("eFavStore").uppercased() == "YES" ? true : false
                restaurantDetailsUV.restaurantRating = item.get("vAvgRating")
                restaurantDetailsUV.restaurantCuisine = item.get("Restaurant_Cuisine")
                GeneralFunctions.saveValue(key: "ispriceshow", value: itemsArray[0].get("ispriceshow") as AnyObject)
            }
            
            
            let WALLET_ENABLE = userProfileJson.get("WALLET_ENABLE")
            
            var controllers = [UIViewController]()
            if(ServiceModule.isDeliverAllOnly())
            {
                let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
                if serviceCategoryArray.count > 1
                {
                    
                    deliveryAllUV = (GeneralFunctions.instantiateViewController(pageName: "DeliveryAllUV") as! DeliveryAllUV)
                    let icon1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                    deliveryAllUV.tabBarItem = icon1
                    deliveryAllUV.homeTabBar = self
                    
                    if(WALLET_ENABLE.uppercased() == "YES"){
                        
                        if(GeneralFunctions.getMemberd() == ""){
                            
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && !ServiceModule.isDeliverAllOnly()){
                                controllers = [ufxProUV!, historyForNoLogIn, walletNoLogIn, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!, historyForNoLogIn, walletNoLogIn, manageProfileUv!]
                            }
                            
                            self.viewControllers = controllers
                           
                        }else{
                            
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && !ServiceModule.isDeliverAllOnly()){
                                controllers = [ufxProUV!, ordersListUV!, manageWalletUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!, ordersListUV!, manageWalletUV!, manageProfileUv!]
                            }
                            
                            self.viewControllers = controllers
                        }
                        
                    }else{
                        if(GeneralFunctions.getMemberd() == ""){
                           
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && !ServiceModule.isDeliverAllOnly()){
                                controllers = [ufxProUV!, historyForNoLogIn, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!, historyForNoLogIn, manageProfileUv!]
                            }
                              //array of the root view controllers displayed by the tab bar interface
                            self.viewControllers = controllers
                            
                        }else{
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && !ServiceModule.isDeliverAllOnly()){
                                controllers = [ufxProUV!, ordersListUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!, ordersListUV!, manageProfileUv!]
                            }
                           
                            self.viewControllers = controllers
                        }
                    }
                }else
                {
                    GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: (serviceCategoryArray[0] as! NSDictionary).get("iServiceId") as AnyObject)
                    delAllUfxHomeUV = (GeneralFunctions.instantiateViewController(pageName: "DelAllUFXHomeUV") as! DelAllUFXHomeUV)
                    delAllUfxHomeUV.homeTabBar = self
                    let icon1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                    delAllUfxHomeUV.tabBarItem = icon1
                    
                    if(WALLET_ENABLE.uppercased() == "YES"){
                        
                        if(GeneralFunctions.getMemberd() == ""){
                          
                            controllers = [self.isOpenRestaurantDetail.uppercased() == "YES" ? restaurantDetailsUV : delAllUfxHomeUV!, historyForNoLogIn, walletNoLogIn, manageProfileUv!]  //array of the root view controllers displayed by the tab bar interface
                            
                            
                        }else{
                            controllers = [self.isOpenRestaurantDetail.uppercased() == "YES" ? restaurantDetailsUV : delAllUfxHomeUV!, ordersListUV!, manageWalletUV!, manageProfileUv!]  //array of the root view controllers displayed by the tab bar interface
                           
                        }
                        
                    }else{
                        
                        if(GeneralFunctions.getMemberd() == ""){
                            
                            controllers = [self.isOpenRestaurantDetail.uppercased() == "YES" ? restaurantDetailsUV : delAllUfxHomeUV!, historyForNoLogIn, manageProfileUv!]  //array of the root view controllers displayed by the tab bar interface
                            
                            
                        }else{
                            controllers = [self.isOpenRestaurantDetail.uppercased() == "YES" ? restaurantDetailsUV : delAllUfxHomeUV!, ordersListUV!, manageProfileUv!]  //array of the root view controllers displayed by the tab bar interface
                            
                        }
                        
                    }
                }
                
            }else if ServiceModule.rideProduct {
                rideDeliveryNewServicesUV = (GeneralFunctions.instantiateViewController(pageName: "RideDeliveryNewServicesUV") as! RideDeliveryNewServicesUV)
                rideDeliveryNewServicesUV.homeTabBar = self
                let icon5 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES"), image: UIImage(named: "ic_service_fill"), selectedImage: UIImage(named: "ic_service_fill"))
                rideDeliveryNewServicesUV.tabBarItem = icon5
                
                controllers = [ufxProUV!, rideDeliveryNewServicesUV ,rideHistoryUV!, manageProfileUv!]
                    
                //controllers = [ufxProUV!,rideHistoryUV!,manageWalletUV! ,manageProfileUv!]
            }
            else{
                
                if (userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && ServiceModule.cubex) {
                    rideDeliveryNewServicesUV = (GeneralFunctions.instantiateViewController(pageName: "RideDeliveryNewServicesUV") as! RideDeliveryNewServicesUV)
                    rideDeliveryNewServicesUV.homeTabBar = self
                    let icon5 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES"), image: UIImage(named: "ic_service_fill"), selectedImage: UIImage(named: "ic_service_fill"))
                    rideDeliveryNewServicesUV.tabBarItem = icon5
                    if(mArray.count > 1){
                        controllers = [ufxProUV!,rideDeliveryNewServicesUV,  rideOrderHistoryTabUV!, manageProfileUv!]
                    }else{
                        controllers = [ufxProUV!,rideDeliveryNewServicesUV, rideHistoryUV!, manageProfileUv!]
                    }
                }else if userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"{
                    
                    uFXServicesUV = (GeneralFunctions.instantiateViewController(pageName: "UFXServicesUV") as! UFXServicesUV)
                    uFXServicesUV.homeTabBar = self
                    let icon1 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                    uFXServicesUV.tabBarItem = icon1
                    
                    controllers = [uFXServicesUV!,  rideHistoryUV!, manageWalletUV!, manageProfileUv!]
                }
                else{
                 
                    if(WALLET_ENABLE.uppercased() == "YES"){
                        
                        if(mArray.count > 1){
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                                controllers = [ufxProUV!,  rideOrderHistoryTabUV!, manageWalletUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!,  rideOrderHistoryTabUV!, manageWalletUV!, manageProfileUv!]
                            }
                            
                        }else{
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                                controllers = [ufxProUV!,  rideHistoryUV! , manageWalletUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!,  rideHistoryUV! , manageWalletUV!, manageProfileUv!]
                            }
                            
                        }
                        
                    }else{
                        
                        if(mArray.count > 1){
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                                controllers = [ufxProUV!,  rideOrderHistoryTabUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!,  rideOrderHistoryTabUV!, manageProfileUv!]
                            }
                            
                        }else{
                            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                                controllers = [ufxProUV!, rideHistoryUV!, manageProfileUv!]
                            }else{
                                controllers = [ufxHomeUV!, rideHistoryUV!, manageProfileUv!]
                            }
                            
                        }
                        
                    }
                }
            }
            
            // FOR DELIVERY APPS
            if(ServiceModule.deliveryProduct || ServiceModule.rideDeliveryProduct){
                
                let moreDeliveriesUv = GeneralFunctions.instantiateViewController(pageName: "MoreDeliveriesUV") as! MoreDeliveriesUV
                moreDeliveriesUv.homeTabBar = self
                moreDeliveriesUv.iVehicleCategoryId = userProfileJson.get("DELIVERY_CATEGORY_ID")
                moreDeliveriesUv.isMenuAdded = false
                moreDeliveriesUv.vCategoryName = ""
                moreDeliveriesUv.navItem = self.navigationItem
                let iconMD = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_BOTTOM_MENU"), image: UIImage(named: "ic_home_new_unselected"), selectedImage: UIImage(named: "ic_home_new_selected"))
                moreDeliveriesUv.tabBarItem = iconMD
                
                let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                rideHistoryUV.homeTabBar = self
                rideHistoryUV.viewLoadForDelivery = true
                rideHistoryUV.isFromUFXCheckOut = false
                rideHistoryUV.isOpenFromMainScreen = false
                rideHistoryUV.isDirectPush = false
                rideHistoryUV.isFromViewProfile = false
                rideHistoryUV.navItem = self.navigationItem
                rideHistoryUV.ordeIdForDirectLiveTrack = ""
                rideHistoryUV.directToLiveTrack = false

                let iconRH = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_BOOKINGS"), image: UIImage(named: "ic_bookings_new_unselcted"), selectedImage: UIImage(named: "ic_booking_new_selected"))
                rideHistoryUV.tabBarItem = iconRH
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && ServiceModule.rideDeliveryProduct){
                    rideDeliveryNewServicesUV = (GeneralFunctions.instantiateViewController(pageName: "RideDeliveryNewServicesUV") as! RideDeliveryNewServicesUV)
                    rideDeliveryNewServicesUV.homeTabBar = self
                    let icon5 = UITabBarItem(title: self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES"), image: UIImage(named: "ic_service_fill"), selectedImage: UIImage(named: "ic_service_fill"))
                    rideDeliveryNewServicesUV.tabBarItem = icon5
                    controllers = [ufxProUV!, rideDeliveryNewServicesUV ,rideHistoryUV, manageProfileUv!]
                    //controllers = [ufxProUV! ,rideHistoryUV, manageWalletUV!,manageProfileUv!]
                    self.viewControllers = controllers
                }else if (userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && ServiceModule.deliveryProduct){
                    if(WALLET_ENABLE.uppercased() == "YES"){
                        
                        controllers = [ufxProUV!,rideHistoryUV,manageWalletUV, manageProfileUv!]
                        self.viewControllers = controllers
                    }else{
                        controllers = [ufxProUV!,rideHistoryUV, manageProfileUv!]
                        self.viewControllers = controllers
                    }
                }else{
                    var finalController = [UIViewController]()
                    for i in 0..<controllers.count{
                        if(i == 0){
                            finalController.append(moreDeliveriesUv)
                        }else if(i == 1){
                            finalController.append(rideHistoryUV)
                        }else{
                            finalController.append(controllers[i])
                        }
                        
                    }
                    self.viewControllers = finalController
                }
            }else{
                self.viewControllers = controllers
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarViewHeight = self.view.frame.size.height
        
        self.tabBar.layer.addShadow(opacity: 0.9, radius: 2, UIColor.gray)
    }
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if(selectedViewController?.isKind(of: ViewProfileUV.self) ?? false){
            (selectedViewController as! ViewProfileUV).tableViewLastCntOffset = nil
        }
        
        if fromView != toView {
            self.removeTitleView()
           // UIView.transition(from: fromView, to: toView, duration: 0.2, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
    
    override func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
    
    func setTabBarVisible(visible: Bool, animated: Bool, completion: @escaping ((Bool)->Void)) {
        
        if ((self.tabBar.isHidden == false && visible == true) || (self.tabBar.isHidden == true && visible == false)) {
            return completion(false)
        }
        // get a frame calculation ready
        let height = self.tabBar.frame.size.height + self.bannerAdHeight
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration = (animated ? 0.2 : 0.0)
        
        UIView.animate(withDuration: duration, animations: {
            self.view.layoutIfNeeded()
            let frame = self.tabBar.frame
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            if(visible == true){
                
                self.tabBar.isHidden = false
                self.bannerAd.isHidden = false
            }else{
                self.tabBar.isHidden = true
                self.bannerAd.isHidden = true
            }
            
        }, completion:completion)
    }
   
    func removeTitleView(){
        self.navItem.leftBarButtonItem = nil
        self.navItem.rightBarButtonItem = nil
        self.navItem.titleView = nil
        
    }
}


class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.2
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}
