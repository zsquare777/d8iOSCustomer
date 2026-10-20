

import UIKit
import CoreLocation
import SysBaseLib
import LiveChat

struct Headline {
    
    var title : String
    var image : String
    var id    : String
    var attributedTitle: NSMutableAttributedString
    var rightSideImage:String
}

class ViewProfileUV: ParentViewUV, MyLabelClickDelegate, UITableViewDelegate, UITableViewDataSource, LiveChatDelegate, ParentViewUVDelegate {
    
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profilePicViewArea: UIView!
    @IBOutlet weak var editPicAreaView: UIView!
    @IBOutlet weak var placesSeperatorView: UIView!
    
    @IBOutlet weak var userProfilePicBgView: UIView!
    @IBOutlet weak var userProfilePicBgImgView: UIImageView!
    @IBOutlet weak var usrProfileImgView: UIImageView!
    @IBOutlet weak var fNameTxtField: MyTextField!
    @IBOutlet weak var lNameTxtField: MyTextField!
    @IBOutlet weak var emailTxtField: MyTextField!
    //    @IBOutlet weak var countryTxtField: MyTextField!
    @IBOutlet weak var mobileTxtField: MyTextField!
    @IBOutlet weak var languageTxtField: MyTextField!
    @IBOutlet weak var currencyTxtField: MyTextField!
    @IBOutlet weak var langTxtFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var currencyTxtFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var placeAreaTopMargin: NSLayoutConstraint!
    @IBOutlet weak var editIconImgView: UIImageView!
    
    @IBOutlet weak var placesHLbl: MyLabel!
    @IBOutlet weak var workLocContainerView: UIView!
    @IBOutlet weak var homeLocContainerView: UIView!
    @IBOutlet weak var homeLocImgView: UIImageView!
    @IBOutlet weak var homeLocVLbl: MyLabel!
    @IBOutlet weak var homeLocHLbl: MyLabel!
    @IBOutlet weak var homeLoceditImgContainerView: UIView!
    @IBOutlet weak var homeLocEditImgView: UIImageView!
    @IBOutlet weak var placesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var placesContainerView: UIView!
    
    @IBOutlet weak var bottomHeaderTop: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var workLocVLbl: MyLabel!
    @IBOutlet weak var workLocHLbl: MyLabel!
    @IBOutlet weak var workLocImgView: UIImageView!
    @IBOutlet weak var workLoceditImgContainerView: UIView!
    @IBOutlet weak var workLocEditImgView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTopBgView: UIView!
    @IBOutlet weak var profileHeaderImgView: UIImageView!
    @IBOutlet weak var nameHeaderLbl: MyLabel!
    @IBOutlet weak var emailHeaderLbl: MyLabel!
    @IBOutlet weak var singinHeaderLbl: MyLabel!

    @IBOutlet weak var walletBHLbl: MyLabel!
    @IBOutlet weak var walletBVLbl: MyLabel!
    @IBOutlet weak var headerBtnView1: UIView!
    @IBOutlet weak var headerBtnView2: UIView!
    @IBOutlet weak var headerBtnView3: UIView!
    @IBOutlet weak var headerBtnView4: UIView!
    @IBOutlet weak var btn1ImgView: UIImageView!
    @IBOutlet weak var btn1VLbl: MyLabel!
    @IBOutlet weak var btn2ImgView: UIImageView!
    @IBOutlet weak var btn2VLbl: MyLabel!
    @IBOutlet weak var btn3ImgView: UIImageView!
    @IBOutlet weak var btn3VLbl: MyLabel!
    @IBOutlet weak var btn4ImgView: UIImageView!
    @IBOutlet weak var btn4VLbl: MyLabel!
    @IBOutlet weak var topBottomView: UIView!
    @IBOutlet weak var topHeaderViewBGHeight: NSLayoutConstraint!  // default 175

    //GenderView related OutLets
    @IBOutlet weak var genderVCloseImgView: UIImageView!
    @IBOutlet weak var genderHLbl: MyLabel!
    @IBOutlet weak var maleImgView: UIImageView!
    @IBOutlet weak var femaleImgView: UIImageView!
    @IBOutlet weak var maleLbl: MyLabel!
    @IBOutlet weak var femaleLbl: MyLabel!
    
    @IBOutlet weak var Email_Verify_ImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    var languageNameList = [String]()
    var languageCodes = [String]()
    var currenyList = [String]()
    var selectedCurrency = ""
    var selectedLngCode = ""
    
    var colorArrayForLang = [UIColor]()
    var colorArrayForCurr = [UIColor]()
    
    var colorArrayForTextLang = [UIColor]()
    var colorArrayForTextCurr = [UIColor]()
    
    var selectedLngColor = UIColor()
    var selectedCurrColor = UIColor()
    
    var selectedLngTxtColor = UIColor()
    var selectedCurrTxtColor = UIColor()
    
    var currencySymboles = [String]()
    var openListView:OpenListView!
    
    
    var tableHeaderView:UIView!
    let generalFunc = GeneralFunctions()
    var containerViewHeight:CGFloat = 0

    
    var isFirstLaunch = true
    var cntView:UIView!
    
    var PAGE_HEIGHT:CGFloat = 610
    
    var homeLoc:CLLocation!
    var workLoc:CLLocation!
    
    var numaberOfSection = 8
    
    var chatLicenseID = ""
    
    var rightButton: UIBarButtonItem!
    
    var finalDataArray = NSMutableArray()
    var navView:UIView!
    var userProfileJson:NSDictionary!
    
    var MY_BOOKINGS = "0"
    var BUSINESS_PROFILE = "1"
    var MY_CART = "2"
    var NOTIFICATIONS = "3"
    var FAV_DRIVER = "4"
    var INVITE_FRIEND = "5"
    var EMERGENCY_CONTACT = "6"
    var VERIFY_MOBILE = "7"
    var VERIFY_EMAIL = "8"
    var PERSONAL_DETAILS = "9"
    var CHANGE_PASSWORD = "10"
    var CHANGE_CURRENCY = "11"
    var CHANGE_LANGUAGE = "12"
    var PAYMENT_METHOD = "13"
    var MY_WALLET = "14"
    var ADD_MONEY = "15"
    var SEND_MONEY = "16"
    var ABOUT_US = "17"
    var PRIVACY_POLICY = "18"
    var TERMS_CONDITION = "19"
    var FAQ = "20"
    var LIVE_CHAT = "21"
    var CONTACT_US = "22"
    var HOME_PLACE = "23"
    var WORK_PLACE = "24"
    var LOG_OUT = "25"
    var MENU_DONATION = "26"
    var SMART_LOGIN = "27"
    var SEND_GIFT = "28"
    var REDEEM_GIFT = "29"
    var RENT_ITEM_ADD = "30"
    var RENT_ITEM_POST = "31"
    var RENT_ITEM_FIND = "32"
    var REAL_ESTATE_ADD = "33"
    var REAL_ESTATE_POST = "34"
    var REAL_ESTATE_FIND = "35"
    var RENT_CAR_ADD = "36"
    var RENT_CAR_POST = "37"
    var RENT_CAR_FIND = "38"
    
    var homeTabBar:HomeScreenTabBarUV!
    var navTitleView:UIView!
    var navAlpha:CGFloat = 0
    var tableViewLastCntOffset:CGPoint!
    var APPSTORE_MODE_IOS:AnyObject?
    
    var isAddBackButton = false
    
    var genderView:UIView!
    var veriFy:UIView!
    var headerTitle = [String]()
    
   
    public var openImgSelection:OpenFileSelector!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.openImgSelection = OpenFileSelector(uv: self)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.chatLicenseID = userProfileJson.get("LIVE_CHAT_LICENCE_NUMBER") /* Live Chat Settings .*/
            
    //        if(userProfileJson.get("APP_TYPE").uppercased() == Utils.cabGeneralType_Ride.uppercased()){
    //
    //            cntView = self.generalFunc.loadView(nibName: "ViewProfileScreenDesign", uv: self, contentView: scrollView)
    //
    //            APPSTORE_MODE_IOS = GeneralFunctions.getValue(key: Utils.APPSTORE_MODE_IOS_KEY)
    //
    //            self.scrollView.addSubview(cntView)
    //            self.scrollView.bounces = false
    //
    //            setContentSize()
    //
    //            setData()
    //
    //        }else{
                cntView = self.generalFunc.loadView(nibName: "ViewProfileScreenDesign", uv: self, contentView: contentView)
                
                self.contentView.addSubview(cntView)
                self.scrollView.bounces = false
                self.scrollView.isHidden = true
                setLanguage()
                self.scrollViewContentView.isHidden = true
                
         //   }
            
            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
            blurEffectView.frame = userProfilePicBgView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.userProfilePicBgView.addSubview(blurEffectView)
            
