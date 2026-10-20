

import UIKit
import WebKit
import SysBaseLib

class StaticPageUV: ParentViewUV, WKNavigationDelegate, ParentViewUVDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    
    let generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    
    var STATIC_PAGE_ID = "1"
    var webView = WKWebView()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "StaticPageScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
            self.webView.scrollView.bounces = false
            
            setData()
            
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            
            let configuration = WKWebViewConfiguration()
            configuration.websiteDataStore =  WKWebsiteDataStore.nonPersistent()
            configuration.preferences = preferences
            self.webView = WKWebView.init(frame: CGRect(x: 10, y: 0, width: Application.screenSize.width - 10, height: self.contentView.bounds.size.height),configuration: configuration)
            self.webView.translatesAutoresizingMaskIntoConstraints = false
            self.webView.allowsLinkPreview = true
            self.webView.allowsBackForwardNavigationGestures = true
            self.webView.navigationDelegate = self
            
            
            
            self.webView.scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.webView.backgroundColor = UIColor.clear
            self.contentView.addSubview(self.webView)
            self.webView.scrollView.bounces = false
            
            getAboutUsPageData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(){
        if(STATIC_PAGE_ID == "1"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT_US_HEADER_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT_US_HEADER_TXT")
        }else if(STATIC_PAGE_ID == "33"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT")
        }else if(STATIC_PAGE_ID == "4"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_AND_CONDITION")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_AND_CONDITION")
        }else{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DETAILS")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DETAILS")
        }
    }
    
    
    func getAboutUsPageData(){
        
        let parameters = ["type":"staticPage","iPageId": STATIC_PAGE_ID, "appType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "vLangCode": (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) == nil ? "" : (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String))]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                let page_desc = dataDict.get("page_desc")
                let content = page_desc.replace("\r\n", withString: "")
                
                
                //              let stringFormat = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
                
                //                if(Configurations.isRTLMode()){
                //                    self.webView.loadHTMLString(stringFormat + "<html dir=\"rtl\"><body><h1 id=h101>\("")</h1><p id=p01>\(content)</p></body></html>", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
                //                }else{
                //                    self.webView.loadHTMLString(stringFormat + "<html><body><h1 id=h101>\("")</h1><p id=p01><span>\(content)</span></p></body></html>", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
                //                }
                
                //                let htmlString = """
                //                    <link rel="stylesheet" type="text/css" href="font.css">
                //                    <span style="font-family: 'Roboto-Light'; font-weight: bold; font-size: 30">\(content)</span>
                //                    """
                //                self.webView.loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
                
                let htmlString = """
                    <style>
                    @font-face
                    {
                        font-family: 'Roboto';
                        font-weight: normal;
                        src: url(Roboto-Regular.ttf);
                    }
                    @font-face
                    {
                        font-family: 'Roboto';
                        font-weight: bold;
                        src: url(Roboto-Bold.ttf);
                    }
                    @font-face
                    {
                        font-family: 'Roboto';
                        font-weight: 200;
                        src: url(Roboto-Light.ttf);
                    }
                    @font-face
                    {
                        font-family: 'Roboto';
                        font-weight: 500;
                        src: url(Roboto-Semibold.ttf);
                    }
                    </style>
                    <span style="font-family: 'Roboto'; font-weight: light; font-size: 40; color: #333333">\(content)</span>
                    """
                self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL) //<-
                self.webView.scrollView.delegate = self
                
                self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
                
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
            self.loaderView.isHidden = true
        })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let javascriptStyle = "var css = '*{-webkit-touch-callout:none;-webkit-user-select:none}'; var head = document.head || document.getElementsByTagName('head')[0]; var style = document.createElement('style'); style.type = 'text/css'; style.appendChild(document.createTextNode(css)); head.appendChild(style);"
        webView.evaluateJavaScript(javascriptStyle, completionHandler: nil)
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation: \(navigation.debugDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}
