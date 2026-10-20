

import Foundation
import UIKit
import TwilioVideo

class VideoCallUV: UIViewController, RoomDelegate, CameraSourceDelegate, RemoteParticipantDelegate{
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var previewView: VideoView!
    
    @IBOutlet weak var remoteView: VideoView!
    
    @IBOutlet weak var callRejectBtn: MyLabel!
    @IBOutlet weak var ansBtn: MyLabel!
    @IBOutlet weak var ansCallStackView: UIStackView!
    @IBOutlet weak var btnStackView: UIStackView!
    
    
    @IBOutlet weak var localVideoTopSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoTrailingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var cameraSwipe: UIImageView!
    @IBOutlet weak var soundMute: UIImageView!
    @IBOutlet weak var speakerOnoff: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileNameLbl: MyLabel!
    
    
    @IBOutlet weak var callingTxtLbl: MyLabel!
    @IBOutlet weak var callingTitleLbl: MyLabel!
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    
    var cntView:UIView!
    
    var accessToken = ""
    var roomName = ""
    var room: Room?
    var camera: CameraSource?
    var localVideoTrack: LocalVideoTrack?
    var localAudioTrack: LocalAudioTrack?
    var remoteParticipant: RemoteParticipant?
    
    var asignedDic = NSDictionary()
    var messageDataDic:NSDictionary!
    
    var callingPersonName = ""
    var isOutGoing = true
    
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    

    var isSpeakerOn = true
    var isMuteOff = true
    var isCameraOn = true
    
    var isVideoCall = ""
    var audioDevice = DefaultAudioDevice()
    
    var callingCount = 0
    weak var callingTimer:Timer?
    
    
    deinit {
        // We are done with camera
        if let camera = self.camera {
            camera.stopCapture()
            self.camera = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configRTL()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isOutGoing == false){
            isVideoCall = messageDataDic.get("isVideoCall").uppercased()
        }else{
            isVideoCall = asignedDic.get("isVideoCall").uppercased()
        }
        
        TwilioVideoSDK.audioDevice = self.audioDevice
        self.audioDevice.block = {
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setMode(AVAudioSession.Mode.voiceChat)
                if(self.isVideoCall.uppercased() == "YES"){
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                }else{
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
                }
                
                
                
            } catch let error as NSError {
                print("Fail: \(error.localizedDescription)")
            }
        }

        self.audioDevice.block();
        
        
        self.contentView.addSubview(self.generalFunc.loadView(nibName: "VideoCallScreenDesign", uv: self, contentView: contentView))

        
        
        self.previewView.isHidden = true
        self.remoteView.isHidden = true
        