            self.placesSeperatorView.backgroundColor = SColors.Theme
            
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
        }else if(type == 1){
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
    //        if(userProfileJson.get("APP_TYPE").uppercased() != Utils.cabGeneralType_Ride.uppercased()){
    //            self.navigationController?.navigationBar.layer.zPosition = -1
    //        }
            self.configRTL()
            
            if(isAddBackButton){
                self.addBack()
            }
            
        }else if(type == 2){
            if(GeneralFunctions.getMemberd() != "") {
                self.updateWalletAmount()
            }
            self.setNavItems()
            
            self.tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom - 15) : 20), right: 0)
            

            self.shadowView.createShadow(color: UIColor.black, opacity: 1.0, offSet: CGSize(width: 0.5, height: 1.0), radius: 1.8, scale: false)
        }else if(type == 3){
            //if(userProfileJson.get("APP_TYPE").uppercased() != Utils.cabGeneralType_Ride.uppercased()){
                self.navAlpha = self.navTitleView.alpha
                self.tableView.reloadData()
                if(self.homeTabBar != nil){
                    self.homeTabBar.navItem.titleView = nil
                }else{
                    self.navigationItem.titleView = nil
                }
                
          //  }
            
        }
    }
    

    func setNavItems(){
        navTitleView = generalFunc.loadView(nibName: "ProfileTitleView", uv: self, isWithOutSize: true)
        navTitleView.frame = CGRect(x: 0, y:0, width: Application.screenSize.width, height: 50)
        navTitleView.backgroundColor = UIColor.clear
        (navTitleView.subviews[1] as! MyLabel).text = GeneralFunctions.getMemberd() == "" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WELCOME_BACK"):userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
        (navTitleView.subviews[1] as! MyLabel).textColor = SColors.ThemeTxt
        (navTitleView.subviews[0] as! UIImageView).sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        
        var image = UIImage(named: "ic_pf_edit")!
        if(self.userProfileJson.get("eGender") == "" && ServiceModule.isDeliverAllOnly() == false &&  self.userProfileJson.get("FEMALE_RIDE_REQ_ENABLE").uppercased() == "YES"){
            image = UIImage(named: "ic_settings")!
        }else{
            image = UIImage(named: "ic_pf_edit")!
        }
        
        let rightButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.settingIcTapped))
        
        if self.homeTabBar != nil {
            
            self.navTitleView.alpha = navAlpha
            if(GeneralFunctions.getMemberd() != ""){
                self.homeTabBar.navItem.rightBarButtonItem = rightButton
            }
            
        }else {
            let rightButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.settingIcTapped))
            if(GeneralFunctions.getMemberd() != ""){
                self.navigationItem.rightBarButtonItem = rightButton
            }
            
        }
        
        if(isFirstLaunch == true){
            self.setTableView()
            isFirstLaunch = false
        }
        
        self.topBottomView.layer.addShadow(opacity: 0.4, radius: 1, UIColor.lightGray)
        self.topBottomView.layer.roundCorners(radius: 14)
        setTableData()
    }
    
    @objc func settingIcTapped(){
           
           if(self.userProfileJson.get("eGender") == "" && ServiceModule.isDeliverAllOnly() == false &&  self.userProfileJson.get("FEMALE_RIDE_REQ_ENABLE").uppercased() == "YES"){
               openGenderView()
           }else{
               self.editProfileTappedNavigation()
           }
           
       }
    
