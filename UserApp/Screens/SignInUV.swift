

import UIKit
import SafariServices
import GoogleSignIn
import AuthenticationServices
import Lottie
import Firebase
import SysBaseLib

class SignInUV: ParentViewUV, MyLabelClickDelegate, MyTxtFieldOnTextChangeDelegate , MyTxtFieldClickDelegate, ParentViewUVDelegate, MyBtnClickDelegate{
    
    
    
    @IBOutlet weak var socialLoginStkView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signInWithSocial: MyLabel!
    @IBOutlet weak var googleImgView: UIImageView!
    @IBOutlet weak var appleIdImgView: UIImageView!
    @IBOutlet weak var fbImgView: UIImageView!
    @IBOutlet weak var linkdinImgView: UIImageView!
    @IBOutlet weak var goSignUpLbl: MyLabel!
    @IBOutlet weak var forgetPasswordLbl: MyLabel!
    @IBOutlet weak var signInImgHLbl: MyLabel!
    @IBOutlet weak var passwordTxtField: MyTextField!
    @IBOutlet weak var userNameTxtField: MyTextField!
    @IBOutlet weak var orLblContainer: UIView!
    @IBOutlet weak var orLbl: MyLabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userNameTxtFieldHelperLbl: MyLabel!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitImgView: UIImageView!
    @IBOutlet weak var submitViewLbl: MyLabel!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var orrightView: UIView!
    @IBOutlet weak var orLeftView: UIView!
    @IBOutlet weak var signInHImg: UIImageView!
    @IBOutlet weak var signInLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var countryTxtField: MyTextField!
    
    
    @IBOutlet weak var termsConditionLbl: MyLabel!
    
    @IBOutlet weak var submitBtnTopSpace: NSLayoutConstraint!
    @IBOutlet weak var quickLoginInfoImgView: UIImageView!
    @IBOutlet weak var quickLoginView: UIView!
    @IBOutlet weak var quickLoginTitleLbl: MyLabel!
    @IBOutlet weak var quickLoginCheckImgView: UIImageView!
    
    @IBOutlet weak var donHaveAccountTopSpace: NSLayoutConstraint!
    @IBOutlet weak var quickLoginBtnImgView: UIImageView!
    @IBOutlet weak var newMainView: UIView!
    @IBOutlet weak var nBackBtn: UIImageView!
    @IBOutlet weak var enterMNumberLbl: MyLabel!
    @IBOutlet weak var nSmartLoginLbl: MyLabel!
    
    
    @IBOutlet weak var nMailInfoOptionalLbl: MyLabel!
    @IBOutlet weak var nMailInfoBackBtn: UIImageView!
    @IBOutlet weak var nMailInfoTxtField: MyTextField!
    @IBOutlet weak var nMailInfoTitleLbl: MyLabel!
    @IBOutlet weak var nMailInfoView: UIView!
    @IBOutlet weak var nUserInfoBackBtn: UIImageView!
    @IBOutlet weak var nUserInfoLNameTxtField: MyTextField!
    @IBOutlet weak var nUserInfoFirstNTxtField: MyTextField!
    @IBOutlet weak var nUserInfoTitleLbl: MyLabel!
    @IBOutlet weak var nUserInfoView: UIView!
    @IBOutlet weak var nForgotPassLbl: MyLabel!
    @IBOutlet weak var nPassTxtFiled: MyTextField!
    @IBOutlet weak var nPassResendOTPLbl: MyLabel!
    @IBOutlet weak var nPassErrorLbl: MyLabel!
    @IBOutlet weak var nPassOTPTxtFiled: MyTextField!
    @IBOutlet weak var nPassOTPLbl: MyLabel!
    @IBOutlet weak var nPassViewOTPTxtField: UIView!
    @IBOutlet weak var nPassBackBtn: UIImageView!
    @IBOutlet weak var nPassNumberLbl: MyLabel!
    @IBOutlet weak var nPassOTPStackView: OTPStackView!
    @IBOutlet weak var nPassViewTitleLbl: MyLabel!
    @IBOutlet weak var nPassOtpView: UIView!
    @IBOutlet weak var nMobileTxtFiled: MyTextField!
    @IBOutlet weak var nCountryTxtFiled: MyTextField!
    
    @IBOutlet weak var bottomInfoTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var bottomInfoImgView: UIImageView!
    @IBOutlet weak var bottomInfoImgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomInfoTitlelbl: MyLabel!
    @IBOutlet weak var bottomInfoSubmitBtn: MyButton!
    @IBOutlet weak var bottomInfoDecLbl: MyLabel!
    
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    
    
    var isFromAppLogin = true
    
    let generalFunc = GeneralFunctions()
    
    var required_str = ""
    
    var openFbLogin: OpenFbLogin!
    var openGoogleLogin: OpenGoogleLogin!
    var openLinkdinLogin: OpenLinkedinLogin!
    
    var chackOutUV:CheckOutUV!
    
    var cntView:UIView!
    
//    var isViewProperShutDown = false
    var PAGE_HEIGHT:CGFloat = 730
    
    var isPageSet = false
    
    var finalStr:NSMutableAttributedString!
    
    var userProfileJson:NSDictionary!
    var countryListArr:NSArray!
    
    var openListView:OpenListView!
    var isOpenForPass = false
    var isOpenForEmail = false
    var isOpenForRegi = false
    var isOpenForReffereal = false
    var isFirebase = false
    var varificationId = ""
    var freqTask_Phone:TaskScheduler!
    var smsVerificationCode = ""
    
    var nPassMobileNumberWithCountry = ""
    var nPassMobileNumberOnly = ""
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var nPassTxt = ""
    var nFirstName = ""
    var nLastName = ""
    var nMail = ""
    var isUserRegistered = ""
    var finalStrTerms:NSMutableAttributedString!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            Configurations.setAppThemeNavBar()
    //        self.contentView.addSubview(self.generalFunc.loadView(nibName: "SignInScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            cntView = self.generalFunc.loadView(nibName: "SignInScreenDesign", uv: self, contentView: scrollView)
            
            //        cntView.frame = CGRect(x:0, y:0, width: self.contentView.frame.width, height: PAGE_HEIGHT)
            scrollView.addSubview(cntView)
            
            self.bottomInfoTopSpace.constant = 0
            self.bottomInfoView.isHidden = true
            if(self.isOpenForPass){
                self.newMainView.isHidden = true
            }
            
            /// Quick Login
            self.setSmartLogin()
            
            
            
            scrollView.bounces = false
            scrollView.backgroundColor = UIColor.clear
            
            let facebookLoginEnabled = GeneralFunctions.getValue(key: Utils.FACEBOOK_LOGIN_KEY)
            let googleLoginEnabled = GeneralFunctions.getValue(key: Utils.GOOGLE_LOGIN_KEY)
            let appleLoginEnabled = GeneralFunctions.getValue(key: Utils.APPLE_LOGIN_KEY)
            let linkdinLoginEnabled = GeneralFunctions.getValue(key: Utils.LINKDIN_LOGIN_KEY)
            let smartLoginEnable = GeneralFunctions.getValue(key: Utils.SMART_LOGIN)
            
            
            var isFBLoginEnabled = false
            var isGoogleLoginEnabled = false
            var isAppleLoginEnabled = false
            var isLinkdinLoginEnabled = false
            if(facebookLoginEnabled != nil && (facebookLoginEnabled as! String).uppercased() == "NO"){
                isFBLoginEnabled = false
                self.fbImgView.isHidden = true
            }else{
                isFBLoginEnabled = true
            }
            
