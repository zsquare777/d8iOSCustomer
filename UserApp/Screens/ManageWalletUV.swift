

import UIKit
import SafariServices
import WebKit
import SysBaseLib


class ManageWalletUV: ParentViewUV, MyLabelClickDelegate, MyBtnClickDelegate, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource, MyTxtFieldOnTextChangeDelegate, MXParallaxHeaderDelegate, ParentViewUVDelegate  {
   

    var pageHeight:CGFloat = 600
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var balanceHLbl: MyLabel!
    @IBOutlet weak var balanceVLbl: MyLabel!
    @IBOutlet weak var viewTransactionBtn: MyButton!
    @IBOutlet weak var moneyTxtFieldContainerView: UIView!
    @IBOutlet weak var moneyTxtField: MyTextField!
    @IBOutlet weak var addMoneyHLbl: MyLabel!
    @IBOutlet weak var addMoneySHLbl: MyLabel!
    @IBOutlet weak var safeLbl: MyLabel!
    @IBOutlet weak var moneyContainerView1: UIView!
    @IBOutlet weak var moneyContainerView2: UIView!
    @IBOutlet weak var moneyContainerView3: UIView!
    @IBOutlet weak var moneyLbl1: MyLabel!
    @IBOutlet weak var moneyLbl2: MyLabel!
    @IBOutlet weak var moneyLbl3: MyLabel!
    @IBOutlet weak var addMoneyCancelLbl: MyLabel!
    @IBOutlet weak var addMoneyBtn: MyButton!
    @IBOutlet weak var addMoneyContainerView: UIView!
    @IBOutlet weak var updateAmountIndicator: UIActivityIndicatorView!
    @IBOutlet weak var walletAddImgView: UIImageView!
    @IBOutlet weak var walletMinusimgView: UIImageView!
    
    @IBOutlet weak var newTopCardView: UIView!
    @IBOutlet weak var viewAllSepratorView: UIView!
    @IBOutlet weak var viewCreditSapratorView: UIView!
    @IBOutlet weak var viewDebitSepratorView: UIView!
    
    @IBOutlet weak var viewSeeAll: UIView!
    /* GOPAY CHANGES */
    @IBOutlet weak var goPayBackImgView: UIImageView!
    @IBOutlet weak var transferMoneyBtn: MyButton!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var goPayTransferMoneyView: UIView!
    @IBOutlet weak var methodView: UIView!
    @IBOutlet weak var methodViewHLbl: MyLabel!
    @IBOutlet weak var userSelView: UIView!
    @IBOutlet weak var userSelHLbl: MyLabel!
    @IBOutlet weak var passSelView: UIView!
    @IBOutlet weak var passSelImgView: UIImageView!
    @IBOutlet weak var passSelHLbl: MyLabel!
    @IBOutlet weak var driverSelView: UIView!
    @IBOutlet weak var driverSelImgView: UIImageView!
    @IBOutlet weak var driverSelHLbl: MyLabel!
    @IBOutlet weak var methodvalueTxtField: MyTextField!
    @IBOutlet weak var methodSearchBtn: MyButton!
    @IBOutlet weak var goPaySubmitView: UIView!
    @IBOutlet weak var searchUserProfileImgView: UIImageView!
    @IBOutlet weak var searchUserNameLbl: MyLabel!
    @IBOutlet weak var searchUserTypeLbl: MyLabel!
    @IBOutlet weak var transferingAmountLbl: MyLabel!
    @IBOutlet weak var verificationInfoImgView: UIImageView!
    @IBOutlet weak var transferingAmtView: UIView!
    @IBOutlet weak var transferingAmtViewHeight: NSLayoutConstraint!
    @IBOutlet weak var goPayAmountTxtField: MyTextField!
    @IBOutlet weak var goPaySubmitBtn: MyButton!
    @IBOutlet weak var goPayAlertBGView: UIView!
    @IBOutlet weak var goPayAlertView: UIView!
    @IBOutlet weak var gopayAlertHLbl: MyLabel!
    @IBOutlet weak var goPayAlertDoneBtn: MyButton!
    @IBOutlet weak var goPayAlertImgView: UIImageView!
    @IBOutlet var goPayCustomAlertView: UIView!
    @IBOutlet weak var resendOtpLbl: MyLabel!
    @IBOutlet weak var resendOtpImgView: UIImageView!
    @IBOutlet weak var resendOtpView: UIView!
    @IBOutlet weak var transferMoneySecLbl: MyLabel!
    @IBOutlet weak var sendMoneycancelLbl: MyLabel!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var sendMoneyBackImgView: UIImageView!
    @IBOutlet weak var goPayViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var amountMinusImgView: UIImageView!
    @IBOutlet weak var amountAddImgView: UIImageView!
    @IBOutlet weak var sendMoneyCurrencyCodeLbl: MyLabel!
    @IBOutlet weak var sendMoneyOTPTxtFiled: MyTextField!
    @IBOutlet weak var sendMoneyUserInfoView: UIView!
    @IBOutlet weak var otpSentHintLbl: MyLabel!
    @IBOutlet weak var goPayAlertSuccessView: UIView!
    @IBOutlet weak var goPayAlertSuccessDoneBtn: MyButton!
    @IBOutlet weak var goPayAlertSuccessHLbl: MyLabel!
    @IBOutlet weak var goPaySuccessSHLbl: MyLabel!
    @IBOutlet weak var goPaySuccessAmountLbl: MyLabel!
    @IBOutlet weak var goPaySuccessDateLbl: MyLabel!
    @IBOutlet weak var goPaySuccessProfileImgView: UIImageView!
    @IBOutlet weak var goPaySuccessProfileNameLbl: MyLabel!
    @IBOutlet weak var goPaySuccessViewWidth: NSLayoutConstraint!
    @IBOutlet weak var goPaySuccessViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sendMoneyUserInfoViewHeight: NSLayoutConstraint!
    /* .......... */
    
    /* New Flow Changes*/
    @IBOutlet weak var addMoneyView: UIView!
    @IBOutlet weak var addMoneyImgView: UIImageView!
    @IBOutlet weak var addMoneyLbl: MyLabel!
    @IBOutlet weak var transferMoneyView: UIView!
    @IBOutlet weak var transferMoneyImgView: UIImageView!
    @IBOutlet weak var transferMoneyLbl: MyLabel!
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var transactionImgView: UIImageView!
    @IBOutlet weak var transactionLbl: MyLabel!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var topstackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var addMoneyCurrencyCode: MyLabel!
    @IBOutlet weak var topstackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var parallexHView: UIView!
    @IBOutlet weak var parellexBottomView: UIView!
    
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var helpWalletImgView: UIImageView!
    @IBOutlet weak var helpLbl: MyLabel!
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var allLbl: MyLabel!
    @IBOutlet weak var viewCredit: UIView!
    @IBOutlet weak var creditLbl: MyLabel!
    @IBOutlet weak var imageCredit: UIImageView!
    @IBOutlet weak var viewDebit: UIView!
    @IBOutlet weak var debitLbl: MyLabel!
    @IBOutlet weak var imageDebit: UIImageView!
    @IBOutlet weak var lblSeeAll: MyLabel!
    @IBOutlet weak var seeAllArrowImage: UIImageView!
    
    @IBOutlet weak var parentPhView1: UIView!
    @IBOutlet weak var parentPhView2: UIView!
    @IBOutlet weak var parentPhView3: UIView!
    @IBOutlet weak var parentPhView4: UIView!
    @IBOutlet weak var parentPhView5: UIView!
    @IBOutlet weak var parentPhView6: UIView!
    @IBOutlet weak var parentPhView7: UIView!
    @IBOutlet weak var parentPhView8: UIView!
    
    
    @IBOutlet weak var newAddMoney_icon: UIImageView!
    @IBOutlet weak var newWalletTransfer_icon: UIImageView!
    @IBOutlet weak var newWalletTransaction_iocn: UIImageView!
    @IBOutlet weak var newContact_iocn: UIImageView!
    
    /* GOPAY CHANGES */
    var goPayMethodSelValue = ""
    var goPayuserSelValue = ""
    var transferState = ""
    var goPayDataDic:NSDictionary!
    var goPayVerificationDic:NSDictionary!
    var enteredAmount = "0.00"
    var LIST_TYPE = "All"
    var isFromSuceccesPayment = false
    
    /* FLUTEERVAVE CHANGES */
    var currencyPass = ""
    var AmountPass = ""
    var OrignalMount = ""
    var txref = ""
    var isSucess = false
    var charged = false
    var flutterWaveUniqID = ""
    var isCard = false
    var strPaymentType = ""
    /* .......... */
    
