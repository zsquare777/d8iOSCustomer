

import UIKit
import SysBaseLib

class ForgetPasswordUV: ParentViewUV, MyLabelClickDelegate, UITextFieldDelegate ,  MyTxtFieldOnTextChangeDelegate , MyTxtFieldClickDelegate, ParentViewUVDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lockImgView: UIImageView!
    @IBOutlet weak var forgetPasswordHLbl: MyLabel!
    @IBOutlet weak var forgetPassSubLbl: MyLabel!
    @IBOutlet weak var emailTxtField: MyTextField!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitImgView: UIImageView!
    @IBOutlet weak var submitViewLbl: MyLabel!
    @IBOutlet weak var signInLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var countryTxtField: MyTextField!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var isEmail = false
    
    var countryListArr:NSArray!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "ForgetPasswordScreenDesign", uv: self, contentView: scrollView)
         
            self.scrollView.addSubview(cntView)
            
            self.addBack()
            
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_PASS_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_PASS_TXT")
            
            self.forgetPasswordHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_YOUR_PASS_TXT")
            self.forgetPasswordHLbl.textColor = UIColor(hex: 0x010101)
            self.forgetPassSubLbl.textColor = UIColor(hex: 0x646464)
            if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
               self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PHONE_EMAIL"))
            }else{
                self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))
            }
           
            self.forgetPassSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "We just need your registered Email Id to sent you password reset instruction.", key: "LBL_FORGET_PASS_NOTE")
            self.forgetPassSubLbl.fit()
            self.emailTxtField.getTextField()!.keyboardType = .emailAddress
            
            self.submitView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: self.submitImgView, color: SColors.ThemeTxt)
            self.submitViewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_TXT").uppercased()
            self.submitViewLbl.textColor = SColors.ThemeTxt
            
            self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
            self.countryTxtField.setEnable(isEnabled: false)
            self.countryTxtField.onTextChangedDelegate = self
            
              if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                  self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                  self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                  
                  self.countryTxtField.setText(text: "+\(self.selectedPhoneCode)")
                  
                  self.isCountrySelected = true
                  self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
              }
            
            if(Configurations.isRTLMode()){
                self.submitImgView.image = self.submitImgView.image?.rotate(180)
                 GeneralFunctions.setImgTintColor(imgView: self.submitImgView, color: SColors.ThemeTxt)
            }
            self.submitView.handleClick { (instance) in
                self.checkData()
            }
            
            self.cancelImgView.handleClick { (instance) in
                self.close()
            }
            
            self.checkEmailOptional()
            
        }else if(type == 1){
            
            CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
                if(isSuccess){
                    self.countryListArr = dataArray
                }
            }
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            self.navigationController?.navigationBar.isHidden = true
           
            self.configRTL()
            
            
            
        }else if(type == 2){
            
            
            
            let height = self.forgetPassSubLbl.text!.height(withConstrainedWidth: cntView.frame.width, font: UIFont.init(name: Fonts().light, size: 13)!)
            
            cntView.frame.size = CGSize(width: cntView.frame.width, height: (height - 20) + 510)
            self.scrollView.bounces = false
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: (height - 20) + 510)
            
            self.emailTxtField.getTextField()!.delegate = self
            self.emailTxtField.onTextChangedDelegate = self
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
               countryTxtField.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
               self.countryTxtField.myTxtFieldDelegate = self
           }
                       
           self.countryTxtField.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in
               
               if(self.countryPrefixImgView == nil){
                   self.countryPrefixImgView = imageView
                   self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
               }
             
           }
            
        }else if(type == 3){
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    func checkEmailOptional(){
        let isEmailOptional =  GeneralFunctions.getValue(key: Utils.ENABLE_EMAIL_OPTIONAL)?.uppercased
        
        if (isEmailOptional == "YES") {
            self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
            self.countryTxtField.isHidden = false
            self.signInLeadingSpace.constant = 125
            self.forgetPassSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_PASS_NOTE_PHONE")
            self.emailTxtField.getTextField()!.keyboardType = .numberPad
        }else{
            self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))
            self.countryTxtField.isHidden = true
            self.emailTxtField.getTextField()!.keyboardType = .emailAddress
            self.forgetPassSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_PASS_NOTE")
        }
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
        if(sender == self.countryTxtField){
           
            let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
            countryListUv.fromForgetPassword = true
            
            if(countryListArr != nil){
                countryListUv.countryListArr = countryListArr
            }
            countryListUv.modalPresentationStyle = .overCurrentContext
            self.present(countryListUv, animated: true) {
            }
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        if(emailTxtField == sender){
//            self.userNameTxtFieldHelperLbl.isHidden = false

            let isEmailOptional =  GeneralFunctions.getValue(key: Utils.ENABLE_EMAIL_OPTIONAL)?.uppercased
            
            if (isEmailOptional != "YES") {
                if(text.count > 3){
                     if(text.isNumeric()){

                        self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))

                         view.layoutIfNeeded()
                         self.signInLeadingSpace.constant = 125

                         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                           self.view.layoutIfNeeded()
                         }, completion: { finished in
                           self.countryTxtField.isHidden = false
                         })


                     }else{
                        self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))

                         self.countryTxtField.isHidden = true
                         view.layoutIfNeeded()
                         self.signInLeadingSpace.constant = 20

                         UIView.animate(withDuration: 0.3, animations: {
                              self.view.layoutIfNeeded()
                         })
                     }
                 }else{
                    self.emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PHONE_EMAIL"))

                     self.countryTxtField.isHidden = true
                     view.layoutIfNeeded()
                     self.signInLeadingSpace.constant = 20

                     UIView.animate(withDuration: 0.3, animations: {
                          self.view.layoutIfNeeded()
                     })
                 }
            }
        }
    }
    
    func myLableTapped(sender: MyLabel) {

    }
    
    func checkData(){
        
        self.view.endEditing(true)
        
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
        
        var emailEntered = false
        
        if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
            emailEntered = Utils.checkText(textField: self.emailTxtField.getTextField()!) ? (Utils.getText(textField: self.emailTxtField.getTextField()!).isNumeric() ? (Utils.getText(textField: self.emailTxtField.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: mobileInvalid)) : (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtField.getTextField()!)) ? true :  Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR")) )) : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: required_str)
        }else{
            emailEntered = Utils.checkText(textField: self.emailTxtField.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtField.getTextField()!)) ? true : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: required_str)
        }
        
        isEmail = GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtField.getTextField()!))
        
        if(emailEntered){
            requestResetPassword()
        }
    }
    
    
    func requestResetPassword(){
    
        var parameters = ["type":"requestResetPassword","vEmail": Utils.getText(textField: self.emailTxtField.getTextField()!), "UserType": Utils.appUserType]
        
        if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
            parameters["isEmail"] = isEmail ? "Yes" : "No"
            if !isEmail{
                parameters["CountryCode"] = self.selectedCountryCode
                parameters["PhoneCode"] = self.selectedPhoneCode
            }
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.emailTxtField.setText(text: "")
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.close()
                    })
                    
                    return
                }
                
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))

                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    @IBAction func unwindToForgetPassword(_ segue:UIStoryboardSegue) {
        if(segue.source .isKind(of: CountryListUV.self)){
            let sourceViewController = segue.source as? CountryListUV
            let selectedPhoneCode:String = sourceViewController!.selectedCountryHolder!.vPhoneCode
            let selectedCountryCode = sourceViewController!.selectedCountryHolder!.vCountryCode
            
            self.selectedCountryCode = selectedCountryCode
            self.selectedPhoneCode = selectedPhoneCode
            self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:sourceViewController!.selectedCountryHolder!.vSImage, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
            
            self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
            
            self.isCountrySelected = true
            self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
            
        }
    }
    
    //MARK:- TextfieldDelegate Method
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.isStatusBarHidden = false
    }

}
