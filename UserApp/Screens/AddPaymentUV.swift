

import UIKit
import SysBaseLib
import WebKit
import IQKeyboardManagerSwift
import Lottie


class AddPaymentUV: ParentViewUV, MyBtnClickDelegate, WKNavigationDelegate, ParentViewUVDelegate, WKUIDelegate { // CardIOPaymentViewControllerDelegate
    
    var PAGE_HEIGHT:CGFloat = 595
    
    @IBOutlet weak var noInternetRetryLbl: MyLabel!
    @IBOutlet weak var noInternetLbl: MyLabel!
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var closeImgView: UIImageView!
    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
   
    var webView: WKWebView!
    var cntView:UIView!
    
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    
    var paymentUv:PaymentUV!
    var rentItemNewPostUV:RentItemNewPostUV!
    var isFromUFXPayMode = false
    var isFromCheckOut = false
    var isFromMainScreen = false

    var loadingDialog:NBMaterialLoadingDialog!
  
    var payMentMethod = ""
    var PAGE_MODE = "ADD"
    var paymentUrl = ""
    
    var uv:UIViewController!
    
    var loaderView:UIView!
    
    var isFirstLoad = false
    var isGetDetailCalled = false
    
    var isGenieOrderPlaced = false
    
    var appliedPromoCode = ""
    var isPromoCodeAppliedManually = false
    var isFromFly = false
    var currentCabGeneralType = Utils.cabGeneralType_Ride
    var destLocation:CLLocation!
    var destAddress = ""
    var pickUpLocation:CLLocation!
    var currentLat = ""
    var currentLong = ""
    var selectedLat = ""
    var selectedLong = ""
    var failedUrlString = ""
    
    typealias completionHandler = (_ data:String) -> Void
    var completionHandler:completionHandler!
    
    var animationView:AnimationView!
    var isCompletionFromSegue = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            
            self.addBack()
            
            cntView = self.generalFunc.loadView(nibName: "AddPaymentScreenDesign", uv: self, contentView: self.contentView)
            
            cntView.frame.size = CGSize(width: cntView.frame.width, height: PAGE_HEIGHT)
           // self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
            
            self.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
            self.contentView.addSubview(cntView)
           // self.scrollView.bounces = false
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.payMentMethod = userProfileJson.get("APP_PAYMENT_METHOD")
           // self.contentView.isHidden = true
        
