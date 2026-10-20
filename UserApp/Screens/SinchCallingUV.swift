

import UIKit
import SysBaseLib

class SinchCallingUV: ParentViewUV, MyLabelClickDelegate, SinchCallingProtocol, ParentViewUVDelegate {
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var videoSpeakerImgView: UIImageView!
    @IBOutlet weak var speakerImgview: UIImageView!
    @IBOutlet weak var muteImgView: UIImageView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var endcallLbl: MyLabel!
    @IBOutlet weak var answerLbl: MyLabel!
    @IBOutlet weak var bottomSatckView: UIStackView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var topcallingLbl: MyLabel!
    
    @IBOutlet weak var profileName: MyLabel!
    
    @IBOutlet weak var videoCallCntView: UIView!
    @IBOutlet weak var videoCallCntTopHeaderView: UIView!
    @IBOutlet weak var remoteVideoView: UIView!
    @IBOutlet weak var localVideoView: UIView!
    @IBOutlet weak var startVideoCallBtnLbl: MyLabel!
    @IBOutlet weak var endVideoCallBtnLbl: MyLabel!
    @IBOutlet weak var videoProfileName: MyLabel!
    @IBOutlet weak var videoCalling: MyLabel!
    @IBOutlet weak var videoMuteImgView: UIImageView!
    @IBOutlet weak var videoSwitchImgView: UIImageView!
    @IBOutlet weak var localVideoTopSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var localVideoTrailingSpace: NSLayoutConstraint!
    
    var mueTapped = false
    var speakerTapped = false
    
    var cntView:UIView!
    
    var isCallReceiving = false
    var assignedData:NSDictionary!
    
    var callingCount = 0
    weak var callingTimer:Timer?
    weak var timer: Timer?
    
    var startTime: Double = 0
    var time: Double = 0
    var elapsed: Double = 0
    var status: Bool = false
    
    var isVideoCall = false
    
    
    let generalFunc = GeneralFunctions()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if(type == 0){
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "SinchCallingScreenDesign", uv: self, contentView: containerView)
            self.containerView.addSubview(cntView)
            
            
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            if (isCallReceiving == false){
                answerLbl.isHidden = true
            }

            SinchCalling.getInstance().delegate = self
            
            self.backBtn.isHidden = true
            self.backBtn.image = backBtn.image?.addImagePadding(x: 20, y: 20)
            let backTappGes = UITapGestureRecognizer()
            backTappGes.addTarget(self, action: #selector(self.backTapped))
            backBtn.isUserInteractionEnabled = true
            self.backBtn.addGestureRecognizer(backTappGes)
            
           
            self.topcallingLbl.text = "Calling"
            self.profileName.text = assignedData.get("Name")
            self.videoProfileName.text = assignedData.get("Name")
            if(assignedData.get("type") == "Company"){
                self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.restaurant_image_url)\(assignedData.get("Id"))/\(assignedData.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
            }else{
                self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(assignedData.get("Id"))/\(assignedData.get("PImage"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
            }
            
            
            
            let muteTappGes = UITapGestureRecognizer()
            muteTappGes.addTarget(self, action: #selector(self.muteTapped))
            muteImgView.isUserInteractionEnabled = true
            self.muteImgView.addGestureRecognizer(muteTappGes)
            
            let muteTappGesV = UITapGestureRecognizer()
            muteTappGesV.addTarget(self, action: #selector(self.muteTapped))
            videoMuteImgView.isUserInteractionEnabled = true
            self.videoMuteImgView.addGestureRecognizer(muteTappGesV)
            
            let speakerTappGes = UITapGestureRecognizer()
            speakerTappGes.addTarget(self, action: #selector(self.speaTapped))
            speakerImgview.isUserInteractionEnabled = true
            self.speakerImgview.addGestureRecognizer(speakerTappGes)
            
            let cameraSwitchTappGes = UITapGestureRecognizer()
            cameraSwitchTappGes.addTarget(self, action: #selector(self.cameraSwitchTapped))
            videoSwitchImgView.isUserInteractionEnabled = true
            self.videoSwitchImgView.addGestureRecognizer(cameraSwitchTappGes)
            
            let speakerVTappGes = UITapGestureRecognizer()
            speakerVTappGes.addTarget(self, action: #selector(self.speaTapped))
            videoSpeakerImgView.isUserInteractionEnabled = true
            self.videoSpeakerImgView.addGestureRecognizer(speakerVTappGes)
            self.videoSpeakerImgView.image = self.videoSpeakerImgView.image?.addImagePadding(x: 30, y: 30)
            
            self.endcallLbl.setClickDelegate(clickDelegate: self)
            self.answerLbl.setClickDelegate(clickDelegate: self)
          
            self.endcallLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_END_CALL")
            self.answerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ANSWER")
            
            self.muteImgView.image = self.muteImgView.image?.addImagePadding(x: 30, y: 30)
            self.speakerImgview.image = self.speakerImgview.image?.addImagePadding(x: 30, y: 30)
            self.videoSwitchImgView.image = self.videoSwitchImgView.image?.addImagePadding(x: 30, y: 30)
            self.videoMuteImgView.image = self.videoMuteImgView.image?.addImagePadding(x: 30, y: 30)
            
            callingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.callingAnimation), userInfo: nil, repeats: true)
           
           
            if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
                SinchCalling.getInstance().sinAudioController.enableSpeaker()
                self.videoSpeakerImgView.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.videoSpeakerImgView, color: UIColor.black)
                speakerTapped = true
            }else{
                self.speakerImgview.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.speakerImgview, color: UIColor.white)
                SinchCalling.getInstance().sinAudioController.disableSpeaker()
                speakerTapped = false
            }
            if isCallReceiving == true{
                self.muteImgView.isHidden = true
                self.speakerImgview.isHidden = true
                self.videoSpeakerImgView.isHidden = true
                self.videoMuteImgView.isHidden = true
                self.videoSwitchImgView.isHidden = true
            }
        }else if(type == 1){
            UIApplication.shared.isIdleTimerDisabled = true
        }else if(type == 2){
            if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
                self.videoCallCntView.isHidden = false
            
                let sinVideoView = SinchCalling.getInstance().client.videoController()
               
                let localRenderView = sinVideoView?.localView()
                localRenderView?.contentMode = .scaleAspectFill
                self.localVideoView.addSubview(localRenderView ?? UIView())
                self.localVideoView.masksToBounds = true
                
                
                self.startVideoCallBtnLbl.isUserInteractionEnabled = true
                self.endVideoCallBtnLbl.isUserInteractionEnabled = true
                self.startVideoCallBtnLbl.setClickDelegate(clickDelegate: self)
                self.endVideoCallBtnLbl.setClickDelegate(clickDelegate: self)
                
                if (isCallReceiving == false){
                    startVideoCallBtnLbl.isHidden = true
                }
            }
        }else if(type == 3){
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            UIApplication.shared.isIdleTimerDisabled = false
        }
        
    }
    
