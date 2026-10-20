
import UIKit
import GoogleMaps
import AVFoundation
import GoogleSignIn
import FirebaseAnalytics
import Firebase
import Fabric
import IQKeyboardManagerSwift
import FBSDKCoreKit
import LiveChat
import AdSupport
import SysBaseLib
import AppTrackingTransparency


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SINManagedPushDelegate, UIColorPickerViewControllerDelegate, AppServiceDelegate    {
    
    var window: UIWindow?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    var push:SINManagedPush!
    var refreshRequired = true
    var fcmDeviceToken = ""
  
    var tokenTimer:Timer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        GeneralFunctions.saveValue(key: "IS_USERDATA_IN_PROGRESS", value: false as AnyObject)
        
        // Quick Login
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "IS_QUICK_LOGIN") == false){
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: false as AnyObject)
        }
    
        AppService.getInstance().appServiceDelegate = self
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.USER_PROFILE_DICT_KEY) == true){
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            _ = ServiceModule.init(dataDict: userProfileJson)
        }
        
        WKWebViewWarmUper.shared.prepare()

        GeneralFunctions.saveValue(key: "APP_IS_IN_BACKGROUND", value: false as AnyObject)
        GeneralFunctions.saveValue(key: "REFRESH_APP", value: false as AnyObject)
       
        /* SET FONTFAMILY */
        GeneralFunctions.saveValue(key: "FONTFAMILY", value: Utils.getFontWeightList(familyName: Utils.fontFname) as AnyObject)
        UIFont.overrideDefaultTypography()
        /* */
        
        // Override point for customization after application launch.
        GeneralFunctions.saveValue(key: "SERVERURL", value: "http://192.168.1.141/" as AnyObject)
        GeneralFunctions.saveValue(key: "SERVER_PATH", value: CommonUtils.webservice_path as AnyObject)
        
        // Watch app changes
        WatchSessionManager.sharedManager.startSession()
    
        // For UFX Provider
        GeneralFunctions.removeValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS")
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            GeneralFunctions.saveValue(key: "UFXCartData", value: [[NSDictionary]]() as AnyObject)
        }
        
        Configurations.setAppLocal()
      //  Fabric.with([Crashlytics.self])
        
        //SDImageCache.shared().clearMemory()
        //SDImageCache.shared().clearDisk()
        
        GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: "" as AnyObject)
        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "false" as AnyObject)
        UserDefaults.standard.set("", forKey: "guestTap")
        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
            //            (GeneralFunctions()).setError(uv: Application.window!.rootViewController!, title: "", content: "From Push")
            let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as! [AnyHashable : Any]
            
            let notification = userInfo["aps"] as? NSDictionary
            
            if(notification?.get("body") != "" && (notification!.get("body")).toDict().get("MsgType") == "CHAT"){
                
                if(Application.window != nil && Application.window?.rootViewController != nil){
                    
                    if(GeneralFunctions.getVisibleViewController(Application.window!.rootViewController) != nil && GeneralFunctions.getVisibleViewController(Application.window!.rootViewController)!.className != "ChatUV"){
                        GeneralFunctions.saveValue(key: "OPEN_MSG_SCREEN", value: notification!.get("body") as AnyObject)
                    }
                }
                
            }else if (notification?.get("body") != "" && (notification!.get("body")).toDict().get("MsgType") == "VOIP"){
                
                if GeneralFunctions.getMemberd() != "" {
                    SinchCalling.getInstance().initSinchClient()
                    let result:SINNotificationResult = SINManagedPush.queryPushNotificationPayload(userInfo)
                    if result.isCall(){
                        GeneralFunctions.saveValue(key: "SINCHCALLING", value: true as AnyObject)
                        
                        DispatchQueue.main.async {
                            
                            SinchCalling.getInstance().client.relayPushNotification(userInfo)
                        }
                        
                    }
                }
                
            }else if(notification?.get("body") != "" && ((notification!.get("body")).toDict().get("MsgType") == "TripCancelledByDriver" || (notification!.get("body")).toDict().get("Message") == "TripCancelledByDriver" || (notification!.get("body")).toDict().get("Message") == "TripEnd" || (notification!.get("body")).toDict().get("MsgType") == "TripEnd")){
                
                if(Application.window != nil && Application.window?.rootViewController != nil){
                    
                    if(GeneralFunctions.getVisibleViewController(Application.window!.rootViewController) != nil && GeneralFunctions.getVisibleViewController(Application.window!.rootViewController)!.className != "RatingUV"){
                        GeneralFunctions.saveValue(key: "OPEN_RATING_SCREEN", value: "\((notification!.get("body")).toDict().get("iTripId"))" as AnyObject)
                    }
                }
                
                if(notification != nil && notification?.get("body") != ""){
                    if((notification!["body"] as? NSDictionary) != nil){
                        let jsonDic = notification!["body"] as! NSDictionary
                        
                        FireTripStatusMessges().fireTripMsg(jsonDic.toJsonStr(), false, "")
                    }else if((notification!["body"] as? String) != nil){
                        
                        let jsonData = notification!["body"] as! String
                        
                        FireTripStatusMessges().fireTripMsg(jsonData, false, "")
                    }
                }
                
            }else{
              
                if(notification != nil && notification?.get("alert") == "" && notification?.get("sound") == ""){
                    if(notification != nil && notification?.get("body") != ""){
                        if((notification!["body"] as? NSDictionary) != nil){
                            let jsonDic = notification!["body"] as! NSDictionary
                            
                            FireTripStatusMessges().fireTripMsg(jsonDic.toJsonStr(), false, "")
                        }else if((notification!["body"] as? String) != nil){
                            
                            let jsonData = notification!["body"] as! String
                            
                            FireTripStatusMessges().fireTripMsg(jsonData, false, "")
                        }
                    }
                }
             
            }
            
        }
        
        Configurations.setAppThemeNavBar()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = (GeneralFunctions()).getLanguageLabel(origValue: "Done", key: "LBL_DONE")
        IQKeyboardManager.shared.disabledToolbarClasses.append(MessagesViewController.self)
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(MessagesViewController.self)
        
        
        Analytics.setAnalyticsCollectionEnabled(true)
        
        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        if(!GeneralFunctions.isKeyExistInUserDefaults(key: Utils.deviceTokenKey) || GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String == ""){
            GeneralFunctions.saveValue(key: Utils.deviceTokenKey, value: "simulator_demo_1234" as AnyObject)
        }
        
        LocalNotification.registerForLocalNotification(on: UIApplication.shared)
        
        GeneralFunctions.registerRemoteNotification(true)
        
      
        UIViewController.present()
      
        NotificationCenter.default.addObserver(self, selector: #selector(self.getAppServicesWithInfo(_:)), name: NSNotification.Name(rawValue: Utils.AppServicesObserver), object: nil)
        
        
        GeneralFunctions.saveValue(key: "SINCHCALLING", value: false as AnyObject)
        if Configurations.isDevelopmentMode() == true{
        self.push = Sinch.managedPush(with: SINAPSEnvironment.development)
        }else{
            self.push = Sinch.managedPush(with: SINAPSEnvironment.production)
            
        }
        self.push.delegate = self
        self.push.setDesiredPushType(SINPushTypeVoIP)

        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.deviceTokenKey) && GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String == "simulator_demo_1234"){
            self.tokenTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(getTokenFromRegister), userInfo: nil, repeats: true)
        }else{
            
            if(self.tokenTimer != nil){
                self.tokenTimer.invalidate()
                self.tokenTimer = nil
            }
        }
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.USER_PROFILE_DICT_KEY)){
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
        }
        
        return true
    }
    
    @objc func getTokenFromRegister(){
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.deviceTokenKey) && (GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String == "simulator_demo_1234" || GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String == "")){
            GeneralFunctions.registerRemoteNotification(true)
        }else{
            self.tokenTimer.invalidate()
            self.tokenTimer = nil
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
  
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let isFacebookURL = url.scheme != nil && url.scheme!.hasPrefix("fb\(Settings.appID!)") && url.host != nil && url.host! == "authorize"
        if isFacebookURL {
            return ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        }
        
        let isGoogleUrl = url.scheme != nil && url.scheme!.hasPrefix("com.googleusercontent.apps")
        
        if(isGoogleUrl){
            GIDSignIn.sharedInstance()?.handle(url)
           
        }
        

        if Auth.auth().canHandle(url) {
            return true
          }
        
        return self.openUrlFromCutomNotification(url:url)
    
    }
  
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        
        GeneralFunctions.saveValue(key: "APP_IS_IN_BACKGROUND", value: true as AnyObject)
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIMinimumKeepAliveTimeout)
        
        GeneralFunctions.postNotificationSignal(key: Utils.appBGNotificationKey, obj: self)
        
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
    }
    
    func endApplicationTask(){
        SinchCalling.getInstance().terminateInstance()
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            
            self?.senAppStateToServer(isTerminate: "Yes")
            self?.endBackgroundTask()
        }
    }
    
    func endBackgroundTask() {
        Utils.printLog(msgData: "Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        GeneralFunctions.saveValue(key: "APP_IS_IN_BACKGROUND", value: false as AnyObject)
        
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        registerBackgroundTask()
        
        GeneralFunctions.postNotificationSignal(key: Utils.appFGNotificationKey, obj: self)

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
//        window?.addGestureRecognizer(tap)
        
        self.setAppTrackingPermission()
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                ATTrackingManager.requestTrackingAuthorization { status in
                }
            }
        }
        else {}
        self.identifierForAdvertising()
        _ = GeneralFunctions.getSafeAreaInsets()
        self.senAppStateToServer(isTerminate: "No")
        
        //******* REFRESH UI
        GeneralFunctions.saveValue(key: "APP_IS_IN_BACKGROUND", value: false as AnyObject)
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "REFRESH_APP") && GeneralFunctions.getValue(key: "REFRESH_APP") as! Bool == true){
            
            var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
            
            if(viewController != nil){
                viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
                GeneralFunctions.saveValue(key: "REFRESH_APP", value: false as AnyObject)
                
                let window = Application.window
                
                let getUserData = GetUserData(uv: viewController!, window: window!)
                getUserData.getdata()
                
               // let userProfileJsonDict = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict()
              //  let _ = OpenMainProfile(uv: viewController!, userProfileJson: userProfileJsonDict.toJsonStr(), window: window!)
            }
        }
        //*******
        
        GeneralFunctions.postNotificationSignal(key: Utils.appFGNotificationKey, obj: self)
        
        Utils.resetAppNotifications()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        self.senAppStateToServer(isTerminate: "Yes")
        UserDefaults.standard.set("", forKey: "guestTap")
        GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
        GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
        GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)

        self.endApplicationTask()
        
        GeneralFunctions.saveValue(key: "IS_USERDATA_IN_PROGRESS", value: false as AnyObject)
        
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

        
        GeneralFunctions.saveValue(key: "APNID", value: token as AnyObject)
        GeneralFunctions.saveValue(key: Utils.deviceTokenKey, value: token as AnyObject)
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.apnIDNotificationKey), object: nil, userInfo: ["body":token, "FCMToken": token])
        
        if(GeneralFunctions.getMemberd() != ""){
            self.tokenSaveCall()
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    
        if(UIDevice().type == .simulator){
            let token = "simulator_demo_1234"
             GeneralFunctions.saveValue(key: Utils.deviceTokenKey, value: token as AnyObject)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.apnIDNotificationKey), object: nil, userInfo: ["body":token, "FCMToken": token])
        }else{
            GeneralFunctions.registerRemoteNotification(true)
        }
    }
    
 
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

       
        print("APNS RECEIVER:::::::::::::\(userInfo)")
        let notification = userInfo["aps"] as? NSDictionary

        if(notification != nil && notification?.get("alert") == "" && notification?.get("sound") == ""){

            if((notification?.dictOf("alert"))?.get("loc-key") == "SIN_INCOMING_CALL_DISPLAY_NAME"){
                self.refreshRequired = false
               // self.push.application(application, didReceiveRemoteNotification: userInfo)
                return
            }

            if(notification == nil || notification?.get("body") == ""){
                return
            }

            if((notification!["body"] as? NSDictionary) != nil){
                let jsonDic = notification!["body"] as! NSDictionary

                FireTripStatusMessges().fireTripMsg(jsonDic.toJsonStr(), false, "")
            }else if((notification!["body"] as? String) != nil){

    //            if (application.applicationState == .background) {
    //                return
    //            }

                let jsonData = notification!["body"] as! String

                FireTripStatusMessges().fireTripMsg(jsonData, false, "")
            }
        }
    }
    

    
    func managedPush(_ managedPush: SINManagedPush!, didReceiveIncomingPushWithPayload payload: [AnyHashable : Any]!, forType pushType: String!) {
        if(GeneralFunctions.getMemberd() != "") {
            let result:SINNotificationResult = SINManagedPush.queryPushNotificationPayload(payload)
            if result.isCall(){
                SinchCalling.getInstance().initSinchClient()
                if self.refreshRequired == true{
                    GeneralFunctions.saveValue(key: "SINCHCALLING", value: true as AnyObject)
                }
                DispatchQueue.main.async {
                    SinchCalling.getInstance().client.relayPushNotification(payload)
                }
                
            }
        }
    }
    