            if(googleLoginEnabled != nil && (googleLoginEnabled as! String).uppercased() == "NO"){
                isGoogleLoginEnabled = false
                self.googleImgView.isHidden = true
            }else{
                isGoogleLoginEnabled = true
            }
            
           if(appleLoginEnabled != nil && (appleLoginEnabled as! String).uppercased() == "NO"){
                isAppleLoginEnabled = false
                self.appleIdImgView.isHidden = true
            }else{
                isAppleLoginEnabled = true
            }
            
            if(linkdinLoginEnabled != nil && (linkdinLoginEnabled as! String).uppercased() == "NO"){
                isLinkdinLoginEnabled = false
                self.linkdinImgView.isHidden = true
            }else{
                isLinkdinLoginEnabled = true
            }
            
            if(isFBLoginEnabled == false && isGoogleLoginEnabled == false && isAppleLoginEnabled == false && isLinkdinLoginEnabled == false){
                for i in 0..<socialLoginStkView.subviews.count{
                    let subView = socialLoginStkView.subviews[i]
                    
                    self.signInWithSocial.isHidden = true
                    self.orLbl.isHidden = true
                    self.orrightView.isHidden = true
                    self.orLeftView.isHidden = true
                    subView.isHidden = true
                }
                
                
                self.PAGE_HEIGHT = self.PAGE_HEIGHT - 180
            }

