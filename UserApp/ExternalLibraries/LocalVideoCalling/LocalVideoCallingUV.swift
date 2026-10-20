

import Foundation
import WebRTC
import SysBaseLib
//import ConfigData

class LocalVideoCallingUV: ParentViewUV, ParentViewUVDelegate, WebRTCClientDelegate, CameraCaptureDelegate {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var remoteView: UIView!
    
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
    
    
    var asignedDic = NSDictionary()
    var messageDataDic:NSDictionary!
    
    var selfDic = NSDictionary()
    
    var callingPersonName = ""
    var isOutGoing = true
    
    weak var timer: Timer?
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    
    var isVideoCall = ""
  
    var callingCount = 0
    weak var callingTimer:Timer?
    
    //var socket: WebSocket!
    var tryToConnectWebSocket: Timer!
    
    var webRTCClient: WebRTCClient!
    
    var cameraManager:CameraManager!
    
    var signalingUrl = ""
    var client:ScClient!
    
    var isSocketConnected = false
    
    var roomID = ""
    
    var isRemoteFrameSet = false
    var localToLarge = false
    var isCameraOff = false
    var isMuteOn = false
    var isSpeakerOn = false
    var speakerImgTapped = false
    
    var eventName = ""
    var data:AnyObject?
    var ansData:AnyObject?
    var offerData:AnyObject?
    var endData:AnyObject?
    
    var candidateData = [NSDictionary]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
  
