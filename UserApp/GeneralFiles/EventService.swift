

import Foundation
import CoreLocation
import SysBaseLib

class EventService: NSObject, OnLocationUpdateDelegate, OnTaskRunCalledDelegate{
    
    static let removeSCInst_key = "REMOVE_SC_PUBSUB_INST"
    static let removeInst_key = "REMOVE_PUBNUB_INST"
    static let pauseInst_key = "PAUSE_PUBNUB_INST"
    static let resumeInst_key = "RESUME_PUBNUB_INST"
    static let TRIP_COMPLETE_NOTI_OBSERVER_KEY = "TRIP_COMPLETE_NOTI_KEY"
    
    typealias CompletionHandler = (_ response:String) -> Void
    
    /**
     * Variable declaration of singleton instance.
     */
    static var eventService:EventService!
    
    /**
     * client is object of sockect cluster. With the help of this object, we can perform any required operations of socket cluster. Socket cluster is running on particular port and mentioned port must be open for all connection (Public port).
     */
    var client = ScClient(url: GeneralFunctions.getValue(key: Utils.SC_CONNECT_URL_KEY) as! String)
    
    /**
     * Variable used to check user is successfully authenticated or not.
     */
    var isUserAuthenticated = false
    
    /**
     * This list maintains list of subscribed channels list.
     */
    var listOfSubscribedList = [String]()
    
    /**
     * This list maintains list of channels list, which are not subscribed.
     */
    var listOfNotSubscribedList = [String]()
    
    /**
     * This task will will perform connection between app to server.
     */
    var reConnectionFreqTask:TaskScheduler!
    
    /**
     * This variable check weather a subscribing to one channel is in process or not.
     */
    var isChannelSubscribing = false
    
    var getLocation:DeviceLocation!
    
    var FETCH_TRIP_STATUS_TIME_INTERVAL_INT = 15
    var updateTripStatusFreqTask:TaskScheduler!
    
    var generalFunc = GeneralFunctions()
    
    var latitude = 0.0
    var longitude = 0.0
    
    var iTripId = ""
    var checkTripStatus:ApiHandler!
    
    let messageStoreDict = NSMutableDictionary()
    var isDispatchThreadLocked = false
    
    var isKilled = false
    
    var isSubsToCabReq = false
    
    /**
     * Creating Singleton instance. By using this method will create only one instance of this class.
     */
    static func getInstance() -> EventService{
        
        if(eventService == nil){
            eventService = EventService()
        }
        
        return eventService
    }
    
    static func retrieveInstance() -> EventService?{
        return eventService
    }
    
    /**
     * This function will create a socket connection with the help of socket cluster with mentioned server. Don't call this function every time. This must be called once on each session of app.
     */
    func buildConnection(){
        if(self.client.isConnected()){
            return
        }
        
        Utils.printLog(msgData: "SC_CONNECT_URL::\(GeneralFunctions.getValue(key: Utils.SC_CONNECT_URL_KEY) as! String)")
        getLocation = DeviceLocation(uv: Application.window!.rootViewController!, isContinuous: true)
        getLocation.buildLocManager(locationUpdateDelegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.forceDestroy), name: NSNotification.Name(rawValue: EventService.removeSCInst_key), object: nil)
        
        
        let FETCH_TRIP_STATUS_TIME_INTERVAL = GeneralFunctions.getValue(key: Utils.FETCH_TRIP_STATUS_TIME_INTERVAL_KEY) != nil ? (GeneralFunctions.getValue(key: Utils.FETCH_TRIP_STATUS_TIME_INTERVAL_KEY) as! String) : "15"
        