/////////////////////////// CUSTOM_NOTIFICATION UI CODE ///////////////////////////////////////////////////
    
    func openUrlFromCutomNotification(url:URL) -> Bool{
    
        let urlPath : String = url.absoluteString
        let pathComponenetsArray = urlPath.components(separatedBy: "@")
        let id = pathComponenetsArray.last
        var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
        
        if(viewController != nil){
            viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
        }
        
        
        
        if (((pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1] == ("RIDE")) || (pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1] == ("DELIVER"))) && url.scheme!.hasPrefix("\(Bundle.main.bundleIdentifier!).OpenFromCustomNotiUI")){
            
            if(viewController != nil && viewController!.isKind(of: LauncherScreenUV.self)){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    
                    if(pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1].contains("RIDE")){
                        self.checkAppRestarted(oId:id ?? "", screenToOpen:"RIDE")
                    }else{
                        self.checkAppRestarted(oId:id ?? "", screenToOpen:"DELIVER")
                    }
                    
                }
            }
            return true
        }
        
        if ((pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1] == ("UBERX") || pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1] == ("Multi-Delivery")) && url.scheme!.hasPrefix("\(Bundle.main.bundleIdentifier!).OpenFromCustomNotiUI")){
            
            if(viewController != nil && viewController!.isKind(of: LauncherScreenUV.self)){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    
                    if(pathComponenetsArray[1].contains("UBERX")){
                        self.checkAppRestarted(oId:id ?? "", screenToOpen:"UBERX@ViewDetails", urlPath)
                    }else{
                        self.checkAppRestarted(oId:id ?? "", screenToOpen:"Multi-Delivery@ViewDetails", urlPath)
                    }
                    
                }
            }else{
                let myOnGoingTripDetailsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                
                var dataDic = [String:String]()
                for i in 0..<pathComponenetsArray.count{
                    
                    if(i != 0 && i != 1){
                        let dataComp = pathComponenetsArray[i].components(separatedBy: "=")
                        dataDic[dataComp[0]] = dataComp[1]
                    }
                }
                
                myOnGoingTripDetailsUV.openFromCustomNoti_UI = true
                myOnGoingTripDetailsUV.dataDict = dataDic as NSDictionary
                viewController?.push(uv: myOnGoingTripDetailsUV)
                
            }
            return true
        }
        
        if (pathComponenetsArray[0].contains("LiveTrack") && pathComponenetsArray[1] == ("DELIVERALL") && url.scheme!.hasPrefix("\(Bundle.main.bundleIdentifier!).OpenFromCustomNotiUI")){
            //here go to firstViewController view controller

            
            if(viewController != nil && viewController!.isKind(of: LauncherScreenUV.self) && (viewController as! LauncherScreenUV).isScreenLoaded == false){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.checkAppRestarted(oId:id ?? "", screenToOpen:"DELIVERALL@LiveTrack")
                }
                
                
            }else{
                let liveTrackUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                liveTrackUv.orderId = id ?? ""
                liveTrackUv.isDirect = true
                viewController?.push(uv: liveTrackUv)
            }
            return true
        }
        
        if (pathComponenetsArray[0].contains("ViewDetails") && pathComponenetsArray[1] == ("DELIVERALL") && url.scheme!.hasPrefix("\(Bundle.main.bundleIdentifier!).OpenFromCustomNotiUI")){
            //here go to firstViewController view controller

            if(viewController != nil && viewController!.isKind(of: LauncherScreenUV.self) && (viewController as! LauncherScreenUV).isScreenLoaded == false){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.checkAppRestarted(oId:id ?? "", screenToOpen:"DELIVERALL@ViewDetails")
                }
              
                
            }else{
                let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
                orderDetailsUv.orderId = id ?? ""
                viewController?.push(uv: orderDetailsUv)
            }

            return true
        }
    
        return false
    }
    
    func checkAppRestarted(oId:String, screenToOpen:String, _ path:String = ""){
        
        let pathComponenetsArray = path.components(separatedBy: "@")
        
        var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
        
        if(viewController != nil){
            viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
        }
        if(viewController != nil && viewController!.isKind(of: LauncherScreenUV.self) && (viewController as! LauncherScreenUV).isScreenLoaded == false){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.checkAppRestarted(oId: oId, screenToOpen:screenToOpen, path)
            }
            
        }else{
            
            
            if(screenToOpen == "UBERX@ViewDetails" || screenToOpen == "Multi-Delivery@ViewDetails"){
                
                let myOnGoingTripDetailsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                
                var dataDic = [String:String]()
                for i in 0..<pathComponenetsArray.count{
                    
                    if(i != 0 && i != 1){
                        let dataComp = pathComponenetsArray[i].components(separatedBy: "=")
                        dataDic[dataComp[0]] = dataComp[1]
                    }
                }
                
                myOnGoingTripDetailsUV.openFromCustomNoti_UI = true
                myOnGoingTripDetailsUV.dataDict = dataDic as NSDictionary
                viewController?.push(uv: myOnGoingTripDetailsUV)
                
            }else if(screenToOpen == "DELIVERALL@LiveTrack"){
                let liveTrackUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                liveTrackUv.orderId = oId
                liveTrackUv.isDirect = true
                viewController?.push(uv: liveTrackUv)
            }else if(screenToOpen == "DELIVERALL@ViewDetails"){
                let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
                orderDetailsUv.orderId = oId
                viewController?.push(uv: orderDetailsUv)
            }
            
        }
    }
    
    func senAppStateToServer(isTerminate:String, _ isDoneCount:Int = 0){
        
        
        if(Configurations.isUserLoggedIn() == false){
            return
        }
        
        let viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : UIViewController()
        
        
        let parameters = ["type":"CheckAppTerminate","iMemberId": GeneralFunctions.getMemberd(), "eAppTerminate": isTerminate]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: viewController!.view, isOpenLoader: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
        
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                }else{
                    
                    if(isDoneCount < 2){
                        self.senAppStateToServer(isTerminate:isTerminate, isDoneCount + 1)
                    }
                   
                }
                
            }
        })
    }
    // App tracking Data Set
    func setAppTrackingPermission()  {
        
    }
    
    func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
    
    @objc func getAppServicesWithInfo(_ notification: Notification){
        let generalFunc = GeneralFunctions()
        
        let userInfo = notification.userInfo as NSDictionary?
        
        print(userInfo)
        if(userInfo != nil && userInfo?.get("fireTripResult") != ""){
            FireTripStatusMessges().fireTripMsg(userInfo!.get("fireTripResult"), true, "")
        }else if(userInfo != nil && userInfo?.get("configTripResult") != ""){
            
            let iTripId = userInfo!.get("iTripId")
            let response = userInfo!.get("configTripResult")
            let dataDict = response.toDict()
            
            if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                Utils.printLog(msgData: "SESSION_OUT_CALLED")
                if(GeneralFunctions.isAlertViewPresentOnScreenWindow(viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG) == false){
                    
                    GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                    GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)
                    
                    generalFunc.setAlertMessage(uv: nil , title: "", content: generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG, completionHandler: { (btnClickedIndex) in
                        
                        GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                        
                        GeneralFunctions.logOutUser()
                        GeneralFunctions.restartApp(window: Application.window!)
                    })
                }
                
                return
            }
        
            if(dataDict.get("Action") == "1"){
                
                //                    if(self.isKilled == false){
                DispatchQueue.main.async {
                    if dataDict.dictOf(Utils.message_str) is Dictionary<AnyHashable,Any> {
                        print(dataDict.dictOf(Utils.message_str).toJsonStr())
                        
                        EventService.getInstance().dispatchMsg(result: dataDict.dictOf(Utils.message_str).toJsonStr(), "")
                    }else{
                        print(dataDict.get(Utils.message_str))
                        EventService.getInstance().dispatchMsg(result: dataDict.get(Utils.message_str), "")
                    }
                    
                }
                //                    }
            }
            
            if(dataDict.arrOf("currentDrivers").count > 0 ){
                //                    && self.isKilled == false
                let currentDriversLocArr = dataDict.arrOf("currentDrivers")
                
                let PUBSUB_TECHNIQUE = GeneralFunctions.getValue(key: Utils.PUBSUB_TECHNIQUE_KEY) == nil ? "" : (GeneralFunctions.getValue(key: Utils.PUBSUB_TECHNIQUE_KEY) as! String)
                
                if(PUBSUB_TECHNIQUE.uppercased() == "NONE"){
                    DispatchQueue.main.async {
                        for i in 0..<currentDriversLocArr.count{
                            let data_temp = currentDriversLocArr[i] as! NSDictionary
                            let dictionary = ["MsgType": iTripId == "" ? "LocationUpdate" : "LocationUpdateOnTrip", "iDriverId": data_temp.get("iDriverId"), "ChannelName": "ONLINE_DRIVER_LOC_\(data_temp.get("iDriverId"))", "vLatitude": data_temp.get("vLatitude"),"vLongitude": data_temp.get("vLongitude"), "LocTime": "\(Utils.currentTimeMillis())"]
                            
                            let js_data = (dictionary as NSDictionary).toJsonStr()
                            
                            EventService.getInstance().dispatchMsg(result: js_data, "")
                        }
                    }
                }
            }
        }
        
    }
    
    func tokenSaveCall(){
        
        let parameters = ["type": "GetMemberWalletBalance", "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
        })
    }
    
    // Custme Color Changes
    @objc func respondToSwipeGesture(gestureReconizer: UILongPressGestureRecognizer) {
   
        if(gestureReconizer.state == .ended){
            let alert = UIAlertController(title: "Change Color", message: "Choose Option", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "For Apptheme", style: UIAlertAction.Style.default, handler: { _ in
                        if #available(iOS 14.0, *) {
                            let picker = UIColorPickerViewController()
                            picker.delegate = self
                            picker.title = "For Apptheme"
                            picker.view.backgroundColor = UIColor.white
                            picker.selectedColor = SColors.Theme

                            var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                            
                            if(viewController != nil){
                                viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
                            }
                            if(viewController != nil && viewController!.navigationController != nil){
                                let currentViewCOntroller = viewController!.navigationController!.viewControllers.last
                                
                                currentViewCOntroller?.present(picker, animated: true, completion: nil)
                            }else{
                                
                                if(viewController != nil){
                                    let navController = UINavigationController(rootViewController: picker)
                                    picker.addBack()
                                    navController.navigationBar.isTranslucent = false
                                    viewController?.present(navController, animated: true, completion: nil)
                                }
                            }
                            
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "For Apptheme Text",
                                                  style: UIAlertAction.Style.default,
                                                  handler: {(_: UIAlertAction!) in
                                                    //Sign out action
                                                    if #available(iOS 14.0, *) {
                                                        let picker = UIColorPickerViewController()
                                                        picker.delegate = self
                                                        picker.title = "For Apptheme Text"
                                                        picker.view.backgroundColor = UIColor.white
                                                        picker.selectedColor = SColors.Theme

                                                        var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                                                        
                                                        if(viewController != nil){
                                                            viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
                                                        }
                                                        if(viewController != nil && viewController!.navigationController != nil){
                                                            let currentViewCOntroller = viewController!.navigationController!.viewControllers.last
                                                            
                                                            currentViewCOntroller?.present(picker, animated: true, completion: nil)
                                                        }else{
                                                            
                                                            if(viewController != nil){
                                                                let navController = UINavigationController(rootViewController: picker)
                                                                picker.addBack()
                                                                navController.navigationBar.isTranslucent = false
                                                                viewController?.present(navController, animated: true, completion: nil)
                                                            }
                                                        }
                                                        
                                                    }
                    }))
            
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: UIAlertAction.Style.cancel,
                                          handler: {(_: UIAlertAction!) in
                
            }))
            
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            //self.view.backgroundColor = viewController.selectedColor
        if(viewController.title == "For Apptheme"){
            SColors.Theme = viewController.selectedColor
        }else{
            SColors.ThemeTxt = viewController.selectedColor
        }
        Configurations.setAppThemeNavBar()
        GeneralFunctions.restartApp(window: Application.window!)
        
    }
    
    func onSubscribeToChannels(channelName: String) {
        EventService.getInstance().subscribeToChannels(channelName: channelName)
    }
    
    func onUnSubscribeFromChannels(channelName: String) {
        EventService.getInstance().unSubscribeFromChannels(channelName: channelName)
    }
    
    func onPublishMsg(channelName: String, content: String) {
        EventService.getInstance().publishMsg(channelName: channelName, content: content)
    }
    
    func onServiceDestroy() {
        EventService.getInstance().forceDestroy()
    }
    
    func onSubscribeToCabReqChannel() {
        EventService.getInstance().subscribeToCabReqChannel()
    }
    
    func onUnSubscribeToCabReqChannel() {
        EventService.getInstance().unSubscribeToCabReqChannel()
    }
    
    func loadServiceCategory(parentCategoryId:String, category :String = "", _ eForVideoConsultation:String = ""){
        
        if(GeneralFunctions.getMemberd() == ""){
            return
        }
        
//        let parameters = ["type":"getServiceCategoriesPro", "userId": GeneralFunctions.getMemberd(), "parentId": "0","vLatitude": "", "vLongitude": ""] //TEMP
        
        let parameters = ["type":"getServiceCategoriesProNew", "userId": GeneralFunctions.getMemberd(), "parentId": "0","vLatitude": "", "vLongitude": ""]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
    
            
            if(response != ""){
                
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.saveValue(key: "SERVICE_HOME_DATA", value: response as AnyObject)
                    
                    
                }
            
            }else{
                
//                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
//                self.loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
            }
            
         
            
        })
    }
        
   
}