    /* PAYMENT FLOW CHANGES */
    let webView = WKWebView()
    var activityIndicator:UIActivityIndicatorView!
    /* ................. */
    
    let generalFunc = GeneralFunctions()
    
    var userProfileJson:NSDictionary!
    
    var cntView:UIView!
    
    var isFirstLaunch = true
   
    // NEw Changes
    var dataArrList = [NSDictionary]()
    var nextPage_str = 1
    var isLoadingMore = false
    var isNextPageAvail = false
    var loaderView:UIView!
    var bgView:UIView!
    var sendMoneyView:UIView!
    var addMoneyPopupView:UIView!
    
    var homeTabBar:HomeScreenTabBarUV!
    var isOpenAddMoney = false
    var isOpenSendMoney = false
    let messageLbl = MyLabel()
    var placeHolderView:UIView!
    var placeholderMarker:Placeholder!
    var isDataLoading = true
    var isViewGone = false
    var isFromReedem = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
            self.setnavBarTintColor(color: SColors.Theme)
            cntView = self.generalFunc.loadView(nibName: "ManageWalletScreenDesign", uv: self, contentView: contentView)
            
            
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            
            scrollView.backgroundColor = UIColor(hex: 0xF2F2F4)
            
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            
            self.contentView.addSubview(cntView)
            self.scrollView.bounces = false
    
            self.webView.isHidden = true
            /* ........... */
            if(self.homeTabBar != nil) {
            placeHolderView = self.generalFunc.loadView(nibName: "ManageWalletPhView", uv: self, contentView: self.view)
            self.placeHolderView.clipsToBounds = true
            if(self.homeTabBar != nil){
                self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height - self.homeTabBar.kBarHeight)
            }else{
                self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height - 70)
            }
            
            }else{
                placeHolderView = self.generalFunc.loadView(nibName: "ManageWalletPhView", uv: self, contentView: self.view)
                self.placeHolderView.clipsToBounds = true
                self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height)
            }
            Application.window!.addSubview(placeHolderView)
            if(self.isDataLoading == true){
                self.setPlaceHolderView()
            }
            self.contentView.alpha = 0
            if(self.homeTabBar == nil){
                self.addBack()
            }
        
            self.contentView.isHidden = true
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            self.navigationController?.navigationBar.layer.zPosition = 1
            
            if(isFirstLaunch){
                
                cntView.frame.size = CGSize(width: cntView.frame.width, height: cntView.frame.height)
                
                //self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: pageHeight)
                
                self.transactionTableView.dataSource = self
                self.transactionTableView.delegate = self
                self.transactionTableView.register(UINib(nibName: "TransactionHistoryListTVCell", bundle: nil), forCellReuseIdentifier: "TransactionHistoryListTVCell")
                self.transactionTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
                
              
                //self.addMoneyView.layer.addShadow(opacity:0.7, radius:2)
                //self.addMoneyView.layer.roundCorners(radius: 10)
                
                //self.transactionView.layer.addShadow(opacity:0.7, radius:2)
                //self.transactionView.layer.roundCorners(radius: 10)
                
                //self.transferMoneyView.layer.addShadow(opacity:0.7, radius:2)
                //self.transferMoneyView.layer.roundCorners(radius: 10)
                
                isFirstLaunch = false
              
                self.transactionTableView.parallaxHeader.delegate = self
                self.transactionTableView.parallaxHeader.view = self.parallexHView
                self.transactionTableView.parallaxHeader.mode = .bottom
                self.transactionTableView.parallaxHeader.height = 388
                self.transactionTableView.parallaxHeader.minimumHeight = 160
                
                if(userProfileJson.get("ENABLE_GOPAY").uppercased() != "YES"){
                    self.transferMoneyView.isHidden = true
                }
                
                if(self.userProfileJson.get("APP_PAYMENT_MODE").uppercased() == "CASH"){
                    self.addMoneyView.isHidden = true
                }
            }
            
            updateWalletAmount(false, true)
            if self.isFromSuceccesPayment {
                self.isFromSuceccesPayment = false
            }else{
            self.refreshTransactions()
            }
            self.contentView.isHidden = false
            
            if(self.homeTabBar != nil){
                self.homeTabBar.navItem.rightBarButtonItem = nil
                let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
                label.font = UIFont(name: Fonts().regular, size: 18)!
                label.backgroundColor = UIColor.clear
                label.numberOfLines = 0
                label.textAlignment = NSTextAlignment.center
                label.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
                label.textColor = SColors.ThemeTxt
                self.homeTabBar.navItem.titleView = label
                
            }else{
                self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
                 self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
            }
            
            if(isOpenAddMoney){
                isOpenAddMoney = false
                self.openAddMoneyView()
            }
            if(isOpenSendMoney){
                isOpenSendMoney = false
                self.sendMoneyInitialize()
            }
            
            self.messageLbl.frame.size = CGSize(width: self.contentView.frame.size.width - 25, height: 80)
            self.messageLbl.numberOfLines = 4
            self.messageLbl.font = UIFont(name: Fonts().regular, size: 17)!
            self.messageLbl.textAlignment = .center
            //self.messageLbl.center = CGPoint(x: transactionTableView.width/2, y: (transactionTableView.height/2) + 100)
            //self.messageLbl.frame = //self.transactionTableView.bounds
            self.messageLbl.frame = CGRect(x:10, y:(transactionTableView.height/2) + 125, width:Application.screenSize.width - 20, height: 70)
            //self.messageLbl.frame.origin.y = (transactionTableView.height/2) + 100
            //self.messageLbl.frame.origin.x = transactionTableView.width/2
            self.messageLbl.setPadding(paddingTop: 10, paddingBottom: 10, paddingLeft: 10, paddingRight: 10)
            self.messageLbl.isHidden = true
            self.cntView.addSubview(self.messageLbl)
            //self.transactionTableView.addSubview(self.messageLbl)
        }else if type == 3 {
           // self.isViewGone = true
            self.isDataLoading = true
            self.removePlaceHolderView()
        }
    }


    override func close() {
        
        /* PAYMENT FLOW CHANGES */
        if(GeneralFunctions.getPaymentMethod(userProfileJson: self.userProfileJson) == "2" && self.webView.isHidden == false){
            
            self.closeWebView()
            return
        }/* ........... */
        if self.isFromReedem {
            self.navigationController!.popToRootViewController(animated: false)
            return
        }
        super.close()
    }

    func setScrollViewHeight(height:CGFloat){
        
        self.pageHeight = height
        if(self.pageHeight < self.contentView.frame.height){
            self.pageHeight = self.contentView.frame.height
        }
       // self.cntView.frame.size = CGSize(width: self.cntView.frame.width, height: self.pageHeight)
         self.cntView.frame.size = CGSize(width: self.cntView.frame.width, height: self.cntView.frame.height)
        //self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.pageHeight)
    }
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        
        if(parallaxHeader.progress <= 0){
          
            self.parallexHView.layer.borderColor = UIColor.lightGray.cgColor
            self.parellexBottomView.backgroundColor = UIColor.white
            self.parallexHView.backgroundColor = UIColor.white
        }else{
            //self.selectServiceLbl.layer.shadowOpacity = 0.0;
            self.parallexHView.layer.borderColor = UIColor.clear.cgColor
            self.parellexBottomView.backgroundColor = UIColor.clear
            self.parallexHView.backgroundColor = UIColor.clear
        }
    }
    
    func setData(){
        
        // New Flow
        
        
        if(Application.screenSize.height > 568){
            //self.topstackViewWidth.constant = 330
            //self.topstackViewHeight.constant = 100
        }
        self.shadowOnview(view: self.addMoneyView)
        self.shadowOnview(view: self.transferMoneyView)
        self.shadowOnview(view: self.transactionView)
        self.shadowOnview(view: self.helpView)
        self.addMoneyLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY")
        self.transferMoneyLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER")
        self.transactionLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSACTIONS")
        self.safeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECENT_TRANSACTION")
        self.helpLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_HEADER_TXT")
        self.safeLbl.isHidden = false
        self.safeLbl.isHidden = false
        viewSeeAll.layer.borderWidth = 1
        viewSeeAll.layer.borderColor = UIColor.black.cgColor

        self.parellexBottomView.isHidden = false
        self.transactionView.handleClick { (instance) in
            let ufxProviderInfoTabUV = GeneralFunctions.instantiateViewController(pageName: "TransactionHistoryTabUV") as! TransactionHistoryTabUV
            ufxProviderInfoTabUV.isfromSeeAll = false
            self.push(uv: ufxProviderInfoTabUV)
        }
        self.transferMoneyView.handleClick { (instance) in
            self.sendMoneyInitialize()
        }
        
        self.addMoneyView.handleClick { (instance) in
            
            self.openAddMoneyView()
        }
        self.helpView.handleClick { (view) in
            self.openHelp()
        }
        /* */
        
      //  self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
       // self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
//
        
        self.balanceHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BALANCE")
        self.shadowOnview(view: self.newTopCardView)
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)

        self.balanceVLbl.text = Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)
        
       // self.viewTransactionBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_TRANS_HISTORY"))
        
        
        headerView.layer.shadowOpacity = 0.5