            if(self.paymentUrl != "" && self.isFirstLoad == false){
                self.webView = WKWebView.init(frame: CGRect(x: 0, y:0, width: Application.screenSize.width, height: Application.screenSize.height))
            }
            animationView = self.perofrmLoginAnimation()
            self.animationView.play()
            
        }else if(type == 1){
            
            if(self.isFirstLoad == true && self.completionHandler != nil && self.isCompletionFromSegue == false){
                self.completionHandler(self.appliedPromoCode)
            }else{
                self.isCompletionFromSegue = false
            }
            
            self.configRTL()
            self.navigationController?.navigationBar.zPosition = 1
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            Configurations.setDefaultNavBar()
            
            
        }else if(type == 2){
            cntView.frame.size = CGSize(width: Application.screenSize.width, height: Application.screenSize.height)
           // self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: cntView.frame.height)
            
            self.closeImgView.handleClick { instance in
                self.close()
            }
        
            if(self.paymentUrl != "" && self.isFirstLoad == false){
                
                self.webView.frame = CGRect(x: 0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
                self.webView.configuration.preferences.javaScriptEnabled = true
                self.webView.isHidden = true
                self.webView.scrollView.bounces = false
                self.webView.navigationDelegate = self
                self.webView.backgroundColor = UIColor.clear
                self.contentView.addSubview(self.webView)
                self.webView.scrollView.contentInsetAdjustmentBehavior = .never
                self.webView?.uiDelegate = self
               

                self.contentView.isHidden = false
                
                print("URLLL:\(self.paymentUrl)")
                
                self.webView.navigationDelegate = self
                
                self.failedUrlString = paymentUrl
                self.webView.load(URLRequest(url: URL(string: self.paymentUrl)!))
                
                self.isFirstLoad = true
            }
            
            setData()
            
           // self.handleNoInternetView()
            self.noInternetLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_INTERNET_TXT")
            self.noInternetRetryLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RETRY_TXT")
            self.noInternetRetryLbl.handleClick(clickHandler: { (instance) in
                
                if(InternetConnection.isConnectedToNetwork() == true){
                    self.animationView.isHidden = false
                    self.animationView.play()
                    Utils.delayWithSeconds(1.0) {
                        if(self.failedUrlString != ""){
                            self.webView.load(URLRequest(url: URL(string: self.failedUrlString)!))
                            self.failedUrlString = ""
                        }else{
                            self.webView.load(URLRequest(url: URL(string: self.paymentUrl)!))
                        }
                        
                    }
                    
                    self.noInternetView.isHidden = true
                }
                
            })
          
        }else if(type == 3){
            Configurations.setAppThemeNavBar()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
            WKWebsiteDataStore.default().removeData(ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeLocalStorage], modifiedSince: Date(timeIntervalSince1970: 0), completionHandler:{ })
        }
    }
    
    func handleNoInternetView(){
        animationView.isHidden = true
        self.webView.isHidden = true
        self.noInternetView.isHidden = false
    }
    

    func perofrmLoginAnimation() -> AnimationView?{
        
        let jsonName = "payment"
        let animationView = AnimationView.init(name: jsonName)

        animationView.frame = CGRect(x: (Application.screenSize.width / 2) - 75, y: (Application.screenSize.height / 2) - 75, width: 150, height: 150)
          
          // 3. Set animation content mode
          
        animationView.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
        animationView.loopMode = .loop
          
          // 5. Adjust animation speed
          
        //animationView.animationSpeed = 0.5
          
        self.contentView.addSubview(animationView)
        //Application.window!.addSubview(view)
          
          // 6. Play animation
          
       // animationView.play()
        
        return animationView
    }
    
    
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {

        if(defaultText != nil && (defaultText == "OPEN_PROMOCODE" || defaultText!.starts(with: "OPEN_PROMOCODE"))){
            
            let promoStrArray = defaultText!.components(separatedBy: "_")
            
            self.appliedPromoCode = (promoStrArray.count > 2) ? promoStrArray.last! : ""
            
            let selectPromoCodeUV = GeneralFunctions.instantiateViewController(pageName: "SelectPromoCodeUV") as! SelectPromoCodeUV
            selectPromoCodeUV.appliedPromoCode = appliedPromoCode
            selectPromoCodeUV.isPromoCodeAppliedManually = isPromoCodeAppliedManually
            selectPromoCodeUV.isFromFly = self.isFromFly
            selectPromoCodeUV.isFromPromoCode = true
            selectPromoCodeUV.currentCabgeneralType = self.currentCabGeneralType
            selectPromoCodeUV.selectedLat = selectedLat
            selectPromoCodeUV.selectedLong = selectedLong
            selectPromoCodeUV.currentLat = currentLat
            selectPromoCodeUV.currentLong = currentLong
            self.push(uv: selectPromoCodeUV)
            self.completionHandler = completionHandler
            
            return
        }
        
        if(defaultText != nil && defaultText == "PROMO_REMOVED"){
            self.appliedPromoCode = ""
            completionHandler("")
            return
        }
    
        
 
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        self.generalFunc.setAlertMessage(uv: nil, title: "", content: message, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn:"", completionHandler: { (btnClickedIndex) in
            
            completionHandler()
            
        })
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

        self.generalFunc.setAlertMessage(uv: nil, title: "", content: message, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
            
            if(btnClickedIndex == 0){
                completionHandler(true)
            }else{
                completionHandler(false)
            }
            
        })
        
    }
    
    func setData(){
        
        //CardIOUtilities.preload()
    }
    
    func myBtnTapped(sender: MyButton) {
        
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        
        DispatchQueue.main.async {
            if let urlString = navigationAction.request.url?.absoluteString{
                print(urlString)
                if(urlString.contains(find: "gift_action=success")){
                    self.performSegue(withIdentifier: "unwindToViewProfileScreen", sender: self)
                    return
                }

                if (urlString.contains(find: "BUSINESS_PROFILE_SETUP=Yes")){
                    
                    self.close()
                    
                    let businessProfileUV = GeneralFunctions.instantiateViewController(pageName: "BusinessProfileUV") as! BusinessProfileUV
                    Application.window?.rootViewController!.push(uv: businessProfileUV)
                    
                    
                    return
                }
                
                
                if (urlString.contains(find: "OPEN_IN_APP_WALLET=Yes")){
                    
                    self.close()
                    
                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                    Application.window?.rootViewController!.push(uv: manageWalletUV)
                    
                    
                    return
                }
                
                if (urlString.contains(find: "result.php?success=1") || urlString.contains(find: "success=1")){
                    
//                    if(self.loaderView != nil){
//                        self.loaderView.isHidden = true
//                    }
                    self.animationView.pause()
                    self.animationView.isHidden = true
                   // self.closeImgView.isHidden = true
                    
                    self.navigationItem.setHidesBackButton(true, animated:false);
                   
                    UIBarButtonItem.appearance().tintColor = SColors.ThemeTxt
                    
                    if(self.uv != nil && self.uv!.isKind(of: RentItemNewPostUV.self)) {
                        if self.rentItemNewPostUV != nil {
                            self.close()
                            self.rentItemNewPostUV.loadTripFinishView()
                           return
                        }
                    }
                    if(self.uv != nil && self.uv!.isKind(of: BookingSummaryUV.self)) {
                       let temp = self.uv! as! BookingSummaryUV
                        
                        let snippet = urlString
                        if let range = snippet.range(of: "iAuthorizePaymentId=") {
                        let id = snippet[range.upperBound...]
                        temp.authPaymentID = String(id)
                        self.close()
                        temp.bookRide()
                           return
                        }
                        self.close()
                        temp.bookRide()
                    }
                    if(self.uv != nil && self.uv!.isKind(of: AskForPay.self) && urlString.contains(find: "paymentModeSelected=Yes")){
                        self.performSegue(withIdentifier: "unwindToAskForPayUV", sender: self)
                        return
                    }else if(self.uv != nil && self.uv!.isKind(of: UFXCheckOutUV.self) && urlString.contains(find: "paymentModeSelected=Yes")){
                        self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
                        return
                    }else if(self.uv != nil && self.uv!.isKind(of: GenieFindStoreUV.self)){
                        if(urlString.contains(find: "message=LBL_MANUAL_STORE_THANK_YOU_ORDER_PLACE_ORDER")){
                            self.isGenieOrderPlaced = true
                        }
                        self.performSegue(withIdentifier: "unwindToGenieFindStore", sender: self)
                        return
                    }else if(self.uv != nil && self.uv!.isKind(of: CheckOutUV.self)){
                        
                        if(urlString.contains(find: "message=LBL_MANUAL_STORE_THANK_YOU_ORDER_PLACE_ORDER")){
                            self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
                            return
                        }
                        
                    }else if(self.uv != nil && self.uv!.isKind(of: RatingUV.self)){
                        self.performSegue(withIdentifier: "unwindToRatingUV", sender: self)
                    }else if (self.uv != nil && self.uv!.isKind(of: BiddingDetialsUV.self)){
                        self.performSegue(withIdentifier: "unwindToBiddingDetials", sender: self)
                    }else if (self.uv != nil && self.uv!.isKind(of: ManageWalletUV.self)){
                        self.performSegue(withIdentifier: "unwindToManageWallet", sender: self)
                    }else if(self.isFromMainScreen == true){
                        self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                    }
                    
                    if (urlString.contains(find: "paymentModeSelected=Yes")){
                        self.close()
                        return
                    }
                    
                    
                    
                    self.getUserDetail()
                    
                    
                }else if (urlString.contains(find: "result.php?success=0") || urlString.contains(find: "success=0") || urlString.contains(find: "page_action=close") || urlString.contains(find: "page_action=contactus")){
                    
//                    if(self.loaderView != nil){
//                        self.loaderView.isHidden = true
//                    }

                    self.animationView.pause()
                    self.animationView.isHidden = true
                   // self.closeImgView.isHidden = true
                    
                    if(urlString.contains(find: "page_action=contactus")){
                        let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                        self.push(uv: contactUsUv)
                        return
                    }
                    
                    if(urlString.contains(find: "page_action=close")){
                        
                        if(self.isFromMainScreen){
                            self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                        }else{
                            self.close()
                        }
                        
                        return
                    }
                }
            }
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("errorororoor:\(error)")
        print("Paymenturl:\(self.paymentUrl)")
        if let err = error as? URLError {
            switch(err.code) {
            case .notConnectedToInternet:
                self.handleNoInternetView()
                if error._domain == "NSURLErrorDomain" {
                    if let info = error._userInfo as? [String: Any] {
                        
                        if let url = info["NSErrorFailingURLKey"] as? URL {
                            
                            self.failedUrlString = url.absoluteString
                        }
                    }
                }
            case .cancelled:
                self.webView.stopLoading()
                self.close()
            default:
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: error.localizedDescription, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    self.webView.stopLoading()
                    self.close()
                })
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("errorororoor:\(error)")
        print("Paymenturl:\(self.paymentUrl)")
        if let err = error as? URLError {
            switch(err.code) {
            case .notConnectedToInternet:
                self.handleNoInternetView()
                if error._domain == "NSURLErrorDomain" {
                    if let info = error._userInfo as? [String: Any] {
                        
                        if let url = info["NSErrorFailingURLKey"] as? URL {
                            
                            self.failedUrlString = url.absoluteString
                        }
                    }
                }
            case .cancelled:
                self.webView.stopLoading()
                self.close()
            default:
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: error.localizedDescription, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    self.webView.stopLoading()
                    self.close()
                })
            }
        }
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        DispatchQueue.main.async {
            
            if(self.isGetDetailCalled == false){
                UIView.transition(with: self.webView, duration: 0.03,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.webView.isHidden = false
                })
//                if(self.loaderView != nil){
//                    self.loaderView.isHidden = true
//                }
                self.animationView.pause()
                self.animationView.isHidden = true
               // self.closeImgView.isHidden = true
            }
        
        }
    }
    

    func getUserDetail(){
       
        self.isGetDetailCalled = true
        self.webView.isHidden = true
        if(self.loaderView == nil){
            self.loaderView =  self.generalFunc.addMDloader(contentView: self.contentView)
            self.loaderView.backgroundColor = UIColor.clear
        }else if(self.loaderView != nil){
            self.loaderView.isHidden = false
        }
        
        let parameters = ["type":"getDetail","UserType": Utils.appUserType, "AppVersion": Utils.applicationVersion(), "vDeviceType": Utils.deviceType, "iUserId": GeneralFunctions.getMemberd(), "LiveTripId":""]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.contentView, isOpenLoader: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            
//            if(self.loaderView != nil){
//                self.loaderView.isHidden = true
//            }
            //            print("Response:\(response)")
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                    GeneralFunctions.logOutUser()
                    GeneralFunctions.removeObserver(obj: self)
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SESSION_TIME_OUT"), content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        GeneralFunctions.restartApp(window: Application.window!)
                    })
                    
                    return
                }
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    self.userProfileJson = userProfileJson
                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: self.userProfileJson.get("user_available_balance_amount") as AnyObject)
                    GeneralFunctions.saveValue(key: "user_available_balance", value: self.userProfileJson.get("user_available_balance") as AnyObject) // With Currency Symbole
                    
                    
                   if(self.isFromUFXPayMode == true){
                        self.performSegue(withIdentifier: "unwindToUfxPayModeScreen", sender: self)
                    }else{
                        if(self.isFromMainScreen == true){
                            self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                        }else if self.isFromCheckOut == true
                        {
                            self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
                        }else if(!(self.uv != nil && self.uv.isKind(of: ViewProfileUV.self))){
                            self.close()
                        }
                    }
                    
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.getUserDetail()
                    })
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    GeneralFunctions.restartApp(window: Application.window!)
                })
             
            }
        })
    }