            self.contentView.alpha = 0
            setData()
            
        
            self.nSmartLoginLbl.handleClick { (instance) in
                
                self.view.endEditing(true)
                self.openListView = OpenListView(uv: nil, containerView: self.view)
                self.openListView.openNewList = true
                self.openListView.isForSocialAccount = true
                
                var arrayObject = [String]()
                var issmartLogin = false
            
               // if((appleLoginEnabled != nil) == true){
                if isAppleLoginEnabled {
                    arrayObject.append("apple")
                }
                //if((googleLoginEnabled != nil) == true){
                if isGoogleLoginEnabled{
                    arrayObject.append("google")
                }
                //if((facebookLoginEnabled != nil) == true){
                if isFBLoginEnabled{
                    arrayObject.append("fb")
                }
                if isLinkdinLoginEnabled {
                    arrayObject.append("linkedin")
                }
                //if((linkdinLoginEnabled != nil) == true){
                   // arrayObject.append("linkedin")
               // }
                if (smartLoginEnable as! String).uppercased() == "YES" {
               if(GeneralFunctions.isDeviceAuthenticationEnableForQuickLogin() == true && GeneralFunctions.isQuickLogInEnable()){
                //if(GeneralFunctions.isQuickLogInEnable()){
                    arrayObject.append("smartid")
                    issmartLogin = false
                }else{
                    arrayObject.append("smartid")
                    issmartLogin = true
                }
                }
                
                
                
                self.openListView = OpenListView(uv: nil, containerView: self.view)
                self.openListView.signInUV = self
                self.openListView.isForSocialAccount = true
                self.openListView.isSocialLoginDisable = issmartLogin
                self.openListView.openNewList = true
                self.openListView.show(listObjects:arrayObject, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_ACCOUNT"), currentInst: self.openListView, handler: { (selectedItemId) in
                    
                    if arrayObject[selectedItemId] == "smartid" {
                        GeneralFunctions.performQuickLoginWithUV(uv:self)
                    }else if arrayObject[selectedItemId] == "apple" {
                        self.appleBtnTapped()
                    }else if arrayObject[selectedItemId] == "fb"{
                        self.fbBtnTapped()
                    }else if arrayObject[selectedItemId] == "google"{
                        self.googleBtnTapped()
                    }else if arrayObject[selectedItemId] == "linkedin"{
                        self.linkdinBtnTapped()
                    }
                })
                
            }
            
            //self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.height)
            
        }else if(type == 1){
            
            CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
                if(isSuccess){
                    self.countryListArr = dataArray
                }
            }
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            self.navigationController?.navigationBar.isHidden = true
            
            self.configRTL()
            UIView.animate(withDuration: 0.15, animations: {
                self.contentView.alpha = 1.0
            })
            
            
            self.nSmartLoginLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONNECT_WITH_SOCIAL_ACCOUNTS")
            self.nSmartLoginLbl.textColor = SColors.Theme
            
            self.nSmartLoginLbl.addImage(originalText: Configurations.isRTLMode() ? " \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONNECT_WITH_SOCIAL_ACCOUNTS"))" : "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONNECT_WITH_SOCIAL_ACCOUNTS")) ", image: UIImage(named: "ic_btn_rightarrow")!.resize(toWidth: 20)!.resize(toHeight: 20)!, color: SColors.Theme, position:  Configurations.isRTLMode() ? .left : .right)
            

            if(Configurations.isRTLMode()){
                self.nSmartLoginLbl.textAlignment = .right
            }else{
                self.nSmartLoginLbl.textAlignment = .left
            }
            
            if((GeneralFunctions.getValue(key: "isOtherSignInOptionsAvailable") as! String).uppercased() == "NO"){
                self.nSmartLoginLbl.isHidden = true
            }
           
            
            self.setSignInPageData()
            
            
        }else if(type == 2){
            if(isPageSet == false){
                
//                if(PAGE_HEIGHT < self.cntView.frame.height){
//                    self.PAGE_HEIGHT = self.cntView.frame.height
//                }
                self.cntView.frame.size.height = self.view.frame.height
                self.scrollView.frame.size.height = self.view.frame.height
    
                //self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.size.height)
                
                isPageSet = true
                
                if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
                    countryTxtField.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
                    self.countryTxtField.myTxtFieldDelegate = self
                    
                    nCountryTxtFiled.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
                    self.nCountryTxtFiled.myTxtFieldDelegate = self
                }
                
                self.nCountryTxtFiled.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in
                    
                    if(self.countryPrefixImgView == nil){
                        self.countryPrefixImgView = imageView
                        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                    }
                  
                }
                self.nPassTxtFiled.addImageView(color: UIColor.gray, transform: .identity, isCustomImage: true, "ic_show_password") { (imageView) in
                    
                    if(self.nPassTxtFiled.getTextField()!.isSecureTextEntry == true){
                        imageView.image = UIImage(named: "ic_show_hide_pass")
                        GeneralFunctions.setImgTintColor(imgView: imageView, color: UIColor.gray)
                        self.nPassTxtFiled.getTextField()!.isSecureTextEntry = false
                    }else{
                        imageView.image = UIImage(named: "ic_show_password")
                        GeneralFunctions.setImgTintColor(imgView: imageView, color: UIColor.gray)
                        self.nPassTxtFiled.getTextField()!.isSecureTextEntry = true
                    }
                }
                
                if(self.selectedPhoneCode == ""){
                    self.nCountryTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: ""))
                           self.nCountryTxtFiled.setEnable(isEnabled: false)
                           self.nCountryTxtFiled.onTextChangedDelegate = self
                           if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                               self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                               self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                               
                               self.nCountryTxtFiled.setText(text: "+\(self.selectedPhoneCode)")
                               
                               self.isCountrySelected = true
                               self.nCountryTxtFiled.getTextField()!.sendActions(for: .editingChanged)
                    }
                }
                
                
                self.countryTxtField.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in
                    
                    if(self.countryPrefixImgView == nil){
                        self.countryPrefixImgView = imageView
                        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                    }
                  
                }
                
                self.passwordTxtField.addImageView(color: UIColor.gray, transform: .identity, isCustomImage: true, "ic_show_password") { (imageView) in
                    
                    if(self.passwordTxtField.getTextField()!.isSecureTextEntry == true){
                        imageView.image = UIImage(named: "ic_show_hide_pass")
                        GeneralFunctions.setImgTintColor(imgView: imageView, color: UIColor.gray)
                        self.passwordTxtField.getTextField()!.isSecureTextEntry = false
                    }else{
                        imageView.image = UIImage(named: "ic_show_password")
                        GeneralFunctions.setImgTintColor(imgView: imageView, color: UIColor.gray)
                        self.passwordTxtField.getTextField()!.isSecureTextEntry = true
                    }
                }
                
                if(self.isOpenForReffereal){
                    self.nMailInfoTxtField.addImageView(color: SColors.Theme, transform: .identity, isCustomImage: true, "ic_invite_detail") { (imageView) in
                        
                        self.view.endEditing(true)
                        self.bottomInfoView.isHidden = false
                        
                        self.view.layoutIfNeeded()
                        self.bottomInfoTopSpace.constant = 0
                        self.bottomInfoImgViewHeight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                        self.bottomInfoImgView.image = UIImage(named:"invite")
                        self.bottomInfoTitlelbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REFERAL_SCHEME_TXT")
                        self.bottomInfoDecLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REFERAL_SCHEME")
                        self.bottomInfoSubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"))
                        self.bottomInfoSubmitBtn.clickDelegate = self
                        
                        UIView.animate(withDuration: 0.3, animations: {
                             self.view.layoutIfNeeded()
                        })
                        
                       
                    }
                }
                
                self.setSignInNextPageBtn()

            }
            
            /// Quick Login
            self.setSmartLogin()
            if(GeneralFunctions.isDeviceAuthenticationEnableForQuickLogin()){
                self.quickLoginView.isHidden = false
                
                
                self.quickLoginTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN")
                GeneralFunctions.setImgTintColor(imgView: self.quickLoginBtnImgView, color: SColors.Theme)
                
                self.quickLoginView.handleClick { (instance) in
                  
                    if(GeneralFunctions.isQuickLogInEnable()){
                        self.quickLoginCheckImgView.image = nil
                        self.quickLoginCheckImgView.borderWidth = 2
                        GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: false as AnyObject)
                        
                        self.quickLoginBtnImgView.isHidden = true
                        self.donHaveAccountTopSpace.constant = 30
                        
                        
                    }else{
                        self.quickLoginCheckImgView.borderWidth = 0
                        self.quickLoginCheckImgView.image = UIImage(named:"ic_right")
                        GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: true as AnyObject)
                        
                        if(GeneralFunctions.isQuickLogInEnable() && (GeneralFunctions.isKeyExistInUserDefaults(key: "QUICK_LOGIN_DIC") == true && (GeneralFunctions.getValue(key: "QUICK_LOGIN_DIC") as! NSDictionary).count > 0)){
                            
                            // QUick Login
                            self.quickLoginBtnImgView.handleClick { (instance) in
                                
                                self.quickLoginBtnImgView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                                
                                GeneralFunctions.performQuickLoginWithUV(uv:self)
                                
                            }
                            
                            self.donHaveAccountTopSpace.constant = 120
                            self.quickLoginBtnImgView.isHidden = false
                        }else{
                            self.quickLoginBtnImgView.isHidden = true
                            self.donHaveAccountTopSpace.constant = 30
                        }
                        
                    }
                }
                
                self.quickLoginInfoImgView.handleClick { (instance) in
                    
                    let dialog = MTDialog()
                    
                    dialog.build(containerViewController: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN"), message: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN_INFO"), positiveBtnTitle: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), negativeBtnTitle: "", action: { (btnClickedIndex) in
                        
                    })
                    
                    dialog.show()
                
                }
                
            }else{
                
                self.donHaveAccountTopSpace.constant = 30
                self.quickLoginBtnImgView.isHidden = true
                self.quickLoginView.isHidden = true
            } ///
        }else if(type == 3){
            self.navigationController?.navigationBar.isHidden = false
        }
    }
   
   
    func setSignInNextPageBtn(){
        
        if(self.isOpenForPass){
            
            let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() == true ? 30 : Application.screenSize.width - 100, y: newMainView.height - 50 - GeneralFunctions.getSafeAreaInsets().bottom - 35, width: 70, height: 70))
            imageView.image = UIImage(named: "ic_arrow_right")?.addImagePadding(x: 35, y: 35)
            if(Configurations.isRTLMode()){
                imageView.image = imageView.image?.rotate(180)
            }
            Utils.createRoundedView(view: imageView, borderColor: .clear, borderWidth: 0)
            imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
            imageView.backgroundColor = SColors.Theme
            self.nPassOtpView.addSubview(imageView)
            
            imageView.handleClick { (instance) in
                if((GeneralFunctions.getValue(key: "SIGN_IN_OPTION") as! String).uppercased() != "OTP"){
                    
                    let noWhiteSpace = self.generalFunc.getLanguageLabel(origValue: "Password should not contain whitespace.", key: "LBL_ERROR_NO_SPACE_IN_PASS");
                    let pass_length = self.generalFunc.getLanguageLabel(origValue: "Password must be", key: "LBL_ERROR_PASS_LENGTH_PREFIX")
                        + " \(Utils.minPasswordLength)" + " " + self.generalFunc.getLanguageLabel(origValue: "or more character long.",key: "LBL_ERROR_PASS_LENGTH_SUFFIX");
                    let passwordEntered = Utils.checkText(textField: self.nPassTxtFiled.getTextField()!) ? (Utils.getText(textField: self.nPassTxtFiled.getTextField()!).contains(" ") ? Utils.setErrorFields(textField: self.nPassTxtFiled.getTextField()!, error: noWhiteSpace) : (Utils.getText(textField: self.nPassTxtFiled.getTextField()!).count >= Utils.minPasswordLength ? true : Utils.setErrorFields(textField: self.nPassTxtFiled.getTextField()!, error: pass_length))) : Utils.setErrorFields(textField: self.nPassTxtFiled.getTextField()!, error: self.required_str)
                   
                    if (passwordEntered == false) {
                        return;
                    }
                    
                    self.verifyOTPVerification()
                    
                }else{
                    if (GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String == "Firebase"){
                        self.checkOTP(strOtp: self.nPassOTPTxtFiled.text)
                    }else{
                        self.validateOTP()
                    }
                    
                }
                
            }
            
        }else if(self.isOpenForRegi){
            let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() == true ? 30 : Application.screenSize.width - 100, y: newMainView.height - 50 - GeneralFunctions.getSafeAreaInsets().bottom - 35, width: 70, height: 70))
            imageView.image = UIImage(named: "ic_arrow_right")?.addImagePadding(x: 35, y: 35)
            if(Configurations.isRTLMode()){
                imageView.image = imageView.image?.rotate(180)
            }
            Utils.createRoundedView(view: imageView, borderColor: .clear, borderWidth: 0)
            imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
            imageView.backgroundColor = SColors.Theme
            self.nUserInfoView.addSubview(imageView)
            
            imageView.handleClick { (instance) in
                let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                let fNameEntered = Utils.checkText(textField: self.nUserInfoFirstNTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.nUserInfoFirstNTxtField.getTextField()!, error: required_str)
                let lNameEntered = Utils.checkText(textField: self.nUserInfoLNameTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.nUserInfoLNameTxtField.getTextField()!, error: required_str)
                
                if (fNameEntered == false || lNameEntered == false) {
                    return;
                }
                
                
                let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
                uv.isOpenForEmail = true
                uv.nFirstName = Utils.getText(textField: self.nUserInfoFirstNTxtField.getTextField()!)
                uv.nLastName = Utils.getText(textField: self.nUserInfoLNameTxtField.getTextField()!)
                uv.nPassTxt = self.nPassTxt
                uv.nPassMobileNumberOnly = self.nPassMobileNumberOnly
                uv.selectedPhoneCode = self.selectedPhoneCode
                uv.selectedCountryCode = self.selectedCountryCode
                uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
                self.push(uv: uv)
            }
            
        }else if(self.isOpenForEmail){
            
            let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() == true ? 30 : Application.screenSize.width - 100, y: newMainView.height - 50 - GeneralFunctions.getSafeAreaInsets().bottom - 35, width: 70, height: 70))
            imageView.image = UIImage(named: "ic_arrow_right")?.addImagePadding(x: 35, y: 35)
            if(Configurations.isRTLMode()){
                imageView.image = imageView.image?.rotate(180)
            }
            Utils.createRoundedView(view: imageView, borderColor: .clear, borderWidth: 0)
            imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
            imageView.backgroundColor = SColors.Theme
            self.nMailInfoView.addSubview(imageView)
            
            imageView.handleClick { (instance) in
                
                
                
                
                
                if GeneralFunctions.getValue(key: Utils.ENABLE_EMAIL_OPTIONAL)?.uppercased != "YES" {
               let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
               let emailValidEntered =   Utils.checkText(textField: self.nMailInfoTxtField.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)) ? true : Utils.setErrorFields(textField: self.nMailInfoTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : Utils.setErrorFields(textField: self.nMailInfoTxtField.getTextField()!, error: required_str)
               
               
               if (emailValidEntered == false ) {
                   return;
               }
                }
                let tempStr = self.nMailInfoTxtField.text
                if  !tempStr.isBlank {
                let checkValidEmail = (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)))
                if checkValidEmail == false {
                    
                    _ = Utils.setErrorFields(textField: self.nMailInfoTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))
                    return
                }
                }
                self.nMail = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
                self.checkUserEmail()