//    @objc func settingIcTapped(){
//
//        if(self.userProfileJson.get("IS_RIDE_MODULE_AVAIL").uppercased() == "YES"){
//            openGenderView()
//        }else{
//            self.editProfileTapped()
//        }
//
//    }
    
    func setContentSize(){
        cntView.frame.size = CGSize(width: cntView.frame.width, height: PAGE_HEIGHT)
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y > 0){
            self.shadowView.isHidden = false
        }else{
            self.shadowView.isHidden = true
        }
        
        if(scrollView.contentOffset.y >= 80){
            UIView.animate(withDuration: 0.15, animations: {
                
                if(self.homeTabBar != nil){
                    self.homeTabBar.navItem.titleView = self.navTitleView
                }
               
                self.navTitleView.alpha = 1
                
            })
        }else{
            UIView.animate(withDuration: 0.15, animations: {
                self.navTitleView.alpha = 0
                
            })
        }
        
    }
    
    @objc func editProfileTapped(){
        if userProfileJson.get("ENABLE_ACCOUNT_DELETION").uppercased() == "YES" {
            let uv = GeneralFunctions.instantiateViewController(pageName: "ManageAccountUV") as! ManageAccountUV
            self.push(uv: uv)
        }else{
        let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
        self.push(uv: uv)
        }
    }
    @objc func editProfileTappedNavigation(){
        let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
        self.push(uv: uv)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyTabBarBottomInset()
    }

    private func applyTabBarBottomInset() {
        guard let tableView = self.tableView, let window = view.window else { return }

        var overlap: CGFloat = 0
        if let tabBar = homeTabBar?.tabBar ?? tabBarController?.tabBar, !tabBar.isHidden {
            let tabFrame   = tabBar.convert(tabBar.bounds, to: window)
            let tableFrame = tableView.convert(tableView.bounds, to: window)
            overlap = max(0, tableFrame.maxY - tabFrame.minY)
        }

        let bottom = overlap
        if tableView.contentInset.bottom != bottom {
            tableView.contentInset.bottom = bottom
            tableView.verticalScrollIndicatorInsets.bottom = bottom
        }
    }
    
    func setTableView() {
        
        selectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        selectedLngCode = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        print(selectedLngCode)
        
        self.tableView.register(UINib(nibName: "ProfileTVCell", bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
        
  //      self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        self.tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {}
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor(hex: 0xf1f1f1)
        tableHeaderView = self.generalFunc.loadView(nibName: "ProfileHeaderView", uv: self, isWithOutSize: true)
        tableHeaderView.backgroundColor = UIColor(hex: 0xf1f1f1)
        
        tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 250)
        self.headerTopBgView.backgroundColor = SColors.Theme
        self.headerTopBgView.layer.shadowColor = UIColor.lightGray.cgColor
        self.headerTopBgView.layer.shadowOpacity = 0.6
        self.headerTopBgView.layer.shadowOffset = CGSize.zero
        self.headerTopBgView.layer.shadowRadius = 3
         singinHeaderLbl.isHidden = true
        if GeneralFunctions.getMemberd() == "" {
            singinHeaderLbl.isHidden = false
            topBottomView.isHidden = true
            topHeaderViewBGHeight.constant = 100
            singinHeaderLbl.paddingLeft = 10
            singinHeaderLbl.paddingRight = 10
            
            singinHeaderLbl.cornerRadius = 5
            singinHeaderLbl.borderColor = .white
            singinHeaderLbl.borderWidth = 1
            singinHeaderLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGN_IN_SIGN_IN_TXT") + " /  " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SIGNUP_SIGNUP")
            singinHeaderLbl.font = UIFont(name: Fonts().regular, size: 17)
            tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 100)
            self.nameHeaderLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WELCOME_BACK")
            singinHeaderLbl.setClickHandler { (MyLabel) in
                self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignInUV"))
            }
        }
        
        self.tableView.tableHeaderView = tableHeaderView
        self.btn1VLbl.text = ServiceModule.isDeliverAllOnly() ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_ORDERS") : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOKING")
        self.btn2VLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_TXT")
        self.btn3VLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TOP_UP")
        self.btn4VLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE")
        
        self.btn1ImgView.image = UIImage(named: "ic_pf_top_bookings")
        self.btn2ImgView.image = UIImage(named: "ic_pf_top_wallet")
        self.btn3ImgView.image = UIImage(named: "ic_pf_top_wallettopup")
        self.btn4ImgView.image = UIImage(named: "ic_pf_top_Invite")
        
        let REFERRAL_SCHEME_ENABLE = userProfileJson.get("REFERRAL_SCHEME_ENABLE")
        if(REFERRAL_SCHEME_ENABLE.uppercased() != "YES"){
            self.headerBtnView4.isHidden = true
        }
        let WALLET_ENABLE = userProfileJson.get("WALLET_ENABLE")
        if(WALLET_ENABLE.uppercased() != "YES"){
            self.headerBtnView3.isHidden = true
            self.headerBtnView2.isHidden = true
        }
        
        if(self.userProfileJson.get("APP_PAYMENT_MODE").uppercased() == "CASH"){
            self.headerBtnView3.isHidden = true
        } else {
            self.headerBtnView3.isHidden = false
        }
        
        self.btn1ImgView.handleClick { (instance) in
            self.tableViewLastCntOffset = self.tableView.contentOffset
            self.openBookings()
        }
        
        self.btn2ImgView.handleClick { (instance) in
            self.tableViewLastCntOffset = self.tableView.contentOffset
            self.openMyWallet()
        }
        self.btn3ImgView.handleClick { (instance) in
            self.tableViewLastCntOffset = self.tableView.contentOffset
            self.openMyWallet(true, false)
        }
        self.btn4ImgView.handleClick { (instance) in
            self.tableViewLastCntOffset = self.tableView.contentOffset
            self.openInviteFriends()
        }
    }
    
    func setTableData() {
        self.finalDataArray.removeAllObjects()
        self.profileHeaderImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
        self.emailHeaderLbl.text = ""
        //let vCode = (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String)
        if GeneralFunctions.getMemberd() != "" {
            self.nameHeaderLbl.text = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
            
            if userProfileJson.get("vEmail").trim() != ""{
                self.bottomHeaderTop.constant = 98
                tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 260)
                if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S){
                  self.emailHeaderLbl.font = UIFont(name: Fonts().regular, size: 12)!
                }else{
                    self.emailHeaderLbl.font = UIFont(name: Fonts().regular, size: 13)!
                }
                
                self.emailHeaderLbl.text = userProfileJson.get("vEmail") + "\n" +  "(+" + userProfileJson.get("vPhoneCode")  + ")" + userProfileJson.get("vPhone")
            }else{
                self.bottomHeaderTop.constant = 88
                tableHeaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 250)
                self.emailHeaderLbl.text = "(+" + userProfileJson.get("vPhoneCode")  + ")" + userProfileJson.get("vPhone")
            }
        }
        self.tableView.tableHeaderView = tableHeaderView
        self.nameHeaderLbl.textColor = SColors.ThemeTxt
        self.emailHeaderLbl.textColor = SColors.ThemeTxt
        
        self.walletBHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_BALANCE")
        self.walletBVLbl.text = Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)
        self.walletBVLbl.textColor = SColors.Theme
        if((userProfileJson.get("eEmailVerified").uppercased() != "YES" && userProfileJson.get("RIDER_EMAIL_VERIFICATION").uppercased() == "YES")){
            self.Email_Verify_ImageView.isHidden = false
            self.Email_Verify_ImageView.handleClick { (instance) in
            self.openVerifyView()
            }
        }else{
            
           self.Email_Verify_ImageView.isHidden = true
        }
        
        
        headerTitle.removeAll()
        for i in 0..<numaberOfSection{
            var sectionDataArray = [Headline]()
            if(i == 0) {
                sectionDataArray = generalSettingSectionRows()
                headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENERAL_SETTING"))
            }else if(i == 1) {
                if userProfileJson.get("ENABLE_RENT_ITEM_SERVICES").uppercased() == "YES" || userProfileJson.get("ENABLE_RENT_ESTATE_SERVICES").uppercased() == "YES" || userProfileJson.get("ENABLE_RENT_CARS_SERVICES").uppercased() == "YES" {
                    headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "Buy, Sell & Cars", key: "LBL_RENT_BUY_SELL_CARS"))
                    sectionDataArray = generalRentData()
                }else{
                    continue
                }
                
            }else if(i == 2){
                sectionDataArray = self.accountSectionRows()
                headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_SETTING"))
            }else if(i == 3){
                if(GeneralFunctions.getMemberd() != ""){
                    headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT"))
                    sectionDataArray = self.paymentSectionRows()
                }else{
                    continue
                }
                
            }else if(i == 4){
                
                if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_GIFT_CARD_FEATURE") && (GeneralFunctions.getValue(key: "ENABLE_GIFT_CARD_FEATURE") as! String).uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
                    sectionDataArray = self.giftCardSectionRows()
                    
                    headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_TXT"))
                }else{
                    continue
                }
                
                
            }else if(i == 5){
                if(GeneralFunctions.getMemberd() != ""){
                    headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAV_LOCATIONS"))
                    sectionDataArray = favLocationSectionRows()
                }else{
                    continue
                }
                
            }else if(i == 6){
                headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUPPORT"))
                sectionDataArray = self.supportSectionRows()
            }else{
                if(GeneralFunctions.getMemberd() != ""){
                    headerTitle.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT"))
                    let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOGOUT"), image: "ic_pf_logout", id: LOG_OUT, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                    sectionDataArray.append(dataArray1)
                }else{
                    continue
                }
                
            }
            self.finalDataArray.add(sectionDataArray)
        }
        
        self.tableView.reloadData()
        if(self.tableViewLastCntOffset != nil){
            self.tableView.setContentOffset(self.tableViewLastCntOffset, animated: false)
        }

    }
    func generalRentData()  ->[Headline] {
        var sectionDataArray = [Headline]()
      
       
        if(userProfileJson.get("ENABLE_RENT_ITEM_SERVICES").uppercased() == "YES") {
        let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "Your General Items Listing", key: "LBL_RENT_GENERAL_ITEM_LISTING"), image: "ic_pf_buySell", id: RENT_ITEM_POST, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray2)
        }
        if(userProfileJson.get("ENABLE_RENT_ESTATE_SERVICES").uppercased() == "YES"){
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "Your Properties Listing", key: "LBL_RENT_PROPERTY_LISTING"), image: "ic_pf_realEstate", id: REAL_ESTATE_POST, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }
        if(userProfileJson.get("ENABLE_RENT_CARS_SERVICES").uppercased() == "YES") {
        let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "Your Car Listing", key: "LBL_RENT_CARS_LISTING"), image: "ic_pf_car", id: RENT_CAR_POST, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray2)
        }


        
        return sectionDataArray
    }
    
        
    
    func generalSettingSectionRows()  ->[Headline] {
        var sectionDataArray = [Headline]()
      
        let dataArray1 = Headline.init(title:ServiceModule.isDeliverAllOnly() == false ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_BOOKINGS") : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_ORDERS"), image: "ic_pf_bookings", id: MY_BOOKINGS, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray1)
        if(userProfileJson.get("ENABLE_CORPORATE_PROFILE").uppercased() == "YES"){
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BUSINESS_PROFILE"), image: "ic_pf_busi_pro", id: BUSINESS_PROFILE, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }
        
        if(ServiceModule.isDeliverAllOnly() == false){
            
            if(ServiceModule.deliverallM){
                if(ServiceModule.isAnyDeliverAllOptionEnable()){
                    let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_CART"), image: "ic_my_cart", id: MY_CART, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                    sectionDataArray.append(dataArray5)
                }
            }
            
            
            if (userProfileJson.get("ENABLE_NEWS_SECTION").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
                let dataArray4 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFICATIONS"), image: "ic_pf_notification", id: NOTIFICATIONS, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray4)
            }
        }else{
            
            if(ServiceModule.isAnyDeliverAllOptionEnable()){
                let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_CART"), image: "ic_my_cart", id: MY_CART, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray5)
            }
            
            if (userProfileJson.get("ENABLE_NEWS_SECTION").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
                let dataArray4 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFICATIONS"), image: "ic_pf_notification", id: NOTIFICATIONS, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray4)
            }
          
        }
        
        
        if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
            
            if(ServiceModule.ufxM || ServiceModule.biddingM || ServiceModule.vcM){
                let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAV_PROVIDER"), image: "ic_pf_favdriver", id: FAV_DRIVER, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray5)
            }else{
                
                if(ServiceModule.isRideOnly() || ServiceModule.isDeliveryOnly() || ServiceModule.isRideDeliveryOnly()){
                    let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAV_DRIVER"), image: "ic_pf_favdriver", id: FAV_DRIVER, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                    sectionDataArray.append(dataArray5)
                }else{
                    let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAV_DRIVERS_TITLE_TXT"), image: "ic_pf_favdriver", id: FAV_DRIVER, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                    sectionDataArray.append(dataArray5)
                }
                
            }
            
        }
        let REFERRAL_SCHEME_ENABLE = userProfileJson.get("REFERRAL_SCHEME_ENABLE")
        if(REFERRAL_SCHEME_ENABLE.uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
            let dataArray6 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_TXT"), image: "ic_pf_Invite", id: INVITE_FRIEND, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray6)
        }
        
        if(GeneralFunctions.getMemberd() != "" && ServiceModule.isDeliverAllOnly() == false){
            let dataArray7 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT"), image: "ic_pf_emr_contact", id: EMERGENCY_CONTACT, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray7)
        }
        
        if (userProfileJson.get("DONATION_ENABLE").uppercased() == "YES" && GeneralFunctions.getMemberd() != "") //&& userProfileJson.get("APP_TYPE").uppercased() != Utils.cabGeneralType_Ride_Delivery_UberX.uppercased())
        {
            let dataArray8 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONATE"), image: "ic_pf_donation", id: MENU_DONATION, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray8)
        }
        return sectionDataArray
    }
    
    
    func favLocationSectionRows () ->[Headline] {
        var sectionDataArray = [Headline]()
        let userHomeLocationAddress = GeneralFunctions.getValue(key: "userHomeLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userHomeLocationAddress") as! String) : ""
        let userWorkLocationAddress = GeneralFunctions.getValue(key: "userWorkLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userWorkLocationAddress") as! String) : ""
        
        if(userHomeLocationAddress != ""){
            let finalStr = NSMutableAttributedString.init(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PLACE") + "\n")
            
            let attributedTitleString = NSMutableAttributedString(string:(GeneralFunctions.getValue(key: "userHomeLocationAddress") as? String ?? ""))
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 13)]
            attributedTitleString.addAttributes(yourOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedTitleString.length))
            finalStr.append(attributedTitleString)
            
            
            let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PLACE"), image: "ic_pf_home", id: HOME_PLACE, attributedTitle: finalStr, rightSideImage: "")
            sectionDataArray.append(dataArray1)
        }else{
            let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_HOME_PLACE_TXT"), image: "ic_pf_home", id: HOME_PLACE, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray1)
        }
        
        if(userWorkLocationAddress != ""){
            let finalStr = NSMutableAttributedString.init(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORK_PLACE") + "\n")
            
            let attributedTitleString = NSMutableAttributedString(string:(GeneralFunctions.getValue(key: "userWorkLocationAddress") as? String ?? ""))
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 13)]
            attributedTitleString.addAttributes(yourOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedTitleString.length))
            finalStr.append(attributedTitleString)
            
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORK_PLACE"), image: "ic_pf_work", id: WORK_PLACE, attributedTitle: finalStr, rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }else{
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_WORK_PLACE_TXT"), image: "ic_pf_work", id: WORK_PLACE, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }
        return sectionDataArray
    }
    
    func giftCardSectionRows () ->[Headline] {
        
        var sectionDataArray = [Headline]()
        let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_SEND_TXT"), image: "ic_send_gift", id: SEND_GIFT, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray1)
        
        let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_REDEEM_GIFT_CARD_TXT"), image: "ic_redeem_gift", id: REDEEM_GIFT, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray2)
        
        return sectionDataArray
    }
    
    func paymentSectionRows () ->[Headline] {
        var sectionDataArray = [Headline]()
        
        let APP_PAYMENT_MODE = userProfileJson.get("APP_PAYMENT_MODE")
        if self.userProfileJson.get("CARD_SAVE_ENABLE").uppercased() == "YES" {
            let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_METHOD"), image: "ic_pf_payment_method", id: PAYMENT_METHOD, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray1)
        }
        
        let WALLET_ENABLE = userProfileJson.get("WALLET_ENABLE")
        if(WALLET_ENABLE.uppercased() == "YES"){
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MY_WALLET"), image: "ic_pf_wallet", id: MY_WALLET, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
            if(userProfileJson.get("APP_PAYMENT_MODE").uppercased() != "CASH"){
                let dataArray3 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY"), image: "ic_pf_wallettopup", id: ADD_MONEY, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray3)
            }
            if(userProfileJson.get("ENABLE_GOPAY").uppercased() == "YES"){
                let dataArray4 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY"), image: "ic_pf_wallet_send", id: SEND_MONEY, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray4)
            }
            
        }
        return sectionDataArray
    }
    
    func accountSectionRows() ->[Headline] {
        var sectionDataArray = [Headline]()
        if GeneralFunctions.getMemberd() != "" {
            
            if userProfileJson.get("isSmartLoginEnable").uppercased() == "YES" {
            if(GeneralFunctions.isDeviceAuthenticationEnableForQuickLogin()){
               
                let dataArray11 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN"), image: "ic_pf_finger-print", id: SMART_LOGIN, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray11)
               
            }
            }
            if (userProfileJson.get("ePhoneVerified").uppercased() != "YES" && userProfileJson.get("RIDER_PHONE_VERIFICATION").uppercased() == "YES") {
                let dataArray11 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_VERIFY"), image: "ic_pf_phonevery", id: VERIFY_MOBILE, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray11)
            }
            if((userProfileJson.get("eEmailVerified").uppercased() != "YES" && userProfileJson.get("RIDER_EMAIL_VERIFICATION").uppercased() == "YES")) {
                let dataArray12 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_VERIFY"), image: "ic_pf_emailvery", id: VERIFY_EMAIL, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
                sectionDataArray.append(dataArray12)
            }
            var manageAccountLbl = ""
            if userProfileJson.get("ENABLE_ACCOUNT_DELETION").uppercased() == "YES" {
                manageAccountLbl = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MANAGE_ACCOUNT_TXT")
            }else{
                manageAccountLbl = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PERSONAL_DETAILS")
            }
            let dataArray1 = Headline.init(title:manageAccountLbl , image: "ic_pf_personaldetails", id: PERSONAL_DETAILS, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray1)
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_PASSWORD_TXT"), image: "ic_pf_change_password", id: CHANGE_PASSWORD, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }
        let dataCurrecny = GeneralFunctions.getValue(key: Utils.CURRENCY_LIST_KEY) as! NSArray
        if dataCurrecny.count > 1 {
            let dataArray3 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_CURRENCY"), image: "ic_pf_change_currency", id: CHANGE_CURRENCY, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray3)
        }
        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray
        
        if dataArr.count > 1{
            let dataArray4 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_LANGUAGE"), image: "ic_pf_change_location", id: CHANGE_LANGUAGE, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray4)
        }
        
        return sectionDataArray
    }
    
    func supportSectionRows()->[Headline] {
        var sectionDataArray = [Headline]()
        
        if(userProfileJson.get("showAboutUs").uppercased() == "YES"){
            let dataArray1 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT_US_TXT"), image: "ic_pf_aboutus", id: ABOUT_US, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray1)
        }
        
        if(userProfileJson.get("showPrivacyPolicy").uppercased() == "YES"){
            let dataArray2 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT"), image: "ic_pf_privacy", id: PRIVACY_POLICY, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray2)
        }
        
        if(userProfileJson.get("showTermsCondition").uppercased() == "YES"){
            let dataArray3 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION"), image: "ic_pf_terms", id: TERMS_CONDITION, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray3)
        }
        
        
        let dataArray4 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAQ_TXT"), image: "ic_pf_faq", id: FAQ, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray4)
        
        if(userProfileJson.get("ENABLE_LIVE_CHAT").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
            self.configLiveChat()
            let dataArray5 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LIVE_CHAT"), image: "ic_pf_livechat", id: LIVE_CHAT, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
            sectionDataArray.append(dataArray5)
        }
        
        let dataArray6 = Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), image: "ic_pf_contactus", id: CONTACT_US, attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: "")
        sectionDataArray.append(dataArray6)
        return sectionDataArray
    }
    
    
    func setData() {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROFILE_TITLE_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROFILE_TITLE_TXT")
        fNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIRST_NAME_HEADER_TXT"))
        lNameTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LAST_NAME_HEADER_TXT"))
        emailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_LBL_TXT"))
        //        countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
        mobileTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
        languageTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANGUAGE_TXT"))
        currencyTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CURRENCY_TXT"))
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        fNameTxtField.setText(text: userProfileJson.get("vName"))
        lNameTxtField.setText(text: userProfileJson.get("vLastName"))
        emailTxtField.setText(text: userProfileJson.get("vEmail"))
        //        countryTxtField.setText(text: userProfileJson.get("vPhoneCode"))
        mobileTxtField.setText(text: "+\(userProfileJson.get("vPhoneCode"))\(userProfileJson.get("vPhone"))")
        languageTxtField.setText(text: userProfileJson.get("vName"))
        currencyTxtField.setText(text: userProfileJson.get("vCurrencyPassenger"))
        
        fNameTxtField.setEnable(isEnabled: false)
        lNameTxtField.setEnable(isEnabled: false)
        emailTxtField.setEnable(isEnabled: false)
        //        countryTxtField.setEnable(isEnabled: false)
        mobileTxtField.setEnable(isEnabled: false)
        languageTxtField.setEnable(isEnabled: false)
        currencyTxtField.setEnable(isEnabled: false)
        
        fNameTxtField.configDivider(isDividerEnabled: false)
        lNameTxtField.configDivider(isDividerEnabled: false)
        emailTxtField.configDivider(isDividerEnabled: false)
        //        countryTxtField.configDivider(isDividerEnabled: false)
        mobileTxtField.configDivider(isDividerEnabled: false)
        languageTxtField.configDivider(isDividerEnabled: false)
        currencyTxtField.configDivider(isDividerEnabled: false)
        
        fNameTxtField.configHighlighted(isHighLightedEnabled: true)
        lNameTxtField.configHighlighted(isHighLightedEnabled: true)
        emailTxtField.configHighlighted(isHighLightedEnabled: true)
        //        countryTxtField.configHighlighted(isHighLightedEnabled: true)
        mobileTxtField.configHighlighted(isHighLightedEnabled: true)
        languageTxtField.configHighlighted(isHighLightedEnabled: true)
        currencyTxtField.configHighlighted(isHighLightedEnabled: true)
        
        
        userProfilePicBgImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
        usrProfileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        Utils.createRoundedView(view: usrProfileImgView, borderColor: SColors.Theme, borderWidth: 2)
        setLanguage()
        
        editPicAreaView.backgroundColor = SColors.Theme
        Utils.createRoundedView(view: editPicAreaView, borderColor: UIColor.clear, borderWidth: 0)
        
        if(userProfileJson.get("vImgName").trim() == ""){
            editIconImgView.image = UIImage(named: "ic_plus")
        }
        
        GeneralFunctions.setImgTintColor(imgView: editIconImgView, color: SColors.ThemeTxt)
        
        let userProfileImgTapGue = UITapGestureRecognizer()
        userProfileImgTapGue.addTarget(self, action: #selector(self.profilePicTapped))
        
        self.profilePicViewArea.isUserInteractionEnabled = true
        self.profilePicViewArea.addGestureRecognizer(userProfileImgTapGue)
        
        self.placesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PLACES_HEADER_TXT")
        
        if(ServiceModule.serviceProviderProduct){
            self.placesViewHeight.constant = 0
            self.placesContainerView.isHidden = true
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 165
            
        }
        
        checkPlaces()
        
    }
    
    
    func checkPlaces(){
        let userHomeLocationAddress = GeneralFunctions.getValue(key: "userHomeLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userHomeLocationAddress") as! String) : ""
        let userWorkLocationAddress = GeneralFunctions.getValue(key: "userWorkLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userWorkLocationAddress") as! String) : ""
        
        if(userHomeLocationAddress != ""){
            self.homeLocEditImgView.image = UIImage(named: "ic_edit")
            self.homeLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PLACE")
            self.homeLocVLbl.text = GeneralFunctions.getValue(key: "userHomeLocationAddress") as? String
            
            let homeLatitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userHomeLocationLatitude") as! String)
            let homeLongitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userHomeLocationLongitude") as! String)
            
            self.homeLoc = CLLocation(latitude: homeLatitude, longitude: homeLongitude)
            
        }else{
            self.homeLocEditImgView.image = UIImage(named: "ic_add_plus")
            self.homeLocVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_HOME_PLACE_TXT")
            self.homeLocHLbl.text = "----"
        }
        
        if(userWorkLocationAddress != ""){
            self.workLocEditImgView.image = UIImage(named: "ic_edit")
            self.workLocHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORK_PLACE")
            self.workLocVLbl.text = GeneralFunctions.getValue(key: "userWorkLocationAddress") as? String
            
            let workLatitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userWorkLocationLatitude") as! String)
            let workLongitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userWorkLocationLongitude") as! String)
            
            self.workLoc = CLLocation(latitude: workLatitude, longitude: workLongitude)
        }else{
            self.workLocEditImgView.image = UIImage(named: "ic_add_plus")
            self.workLocVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_WORK_PLACE_TXT")
            self.workLocHLbl.text = "----"
        }
        
        GeneralFunctions.setImgTintColor(imgView: self.homeLocImgView, color: UIColor(hex: 0x272727))
        GeneralFunctions.setImgTintColor(imgView: self.workLocImgView, color: UIColor(hex: 0x272727))
        
        GeneralFunctions.setImgTintColor(imgView: self.homeLocEditImgView, color: UIColor(hex: 0x909090))
        GeneralFunctions.setImgTintColor(imgView: self.workLocEditImgView, color: UIColor(hex: 0x909090))
        
        let homePlaceTapGue = UITapGestureRecognizer()
        let workPlaceTapGue = UITapGestureRecognizer()
        
        homePlaceTapGue.addTarget(self, action: #selector(self.homePlaceEditTapped))
        workPlaceTapGue.addTarget(self, action: #selector(self.workPlaceEditTapped))
        
        self.homeLoceditImgContainerView.isUserInteractionEnabled = true
        //        self.homeLoceditImgContainerView.addGestureRecognizer(homePlaceTapGue)
        self.homeLocContainerView.addGestureRecognizer(homePlaceTapGue)
        
        self.workLoceditImgContainerView.isUserInteractionEnabled = true
        //        self.workLoceditImgContainerView.addGestureRecognizer(workPlaceTapGue)
        self.workLocContainerView.addGestureRecognizer(workPlaceTapGue)
    }
    
    @objc func homePlaceEditTapped(){
        let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
        addDestinationUv.SCREEN_TYPE = "HOME"
        addDestinationUv.centerLocation = homeLoc
        self.push(uv: addDestinationUv)
    }
    
    @objc func workPlaceEditTapped(){
        let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
        addDestinationUv.SCREEN_TYPE = "WORK"
        addDestinationUv.centerLocation = workLoc
        self.push(uv: addDestinationUv)
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
    
    func updateWalletAmount(){
       
        let parameters = ["type":"GetMemberWalletBalance", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                //                Utils.printLog(msgData: "dataDict:Balance:\(dataDict)")
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: dataDict.get("user_available_balance_amount") as AnyObject)   // Without Currency Symbole
                    
                    GeneralFunctions.saveValue(key: "user_available_balance", value: dataDict.get("user_available_balance") as AnyObject) // With Currency Symbole
                    
                    
                    if(self.userProfileJson.get("user_available_balance") != dataDict.get("MemberBalance")){
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                    
                    self.walletBVLbl.text = Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)
                    
                }
                
            }else{
               
                self.generalFunc.setError(uv: self)
            }
        })
    }
    //    ChooseImageOptionView
    func setLanguage(){
        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            
            self.colorArrayForLang.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextLang.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
            
            if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) == tempItem.get("vCode")){
                languageTxtField.setText(text: tempItem.get("vTitle"))
               
                self.selectedLngCode = tempItem.get("vCode")
                self.selectedLngColor = self.colorArrayForLang[i]
                self.selectedLngTxtColor = self.colorArrayForTextLang[i]
            }
            
            languageNameList += [tempItem.get("vTitle")]
            languageCodes += [tempItem.get("vCode")]
        }
        
        if(dataArr.count < 2){
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 55
            self.langTxtFieldHeight.constant = 0.0
            self.languageTxtField.isHidden = true
            self.placeAreaTopMargin.constant = self.placeAreaTopMargin.constant - 5
        }
        
        setCurrency()
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
            
            currenyList += [tempItem.get("vName")]
            currencySymboles.append(tempItem.get("vSymbol"))
        }
        
        if(dataArr.count < 2){
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 55
            self.currencyTxtFieldHeight.constant = 0.0
            self.currencyTxtField.isHidden = true
            self.placeAreaTopMargin.constant = self.placeAreaTopMargin.constant - 5
        }
        
    }
    
    @IBAction func unwindToViewProfileScreen(_ segue:UIStoryboardSegue) {
        
        if(segue.source.isKind(of: AddDestinationUV.self))
        {
            
            let addDestinationUv = segue.source as! AddDestinationUV
            let selectedLocation = addDestinationUv.selectedLocation
            let selectedAddress = addDestinationUv.selectedAddress
            
            if(addDestinationUv.SCREEN_TYPE == "HOME"){
                GeneralFunctions.saveValue(key: "userHomeLocationAddress", value: selectedAddress as AnyObject)
                GeneralFunctions.saveValue(key: "userHomeLocationLatitude", value: ("\(selectedLocation!.coordinate.latitude)") as AnyObject)
                GeneralFunctions.saveValue(key: "userHomeLocationLongitude", value: ("\(selectedLocation!.coordinate.longitude)") as AnyObject)
            }else{
                GeneralFunctions.saveValue(key: "userWorkLocationAddress", value: selectedAddress as AnyObject)
                GeneralFunctions.saveValue(key: "userWorkLocationLatitude", value: ("\(selectedLocation!.coordinate.latitude)") as AnyObject)
                GeneralFunctions.saveValue(key: "userWorkLocationLongitude", value: ("\(selectedLocation!.coordinate.longitude)") as AnyObject)
            }
            
            checkPlaces()
        }
        
    }
    
    func myLableTapped(sender: MyLabel) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.finalDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.finalDataArray[section] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
        cell.selectionStyle = .none
        
        let headerData = self.finalDataArray[indexPath.section] as! [Headline]
        if(headerData[indexPath.row].attributedTitle == NSMutableAttributedString.init(string: "")){
            cell.titleLbl.text = headerData[indexPath.row].title
        }else{
            cell.titleLbl.attributedText = headerData[indexPath.row].attributedTitle
        }
        
        cell.iconImgView.image = UIImage(named: headerData[indexPath.row].image)
        