//        headerView.layer.shadowRadius = 1.1
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        headerView.layer.shadowColor = UIColor(hex: 0xc0c0c1).cgColor
        headerView.backgroundColor = SColors.Theme
        Utils.delayWithSeconds(0.5) {
            //self.headerView.round(corners: [.bottomLeft,.bottomRight], cornerRadius: 40)
            
                //self.headerView.roundTo(corners: [.bottomLeft,.bottomRight], radius: 40)
            
        }
        
       
       
      
        self.transactionTableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom - 15) : 20), right: 0)
        
        viewAll.backgroundColor = UIColor.clear//SColors.Theme
        viewAll.layer.roundCorners(radius: 15)
        self.allLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALL")
        self.allLbl.textColor = SColors.Theme
        self.viewAllSepratorView.backgroundColor = SColors.Theme
       
        debitLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DEBIT")
        viewDebit.backgroundColor = UIColor.clear //SColors.ThemeTxt
        //viewDebit.layer.roundCorners(radius: 15)
        
        creditLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CREDIT")
        viewCredit.backgroundColor = UIColor.clear//SColors.ThemeTxt
       // viewCredit.layer.roundCorners(radius: 15)
        lblSeeAll.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEE_ALL")
        self.lblSeeAll.textColor = SColors.blackColor
        if(Configurations.isRTLMode()){
            lblSeeAll.textAlignment = .left
        }
        //self.shadowOnview(view: viewDebit)
        //self.shadowOnview(view: viewCredit)
        //self.shadowOnview(view: viewAll)
        var tempImage = "ic_arrow_right"
          if(Configurations.isRTLMode()){
        self.seeAllArrowImage.image = UIImage(named:tempImage)?.rotate(180)
          }
        GeneralFunctions.setImgTintColor(imgView: self.seeAllArrowImage, color: SColors.blackColor)