    @objc func cameraSwitchTapped(){
        
        if(SinchCalling.getInstance().client.videoController()?.captureDevicePosition == .back){
            SinchCalling.getInstance().client.videoController()?.captureDevicePosition = .front
            self.videoSwitchImgView.backgroundColor = UIColor.clear
            GeneralFunctions.setImgTintColor(imgView: self.videoSwitchImgView, color: UIColor.white)
        }else{
            SinchCalling.getInstance().client.videoController()?.captureDevicePosition = .back
            self.videoSwitchImgView.backgroundColor = UIColor.white
            GeneralFunctions.setImgTintColor(imgView: self.videoSwitchImgView, color: UIColor.black)
        }
        

    }
    
    @objc func callingAnimation(){
        callingCount = callingCount + 1
        if callingCount == 1{
            self.topcallingLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "."
            self.videoCalling.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "."
        }else if callingCount == 2{
            self.topcallingLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + ".."
            self.videoCalling.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + ".."
        }else if callingCount == 3{
            self.topcallingLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "..."
            self.videoCalling.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING") + "..."
        }else{
            callingCount = 0
            self.topcallingLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING")
            self.videoCalling.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALLING")
        }
        
    }
    
    @objc func backTapped(){
        callingTimer?.invalidate()
        callingTimer = nil
        timer?.invalidate()
        timer = nil
        
        if (GeneralFunctions.isKeyExistInUserDefaults(key: "SINCHCALLING") == true &&  GeneralFunctions.getValue(key: "SINCHCALLING") as! Bool == true){
            GeneralFunctions.saveValue(key: "SINCHCALLING", value: false as AnyObject)
            let window = Application.window
            GeneralFunctions.restartApp(window: window!)
            return
        }
        self.close()
    }
    