//        var rightImage = ""
//        if(headerData[indexPath.row].rightSideImage == ""){
//            rightImage = "ic_arrow_right"
//        }else{
//            rightImage = headerData[indexPath.row].rightSideImage
//        }
//        if(Configurations.isRTLMode()){
//            cell.nextArrowImgView.image = UIImage(named:rightImage)?.rotate(180)
//        }else{
//            cell.nextArrowImgView.image = UIImage(named:rightImage)
//        }
//
//        GeneralFunctions.setImgTintColor(imgView: cell.nextArrowImgView, color: UIColor.lightGray)
        
        let selectedRow = (self.self.finalDataArray[indexPath.section] as! [Headline])[indexPath.row].id
        
        if(selectedRow == SMART_LOGIN){
            
            cell.nextArrowImgView.isHidden = true
            cell.onOffSwitch.isHidden = false
            cell.onOffSwitch.addTarget(self, action: #selector(smartLoginSwitchValueChanged), for: .valueChanged)
            if(GeneralFunctions.isQuickLogInEnable()){
                cell.onOffSwitch.setOn(true, animated: false)
            }else{
                cell.onOffSwitch.setOn(false, animated: false)
                cell.nextArrowImgView.image = UIImage(named:"ic_list_false")
            }
            cell.imageViewSmartLogin.image = UIImage.init(named: "info_new_2")
            cell.titleLblTrailing.constant = 50
            GeneralFunctions.setImgTintColor(imgView: cell.imageViewSmartLogin, color: SColors.Theme)
            cell.rightArrowImageHight.constant = 34
            cell.rightArrowImageWidth.constant = 34
            cell.imageViewSmartLogin.isHidden = false
            cell.imageViewSmartLogin.handleClick { instance in
                self.openSmartLogin()
            }
        }else{
            cell.nextArrowImgView.isHidden = false
            cell.onOffSwitch.isHidden = true
            cell.imageViewSmartLogin.isHidden = true
            var rightImage = ""
            if(headerData[indexPath.row].rightSideImage == ""){
                rightImage = "ic_arrow_right"
            }else{
                rightImage = headerData[indexPath.row].rightSideImage
            }
            if(Configurations.isRTLMode()){
                cell.nextArrowImgView.image = UIImage(named:rightImage)?.rotate(180)
            }else{
                cell.nextArrowImgView.image = UIImage(named:rightImage)
            }
            cell.titleLblTrailing.constant = 20
            GeneralFunctions.setImgTintColor(imgView: cell.nextArrowImgView, color: UIColor.lightGray)
            cell.rightArrowImageHight.constant = 24
            cell.rightArrowImageWidth.constant = 24
        }
        
        return cell
    }
    
    @objc func smartLoginSwitchValueChanged(_ sSwitch: UISwitch) {
            
        if(sSwitch.isOn){
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: true as AnyObject)
        }else{
            GeneralFunctions.saveValue(key: "IS_QUICK_LOGIN", value: false as AnyObject)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let selectedRow = (self.self.finalDataArray[indexPath.section] as! [Headline])[indexPath.row].id
        
        if(selectedRow == SMART_LOGIN){
            return 60
        }else{
            
            if((selectedRow == HOME_PLACE || selectedRow == WORK_PLACE) && GeneralFunctions.getMemberd() != ""){
                return 80
            }
            return 52
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 55))
        view.backgroundColor = UIColor(hex: 0xf1f1f1)
        
        let label = UILabel.init(frame: CGRect(x:20, y:10, width: tableView.frame.size.width - 40, height: 55 - 10))
        label.font = UIFont.init(name: Fonts().semibold, size: 17)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.text = headerTitle[section]

        view.addSubview(label)
        return view
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableViewLastCntOffset = self.tableView.contentOffset
        
        let selectedRow = (self.self.finalDataArray[indexPath.section] as! [Headline])[indexPath.row].id
        
        
        switch selectedRow {
        case MY_BOOKINGS:
            self.openBookings()
            break
        case BUSINESS_PROFILE:
            openBusinessProfile()
            break
        case MY_CART:
            openCart()
            break
        case NOTIFICATIONS:
            openNotifications()
            break
        case FAV_DRIVER:
            openFAVDrivers()
            break
        case INVITE_FRIEND:
            openInviteFriends()
            break
        case EMERGENCY_CONTACT:
            openEmeContact()
            break
        case VERIFY_MOBILE:
            AccountVerification(isMobile: true)
            break
        case VERIFY_EMAIL:
            AccountVerification(isMobile: false)
            break
            
        case PERSONAL_DETAILS:
            editProfileTapped()
            break
        case CHANGE_PASSWORD:
            openChangePassword()
            break
        case CHANGE_CURRENCY:
            changeCurrencyTapped()
            break
        case CHANGE_LANGUAGE:
            changeLanguageTapped()
            break
        case PAYMENT_METHOD:
            openPayment()
            break
        case MY_WALLET:
            self.openMyWallet()
            break
        case ADD_MONEY:
            self.openMyWallet(true, false)
            break
        case SEND_MONEY:
            self.openMyWallet(false, true)
            break
        case ABOUT_US:
            openAbout()
            break
        case PRIVACY_POLICY:
            openPrivacy()
            break
        case TERMS_CONDITION:
            openTerms()
            break
        case FAQ:
            openHelp()
            break
        case LIVE_CHAT:
            self.openLiveChat()
            break
        case CONTACT_US:
            openContactUs()
            break
        case HOME_PLACE:
            self.homePlaceEditTapped()
            break
        case WORK_PLACE:
            self.workPlaceEditTapped()
            break
        case MENU_DONATION:
            self.openDonation()
            break
        case LOG_OUT:
            self.signOutTapped()
            break
        case SMART_LOGIN:
           // self.openSmartLogin()
            break
        case SEND_GIFT:
            self.sendGift()
            break
        case REDEEM_GIFT:
            self.redeemGift()
            break
        case RENT_ITEM_ADD:
            self.openRentItem()
            break
        case RENT_ITEM_POST:
            self.openRentItemPost()
            break
        case RENT_ITEM_FIND:
            self.openRentItemFind()
            break
        case REAL_ESTATE_ADD:
            self.openRealEstateItem()
            break
        case REAL_ESTATE_POST:
            self.openRealEstateItemPost()
            break
        case REAL_ESTATE_FIND:
            self.openRealEstateItemFind()
            break
        case RENT_CAR_ADD:
            self.openCarItem()
            break
        case RENT_CAR_POST:
            self.openCarItemPost()
            break
        case RENT_CAR_FIND:
            self.openCarItemFind()
            break
        default:
            break
        }
        
    }
    
    func sendGift(){
        let sendGiftCardUV = GeneralFunctions.instantiateViewController(pageName: "SendGiftCardUV") as! SendGiftCardUV
        self.push(uv: sendGiftCardUV)
    }
    
    func redeemGift(){
        let redeemGiftCardUV = GeneralFunctions.instantiateViewController(pageName: "RedeemGiftCardUV") as! RedeemGiftCardUV
        self.push(uv: redeemGiftCardUV)
    }
    
    func openBookings(){
        if(GeneralFunctions.getMemberd() != ""){
            
            var BOOKINGS_SECTION = false
            var ORDER_SECTION = false
            var BIDDING_SECTION = false
            
            if(ServiceModule.rideM || ServiceModule.deliveryM || ServiceModule.ufxM || ServiceModule.vcM){
                BOOKINGS_SECTION = true
            }
            
            if(ServiceModule.deliverallM || ServiceModule.runnerM || ServiceModule.genieM){
                ORDER_SECTION = true
            }
            
            if(ServiceModule.biddingM){
                BIDDING_SECTION = true
            }
            
            var mArray = [Bool]()
            if(BOOKINGS_SECTION == true){ mArray.append(BOOKINGS_SECTION) }
            if(ORDER_SECTION == true){ mArray.append(ORDER_SECTION) }
            if(BIDDING_SECTION == true){ mArray.append(BIDDING_SECTION) }
            
            if(ServiceModule.isDeliverAllOnly()){
                let ordersListUV = GeneralFunctions.instantiateViewController(pageName: "OrdersListUV") as! OrdersListUV
                //ordersListUV.homeTabBar = self.homeTabBar
               // ordersListUV.navItem = self.navigationItem
                self.push(uv: ordersListUV)
            }else{
                if(mArray.count > 1){
                    let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                    rideOrderHistoryTabUV.homeTabBar = self.homeTabBar
                    rideOrderHistoryTabUV.isFromViewProfile = true
                    rideOrderHistoryTabUV.isDirectPush = true
                    rideOrderHistoryTabUV.isFromUFXCheckOut = false
                    self.push(uv: rideOrderHistoryTabUV)
                }else{
                    let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                    //rideHistoryUV.homeTabBar = self.homeTabBar
                    rideHistoryUV.isFromViewProfile = true
                   // rideHistoryUV.navItem = self.navigationItem
                    self.push(uv: rideHistoryUV)
                }
            }
        
        }else{
            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
            self.push(uv: uv)
        }
    }
    
    func openBusinessProfile(){
        let businessProfileUV = GeneralFunctions.instantiateViewController(pageName: "BusinessProfileUV") as! BusinessProfileUV
        (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(businessProfileUV, animated: true)
    }
    
    /* Notofication Code*/
    func openNotifications(){
        
        if(GeneralFunctions.getMemberd() != ""){
            let notificationsTabUV = GeneralFunctions.instantiateViewController(pageName: "NotificationsTabUV") as! NotificationsTabUV
            self.push(uv: notificationsTabUV)
        }else{
            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
            self.push(uv: uv)
        }
        
    }/* Notofication Code*/
    
    
    func openCart()
    {
        let cartUV = GeneralFunctions.instantiateViewController(pageName: "CartUV") as! CartUV
        cartUV.isFromMenu = true
      self.push(uv: cartUV)
    }
    
    /* FAV DRIVERS CHANGES*/
    func openFAVDrivers() {
        
        let favDriversTabUv = GeneralFunctions.instantiateViewController(pageName: "FavDriversTabUV") as! FavDriversTabUV
        self.push(uv: favDriversTabUv)
    }/* .............*/
    
    func openInviteFriends(){
        if GeneralFunctions.getMemberd() == ""
        {
            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
            self.push(uv: uv)
        }else
        {
            let inviteFriendsUv = GeneralFunctions.instantiateViewController(pageName: "InviteFriendsUV") as! InviteFriendsUV
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(inviteFriendsUv, animated: true)
        }
    }
    
    func AccountVerification(isMobile:Bool) {
        let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
        accountVerificationUv.isForMobile = isMobile
        self.push(uv: accountVerificationUv)
    }
    
    func openEmeContact(){
        
        let emergencyContactsUv = GeneralFunctions.instantiateViewController(pageName: "EmergencyContactsUV") as! EmergencyContactsUV
        (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(emergencyContactsUv, animated: true)
    }
    
    func openChangePassword(){
        //        ChangePasswordView
        let openChangePassword = OpenChangePassword(uv: self, containerView: self.contentView, vPassword: userProfileJson.get("vPassword"), userProfileJson: self.userProfileJson, SITE_TYPE_DEMO_MSG: userProfileJson.get("SITE_TYPE_DEMO_MSG"))
        openChangePassword.show()
        openChangePassword.setViewHandler { (isPasswordCange) in
            if(isPasswordCange == true){
                self.setData()
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INFO_UPDATED_TXT"), uv: self)
            }
        }
    }
    
    func lngValueChanged(selectedItemId:Int){
        self.selectedLngCode = self.languageCodes[selectedItemId]
        self.updateProfile()
        
//        if(self.openListView != nil){
//            self.openListView.bgView.isUserInteractionEnabled = true
//            self.openListView.newListView.isUserInteractionEnabled = true
//            self.openListView.startLoading = false
//            self.openListView.newListView.tableView.reloadData()
//            self.openListView.closeNewListView()
//        }
    }
    
    func updateProfile(){
        var  parameters = ["type":"updateUserProfileDetail","vName": userProfileJson.get("vName"), "vLastName": userProfileJson.get("vLastName"), "vEmail": userProfileJson.get("vEmail"), "vPhone": userProfileJson.get("vPhone"), "vPhoneCode": userProfileJson.get("vPhoneCode"), "vCountry": userProfileJson.get("vCountry"), "vDeviceType": Utils.deviceType, "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "LanguageCode": selectedLngCode, "CurrencyCode": self.selectedCurrency]
        if GeneralFunctions.getMemberd() == "" {
                parameters = ["type":"changelanguagelabel","vLang": self.selectedLngCode]
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict( )
                
                if(dataDict.get("Action") == "1"){
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: false)
                    
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    
                    let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")
                    let vLang = userProfileJson.get("vLang")
                    
                    if(vLang != self.selectedLngCode || vCurrencyPassenger != self.selectedCurrency){
                        
                        GeneralFunctions.saveValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY, value: self.selectedCurrency as AnyObject)
                        
                        if GeneralFunctions.getMemberd() == "" {
                            GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
                            
                            GeneralFunctions.saveValue(key: Utils.LANGUAGE_CODE_KEY, value: dataDict.get("vCode") as AnyObject)
                            GeneralFunctions.saveValue(key: Utils.LANGUAGE_IS_RTL_KEY, value: dataDict.get("eType") as AnyObject)
                            GeneralFunctions.saveValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY, value: dataDict.get("vTitle") as AnyObject)
                            GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: dataDict.get("vGMapLangCode") as AnyObject)
                            GeneralFunctions.languageLabels = nil
                            Configurations.setAppLocal()
                        }
                        
                    }
                    
        
                    GeneralFunctions.downloadGenData(completionHandler: { success in
                        if(success){
                            
                            if(self.openListView != nil){
                                self.openListView.bgView.isUserInteractionEnabled = true
                                self.openListView.newListView.isUserInteractionEnabled = true
                                self.openListView.startLoading = false
                                self.openListView.newListView.tableView.reloadData()
                                self.openListView.closeNewListView()
                            }
                            
                            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_TRIP_CANCEL_CONFIRM_TXT"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFY_RESTART_APP_TO_CHANGE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                
                                let window = UIApplication.shared.delegate!.window!
                                GeneralFunctions.restartApp(window: window!)
                            })
                            
                        }
                        
                        
                    }, true, self.view)
                   
                    if(vLang != self.selectedLngCode || vCurrencyPassenger != self.selectedCurrency){
                        return
                    }
                  
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                  
                                        
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    func changeLanguageTapped(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        self.userProfileJson = userProfileJson

        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray

        var selectedItem = ""
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) == tempItem.get("vCode")){
                selectedItem = tempItem.get("vTitle")
            }
        }
        
        self.openListView = OpenListView(uv: nil, containerView: self.view)
        self.openListView.openNewList = true
        self.openListView.viewProfileUV = self
        self.openListView.newListCodeString = self.languageCodes
        self.openListView.colorArray = self.colorArrayForLang
        self.openListView.textColorArray = self.colorArrayForTextLang
        self.openListView.selectedItem = selectedItem
        self.openListView.isForLang = true
        self.openListView.show(listObjects: self.languageNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LANGUAGE_HINT_TXT"), currentInst: self.openListView, handler: { (selectedItemId) in
            self.selectedLngCode = self.languageCodes[selectedItemId]
            
            let vLang = userProfileJson.get("vLang")

            if((ServiceModule.isDeliverAllOnly() || ServiceModule.isAnyDeliverAllOptionEnable()) && vLang != self.selectedLngCode)
            {
                var foodItmData = NSMutableArray.init()

                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {

                foodItmData = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray

                }
                if foodItmData.count != 0
                {
//                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CART_REMOVE_NOTE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
//
//                        if btnClickedIndex == 0
//                        {
//                            let cartItemsArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
//                            cartItemsArray.removeAllObjects()
//                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: cartItemsArray as AnyObject)
//
//                            self.lngValueChanged(selectedItemId: selectedItemId)
//
//                        }
//
//                    })
                    
                    self.lngValueChanged(selectedItemId: selectedItemId)
                }else
                {
                    self.lngValueChanged(selectedItemId: selectedItemId)
                }
            }else{
                    self.lngValueChanged(selectedItemId: selectedItemId)
            }
        })
        
    }

    
    func changeCurrencyTapped(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        self.openListView = OpenListView(uv: nil, containerView: self.view)
        self.openListView.openNewList = true
        self.openListView.viewProfileUV = self
        self.openListView.newListCodeString = self.currencySymboles
        self.openListView.colorArray = self.colorArrayForCurr
        self.openListView.textColorArray = self.colorArrayForTextCurr
        self.openListView.isForCurrency = true
        if GeneralFunctions.getMemberd() == "" {
            self.openListView.selectedItem = (GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String)
        }else {
            self.openListView.selectedItem = userProfileJson.get("vCurrencyPassenger")
        }
        self.openListView.show(listObjects: self.currenyList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CURRENCY"), currentInst: self.openListView, handler: { (selectedItemId) in
            
            self.selectedCurrency = self.currenyList[selectedItemId]
            let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")

            if((ServiceModule.isDeliverAllOnly() || ServiceModule.isAnyDeliverAllOptionEnable()) && vCurrencyPassenger != self.selectedCurrency)
            {
                var foodItmData = NSMutableArray.init()

                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {

                   foodItmData = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray

                }
                if foodItmData.count != 0
                {
                  self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_TXT"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CART_REMOVE_NOTE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in

                    if btnClickedIndex == 0
                    {
                        let cartItemsArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                        cartItemsArray.removeAllObjects()
                        GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: cartItemsArray as AnyObject)

                        self.currencyValueChanged(selectedItemId: selectedItemId)
                    }

                 })
              }else{
                    self.currencyValueChanged(selectedItemId: selectedItemId)
              }
            }else{
               self.currencyValueChanged(selectedItemId: selectedItemId)
            }
        })
        
    }

    func currencyValueChanged(selectedItemId:Int) {
        
        self.selectedCurrency = self.currenyList[selectedItemId]
        
        if GeneralFunctions.getMemberd() != "" {
            self.updateProfile()
        }else {
            
            self.openListView.bgView.isUserInteractionEnabled = true
            self.openListView.newListView.isUserInteractionEnabled = true
            self.openListView.startLoading = false
            self.openListView.newListView.tableView.reloadData()
            self.openListView.closeNewListView()
            GeneralFunctions.downloadGenData { success in
                if(success){
                    self.selectedCurrency = self.currenyList[selectedItemId]
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY, value: self.selectedCurrency as AnyObject)
                      let window = UIApplication.shared.delegate!.window!
                    GeneralFunctions.restartApp(window: window!)
                    
                }
            }
        }
    }
    
    func openPayment() {
        var url = self.userProfileJson.get("PAYMENT_BASE_URL") + "&PAGE_TYPE=PAYMENT_LIST"
        url = url + "&currency=" + "" + userProfileJson.get("vCurrencyPassenger")
        GeneralFunctions.addPayment(url: url, uv: self)
    }
    
    func openMyWallet(_ isOpenAddMoney:Bool = false, _ isOpenSendMoney:Bool = false) {
        
        if GeneralFunctions.getMemberd() == ""
        {
            let uv = GeneralFunctions.instantiateViewController(pageName: "SignInUV") as! SignInUV
            self.push(uv: uv)
        }else
        {
            let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
            if(isOpenAddMoney == true){
                manageWalletUV.isOpenAddMoney = true
            }
            if(isOpenSendMoney == true){
                manageWalletUV.isOpenSendMoney = true
            }
            self.push(uv: manageWalletUV)
            
        }
        
    }
    
    func openAbout(){
        let staticPageUV = GeneralFunctions.instantiateViewController(pageName: "StaticPageUV") as! StaticPageUV
        staticPageUV.STATIC_PAGE_ID = "1"
        self.push(uv: staticPageUV)
    }
    
    func openPrivacy(){
        let staticPageUV = GeneralFunctions.instantiateViewController(pageName: "StaticPageUV") as! StaticPageUV
        staticPageUV.STATIC_PAGE_ID = "33"
        self.push(uv: staticPageUV)
    }
    
    func openTerms(){
        let staticPageUV = GeneralFunctions.instantiateViewController(pageName: "StaticPageUV") as! StaticPageUV
        staticPageUV.STATIC_PAGE_ID = "4"
        self.push(uv: staticPageUV)
    }
    
    func openContactUs(){
        let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
        self.push(uv: contactUsUv)
    }
    
    func openHelp(){
        let helpUv = GeneralFunctions.instantiateViewController(pageName: "HelpUV") as! HelpUV
        self.push(uv: helpUv)
    }
    func openDonation(){
        let donationUV = GeneralFunctions.instantiateViewController(pageName: "DonationUV") as! DonationUV
        self.push(uv: donationUV)
        
    }
    func openRentItem(){
        let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
        rentItemNewPostUV.eType = "RentItem"
        self.push(uv: rentItemNewPostUV)
        
    }
    func openRentItemPost(){
        let rentItemListUV = GeneralFunctions.instantiateViewController(pageName: "RentItemListUV") as! RentItemListUV
        rentItemListUV.eType = "RentItem"
        self.push(uv: rentItemListUV)
    }
    func openRentItemFind(){
        let rentItemHomeUV = GeneralFunctions.instantiateViewController(pageName: "RentItemHomeUV") as! RentItemHomeUV
        rentItemHomeUV.eType = "RentItem"
        self.push(uv: rentItemHomeUV)
    }
    func openRealEstateItem(){
        let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
        rentItemNewPostUV.eType = "RentEstate"
        self.push(uv: rentItemNewPostUV)
        
    }
    func openRealEstateItemPost(){
        let rentItemListUV = GeneralFunctions.instantiateViewController(pageName: "RentItemListUV") as! RentItemListUV
        rentItemListUV.eType = "RentEstate"
        self.push(uv: rentItemListUV)
    }
    func openRealEstateItemFind(){
        let rentItemHomeUV = GeneralFunctions.instantiateViewController(pageName: "RentItemHomeUV") as! RentItemHomeUV
        rentItemHomeUV.eType = "RentEstate"
        
        self.push(uv: rentItemHomeUV)
    }
    func openCarItem(){
        let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
        rentItemNewPostUV.eType = "RentCars"
        self.push(uv: rentItemNewPostUV)
        
    }
    func openCarItemPost(){
        let rentItemListUV = GeneralFunctions.instantiateViewController(pageName: "RentItemListUV") as! RentItemListUV
        rentItemListUV.eType = "RentCars"
        self.push(uv: rentItemListUV)
    }
    func openCarItemFind(){
        let rentItemHomeUV = GeneralFunctions.instantiateViewController(pageName: "RentItemHomeUV") as! RentItemHomeUV
        rentItemHomeUV.eType = "RentCars"
        
        self.push(uv: rentItemHomeUV)
    }
    
    func signOutTapped(){
        
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            GeneralFunctions.logOutUser()
            
            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
            
            GeneralFunctions.restartApp(window: Application.window!)
            return
        }
        
        self.generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOGOUT"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WANT_LOGOUT_APP_TXT"), positiveBtn:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: {(btnClickedId) in
            
            if(btnClickedId == 0){
                
                let window = UIApplication.shared.delegate!.window!
                
                let parameters = ["type":"callOnLogout", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
                
                let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: (self.navigationDrawerController?.rootViewController as! UINavigationController).view, isOpenLoader: true)
                exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
                exeWebServerUrl.currInstance = exeWebServerUrl
                exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                    
                    if(response != ""){
                        
                        
                        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true){
                            let cartItemsArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                            cartItemsArray.removeAllObjects()
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: cartItemsArray as AnyObject)
                        }
                        
                        /* BOOK FOR SOME ONE VIEW CHANGES */
                        GeneralFunctions.removeValue(key: "BS_CONTACTS")/* BOOK FOR SOME ONE VIEW CHANGES */
                        
                        GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                        
                        GeneralFunctions.logOutUser()
                        
                        GeneralFunctions.restartApp(window: window!)
                        
                    }else{
                        self.generalFunc.setError(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController))
                    }
                })
                
            }
            if(btnClickedId == 1)
            {
                
            }
        })
    }
    
    func openGenderView(){
        
        genderView = self.generalFunc.loadView(nibName: "GenderView", uv: self, isWithOutSize: true)
        
        genderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height)
        
        Application.window!.addSubview(genderView)
        
        let closeTapGue = UITapGestureRecognizer()
        closeTapGue.addTarget(self, action: #selector(self.closeGenderView))
        
        self.genderVCloseImgView.isUserInteractionEnabled = true
        self.genderVCloseImgView.addGestureRecognizer(closeTapGue)
        
        self.genderHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select your gender to continue", key: "LBL_SELECT_GENDER")
        self.maleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Male", key: "LBL_MALE_TXT")
        self.femaleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Female", key: "LBL_FEMALE_TXT")
        GeneralFunctions.setImgTintColor(imgView: self.genderVCloseImgView, color: UIColor.white)
        
        self.maleImgView.image = self.maleImgView.image?.addImagePadding(x: 25, y: 25)
        self.femaleImgView.image = self.femaleImgView.image?.addImagePadding(x: 25, y: 25)
        Utils.createRoundedView(view: self.maleImgView, borderColor: UIColor(hex: 0xF1F1F1), borderWidth: 4)
        Utils.createRoundedView(view: self.femaleImgView, borderColor: UIColor(hex: 0xF1F1F1), borderWidth: 4)
        
        let maleTapGue = UITapGestureRecognizer()
        maleTapGue.addTarget(self, action: #selector(self.maleImgTapped))
        
        self.maleImgView.isUserInteractionEnabled = true
        self.maleImgView.addGestureRecognizer(maleTapGue)
        
        let femaleTapGue = UITapGestureRecognizer()
        femaleTapGue.addTarget(self, action: #selector(self.femaleImgTapped))
        
        self.femaleImgView.isUserInteractionEnabled = true
        self.femaleImgView.addGestureRecognizer(femaleTapGue)
    }
    
    @objc func maleImgTapped(){
        
        self.closeGenderView()
        updateUserGender(eGender: "Male")
    }
    
    @objc func femaleImgTapped(){
        self.closeGenderView()
        updateUserGender(eGender: "Female")
    }
    
    @objc func closeGenderView(){
        if(self.genderView != nil){
            self.genderView.removeFromSuperview()
        }
    }
    
    func updateUserGender(eGender:String){
        
        let parameters = ["type":"updateUserGender", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "eGender": eGender]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    
                    self.userProfileJson = userProfileJson
                    
                    self.setNavItems()
                    
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
    }
    
    /* Live Chat Settings .*/
    func configLiveChat(){
        LiveChat.licenseId = userProfileJson.get("LIVE_CHAT_LICENCE_NUMBER")
        LiveChat.name = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
        LiveChat.email = userProfileJson.get("vEmail")
        LiveChat.setVariable(withKey:"FNAME", value:userProfileJson.get("vName"))
        LiveChat.setVariable(withKey:"LNAME", value:userProfileJson.get("vLastName"))
        LiveChat.setVariable(withKey:"EMAIL", value:userProfileJson.get("vEmail"))
        LiveChat.setVariable(withKey:"USERTYPE", value:Utils.appUserType)
        
        LiveChat.delegate = self
    }
    
    // MARK: LiveChatDelegate
    func received(message: LiveChatMessage) {
        if (!LiveChat.isChatPresented) {
            // Notifying user
            let alert = UIAlertController(title: "Support", message: message.text, preferredStyle: .alert)
            let chatAction = UIAlertAction(title: "Go to Chat", style: .default) { alert in
                // Presenting chat if not presented:
                if !LiveChat.isChatPresented {
                    LiveChat.presentChat()
                }
            }
            alert.addAction(chatAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    /* Live Chat Settings .*/
    func openLiveChat(){
        LiveChat.presentChat()
        //closeLiveChatSetup()

    }
    @objc func clearChat()
    {
        LiveChat.clearSession()
        LiveChat.dismissChat()
        btnClearsession.removeFromSuperview()

    }
    let btnClearsession = UIButton(frame: CGRect(60 , 25, 35, 35))

    func closeLiveChatSetup(){
        
        btnClearsession.frame.origin.x = (self.view.frame.size.width - 70)
        btnClearsession.setImage(UIImage(named: "ic_close_detail"), for: .normal)

        GeneralFunctions.setImgTintColor(imgView: btnClearsession.imageView!, color: UIColor(hex: 0x000000))
        btnClearsession.backgroundColor = .white
        btnClearsession.addTarget(self, action: #selector(clearChat), for: .touchUpInside)
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(btnClearsession)
    }/* Live Chat Settings .*/
    
    func openVerifyView(){
           
        let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
        openUserPreferences.isShowCancel = true
        openUserPreferences.isFromEmailVerify = true
        openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_VERIFY_NOTE_TXT"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_VERIFY"))
        
    }
    func openSmartLogin() {
    let openListView = OpenListView(uv: self, containerView: self.view)
    openListView.openNewList = true
    openListView.isFromProfile = true
    //openListView.isFromDate = true
    openListView.showCameraSheet(currentInst: openListView, handler: { (selectedItemId) in
                  
    
    
                })
    }
       
}
