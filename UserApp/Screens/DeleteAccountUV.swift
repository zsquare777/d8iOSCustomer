

import UIKit
import WebKit
import SysBaseLib

class DeleteAccountUV: ParentViewUV,ParentViewUVDelegate,WKNavigationDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var generalFunc = GeneralFunctions()
    var loaderView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
        
        if(type == 0){
            cntView = self.generalFunc.loadView(nibName: "DeleteAccountScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
        }else if (type == 1){
            self.setData()
        }
    }
    func setData(){
        self.addBack()
        self.configRTL()
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_ACCOUNT_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_ACCOUNT_TXT")
        self.deleteAccount()
        
    }
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        self.generalFunc.setAlertMessage(uv: nil, title: "", content: error.localizedDescription, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
            
        })
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.generalFunc.setAlertMessage(uv: nil, title: "", content: error.localizedDescription, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
            
        })
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        DispatchQueue.main.async {
            if let urlString = navigationAction.request.url?.absoluteString{
                
                print("URL:\(urlString)")
                
                
                if (urlString.contains(find: "success=1&account_deleted=Yes")){
                    
                    
                    self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_DELETED_SUCCESS_MSG") , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        self.logOut()
                    })
                    
                }else if (urlString.contains(find: "result.php?success=0") || urlString.contains(find: "success=0") ){
                    let snippet = urlString
                    
                    if let range = snippet.range(of: "message=") {
                        let message = snippet[range.upperBound...]
                        //self.generalFunc.setError(uv: self, title: "", content: String(message).removingPercentEncoding ?? "")
                        
                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: String(message).removingPercentEncoding ?? ""  , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            self.close()
                        })
                    }
                  
                }
                
            }
        }
        
        decisionHandler(.allow)
    }
    func deleteAccount(){
        DispatchQueue.main.async {
            if(self.loaderView == nil){
                self.loaderView =  self.generalFunc.addMDloader(contentView: self.view)
                self.loaderView.backgroundColor = UIColor.clear
            }else if(self.loaderView != nil){
                self.loaderView.isHidden = false
            }
        }
        let parameters = ["type": "AccountDelete", "GeneralUserType": Utils.appUserType, "GeneralMemberId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                   // DispatchQueue.main.async {
                
                    self.webView.configuration.preferences.javaScriptEnabled = true
                    self.webView.isHidden = false
                    self.webView.scrollView.bounces = false
                    self.webView.navigationDelegate = self
                    
                    self.webView.backgroundColor = UIColor.clear
                    self.webView.scrollView.contentInsetAdjustmentBehavior = .never
                    
                    self.webView.load(URLRequest(url: URL(string: dataDict.get("Url"))!))
                       
                   // }
                }else if (dataDict.get("Action") == "0") {
                    //self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    if(self.loaderView != nil){
                        self.loaderView.isHidden = true
                    }
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT") , nagativeBtn: "", completionHandler: { btnClickedId in
                        self.close()
                    })
                }
                else{
                    if(self.loaderView != nil){
                        self.loaderView.isHidden = true
                    }
                    self.generalFunc.setError(uv: self)
                }
                
            }else{
                if(self.loaderView != nil){
                    self.loaderView.isHidden = true
                }
                self.generalFunc.setError(uv: self)
            }
    
        })
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        DispatchQueue.main.async {
            
            if(self.loaderView != nil){
                self.loaderView.isHidden = true
            }
            }
        
        }
    func logOut(){
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
}
