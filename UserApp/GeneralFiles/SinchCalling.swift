//
//  SinchCalling.swift
//  DriverApp
//
//  Created by Admin on 10/13/18.
//  Copyright © 2018 #. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import SysBaseLib

protocol SinchCallingProtocol: AnyObject {
    func callDidEnd()
    func callDidEstablish()
    func clientDidStart()
}

class SinchCalling: NSObject, SINCallClientDelegate, SINCallDelegate, SINClientDelegate, SINAudioControllerDelegate {
    
    
    
    weak var delegate: SinchCallingProtocol? = nil
    
    public static var sinchInstance:SinchCalling?
    
    var sinAudioController: SINAudioController!
    var client: SINClient!
    var callFromSynch:SINCall!
    var callRunnig = false
    
    let generalFunc = GeneralFunctions()
    
    var soundPath = ""
    
    var audioPlayer:AVAudioPlayer?
    
    var sinchCallingUV:SinchCallingUV!

    var media_type = ""
    
    var signalingUrl = ""
    var localClient:ScClient!
    var webRTCClient:WebRTCClient!
    
    var userProfileJson:NSDictionary!
    
    static func getInstance() -> SinchCalling{
        if(sinchInstance == nil){
            sinchInstance = SinchCalling()
        }
        
        return sinchInstance!
    }
    
    func localizedString(forKey key: String) -> String {
    
        return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    }
    
    func initSinchClient(){
        
        if(GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) == nil){
            return
        }
        
        
        self.getcallingMethodAndPlatform()
        self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
       
