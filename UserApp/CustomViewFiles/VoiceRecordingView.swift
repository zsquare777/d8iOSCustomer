
import UIKit
import AVFoundation

protocol VoiceRecordingDelegate {
    
    func getVoiceRecording(file:Data, isSuccess:Bool)
    func cancelRecording()
  
}

class VoiceRecordingView: UIView, AVAudioRecorderDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var recordDurationLbl: MyLabel!
    @IBOutlet weak var tapAndHoldHLbl: MyLabel!
    @IBOutlet weak var tapAndHoldSHLbl: MyLabel!
     
    @IBOutlet weak var clearImgView: UIImageView!
    @IBOutlet weak var playerHolderView: UIView!
    @IBOutlet weak var releaseLbl: MyLabel!
    @IBOutlet weak var microphoneCenter: NSLayoutConstraint!
    @IBOutlet weak var recordViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var playerView: UIView!
    
    @IBOutlet weak var addVoiceSHLbl: MyLabel!
    @IBOutlet weak var addVoiceLbl: MyLabel!
     
    var longgesture:UILongPressGestureRecognizer!
     
    var seconds = 0
    var timer:Timer!
    
    var voiceRecordingDelegate:VoiceRecordingDelegate?
    
    var audioRecorder : AVAudioRecorder?
    
    let generalFunc = GeneralFunctions()
    
    var view: UIView!
    
    var audioPlayer:XQAudioPlayer!
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        //        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        recordDurationLbl.text = Configurations.convertNumToAppLocal(numStr: "00:00")
         
         let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
         lpgr.minimumPressDuration = 0.5
         lpgr.delaysTouchesBegan = true
         lpgr.delegate = self
         recordView.addGestureRecognizer(lpgr)
         

         // getting URL path for audio
         let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
         let docDir = dirPath[0]
         let soundFilePath = (docDir as NSString).appendingPathComponent("sound.wav")
         let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
         print(soundFilePath)

         //Setting for recorder
         let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey : 2,
             AVSampleRateKey: 44100.0] as [String : Any] as [String : Any] as [String : Any] as [String : Any]
         var error : NSError?
         let audioSession = AVAudioSession.sharedInstance()
        
         do {
            if #available(iOS 11.0, *) {
                try? audioSession.setCategory(.playAndRecord, mode: .default, policy: .default, options: .defaultToSpeaker)
            } else {
                try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            }
             audioRecorder = try AVAudioRecorder(url: soundFileURL as URL, settings: recordSettings as [String : AnyObject])
             audioRecorder?.delegate = self
         } catch _ {
             print("Error")
         }

         if let err = error {
             print("audioSession error: \(err.localizedDescription)")
         }else{
             audioRecorder?.prepareToRecord()
         }
         
         
         self.addVoiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VOICE_DIRECTIONS")
         self.addVoiceSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VOICE_DETAILS")
         
         self.tapAndHoldHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TAP_HOLD_RECORD")
         self.tapAndHoldSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_KEEP_RECORDING_TIME")
         self.releaseLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RELASE_TO_SAVE")
         
         clearImgView.image = UIImage(named: "ic_deleteRecording")?.addImagePadding(x: 5, y: 5)
         
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         self.clearImgView.isUserInteractionEnabled = true
         self.clearImgView.addGestureRecognizer(tap)
        
        self.recordView.backgroundColor = SColors.Theme
        self.tapAndHoldHLbl.textColor = SColors.Theme
        if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S){
          //recordDurationLbl.font = UIFont(name: Fonts().semibold, size: 18)!
        }
        //recordDurationLbl.font = UIFont(name: Fonts().semibold, size: 13)!
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state == UIGestureRecognizer.State.began {
            
           
            self.playerView.isHidden = true
            
            //When lognpress is start or running
            if(timer != nil){
                timer.invalidate()
                timer = nil
            }
            seconds = 0
            recordDurationLbl.text = Configurations.convertNumToAppLocal(numStr: "00:00")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            
            self.startRecording()
            
            
            UIView.animate(withDuration: 1.0, animations: {
            
                let fadeTransition = CATransition()
                fadeTransition.duration = 0.05

                CATransaction.begin()
                CATransaction.setCompletionBlock({
                    
                    self.tapAndHoldHLbl.layer.add(fadeTransition, forKey: kCATransition)
                    self.tapAndHoldSHLbl.layer.add(fadeTransition, forKey: kCATransition)
                })

                self.tapAndHoldHLbl.isHidden = true
                self.tapAndHoldSHLbl.isHidden = true
                self.tapAndHoldHLbl.text = ""
                self.tapAndHoldSHLbl.text = ""
                self.tapAndHoldHLbl.layer.add(fadeTransition, forKey: kCATransition)
                self.tapAndHoldSHLbl.layer.add(fadeTransition, forKey: kCATransition)

                self.recordViewLeadingSpace.constant = 0
                
                self.microphoneCenter.constant = -(self.frame.width / 2) + 40
                
                self.releaseLbl.isHidden = false
                
                self.recordDurationLbl.isHidden = false
                CATransaction.commit()
                
                
            }, completion: {
                (value: Bool) in
            })
            
        }
        else if gestureReconizer.state == UIGestureRecognizer.State.ended {
            //When lognpress is finish
            
            timer.invalidate()
            timer = nil
            self.stopRecording()
            
            
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        self.audioPlayer.audioPlayer.pause()
        self.recordView.isHidden = false
        self.playerView.isHidden = true
        
        self.tapAndHoldHLbl.isHidden = false
        self.tapAndHoldSHLbl.isHidden = false
        
        self.voiceRecordingDelegate?.cancelRecording()
    }
    
    @objc func updateTimer() {
        seconds += 1
        recordDurationLbl.text = Configurations.convertNumToAppLocal(numStr: timeString(time: TimeInterval(seconds)))
    }
    
    @objc func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
      
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
    func startRecording(){
        if audioRecorder?.isRecording == false{
            
            audioRecorder?.record()
        }
    }
    
    func stopRecording(){
        
        if audioRecorder?.isRecording == true{
            audioRecorder?.stop()
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if let theVoiceUrl = audioRecorder?.url {
            do {
                let voiceData = try Data(contentsOf: theVoiceUrl as URL)
                self.voiceRecordingDelegate?.getVoiceRecording(file: voiceData, isSuccess: true)
            } catch {
                self.voiceRecordingDelegate?.getVoiceRecording(file: Data(), isSuccess: false)
            }
        }
        
        
        let url = audioRecorder!.url
        audioPlayer = XQAudioPlayer.init(frame: CGRect(x: 0, y: 0, width: self.playerHolderView.frame.size.width, height: self.playerHolderView.frame.size.height), urlString: url.absoluteString)
        
        self.playerHolderView.addSubview(audioPlayer)
        
        recordDurationLbl.text = Configurations.convertNumToAppLocal(numStr: "00:00")
        
        UIView.animate(withDuration: 1.0, animations: {
        
            let fadeTransition = CATransition()
            fadeTransition.duration = 0.05

            CATransaction.begin()
            CATransaction.setCompletionBlock({
                
                self.playerView.layer.add(fadeTransition, forKey: kCATransition)
                self.recordView.layer.add(fadeTransition, forKey: kCATransition)
            })

            self.tapAndHoldHLbl.isHidden = true
            self.tapAndHoldSHLbl.isHidden = true
            self.tapAndHoldHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TAP_HOLD_RECORD")
            self.tapAndHoldSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_KEEP_RECORDING_TIME")
            
            self.recordViewLeadingSpace.constant = 10
            
            self.microphoneCenter.constant = 0
            self.recordDurationLbl.isHidden = true
            self.releaseLbl.isHidden = true
            
            self.recordView.isHidden = true
            self.playerView.isHidden = false
            
            CATransaction.commit()
            
            
        }, completion: {
            (value: Bool) in
        })
        
        
    }

    private func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "VoiceRecordingView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
