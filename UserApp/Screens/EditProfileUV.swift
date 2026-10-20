
import UIKit
import SysBaseLib

class EditProfileUV: ParentViewUV, MyBtnClickDelegate, MyTxtFieldClickDelegate, MyLabelClickDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollViewCOntentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profilePicViewArea: UIView!
    @IBOutlet weak var editPicAreaView: UIView!
    
    @IBOutlet weak var userProfilePicBgView: UIView!
    @IBOutlet weak var userProfilePicBgImgView: UIImageView!
    @IBOutlet weak var usrProfileImgView: UIImageView!
    @IBOutlet weak var fNameTxtField: MyTextField!
    @IBOutlet weak var lNameTxtField: MyTextField!
    @IBOutlet weak var emailTxtField: MyTextField!
    @IBOutlet weak var countryTxtField: MyTextField!
    @IBOutlet weak var mobileTxtField: MyTextField!
    @IBOutlet weak var currencyTxtField: MyTextField!
    @IBOutlet weak var editIconImgView: UIImageView!
    
    @IBOutlet weak var langTxtFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var currencyTxtFieldHeight: NSLayoutConstraint!
    
    @IBOutlet weak var updateBtn: MyButton!
    @IBOutlet weak var mainViewBG: UIView!
    @IBOutlet weak var languageTextField : MyTextField!
    
    @IBOutlet weak var languageLBL: MyLabel!
    @IBOutlet weak var fNameLBL: MyLabel!
    @IBOutlet weak var lNameLBL: MyLabel!
    @IBOutlet weak var emailLBL: MyLabel!
    @IBOutlet weak var mobileLBL: MyLabel!
    @IBOutlet weak var currencyLBL: MyLabel!

    @IBOutlet weak var phoneCntView : UIView!
    
    
    @IBOutlet weak var languageLblTop: NSLayoutConstraint!
    
    
    var manageProfileUv:ManageProfileUV!
    
    var containerViewHeight:CGFloat = 0
    
    let generalFunc = GeneralFunctions()
    
    var required_str = ""
    
    var isCountrySelected = false
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    
    var selectedCurrency = ""
    var selectedLngCode = ""
    
    var languageNameList = [String]()
    var languageCodes = [String]()
    
    var colorArrayForLang = [UIColor]()
    var colorArrayForCurr = [UIColor]()
    
    var colorArrayForTextLang = [UIColor]()
    var colorArrayForTextCurr = [UIColor]()
    
    var selectedLngColor = UIColor()
    var selectedCurrColor = UIColor()
    
    var selectedLngTxtColor = UIColor()
    var selectedCurrTxtColor = UIColor()
    
    var currencySymboles = [String]()
    var currenyList = [String]()
    
    var countryPrefixImgView:UIImageView!
    
    var isFirstLaunch = true
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    
    var countryListArr:NSArray!
    var openListView:OpenListView!
    
    public var openImgSelection:OpenFileSelector!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.openImgSelection = OpenFileSelector(uv: self)
            
            cntView = self.generalFunc.loadView(nibName: "EditProfileScreenDesign", uv: self, contentView: scrollView)
            
            self.scrollView.addSubview(cntView)
            
            self.contentView.alpha = 0
            
            self.mainViewBG.addShadowWithCornerRadius_new()
            self.phoneCntView.addShadowWithCornerRadius_new(Opacity: 0.5)

            self.fNameLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIRST_NAME_HEADER_TXT")
            self.lNameLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LAST_NAME_HEADER_TXT")
            self.emailLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT")
            self.mobileLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT")
            self.currencyLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CURRENCY_TXT")
            self.languageLBL.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANGUAGE_TXT")
            
            setData()
            
        }else if(type == 1){
            
            CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
                if(isSuccess){
                    self.countryListArr = dataArray
                }
            }
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            if(isFirstLaunch == true){
                languageTextField.addImageView(color: UIColor.lightGray, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 25, 25, nil)

                currencyTxtField.addImageView(color: UIColor.lightGray, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 25, 25, nil)
                
                if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
                    countryTxtField.addImageView(color: UIColor.lightGray, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 25, 25, nil)
                    self.countryTxtField.myTxtFieldDelegate = self
                    
                }
                
                if(containerViewHeight > self.scrollViewCOntentViewHeight.constant){
                    self.scrollViewCOntentViewHeight.constant = containerViewHeight + 30
                }
                
                cntView.frame.size = CGSize(width: cntView.frame.width, height: self.scrollViewCOntentViewHeight.constant + 30)
                
                self.scrollView.bounces = false
    //            self.scrollView.setContentViewSize(offset: 15, currentMaxHeight: self.scrollViewCOntentViewHeight.constant)
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollViewCOntentViewHeight.constant + 30)
                
                isFirstLaunch = false
                
                self.countryTxtField.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in
                    
                    self.countryPrefixImgView = imageView
                    if(self.userProfileJson.get("vSCountryImage") != ""){
                        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:self.userProfileJson.get("vSCountryImage") , width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                    }else{
                        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                    }
                    
                }
                
               
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.contentView.alpha = 1
                })
                
            }
            
        }
    }
    
    
    func setData(){
        required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT_PROFILE_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT_PROFILE_TXT")
//        LBL_EDIT_PROFILE_TXT
        fNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIRST_NAME_HEADER_TXT"))
        lNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LAST_NAME_HEADER_TXT"))
        emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))
        countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
        mobileTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
        currencyTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CURRENCY_TXT"))
        languageTextField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANGUAGE_TXT"))

        countryTxtField.masksToBounds = true
        mobileTxtField.masksToBounds = true
        self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        fNameTxtField.setText(text: userProfileJson.get("vName"))
        lNameTxtField.setText(text: userProfileJson.get("vLastName"))
        emailTxtField.setText(text: userProfileJson.get("vEmail"))
        countryTxtField.setText(text: "+" + userProfileJson.get("vPhoneCode"))
        mobileTxtField.setText(text: userProfileJson.get("vPhone"))
        currencyTxtField.setText(text: userProfileJson.get("vCurrencyPassenger"))
        languageTextField.setText(text: userProfileJson.get("vLang"))
        
        countryTxtField.disableMenu()
        currencyTxtField.disableMenu()
        languageTextField.disableMenu()
        
        currencyTxtField.setEnable(isEnabled: false)
        
        self.countryTxtField.setEnable(isEnabled: false)
        languageTextField.setEnable(isEnabled: false)
        
        self.languageTextField.myTxtFieldDelegate = self
        
        self.currencyTxtField.myTxtFieldDelegate = self
        
        self.selectedCurrency = userProfileJson.get("vCurrencyPassenger")
        
        if(userProfileJson.get("vPhoneCode") != ""){
            isCountrySelected = true
            selectedCountryCode = userProfileJson.get("vCountry")
            selectedPhoneCode = userProfileJson.get("vPhoneCode")
        }
        
        self.updateBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE"))
        self.updateBtn.clickDelegate = self
        
       // userProfilePicBgImgView.sd_setImage(with: URL(string: CommonUtils.user_image_url + GeneralFunctions.getMemberd() + "/" + userProfileJson.get("vImgName")), placeholderImage:UIImage(named:"ic_no_pic_user"))
       // self.userProfilePicBgView.backgroundColor = SColors.Theme

        usrProfileImgView.sd_setImage(with: URL(string: CommonUtils.user_image_url + GeneralFunctions.getMemberd() + "/" + userProfileJson.get("vImgName")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        Utils.createRoundedView(view: usrProfileImgView, borderColor: SColors.ThemeTxt, borderWidth: 0)
        

        editPicAreaView.backgroundColor = SColors.Theme
        editPicAreaView.layer.addShadow(opacity: 0.8, radius: 3, UIColor.lightGray)
        editPicAreaView.layer.roundCorners(radius: 12)
        
        if(userProfileJson.get("vImgName").trim() == ""){
            editIconImgView.image = UIImage(named: "ic_plus")?.resize(toWidth: 25)!.resize(toHeight: 25)
            editIconImgView.contentMode = .center
        }else {
            editIconImgView.contentMode = .center
            editIconImgView.image = UIImage(named: "ic_edit")?.resize(toWidth: 18)!.resize(toHeight: 18)

        }
        GeneralFunctions.setImgTintColor(imgView: editIconImgView, color: SColors.ThemeTxt)
//
//        self.editIconImgView.image = self.editIconImgView.image?.addImagePadding(x: 5, y: 5)
//        GeneralFunctions.setImgTintColor(imgView: editIconImgView, color: SColors.Theme)
        
        self.mobileTxtField.getTextField()!.keyboardType = .numberPad
        self.emailTxtField.getTextField()!.keyboardType = .emailAddress
        
        setLanguage()
        
        let userProfileImgTapGue = UITapGestureRecognizer()
        userProfileImgTapGue.addTarget(self, action: #selector(self.profilePicTapped))
        
        self.profilePicViewArea.isUserInteractionEnabled = true
        self.profilePicViewArea.addGestureRecognizer(userProfileImgTapGue)
        
    }
    
    @objc func profilePicTapped(){
        
        self.openImgSelection.show(type: .CroppedImageFileType) { (isImageUpload) in
            if(isImageUpload == true){
                
                self.openImgSelection.closeSlectionView()
                
               
                if(self.openImgSelection.selectedFileData != nil){
                    self.myImageUploadRequest(image: UIImage.init(data: self.openImgSelection.selectedFileData)!)
                }
            }
        }
        
    }
    
    func myImageUploadRequest(image:UIImage){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let SITE_TYPE_DEMO_MSG = userProfileJson.get("SITE_TYPE_DEMO_MSG")
    
        
        if let SITE_TYPE = GeneralFunctions.getValue(key: Utils.SITE_TYPE_KEY) as? String{
            if(SITE_TYPE == "Demo" && userProfileJson.get("vEmail") == "rider@gmail.com"){
                self.generalFunc.setError(uv: self, title: "", content: SITE_TYPE_DEMO_MSG)
                return
            }
        }
        
        let myUrl = URL(string: CommonUtils.webservice_path)
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST"
        
        let parameters = [
            "type"  : "uploadImage",
            "MemberType"    : Utils.appUserType,
            "iMemberId"    : GeneralFunctions.getMemberd()
        ]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.uploadImage(image:image, completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    self.setData()
                    
                } else if dataDict.get("message") == "" {
                    self.generalFunc.setError(uv: self)
                }
                else{
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
            countryListUv.fromEditProfile = true
            
            if(countryListArr != nil){
                countryListUv.countryListArr = countryListArr
            }
            countryListUv.modalPresentationStyle = .overCurrentContext
            self.present(countryListUv, animated: true) {
            }
            
        }else if(sender == self.currencyTxtField){
            self.openListView = OpenListView(uv: nil, containerView: self.view)
            self.openListView.openNewList = true
            self.openListView.editProfileUV = self
            self.openListView.newListCodeString = self.currencySymboles
            self.openListView.colorArray = self.colorArrayForCurr
            self.openListView.textColorArray = self.colorArrayForTextCurr
            self.openListView.isForCurrency = true
            self.openListView.selectedItem = self.currencyTxtField.text
            self.openListView.show(listObjects: self.currenyList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CURRENCY"), currentInst: self.openListView, handler: { (selectedItemId) in
                
            })
        }
        else if(sender == self.languageTextField){
                    self.openListView = OpenListView(uv: nil, containerView: self.view)
                    self.openListView.openNewList = true
                    self.openListView.editProfileUV = self
                    self.openListView.newListCodeString = self.languageCodes
                    self.openListView.colorArray = self.colorArrayForLang
                    self.openListView.textColorArray = self.colorArrayForTextLang
                    self.openListView.selectedItem = self.languageTextField.text
                    self.openListView.isForLang = true
                    self.openListView.show(listObjects: self.languageNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LANGUAGE_HINT_TXT"), currentInst: self.openListView, handler: { (selectedItemId) in
                       
                    })
                }
    }
    
    func setLanguage(){
        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            
            self.colorArrayForLang.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextLang.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
            
            if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) == tempItem.get("vCode")){
               
                languageTextField.setText(text: tempItem.get("vTitle"))

                self.selectedLngCode = tempItem.get("vCode")
                self.selectedLngColor = self.colorArrayForLang[i]
                self.selectedLngTxtColor = self.colorArrayForTextLang[i]
            }
            
            languageNameList += [tempItem.get("vTitle")]
            languageCodes += [tempItem.get("vCode")]
            
        }
        
        if(dataArr.count < 2){
            self.scrollViewCOntentViewHeight.constant = self.scrollViewCOntentViewHeight.constant - self.langTxtFieldHeight.constant - 30
            self.langTxtFieldHeight.constant = 0.0
            self.languageTextField.isHidden = true
            self.languageLBL.isHidden = true
            self.languageLBL.text = ""
            self.languageLblTop.constant = -8
          
        }
        
        setCurrency()
    }
    
    func lngValueChanged(selectedItemId:Int){
        self.selectedLngCode = self.languageCodes[selectedItemId]
        self.languageTextField.setText(text: self.languageNameList[selectedItemId])
        
        if(self.openListView != nil){
            self.openListView.bgView.isUserInteractionEnabled = true
            self.openListView.newListView.isUserInteractionEnabled = true
            self.openListView.startLoading = false
            self.openListView.newListView.tableView.reloadData()
            self.openListView.closeNewListView()
        }
    }
    
    func setCurrency(){
        let dataArr = GeneralFunctions.getValue(key: Utils.CURRENCY_LIST_KEY) as! NSArray
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            self.colorArrayForCurr.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextCurr.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
          //  if((GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String) == tempItem.get("vName")){
            if(userProfileJson.get("vCurrencyPassenger") == tempItem.get("vName")) {
                self.currencyTxtField.setText(text: tempItem.get("vName"))
                self.selectedCurrency = tempItem.get("vName")
                self.selectedCurrColor = self.colorArrayForCurr[i]
                self.selectedCurrTxtColor = self.colorArrayForTextCurr[i]
                
            }
            
            currenyList += [tempItem.get("vName")]
            currencySymboles.append(tempItem.get("vSymbol"))
        }
        
        if(dataArr.count < 2){
            self.scrollViewCOntentViewHeight.constant = self.scrollViewCOntentViewHeight.constant - self.currencyTxtFieldHeight.constant - 30
            self.currencyTxtFieldHeight.constant = 0.0
            self.currencyTxtField.isHidden = true
            self.currencyLBL.isHidden = true
            
            self.currencyLBL.text = ""
           // self.languageTextField.isHidden = true
        }
    }
    
    func currencyValueChanged(selectedItemId:Int){
        
        self.selectedCurrency = self.currenyList[selectedItemId]
        self.currencyTxtField.setText(text: self.selectedCurrency)
    
        self.selectedCurrColor = self.colorArrayForCurr[selectedItemId]
        self.selectedCurrTxtColor = self.colorArrayForTextCurr[selectedItemId]
        self.selectedCurrency = self.currenyList[selectedItemId]
        self.currencyTxtField.setText(text: self.selectedCurrency.uppercased())
        //GeneralFunctions.saveValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY, value: self.selectedCurrency as AnyObject)
        
    }
    
    func myBtnTapped(sender: MyButton) {
//        let noWhiteSpace = generalFunc.getLanguageLabel(origValue: "Password should not contain whitespace.", key: "LBL_ERROR_NO_SPACE_IN_PASS");
//        let pass_length = generalFunc.getLanguageLabel(origValue: "Password must be", key: "LBL_ERROR_PASS_LENGTH_PREFIX")
//            + " \(Utils.minPasswordLength)"  + generalFunc.getLanguageLabel(origValue: "or more character long.",key: "LBL_ERROR_PASS_LENGTH_SUFFIX");
        
        let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
        
        let fNameEntered = Utils.checkText(textField: self.fNameTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.fNameTxtField.getTextField()!, error: required_str)
        let lNameEntered = Utils.checkText(textField: self.lNameTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.lNameTxtField.getTextField()!, error: required_str)
        
        let isEmailOptional =  GeneralFunctions.getValue(key: Utils.ENABLE_EMAIL_OPTIONAL)?.uppercased
        var emailValidEntered = false
        let isEmailEntered = Utils.checkText(textField: self.emailTxtField.getTextField()!)
        
        if isEmailOptional == "YES" {
            if isEmailEntered {
                emailValidEntered = Utils.checkText(textField: self.emailTxtField.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtField.getTextField()!)) ? true : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : false
            }
        }else{
            emailValidEntered = Utils.checkText(textField: self.emailTxtField.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtField.getTextField()!)) ? true : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : Utils.setErrorFields(textField: self.emailTxtField.getTextField()!, error: required_str)
        }

        let mobileEntered = Utils.checkText(textField: self.mobileTxtField.getTextField()!) ? (Utils.getText(textField: self.mobileTxtField.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.mobileTxtField.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.mobileTxtField.getTextField()!, error: required_str)
        
        let countryEntered = isCountrySelected ? true : Utils.setErrorFields(textField: self.countryTxtField.getTextField()!, error: required_str)
        
        
         if (fNameEntered == false || lNameEntered == false ||  mobileEntered == false
             || countryEntered == false) {
             return;
         }
         
         if isEmailOptional == "YES"{
            if isEmailEntered {
                if emailValidEntered == false{
                    return;
                }
            }
        }else{
            if(emailValidEntered == false){
                return;
            }
        }
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        let vPhoneCode = userProfileJson.get("vPhoneCode")
        let vPhone = userProfileJson.get("vPhone")
        
        if let SITE_TYPE = GeneralFunctions.getValue(key: Utils.SITE_TYPE_KEY) as? String{
            if(SITE_TYPE == "Demo" && userProfileJson.get("vEmail") == "rider@gmail.com"){
                self.generalFunc.setError(uv: self, title: "", content: userProfileJson.get("SITE_TYPE_DEMO_MSG"))
                return
            }
        }
        
        if(GeneralFunctions.getValue(key: Utils.MOBILE_VERIFICATION_ENABLE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.MOBILE_VERIFICATION_ENABLE_KEY) as! String).uppercased() == "YES" && (vPhoneCode != self.selectedPhoneCode  || vPhone != Utils.getText(textField: self.mobileTxtField.getTextField()!))){
            
            DispatchQueue.main.async() {
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VERIFY_MOBILE_CONFIRM_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedId) in
                    
                    if(btnClickedId == 0){
                        let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
                        accountVerificationUv.mobileNum = self.selectedPhoneCode + Utils.getText(textField: self.mobileTxtField.getTextField()!)
                        accountVerificationUv.isEditProfile = true
                        accountVerificationUv.requestType = "DO_PHONE_VERIFY"
                        self.push(uv: accountVerificationUv)
                    }
                })
            }
        }else{
            
            let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")
            let vLang = userProfileJson.get("vLang")
            
            if(ServiceModule.isDeliverAllOnly() || ServiceModule.isAnyDeliverAllOptionEnable()) && (vLang != self.selectedLngCode || vCurrencyPassenger != self.selectedCurrency)
            {
                var foodItmData = NSMutableArray.init()
                
                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                    
                    foodItmData = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                    
                }
                if foodItmData.count != 0
                {
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CART_REMOVE_NOTE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0
                        {
                            let cartItemsArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                            cartItemsArray.removeAllObjects()
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: cartItemsArray as AnyObject)
                            
                            self.updateProfile()
                        }
                        
                    })
                }else
                {
                    updateProfile()
                }
            }else
            {
                updateProfile()
            }
          
        }
    }
    
    func updateProfile(){
        
        let parameters = ["type":"updateUserProfileDetail","vName": Utils.getText(textField: self.fNameTxtField.getTextField()!), "vLastName": Utils.getText(textField: self.lNameTxtField.getTextField()!), "vEmail": Utils.getText(textField: self.emailTxtField.getTextField()!), "vPhone": Utils.getText(textField: self.mobileTxtField.getTextField()!), "vPhoneCode": self.selectedPhoneCode, "vCountry": self.selectedCountryCode, "vDeviceType": Utils.deviceType, "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "LanguageCode": selectedLngCode, "CurrencyCode": self.selectedCurrency]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY, value: self.selectedCurrency as AnyObject)
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: false)
                    
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)

                    let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")
                    let vLang = userProfileJson.get("vLang")

                    if(vLang != self.selectedLngCode || vCurrencyPassenger != self.selectedCurrency){
                       
                        GeneralFunctions.downloadGenData(completionHandler: { success in
                            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_TRIP_CANCEL_CONFIRM_TXT"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFY_RESTART_APP_TO_CHANGE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                
                                
                                let window = UIApplication.shared.delegate!.window!
                                
                                GeneralFunctions.restartApp(window: window!)
                            })
                        }, true, self.view)
                        
                        return
                    }
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)

                    if(self.manageProfileUv == nil){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INFO_UPDATED_TXT"), uv: self)
                        
                        //self.close()
                    }else{
                        if(self.manageProfileUv.isFromAccountVerifyScreen == true){
                            self.manageProfileUv!.performSegue(withIdentifier: "unwindToAccountVerificationScreen", sender: self.manageProfileUv)
                        }else{
                            self.manageProfileUv!.openViewProfileUv()
                        }
                    }
                    
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    
    }
    
    @IBAction func unwindToEditProfile(_ segue:UIStoryboardSegue) {
        //        unwindToSignUp
        
        if(segue.source .isKind(of: CountryListUV.self))
        {
            
            let sourceViewController = segue.source as? CountryListUV
            let selectedPhoneCode:String = sourceViewController!.selectedCountryHolder!.vPhoneCode
            let selectedCountryCode = sourceViewController!.selectedCountryHolder!.vCountryCode
            
            self.selectedCountryCode = selectedCountryCode
            self.selectedPhoneCode = selectedPhoneCode
            
            self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:sourceViewController!.selectedCountryHolder!.vSImage, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
            
            self.countryTxtField.setText(text: "+" + selectedPhoneCode)
//            self.countryTxtField.getTextField()!.text = "+" + selectedPhoneCode
            self.isCountrySelected = true
            
            self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
        }else if(segue.source.isKind(of: AccountVerificationUV.self)){
            let accountVerificationUv = segue.source as! AccountVerificationUV
            
            if(accountVerificationUv.mobileNumVerified == true){
                updateProfile()
            }
        }
        
    }
    
    func myLableTapped(sender: MyLabel) {
       
    }
}