    func viewType(type: Int) {

        if(type == 0){

            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "LocalVideoCallingScreenDesign", uv: self, contentView: containerView)
            self.containerView.addSubview(cntView)

            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            signalingUrl = userProfileJson.get("WEBRTC_SOCKET_URL")
            Utils.printLog(msgData: "LOCAL CALLLING SOCKET:\(signalingUrl)")
            
            if(webRTCClient == nil){
                webRTCClient = WebRTCClient()
            }
            
            webRTCClient.uv = self
            
            if(isOutGoing == false){
                
                isVideoCall = messageDataDic.get("isVideoCall").uppercased()
            }else{
                isVideoCall = asignedDic.get("isVideoCall").uppercased()
                
                self.playSound(soundPath: Bundle.main.path(forResource: "progress", ofType: "wav")!)
               
            }
            
            self.callingTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING")
            
            callingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.callingAnimation), userInfo: nil, repeats: true)
            
            self.cameraSwipe.image = self.cameraSwipe.image?.addImagePadding(x: 30, y: 30)
            self.soundMute.image = self.soundMute.image?.addImagePadding(x: 30, y: 30)
            self.speakerOnoff.image = self.speakerOnoff.image?.addImagePadding(x: 30, y: 30)
            
            
            cameraManager = CameraManager()
            cameraManager.startCapture()
            
            
            self.ansCallStackView.isHidden = false
            self.previewView.isHidden = false
            
            if(self.isOutGoing){
                self.previewView.borderWidth = 0
                self.ansBtn.isHidden = true
                self.btnStackView.isHidden = false
                self.callingTitleLbl.text = asignedDic.get("Name")
                
                self.setToolKitViews()
                
                if(self.client == nil){
                    
                    self.client = SinchCalling.getInstance().localClient
//                    client.setAuthToken(token: Utils.appUserType + "_" + GeneralFunctions.getMemberd())
//                    client.connect()
                }
        
                self.roomID = asignedDic.get("type") + "_" + asignedDic.get("Id")
                print("room id:\(self.roomID)")
                
                if(self.webRTCClient != nil){
                    self.webRTCClient.delegate = self
                    self.webRTCClient.offer()
                    if(self.webRTCClient.currentCandidate != nil){
                        self.sendCandidateData()
                    }
                }
                
                
                
                
            }else{
                
                self.webRTCClient.delegate = self
                
               // self.prepareLocalMedia()
                self.callingTitleLbl.text = messageDataDic.get("Name")
                self.remoteView.isHidden = true
                self.ansBtn.isHidden = false
                
            }
            
            
            self.ansBtn.handleClick { (instance) in
                
                if(self.audioPlayer != nil){
                    self.audioPlayer!.stop()
                }
                
                self.callingTimer?.invalidate()
                self.callingTimer = nil
                self.startTime = Date().timeIntervalSinceReferenceDate - self.elapsed
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                
                self.ansBtn.isHidden = true
                self.btnStackView.isHidden = false
                self.setToolKitViews()
                
                if let str = self.offerData as? String {
                    let finalData = str.components(separatedBy: "@@")
                    let dict = (finalData[2]).convertToDictionary()
                    let sdp = dict!["description"] as! String
                    self.webRTCClient.handleRemoteDescription(RTCSessionDescription(type: .offer, sdp: sdp))
                }
                
                if(self.isRemoteFrameSet == false){
                  
                    self.speakerOnoff.isHidden = false
                    let currentRoute = AVAudioSession.sharedInstance().currentRoute

                    for output in currentRoute.outputs {

                        switch output.portType {

                        case AVAudioSession.Port.builtInSpeaker:
                            self.speakerImgTapped = true
                            self.speakerTapped(makeOn: true)
                        case AVAudioSession.Port.builtInReceiver:
                            self.speakerImgTapped = true
                            self.speakerTapped(makeOn: true)
                            
                        default:
                            break
                        }
                    }
                    
                    
                    self.view.layoutIfNeeded()
                    
                    if(UIScreen.main.bounds.size.height <= 667){
                        self.localVideoTopSpace.constant = 100
                        self.localVideoBottomSpace.constant = (UIScreen.main.bounds.size.height / 2) + (self.localVideoTopSpace.constant / 2.0)
                    }else{
                        self.localVideoTopSpace.constant = 150
                        self.localVideoBottomSpace.constant = (UIScreen.main.bounds.size.height / 2) + (self.localVideoTopSpace.constant / 1.4)
                    }
                    
                    
                    self.localVideoTrailingSpace.constant = 15
                    self.localVideoLeadingSpace.constant = (UIScreen.main.bounds.size.width / 2) + (self.localVideoTrailingSpace.constant * 3.5)
                    self.previewView.layer.cornerRadius = 6
                    self.previewView.clipsToBounds = true
                    self.previewView.layer.borderWidth = 0.5
                    self.previewView.layer.borderColor = UIColor.white.cgColor
                  
                    UIView.animate(withDuration: 0.3, animations: {
                        self.view.layoutIfNeeded()
                    })
                    
                    if(self.webRTCClient != nil ){
                        try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                    }
                    
                    if(AVAudioSession.sharedInstance().isHeadphonesConnected || AVAudioSession.sharedInstance().isOtherDeviceConnected || self.isVideoCall.uppercased() != "YES"){
                        self.speakerImgTapped = true
                        self.speakerTapped(makeOn: false)
                    }
                    
                    self.btnStackView.isHidden = false
                   
                    self.isRemoteFrameSet = true
                }
                
                
                print("Receive candidate")
                for i in 0..<self.candidateData.count{
                    let candidate = RTCIceCandidate.candidate(from: self.candidateData[i] as! [String : Any])
                    self.webRTCClient.addCandidate(candidate:candidate!)
                }
                
                
            }
            
            self.callRejectBtn.handleClick { (instance) in
                if(self.client != nil && self.roomID != ""){
                    
                    if(self.audioPlayer != nil){
                        self.audioPlayer!.stop()
                    }
                   
                    SinchCalling.getInstance().storeMessageToclientServer(idString:self.roomID, callEnded: "Yes")
                    
                    let oppD = self.isOutGoing == true ? self.roomID : (self.messageDataDic.get("type") + "_" + self.messageDataDic.get("Id"))
                    let str = oppD + "@@" + self.roomID + "@@" + "CallEnd" + "@@" + self.selfDic.toJsonStr()
                    self.client.emit(eventName: "*", data: str as AnyObject)
                }
                
                self.callEndViewSetup()
                
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
                
                self.webRTCClient.localVideoTrack?.isEnabled = false
                self.webRTCClient.remoteVideoTrack?.isEnabled = false
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
                        self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.restaurant_image_url)\(messageDataDic.get("Id"))/\(messageDataDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            
                        })
                    }else{
                        self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(messageDataDic.get("Id"))/\(messageDataDic.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            
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

        }else if(type == 1){
            
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            UIApplication.shared.isIdleTimerDisabled = true
            
    
            setupCamera()

        }else if(type == 2){
            if(isOutGoing == true){
            
                self.playSound(soundPath: Bundle.main.path(forResource: "progress", ofType: "wav")!, "Yes")
            }else{
                var soundPath = ""
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
                
                self.playSound(soundPath: soundPath)
            }
        }else if(type == 3){

            if(cameraManager != nil){
                cameraManager.stopCapture()
            }
            if(self.audioPlayer != nil){
                self.audioPlayer!.stop()
                
            }
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            UIApplication.shared.isIdleTimerDisabled = false

            
            
        }

    }

    var audioPlayer:AVAudioPlayer?
    func playSound(soundPath: String, _ isForOutGoing:String = "")
    {
      
        if(soundPath != ""){
            let coinSound = NSURL(fileURLWithPath: soundPath)
            print(coinSound)
        
            do{
                //            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                //            try AVAudioSession.sharedInstance().setActive(true)
                
                if(isForOutGoing == "Yes"){
                    if #available(iOS 10.0, *) {
                        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
                    }
                    else {
                        AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
                    }
                }else{
                    if #available(iOS 10.0, *) {
                        do{
                            try AVAudioSession.sharedInstance().setCategory(.soloAmbient, mode: .moviePlayback)
                        }catch{
                            print(error)
                        }
                        
                    }
                    else {
                        AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
                    }
                }
                
                
                Utils.printLog(msgData: "AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                  //  try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
                    Utils.printLog(msgData: "AVAudioSession is Active")
                } catch {
                    print(error)
                }
                
                
                audioPlayer = try AVAudioPlayer(contentsOf:coinSound as URL)
                audioPlayer!.volume = 0.1
                audioPlayer!.numberOfLoops = -1
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
                
                
            }catch {
                Utils.printLog(msgData: "Error getting the audio file")
            }
        }
        
    }
    
    func setupCamera() {
        cameraManager.delegate = self
        cameraManager.setupCamera()
        
        self.setupView()
    }
    
    private func setupView() {
        guard let webRTCClient = webRTCClient else {
            
            return
           
        }
        
        #if arch(arm64)
            // Using metal (arm64 only)
            let localRenderer = RTCMTLVideoView(frame: self.previewView.frame)
            let remoteRenderer = RTCMTLVideoView(frame: self.remoteView.frame)
            
        
        #else
            // Using OpenGLES for the rest
            let localRenderer = RTCEAGLVideoView(frame: self.previewView.frame)
            let remoteRenderer = RTCEAGLVideoView(frame: self.remoteView.frame)
        #endif
    
        localRenderer.contentMode = .scaleAspectFill
        remoteRenderer.contentMode = .scaleAspectFill
        
        webRTCClient.setupLocalRenderer(localRenderer)
        webRTCClient.setupRemoteRenderer(remoteRenderer)
        self.previewView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.previewView.addSubview(localRenderer)
        self.remoteView.addSubview(remoteRenderer)
        self.previewView.layer.masksToBounds = true
        self.remoteView.layer.masksToBounds = true
        if let localVideoView = self.previewView {
            self.embedViewForLocal(localRenderer, into: localVideoView)
        }
        self.embedViewForLocal(remoteRenderer, into: remoteView)
        
       
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
            if(self.cameraManager != nil){
                self.cameraManager.switchCamera()
            }
        
        }
        
        self.soundMute.handleClick { (instance) in
            
            if(self.isMuteOn == true){
                
                self.soundMute.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.soundMute, color: UIColor.white)
                
                self.isMuteOn = false
                self.webRTCClient.audioTrack.isEnabled = true
            }else{
                
                self.soundMute.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.soundMute, color: UIColor.black)
                
                self.isMuteOn = true
                self.webRTCClient.audioTrack.isEnabled = false
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
    
    
    
    func listinigEventFor(eventName : String, data : AnyObject?){
        print("Video Socket Recived Data")

        if(self.webRTCClient != nil){
            self.webRTCClient.delegate = self
            
            self.isSocketConnected = true

        }else{
            return
        }
        
        self.eventName = eventName
        self.data = data
        
        
        if let str = data as? String {
            let finalData = str.components(separatedBy: "@@")
            if finalData.contains("CameraSwitched") {
                return
            }
            let dict = (finalData[2]).convertToDictionary()
            
            if(finalData.count > 2){
                let type = dict!["type"] as! String

                if (type == "answer" || type == "ANSWER"){
                    self.ansData = data
                }
                
                if (type == "offer" || type == "OFFER"){
                    
                    self.offerData = data
                    
                }
            }
            
            
            
        }
        if let str = data as? String {
            let finalData = str.components(separatedBy: "@@")
            let dict = (finalData[2]).convertToDictionary()
            if(finalData.count > 2){
                _ = dict!["type"] as! String

                if((finalData[2]) == "CallEnd" && self.webRTCClient != nil){
                    self.endData = data
                }
            }
            
        }
        
        self.handleCallEvent()
    }
    
    func handleCallEvent(){
        if let str = data as? String {
            print("Video Socket Recieved String Data", data!)
            
            let finalData = str.components(separatedBy: "@@")
            if(finalData.count > 2){
                
                if(self.audioPlayer != nil){
                    self.audioPlayer!.stop()
                }
                
                if((finalData[2]) == "CallEnd" && self.webRTCClient != nil){
                    self.callEndViewSetup()
                    return
                }
                
                let dict = (finalData[2]).convertToDictionary()
                let type = dict!["type"] as! String

                if (type == "answer" || type == "ANSWER"){
                    let sdp = dict!["description"] as! String

                    
                    self.webRTCClient.handleRemoteDescription(RTCSessionDescription(type: .answer, sdp: sdp))
                    print("Recevie Answer")
                    
                    if(self.isRemoteFrameSet == false){
                      
                        self.speakerOnoff.isHidden = false
                        let currentRoute = AVAudioSession.sharedInstance().currentRoute

                        for output in currentRoute.outputs {

                            switch output.portType {

                            case AVAudioSession.Port.builtInSpeaker:
                                self.speakerImgTapped = true
                                self.speakerTapped(makeOn: true)
                            case AVAudioSession.Port.builtInReceiver:
                                self.speakerImgTapped = true
                                self.speakerTapped(makeOn: true)
                                
                            default:
                                break
                            }
                        }
                        
                        self.view.layoutIfNeeded()
                        if(UIScreen.main.bounds.size.height <= 667){
                            self.localVideoTopSpace.constant = 100
                            self.localVideoBottomSpace.constant = (UIScreen.main.bounds.size.height / 2) + (self.localVideoTopSpace.constant / 2.0)
                        }else{
                            self.localVideoTopSpace.constant = 150
                            self.localVideoBottomSpace.constant = (UIScreen.main.bounds.size.height / 2) + (self.localVideoTopSpace.constant / 1.4)
                        }
                        
                        self.localVideoTrailingSpace.constant = 15
                        self.localVideoLeadingSpace.constant = (UIScreen.main.bounds.size.width / 2) + (self.localVideoTrailingSpace.constant * 3.5)
                        self.previewView.layer.cornerRadius = 6
                        self.previewView.clipsToBounds = true
                        self.previewView.layer.borderWidth = 0.5
                        self.previewView.layer.borderColor = UIColor.white.cgColor
                      
                        UIView.animate(withDuration: 0.3, animations: {
                            self.view.layoutIfNeeded()
                        })
                        
                        if(self.webRTCClient != nil){
                            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                        }
                        
                        if(AVAudioSession.sharedInstance().isHeadphonesConnected || AVAudioSession.sharedInstance().isOtherDeviceConnected || self.isVideoCall.uppercased() != "YES"){
                            self.speakerImgTapped = true
                            self.speakerTapped(makeOn: false)
                        }
                        
                        self.btnStackView.isHidden = false
                       
                        self.isRemoteFrameSet = true
                    }
                    
                } else if (type == "offer" || type == "OFFER"){
                    let sdp = dict!["description"] as! String
                    print(sdp)
                    print("Recevie Offer")
                   // self.webRTCClient.handleRemoteDescription(RTCSessionDescription(type: .offer, sdp: sdp))
                }else{
                    
                    if(!self.isOutGoing){
                        self.candidateData.append(dict! as NSDictionary)
                    }else{
                        
                        if(self.timer == nil && self.isRemoteFrameSet == true){
                            self.callingTimer?.invalidate()
                            self.callingTimer = nil
                            self.startTime = Date().timeIntervalSinceReferenceDate - self.elapsed
                            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                        }
                        
                         let candidate = RTCIceCandidate.candidate(from: dict!)
                         self.webRTCClient.addCandidate(candidate:candidate!)
                    }
                    
                  //  let candidate = RTCIceCandidate.candidate(from: dict!)
                  //  self.webRTCClient.addCandidate(candidate:candidate!)
                    
                    
                }
            }
        }
    }
    
    
    func speakerTapped(makeOn:Bool){
        
    
        if(makeOn == false){
            self.isSpeakerOn = false
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
        }else{
            self.isSpeakerOn = true
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        }
        
    }
    
    func callEndViewSetup(){
       
        
        if(self.audioPlayer != nil){
            self.audioPlayer!.stop()
        }
        
        self.roomID = ""
        
        if(self.webRTCClient != nil){
          //  cameraManager.stopCapture()
            self.webRTCClient.peerConnection = nil
            self.webRTCClient.isConnected = false            
    
            self.webRTCClient = nil
            
            SinchCalling.getInstance().initWebRTC()
            
            if(self.remoteView != nil){
                for view in self.remoteView.subviews{
                    view.removeFromSuperview()
                }
            }
            
            if(self.previewView != nil){
                for view in self.previewView.subviews{
                    view.removeFromSuperview()
                }
            }
            
        }
        
        if(self.isRemoteFrameSet == true){
            self.localToLarge =  true
            self.localVideoTopSpace.constant = 0
            self.localVideoBottomSpace.constant = 0
            self.localVideoTrailingSpace.constant = 0
            self.localVideoLeadingSpace.constant = 0

        }
        
        self.isRemoteFrameSet = false
        
        callingTimer?.invalidate()
        callingTimer = nil
        timer?.invalidate()
        timer = nil
        
        self.close()
        
        SinchCalling.getInstance().initSinchClient()
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

    @objc func backTapped(){

        callingTimer?.invalidate()
        callingTimer = nil
        timer?.invalidate()
        timer = nil

        if (GeneralFunctions.isKeyExistInUserDefaults(key: "SINCHCALLING") == true && GeneralFunctions.getValue(key: "SINCHCALLING") as! Bool == true){
            GeneralFunctions.saveValue(key: "SINCHCALLING", value: false as AnyObject)
            let window = Application.window
            GeneralFunctions.restartApp(window: window!)
            return
        }
        self.close()
    }

   
    func sendCandidateData(){
        
        if(self.webRTCClient != nil && self.webRTCClient.currentCandidate != nil){
            guard let message = self.webRTCClient.currentCandidate.JSONData() else { return }
           
             print("--candidate Data Sent--")
             
            let oppD = self.isOutGoing == true ? self.roomID : (messageDataDic.get("type") + "_" + messageDataDic.get("Id"))
            let str = oppD + "@@" + self.roomID + "@@" + String(decoding: message, as: UTF8.self) + "@@" + selfDic.toJsonStr()
             self.client.emit(eventName: "*", data: str as AnyObject)
        }
        
    }
    
    //WebRTC Client Delegate
    func webRTCClient(_ client: WebRTCClient, sendData data: Data) {
    
        print("--candidate Data Sent--")
        
        let oppD = self.isOutGoing == true ? self.roomID : (messageDataDic.get("type") + "_" + messageDataDic.get("Id"))
        let str = oppD + "@@" + self.roomID + "@@" + String(decoding: data, as: UTF8.self) + "@@" + selfDic.toJsonStr()
        
        self.client.emit(eventName: "*", data: str as AnyObject)
        
    }

    func captureVideoOutput(sampleBuffer: CMSampleBuffer) {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let rtcpixelBuffer = RTCCVPixelBuffer(pixelBuffer: pixelBuffer)
            let timeStampNs: Int64 = Int64(CMTimeGetSeconds(CMSampleBufferGetPresentationTimeStamp(sampleBuffer)) * 1000000000)
            let videoFrame = RTCVideoFrame(buffer: rtcpixelBuffer, rotation: RTCVideoRotation._0, timeStampNs: timeStampNs)
            
            webRTCClient?.didCaptureLocalFrame(videoFrame)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}


extension UIViewController {
    func embedViewForLocal(_ addingView: UIView, into containerView: UIView) {
        containerView.addSubview(addingView)
        addingView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": addingView]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view": addingView]))
        containerView.layoutIfNeeded()
    }
}


