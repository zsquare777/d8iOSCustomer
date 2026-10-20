

import UIKit
import SysBaseLib

class ConfirmEmergencyTapUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
//    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var topHLbl: MyLabel!
    @IBOutlet weak var bannerImgView: UIImageView!
    @IBOutlet weak var callPoliceView: UIView!
    @IBOutlet weak var callPoliceLbl: MyLabel!
    @IBOutlet weak var sendMsgView: UIView!
    @IBOutlet weak var sendMsgLbl: MyLabel!
    @IBOutlet weak var callImgView: UIImageView!
    @IBOutlet weak var msgImgView: UIImageView!

    @IBOutlet weak var callLeftImgView: UIImageView!
    @IBOutlet weak var msgLeftImgView: UIImageView!

    @IBOutlet weak var OptionsStackView : UIStackView!
    
    let generalFunc = GeneralFunctions()
    
    var iTripId = ""
    
    let sendMsgViewTapGue = UITapGestureRecognizer()
    let callPoliceViewTapGue = UITapGestureRecognizer()
    
    var SITE_POLICE_CONTROL_NUMBER = ""
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "ConfirmEmergencyTapScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
            
//            self.headerView.backgroundColor = .clear
            self.topHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_EME_PAGE_TITLE")
            self.callPoliceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_POLICE")
            self.sendMsgLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_ALERT_EME_CONTACT")
            
            callPoliceViewTapGue.addTarget(self, action: #selector(self.policeViewTapped))
            sendMsgViewTapGue.addTarget(self, action: #selector(self.sendMsgViewTapped))
            
            callPoliceView.isUserInteractionEnabled = true
            sendMsgView.isUserInteractionEnabled = true
            callPoliceView.addGestureRecognizer(callPoliceViewTapGue)
            sendMsgView.addGestureRecognizer(sendMsgViewTapGue)
            
            
            OptionsStackView.cornerRadius = 10
            OptionsStackView.borderColor = UIColor(hex: 0xDDDDDD)
            OptionsStackView.borderWidth = 1
            
            GeneralFunctions.setImgTintColor(imgView: self.callLeftImgView, color: UIColor(hex:0xd3d3d3))
            GeneralFunctions.setImgTintColor(imgView: self.msgLeftImgView, color: UIColor(hex:0xd3d3d3))

            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)

            SITE_POLICE_CONTROL_NUMBER = userProfileJson.get("SITE_POLICE_CONTROL_NUMBER")
            //if userProfileJson.get("HIDE_EMERGENCY_CONTACT").uppercased() == "NO" {
                self.sendMsgView.isHidden = false
            //}else{
                //self.sendMsgView.isHidden = true
           // }
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
            self.navigationController?.navigationBar.layer.zPosition = -1
            
        }else if(type == 3){
            self.navigationController?.navigationBar.layer.zPosition = 1
        }
    }
  
    

    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT")
        
    }
    
    @objc func policeViewTapped(){
        DispatchQueue.main.async {
//            UIApplication.shared.openURL(URL(string:"telprompt:" + self.SITE_POLICE_CONTROL_NUMBER)!)
            
            UIApplication.shared.openURL(NSURL(string: ("telprompt:" + self.SITE_POLICE_CONTROL_NUMBER).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
        }
    }
    
    @objc func sendMsgViewTapped(){
        sendAlertToEmeContacts()
    }
    
    func sendAlertToEmeContacts(){
        let parameters = ["type":"sendAlertToEmergencyContacts","iUserId": GeneralFunctions.getMemberd(), "iTripId": iTripId, "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get(Utils.message_str) == "LBL_ADD_EME_CONTACTS"){
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        let emergencyContactsUv = GeneralFunctions.instantiateViewController(pageName: "EmergencyContactsUV") as! EmergencyContactsUV
                        self.push(uv: emergencyContactsUv)
                    })
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }

}