//        GeneralFunctions.setImgTintColor(imgView: self.newAddMoney_icon, color: SColors.Theme)
//        GeneralFunctions.setImgTintColor(imgView: self.newWalletTransfer_icon, color: SColors.Theme)
//        GeneralFunctions.setImgTintColor(imgView: self.newWalletTransaction_iocn, color: SColors.Theme)
//        GeneralFunctions.setImgTintColor(imgView: self.newContact_iocn, color: SColors.Theme)
       
        self.viewAll.handleClick { (view) in
            self.viewDebit.backgroundColor = UIColor.clear//SColors.ThemeTxt
            self.viewCredit.backgroundColor = UIColor.clear//SColors.ThemeTxt
            self.creditLbl.textColor = UIColor.black
            self.debitLbl.textColor = UIColor.black
            self.viewAll.backgroundColor = UIColor.clear
            self.viewAllSepratorView.backgroundColor = SColors.Theme
            self.viewDebitSepratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.viewCreditSapratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.allLbl.textColor = SColors.Theme
            if self.LIST_TYPE != "All" {
            self.LIST_TYPE = "All"
            self.refreshTransactions()
            }
        }
        self.viewCredit.handleClick { (view) in
            self.messageLbl.isHidden = true
            self.viewDebit.backgroundColor = UIColor.clear
            self.viewCredit.backgroundColor = UIColor.clear
            self.creditLbl.textColor = SColors.Theme
            self.debitLbl.textColor = UIColor.black
            self.viewAll.backgroundColor = SColors.ThemeTxt
            self.allLbl.textColor = UIColor.black
            self.viewAllSepratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.viewDebitSepratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.viewCreditSapratorView.backgroundColor = SColors.Theme
            if self.LIST_TYPE != "Credit" {
            self.LIST_TYPE = "Credit"
            self.refreshTransactions()
            }
        }
        self.viewDebit.handleClick { (view) in
            self.viewDebit.backgroundColor = UIColor.clear
            self.viewCredit.backgroundColor = UIColor.clear
            self.creditLbl.textColor = UIColor.black
            self.debitLbl.textColor = SColors.Theme
            self.viewAll.backgroundColor = SColors.ThemeTxt
            self.viewAllSepratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.viewDebitSepratorView.backgroundColor = SColors.Theme
            self.viewCreditSapratorView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.allLbl.textColor = UIColor.black
            if self.LIST_TYPE != "Debit" {
            self.LIST_TYPE = "Debit"
            self.refreshTransactions()
            }
        }
        self.lblSeeAll.handleClick { (view) in
            let transactionHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "TransactionHistoryTabUV") as! TransactionHistoryTabUV
            transactionHistoryTabUV.isfromSeeAll = true
            self.push(uv: transactionHistoryTabUV)
        }
    }
    
    func sendMoneyInitialize(){
        self.enteredAmount = "0.00"
        
        self.addBGView()
        self.sendMoneyView = self.generalFunc.loadView(nibName: "SendMoneyView", uv: self, isWithOutSize: true)
        self.sendMoneyView.frame = CGRect(x:0, y:Application.screenSize.height, width:Application.screenSize.width, height: 410)
        Application.window?.addSubview(self.sendMoneyView)
        
        self.sendMoneyBackImgView.image = self.sendMoneyBackImgView.image?.addImagePadding(x: 10, y: 10)
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.sendMoneyView.frame.origin.y = Application.screenSize.height - 410
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.goPayTransferMoneyView.roundTo(corners:[.topLeft, .topRight], radius: 12)
        })
        
        
        self.gopayMoneyTransferViewSetup()
        
        self.goPayTransferMoneyView.isHidden = false
        self.goPayTransferMoneyView.clipsToBounds = true
        
        self.setScrollViewHeight(height: 560)
    }
    
    func addBGView(){
        
        if(bgView != nil){
            bgView.removeFromSuperview()
            bgView = nil
        }
        bgView = UIView.init(frame: CGRect(x:0, y:0, width:Application.screenSize.width, height:Application.screenSize.height))
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        bgView.alpha = 0
        Application.window?.addSubview(bgView)
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 1
        }
    }
    
    func removeBGView(){
        bgView.removeFromSuperview()
        bgView = nil
    }
    
    func closeSendMoneyView(){
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.sendMoneyView.frame.origin.y = Application.screenSize.height
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.sendMoneyView.removeFromSuperview()
            self.removeBGView()
        })
    }
    
    @objc func openAddMoneyView(){
        
        
        self.enteredAmount = "0.00"
        self.addBGView()
        self.addMoneyPopupView = self.generalFunc.loadView(nibName: "AddMoneyView", uv: self, isWithOutSize: true)
        self.addMoneyPopupView.frame = CGRect(x:0, y:Application.screenSize.height, width:Application.screenSize.width, height: 368)
        Application.window?.addSubview(self.addMoneyPopupView)
        
        self.addMoneyCurrencyCode.text = userProfileJson.get("vCurrencyPassenger")
        self.moneyTxtFieldContainerView.alpha = 0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            
            self.addMoneyPopupView.frame.origin.y = Application.screenSize.height - 368
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.moneyTxtFieldContainerView.alpha = 1
            self.addMoneyContainerView.roundTo(corners:[.topLeft, .topRight], radius: 12)
            self.moneyTxtField.onTextChangedDelegate = self
            self.moneyTxtField.getTextField()!.keyboardType = .decimalPad
            self.moneyTxtField.getTextField()?.textAlignment = .center
            self.moneyTxtField.getTextField()?.isDividerHidden = true
            self.moneyTxtField.getTextField()?.adjustsFontSizeToFitWidth = true
            self.moneyTxtField.getTextField()?.minimumFontSize = 12
            self.addMoneyBtn.setButtonEnabled(isBtnEnabled: false)
        })
        
        
        self.addMoneyHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY")
        self.addMoneySHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY_MSG")
        
        self.moneyLbl1.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("WALLET_FIXED_AMOUNT_1"))
        self.moneyLbl2.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("WALLET_FIXED_AMOUNT_2"))
        self.moneyLbl3.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("WALLET_FIXED_AMOUNT_3"))
        
        self.moneyLbl1.setClickDelegate(clickDelegate: self)
        self.moneyLbl2.setClickDelegate(clickDelegate: self)
        self.moneyLbl3.setClickDelegate(clickDelegate: self)
        
        self.addMoneyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONE"))
        self.addMoneyBtn.clickDelegate = self
        
        self.updateAmountIndicator.color = SColors.ThemeTxt
        
        self.moneyTxtField.getTextField()!.keyboardType = .decimalPad
        
        
        self.moneyTxtField.setText(text: self.enteredAmount)
        
        self.walletMinusimgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            var fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: self.enteredAmount) - 1.00
            if(fareInDigits < 0){
                fareInDigits = 0.00
            }
            self.enteredAmount = "\(fareInDigits)"
            self.moneyTxtField.setText(text: String(format: "%.02f", fareInDigits))
            
        }
        
        GeneralFunctions.setImgTintColor(imgView: self.walletAddImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.walletMinusimgView, color: SColors.Theme)
        
        self.walletAddImgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            let fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: self.enteredAmount) + 1.00
            self.enteredAmount = "\(fareInDigits)"
            self.moneyTxtField.setText(text: String(format: "%.02f", fareInDigits))
        }
        
        
        self.addMoneyCancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
        self.addMoneyCancelLbl.handleClick { (instance) in
            
            self.closeAddMoneyView()
        }
    }
    func openHelp()  {
        //let helpUv = GeneralFunctions.instantiateViewController(pageName: "HelpUV") as! HelpUV
        //self.push(uv: helpUv)
        let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
        self.push(uv: contactUsUv)
    }
    func closeAddMoneyView(){
        self.moneyTxtField.setText(text: "0.00")
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.addMoneyPopupView.frame.origin.y = Application.screenSize.height
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.addMoneyPopupView.removeFromSuperview()
            self.addMoneyPopupView = nil
            self.removeBGView()
        })
    }
    
    @objc func keyboardWillDisappear(sender: NSNotification){
        let info = sender.userInfo!
        _ = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    
        
        if(self.sendMoneyView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.sendMoneyView.frame.origin.y = Application.screenSize.height - 410
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
        if(self.addMoneyPopupView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.addMoneyPopupView.frame.origin.y = Application.screenSize.height - 360
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
    }
    @objc func keyboardWillAppear(sender: NSNotification){
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        if(self.sendMoneyView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.sendMoneyView.frame.origin.y = Application.screenSize.height - 410 - keyboardSize
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
        if(self.addMoneyPopupView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.addMoneyPopupView.frame.origin.y = Application.screenSize.height - 360 - keyboardSize
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        if(sender == goPayAmountTxtField || sender == moneyTxtField){
            if(sender == moneyTxtField){
                if(GeneralFunctions.parseDouble(origValue: 0.00, data: text) <= 0){
                    self.addMoneyBtn.setButtonEnabled(isBtnEnabled: false)
                }else{
                    self.addMoneyBtn.setButtonEnabled(isBtnEnabled: true)
                }
            }
            if(sender == goPayAmountTxtField){
                if(GeneralFunctions.parseDouble(origValue: 0.00, data: text) <= 0 && self.verificationInfoImgView.isHidden == true){
                    self.goPaySubmitBtn.setButtonEnabled(isBtnEnabled: false)
                }else{
                    self.goPaySubmitBtn.setButtonEnabled(isBtnEnabled: true)
                }
            }
            if(text == ""){
                self.enteredAmount = "\(0.00)"
            }else{
                self.enteredAmount = text
            }
        }
    }
    
    /* GOPAY CHANGES */
    func gopayMoneyTransferViewSetup(){
        
        self.sendMoneycancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
        self.methodViewHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY")
        self.transferMoneySecLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY_TXT1")
       
        self.methodvalueTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GO_PAY_EMAIL_OR_PHONE_TXT"))
       
        self.sendMoneycancelLbl.handleClick { (instance) in
            self.goPayuserSelValue = ""
            self.closeSendMoneyView()
            
        }
        
        
        
//        self.methodEmailSelView.handleClick { (Instance) in
//
//            self.setScrollViewHeight(height: 680)
//
//            if(self.userSelView.isHidden == true){
//                self.userSelView.alpha = 0
//                self.userSelView.isHidden = false
//                self.view.layoutIfNeeded()
//
//
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.userSelView.alpha = 1
//                    self.view.layoutIfNeeded()
//                },
//                completion: { complete in
//                    self.userSelView.alpha = 1
//                })
//            }
//
//            self.phoneSelImgView.image = UIImage(named:"ic_select_false")
//            GeneralFunctions.setImgTintColor(imgView: self.phoneSelImgView, color: SColors.Theme)
//            self.emailSelImgView.image = UIImage(named:"ic_select_true")
//            GeneralFunctions.setImgTintColor(imgView: self.emailSelImgView, color: SColors.Theme)
//
//            self.methodvalueTxtField.getTextField()!.keyboardType = .emailAddress
//            self.goPayMethodSelValue = "Email"
//            self.methodvalueTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_EMAIL_TXT"))
//            self.methodvalueTxtField.setText(text: "")
//            if(self.methodvalueTxtField.getTextField()?.isEditing == true){
//                self.view.endEditing(true)
//                _ = self.methodvalueTxtField.getTextField()?.becomeFirstResponder()
//            }
//
//        }
//
//        self.methodPhoneSelView.handleClick { (Instance) in
//
//            self.setScrollViewHeight(height: 680)
//
//            if(self.userSelView.isHidden == true){
//                self.userSelView.alpha = 0
//                self.userSelView.isHidden = false
//                self.view.layoutIfNeeded()
//
//
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.userSelView.alpha = 1
//                    self.view.layoutIfNeeded()
//                },
//                               completion: { complete in
//                                self.userSelView.alpha = 1
//                })
//            }
//
//            self.emailSelImgView.image = UIImage(named:"ic_select_false")
//            GeneralFunctions.setImgTintColor(imgView: self.emailSelImgView, color: SColors.Theme)
//            self.phoneSelImgView.image = UIImage(named:"ic_select_true")
//            GeneralFunctions.setImgTintColor(imgView: self.phoneSelImgView, color: SColors.Theme)
//
//            self.methodvalueTxtField.getTextField()!.keyboardType = .numberPad
//            self.goPayMethodSelValue = "Phone"
//            self.methodvalueTxtField.setText(text: "")
//            self.methodvalueTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_PHONE_TXT"))
//            if(self.methodvalueTxtField.getTextField()?.isEditing == true){
//                self.view.endEditing(true)
//                _ = self.methodvalueTxtField.getTextField()?.becomeFirstResponder()
//            }
//
//
//
//        }
        
        self.userSelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER_TO_WHOM")
        self.passSelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDER")
        if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct) {
            self.driverSelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROVIDER")
        }else{
            self.driverSelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER")
        }
        
        self.passSelImgView.image = UIImage(named:"ic_select_false")
        self.driverSelImgView.image = UIImage(named:"ic_select_false")
        GeneralFunctions.setImgTintColor(imgView: self.passSelImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.driverSelImgView, color: SColors.Theme)
        
        self.passSelView.handleClick { (Instance) in
            
            self.driverSelImgView.image = UIImage(named:"ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.driverSelImgView, color: SColors.Theme)
            self.passSelImgView.image = UIImage(named:"ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.passSelImgView, color: SColors.Theme)
            
            self.goPayuserSelValue = "Passenger"
        }
        
        self.driverSelView.handleClick { (Instance) in
            
            self.passSelImgView.image = UIImage(named:"ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.passSelImgView, color: SColors.Theme)
            self.driverSelImgView.image = UIImage(named:"ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.driverSelImgView, color: SColors.Theme)
            
            self.goPayuserSelValue = "Driver"
        }
        
        
        self.methodSearchBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_NEXT_TXT"))
        self.methodSearchBtn.clickDelegate = self
        
    }

    func resetGoPayTransferMoneyValue(){
        
        //self.setScrollViewHeight(height: 560)
        self.view.endEditing(true)
        self.goPayDataDic = nil
        self.goPayVerificationDic = nil
        _ = Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: "")
    
    }
    
    func goPayMoneyEnterSetup(){
        
        
        if(Configurations.isRTLMode()){
            self.sendMoneyBackImgView.image = self.sendMoneyBackImgView.image?.rotate(180)
        }
        
        self.goPaySubmitView.roundTo(corners:[.topLeft, .topRight], radius: 12)
        
        GeneralFunctions.setImgTintColor(imgView: self.sendMoneyBackImgView, color: UIColor.black)
        self.userProfileView.isHidden = false
        self.methodView.isHidden = true
        self.userSelView.isHidden = true
        self.goPayTransferMoneyView.backgroundColor = UIColor.clear
        
        self.sendMoneyCurrencyCodeLbl.isHidden = false
        self.sendMoneyCurrencyCodeLbl.text = userProfileJson.get("vCurrencyPassenger")
        
        self.sendMoneyBackImgView.handleClick { (Instance) in
            if(self.goPaySubmitView.isHidden == false){

                self.goPayTransferMoneyView.backgroundColor = UIColor.white
                self.userProfileView.isHidden = true
                self.methodView.isHidden = false
                self.userSelView.isHidden = false
                self.sendMoneyCurrencyCodeLbl.isHidden = true
                
                if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                    _ = Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: "")
                    self.goPayMoneyEnterSetup()
                    return
                }
                self.resetGoPayTransferMoneyValue()
                self.goPaySubmitView.isHidden = true

                return
            }
        }
        self.setScrollViewHeight(height: 655)
        self.transferState = "SEARCH"
        self.goPaySubmitView.isHidden = false
        
        self.searchUserNameLbl.text = goPayDataDic.get("vName")
        self.searchUserTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY_MSG")//goPayDataDic.get("eUserType") == "Driver" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER") : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDER")
        self.searchUserProfileImgView.sd_setImage(with: URL(string:goPayDataDic.get("vImgName")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        self.transferingAmtViewHeight.constant = 0
        self.transferingAmtView.isHidden = true
        //self.goPayAmountTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_TRANSFER_AMOUNT_TXT"))
        self.goPayAmountTxtField.onTextChangedDelegate = self
        self.goPayAmountTxtField.getTextField()!.keyboardType = .decimalPad
        self.goPayAmountTxtField.getTextField()?.textAlignment = .center
        self.goPayAmountTxtField.getTextField()?.isDividerHidden = true
        self.goPayAmountTxtField.getTextField()?.adjustsFontSizeToFitWidth = true
        self.goPayAmountTxtField.getTextField()?.minimumFontSize = 12
        self.goPaySubmitBtn.clickDelegate = self
        self.goPaySubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_TO") + " " + goPayDataDic.get("vName"))
        self.verificationInfoImgView.isHidden = true
        self.otpSentHintLbl.isHidden = true
        self.sendMoneyOTPTxtFiled.isHidden = true
        self.goPayAmountTxtField.isHidden = false
        self.amountAddImgView.isHidden = false
        self.amountMinusImgView.isHidden = false
        self.sendMoneyUserInfoView.isHidden = false
        self.sendMoneyUserInfoViewHeight.constant = 60
        
        self.goPayAmountTxtField.setText(text: self.enteredAmount)
        
        self.amountMinusImgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            var fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: self.enteredAmount) - 1.00
            if(fareInDigits < 0){
                fareInDigits = 0.00
            }
            self.enteredAmount = "\(fareInDigits)"
            self.goPayAmountTxtField.setText(text: String(format: "%.02f", fareInDigits))
          
        }
        
        GeneralFunctions.setImgTintColor(imgView: self.amountAddImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.amountMinusImgView, color: SColors.Theme)
        
        self.amountAddImgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            let fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: self.enteredAmount) + 1.00
            self.enteredAmount = "\(fareInDigits)"
            self.goPayAmountTxtField.setText(text: String(format: "%.02f", fareInDigits))
            
        }
        
    }
    
    
    func goPaySubmitMoney(){
        
        self.sendMoneyCurrencyCodeLbl.isHidden = true
        if(self.transferState.uppercased() == "SEARCH"){
            
            self.goPayMoneyEnterSetup()
            
        }else if(self.transferState.uppercased() == "ENTER_AMOUNT"){
            
            self.resendOtpView.handleClick { (Instance) in
                self.goPayAmountTxtField.setText(text: "0.00")
                self.searchUserForTransferMoney("ENTER_AMOUNT")
            }
            self.resendOtpLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESEND_OTP_TXT")
            GeneralFunctions.setImgTintColor(imgView: self.resendOtpImgView, color: SColors.Theme)
            
           // self.setScrollViewHeight(height: 685)
            self.goPayAmountTxtField.isHidden = true
            self.sendMoneyUserInfoView.isHidden = true
            self.sendMoneyUserInfoViewHeight.constant = -20
            self.amountAddImgView.isHidden = true
            self.amountMinusImgView.isHidden = true
            self.sendMoneyOTPTxtFiled.isHidden = false
            self.verificationInfoImgView.isHidden = false
            self.otpSentHintLbl.isHidden = false
            self.sendMoneyOTPTxtFiled.setText(text: "")
            self.otpSentHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER_WALLET_OTP_INFO_TXT")
            self.otpSentHintLbl.textColor = UIColor.red
            
            self.sendMoneyOTPTxtFiled.addImageView(color: SColors.Theme, transform: .identity, isCustomImage: true, "ic_fare_detail", 22,22) { (imageView) in
                self.openGoPayAlertViewWith(image:UIImage(named:"ic_gopayInfo")!, alertStr:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER_WALLET_OTP_INFO_TXT"))
            }
            
            
            GeneralFunctions.setImgTintColor(imgView: self.verificationInfoImgView, color: SColors.Theme)
            self.sendMoneyOTPTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_GOPAY_VERIFICATION_CODE"))
            self.goPaySubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_BUTTON_TXT"))
//            self.transferingAmtViewHeight.constant = 50
//            self.transferingAmtView.isHidden = false
            
            let amount =  Configurations.convertNumToAppLocal(numStr: String(GeneralFunctions.parseFloat(origValue: 0.0, data:self.enteredAmount)))
            self.transferingAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER_MONEY_TXT") + " " + userProfileJson.get("CurrencySymbol") + amount

        }
      
    }

    func searchUserForTransferMoney(_ state:String = ""){

        var parameters = ["fromUserId": GeneralFunctions.getMemberd(), "fromUserType": Utils.appUserType, "transferType":"", "searchUserType":self.goPayuserSelValue, "UserType":Utils.appUserType]
        
        if(self.transferState.uppercased() == "SEARCH"){
            parameters["type"] = "GopayCheckPhoneEmail"
            parameters["vPhoneOrEmailTxt"] = self.methodvalueTxtField.getTextField()?.text
        }else if(self.transferState.uppercased() == "ENTER_AMOUNT" || state == "ENTER_AMOUNT"){
            parameters["type"] = "GoPayVerifyAmount"
            parameters["fAmount"] = self.enteredAmount
            parameters["toUserId"] = self.goPayDataDic.get("iUserId")
            parameters["toUserType"] = self.goPayDataDic.get("eUserType")
            
        }else if(self.transferState.uppercased() == "VERIFY"){
            parameters["type"] = "GoPayTransferAmount"
            parameters["toUserId"] = self.goPayDataDic.get("iUserId")
            parameters["toUserType"] = self.goPayDataDic.get("eUserType")
            parameters["fAmount"] = self.enteredAmount
           
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.goPayTransferMoneyView, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
        

            if(response != ""){
                let dataDict = response.toDict()
                //                Utils.printLog(msgData: "dataDict:Balance:\(dataDict)")
                if(dataDict.get("Action") == "1"){
                    
            
                    if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                        self.resendOtpView.isHidden = true
                        self.goPayVerificationDic = dataDict.dictOf("message")
                        
                    }else{
                        self.goPayDataDic = dataDict.dictOf("message")
                    }
                   
                    self.goPaySubmitMoney()
                    
                }else if(dataDict.get("Action") == "2"){
                    
                    if(self.transferState.uppercased() == "VERIFY"){
                        self.updateWalletAmount()
                        self.closeSendMoneyView()
                        self.openGoPayAlertViewWith(image:UIImage(named:"ic_trip_finish_check")!, alertStr:dataDict.get(Utils.message_str), true, dataDict)
                        return
                    }else{
                        
                        if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                            self.transferState = "SEARCH"
                        }else if(self.transferState.uppercased() == "VERIFY"){
                            self.transferState = "ENTER_AMOUNT"
                        }else{
                            self.transferState = ""
                        }
                        
                        self.generalFunc.setError(uv: nil, title: "", content: dataDict.get(Utils.message_str))
                    }
                    
                }else{
                
                    if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                        self.transferState = "SEARCH"
                    }else if(self.transferState.uppercased() == "VERIFY"){
                        self.transferState = "ENTER_AMOUNT"
                        if(dataDict.get(Utils.message_str) == "LBL_OTP_EXPIRED"){
                            self.resendOtpView.isHidden = false
                            self.openGoPayAlertViewWith(image:UIImage(named:"ic_gopay_resend_alert")!, alertStr:self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                            return
                        }
                    }else{
                        self.transferState = ""
                    }
                    
                    if(dataDict.get(Utils.message_str) == "LBL_WALLET_AMOUNT_GREATER_THAN_ZERO" || dataDict.get("showAddMoney").uppercased() == "YES"){
                        
                        if(self.userProfileJson.get("APP_PAYMENT_MODE").uppercased() == "CASH"){
                            self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                            
                                }
                                
                            })
                        }else{
                            self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                                    self.closeSendMoneyView()
                                    self.resetGoPayTransferMoneyValue()
                                    self.perform(#selector(self.openAddMoneyView), with: nil, afterDelay: 0.5)
                                }
                                
                            })
                        }
                        
                        
                        return
                    }
                    self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                
                if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                    self.transferState = "SEARCH"
                }else if(self.transferState.uppercased() == "VERIFY"){
                    self.transferState = "ENTER_AMOUNT"
                }else{
                    self.transferState = ""
                }
                self.generalFunc.setError(uv: nil)
            }
        })
    }
    
    func openGoPayAlertViewWith(image:UIImage, alertStr:String, _ isForSuccess:Bool = false, _ dataDic:NSDictionary = [:]){
        self.goPayCustomAlertView.frame = CGRect(x:0, y:0, width:Application.screenSize.width, height: Application.screenSize.height)
        Application.window?.addSubview(self.goPayCustomAlertView)
        self.view.endEditing(true)
        self.goPayAlertDoneBtn.clickDelegate = self
        self.goPayAlertDoneBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"))
        self.gopayAlertHLbl.text = alertStr
        self.goPayAlertBGView.isHidden = false
        self.goPayAlertView.isHidden = false
        self.goPayAlertImgView.image = image
        self.goPayAlertImgView.backgroundColor = UIColor.white
        GeneralFunctions.setImgTintColor(imgView: self.goPayAlertImgView, color: SColors.Theme)
        
        if(UIImage(named:"ic_gopay_resend_alert") == image){
            
            self.goPayAlertImgView.image = image.addImagePadding(x: 20, y: 20)
            self.goPayAlertImgView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: self.goPayAlertImgView, color: UIColor.white)
        }
        
        if(isForSuccess == true){
            let profData = dataDic.dictOf("message_profile_data")
            self.goPayAlertView.isHidden = true
            self.goPayAlertSuccessView.isHidden = false
            self.goPayAlertSuccessHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUCCESSFULLY")
            self.goPaySuccessSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY_TO")
            self.goPaySuccessSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY_TO") + " " +  goPayDataDic.get("vName")
            //let amount =  Configurations.convertNumToAppLocal(numStr: String(GeneralFunctions.parseFloat(origValue: 0.0, data:self.enteredAmount)))
            let amount =  Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: self.enteredAmount)))
            self.goPaySuccessAmountLbl.text = userProfileJson.get("CurrencySymbol") + " " + amount
            self.goPaySuccessProfileNameLbl.text = goPayDataDic.get("vName")
            self.goPaySuccessProfileImgView.sd_setImage(with: URL(string:goPayDataDic.get("vImgName")), placeholderImage:UIImage(named:"ic_no_pic_user"))
            
            let finalStr = NSMutableAttributedString.init(string: "")