//                if(GeneralFunctions.getValue(key: Utils.REFERRAL_SCHEME_ENABLE) != nil && (GeneralFunctions.getValue(key: Utils.REFERRAL_SCHEME_ENABLE) as! String).uppercased() != "YES" ){
//                    self.nMail = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
//                    self.registerUser()
//                }else{
//                    let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
//                    uv.isOpenForReffereal = true
//                    uv.nMail = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
//                    uv.nFirstName = self.nFirstName
//                    uv.nLastName = self.nLastName
//                    uv.nPassTxt = self.nPassTxt
//                    uv.nPassMobileNumberOnly = self.nPassMobileNumberOnly
//                    uv.selectedPhoneCode = self.selectedPhoneCode
//                    uv.selectedCountryCode = self.selectedCountryCode
//                    uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
//                    self.push(uv: uv)
//                }
                
            }
            
        }else if(self.isOpenForReffereal){
            
            let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() == true ? 30 : Application.screenSize.width - 100, y: newMainView.height - 50 - GeneralFunctions.getSafeAreaInsets().bottom - 35, width: 70, height: 70))
            imageView.image = UIImage(named: "ic_arrow_right")?.addImagePadding(x: 35, y: 35)
            if(Configurations.isRTLMode()){
                imageView.image = imageView.image?.rotate(180)
            }
            imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
            Utils.createRoundedView(view: imageView, borderColor: .clear, borderWidth: 0)
            imageView.backgroundColor = SColors.Theme
            self.nMailInfoView.addSubview(imageView)
            
            imageView.handleClick { (instance) in
                self.registerUser()
                
            }
            
            
            
        }else{
            
            let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() == true ? 30 : Application.screenSize.width - 100, y: newMainView.height - 50 - GeneralFunctions.getSafeAreaInsets().bottom - 35, width: 70, height: 70))
            imageView.image = UIImage(named: "ic_arrow_right")?.addImagePadding(x: 35, y: 35)
            if(Configurations.isRTLMode()){
                imageView.image = imageView.image?.rotate(180)
            }
            Utils.createRoundedView(view: imageView, borderColor: .clear, borderWidth: 0)
            imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
            imageView.backgroundColor = SColors.Theme
            self.newMainView.addSubview(imageView)
            
            imageView.handleClick { (instance) in
                
                let mobileInvalid = self.generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
                let mobileEntered = Utils.checkText(textField: self.nMobileTxtFiled.getTextField()!) ? (Utils.getText(textField: self.nMobileTxtFiled.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.nMobileTxtFiled.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.nMobileTxtFiled.getTextField()!, error: self.required_str)
                
                if (mobileEntered == false) {
                    return;
                }
                
                if((GeneralFunctions.getValue(key: "SIGN_IN_OPTION") as! String).uppercased() == "OTP"){
                    let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
                    uv.isOpenForPass = true
                    uv.nPassMobileNumberOnly = self.nMobileTxtFiled.getTextField()!.text!
                    uv.selectedPhoneCode = self.selectedPhoneCode
                    uv.selectedCountryCode = self.selectedCountryCode
                    uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
                    self.push(uv: uv)
                }else{
                    self.checkUserRegistered()
                }
            }
        }
        
    }
    
    func setSignInPageData(){
        if(self.isOpenForPass){
            
            self.nMailInfoView.isHidden = true
            self.nUserInfoView.isHidden = true
            
            if(Configurations.isRTLMode()){
                self.nPassViewTitleLbl.textAlignment = .right
            }else{
                self.nPassViewTitleLbl.textAlignment = .left
            }
            
            if((GeneralFunctions.getValue(key: "SIGN_IN_OPTION") as! String).uppercased() == "OTP"){
                
        
                if(Configurations.isRTLMode()){
                    self.nPassNumberLbl.textAlignment = .right
                    self.nPassResendOTPLbl.textAlignment = .right
                }else{
                    self.nPassNumberLbl.textAlignment = .left
                    self.nPassResendOTPLbl.textAlignment = .left
                }
                
                self.nPassViewTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTP_SENT_TITLE")
                self.nPassNumberLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_CODE_SENT_TO_MOBILE_TXT") + " " + self.nPassMobileNumberWithCountry
                self.nPassOTPStackView.delegate = self
                
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
                
                print(GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String)
                if (GeneralFunctions.getValue(key: "MOBILE_NO_VERIFICATION_METHOD") as! String == "Firebase"){
                    self.isFirebase = true
                
                    self.fireBaseConfig(phoneNo: self.nPassMobileNumberWithCountry)
                    self.nPassOTPTxtFiled.getTextField()!.textAlignment = .center
                    self.nPassOTPTxtFiled.defaultTextAlignment = .center
                    self.nPassOTPTxtFiled.getTextField()!.dividerNormalColor = .clear
                    self.nPassOTPTxtFiled.getTextField()!.dividerActiveColor = .clear
                    self.nPassOTPTxtFiled.getTextField()!.dividerColor = .clear
                    self.nPassOTPTxtFiled.getTextField()!.keyboardType = .numberPad
                    self.nPassOTPTxtFiled.onTextChangedDelegate = self
                    
                    if(Utils.getText(textField: self.nPassOTPTxtFiled.getTextField()!) != ""){
                        self.nPassOTPLbl.isHidden = true
                        self.nPassErrorLbl.isHidden = true
                    }else{
                        self.nPassOTPLbl.isHidden = false
                        self.nPassOTPLbl.text = self.generalFunc.getLanguageLabel(origValue: "Enter OTP", key: "LBL_ENTER_OTP")
                    }
                    
                    self.nPassTxtFiled.isHidden = true
                    self.nPassOTPStackView.isHidden = true
                    self.nPassViewOTPTxtField.isHidden = false
                    self.nPassOTPTxtFiled.isHidden = false
                }else{
                    self.nPassViewOTPTxtField.isHidden = true
                    self.nPassOTPStackView.isHidden = false
                    self.requestVerification()
                }
                
            }else{
                
                if(Configurations.isRTLMode()){
                    self.nForgotPassLbl.textAlignment = .right
                }else{
                    self.nForgotPassLbl.textAlignment = .left
                }
                
                
                self.nPassOTPStackView.isHidden = true
                self.nPassNumberLbl.isHidden = true
                self.nPassTxtFiled.isHidden = false
                self.nForgotPassLbl.isHidden = false
                self.nForgotPassLbl.textColor = SColors.Theme
                self.nForgotPassLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_YOUR_PASS_TXT")
                
                self.nForgotPassLbl.handleClick { (insatnce) in
                    let forgetPasswordUV = GeneralFunctions.instantiateViewController(pageName: "ForgetPasswordUV") as! ForgetPasswordUV
                    self.push(uv: forgetPasswordUV)
                }
                
                self.nPassViewTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PASSWORD_TITLE")
                self.nPassTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PASSWORD_LBL_TXT"))
                self.nPassTxtFiled.getTextField()!.isSecureTextEntry = true
                
                if(self.isUserRegistered.uppercased() == "YES"){
                    self.nForgotPassLbl.isHidden = true
                    self.nPassViewTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CREATE_PASSWORD_TXT")
                }
            }
            
            self.nPassBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.nPassBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.nPassBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.nPassBackBtn.layer.roundCorners(radius: 25)
            
            self.nPassBackBtn.handleClick { (instance) in
                self.close()
            }
            
            
            
        }else if(self.isOpenForRegi){
            
            self.nMailInfoView.isHidden = true
            self.newMainView.isHidden = true
            self.nPassOTPStackView.isHidden = true
            self.nUserInfoView.isHidden = false
            
            if(Configurations.isRTLMode()){
                self.nUserInfoTitleLbl.textAlignment = .right
            }else{
                self.nUserInfoTitleLbl.textAlignment = .left
            }
            
            self.nUserInfoFirstNTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIRST_NAME_HEADER_TXT"))
            self.nUserInfoLNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LAST_NAME_HEADER_TXT"))
            self.nUserInfoTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WHAT_YOUR_NAME")
            
            self.nUserInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.nUserInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.nUserInfoBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.nUserInfoBackBtn.layer.roundCorners(radius: 25)
            
            self.nUserInfoBackBtn.handleClick { (instance) in
                self.close()
            }
            
        }else if(self.isOpenForEmail){
            
            self.nUserInfoView.isHidden = true
            self.nPassOtpView.isHidden = true
            self.nMailInfoView.isHidden = false
            self.newMainView.isHidden = true
            
            if(Configurations.isRTLMode()){
                self.nMailInfoTitleLbl.textAlignment = .right
                self.nMailInfoOptionalLbl.textAlignment = .right
            }else{
                self.nMailInfoTitleLbl.textAlignment = .left
                self.nMailInfoOptionalLbl.textAlignment = .left
            }
            
            self.nMailInfoTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_TITLE")
            if GeneralFunctions.getValue(key: Utils.ENABLE_EMAIL_OPTIONAL)?.uppercased != "YES" {
                self.nMailInfoOptionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "")
            }else{
                self.nMailInfoOptionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONAL")
            }
            //self.nMailInfoOptionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONAL")
            self.nMailInfoTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))
            self.nMailInfoTxtField.getTextField()!.keyboardType = .emailAddress
            
            self.nMailInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.nMailInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.nMailInfoBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.nMailInfoBackBtn.layer.roundCorners(radius: 25)
            
            self.nMailInfoBackBtn.handleClick { (instance) in
                self.close()
            }
            
        }else if(self.isOpenForReffereal){
            
            self.nUserInfoView.isHidden = true
            self.nPassOtpView.isHidden = true
            self.nMailInfoView.isHidden = false
            self.newMainView.isHidden = true
            
            if(Configurations.isRTLMode()){
                self.nMailInfoTitleLbl.textAlignment = .right
                self.nMailInfoOptionalLbl.textAlignment = .right
            }else{
                self.nMailInfoTitleLbl.textAlignment = .left
                self.nMailInfoOptionalLbl.textAlignment = .left
            }
            
            self.nMailInfoTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HAVE_REFFERAL_CODE")
            self.nMailInfoOptionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONAL")
            self.nMailInfoTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REFERRAL_CODE_HINT"))
            self.nMailInfoTxtField.getTextField()!.keyboardType = .emailAddress
            
            self.nMailInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.nMailInfoBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.nMailInfoBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.nMailInfoBackBtn.layer.roundCorners(radius: 25)
            
            self.nMailInfoBackBtn.handleClick { (instance) in
                self.close()
            }
        
            
        }else{
            
            
            let APPSTORE_MODE_IOS = GeneralFunctions.getValue(key: Utils.APPSTORE_MODE_IOS_KEY)
            if(APPSTORE_MODE_IOS != nil && (APPSTORE_MODE_IOS as! String).uppercased() == "REVIEW"){
                 _ = UIView()
    //            skipContainerView.backgroundColor = UIColor.blue
                let skipLabel = MyLabel(frame: CGRect(x: 20, y: (Application.screenSize.height - 65) - GeneralFunctions.getSafeAreaInsets().bottom, width: 200, height: 40))

                skipLabel.text = "Skip Login"
                
                //skipLabel.textAlignment = .center
                skipLabel.fontFamilyWeight = "Bold"
                skipLabel.font = UIFont(name: Fonts().bold, size: 17)!
                skipLabel.textColor = UIColor(hex: 0x272727)
                skipLabel.backgroundColor = UIColor(hex: 0xFFFFFF)
              
                
                skipLabel.layer.cornerRadius = 8
                skipLabel.layer.masksToBounds = true
                self.view.addSubview(skipLabel)
              
                
                skipLabel.setClickHandler { (instance) in
                    self.skipLoginInfo()
                }
            }
            
            
            
            if(Configurations.isRTLMode()){
                self.enterMNumberLbl.textAlignment = .right
            }else{
                self.enterMNumberLbl.textAlignment = .left
            }
            
            self.nMailInfoView.isHidden = true
            self.nUserInfoView.isHidden = true
            self.nPassOtpView.isHidden = true
            
            self.enterMNumberLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_MOBILE_NO")
            self.nCountryTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: ""))
            self.nMobileTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
            self.nMobileTxtFiled.getTextField()!.keyboardType = .numberPad
            
           
            finalStrTerms = NSMutableAttributedString.init(string: "")
            finalStrTerms.append(self.getAttributedString(str:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION_PREFIX_TXT"),color:SColors.tfPlaceholderInActive))
            finalStrTerms.append(self.getAttributedString(str: " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION_PRIVACY"),color:SColors.Theme))
          
            
            self.termsConditionLbl.attributedText = finalStrTerms
            self.termsConditionLbl.isUserInteractionEnabled = true
            self.termsConditionLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabelTerms(gesture:))))
            self.termsConditionLbl.fit()
            self.nBackBtn.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.nBackBtn.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.nBackBtn.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.nBackBtn.layer.roundCorners(radius: 25)
            
            self.nBackBtn.handleClick { (instance) in
                self.close()
            }
        }
    }
    
    func checkUserRegistered(){
        
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        
        let parameters = ["type":"CheckMemberAccount", "MobileNo": self.nMobileTxtFiled.getTextField()!.text!, "vPhoneCode": self.selectedPhoneCode, "vDeviceType": Utils.deviceType, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
                    uv.isOpenForPass = true
                    uv.isUserRegistered = dataDict.get("showEnterPassword")
                    uv.nPassMobileNumberOnly = self.nMobileTxtFiled.getTextField()!.text!
                    uv.selectedPhoneCode = self.selectedPhoneCode
                    uv.selectedCountryCode = self.selectedCountryCode
                    uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
                    self.push(uv: uv)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    
    func setSmartLogin(){
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "isSmartLoginEnable") == true && GeneralFunctions.isKeyExistInUserDefaults(key: "isSmartLoginEnable") == true && (GeneralFunctions.getValue(key: "isSmartLoginEnable") as! String).uppercased() != "YES"){
            
            self.PAGE_HEIGHT = 675
            self.submitBtnTopSpace.constant = 40
            self.quickLoginView.isHidden = true
            self.quickLoginCheckImgView.image = nil
            self.quickLoginCheckImgView.borderWidth = 2
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: false as AnyObject)
            
            self.donHaveAccountTopSpace.constant = 30
            self.quickLoginBtnImgView.isHidden = true
            return
        }
        
        if(GeneralFunctions.isQuickLogInEnable() && (GeneralFunctions.isKeyExistInUserDefaults(key: "QUICK_LOGIN_DIC") == true && (GeneralFunctions.getValue(key: "QUICK_LOGIN_DIC") as! NSDictionary).count > 0)){
            self.quickLoginCheckImgView.borderWidth = 0
            self.quickLoginCheckImgView.image = UIImage(named:"ic_right")
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: true as AnyObject)
            
            
            self.donHaveAccountTopSpace.constant = 120
            self.quickLoginBtnImgView.isHidden = false
            // QUick Login
            self.quickLoginBtnImgView.handleClick { (instance) in
                
                self.quickLoginBtnImgView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
                GeneralFunctions.performQuickLoginWithUV(uv:self)
                
            }
            
        }else{
            self.quickLoginCheckImgView.image = nil
            self.quickLoginCheckImgView.borderWidth = 2
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: false as AnyObject)
            
            self.donHaveAccountTopSpace.constant = 30
            self.quickLoginBtnImgView.isHidden = true
        }
    }
    
    func setData(){
        required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        self.orLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OR_TXT")
//        LBL_PHONE_EMAIL
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "SignIn", key: "LBL_HEADER_TOPBAR_SIGN_IN_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "SignIn", key: "LBL_HEADER_TOPBAR_SIGN_IN_TXT")
        self.signInImgHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Sign In", key: "LBL_HEADER_TOPBAR_SIGN_IN_TXT")
        
        self.userNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "PHONE NUMBER OR EMAIL", key: "LBL_PHONE_EMAIL"))
        self.passwordTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PASSWORD_LBL_TXT"))
       
        
        self.forgetPasswordLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FORGET_YOUR_PASS_TXT")
        
        self.forgetPasswordLbl.textColor = UIColor(hex: 0x646464)//SColors.Theme
        self.forgetPasswordLbl.setClickDelegate(clickDelegate: self)
        
