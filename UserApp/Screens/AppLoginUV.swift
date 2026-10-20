

import UIKit
import NVActivityIndicatorView
import LocalAuthentication
import AdvancedPageControl
import SysBaseLib
import IQKeyboardManagerSwift
import Lottie

class AppLoginUV: ParentViewUV, MyBtnClickDelegate, MyTxtFieldClickDelegate, iCarouselDataSource, iCarouselDelegate, ParentViewUVDelegate {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var languageFieldDownArrow: UIImageView!
    @IBOutlet weak var currencyFieldDownArrow: UIImageView!
    
    @IBOutlet weak var logInBottomStackViewSpace: NSLayoutConstraint!
    @IBOutlet weak var registerBtn: MyButton!
    @IBOutlet weak var signInBtn: MyButton!
    @IBOutlet weak var bgImgView: UIImageView!
    
    
    @IBOutlet weak var lanCurrStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var languageSelectView: UIView!
    @IBOutlet weak var currencySelectView: UIView!
    @IBOutlet weak var lngLbl: MyLabel!
    @IBOutlet weak var currencyLbl: MyLabel!
    @IBOutlet weak var selectStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectStackViewBottomMargin: NSLayoutConstraint!

    @IBOutlet weak var loginRegisterStkView: UIStackView!
    @IBOutlet weak var currencyTxtField: MyTextField!
    @IBOutlet weak var languageTxtField: MyTextField!
    
//    var languageTxtField = MyTextField()
//    var currencyTxtField = MyTextField()
    
//    @IBOutlet weak var introLbl: MyLabel!
    @IBOutlet weak var introSubLbl: MyLabel!
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    @IBOutlet weak var langCurrStackView: UIStackView!
    @IBOutlet weak var imgSlideShow: iCarousel!
   
    
    @IBOutlet weak var biomatricLoginTitleLbl: MyLabel!
    @IBOutlet weak var biomatricLoginView: UIView!
    @IBOutlet weak var biomatrImgView: UIImageView!
    
    
    var imageSlideShowPageController: UIPageControl!
    
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

    let generalFunc = GeneralFunctions()
    
    var languageArrCount = 0
    
    var isViewLoad = false
    
    var openListView:OpenListView!
    
    var isViewRestarted = false
    
    var bannersItemList = [NSDictionary]()
    
    var placeHolderArry = [Placeholder]()
    var isImageLoaded = [Bool]()
    
    var pageControl1:AdvancedPageControlView!
    var chackOutUV:CheckOutUV!
  
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            
            
            self.containerView.addSubview(self.generalFunc.loadView(nibName: "AppLoginScreenDesign", uv: self, contentView: containerView))
            
            let APPSTORE_MODE_IOS = GeneralFunctions.getValue(key: Utils.APPSTORE_MODE_IOS_KEY)
            if(APPSTORE_MODE_IOS != nil && (APPSTORE_MODE_IOS as! String).uppercased() == "REVIEW"){
                let skipContainerView = UIView()
    //            skipContainerView.backgroundColor = UIColor.blue
                
                let skipLabel = MyLabel()
                skipLabel.text = "Skip Login"
                skipLabel.fontFamilyWeight = "Bold"
                skipLabel.font = UIFont(name: Fonts().bold, size: 17)!
                skipLabel.textColor = UIColor(hex: 0x272727)
                skipLabel.backgroundColor = UIColor(hex: 0xFFFFFF)
                skipLabel.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 20, paddingRight: 20)
    //            skipLabel.fit()
                
                skipLabel.layer.cornerRadius = 8
                skipLabel.layer.masksToBounds = true
                skipContainerView.addSubview(skipLabel)
                loginRegisterStkView.addArrangedSubview(skipContainerView)
                