        //self.addBackBarBtn()
        if(isOutGoing){
            self.startPreview()
            getAccessToken()
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
       
        self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING")
        
        callingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.callingAnimation), userInfo: nil, repeats: true)
        
        self.cameraSwipe.image = self.cameraSwipe.image?.addImagePadding(x: 30, y: 30)
        self.soundMute.image = self.soundMute.image?.addImagePadding(x: 30, y: 30)
        self.speakerOnoff.image = self.speakerOnoff.image?.addImagePadding(x: 30, y: 30)
        
        self.ansCallStackView.isHidden = false
        self.previewView.isHidden = false
        
        if(self.isOutGoing){
            self.previewView.borderWidth = 0
            self.ansBtn.isHidden = true
            self.btnStackView.isHidden = false
            self.callingTitleLbl.text = asignedDic.get("Name")
            
            self.setToolKitViews()
            
        }else{
            
            self.prepareLocalMedia()
            self.callingTitleLbl.text = messageDataDic.get("Name")
            self.remoteView.isHidden = true
            self.ansBtn.isHidden = false
            
        }
        
        
        self.ansBtn.handleClick { (instance) in
            self.getAccessToken()
        }
        
        self.callRejectBtn.handleClick { (instance) in
           
            self.sendNotificationForCallEnd()
        }
        
        if(isVideoCall.uppercased() == "YES"){
            
            self.previewView.isHidden = false
            self.remoteView.isHidden = false
            
            self.speakerOnoff.backgroundColor = UIColor.white
            GeneralFunctions.setImgTintColor(imgView: self.speakerOnoff, color: UIColor.black)
            
            self.isSpeakerOn = true
            do {
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            } catch let error as NSError {
                print("Fail: \(error.localizedDescription)")
            }
        }else{
            
            self.previewView.isHidden = true
            self.remoteView.isHidden = true
            
            self.callingTitleLbl.isHidden = true
            self.profileImgView.isHidden = false
            self.profileNameLbl.isHidden = false
            self.profileNameLbl.text = self.callingTitleLbl.text
            self.cameraSwipe.isHidden = true
            
            
            if(self.isOutGoing){
                if(asignedDic.get("type") == "Company"){
                    self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.restaurant_image_url)\(asignedDic.get("Id"))/\(asignedDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                    })
                }else{
                    self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(asignedDic.get("Id"))/\(asignedDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                    })
                }
            }else{
                if(messageDataDic.get("type") == "Company"){
                    self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.restaurant_image_url)\(messageDataDic.get("fromMemberId"))/\(messageDataDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                    })
                }else{
                    self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(messageDataDic.get("fromMemberId"))/\(messageDataDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                    })
                }
            }
            
            self.isSpeakerOn = false
            
            self.speakerOnoff.backgroundColor = UIColor.clear
            GeneralFunctions.setImgTintColor(imgView: self.speakerOnoff, color: UIColor.white)
            
            do {
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
            } catch let error as NSError {
                print("Fail: \(error.localizedDescription)")
            }
        }
        
    }
    
    func getAccessToken(){
        var parameters = ["type": "getTwilioAccessToken", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "isVideoCall":self.isOutGoing == true ? asignedDic.get("isVideoCall") : messageDataDic.get("isVideoCall")]
        
        if(self.isOutGoing == false){
            parameters["roomName"]  = messageDataDic.get("roomName")
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                   print(dataDict)
                    self.accessToken = dataDict.dictOf("message").get("token")
                    self.roomName = dataDict.dictOf("message").get("roomName")
                    
                    self.connectToARoom()
                }else{
                    self.generalFunc.setError(uv: self)
                }
                
            }else{
                self.getAccessToken()
            }
            
        })
    }
    
    @objc func callingAnimation(){
        callingCount = callingCount + 1
        if callingCount == 1{
            self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "."
           
        }else if callingCount == 2{
            self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + ".."
           
        }else if callingCount == 3{
            self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "..."
        
        }else{
            callingCount = 0
            self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING")
    
        }
        
    }
    
    func setToolKitViews(){
        
        if(isVideoCall.uppercased() != "YES"){
            self.cameraSwipe.isHidden = true
        }else{
            self.cameraSwipe.isHidden = false
        }

        self.soundMute.isHidden = false
        self.speakerOnoff.isHidden = false

        
        self.cameraSwipe.handleClick { (instance) in
            var newDevice: AVCaptureDevice?

            if let camera = self.camera, let captureDevice = camera.device {
                if captureDevice.position == .front {
                    newDevice = CameraSource.captureDevice(position: .back)
                    self.cameraSwipe.backgroundColor = UIColor.white
                    GeneralFunctions.setImgTintColor(imgView: self.cameraSwipe, color: UIColor.black)
                } else {
                    
                    self.cameraSwipe.backgroundColor = UIColor.clear
                    GeneralFunctions.setImgTintColor(imgView: self.cameraSwipe, color: UIColor.white)
                    newDevice = CameraSource.captureDevice(position: .front)
                }

                if let newDevice = newDevice {
                    
                    camera.selectCaptureDevice(newDevice) { (captureDevice, videoFormat, error) in
                        if error != nil {
                            //self.logMessage(messageText: "Error selecting capture device.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
                        } else {
                            self.previewView.shouldMirror = (captureDevice.position == .front)
                        }
                    }
                  
                }
            }
        
        }
        
        self.soundMute.handleClick { (instance) in
            
            if(self.isMuteOff){
                
                self.soundMute.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.soundMute, color: UIColor.white)
                
                self.isMuteOff = false
                self.localAudioTrack?.isEnabled = true
            }else{
                
                self.soundMute.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.soundMute, color: UIColor.black)
                
                self.isMuteOff = true
                self.localAudioTrack?.isEnabled = false
            }
        
        }
        
        
        self.speakerOnoff.handleClick { (instance) in
            
            if(self.isSpeakerOn){
                self.isSpeakerOn = false
                
                self.speakerOnoff.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.speakerOnoff, color: UIColor.white)
                
                do {
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
                } catch let error as NSError {
                    print("Fail: \(error.localizedDescription)")
                }
                
            }else{
                
                self.speakerOnoff.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.speakerOnoff, color: UIColor.black)
                
            
                self.isSpeakerOn = true
                do {
                    try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                } catch let error as NSError {
                    print("Fail: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func callEnd(){
        
        self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_ENDED")
        if(self.room != nil){
            self.room?.disconnect()
            self.room = nil
        }
        
        if(self.localAudioTrack != nil){
            self.localAudioTrack = nil
        }
        
        if(self.localVideoTrack != nil){
            self.localVideoTrack = nil
        }
        
       
        self.cleanupRemoteParticipant()
        self.close()
    }
   
    func sendNotificationToUser(){
        
        var parameters = ["type": "sendNotificationForTwilio", "fromMemberType": Utils.appUserType, "fromMemberId": GeneralFunctions.getMemberd(), "toMemberType":asignedDic.get("type"), "toMemberId": asignedDic.get("Id"), "isDecline":"No", "roomName":self.roomName, "isVideoCall":asignedDic.get("isVideoCall")]
        
        if(isOutGoing == false){
             parameters = ["type": "sendNotificationForTwilio", "fromMemberType": Utils.appUserType, "fromMemberId": GeneralFunctions.getMemberd(), "toMemberType":messageDataDic.get("type"), "toMemberId": messageDataDic.get("Id"), "isDecline":"No", "roomName":self.roomName, "isVideoCall":messageDataDic.get("isVideoCall")]
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
                
            }else{
                self.getAccessToken()
            }
            
        })
    }
    
    func sendNotificationForCallEnd(){
        
        var parameters = ["type": "sendNotificationForTwilio", "fromMemberType": Utils.appUserType, "fromMemberId": GeneralFunctions.getMemberd(), "toMemberType":asignedDic.get("type"), "toMemberId":asignedDic.get("Id"), "isDecline":"Yes", "roomName":self.roomName, "isVideoCall": asignedDic.get("isVideoCall")]
        
        if(isOutGoing == false){
            parameters = ["type": "sendNotificationForTwilio", "fromMemberType": Utils.appUserType, "fromMemberId": GeneralFunctions.getMemberd(), "toMemberType":messageDataDic.get("type"), "toMemberId":messageDataDic.get("Id"), "isDecline":"Yes", "roomName":self.roomName, "isVideoCall": messageDataDic.get("isVideoCall")]
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.callEnd()
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
                
            }else{
                self.sendNotificationForCallEnd()
            }
            
        })
    }
    
    func connectToARoom() {
        
        
        self.remoteView.isHidden = false
        self.remoteView.contentMode = .scaleAspectFill
        self.remoteView.masksToBounds = true
        
        // Prepare local media which we will share with Room Participants.
        self.prepareLocalMedia()
        
        // Preparing the connect options with the access token that we fetched (or hardcoded).
        let connectOptions = ConnectOptions(token: accessToken) { (builder) in
            
            // Use the local media that we prepared earlier.
            builder.audioTracks = self.localAudioTrack != nil ? [self.localAudioTrack!] : [LocalAudioTrack]()
            builder.videoTracks = self.localVideoTrack != nil ? [self.localVideoTrack!] : [LocalVideoTrack]()
            
            
            
            builder.roomName = self.roomName
        }
        
       
        room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
        
       // self.showRoomUI(inRoom: true)
        
    }
    
    func prepareLocalMedia() {

        // We will share local audio and video when we connect to the Room.

        // Create an audio track.
        if (localAudioTrack == nil) {
            localAudioTrack = LocalAudioTrack(options: nil, enabled: true, name: "Microphone")

            if (localAudioTrack == nil) {
                print("twilio faild tyo connect")
            }
        }

        // Create a video track which captures from the camera.
        if (localVideoTrack == nil) {
            self.startPreview()
        }
   }

    func startPreview() {
        
        let frontCamera = CameraSource.captureDevice(position: .front)
        let backCamera = CameraSource.captureDevice(position: .back)

        if (frontCamera != nil || backCamera != nil) {

            let options = CameraSourceOptions { (builder) in
                if #available(iOS 13.0, *) {
                    // Track UIWindowScene events for the key window's scene.
                    // The example app disables multi-window support in the .plist (see UIApplicationSceneManifestKey).
                    
                }
            }
            // Preview our local camera track in the local video preview view.
            camera = CameraSource(options: options, delegate: self)
            localVideoTrack = LocalVideoTrack(source: camera!, enabled: true, name: "Camera")

            
            self.previewView.contentMode = .scaleAspectFill
            self.previewView.masksToBounds = true
            
            // Add renderer to video track for local preview
            localVideoTrack!.addRenderer(self.previewView)
            print("video track created")

            if (frontCamera != nil && backCamera != nil) {
                // We will flip camera on tap.
               // let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.flipCamera))
               // self.previewView.addGestureRecognizer(tap)
            }
            
           
            camera!.startCapture(device: frontCamera != nil ? frontCamera! : backCamera!)

           
        }
        else {
            
            print("no front camera detected")
           
        }
    }
    
    func setupRemoteVideoView() {
        
        self.setToolKitViews()
        self.previewView.contentMode = .scaleAspectFill
        self.previewView.masksToBounds = true
        self.remoteView.contentMode = .scaleAspectFill
        self.remoteView.masksToBounds = true
        
        self.view.layoutIfNeeded()
        self.localVideoTopSpace.constant = 150
        self.localVideoBottomSpace.constant = (Application.screenSize.height / 2) + (self.localVideoTopSpace.constant / 1.4)
        
        self.localVideoTrailingSpace.constant = 15
        self.localVideoLeadingSpace.constant = (Application.screenSize.width / 2) + (self.localVideoTrailingSpace.constant * 3.5)
        self.previewView.borderWidth = 0.5

        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.btnStackView.isHidden = false
        self.ansBtn.isHidden = true
        
        callingTimer?.invalidate()
        callingTimer = nil
        startTime = Date().timeIntervalSinceReferenceDate - elapsed
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    func renderRemoteParticipant(participant : RemoteParticipant) -> Bool {
        // This example renders the first subscribed RemoteVideoTrack from the RemoteParticipant.
        let videoPublications = participant.remoteVideoTracks
        for publication in videoPublications {
            if let subscribedVideoTrack = publication.remoteTrack,
                publication.isTrackSubscribed {
                setupRemoteVideoView()
                if(isVideoCall.uppercased() == "YES"){
                    subscribedVideoTrack.addRenderer(self.remoteView!)
                }
                
                self.remoteParticipant = participant
                return true
            }
        }
        return false
    }

    
    func renderRemoteParticipants(participants : Array<RemoteParticipant>) {
        for participant in participants {
            // Find the first renderable track.
            if participant.remoteVideoTracks.count > 0,
                renderRemoteParticipant(participant: participant) {
                break
            }
        }
    }
    
    func cleanupRemoteParticipant() {
        if self.remoteParticipant != nil {
            self.remoteView?.removeFromSuperview()
            self.remoteView = nil
            self.remoteParticipant = nil
        }
    }
    

    func roomDidConnect(room: Room) {
        print("room connected")
        
        if(self.isOutGoing == false){
            startTime = Date().timeIntervalSinceReferenceDate - elapsed
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            
        }else{
            self.sendNotificationToUser()
        }
        
        // This example only renders 1 RemoteVideoTrack at a time. Listen for all events to decide which track to render.
        for remoteParticipant in room.remoteParticipants {
            remoteParticipant.delegate = self
        }
    }

   
    func roomDidDisconnect(room: Room, error: Error?) {
        print("room discconected")
        
       //self.cleanupRemoteParticipant()
        self.room = nil
        
        self.callEnd()
       // self.showRoomUI(inRoom: false)
    }


    func roomDidFailToConnect(room: Room, error: Error) {
        
        print("\(error): room connection failed")
        self.room = nil
        self.callEnd()
    }

    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        participant.delegate = self
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        self.callEnd()
    }
    
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack, publication: RemoteVideoTrackPublication, participant: RemoteParticipant) {
        if (self.remoteParticipant == nil) {
            _ = renderRemoteParticipant(participant: participant)
        }
    }
    
    
    @objc func updateCounter() {
        
        if timer == nil{
            return
        }
        
        // Calculate total time since timer started in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        let hours = Int(time / 3600)
        // Calculate minutes
        let minutes = UInt8(time / 60.0)
        time -= (TimeInterval(minutes) * 60)
        
        // Calculate seconds
        let seconds = UInt8(time)
        time -= TimeInterval(seconds)
        
        
        // Format time vars with leading zero
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        UIView.transition(with: self.callingTxtLbl,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.callingTxtLbl.text = "\(strHours):\(strMinutes):\(strSeconds)"
                            self?.callingTxtLbl.text = Configurations.convertNumToAppLocal(numStr: (self?.callingTxtLbl.text!)!)
            }, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