//        self.orLblContainer.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi) / 2)
//        self.orLbl.transform = CGAffineTransform(rotationAngle: -CGFloat(CGFloat.pi) / 2)
        
        self.goSignUpLbl.setClickDelegate(clickDelegate: self)
        
//        self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
//               self.countryTxtField.setEnable(isEnabled: false)
//               self.countryTxtField.onTextChangedDelegate = self
//               if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
//                   self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
//                   self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
//                   
//                   self.countryTxtField.setText(text: "+\(self.selectedPhoneCode)")
//                   
//                   self.isCountrySelected = true
//                   self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
//               }
//        
        
        self.userNameTxtField.getTextField()!.keyboardType = .emailAddress
        self.passwordTxtField.getTextField()!.isSecureTextEntry = true
        
        fbImgView.isUserInteractionEnabled = true
        googleImgView.isUserInteractionEnabled = true
        appleIdImgView.isUserInteractionEnabled = true
        linkdinImgView.isUserInteractionEnabled = true
        
        let fbImgTapGue = UITapGestureRecognizer()
        let googleImgTapGue = UITapGestureRecognizer()
        let appleImgTapGue = UITapGestureRecognizer()
        let linkdinImgTapGue = UITapGestureRecognizer()
        
        fbImgTapGue.addTarget(self, action: #selector(self.fbBtnTapped))
        googleImgTapGue.addTarget(self, action: #selector(self.googleBtnTapped))
        appleImgTapGue.addTarget(self, action: #selector(self.appleBtnTapped))
        linkdinImgTapGue.addTarget(self, action: #selector(self.linkdinBtnTapped))
        
        fbImgView.addGestureRecognizer(fbImgTapGue)
        googleImgView.addGestureRecognizer(googleImgTapGue)
        appleIdImgView.addGestureRecognizer(appleImgTapGue)
        linkdinImgView.addGestureRecognizer(linkdinImgTapGue)
        
        signInWithSocial.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGN_IN_WITH_SOC_ACC_HINT")
        
        finalStr = NSMutableAttributedString.init(string: "")
        finalStr.append(self.getAttributedString(str:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALREADY_HAVE_ACC"),color:UIColor.black))
        finalStr.append(self.getAttributedString(str: " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGNUP"),color:SColors.Theme))
        finalStr.append(self.getAttributedString(str: " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOW"),color:UIColor.black))
        
        self.goSignUpLbl.attributedText = finalStr
        self.goSignUpLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        self.userNameTxtFieldHelperLbl.text = self.generalFunc.getLanguageLabel(origValue: "Enter without leading + or 00 or country code", key: "LBL_SIGN_IN_MOBILE_EMAIL_HELPER")
        
        let helperTxtHeight = self.userNameTxtFieldHelperLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont(name: Fonts().light, size: 14)!)
        if(helperTxtHeight > 0){
            PAGE_HEIGHT = PAGE_HEIGHT + helperTxtHeight
        }
        
        self.userNameTxtField.onTextChangedDelegate = self
        
        self.submitView.backgroundColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: self.submitImgView, color: SColors.ThemeTxt)
        self.submitViewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGN_IN").uppercased()
        self.submitViewLbl.textColor = SColors.ThemeTxt
        
        GeneralFunctions.setImgTintColor(imgView: self.signInHImg, color: SColors.Theme)
        
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
        
       // self.cancelImgView.image = self.cancelImgView.image?.addImagePadding(x: 5, y: 5)
    }
    
    func registerUser(){
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        var inviteCode = ""
        if(self.isOpenForReffereal){
            inviteCode = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
        }
        let parameters = ["type":"signup","vFirstName": self.nFirstName, "vLastName": self.nLastName, "vEmail": self.nMail, "vPhone": self.nPassMobileNumberOnly, "vPassword":self.nPassTxt, "PhoneCode": self.selectedPhoneCode, "CountryCode": self.selectedCountryCode, "vDeviceType": Utils.deviceType, "vInviteCode": inviteCode, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: true)
                    
                   // let userProfileJsonDict = (response.toDict().dictOf(Utils.message_str))
                    if(ServiceModule.isDeliverAllOnly())
                    {
                        GeneralFunctions.saveValue(key: "LOGED_IN_DELIVERALL", value: true as AnyObject)
                        _ = OpenMainProfile(uv: self, userProfileJson: response, checkOutUV:self.chackOutUV)

                        GeneralFunctions.restartApp(window: Application.window!)

                    }else
                    {
                        let window = UIApplication.shared.delegate!.window!
                        _ = OpenMainProfile(uv: self, userProfileJson: response, window: window!)
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
           if(sender == self.countryTxtField){

                let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
                countryListUv.fromLogIn = true
                
                if(countryListArr != nil){
                    countryListUv.countryListArr = countryListArr
                }
                
                countryListUv.modalPresentationStyle = .overCurrentContext
                self.present(countryListUv, animated: true) {
                }
           }
        
        if(sender == self.nCountryTxtFiled){

             let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
             countryListUv.fromLogIn = true
             
             if(countryListArr != nil){
                 countryListUv.countryListArr = countryListArr
             }
             
             countryListUv.modalPresentationStyle = .overCurrentContext
             self.present(countryListUv, animated: true) {
             }
        }
        
        
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        
        let termsRange = (self.finalStr.string as NSString).range(of: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGNUP"))
        
        if gesture.didTapAttributedTextInLabel(label: goSignUpLbl, inRange: termsRange) {
            if(isFromAppLogin){
                let signUpUv = GeneralFunctions.instantiateViewController(pageName: "SignUpUV") as! SignUpUV
                signUpUv.isFromAppLogin = false
                signUpUv.chackOutUV = self.chackOutUV
                self.push(uv: signUpUv)
            }else{
                self.close()
            }
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        if(userNameTxtField == sender){
            self.userNameTxtFieldHelperLbl.isHidden = false
            
             if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
                 if(text.count > 3){
                    if(text.isNumeric()){
                        
                        
                        view.layoutIfNeeded()
                        self.signInLeadingSpace.constant = 135

                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                          self.view.layoutIfNeeded()
                        }, completion: { finished in
                          self.countryTxtField.isHidden = false
                           
                        })
                        
                        
                        
                    }else{
                        self.countryTxtField.isHidden = true
                        view.layoutIfNeeded()
                        self.signInLeadingSpace.constant = 30

                        UIView.animate(withDuration: 0.3, animations: {
                             self.view.layoutIfNeeded()
                        })
                    }
                }else{
                    self.countryTxtField.isHidden = true
                    view.layoutIfNeeded()
                    self.signInLeadingSpace.constant = 30

                    UIView.animate(withDuration: 0.3, animations: {
                         self.view.layoutIfNeeded()
                    })
                }
            }
        }
        
        if sender == self.nPassOTPTxtFiled {
             self.nPassErrorLbl.isHidden = true
        
            if text == ""{
              self.nPassOTPLbl.isHidden = false
            }else{
                self.nPassOTPLbl.isHidden = true
            }
        }
    }
    

    
    @objc func fbBtnTapped(){
//        isViewProperShutDown = true
        let window = UIApplication.shared.delegate!.window!
        
        openFbLogin = OpenFbLogin(uv: self, window: window!)
        
        openFbLogin.processData(openFbLoginInst: openFbLogin)
    }
    
    @objc func googleBtnTapped(){
//        isViewProperShutDown = true
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        let window = UIApplication.shared.delegate!.window!

        openGoogleLogin = OpenGoogleLogin(uv: self, window: window!)
        openGoogleLogin.processData(currGoogleLoginInst: openGoogleLogin)

    }
    
    @objc func appleBtnTapped(){
//        isViewProperShutDown = true
        let appleSignInInstance = SignInWithApple.getInstance(uv: self, isSignUp:"No")

        appleSignInInstance.appleSignInTapped()
        
    }
    
    @objc func linkdinBtnTapped(){
        
        let window = UIApplication.shared.delegate!.window!
        
        openLinkdinLogin = OpenLinkedinLogin(uv: self, window: window!)
        openLinkdinLogin.processData(currLinkedinInst: openLinkdinLogin)
        
    }
    
//    func myBtnTapped(sender: MyButton) {
//
//        if(sender == signInBtn){
//            checkData()
//        }
//
//    }
    
    func checkData(){
        let noWhiteSpace = generalFunc.getLanguageLabel(origValue: "Password should not contain whitespace.", key: "LBL_ERROR_NO_SPACE_IN_PASS");
        let pass_length = generalFunc.getLanguageLabel(origValue: "Password must be", key: "LBL_ERROR_PASS_LENGTH_PREFIX")
            + " \(Utils.minPasswordLength)" + " " + generalFunc.getLanguageLabel(origValue: "or more character long.",key: "LBL_ERROR_PASS_LENGTH_SUFFIX");
        let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
        
//        let emailEntered = Utils.checkText(textField: self.userNameTxtField.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.userNameTxtField.getTextField()!)) ? true : Utils.setErrorFields(textField: self.userNameTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR_TXT"))) : Utils.setErrorFields(textField: self.userNameTxtField.getTextField()!, error: required_str)

        
        let emailEntered = Utils.checkText(textField: self.userNameTxtField.getTextField()!) ? (Utils.getText(textField: self.userNameTxtField.getTextField()!).isNumeric() ? (Utils.getText(textField: self.userNameTxtField.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.userNameTxtField.getTextField()!, error: mobileInvalid)) : (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.userNameTxtField.getTextField()!)) ? true :  Utils.setErrorFields(textField: self.userNameTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR")) )) : Utils.setErrorFields(textField: self.userNameTxtField.getTextField()!, error: required_str)
        
        let passwordEntered = Utils.checkText(textField: self.passwordTxtField.getTextField()!) ? (Utils.getText(textField: self.passwordTxtField.getTextField()!).contains(" ") ? Utils.setErrorFields(textField: self.passwordTxtField.getTextField()!, error: noWhiteSpace) : (Utils.getText(textField: self.passwordTxtField.getTextField()!).count >= Utils.minPasswordLength ? true : Utils.setErrorFields(textField: self.passwordTxtField.getTextField()!, error: pass_length))) : Utils.setErrorFields(textField: self.passwordTxtField.getTextField()!, error: required_str)
       
        if (emailEntered == false || passwordEntered == false) {
            if(emailEntered == false){
                self.userNameTxtFieldHelperLbl.isHidden = true
            }
            return;
        }

        if(Utils.getText(textField: self.userNameTxtField.getTextField()!).isNumeric()){
        }
        
        signIn()
    }
    
    func myLableTapped(sender: MyLabel) {
//        isViewProperShutDown = true
        if(sender == self.forgetPasswordLbl){
            
//            self.present(SFSafariViewController(url: URL(string: GeneralFunctions.getValue(key: Utils.LINK_FORGET_PASS_KEY) as! String)!), animated: true, completion: nil)
            let forgetPasswordUV = GeneralFunctions.instantiateViewController(pageName: "ForgetPasswordUV") as! ForgetPasswordUV

            self.push(uv: forgetPasswordUV)
            
        }

    }
    
    func signIn(){
        UserDefaults.standard.set("", forKey: "guestTap")
        var animationView:AnimationView!
        animationView = GeneralFunctions.perofrmLoginAnimation()
        
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        var parameters = ["type":"signIn","vEmail": Utils.getText(textField: self.userNameTxtField.getTextField()!), "vPassword": Utils.getText(textField: self.passwordTxtField.getTextField()!), "vDeviceType": Utils.deviceType, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage, "UserType": Utils.appUserType]
        
        if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
            parameters["CountryCode"] = self.selectedCountryCode
            parameters["PhoneCode"] = self.selectedPhoneCode
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(animationView != nil){
                animationView.superview?.removeFromSuperview()
            }
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: true)
                    
                 //   let userProfileJsonDict = (response.toDict().dictOf(Utils.message_str))
                    if(ServiceModule.isDeliverAllOnly())
                    {
                        GeneralFunctions.saveValue(key: "LOGED_IN_DELIVERALL", value: true as AnyObject)
                        _ = OpenMainProfile(uv: self, userProfileJson: response, checkOutUV:self.chackOutUV)

                        GeneralFunctions.restartApp(window: Application.window!)

                    }else
                    {
                        let window = UIApplication.shared.delegate!.window!
                        
                        _ = OpenMainProfile(uv: self, userProfileJson: response, window: window!)
                    }
                    
                    
                }else{
                    if(dataDict.get("eStatus").uppercased() == "INACTIVE" || dataDict.get("eStatus").uppercased() == "DELETED"){
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), completionHandler: { (btnClickedIndex) in
                            if(btnClickedIndex == 1){
                                let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                                self.push(uv: contactUsUv)
                            }
                        })
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    
                    self.passwordTxtField.setText(text: "")
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                self.passwordTxtField.setText(text: "")
            }
        })
    }
    
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    func timeString(time:TimeInterval) -> String{
        let min = Configurations.convertNumToAppLocal(numStr:String(format:"%02i",Int(time) / 60 % 60))
        let sec = Configurations.convertNumToAppLocal(numStr:String(format:"%02i",Int(time) % 60))
        return "\(min):\(sec)"
    }
    
    func requestVerification(){
        
        let parameters = ["type":"sendAuthOtp", "iMemberId": GeneralFunctions.getMemberd(), "MobileNo": self.nPassMobileNumberOnly, "vPhoneCode":self.selectedPhoneCode, "UserType": Utils.appUserType]
        
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
    
    func verifyOTPVerification(){
           

        
            var animationView:AnimationView!
            animationView = GeneralFunctions.perofrmLoginAnimation()
            
            let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
            let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
            
            var parameters = ["type":"AuthenticateMember", "iMemberId": GeneralFunctions.getMemberd(), "MobileNo": self.nPassMobileNumberOnly, "vPhoneCode":self.selectedPhoneCode, "UserType": Utils.appUserType, "vPassword":Utils.getText(textField: self.nPassTxtFiled.getTextField()!), "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage]
              if self.isUserRegistered.uppercased() == "YES" {
                   parameters["isNewPassword"] = "Yes"
               }else{
                   parameters["isNewPassword"] = "No"
               }
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
            exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
            exeWebServerUrl.currInstance = exeWebServerUrl
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                
                if(animationView != nil){
                    animationView.superview?.removeFromSuperview()
                }
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
            
                    if(dataDict.get("Action") == "1"){
                        
                        if(self.freqTask_Phone != nil){
                            self.freqTask_Phone.stopRepeatingTask()
                            self.freqTask_Phone = nil
                        }
                        
                        if(dataDict.get("IS_REGISTERED").uppercased() == "YES"){
                            _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: true)
                            
                           // let userProfileJsonDict = (response.toDict().dictOf(Utils.message_str))
                            if(ServiceModule.isDeliverAllOnly())
                            {
                                GeneralFunctions.saveValue(key: "LOGED_IN_DELIVERALL", value: true as AnyObject)
                               
                                
                                _ = OpenMainProfile(uv: self, userProfileJson: response, checkOutUV:self.chackOutUV)

                                GeneralFunctions.restartApp(window: Application.window!)

                            }else
                            {
                                let window = UIApplication.shared.delegate!.window!
                                
                                _ = OpenMainProfile(uv: self, userProfileJson: response, window: window!)
                            }
                            
                        }else{
                            
                            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
                            uv.isOpenForRegi = true
                            uv.nPassTxt = Utils.getText(textField: self.nPassTxtFiled.getTextField()!)
                            uv.nPassMobileNumberOnly = self.nPassMobileNumberOnly
                            uv.selectedPhoneCode = self.selectedPhoneCode
                            uv.selectedCountryCode = self.selectedCountryCode
                            uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
                            self.push(uv: uv)
            
                        }
                        
                        
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    
                    }

                    
                }else{
                    self.generalFunc.setError(uv: self)
                    
                }
            })
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
                    self.nPassErrorLbl.isHidden = true
                    self.verifyOTPVerification()
                }
        }
    }
    
    func validateOTP(){
        let smsCode_str = nPassOTPStackView.getOTP()
        if((smsCode_str == smsVerificationCode && smsVerificationCode != "") || ((GeneralFunctions.getValue(key: Utils.SITE_TYPE_KEY) as! String).uppercased() == "DEMO" && smsCode_str == "1234")){
                            
            verifyOTPVerification()
        }else{
            if(smsCode_str == ""){
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_VERIFICATION_CODE"))
            }else{
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VERIFICATION_CODE_INVALID"))
            }
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == self.bottomInfoSubmitBtn){
            self.view.layoutIfNeeded()
            self.bottomInfoTopSpace.constant = 0

            UIView.animate(withDuration: 0.5, animations: {
                 self.bottomInfoView.isHidden = true
                 self.view.layoutIfNeeded()
            })
        }
        
    }
    
    @IBAction func unwindToSignIn(_ segue:UIStoryboardSegue) {
           
           if(segue.source .isKind(of: CountryListUV.self)){
               let sourceViewController = segue.source as? CountryListUV
               let selectedPhoneCode:String = sourceViewController!.selectedCountryHolder!.vPhoneCode
               let selectedCountryCode = sourceViewController!.selectedCountryHolder!.vCountryCode
               
               self.selectedCountryCode = selectedCountryCode
               self.selectedPhoneCode = selectedPhoneCode
               self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:sourceViewController!.selectedCountryHolder!.vSImage, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
               
               self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
            
               self.nCountryTxtFiled.setText(text: "+\(selectedPhoneCode)")
               
               self.isCountrySelected = true
               self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
               
           }
       
       }
    
    func skipLoginInfo(){
        let parameters = ["type":"generateReviewModeLogin"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: true)
                    
                    let window = UIApplication.shared.delegate!.window!
                    _ = OpenMainProfile(uv: self, userProfileJson: response, window: window!)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func checkUserEmail(){
        
        let parameters = ["type":"CheckMemberAccount", "vEmail": self.nMail, "vDeviceType": Utils.deviceType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.emailExitCheck()
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    func emailExitCheck()  {
        if(GeneralFunctions.getValue(key: Utils.REFERRAL_SCHEME_ENABLE) != nil && (GeneralFunctions.getValue(key: Utils.REFERRAL_SCHEME_ENABLE) as! String).uppercased() != "YES" ){
            self.nMail = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
            self.registerUser()
        }else{
            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
            uv.isOpenForReffereal = true
            uv.nMail = Utils.getText(textField: self.nMailInfoTxtField.getTextField()!)
            uv.nFirstName = self.nFirstName
            uv.nLastName = self.nLastName
            uv.nPassTxt = self.nPassTxt
            uv.nPassMobileNumberOnly = self.nPassMobileNumberOnly
            uv.selectedPhoneCode = self.selectedPhoneCode
            uv.selectedCountryCode = self.selectedCountryCode
            uv.nPassMobileNumberWithCountry = "+\(self.selectedPhoneCode)\(self.nMobileTxtFiled.getTextField()!.text!)"
            self.push(uv: uv)
        }
    }
    @objc func tapLabelTerms(gesture: UITapGestureRecognizer) {
        
        let termsRange = (self.finalStrTerms.string as NSString).range(of: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION_PRIVACY"))
        
        if gesture.didTapAttributedTextInLabel(label: self.termsConditionLbl, inRange: termsRange) {
            let supportUv = GeneralFunctions.instantiateViewController(pageName: "SupportUV") as! SupportUV
            supportUv.isOnlyPrivacyAndTerms = true
            self.push(uv: supportUv)
        }
    }
}


extension SignInUV: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
        
    }
}