                let widthConstraint = NSLayoutConstraint(item: skipContainerView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loginRegisterStkView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
                
                let heightConstraint = NSLayoutConstraint(item: skipContainerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 45)
                loginRegisterStkView.addConstraint(widthConstraint)
                skipContainerView.addConstraints([heightConstraint])
                
                skipLabel.translatesAutoresizingMaskIntoConstraints = false
                
                skipLabel.centerXAnchor.constraint(equalTo: skipContainerView.centerXAnchor).isActive = true
                skipLabel.centerYAnchor.constraint(equalTo: skipContainerView.centerYAnchor).isActive = true
                skipLabel.sizeToFit()
                
                loginRegisterStkView.layoutSubviews()
                loginRegisterStkView.layoutIfNeeded()
                
                skipLabel.setClickHandler { (instance) in
                    self.skipLoginInfo()
                }
            }
            
            
            registerBtn.clickDelegate = self
            signInBtn.clickDelegate = self
            
            setLabels()
            setData()
            
            self.lanCurrStackViewWidth.constant = 140
            self.languageSelectView.handleClick { (instance) in
                
                self.openListView = OpenListView(uv: nil, containerView: self.view)
                self.openListView.openNewList = true
                self.openListView.appLoginUV = self
                self.openListView.newListCodeString = self.languageCodes
                self.openListView.colorArray = self.colorArrayForLang
                self.openListView.textColorArray = self.colorArrayForTextLang
                self.openListView.selectedItem = self.languageTxtField.text
                self.openListView.isForLang = true
                self.openListView.show(listObjects: self.languageNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LANGUAGE_HINT_TXT"), currentInst: self.openListView, handler: { (selectedItemId) in
                   
                })
            }
            
            self.currencySelectView.handleClick { (instance) in
                
                self.openListView = OpenListView(uv: nil, containerView: self.view)
                self.openListView.openNewList = true
                self.openListView.appLoginUV = self
                self.openListView.newListCodeString = self.currencySymboles
                self.openListView.colorArray = self.colorArrayForCurr
                self.openListView.textColorArray = self.colorArrayForTextCurr
                self.openListView.isForCurrency = true
                self.openListView.selectedItem = self.currencyTxtField.text
                self.openListView.show(listObjects: self.currenyList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CURRENCY"), currentInst: self.openListView, handler: { (selectedItemId) in
                    
                })
            }
            
            setLanguage()
            
            indicatorView.type = .ballPulse
            indicatorView.tintColor = SColors.ThemeTxt
            
            self.languageSelectView.backgroundColor = SColors.Theme
            self.currencySelectView.backgroundColor = SColors.Theme
            self.lngLbl.backgroundColor = .clear//self.selectedLngColor
            self.currencyLbl.backgroundColor = .clear//self.selectedCurrColor
            self.lngLbl.textColor = SColors.ThemeTxt
            self.currencyLbl.textColor = SColors.ThemeTxt
            GeneralFunctions.setImgTintColor(imgView: self.languageFieldDownArrow, color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: self.currencyFieldDownArrow, color: SColors.ThemeTxt)
            
            self.lngLbl.clipsToBounds = true
            
            self.introSubLbl.alpha = 1.0
            self.langCurrStackView.alpha = 1.0
            self.loginRegisterStkView.alpha = 1.0
            //self.imgSlideShow.alpha = 0
           
            self.containerView.isHidden = true
            
            Configurations.setDefaultNavBar()
            
            //GeneralFunctions.setImgTintColor(imgView: self.biomatrImgView, color: SColors.Theme)

            if(isViewRestarted){
                
               // self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                    // 3
                //    self.view.layoutIfNeeded()
                }, completion: {_ in
//                    self.lanCurrStackViewWidth.constant = 105
//                    self.bgImgViewYPosition.constant = -(Application.screenSize.height / 2) + GeneralFunctions.getSafeAreaInsets().top + 35
//
//                    self.bgImgViewWidth.constant = 85
//                    self.bgImgViewHeight.constant = 85
//
//                    if(Configurations.isRTLMode()){
//                        self.bgImgViewXPosition.constant = +(Application.screenSize.width / 2) - 60
//                    }else{
//                        self.bgImgViewXPosition.constant = -(Application.screenSize.width / 2) + 60
//                    }
//
//                    self.introSubLbl.alpha = 1.0
//                    self.langCurrStackView.alpha = 1.0
//                    self.loginRegisterStkView.alpha = 1.0
//                    self.imgSlideShow.alpha = 1.0
                })
            
            }
            
        }else if(type == 1){
            
            self.configRTL()
           // self.navigationController?.navigationBar.isHidden = true
            
            //Quick Login
            if(GeneralFunctions.isQuickLogInEnable() && (GeneralFunctions.isKeyExistInUserDefaults(key: "QUICK_LOGIN_DIC") == true && (GeneralFunctions.getValue(key: "QUICK_LOGIN_DIC") as! NSDictionary).count > 0)){
                self.introSubLbl.isHidden = true
                self.biomatricLoginView.isHidden = false
                self.biomatricLoginTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SMART_LOGIN_APPLOGIN")
                
            }else{
                self.introSubLbl.isHidden = false
                self.biomatricLoginView.isHidden = true
            }
            
        }else if(type == 2){
            if(self.isViewLoad == false){
            
                self.imageSlideShowPageController = UIPageControl.init(frame: CGRect(x: 10, y: self.imgSlideShow.frame.origin.y + self.imgSlideShow.frame.height + 5, width: Application.screenSize.width - 20, height:20))
                self.imageSlideShowPageController.currentPage = 0
                self.imageSlideShowPageController.isUserInteractionEnabled = false
                self.imageSlideShowPageController.tintColor = UIColor.lightGray
                self.imageSlideShowPageController.hidesForSinglePage = true
                self.imageSlideShowPageController.pageIndicatorTintColor = UIColor.lightGray
                self.imageSlideShowPageController.currentPageIndicatorTintColor = SColors.Theme
                self.containerView.addSubview(self.imageSlideShowPageController)

                imgSlideShow.bounces = false
                imgSlideShow.type = .linear
                imgSlideShow.isPagingEnabled = true
                imgSlideShow.scrollSpeed = 0.8
                imgSlideShow.decelerationRate = 0.8
                self.imgSlideShow.delegate = self
                self.imgSlideShow.dataSource = self
            
                
                self.bannersItemList.removeAll()
                self.bannersItemList = GeneralFunctions.getValue(key: "APP_LAUNCH_IMAGES") as! [NSDictionary]
                if(Configurations.isRTLMode()){
                    self.imageSlideShowPageController.currentPage = 0
                    var newreverseArray = [NSDictionary]()
                    let totalIndices = self.bannersItemList.count - 1
                    for arrayIndex in 0...totalIndices {
                        newreverseArray.append(self.bannersItemList[totalIndices - arrayIndex])
                    }
                    self.bannersItemList = newreverseArray
                    self.imgSlideShow.reloadData()
                    self.imgSlideShow.scrollToItem(at: self.bannersItemList.count, duration: 0)
                    self.imageSlideShowPageController.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

                }else{
                    self.imgSlideShow.reloadData()
                }
                
                let imageView = UIImageView.init(frame: CGRect(x: Configurations.isRTLMode() ? 20 : Application.screenSize.width - 60, y: Application.screenSize.height - 30 - 30 , width: 40, height: 30))
                let hightWidth = imageView.getViewHightWidth(baseWidhth: 375, baseHight: 667 , 40,30)
                //imageView.getViewHightWidth(baseHight: 667, baseWidhth: 375, 30,40)
               // print(hightWidth.0 , hightWidth.1)
                
                imageView.clipsToBounds = true
                imageView.cornerRadius = 5
                //imageView.layer.addShadow(opacity: 1, radius: 3.0, UIColor.lightGray)
                imageView.backgroundColor = SColors.Theme
                
                GeneralFunctions.setImgTintColor(imgView:imageView , color: .white)
                imageView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 10, y: 10)
                if(Configurations.isRTLMode()){
                    imageView.image = imageView.image?.rotate(180)
                }
          
                GeneralFunctions.setImgTintColor(imgView:imageView , color: .white)
                imageView.contentMode = .scaleAspectFit
                
                self.containerView.addSubview(imageView)
              
                let guestButton = UIButton(type: .system)
                guestButton.setTitle(self.generalFunc.getLanguageLabel(origValue: "Login as Guest", key: "LBL_GUEST_LOGIN"), for: .normal)
                guestButton.setTitleColor(SColors.Theme, for: .normal)
                guestButton.backgroundColor = .clear
                guestButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                guestButton.translatesAutoresizingMaskIntoConstraints = false
                let guestValue = UserDefaults.standard.string(forKey: "guestValue") ?? ""
                print(UserDefaults.standard.string(forKey: "guestValue"))
                if guestValue.lowercased() == "yes"{
                    self.containerView.addSubview(guestButton)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let pageControl = self.pageControl1 {
                        NSLayoutConstraint.activate([
                            guestButton.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                            guestButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: -8),
                            guestButton.heightAnchor.constraint(equalToConstant: 30)
                        ])
                    } else {
                        NSLayoutConstraint.activate([
                            guestButton.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
                            guestButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                            guestButton.heightAnchor.constraint(equalToConstant: 30)
                        ])
                    }
                }

                guestButton.addTarget(self, action: #selector(self.continueAsGuestTapped), for: .touchUpInside)


                imageView.handleClick { (instance) in
                    self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignInUV"))
                }
                
            
                let shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: (Utils.getHeightOfBanner(widthOffset: Application.screenSize.width - ((Application.screenSize.width * 87) / 100), ratio: "16:9") + self.langCurrStackView.frame.height + self.langCurrStackView.frame.origin.y) + 60, width: Application.screenSize.width, height: 30))
                shadowImageView.image = UIImage(named: "shadow1")
                
               // self.containerView.addSubview(shadowImageView)
                
                var dotWidth:CGFloat = 30.0
                
                if((CGFloat(self.bannersItemList.count) * (dotWidth + 5)) > Application.screenSize.width - 130){
                    dotWidth = 20.0

                    if((CGFloat(self.bannersItemList.count) * (dotWidth + 5)) > Application.screenSize.width - 130){
                        dotWidth = 15.0
                    }
                }
                
                
                pageControl1 = AdvancedPageControlView.init(frame: CGRect(x: Configurations.isRTLMode() ? Application.screenSize.width - (CGFloat(self.bannersItemList.count) * (dotWidth + 5)) - 30 : 20.0, y: (imageView.frame.origin.y ), width: (CGFloat(self.bannersItemList.count) * (dotWidth + 5)), height: 30.0))
                pageControl1.drawer = ColorBlendDrawer.init(numberOfPages: self.bannersItemList.count, height: 5, width: dotWidth, space: 8, raduis: 0, currentItem: 0, indicatorColor: SColors.Theme, dotsColor: UIColor(hex: 0xD9D9D9), isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
               
                pageControl1.tintColor = SColors.Theme
                
                self.containerView.addSubview(pageControl1)
                
                UIView.transition(with: self.containerView, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.containerView.isHidden = false
                })
                
            }
            
            if(self.isViewLoad == false && self.isViewRestarted == false){
                self.next()
            }
            
            
            self.isViewLoad = true
            self.isViewRestarted = false
            
            
            // QUick Login
            self.biomatricLoginView.handleClick { (instance) in
                
                self.biomatricLoginView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
                GeneralFunctions.performQuickLoginWithUV(uv:self)
                
            }
            
            
        }else if(type == 3){
            if(self.isViewRestarted == false){
                Configurations.setAppThemeNavBar()
            }
        }
    }
    
    
    @objc func continueAsGuestTapped() {
        UserDefaults.standard.set("yes", forKey: "guestTap")
        var animationView:AnimationView!
        animationView = GeneralFunctions.perofrmLoginAnimation()
        
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        var parameters = ["type":"signIn","vEmail": "guest@gmail.com", "vPassword": "123456", "vDeviceType": Utils.deviceType, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage, "UserType": Utils.appUserType]
        
        if GeneralFunctions.getValue(key: Utils.ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD)?.uppercased == "YES"{
            parameters["CountryCode"] = "Pk"
            parameters["PhoneCode"] = ""
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
                    
                   
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
              
            }
        })
    }

    
    func next() {
      
//        self.view.layoutIfNeeded()
//        if(!isViewRestarted){
//            self.bgImgViewWidth.constant = 140
//            self.bgImgViewHeight.constant = 140
//        }
//        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
//            // 3
//            self.view.layoutIfNeeded()
//        }, completion: {_ in
//
//            self.lanCurrStackViewWidth.constant = 105
//            if(Configurations.isRTLMode()){
//                self.bgImgViewXPosition.constant = +(Application.screenSize.width / 2) - 60
//            }else{
//                self.bgImgViewXPosition.constant = -(Application.screenSize.width / 2) + 60
//            }
//
//            self.bgImgViewYPosition.constant = -(Application.screenSize.height / 2) + GeneralFunctions.getSafeAreaInsets().top + 35
//            self.bgImgViewWidth.constant = 85
//            self.bgImgViewHeight.constant = 85
//            UIView.animate(withDuration:1.0,
//                           delay: 0.0,
//                           usingSpringWithDamping: 0.8,
//                           initialSpringVelocity: 0.65,
//                           options: .transitionCrossDissolve,
//                 animations: {
//                    self.introSubLbl.alpha = 1.0
//                    self.langCurrStackView.alpha = 1.0
//                    self.loginRegisterStkView.alpha = 1.0
//                    self.imgSlideShow.alpha = 1.0
//                    self.view.layoutIfNeeded()
//
//                 }, completion: {
//                    //Code to run after animating
//
//                        (value: Bool) in
//
//
//                })
//        })
        
        
    }
    
    
    func setData(){

        currencyTxtField.disableMenu()
        currencyTxtField.getTextField()!.clearButtonMode = .never
        currencyTxtField.setEnable(isEnabled: false)
        
//        languageTxtField.allColor = SColors.ThemeTxt
        languageTxtField.disableMenu()
        languageTxtField.getTextField()!.clearButtonMode = .never
        languageTxtField.setEnable(isEnabled: false)
        
        languageTxtField.myTxtFieldDelegate = self
        currencyTxtField.myTxtFieldDelegate = self
        
        if (Configurations.isRTLMode() == true){
            self.languageTxtField.textPadding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
            self.currencyTxtField.textPadding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
        }else{
            self.languageTxtField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
            self.currencyTxtField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
        }
        
    }
    
   
    func setLabels(){
//        introLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INTRODUCTION")
        self.lngLbl.text = (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String).uppercased()
        self.currencyLbl.text = (GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String).uppercased()
        
        introSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PASSENGER_INTRO_DETAILS")
        introSubLbl.fit()
        
        self.signInBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOGIN"))
        self.registerBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGN_UP"))
        
        self.languageTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANGUAGE_TXT"))
        self.currencyTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Currency", key: "LBL_CURRENCY_TXT"))
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
    
    func myTxtFieldTapped(sender: MyTextField) {
        if(sender == self.languageTxtField){
            let openListView = OpenListView(uv: self, containerView: self.view)
            openListView.selectedItem = self.languageTxtField.text
            openListView.show(listObjects: languageNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LANGUAGE_HINT_TXT"), currentInst: openListView, handler: { (selectedItemId) in
                self.lngValueChanged(selectedItemId: selectedItemId)
            })
        }else if(sender == self.currencyTxtField){
            
            let openListView = OpenListView(uv: self, containerView: self.view)
            openListView.selectedItem = self.currencyTxtField.text
            openListView.show(listObjects: currenyList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CURRENCY"), currentInst: openListView, handler: { (selectedItemId) in
                self.currencyValueChanged(selectedItemId: selectedItemId)
            })
        }
    }
   
    func setLanguage(){
        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray
        self.languageArrCount = dataArr.count
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            
            self.colorArrayForLang.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextLang.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
            if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) == tempItem.get("vCode")){
                languageTxtField.setText(text: tempItem.get("vTitle").uppercased())
                self.selectedLngCode = tempItem.get("vCode")
                self.selectedLngColor = self.colorArrayForLang[i]
                self.selectedLngTxtColor = self.colorArrayForTextLang[i]
                
            }
            
            languageNameList.append(tempItem.get("vTitle"))
            languageCodes.append(tempItem.get("vCode"))
            
        }
        
        let LANGUAGE_OPTIONAL = GeneralFunctions.getValue(key: Utils.LANGUAGE_OPTIONAL_KEY)
        
        if(LANGUAGE_OPTIONAL != nil && (LANGUAGE_OPTIONAL as! String).uppercased() == "YES"){
            languageSelectView.isHidden = true
            self.lanCurrStackViewWidth.constant = 75
        }else{
            if(dataArr.count < 2){
                languageSelectView.isHidden = true
                self.lanCurrStackViewWidth.constant = 75
            }
        }
        
        setCurrency()
       
    }
    
    func lngValueChanged(selectedItemId:Int){
        self.selectedLngCode = self.languageCodes[selectedItemId]
        
        if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) != self.selectedLngCode){
            changeLanguage()
        }else{
            if(self.openListView != nil){
                self.openListView.bgView.isUserInteractionEnabled = true
                self.openListView.newListView.isUserInteractionEnabled = true
                self.openListView.startLoading = false
                self.openListView.newListView.tableView.reloadData()
                self.openListView.closeNewListView()
            }
        }
    }
    
    func changeLanguage(){
        
        //self.startBottomLoading()
        let parameters = ["type":"changelanguagelabel","vLang": self.selectedLngCode]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    //let window = UIApplication.shared.delegate!.window!
                    
                    
                    GeneralFunctions.saveValue(key: "APP_LAUNCH_IMAGES", value: dataDict.arrOf("APP_LAUNCH_IMAGES"))
                    
                    GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
                    
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_CODE_KEY, value: dataDict.get("vCode") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_IS_RTL_KEY, value: dataDict.get("eType") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY, value: dataDict.get("vTitle") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: dataDict.get("vGMapLangCode") as AnyObject)
                    GeneralFunctions.languageLabels = nil
                    Configurations.setAppLocal()
                    IQKeyboardManager.shared.toolbarDoneBarButtonItemText = (GeneralFunctions()).getLanguageLabel(origValue: "Done", key: "LBL_DONE")

                    // Watchapp changes
                    let lanDic = [Utils.LANGUAGE_CODE_KEY:GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String, Utils.LANGUAGE_IS_RTL_KEY:GeneralFunctions.getValue(key: Utils.LANGUAGE_IS_RTL_KEY)as! String, Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY:GeneralFunctions.getValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY)as! String, Utils.languageLabelsKey:GeneralFunctions.getValue(key: Utils.languageLabelsKey)!, Utils.DEFAULT_LANGUAGE_TITLE_KEY:GeneralFunctions.getValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY)!, Utils.DEFAULT_CURRENCY_TITLE_KEY:GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY)!, "LANCURRENCYCHANGED":"YES"] as [String : Any]
                    
                
                    
                    GeneralFunctions.sendUpdatToWatchApp(lanChanged: lanDic as NSDictionary)
                    // .....
                    
                    let appLoginUv = GeneralFunctions.instantiateViewController(pageName: "AppLoginUV") as! AppLoginUV
                    GeneralFunctions.changeRootViewController(window: Application.window!, viewController: appLoginUv)
                    

                    if(self.openListView != nil){
                        self.openListView.closeNewListView()
                    }

                    
                    //self.setLanguage()
                    self.perform(#selector(self.reloadScreen), with: self, afterDelay: 0.4)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
            if(self.openListView != nil && self.openListView.newListView != nil){
                self.openListView.bgView.isUserInteractionEnabled = true
                self.openListView.newListView.isUserInteractionEnabled = true
                self.openListView.startLoading = false
                self.openListView.newListView.tableView.reloadData()
            }
        })
    }
    
    @objc func reloadScreen(){
        
        self.isImageLoaded.removeAll()
        self.isViewRestarted = true
        let appLoginUv = GeneralFunctions.instantiateViewController(pageName: "AppLoginUV") as! AppLoginUV
        appLoginUv.isViewRestarted = self.isViewRestarted
         
        GeneralFunctions.changeRootViewController(window: Application.window!, viewController: appLoginUv)
        
    }
    
    func startBottomLoading(){
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        self.loginRegisterStkView.isHidden = true
        self.langCurrStackView.isHidden = true
        self.introSubLbl.isHidden = true
    }
    
    func setCurrency(){
        let dataArr = GeneralFunctions.getValue(key: Utils.CURRENCY_LIST_KEY) as! NSArray
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            
            self.colorArrayForCurr.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextCurr.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
            if((GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String) == tempItem.get("vName")){
                self.currencyTxtField.setText(text: tempItem.get("vName"))
                self.selectedCurrency = tempItem.get("vName")
                self.selectedCurrColor = self.colorArrayForCurr[i]
                self.selectedCurrTxtColor = self.colorArrayForTextCurr[i]
                
            }
            
//            currenyList += [tempItem.get("vName")]
            currenyList.append(tempItem.get("vName"))
            currencySymboles.append(tempItem.get("vSymbol"))
            
        }
        
        let CURRENCY_OPTIONAL = GeneralFunctions.getValue(key: Utils.CURRENCY_OPTIONAL_KEY)
        if(CURRENCY_OPTIONAL != nil && (CURRENCY_OPTIONAL as! String).uppercased() == "YES"){
            currencySelectView.isHidden = true
            self.lanCurrStackViewWidth.constant = 75
        }else{
            if(dataArr.count < 2){
                currencySelectView.isHidden = true
                self.lanCurrStackViewWidth.constant = 75
                
            }
        }
        
        let LANGUAGE_OPTIONAL = GeneralFunctions.getValue(key: Utils.LANGUAGE_OPTIONAL_KEY)
        
        
        
        if(CURRENCY_OPTIONAL != nil && (CURRENCY_OPTIONAL as! String).uppercased() == "YES" && LANGUAGE_OPTIONAL != nil && (LANGUAGE_OPTIONAL as! String).uppercased() == "YES"){
            //selectStackViewHeight.constant = 0
            //selectStackViewBottomMargin.constant = 0
            
            currencySelectView.isHidden = true
            languageSelectView.isHidden = true
            
        }
    }
    
    func currencyValueChanged(selectedItemId:Int){
        self.selectedCurrColor = self.colorArrayForCurr[selectedItemId]
        self.selectedCurrTxtColor = self.colorArrayForTextCurr[selectedItemId]
        self.selectedCurrency = self.currenyList[selectedItemId]
        self.currencyLbl.text = self.selectedCurrency.uppercased()
        self.currencyTxtField.setText(text: self.selectedCurrency.uppercased())
        GeneralFunctions.saveValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY, value: self.selectedCurrency as AnyObject)

        
        // Watchapp changes
        let lanDic = [Utils.LANGUAGE_CODE_KEY:GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String, Utils.LANGUAGE_IS_RTL_KEY:GeneralFunctions.getValue(key: Utils.LANGUAGE_IS_RTL_KEY)as! String, Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY:GeneralFunctions.getValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY)as! String, Utils.languageLabelsKey:GeneralFunctions.getValue(key: Utils.languageLabelsKey)!, Utils.DEFAULT_LANGUAGE_TITLE_KEY:GeneralFunctions.getValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY)!, Utils.DEFAULT_CURRENCY_TITLE_KEY:GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY)!, "LANCURRENCYCHANGED":"YES"] as [String : Any]
        
        GeneralFunctions.sendUpdatToWatchApp(lanChanged: lanDic as NSDictionary)
        // .....

    
        //self.currencyLbl.backgroundColor = self.selectedCurrColor
        //self.currencyLbl.textColor = self.selectedCurrTxtColor

    }

    func myBtnTapped(sender: MyButton) {
        
        UIView.animate(withDuration: 0.1,
            animations: {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    sender.transform = CGAffineTransform.identity
                }
            })

        
        self.isViewRestarted = true
        if(sender == signInBtn){
            self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignInUV"))
        }else if(sender == registerBtn){
            self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignUpUV"))
        }
    }
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        if(self.imageSlideShowPageController != nil){
            self.imageSlideShowPageController.numberOfPages = self.bannersItemList.count
        }
        
        return self.bannersItemList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let item = self.bannersItemList[index]
        var mainView:UIView!
        var imageView:UIImageView!
        var titleLbl:MyLabel!
        var subTitleLbl:MyLabel!
        let bottomView:UIView!
        
        
        mainView = UIView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.imgSlideShow.frame.height))
      
       let imgWidth = (Application.screenSize.width * 87) / 100
        
        imageView = UIImageView.init(frame: CGRect(x: 20, y:(41 + (self.langCurrStackView.frame.height + self.langCurrStackView.frame.origin.y)) , width: Application.screenSize.width - 40, height: Utils.getHeightOfBanner(widthOffset:  40, ratio: "4:3")))
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        imageView.tag = index
        //imageView.backgroundColor = UIColor.red
        
        mainView.addSubview(imageView)
        
       // print("CIMAge_FRMAe:\(imageView.frame)")
        
        
        bottomView = UIView.init(frame: CGRect(x: 0, y: (Utils.getHeightOfBanner(widthOffset:  40, ratio: "4:3") + self.langCurrStackView.frame.height + self.langCurrStackView.frame.origin.y) + 60 , width: Application.screenSize.width, height: Application.screenSize.height - imageView.frame.origin.y + imageView.frame.height + 15))
        bottomView.backgroundColor = UIColor.white
        
        titleLbl = MyLabel.init(frame: CGRect(x: 20, y: 30, width: Application.screenSize.width - 40, height: 60))
        
        
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont(name: Fonts().bold, size: 18)!
        titleLbl.fontFamilyWeight = "Bold"
        titleLbl.numberOfLines = 0
        titleLbl.setFontFamily()
        titleLbl.text = item.get("tTitle")
        titleLbl.sizeToFit()
        titleLbl.textColor = UIColor(hex: 0x1B2A3B)
        titleLbl.frame.origin.x = 20
        titleLbl.frame.size.width = imgWidth
        
       
        bottomView.addSubview(titleLbl)
        
        subTitleLbl = MyLabel.init(frame: CGRect(x: 20, y: titleLbl.frame.origin.y + titleLbl.frame.height + 10, width: Application.screenSize.width - 40, height: 65))
        
        

        
        subTitleLbl.textAlignment = .center
        subTitleLbl.font = UIFont(name: Fonts().regular, size: 16)!
        subTitleLbl.fontFamilyWeight = "Regular"
        subTitleLbl.numberOfLines = 0
        subTitleLbl.adjustsFontSizeToFitWidth = true
        subTitleLbl.minimumScaleFactor = 0.5
        subTitleLbl.setFontFamily()
        subTitleLbl.textColor = UIColor(hex: 0x707070)
        subTitleLbl.text = item.get("tSubtitle")
        if !(Configurations.isRTLMode()){
            subTitleLbl.sizeToFit()
        }
        subTitleLbl.frame.origin.x = 20
        subTitleLbl.frame.size.width = imgWidth
        subTitleLbl.layer.cornerRadius = 10
        subTitleLbl.clipsToBounds = true
        bottomView.addSubview(subTitleLbl)
        
  
        mainView.addSubview(bottomView)
        
        self.isImageLoaded.append(false)
        
        if(self.isImageLoaded.count > index && self.isImageLoaded[index] == false){
            let placeholderMarker = Placeholder()
            let viewElements: [UIView] = [

                imageView
            ]
            placeholderMarker.register(viewElements)
            placeholderMarker.startAnimation()
            
            self.placeHolderArry.append(placeholderMarker)
        }
        
        
       print(Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: Application.screenSize.width - 40), height: 0, MAX_HEIGHT: Utils.getValueInPixel(value: imageView.frame.height)))
        imageView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: 0, height: Utils.getValueInPixel(value: imageView.frame.height) , MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width - 40))), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in

            if(self.isImageLoaded.count > index){
                self.isImageLoaded[imageView.tag] = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if(self.placeHolderArry.count > imageView.tag){
                    self.placeHolderArry[imageView.tag].remove()
                }
                
                
            }
            
            
        })
       
        return mainView
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if(self.imageSlideShowPageController != nil){
            self.imageSlideShowPageController.currentPage = carousel.currentItemIndex
        }
    }

    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        
        pageControl1.setPage(carousel.currentItemIndex)
        
        let item = self.bannersItemList[carousel.currentItemIndex]
        
       // carousel.contentView.backgroundColor = UIColor.init(hexString: item.get("vBGColor"), alpha: 1)
       
        GeneralFunctions.saveValue(key: "LOGIN_BANNER_BG_COLOR", value: item.get("vBGColor") as AnyObject)
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0).dark(by: 15) ?? UIColor.black
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           // This will animate the page controll transition, whenever the index is changed, no need to pass an offset of every scroll offset

      }
    

}