    @objc func muteTapped(){
        if  mueTapped == true{
            
            if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
                self.videoMuteImgView.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.videoMuteImgView, color: UIColor.white)
                SinchCalling.getInstance().sinAudioController.unmute()
                mueTapped = false
            }else{
                self.muteImgView.backgroundColor = UIColor.clear
                GeneralFunctions.setImgTintColor(imgView: self.muteImgView, color: UIColor.white)
                SinchCalling.getInstance().sinAudioController.unmute()
                mueTapped = false
            }
            
        }else{
            if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
                self.videoMuteImgView.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.videoMuteImgView, color: UIColor.black)
                SinchCalling.getInstance().sinAudioController.mute()
                mueTapped = true
            }else{
                self.muteImgView.backgroundColor = UIColor.white
                GeneralFunctions.setImgTintColor(imgView: self.muteImgView, color: UIColor.black)
                SinchCalling.getInstance().sinAudioController.mute()
                mueTapped = true
            }
            
        }
        
    }
    
    @objc func speaTapped(){
        
        if  speakerTapped == true{
            self.speakerImgview.backgroundColor = UIColor.clear
            self.videoSpeakerImgView.backgroundColor = UIColor.clear
            GeneralFunctions.setImgTintColor(imgView: self.speakerImgview, color: UIColor.white)
            GeneralFunctions.setImgTintColor(imgView: self.videoSpeakerImgView, color: UIColor.white)
            SinchCalling.getInstance().sinAudioController.disableSpeaker()
            speakerTapped = false
        }else{
            SinchCalling.getInstance().sinAudioController.enableSpeaker()
            self.speakerImgview.backgroundColor = UIColor.white
            self.videoSpeakerImgView.backgroundColor = UIColor.white
            GeneralFunctions.setImgTintColor(imgView: self.speakerImgview, color: UIColor.black)
            GeneralFunctions.setImgTintColor(imgView: self.videoSpeakerImgView, color: UIColor.black)
            speakerTapped = true
        }
    }
    
    func myLableTapped(sender: MyLabel) {
        
        if (answerLbl == sender || startVideoCallBtnLbl == sender){
            if SinchCalling.getInstance().callFromSynch != nil{
                SinchCalling.getInstance().audioPlayer = nil
                SinchCalling.getInstance().callFromSynch.answer()
            }
            callingTimer?.invalidate()
            callingTimer = nil
            startTime = Date().timeIntervalSinceReferenceDate - elapsed
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            self.muteImgView.alpha = 0
            self.speakerImgview.alpha = 0
            self.videoMuteImgView.alpha = 0
            self.videoSwitchImgView.alpha = 0
            self.muteImgView.isHidden = false
            self.speakerImgview.isHidden = false
            self.videoSpeakerImgView.isHidden = false
            self.videoMuteImgView.isHidden = false
            self.videoSwitchImgView.isHidden = false
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.muteImgView.alpha = 1
                            self.speakerImgview.alpha = 1
                            self.videoMuteImgView.alpha = 1
                            self.videoSwitchImgView.alpha = 1
                            self.answerLbl.transform = .init(scaleX: 0.97, y: 0.97)
                            self.startVideoCallBtnLbl.transform = .init(scaleX: 0.97, y: 0.97)
            },  completion: { finished in
                self.answerLbl.transform = .identity
                self.answerLbl.isHidden = true
                self.startVideoCallBtnLbl.isHidden = true
                self.startVideoCallBtnLbl.transform = .identity
                
            })
            
        }else if (endcallLbl == sender || endVideoCallBtnLbl == sender){
            if SinchCalling.getInstance().callFromSynch != nil{
                SinchCalling.getInstance().callFromSynch.hangup()
                SinchCalling.getInstance().audioPlayer = nil
                SinchCalling.getInstance().callFromSynch = nil
                
                if(assignedData.get("type") == "Company"){
                    SinchCalling.getInstance().storeMessageToclientServer(idString:"Company_\(assignedData.get("Id"))", callEnded: "Yes")
                }else{
                    SinchCalling.getInstance().storeMessageToclientServer(idString:"Driver_\(assignedData.get("Id"))", callEnded: "Yes")
                }
                
            }
           
            
            UIView.animate(withDuration: 0.1,
                           animations: {
                            self.endcallLbl.transform = .init(scaleX: 0.97, y: 0.97)
                            self.endVideoCallBtnLbl.transform = .init(scaleX: 0.97, y: 0.97)
            },  completion: { finished in
                self.endcallLbl.transform = .identity
                self.endVideoCallBtnLbl.transform = .identity
                self.backTapped()
            })
            
        }
    }

    
    func callDidEnd() {
        callingTimer?.invalidate()
        callingTimer = nil
        timer?.invalidate()
        timer = nil
        self.topcallingLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_ENDED")
        self.videoCalling.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_ENDED")
        if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
            self.perform(#selector(self.backTapped), with: self, afterDelay:0)
        }else{
            self.perform(#selector(self.backTapped), with: self, afterDelay:2)
        }
    }
    
    func callDidEstablish(){
       
        if timer == nil{
            callingTimer?.invalidate()
            callingTimer = nil
            startTime = Date().timeIntervalSinceReferenceDate - elapsed
            self.updateCounter()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
        
        if mueTapped == true{
            SinchCalling.getInstance().sinAudioController.mute()
        }else{
            SinchCalling.getInstance().sinAudioController.unmute()
        }
        
        if speakerTapped == true{
            SinchCalling.getInstance().sinAudioController.enableSpeaker()
        }else{
            SinchCalling.getInstance().sinAudioController.disableSpeaker()
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
        
        if(self.isVideoCall == true || assignedData.get("isVideoCall").uppercased() == "YES"){
            UIView.transition(with: self.videoCalling,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self?.videoCalling.text = "\(strHours):\(strMinutes):\(strSeconds)"
                                self?.videoCalling.text = Configurations.convertNumToAppLocal(numStr: (self?.videoCalling.text!)!)
                }, completion: nil)
        }else{
            UIView.transition(with: self.topcallingLbl,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self?.topcallingLbl.text = "\(strHours):\(strMinutes):\(strSeconds)"
                                self?.topcallingLbl.text = Configurations.convertNumToAppLocal(numStr: (self?.topcallingLbl.text!)!)
                }, completion: nil)
        }
        
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func clientDidStart() {
        
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
    func embedView(_ addingView: UIView, into containerView: UIView) {
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
