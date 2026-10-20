//
//  TrackAnySignupUV.swift
//  UserApp
//
//  Created by Apple on 21/11/22.
//
import UIKit
import SafariServices
import GoogleSignIn
import AuthenticationServices
import Lottie
import Firebase
import SysBaseLib

class TrackAnySignupUV: ParentViewUV, ParentViewUVDelegate, MyTxtFieldClickDelegate, MyBtnClickDelegate,MyTxtFieldOnTextChangeDelegate  {
    
    @IBOutlet weak var phoneHLbl: MyLabel!
    @IBOutlet weak var inviteHLbl: MyLabel!
    @IBOutlet weak var trackImgView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var inviteTxtField: MyTextField!
    @IBOutlet weak var mobTxtField: MyTextField!
    @IBOutlet weak var countryTxtField: MyTextField!
    
    @IBOutlet weak var submitBtn: MyButton!
    
    @IBOutlet weak var userPhoneLbl: MyLabel!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var nPassViewOTPTxtField: UIView!
    @IBOutlet weak var nPassOTPLbl: MyLabel!
    @IBOutlet weak var nPassOTPTxtFiled: MyTextField!
    @IBOutlet weak var nPassErrorLbl: MyLabel!
    @IBOutlet weak var nPassResendOTPLbl: MyLabel!
    @IBOutlet weak var nPassTxtFiled: MyTextField!
    @IBOutlet weak var nPassOTPStackView: OTPStackView!
    @IBOutlet weak var otpSubmitBtn: MyButton!
    @IBOutlet weak var nPassNumberLbl: MyLabel!
    
    
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var successTitleLbl: MyLabel!
    @IBOutlet weak var successSubTitleLbl: MyLabel!
    @IBOutlet weak var successContBtn: MyButton!
    
    @IBOutlet weak var paringCodeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pairingBackBtn: UIImageView!
    @IBOutlet weak var paringCodeVLbl: MyLabel!
    @IBOutlet weak var yourPairingCodeLbl: MyLabel!
    @IBOutlet weak var pairingViewInfoLbl: MyLabel!
    @IBOutlet weak var pairingViewInfoHLbl: MyLabel!
    @IBOutlet weak var pairingView: UIView!
  
    var dataDic = NSDictionary()
    
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var countryListArr:NSArray!
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    var smsVerificationCode = ""
    var nPassMobileNumberWithCountry = ""
    
    var isFirebase = false
    
    var varificationId = ""
    var freqTask_Phone:TaskScheduler!
    
    var isFromListing = false
    
    var userProfileJson:NSDictionary!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            
            cntView = self.generalFunc.loadView(nibName: "TrackAnySignupScreenDesign", uv: self, contentView: contentView)
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            cntView.backgroundColor = UIColor.clear
            self.contentView.addSubview(cntView)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.setData()
            