        FETCH_TRIP_STATUS_TIME_INTERVAL_INT = GeneralFunctions.parseInt(origValue: 15, data: FETCH_TRIP_STATUS_TIME_INTERVAL)
        
        
        updateTripStatusFreqTask = TaskScheduler(interval: GeneralFunctions.parseDouble(origValue: 15, data: FETCH_TRIP_STATUS_TIME_INTERVAL))
        updateTripStatusFreqTask.onTaskRunCalled = self
        updateTripStatusFreqTask.currInst = updateTripStatusFreqTask
        updateTripStatusFreqTask.startRepeatingTask()
        
        
        /**
         * This is a basic connection listener. This listener will be called when connection related event occurred.
         */
        client.setBasicListener(onConnect: { (scClient) in
            // Called when socket connection is established
            print("ConnectedToSocket")
            self.stopReConnectScheduleTask()
            
            let subscribeTask = TaskScheduler(interval: 4)
            subscribeTask.currInst = subscribeTask
            subscribeTask.setTaskRunHandler { (currentInst) in
                self.continueChannelSubscribe()
                
                subscribeTask.stopRepeatingTask()
            }
            subscribeTask.startRepeatingTask()
            
        }, onConnectError: { (scClient, error) in
            // Called when error occurred in socket connection
            
            
            self.reConnectClient()
        }, onDisconnect: { (scClient, error) in
            // Called when socket connection is disconnected
            //            print("SocketDisconnect::\(String(describing: error))")
            self.reConnectClient()
        })
        
        /**
         * This is a authentication listner. This listner will be called when user is successfully authenticated by server OR user needs to be authenticated.
         */
        client.setAuthenticationListener(onSetAuthentication: { (scClient, authToken) in
            // Called when authentication is successful and authentication token is set by server. Server will set authentication code when user login is verified.
            print("AuthenticatedUser::\(String(describing: authToken))")
            
        }, onAuthentication: { (scClient, isAuthenticated) in
            // By Using this listner we can check user needs to be authenticated OR not.
            
            if(isAuthenticated != nil && isAuthenticated! == true){
                // Server Authentication Successful (Authentication is not needed)
                print("AuthenticatedUser")
                //                self.continueChannelSubscribe()
            }else{
                // Do Server Authentication (Authentication is needed)
                //                self.authenticateUser(client: scClient)
                
                //                self.continueChannelSubscribe()
            }
        })
        