//    @objc func openCardScanner(){
//           let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
//
//           if(cardIOVC != nil){
//               cardIOVC!.hideCardIOLogo = true
//               if(payMentMethod == "Omise"){
//                   cardIOVC!.collectCardholderName = true
//               }
//               cardIOVC!.collectCVV = true
//               cardIOVC!.languageOrLocale = Configurations.getGoogleMapLngCode()
//   //            cardIOVC!.navigationBarStyleForCardIO = .black
//               cardIOVC!.keepStatusBarStyleForCardIO = true
//               cardIOVC!.navigationBarTintColorForCardIO = SColors.Theme
//   //            cardIOVC!.navigationBarTintColor = SColors.Theme
//   //            cardIOVC!.navigationBar.barTintColor = SColors.Theme
//
//               self.present(cardIOVC!, animated: true, completion: nil)
//           }
//
//       }
//
//       func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
//           paymentViewController.dismiss(animated: true, completion: nil)
//       }
//
//       func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
//
//           paymentViewController.dismiss(animated: true, completion: nil)
//
//           if let info = cardInfo {
//   //            let str = NSString(format: "Received card info.\n Cardholders Name: %@ \n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.cardholderName, info.cardNumber, info.expiryMonth, info.expiryYear, info.cvv)
//   //
//   //            print(str)
//               if(self.payMentMethod == "Stripe"){
//                   //stripeCardTxtField.setText(info.cardNumber, in: .number)
//                 //  stripeCardTxtField.setText("\(info.expiryMonth < 10 ? "0\(info.expiryMonth)" : "\(info.expiryMonth)" )/\(info.expiryYear)", in: .expiration)
//                  // stripeCardTxtField.setText(info.cvv, in: .CVC)
//               }else{
//
//                   //self.creditCardTxtField.setText(text: info.cardNumber.separate(every: 4, with: " "))
//                   //self.cardNameTxtField.setText(text: info.cardholderName != nil ? info.cardholderName! : "")
//                   //self.monthTxtField.setText(text: "\(info.expiryMonth < 10 ? "0\(info.expiryMonth)" : "\(info.expiryMonth)" )")
//                   //self.yearTxtField.setText(text: "\(info.expiryYear)")
//
//                  // self.cvvTxtField.setText(text: info.cvv)
//               }
//           }
//
//       }
    
    @IBAction func unwindToAddPaymentUV(_ segue:UIStoryboardSegue) {
        
        self.isCompletionFromSegue = true
        let selectPromoCodeUV = segue.source as! SelectPromoCodeUV
        
        self.appliedPromoCode = selectPromoCodeUV.appliedPromoCode
        self.isPromoCodeAppliedManually = selectPromoCodeUV.isPromoCodeAppliedManually
        
        self.completionHandler(self.appliedPromoCode)
        
    }
}