            EventService.getInstance().buildConnection()
            
        }else if type == 1 {
            self.configRTL()
            
            if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
                Configurations.setDefaultStatusBar()
                self.trackImgView.isHidden = true
                self.pairingView.isHidden = false
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.navigationItem.setHidesBackButton(true, animated: false)
            }else{
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated: false)
                self.addBack()
            }
            
            
        }else if type == 2 {
            //self.inviteTxtField.textPadding = UIEdgeInsets.init(top: 0, left:10, bottom: 0, right:10)
            self.inviteTxtField.addImageView(color: UIColor.darkGray, transform: .identity, isCustomImage: true, "ic_invite_detail") { (imageView) in
                let dialog = MTDialog()
                
                dialog.build(containerViewController: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INVITE_CODE_QUES"), message: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INVITE_CODE_ANS"), positiveBtnTitle: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), negativeBtnTitle: "", action: { (btnClickedIndex) in
                    
                })
                
                dialog.show()
            }
            
            self.countryTxtField.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in

                if(self.countryPrefixImgView == nil){
                    self.countryPrefixImgView = imageView
                    self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                }
              
            }
            
        }else if type == 3 {
           
        }
    }
    
    override func close(){
        
        if(isFromListing){
            self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            return
        }
        if(self.otpView.isHidden == false){
            self.otpView.isHidden = true
            return
        }
        super.close()
    }
    

    func setData(){
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            
            self.pairingViewInfoHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PAIRING_PROCESS_TITLE")
            self.pairingViewInfoLbl.attributedText = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PAIRING_PROCESS_DESC").toHTML(fontName: Fonts().light, fontSize: "14", textColor: "#676767")
            
            self.pairingBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.pairingBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.pairingBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.pairingBackBtn.layer.roundCorners(radius: 25)
            
            self.pairingBackBtn.handleClick { (instance) in
                self.close()
            }
            
            self.generatePairingCode()
        }
        
        
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_SIGNUP_TXT")
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_BUTTON_TXT"))
        self.submitBtn.clickDelegate = self
        self.inviteHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INVITE_CODE_TXT")
        self.phoneHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PHONE_NO_TXT")
        GeneralFunctions.setImgTintColor(imgView: self.trackImgView, color: UIColor.lightGray)
        self.userPhoneLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PHONE_NO_TXT")
        
        self.inviteTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INVITE_CODE_TXT"))
        self.inviteTxtField.onTextChangedDelegate = self
        self.mobTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
        self.mobTxtField.getTextField()!.keyboardType = .numberPad
        self.mobTxtField.onTextChangedDelegate = self
        
        self.countryTxtField.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
        self.countryTxtField.myTxtFieldDelegate = self
        
        
        
        if(self.selectedPhoneCode == ""){
            //self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
                   self.countryTxtField.setEnable(isEnabled: false)
                   self.countryTxtField.onTextChangedDelegate = self
                   if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                       self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                       self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                       
                       self.countryTxtField.setText(text: "+\(self.selectedPhoneCode)")
                       
                       self.isCountrySelected = true
                       self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
            }
        }
        
        CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
            if(isSuccess){
                self.countryListArr = dataArray
            }
        }
    }
    
    func requestVerification(){
        
        let parameters = ["type":"sendAuthOtp", "iMemberId": GeneralFunctions.getMemberd(), "MobileNo": self.mobTxtField.getTextField()!.text!, "vPhoneCode":self.selectedPhoneCode, "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                    self.smsVerificationCode = dataDict.get("message")
                    
                    self.startOTPTimer(dataDict:dataDict)
                    
                }else{
                    self.nPassResendOTPLbl.isUserInteractionEnabled = true
                    self.nPassResendOTPLbl.textColor = SColors.Theme
                    self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
                    self.nPassResendOTPLbl.isHidden = false
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                
                }

                
            }else{
                self.nPassResendOTPLbl.isUserInteractionEnabled = true
                self.nPassResendOTPLbl.textColor = SColors.Theme
                self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
                self.nPassResendOTPLbl.isHidden = false
                
                self.generalFunc.setError(uv: self)
                
            }
        })
    }
    
    func setSuccessView(){
        
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.successView.isHidden = false
        
        self.successTitleLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_SETUP_PROFILE_SUCCESS_TITLE")
        
        self.successSubTitleLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PROFILE_SETUP_USER_SUCCESS_MSG")
        
        self.successContBtn.clickDelegate = self
        self.successContBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_TXT"))
        
    }
    
    func fireBaseConfig(phoneNo : String)  {
        
        var VERIFICATION_CODE_RESEND_TIME_IN_SECONDS = GeneralFunctions.parseInt(origValue: 0, data:GeneralFunctions.getValue(key: "VERIFICATION_CODE_RESEND_TIME_IN_SECONDS") as! String)
        
        self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_OTP_SIGNIN") + " " + self.timeString(time: TimeInterval(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS))
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNo, uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                
                print("errorDDD:\(error)")
                self.nPassResendOTPLbl.isUserInteractionEnabled = true
                self.nPassResendOTPLbl.textColor = SColors.Theme
                self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
                self.nPassResendOTPLbl.isHidden = false
                
                self.generalFunc.setAlertMessage(uv: self, title: "", content:error?.localizedDescription ?? "Firebase Error" , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT") , nagativeBtn: "", completionHandler: { btnClickedId in
                    
                })
                
            
            return
          }
            self.varificationId = verificationID ?? ""
            
            DispatchQueue.main.async {
                self.nPassResendOTPLbl.isHidden = false
        
                let phonefreqTask = TaskScheduler(interval: 1.0)
                phonefreqTask.currInst = phonefreqTask
                self.freqTask_Phone = phonefreqTask
                phonefreqTask.setTaskRunHandler(handler: { (instance) in
                    
                    VERIFICATION_CODE_RESEND_TIME_IN_SECONDS = VERIFICATION_CODE_RESEND_TIME_IN_SECONDS - 1
                    
                    self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_OTP_SIGNIN") + " " + self.timeString(time: TimeInterval(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS))
                    
                    if(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS <= 0){
                        
                        self.nPassResendOTPLbl.isUserInteractionEnabled = true
                        self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_SMS")
                        self.nPassResendOTPLbl.textColor = SColors.Theme
                        
                        instance.stopRepeatingTask()
                    }
                    
                })
                phonefreqTask.startRepeatingTask()
            }
            
        }
    }
    
    
    func setOTPViewData(){
        
        self.otpSubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_VERIFY_TXT"))
        self.otpSubmitBtn.clickDelegate = self
        
        nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.mobTxtField.getTextField()!.text!)"
        
        if(Configurations.isRTLMode()){
            self.nPassNumberLbl.textAlignment = .right
            self.nPassResendOTPLbl.textAlignment = .right
        }else{
            self.nPassNumberLbl.textAlignment = .left
            self.nPassResendOTPLbl.textAlignment = .left
        }
        
       
        self.nPassNumberLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_CODE_SENT_TO_MOBILE_TXT") + " " + self.nPassMobileNumberWithCountry
        self.nPassOTPStackView.delegate = self
        
        if(self.freqTask_Phone != nil){
            self.freqTask_Phone.stopRepeatingTask()
        }
        
        self.freqTask_Phone = nil
        self.nPassResendOTPLbl.text = ""
        self.nPassOTPTxtFiled.setText(text: "")
      
        
        for i in 0..<self.nPassOTPStackView.textFieldsCollection.count{
            self.nPassOTPStackView.textFieldsCollection[i].text = ""
            
        }
        
        self.nPassTxtFiled.isHidden = true
        
        self.nPassResendOTPLbl.handleClick { (instance) in
            self.nPassResendOTPLbl.isUserInteractionEnabled = false
            self.nPassResendOTPLbl.textColor = UIColor(hex: 0xA8A8A8)
            
            if (GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String == "Firebase"){
                self.fireBaseConfig(phoneNo: self.nPassMobileNumberWithCountry)
            }else{
                self.requestVerification()
            }
        }
        
        self.nPassResendOTPLbl.isUserInteractionEnabled = false
        
        
        
        self.otpView.isHidden = false
        
        if (GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String == "Firebase"){
            self.isFirebase = true
        
            self.fireBaseConfig(phoneNo: nPassMobileNumberWithCountry)
            self.nPassOTPTxtFiled.getTextField()!.textAlignment = .center
            self.nPassOTPTxtFiled.getTextField()!.dividerNormalColor = .clear
            self.nPassOTPTxtFiled.getTextField()!.dividerActiveColor = .clear
            self.nPassOTPTxtFiled.getTextField()!.dividerColor = .clear
            self.nPassOTPTxtFiled.getTextField()!.keyboardType = .numberPad
            self.nPassOTPTxtFiled.onTextChangedDelegate = self
            
            
            self.nPassOTPLbl.isHidden = false
            self.nPassOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "Enter OTP", key: "LBL_ENTER_OTP")
            
            self.nPassTxtFiled.isHidden = true
            self.nPassOTPStackView.isHidden = true
            self.nPassViewOTPTxtField.isHidden = false
            self.nPassOTPTxtFiled.isHidden = false
        }else{
            self.nPassViewOTPTxtField.isHidden = true
            self.nPassOTPStackView.isHidden = false
            self.requestVerification()
        }
        
    }
    func validateOTP(){
        let smsCode_str = nPassOTPStackView.getOTP()
        if((smsCode_str == smsVerificationCode && smsVerificationCode != "") || ((GeneralFunctions.getValue(key: Utils.SITE_TYPE_KEY) as! String).uppercased() == "DEMO" && smsCode_str == "1234")){
           
            self.veryfyUserProfile()
           
            
        }else{
            if(smsCode_str == ""){
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_VERIFICATION_CODE"))
            }else{
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VERIFICATION_CODE_INVALID"))
            }
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        
        if sender == self.nPassOTPTxtFiled {
             self.nPassErrorLbl.isHidden = true
        
            if text == ""{
              self.nPassOTPLbl.isHidden = false
            }else{
                self.nPassOTPLbl.isHidden = true
            }
        }
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
     
        if(sender == self.countryTxtField){

             let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
             countryListUv.fromTrackAny = true
             
             if(countryListArr != nil){
                 countryListUv.countryListArr = countryListArr
             }
             
             countryListUv.modalPresentationStyle = .overCurrentContext
             self.present(countryListUv, animated: true) {
             }
        }
       
    }
    
    func startOTPTimer(dataDict:NSDictionary){
        self.nPassResendOTPLbl.isHidden = false
        
        var VERIFICATION_CODE_RESEND_TIME_IN_SECONDS = GeneralFunctions.parseInt(origValue: 0, data:GeneralFunctions.getValue(key: "VERIFICATION_CODE_RESEND_TIME_IN_SECONDS") as! String)
        
        self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_OTP_SIGNIN") + " " + self.timeString(time: TimeInterval(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS))
        
        let phonefreqTask = TaskScheduler(interval: 1.0)
        phonefreqTask.currInst = phonefreqTask
        self.freqTask_Phone = phonefreqTask
        phonefreqTask.setTaskRunHandler(handler: { (instance) in
            
            VERIFICATION_CODE_RESEND_TIME_IN_SECONDS = VERIFICATION_CODE_RESEND_TIME_IN_SECONDS - 1
            
            
            if(dataDict.get("eSMSFailed").uppercased() != "YES"){
                
                self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_OTP_SIGNIN") + " " + self.timeString(time: TimeInterval(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS))
                
            }
            
            if(VERIFICATION_CODE_RESEND_TIME_IN_SECONDS <= 0){
                
                self.nPassResendOTPLbl.isUserInteractionEnabled = true
                self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_SMS")
                self.nPassResendOTPLbl.textColor = SColors.Theme
                
                instance.stopRepeatingTask()
            }
            
        })
        phonefreqTask.startRepeatingTask()
    }
    
    
    func checkOTP(strOtp : String){
        if strOtp == ""{
                self.nPassErrorLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_VERIFICATION_CODE")
                self.nPassErrorLbl.isHidden = false
            
                return
            }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: varificationId ,verificationCode: strOtp)
            Auth.auth().signIn(with: credential) { authData, error in
                if ((error) != nil) {
                    self.nPassErrorLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VERIFICATION_CODE_INVALID")
                        self.nPassErrorLbl.isHidden = false
                            
                    return
               
                }else{
                    self.veryfyUserProfile()
                }
        }
    }
 
    
    func myBtnTapped(sender: MyButton) {
        
        
        if(sender == self.successContBtn){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackingListUV") as! TrackingListUV
            mainScreenUv.isFromTrackingSignup = true
            mainScreenUv.typeDataDic = self.dataDic
            self.push(uv: mainScreenUv)
            return
        }
        
        if(sender == self.otpSubmitBtn){
            if (GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String == "Firebase"){
                self.checkOTP(strOtp: self.nPassOTPTxtFiled.text)
            }else{
                self.validateOTP()
            }
            
            return
        }
        
        
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        let mobileInvalid = self.generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
        let mobileEntered = Utils.checkText(textField: self.mobTxtField.getTextField()!) ? (Utils.getText(textField: self.mobTxtField.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.mobTxtField.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.mobTxtField.getTextField()!, error: required_str)
        
        let inviteCodeEntered = Utils.checkText(textField: self.inviteTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.inviteTxtField.getTextField()!, error: required_str)
        
        if (mobileEntered == false || inviteCodeEntered == false) {
            return;
        }
        
        
        self.setOTPViewData()
        
    }
    
    func timeString(time:TimeInterval) -> String{
        let min = Configurations.convertNumToAppLocal(numStr:String(format:"%02i",Int(time) / 60 % 60))
        let sec = Configurations.convertNumToAppLocal(numStr:String(format:"%02i",Int(time) % 60))
        return "\(min):\(sec)"
    }
    
    
    func generatePairingCode(){
    
        self.paringCodeActivityIndicator.startAnimating()
        let parameters = ["type":"GeneratePairingCode", "iMemberId": GeneralFunctions.getMemberd(), "MemberType": dataDic.get("MemberType")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.paringCodeActivityIndicator.stopAnimating()
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.paringCodeVLbl.text = dataDict.get("message")
                    
                }else{
                    self.nPassResendOTPLbl.isUserInteractionEnabled = true
                    self.nPassResendOTPLbl.textColor = SColors.Theme
                    self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
                    self.nPassResendOTPLbl.isHidden = false
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                
                }

                
            }else{
                self.nPassResendOTPLbl.isUserInteractionEnabled = true
                self.nPassResendOTPLbl.textColor = SColors.Theme
                self.nPassResendOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
                self.nPassResendOTPLbl.isHidden = false
                
                self.generalFunc.setError(uv: self)
                
            }
        })
    }
    
    func veryfyUserProfile(){
        
        let parameters = ["type":"verifyTrackServiceInviteCode", "vInviteCode": self.inviteTxtField.getTextField()!.text!, "MobileNo": self.mobTxtField.getTextField()!.text!, "vPhoneCode":self.selectedPhoneCode, "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                   
                    self.setSuccessView()
                    
                }else{
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT") , nagativeBtn: "", completionHandler: { btnClickedId in
                    })
                    
                }

                
            }else{
                self.generalFunc.setError(uv: self)
                
            }
        })
    }
    
    @IBAction func unwindTrackAnySignUp(_ segue:UIStoryboardSegue) {
           
       if(segue.source .isKind(of: CountryListUV.self)){
           let sourceViewController = segue.source as? CountryListUV
           let selectedPhoneCode:String = sourceViewController!.selectedCountryHolder!.vPhoneCode
           let selectedCountryCode = sourceViewController!.selectedCountryHolder!.vCountryCode
           
           self.selectedCountryCode = selectedCountryCode
           self.selectedPhoneCode = selectedPhoneCode
           self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:sourceViewController!.selectedCountryHolder!.vSImage, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
           
           self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
        
           self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
           
           self.isCountrySelected = true
           self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
           
       }
       
    }
    
}


extension TrackAnySignupUV: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        
    }
}