//            finalStr.append(self.getAttributedString(str:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSACTION_DONE"),color:UIColor(hex: 0x646464)))
//            finalStr.append(self.getAttributedString(str: " " + Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: profData.get("transactionDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateInList),color:UIColor(hex: 0x020202)))
            finalStr.append(self.getAttributedString(str:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSACTION_DONE") + "\n",color:UIColor(hex: 0x646464)))
            finalStr.append(self.getAttributedString(str: " " + Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dataDic.get("transactionDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime),color:UIColor(hex: 0x020202)))
            self.goPaySuccessDateLbl.attributedText = finalStr
            
            self.goPayAlertSuccessDoneBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONE"))
            self.goPayAlertSuccessDoneBtn.clickDelegate = self
            
            if(Application.screenSize.height > 568){
                self.goPaySuccessViewWidth.constant = 350
                self.goPaySuccessViewHeight.constant = 560
            }
        }else{
            self.goPayAlertSuccessView.isHidden = true
        }
        
    }
    
    func hideGoPayAlertView(){
        
        self.goPayCustomAlertView.removeFromSuperview()
        self.goPayAlertBGView.isHidden = true
        self.goPayAlertView.isHidden = true
        
        if(self.transferState.uppercased() == "VERIFY"){
            self.resetGoPayTransferMoneyValue()
            
        }
        
    }/* ......... */
    
    func myBtnTapped(sender: MyButton) {
        
        /* GOPAY CHANGES*/
        
        if(sender == self.transferMoneyBtn){
            
            if(self.transferMoneyBtn.buttonTitle == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY")){
                
                if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                    _ = Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: "")
                    self.goPayMoneyEnterSetup()
                    return
                }
                self.resetGoPayTransferMoneyValue()
                self.goPaySubmitView.isHidden = true
                self.goPayBackImgView.isHidden = true
                
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY_TO_WALLET")
                
                self.transferMoneyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRANSFER_MONEY"))
                
                self.addMoneyHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY").uppercased()
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LEFT_MENU_WALLET")
               
                self.goPayTransferMoneyView.isHidden = true
               
                
                self.moneyTxtField.setText(text: "0.00")
                
            }else{
                
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY_TO_WALLET")
                
                self.goPayTransferMoneyView.isHidden = false
                self.addMoneyHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_MONEY").uppercased()
                
                self.transferMoneyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_MONEY"))
                
                self.setScrollViewHeight(height: 560)
            }
            
        }
        
        if(sender == self.goPayAlertDoneBtn || sender == self.goPayAlertSuccessDoneBtn){
            self.hideGoPayAlertView()
            return
        }
        
        if(sender == goPaySubmitBtn){
            
            if(self.transferState.uppercased() == "ENTER_AMOUNT"){
                var required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                let vEntered = Utils.checkText(textField: self.sendMoneyOTPTxtFiled.getTextField()!) ? true : Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: required_str)
                if(vEntered == false){
                    _ = Utils.setErrorFields(textField: self.sendMoneyOTPTxtFiled.getTextField()!, error: required_str)
                    return
                }
                
                if(self.goPayVerificationDic.get("verificationCode") == self.sendMoneyOTPTxtFiled.getTextField()!.text!){
                    self.transferState = "VERIFY"
                    self.searchUserForTransferMoney()
                }else{
                    required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VERIFICATION_CODE_INVALID")
                    _ = Utils.setErrorFields(textField: self.sendMoneyOTPTxtFiled.getTextField()!, error: required_str)
                }
                return
              
            }else{
                
                let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                let error_money = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_CORRECT_DETAIL_TXT")
                
                let amount_str = Configurations.convertNumToEnglish(numStr: Utils.getText(textField: self.goPayAmountTxtField.getTextField()!))
                let moneyEntered = Utils.checkText(textField: self.goPayAmountTxtField.getTextField()!) ? ((GeneralFunctions.parseFloat(origValue: 0.0, data: amount_str) > 0 && amount_str.isNumeric()) ? true: Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: error_money)) : Utils.setErrorFields(textField: self.goPayAmountTxtField.getTextField()!, error: required_str)
                
                if(moneyEntered == false){
                    return
                }
                
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_CONFIRM_TRANSFER_TO_WALLET_TXT") + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_CONFIRM_TRANSFER_TO_WALLET_TXT1") + " " + goPayDataDic.get("vName"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        
                        self.transferState = "ENTER_AMOUNT"
                        self.enteredAmount = self.goPayAmountTxtField.getTextField()!.text!
                        self.searchUserForTransferMoney()
                        return
                    }
                    
                })
            }
            
            return
        }
        
        if(sender == methodSearchBtn){
        
            self.transferState = "SEARCH"
            let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")

            if(self.goPayuserSelValue == ""){
                self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ANY_MEMBER_OPTION_TXT"))
                return
            }
            
            
            let emailEntered = Utils.checkText(textField: self.methodvalueTxtField.getTextField()!) ? (Utils.getText(textField: self.methodvalueTxtField.getTextField()!).isNumeric() ? (Utils.getText(textField: self.methodvalueTxtField.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.methodvalueTxtField.getTextField()!, error: mobileInvalid)) : (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.methodvalueTxtField.getTextField()!)) ? true :  Utils.setErrorFields(textField: self.methodvalueTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR_TXT")) )) : Utils.setErrorFields(textField: self.methodvalueTxtField.getTextField()!, error: required_str)
            if (emailEntered == false) {
                return;
            }
            
            
            self.searchUserForTransferMoney()
            return
        }/* .........*/
        
        
        if(sender == addMoneyBtn){
            let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            let error_money = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_CORRECT_DETAIL_TXT")
            
            let amount_str = Configurations.convertNumToEnglish(numStr: Utils.getText(textField: self.moneyTxtField.getTextField()!))

//            let moneyEntered = Utils.checkText(textField: self.moneyTxtField.getTextField()!) ? ((Utils.getText(textField: self.moneyTxtField.getTextField()!) != "0" && Utils.getText(textField: self.moneyTxtField.getTextField()!).isNumeric()) ? true: Utils.setErrorFields(textField: self.moneyTxtField.getTextField()!, error: error_money)) : Utils.setErrorFields(textField: self.moneyTxtField.getTextField()!, error: required_str)
//
//            if(moneyEntered){
//                addMoneyToWallet()
//            }
            let moneyEntered = Utils.checkText(textField: self.moneyTxtField.getTextField()!) ? ((amount_str != "0" && amount_str.isNumeric()) ? true: Utils.setErrorFields(textField: self.moneyTxtField.getTextField()!, error: error_money)) : Utils.setErrorFields(textField: self.moneyTxtField.getTextField()!, error: required_str)
            
            if(moneyEntered){
                
                self.closeAddMoneyView()
                self.moneyTxtField.setText(text: "0.00")

                var url = self.userProfileJson.get("PAYMENT_BASE_URL") + "&PAGE_TYPE=WALLET_MONEY_ADD"
                url = url + "&currency=" + "" + userProfileJson.get("vCurrencyPassenger")
                url = url + "&AMOUNT=" + "\(amount_str)"
                
                GeneralFunctions.addPayment(url: url, uv: self)
                
            }
        }else if(sender == viewTransactionBtn){
            
            let transactionHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "TransactionHistoryTabUV") as! TransactionHistoryTabUV

            self.push(uv: transactionHistoryTabUV)
        
        }
    }

    func myLableTapped(sender: MyLabel) {
        if(sender == moneyLbl1){
            let fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: Configurations.convertNumToEnglish(numStr: moneyLbl1.text!))
            self.enteredAmount = moneyLbl1.text!
            moneyTxtField.setText(text: String(format: "%.02f", fareInDigits))
        }else if(sender == moneyLbl2){
            let fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: Configurations.convertNumToEnglish(numStr: moneyLbl2.text!))
            self.enteredAmount = moneyLbl2.text!
            moneyTxtField.setText(text: String(format: "%.02f", fareInDigits))
        }else if(sender == moneyLbl3){
            let fareInDigits = GeneralFunctions.parseDouble(origValue: 0.00, data: Configurations.convertNumToEnglish(numStr: moneyLbl3.text!))
            self.enteredAmount = moneyLbl3.text!
            moneyTxtField.setText(text: String(format: "%.02f", fareInDigits))
        }
    }
    
    
    func addMoneyToWallet(amount:String){
        let parameters = ["type":"addMoneyUserWallet","iMemberId": GeneralFunctions.getMemberd(), "fAmount": amount, "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.addMoneyPopupView, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                self.moneyTxtField.setText(text: "0.00")
                if(dataDict.get("Action") == "1"){
                    
                    if(self.userProfileJson.get("user_available_balance") != dataDict.get("MemberBalance")){
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    
                    self.balanceVLbl.text = Configurations.convertNumToAppLocal(numStr: dataDict.get("MemberBalance"))
                    
                    self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")))
                   
                    self.refreshTransactions()
                    if(self.addMoneyPopupView != nil){
                        self.closeAddMoneyView()
                        
                    }
                  
                }else{
                    
                    if(dataDict.get(Utils.message_str) == "LBL_NO_CARD_AVAIL_NOTE"){
//                        LBL_NO_CARD_AVAIL_NOTE
                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Add Card", key: "LBL_ADD_CARD"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                
                                if(self.addMoneyPopupView != nil){
                                    self.closeAddMoneyView()
                                }
                                
                                let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
                                self.push(uv: paymentUV)
                            }
                            
                        })
                        
                        return
                    }
                    self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                self.generalFunc.setError(uv: nil)
            }
        })
    }
    
    func updateWalletAmount(_ fromWebView:Bool = false, _ isFromViewLoad:Bool = false){
        updateAmountIndicator.startAnimating()
        updateAmountIndicator.isHidden = false
        self.balanceVLbl.text = "  "
        let parameters = ["type":"GetMemberWalletBalance", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.updateAmountIndicator.stopAnimating()
            self.updateAmountIndicator.isHidden = true
            
            if(response != ""){
                let dataDict = response.toDict()
//                Utils.printLog(msgData: "dataDict:Balance:\(dataDict)")
                if(dataDict.get("Action") == "1"){
                    
                    print(dataDict)
                    if(self.userProfileJson.get("user_available_balance") != dataDict.get("MemberBalance")){
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: dataDict.get("user_available_balance_amount") as AnyObject)   // Without Currency Symbole
                    
                    GeneralFunctions.saveValue(key: "user_available_balance", value: dataDict.get("user_available_balance") as AnyObject) // With Currency Symbole
                    
                    if(isFromViewLoad == false){
                        self.refreshTransactions()
                    }
                    
                    if(self.addMoneyPopupView != nil && isFromViewLoad != true){
                        self.closeAddMoneyView()
                    }
                    
                    self.balanceVLbl.text = Configurations.convertNumToAppLocal(numStr: dataDict.get("MemberBalance"))
                    if(fromWebView == true){
                        self.closeWebView()
                    }
                    
                }else{
                    if(fromWebView == true){
                        self.closeWebView()
                    }
                    self.balanceVLbl.text = "--"
                }
                
            }else{
                if(fromWebView == true){
                    self.closeWebView()
                }
                self.balanceVLbl.text = "--"
            }
        })
    }
    
    /* PAYMENT FLOW CHANGES */
    func closeWebView(){

        UIBarButtonItem.appearance().tintColor = SColors.ThemeTxt
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        self.scrollView.scrollToTop()
        self.webView.isHidden = true
        self.webView.navigationDelegate = nil
        self.webView.removeFromSuperview()
        if(activityIndicator != nil){
            activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
 
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            

            if (urlString.contains(find: "success=1")){
                
                self.updateWalletAmount(true)
                
                
            }else if (urlString.contains(find: "success=0")){
                
                let snippet = urlString
                
                if let range = snippet.range(of: "message=") {
                    let message = snippet[range.upperBound...]
                    self.generalFunc.setError(uv: self, title: "", content: String(message).removingPercentEncoding ?? "")
                    self.closeWebView()
                    decisionHandler(.allow)
                }
                
                self.closeWebView()
                self.generalFunc.setError(uv: self)
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicator.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicator.stopAnimating()
        }
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    // NEw Flow Changes
    func getDtata(){
        
        if(self.isDataLoading == true){
            self.setPlaceHolderView()
            self.contentView.alpha = 0
        }
        
        self.viewAll.isUserInteractionEnabled = false
        self.viewDebit.isUserInteractionEnabled = false
        self.viewCredit.isUserInteractionEnabled = false
        
        
        
        self.addFooterView()
        let parameters = ["type": "getTransactionHistory", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "page": self.nextPage_str.description, "ListType": LIST_TYPE]
        
        //        , "TimeZone": "\(DateFormatter().timeZone.identifier)"
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.isDataLoading = false
                self.contentView.alpha = 1
                self.removePlaceHolderView()
                
            }, completion:{ _ in})
           
            self.viewAll.isUserInteractionEnabled = true
            self.viewDebit.isUserInteractionEnabled = true
            self.viewCredit.isUserInteractionEnabled = true
            if self.isViewGone {
                self.isDataLoading = true
            }
            if(response != ""){
                
                let dataDict = response.toDict()
                
                if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                    Utils.printLog(msgData: "SESSION_OUT_CALLED")
                    if(GeneralFunctions.isAlertViewPresentOnScreenWindow(viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG) == false){
                        
                        self.generalFunc.setAlertMessage(uv: nil , title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG, completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                            
                            
                            GeneralFunctions.logOutUser()
                            GeneralFunctions.restartApp(window: Application.window!)
                        })
                    }
                    
                    return
                }
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList += [dataTemp]
                        
                    }
                    let NextPage = dataDict.get("NextPage")
                    
                    if(NextPage != "" && NextPage != "0"){
                        self.isNextPageAvail = true
                        self.nextPage_str = Int(NextPage)!
                        
                        self.addFooterView()
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
                    
                    self.transactionTableView.reloadData()
                    self.transactionTableView.isScrollEnabled = true
                    if self.dataArrList.count == 0 {
                        self.messageLbl.isHidden = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.messageLbl.isHidden = true
                    }
                    
                    
                }else{
                    if(self.isLoadingMore == false){
//                        self.safeLbl.isHidden = true
                        self.messageLbl.isHidden = false
                        self.transactionTableView.isScrollEnabled = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.messageLbl.isHidden = true
                        self.transactionTableView.isScrollEnabled = true
                        
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
                    
                }
                
                //                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                
                
            }else{
                if(self.isLoadingMore == false){
                    self.messageLbl.isHidden = true
                    self.transactionTableView.isScrollEnabled = true
                    
                    self.generalFunc.setError(uv: self)
                }
            }
            
            self.isLoadingMore = false
            

            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.dataArrList.count > 0){
            self.safeLbl.isHidden = false
            self.parellexBottomView.isHidden = false
        }
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 85
        }else{
           return 80
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryListTVCell", for: indexPath) as! TransactionHistoryListTVCell
        
        let item = self.dataArrList[indexPath.item]
        
        cell.moneyLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("iBalance"))
        cell.descriptionLbl.text = item.get("tDescription")
      //  cell.dateLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: item.get("dDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateInList)
        
        let tTripBookingDateOrig = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: item.get("dDateOrig"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime)
        
        let tTripBookingDateOrigNameStr = tTripBookingDateOrig.components(separatedBy: ",")[0]
        
        let tTripBookingDayMonthStr = tTripBookingDateOrig.components(separatedBy: ",")[1].components(separatedBy: " ")
        let tTripBookingMonthStr = tTripBookingDayMonthStr[1]
        let tTripBookingDayStr = tTripBookingDayMonthStr[2]
        
        let tTripBookingTimeYearStr = tTripBookingDateOrig.components(separatedBy: ",")[2].components(separatedBy: " ")
        
        let tTripBookingYearStr = tTripBookingTimeYearStr[1]
        
        cell.dateLbl.text = String(format: "%@ %@, %@ (%@)", tTripBookingDayStr, tTripBookingMonthStr, tTripBookingYearStr, tTripBookingDateOrigNameStr)
        
        if(item.get("eType").uppercased() == "CREDIT"){
            cell.indicatorImgView.image = UIImage.init(named: "ic_credit_new")
            
        }else{
            cell.indicatorImgView.image = UIImage.init(named: "ic_debit_new")
           
        }
        if(Configurations.isRTLMode()){
            cell.dateLbl.textAlignment  = .right
        }else{
            cell.dateLbl.textAlignment  = .left
        }
        cell.moneyLbl.textColor = SColors.Theme
        cell.dateLbl.textColor = SColors.Theme
        cell.highLightView.isHidden = true
        cell.sepratorLbl.isHidden = true
        cell.containerView.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
        cell.containerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 8)