        if(userProfileJson.get("SINCH_APP_KEY") != "" && userProfileJson.get("SINCH_APP_SECRET_KEY") != "" && userProfileJson.get("SINCH_APP_ENVIRONMENT_HOST") != ""){
            if GeneralFunctions.getMemberd() == "" {
                if client != nil{
                  //  removeSinchClient()
                }
            }else{
                if client == nil{
                    
                    GeneralFunctions.registerRemoteNotification(false)
                    
                    //GeneralFunctions.registerRemoteNotification()
                    do {
                        client = try Sinch.client(withApplicationKey: userProfileJson.get("SINCH_APP_KEY"), environmentHost: userProfileJson.get("SINCH_APP_ENVIRONMENT_HOST"), userId: Utils.appUserType + "_" + GeneralFunctions.getMemberd())
                    }catch {
                        print("SINCH INIT ERROR:\(error)")
                    }
                    
                    client.call().delegate = self
                    client.delegate = self

                    client.setSupportPushNotifications(true)
                    client.enableManagedPushNotifications()
                    if Configurations.isDevelopmentMode() == true{


                        SinchCalling.getInstance().client.registerPushNotificationDeviceToken((GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String).utf8Data, type: SINPushTypeVoIP, apsEnvironment: SINAPSEnvironment.development)

                    }else{
                        SinchCalling.getInstance().client.registerPushNotificationDeviceToken((GeneralFunctions.getValue(key: Utils.deviceTokenKey) as! String).utf8Data, type: SINPushTypeVoIP, apsEnvironment: SINAPSEnvironment.production)

                    }
                    
                    
                    
                    client.start()
                    
                    
                    sinAudioController = client.audioController()
                    if(GeneralFunctions.getValue(key: Utils.VOIP_NOTIFICATION) as? String != nil){
                        if(GeneralFunctions.getValue(key: Utils.VOIP_NOTIFICATION) as? String != ""){
                            let word = (GeneralFunctions.getValue(key: Utils.VOIP_NOTIFICATION) as! String).components(separatedBy: ".")
                            soundPath = Bundle.main.path(forResource: word[0], ofType: "wav")!
                        }else{
                            soundPath = Bundle.main.path(forResource: "telephone", ofType: "wav")!
                        }
                    }else{
                        soundPath = Bundle.main.path(forResource: "telephone", ofType: "wav")!
                    }
                    
                    //SINAudioController.s
                }
            }
        }
        
    }
    
    func playSound(soundPath: String)
    {
        if(soundPath != ""){
            let coinSound = NSURL(fileURLWithPath: soundPath)
            print(coinSound)
            
            
            do{
                //            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                //            try AVAudioSession.sharedInstance().setActive(true)
                
                if #available(iOS 10.0, *) {
                    try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
                }
                else {
                    AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
                }
                
                Utils.printLog(msgData: "AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                    Utils.printLog(msgData: "AVAudioSession is Active")
                } catch {
                    print(error)
                }
                
                audioPlayer = try AVAudioPlayer(contentsOf:coinSound as URL)
                audioPlayer!.volume = AVAudioSession.sharedInstance().outputVolume
                audioPlayer!.numberOfLoops = 15
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
                
                
            }catch {
                Utils.printLog(msgData: "Error getting the audio file")
            }
        }
        
    }
    
    func makeACall(IDString:String, assignedData:NSDictionary, selfData:[String:String], withRealNumber:String, _ isVideoCall:Bool = false){
        
        if(media_type.uppercased() == Utils.TWILIO){
            let videoCallUV = GeneralFunctions.instantiateViewController(pageName: "VideoCallUV") as! VideoCallUV
            videoCallUV.asignedDic = assignedData
            
            let visibleViewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
            if(visibleViewController != nil){
                visibleViewController!.push(uv: videoCallUV, isDirect: true)
            }else{
                Application.window!.rootViewController?.push(uv: videoCallUV, isDirect: true)
            }
           
            return
        }else if(media_type.uppercased() == Utils.LOCAL){
            
            let videoCallUV = GeneralFunctions.instantiateViewController(pageName: "LocalVideoCallingUV") as! LocalVideoCallingUV
            videoCallUV.asignedDic = assignedData
            videoCallUV.isVideoCall = isVideoCall == true ? "Yes" : "No"
            videoCallUV.selfDic = selfData as NSDictionary
            
            let visibleViewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
            if(visibleViewController != nil){
                visibleViewController!.push(uv: videoCallUV, isDirect: true)
            }else{
                Application.window!.rootViewController?.push(uv: videoCallUV, isDirect: true)
            }
           
            self.storeMessageToclientServer(idString:IDString, callEnded: "No")
            return
        }
        
        if callFromSynch == nil && client != nil{
            
            if client.isStarted(){
                
                if(isVideoCall == true){
                    callFromSynch = client.call()?.callUserVideo(withId: IDString, headers: selfData)
                }else{
                    if (withRealNumber != ""){
                        callFromSynch = client.call().callPhoneNumber(withRealNumber)
                    }else{
                        callFromSynch = client.call().callUser(withId: IDString, headers: selfData)
                    }
                }
              
                callFromSynch.delegate = self
                
                do{
                    try client.setPushNotificationDisplayName(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INCOMING_CALL"))
                }catch{
                    print("errorr")
                }
                
                
                self.sinchCallingUV = GeneralFunctions.instantiateViewController(pageName: "SinchCallingUV") as? SinchCallingUV
                
                sinchCallingUV.isVideoCall = isVideoCall
                sinchCallingUV.assignedData = assignedData
                sinchCallingUV.modalPresentationStyle = .overCurrentContext
                let visibleViewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                if(visibleViewController != nil){
                    visibleViewController!.push(uv: sinchCallingUV, isDirect: true)
                }else{
                    Application.window!.rootViewController?.push(uv: sinchCallingUV, isDirect: true)
                }
                
                self.storeMessageToclientServer(idString:IDString, callEnded: "No")
                return
            }else{
                
                if(client.isStarted() == false){
                    self.initSinchClient()
                    return
                }
                callFromSynch.hangup()
                
            }
            
        }else{
            
            if(client == nil){
                self.initSinchClient()
                return
            }
            callFromSynch.hangup()
            
            return
        }
    }

    func removeSinchClient(){
        
        var sinVideoView = SinchCalling.getInstance().client.videoController()
        if(sinVideoView != nil && self.sinchCallingUV != nil){
            
            sinVideoView?.remoteView()?.removeFromSuperview()
            sinVideoView?.localView()?.removeFromSuperview()
            
            self.sinchCallingUV.remoteVideoView.removeFromSuperview()
            self.sinchCallingUV.localVideoView.removeFromSuperview()
            sinVideoView = nil
            
        }
        
        self.audioPlayer = nil
        sinAudioController.stopPlayingSoundFile()
        client.unregisterPushNotificationDeviceToken()
       // self.client.terminateGracefully()
        
        if(callFromSynch != nil){
            callFromSynch = nil
        }

    }
    
    /* SINCH DELEGATE METHODS.*/
    func client(_ client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        self.playSound(soundPath: soundPath)
        call.delegate = self
        callFromSynch = call

        self.sinchCallingUV = GeneralFunctions.instantiateViewController(pageName: "SinchCallingUV") as? SinchCallingUV
        sinchCallingUV.assignedData = call.headers! as NSDictionary
        sinchCallingUV.isCallReceiving = true
        sinchCallingUV.modalPresentationStyle = .overCurrentContext
        let visibleViewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
        if(visibleViewController != nil){
            visibleViewController!.push(uv: sinchCallingUV, isDirect: true)
        }else{
            Application.window!.rootViewController?.push(uv: sinchCallingUV, isDirect: true)
        }
        //callFromSynch.answer()
    }
    
    func callDidEnd(_ call: SINCall!) {
       
        self.removeSinchClient()
        //client.setPushNotificationDisplayName(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_ENDED"))
        
        
        self.audioPlayer = nil
        sinAudioController.stopPlayingSoundFile()
        callRunnig = false
        callFromSynch = nil
        delegate?.callDidEnd()
        
        SinchCalling.getInstance().initSinchClient()
        print("<<<<<<<<CALL ENDED>>>>>>>")
    }
    
    func callDidEstablish(_ call: SINCall!) {
        print("<<<<<<<<CALL ESTABLISH>>>>>>>")
        
        self.audioPlayer = nil
        sinAudioController.stopPlayingSoundFile()
        callRunnig = true
        delegate?.callDidEstablish()
        
        
        let dic = call.headers! as NSDictionary
        if(self.sinchCallingUV != nil && dic.get("isVideoCall").uppercased() == "YES"){
  
            SinchCalling.getInstance().sinAudioController.enableSpeaker()
            
            let sinVideoView = SinchCalling.getInstance().client.videoController()
           
            let remoteView = sinVideoView?.remoteView()
            
            remoteView?.contentMode = .scaleAspectFill
            remoteView?.sin_enableFullscreen(true)
            self.sinchCallingUV.remoteVideoView.addSubview(remoteView!)
            self.sinchCallingUV.remoteVideoView.masksToBounds = true
            
            self.sinchCallingUV.view.layoutIfNeeded()
            self.sinchCallingUV.localVideoTopSpace.constant = 150
            self.sinchCallingUV.localVideoBottomSpace.constant = (Application.screenSize.height / 2) + (self.sinchCallingUV.localVideoTopSpace.constant / 1.4)
            
            self.sinchCallingUV.localVideoTrailingSpace.constant = 15
            self.sinchCallingUV.localVideoLeadingSpace.constant = (Application.screenSize.width / 2) + (self.sinchCallingUV.localVideoTrailingSpace.constant * 3.5)
            self.sinchCallingUV.localVideoView.borderWidth = 0.5

            UIView.animate(withDuration: 0.3, animations: {
                self.sinchCallingUV.view.layoutIfNeeded()
            })
            
        }
    }
    

    func client(_ client: SINClient!, requiresRegistrationCredentials registrationCallback: SINClientRegistration!) {
        
        do {
            let jwt = try sinchJWTForUserRegistration(withApplicationKey: self.userProfileJson.get("SINCH_APP_KEY"),
                                                      applicationSecret: self.userProfileJson.get("SINCH_APP_SECRET_KEY"),
                                                    userId: Utils.appUserType + "_" + GeneralFunctions.getMemberd())
            registrationCallback.register(withJWT: jwt)

        } catch {
            print("Error to register sinch call")
        }
    }
    
    func callDidProgress(_ call: SINCall!) {
        print("<<<<<<<<CALL PROGRESS>>>>>>>")
        
        
    }
    
    func clientDidStart(_ client: SINClient!) {
        
        print("<<<<<<<<CLIENT DID START>>>>>>>")
    }
    
    func clientDidStop(_ client: SINClient!) {
        print("<<<<<<<<CLIENT DID STOP>>>>>>>")
    }
    
    func clientDidFail(_ client: SINClient!, error: Error!) {
        self.audioPlayer = nil
        sinAudioController.stopPlayingSoundFile()
        self.client = nil
        //self.initSinchClient()
        print(">>>>>>>CLIENT Did FAIL>>>>>>>\(String(describing: error))")
    }
    
    func storeMessageToclientServer(idString:String, callEnded:String)
    {
        let date = Date()
        let nowDate:String = Utils.convertDateToFormate(date: date, formate: "yyyy-MM-dd HH:mm:ss")
        let parameters = ["type":"SendTripMessageNotification","UserType": Utils.appUserType, "iFromMemberId": GeneralFunctions.getMemberd(), "iToMemberId": idString,"vDate":nowDate, "isForVoip": "Yes", "isCallEnded": callEnded, "eSystem":(idString.contains(find: "Company") ? "DeliverAll":"")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
            }else{
                
            }
        })
        
    }
    
    func initWebRTC(){
        webRTCClient = WebRTCClient()
    }
    
    func initLocalCalling(){
        if(media_type.uppercased() == Utils.LOCAL){
            if(localClient == nil){
                
                Utils.printLog(msgData: "====Local Call Init ======")
                
                localClient = ScClient(url: self.signalingUrl)
                localClient.setAuthToken(token: Utils.appUserType + "_" + GeneralFunctions.getMemberd())
                localClient.connect()
                
                self.initWebRTC()
                
                localClient.setBasicListener(onConnect: { (scClient) in
                    // Called when socket connection is established
                    
                    Utils.printLog(msgData: "====Local Call Init -onConnect-======")
                    
                    self.localClient.on(eventName: "*", ack: {
                                    (eventName : String, data : AnyObject?) in
                        
                        usleep(useconds_t(0.1 * 1000000.0))
                        
                        if let str = data as? String {
                            
                           
                            let finalData = str.components(separatedBy: "@@")
                            
                            print("SDSDSD:\(finalData)")
                            
                            
                            if(Application.window != nil && Application.window?.rootViewController != nil){
                                
                                let videoCallUV = GeneralFunctions.instantiateViewController(pageName: "LocalVideoCallingUV") as! LocalVideoCallingUV
                                videoCallUV.isOutGoing = false
                                
                                
                               // print("DATA MULTIPLESSSSSSS111")
                                if(finalData.count > 3 && (finalData[2]) != "CallEnd" && (finalData[2]).toDict().get("type").lowercased() == "offer"){
                                    videoCallUV.messageDataDic = finalData.last?.toDict()
                                    videoCallUV.webRTCClient = self.webRTCClient
                                    videoCallUV.roomID = finalData[1]
                                    videoCallUV.client = self.localClient
                                    videoCallUV.listinigEventFor(eventName : eventName, data : data)
                                    
                                    if((finalData[1]) == Utils.appUserType + "_" + GeneralFunctions.getMemberd()){
                                        let visibleViewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                                        if(visibleViewController != nil){
                                            visibleViewController!.push(uv: videoCallUV, isDirect: true)
                                        }else{
                                            Application.window!.rootViewController?.push(uv: videoCallUV, isDirect: true)
                                        }
                                    }
                                    
                                }else{
                                    
                                    
                                 
                                    var localVideoCallingUV:LocalVideoCallingUV!
                                    var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                                    
                                    if(viewController != nil){
                                        viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
                                    }
                                    if(viewController != nil && viewController!.isKind(of: LocalVideoCallingUV.self)){
                                        localVideoCallingUV = (viewController as! LocalVideoCallingUV)
                                    }else if(viewController != nil && viewController!.navigationController != nil){
                                        for i in 0..<viewController!.navigationController!.viewControllers.count{
                                            let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                                            
                                            if(currentViewCOntroller.isKind(of: LocalVideoCallingUV.self)){
                                                localVideoCallingUV = (currentViewCOntroller as! LocalVideoCallingUV)
                                            
                                                break
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    if(localVideoCallingUV != nil){
                                        
                                       // print("DATA MULTIPLESSSSSSS000")
                                        if((finalData[1]) ==  localVideoCallingUV.roomID){
                                            if(finalData.count > 3 && (finalData[2]) != "CallEnd"){
                                                
                                               // print("DATA MULTIPLESSSSSSS")
                                                localVideoCallingUV.messageDataDic = finalData.last?.toDict()
                                                localVideoCallingUV.listinigEventFor(eventName : eventName, data : data)
                                            }else{
                                                localVideoCallingUV.callEndViewSetup()
                                            }
                                        }
                                        
                                    
                                    }
                                }
                              
                            }
                        }
                    })
                  
                }, onConnectError: { (scClient, error) in
                    
                    Utils.delayWithSeconds(5.0) {
                        if(self.localClient != nil){
                            self.localClient.connect()
                        }
                    }
                    
                }, onDisconnect: { (scClient, error) in
                    
                    Utils.delayWithSeconds(5.0) {
                        if(self.localClient != nil){
                            self.localClient.connect()
                        }
                    }
                    
                })
            }
            
           
        }
    }
    
    func getcallingMethodAndPlatform(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
       
        if(userProfileJson.get("AUDIO_CALLING_METHOD").uppercased() == Utils.SINCH){
            self.media_type = Utils.SINCH
        }else if(userProfileJson.get("AUDIO_CALLING_METHOD").uppercased() == Utils.TWILIO){
            self.media_type = Utils.TWILIO
        }else if(userProfileJson.get("AUDIO_CALLING_METHOD").uppercased() == Utils.LOCAL){
            
            
            signalingUrl = userProfileJson.get("WEBRTC_SOCKET_URL")
            Utils.printLog(msgData: "LOCAL CALLLING SOCKET:\(signalingUrl)")
            
            self.media_type = Utils.LOCAL
            self.initLocalCalling()
        }
    }
    
    
    func terminateInstance(){
     
        if(self.media_type.uppercased() == Utils.SINCH){
        
            if(self.client != nil){
                self.client.terminateGracefully()
            }
        }else if(self.media_type.uppercased() == Utils.TWILIO){
           
        }else if(self.media_type.uppercased() == Utils.LOCAL){
            if(self.localClient != nil){
                self.localClient.disconnect()
                self.localClient = nil
            }
            
            if(self.webRTCClient != nil){
            
                self.webRTCClient.peerConnection = nil
                self.webRTCClient.isConnected = false
        
                self.webRTCClient = nil
            }
          
        }
        
        if(SinchCalling.sinchInstance != nil){
            SinchCalling.sinchInstance = nil
        }
    }
  
}