        /**
         * Called to connect socket cluster.
         */
        client.connect()
        
        
        
    }
    
    func onTaskRun(currInst: TaskScheduler) {
        
        if(self.isKilled == true){
            return
        }
        
        if(updateTripStatusFreqTask != nil && currInst == updateTripStatusFreqTask){
            if(self.client.isConnected()){
                getUserTripStatus(completionHandler: { (isTaskCompleted) in
                    
                })
            }
        }
//        scheduleAppInactiveNotifition()
    }
    
    func scheduleAppInactiveNotifition(){
        
        Utils.removeAppInactiveStateNotifications()
        
        Utils.addAppInactiveStateNotification(seconds: FETCH_TRIP_STATUS_TIME_INTERVAL_INT + 5)
    }
    
    func onLocationUpdate(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
    func getUserTripStatus(completionHandler: @escaping (Bool?) -> Swift.Void){
        if(isKilled == true) || (Configurations.isUserLoggedIn() == false){
            return
        }
       
        
        let extraRequestParams = CabRequestStatus.getAllStatusParam()
        var parameters = [String:String]()
        
        if(Utils.appUserType.uppercased() == "PASSENGER" || Utils.appUserType.uppercased() == "HOTEL"){
            parameters = ["type": "configPassengerTripStatus", "iTripId": self.iTripId, "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
            if(latitude != 0.0 && longitude != 0.0){
                parameters["vLatitude"] = "\(latitude)"
                parameters["vLongitude"] = "\(longitude)"
            }
        }else{
            self.iTripId = GeneralFunctions.getValue(key: "iTripId") as! String
            
            parameters = ["type": "configDriverTripStatus", "iTripId": iTripId != nil ? (iTripId ) : "", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "isSubsToCabReq": "\(isSubsToCabReq)"]
            if(latitude != 0.0 && longitude != 0.0){
                parameters["vLatitude"] = "\(latitude)"
                parameters["vLongitude"] = "\(longitude)"
            }
            
            
            for key in extraRequestParams.allKeys {
                parameters[key as! String] = extraRequestParams.get(key as! String)
            }
        }
        
        
        if(checkTripStatus != nil){
            checkTripStatus.cancel()
            
            checkTripStatus = nil
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        checkTripStatus = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
                let dataDict = response.toDict()
                if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                    Utils.printLog(msgData: "SESSION_OUT_CALLED")
                    if (GeneralFunctions.getMemberd() != "") {
                    if(GeneralFunctions.isAlertViewPresentOnScreenWindow(viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG) == false){
                        
                        GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                        GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)
                        
                        self.generalFunc.setAlertMessage(uv: nil , title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG, completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            
                            GeneralFunctions.logOutUser()
                            GeneralFunctions.restartApp(window: Application.window!)
                        })
                    }
                        return
                    }
                    return
                }
                completionHandler(true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.AppServicesObserver), object: nil, userInfo: ["configTripResult":response, "iTripId":self.iTripId, "extraRequestParams":extraRequestParams])
                
            }
        })
    }
    
    /**
     * Function used to reconnect socket connection if conncetion failure/disconnect.
     */
    func reConnectClient(){
        
        if(reConnectionFreqTask != nil || self.isKilled == true){
            return
        }
        self.stopReConnectScheduleTask()
        reConnectionFreqTask = TaskScheduler(interval: 10)
        reConnectionFreqTask.currInst = reConnectionFreqTask
        reConnectionFreqTask.setTaskRunHandler { (currentInst) in
            self.client.connect()
        }
        reConnectionFreqTask.startRepeatingTask()
    }
    
    /**
     * This will stop reconnection task.
     */
    func stopReConnectScheduleTask(){
        if(reConnectionFreqTask != nil){
            reConnectionFreqTask.stopRepeatingTask()
            reConnectionFreqTask = nil
        }
    }
    
    /**
     * Function used to authenticate user.
     */
    func authenticateUser(client: ScClient){
        
        var params = [String:String]()
        params["iMemberId"] = GeneralFunctions.getMemberd()
        params["tSessionId"] = GeneralFunctions.getSessionId()
        params["UserType"] = Utils.appUserType
        params["deviceHeight"] = "\(Application.screenSize.height)"
        params["deviceWidth"] = "\(Application.screenSize.width)"
      
        /**
         * This code will transfer user's credentials to server to check it is right or not. Based on that credentials server will authenticate user.
         */
        client.emitAck(eventName: "authenticateUser", data: params as AnyObject) { (eventName, error, data) in
            
            if(error != nil && !error!.isKind(of: NSNull.self)){
                // Error in Authentication.
                
                let dataDict = (error! as! String).toDict()
                
                if(dataDict.get(Utils.action_str) == "0"){
                    // Authentication unsuccessful. This case should not come normally.
                    
                }else{
                    // Some error occurred in authentication. Do authentication again.
                    self.authenticateUser(client: client)
                }
                
            }else{
                if(data != nil){
                    let dataDict = (data! as! String).toDict()
                    
                    if(dataDict.get(Utils.action_str) == "1"){
                        // Authentication Successful. Start initialing all things.
                        
                        
                        self.continueChannelSubscribe()
                        
                    }
                }
                
            }
        }
    }
    
    /**
     * This function is used to subscribe channels, which are not due to not connected to server.
     */
    func continueChannelSubscribe(){
        
        if(Utils.appUserType.uppercased() == "HOTEL"){
            if(self.isKilled == true){
                return
            }
            
            //        self.isUserAuthenticated = true
            
            self.isChannelSubscribing = false
            
            self.releaseAllChannels()
            
            //Subscribing to private channel.
            EventService.getInstance().subscribeToChannels(channelName: "PASSENGER_\(GeneralFunctions.getValue(key: "TEMPUSERID") as! String)")
            
            for i in 0..<self.listOfSubscribedList.count{
                self.subscribeToChannels(channelName: self.listOfSubscribedList[i])
            }
        }else{
            if(self.isKilled == true){
                return
            }
            
            //        self.isUserAuthenticated = true
            
            self.isChannelSubscribing = false
            
            self.releaseAllChannels()
            
            //Subscribing to private channel.
            EventService.getInstance().subscribeToChannels(channelName: "\(Utils.appUserType.uppercased())_\(GeneralFunctions.getMemberd())")
            
            for i in 0..<self.listOfSubscribedList.count{
                self.subscribeToChannels(channelName: self.listOfSubscribedList[i])
            }
        }
        
        
    }
    
    
    /**
     * This function is used to subscribe to channels. (Publish-Subscribe module)
     */
    func subscribeToChannels(channelName:String){
        
        print("channelName::\(channelName)")
        
        // Add any new Channels to subscribed channels list. We will use this list to unsubscribe channels.
        if(!self.listOfSubscribedList.contains(channelName)){
            self.listOfSubscribedList += [channelName]
        }
        
        //        if(self.isUserAuthenticated == false){
        //            // If User is not authenticated, then wait for authentication and after authentication we will resubscribe that channels.
        //            return
        //        }
        if(self.client.isConnected() == false){
            return
        }
        
        if(isChannelSubscribing == true){
            self.listOfNotSubscribedList += [channelName]
            return
        }
        
        isChannelSubscribing = true
        
        if(Utils.appUserType.uppercased() == "DRIVER"){
            self.isSubsToCabReq = true
        }
        
        // Function used to subscribe nerw channels with acknowledgement.
        self.client.subscribeAck(channelName: channelName, ack : {
            (channelName : String, error : AnyObject?, data : AnyObject?) in
            
            self.isChannelSubscribing = false
            
            if (error is NSNull) {
                
                // If subscribe to particular channel is success then start hearing on that channel
                self.client.onChannel(channelName: channelName, ack: { (channelName : String , data : AnyObject?) in
                    // Handle data when some event notification is arrived.
                    
                    print("DataInChannelReceived:\(channelName):\(String(describing: data))")
                    if(self.messageStoreDict.get(String(describing: data)) == ""){
                        self.messageStoreDict[String(describing: data)] = "Yes"
                        print("DataInChannelReceived::\(String(describing: data))")
                        
                        var result = NSDictionary()
                        
                        if((data! as? NSDictionary) != nil){
                            result = data! as! NSDictionary
                        }else if((data! as? String) != nil){
                            result = (data! as! String).toDict()
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            if(result.count > 0){
                                self.dispatchMsg(result: result.toJsonStr(), "")
                            }else if((data! as? String) != nil){
                                self.dispatchMsg(result: data! as! String, "")
                            }
                            
                        }
                    }
                    
                })
                
                print("Successfully subscribed to channel ", channelName)
                
                
                if(self.listOfNotSubscribedList.count > 0){
                    let newChannel = self.listOfNotSubscribedList[0]
                    self.listOfNotSubscribedList.remove(at: 0)
                    
                    self.subscribeToChannels(channelName: newChannel)
                }
                
                
            } else {
                // If error appears then try to resubscribe to channel. A recursive call will be called after 2 seconds delay.
                Utils.delayWithSeconds(2, completion: {
                    self.subscribeToChannels(channelName: channelName)
                })
                
                print("Got error while subscribing ", String(describing: error))
            }
        })
    }
    
    /**
     * Function used to unsubscribe user from particular channel.
     */
    func unSubscribeFromChannels(channelName:String){
        if(self.listOfSubscribedList.contains(channelName)){
            
            self.client.unsubscribeAck(channelName: channelName, ack: { (channelName, error, data) in
                if (error is NSNull) {
                    if let index = self.listOfSubscribedList.index(of: channelName) {
                        self.listOfSubscribedList.remove(at: index)
                    }
                }else{
                    if(error != nil && error as? NSDictionary != nil){
                        let errorDict = error! as! NSDictionary
                        
                        if(errorDict.get("name") != "BrokerError"){
                            // IF problem appears on unsbscribing channel then retry it. A recursive call will be called after 2 seconds delay.
                            Utils.delayWithSeconds(2, completion: {
                                self.unSubscribeFromChannels(channelName: channelName)
                            })
                        }
                    }
                    
                }
            })
        }
    }
    
    func subscribeToCabReqChannel(){
        isSubsToCabReq = true
        
        self.subscribeToChannels(channelName: "CAB_REQUEST_DRIVER_\(GeneralFunctions.getMemberd())")
        
       
    }
    
    func unSubscribeToCabReqChannel(){
        isSubsToCabReq = false
        
        self.unSubscribeFromChannels(channelName: "CAB_REQUEST_DRIVER_\(GeneralFunctions.getMemberd())")
        
        
    }
    
    func unSubscribeToPrivateChannel() {
        self.unSubscribeFromChannels(channelName: "\(Utils.appUserType.uppercased())_\(GeneralFunctions.getMemberd())")
        
        
    }
    
    func subscribeToPrivateChannel() {
        self.subscribeToChannels(channelName: "\(Utils.appUserType.uppercased())_\(GeneralFunctions.getMemberd())")
       
    }
    
    
    /**
     * Function used to unsubscribe all channels. Generally this will be done when app is going to be terminate.
     */
    func releaseAllChannels(){
        for i in 0..<self.listOfSubscribedList.count{
            self.unSubscribeFromChannels(channelName: self.listOfSubscribedList[i])
        }
    }
    
    /**
     * Function used to destroy current instance. Generally this will be done when app is going to be terminate OR instance of this class is no longer required.
     */
    @objc func forceDestroy(){
        
        print("Class REmovede")
        releaseAllChannels()
        if(EventService.retrieveInstance() != nil){
            self.isKilled = true
            EventService.retrieveInstance()!.client.disconnect()
            stopReConnectScheduleTask()
            if(updateTripStatusFreqTask != nil){
                updateTripStatusFreqTask.stopRepeatingTask()
            }
            if(getLocation != nil){
                getLocation.releaseLocationTask()
                getLocation.locationUpdateDelegate = nil
                getLocation = nil
            }
            GeneralFunctions.removeObserver(obj: EventService.retrieveInstance()!)
            EventService.eventService = nil
        }
    }
    
    /**
     * Function used to publish data to particular channel.
     */
    func publishMsg(channelName:String, content:String){
        
        self.client.publishAck(channelName: channelName, data: content as AnyObject) { (channel, error, data) in
            if(error is NSNull){
                
            }
        }
    }
    
    /**
     * Function used to dispatch message to user when received some event on particular channel.
     */
    func dispatchMsg(result:String, _ receivedBy:String){
        
        if(Utils.appUserType.uppercased() == "PASSENGER"){
            if(!isDispatchThreadLocked){
                isDispatchThreadLocked = true
                
                if(self.messageStoreDict.get(result) == ""){
                    self.messageStoreDict[result] = "Yes"
                    
                    Utils.printLog(msgData: "dispatchMsgCalled::\(result)")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.AppServicesObserver), object: nil, userInfo: ["fireTripResult":result])
                    
                    //FireTripStatusMessges().fireTripMsg(result, true)
                }
                isDispatchThreadLocked = false
            }
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.AppServicesObserver), object: nil, userInfo: ["fireTripResult":result, "receivedBy":receivedBy])
        }
        
        
    }
    
}