//        if self.dataArrList.count != 1 {
//        if indexPath.row == 0 {
//
//            cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
//            cell.containerView.roundCorners(corners: [.topRight, .topLeft],amount: 15)
//            cell.containerViewTop.constant = 5
//
//        }else {
//            cell.containerViewTop.constant = 0
//        }
//
//        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//            cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
//            cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 15)
//            cell.sepratorLbl.isHidden = true
//            cell.containerViewBottom.constant = 5
//        }else {
//            cell.containerViewBottom.constant = 0
//            cell.sepratorLbl.isHidden = false
//            if indexPath.row != 0 {
//                cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
//            }
//            //cell.containerView.roundCorners(corners: [.bottomLeft, .bottomLeft],amount: 0)
//            cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
//        }
//        }else{
//            cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
//            cell.containerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 15)
//            cell.sepratorLbl.isHidden = true
//            cell.containerViewBottom.constant = 5
//            cell.containerViewTop.constant = 5
//        }

        

        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryListTVCell" ) as! TransactionHistoryListTVCell
//        let cornerRadius = 15
//        var corners: UIRectCorner = []
//
//        if indexPath.row == 0
//        {
//            corners.update(with: .topLeft)
//            corners.update(with: .topRight)
//        }
//
//        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
//        {
//            corners.update(with: .bottomLeft)
//            corners.update(with: .bottomRight)
//        }
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect:  cell.containerView.bounds,
//                                      byRoundingCorners: corners,
//                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
//        cell.containerView.layer.mask = maskLayer
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        
        if (maximumOffset - currentOffset <= 15) {
            
            if(isNextPageAvail==true && isLoadingMore==false){
                
                isLoadingMore=true
                
                getDtata()
            }
        }
    }
    
    func addFooterView(){
        let loaderView =  self.generalFunc.addMDloader(contentView: self.transactionTableView, isAddToParent: false)
        loaderView.backgroundColor = UIColor.clear
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.transactionTableView.tableFooterView  = loaderView
        self.transactionTableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.transactionTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.transactionTableView.tableFooterView?.isHidden = true
    }
    
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    func refreshTransactions(){
        self.messageLbl.isHidden = true
        self.dataArrList.removeAll()
        self.transactionTableView.reloadData()
        self.nextPage_str = 1
        self.isLoadingMore = false
        self.isNextPageAvail = false
        self.getDtata()
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        //view.shadowPath = UIBezierPath(roundedRect:view.bounds, cornerRadius:view.layer.cornerRadius).cgPath
    }
    
    func addCharge(){
        let parameters = ["type":"addMoneyUserWalletByChargeCard","iMemberId": GeneralFunctions.getMemberd(), "fAmount": OrignalMount, "UserType": Utils.appUserType,"vPayBy": strPaymentType ,"vChargedCurrency" : self.currencyPass ,"vChargedAmount" : self.AmountPass,"txref" : txref,"eSystem": "DeliverAll"]
                        
                        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
                        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
                        exeWebServerUrl.currInstance = exeWebServerUrl
                        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                            
                            if(response != ""){
                                let dataDict = response.toDict()
                                self.isCard = false
                                self.strPaymentType = ""
                                if(self.addMoneyPopupView != nil){
                                    self.moneyTxtField.setText(text: "0.00")
                                }
                                if(dataDict.get("Action") == "1"){
                                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: dataDict.get("user_available_balance_amount") as AnyObject)   // Without Currency Symbole
                                                       
                                GeneralFunctions.saveValue(key: "user_available_balance", value: dataDict.get("user_available_balance") as AnyObject) // With Currency Symbole
                                                       
                                if(self.userProfileJson.get("user_available_balance") != dataDict.get("MemberBalance")){
                                                           GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                                                       }
                                                       
                                                       
                                                       self.balanceVLbl.text = Configurations.convertNumToAppLocal(numStr: dataDict.get("MemberBalance"))
                                  
                                        self.refreshTransactions()
                                    
                                    
                                    if(self.addMoneyPopupView != nil){
                                        self.closeAddMoneyView()
                                    }
                                    
                                }else{
                                    if(self.addMoneyPopupView != nil){
                                        //self.closeAddMoneyView()
                                    }
                                   // self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))

                                }
                                
                            }else{
                                if(self.addMoneyPopupView != nil){
                                   // self.closeAddMoneyView()
                                }
                                self.generalFunc.setError(uv: nil)
                            }
                        })
    }
    
    // placehoder View Changes
    func setPlaceHolderView(){
            self.placeHolderView.alpha = 1.0
            placeholderMarker = Placeholder()
        let viewElements: [UIView] = [ parentPhView2, parentPhView3, parentPhView4 ,parentPhView5,parentPhView6,parentPhView7,parentPhView8]
            
            placeholderMarker.register(viewElements)
            placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.placeHolderView != nil){
            self.contentView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.placeHolderView.alpha = 0.0},
                                            completion: {(value: Bool) in
                                                if(self.placeholderMarker != nil){
                                                    self.placeholderMarker.remove()
                                                }
                                                
                                                        })
        }
    }
    @IBAction func unwindToManageWallet(_ segue:UIStoryboardSegue) {
        self.isFromSuceccesPayment = true
        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_MONEY_CREDITED"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
            self.refreshTransactions()
           
        })
    }
    
}
extension UIView {
    
    func round(corners: UIRectCorner, cornerRadius: Double) {
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
     
        enum Corner:Int {
            case bottomRight = 0,
            topRight,
            bottomLeft,
            topLeft
        }
        
        private func parseCorner(corner: Corner) -> CACornerMask.Element {
            let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            return corners[corner.rawValue]
        }
        
        private func createMask(corners: [Corner]) -> UInt {
            return corners.reduce(0, { (a, b) -> UInt in
                return a + parseCorner(corner: b).rawValue
            })
        }
        
        func roundCorners(corners: [Corner], amount: CGFloat = 5) {
            layer.cornerRadius = amount
            let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
            layer.maskedCorners = maskedCorners
        }
      
   
}