class CabRequestStatus: NSObject {
    static let DRIVER_REQUEST_STATUS_KEY = "DRIVER_REQUEST_STATUS_"

    static func updateDriverRequestStatus(PassengerId:String, UpdatedStatus: String,ReceiverByscriptName : String, repeatCount:Int, vMsgCode:String){
        GeneralFunctions.saveValue(key: DRIVER_REQUEST_STATUS_KEY + vMsgCode + "_\(Utils.currentTimeMillis())_\(PassengerId)_\(UpdatedStatus)_\(ReceiverByscriptName)", value: "Yes" as AnyObject)
        
        if (repeatCount > 3) {
            return
        }
        
        let parameters = ["type":"updateDriverRequestStatus", "iDriverId": GeneralFunctions.getMemberd(), "PassengerId":PassengerId, "UpdatedStatus":UpdatedStatus, "ReceiverByscriptName": ReceiverByscriptName, "vMsgCode":vMsgCode]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
            }else{
                let repCount = repeatCount + 1
                CabRequestStatus.updateDriverRequestStatus(PassengerId: PassengerId, UpdatedStatus: UpdatedStatus, ReceiverByscriptName: ReceiverByscriptName, repeatCount: repCount, vMsgCode: vMsgCode)
            }
            
        })
    }
    
    static func removeDriverRequestStatus(reqKeys:NSDictionary){
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            if key.hasPrefix(DRIVER_REQUEST_STATUS_KEY) {
                if(reqKeys.get(key) != ""){
                    GeneralFunctions.removeValue(key: key)
                }
            }
        }
    }
    
    static func getAllStatusParam() -> NSDictionary {
        let reqKeys = NSMutableDictionary()
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            var newValue = value
            if let b = newValue as? String {
                if(NetworkHelper.isEncAllowed() == true && key != "SERVERURL"){
                    newValue = DataHelper.sharedInstance.decrypt(input: b) as AnyObject
                }
            }
            
            if key.hasPrefix(DRIVER_REQUEST_STATUS_KEY) {
                reqKeys[key] = (newValue as? String) == nil ? "" : (newValue as! String)
//                reqKeys.append(key)
            }
        }
        
        return reqKeys
    }
   
}
