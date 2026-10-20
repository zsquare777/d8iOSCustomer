

import UIKit
import WebKit

class OpenUserPreferences: NSObject, MyLabelClickDelegate, WKNavigationDelegate {
    typealias CompletionHandler = (_ isContinueBtnTapped:Bool, _ isTollSkipped:Bool) -> Void
    
    var uv:UIViewController!
    var containerView:UIView!
    
    var currentInst:OpenUserPreferences!
    
    let generalFunc = GeneralFunctions()
    
    var userPreferencesDesignView:UserPreferencesDesign!
    var userPreferencesDesignBGView:UIView!
    
    var handler:CompletionHandler!
    var isTakeAway = false
    var isDelivery = false
    
    var isTip = false
   
    var customImgName = ""
    
    var webView:WKWebView!
    
    var htmlString = ""
    
    var isShowCancel = false
    var isFromEmailVerify = false
    var isFromBidding = false

    init(uv:UIViewController, containerView:UIView){
        self.uv = uv
        self.containerView = containerView
        super.init()
    }
    
    func setViewHandler(handler: @escaping CompletionHandler){
        self.handler = handler
    }
    
    func show(preferenceDescription:String,title: String){
        
        
        
        let desc = preferenceDescription.replace("\\n", withString: "\n")
              
        var descHeight = desc.height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().regular, size: 17)!) + 20
        
        let width = Application.screenSize.width - 50
        
        var height:CGFloat = 240 + (self.htmlString == "" ? descHeight : 0.0)
        
        height = height - (title == "" ? 20 : 0.0)
        if height > Application.screenSize.height{
            height = Application.screenSize.height - 40
        }
        if UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S{
            descHeight = descHeight + 30
        }
       
        userPreferencesDesignView = UserPreferencesDesign(frame: CGRect(x:0, y:0, width: width, height: height))
        
        if(self.htmlString != ""){
            self.setWebView()
        }
        
        userPreferencesDesignView.frame.size = CGSize(width: width, height: height)
        
        userPreferencesDesignView.center = CGPoint(x: Application.screenSize.width / 2, y: self.containerView.frame.height / 2)
        
        let bgView = UIView()
        
        bgView.frame = CGRect(x:0, y:0, width:Application.screenSize.width, height: self.containerView.frame.height)
        
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: self.containerView.frame.height / 2)
        
        bgView.backgroundColor = UIColor.black
        
        bgView.isUserInteractionEnabled = true
        
        self.userPreferencesDesignBGView = bgView
        
        Application.window?.addSubview(bgView)
        Application.window?.addSubview(userPreferencesDesignView)
        
        bgView.alpha = 0
        self.userPreferencesDesignView.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                bgView.alpha = 0.80
                self.userPreferencesDesignView.alpha = 1
        }
        )
        
        self.userPreferencesDesignView.cornerRadius = 10
        self.userPreferencesDesignView.clipsToBounds = true
        userPreferencesDesignView.prefHBGView.backgroundColor = SColors.Theme
        userPreferencesDesignView.userPreferencesNoteTextView.text = desc
        userPreferencesDesignView.userPreferencesTitleLbl.text = title.uppercased()
        userPreferencesDesignView.userPreferencesOkLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT").uppercased()
        userPreferencesDesignView.userPreferencesOkLbl.setClickDelegate(clickDelegate: self)
        userPreferencesDesignView.userPreferencesOkLbl.backgroundColor = SColors.Theme
        userPreferencesDesignView.userPreferencesNoteTextViewHeight.constant = descHeight
        if (240 + descHeight) > Application.screenSize.height{
            userPreferencesDesignView.userPreferencesNoteTextView.isScrollEnabled = true
        }
        
        if(isTakeAway || isDelivery){
            if(isDelivery){
                userPreferencesDesignView.headerImgView.image = UIImage(named:"ic_delivery_help")
            }else{
                userPreferencesDesignView.headerImgView.image = UIImage(named:"ic_takeaway_help")
            }
        }
        
        if(isTip){
            userPreferencesDesignView.headerImgView.image = UIImage(named:"ic_tipLivetrack")
            
        }
        
        
        if(customImgName != ""){
            userPreferencesDesignView.headerImgView.image = UIImage(named:customImgName)
        }
        
        userPreferencesDesignView.cancelLbl.borderColor = SColors.Theme
        userPreferencesDesignView.cancelLbl.textColor = SColors.Theme
        userPreferencesDesignView.cancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased()
        userPreferencesDesignView.cancelLbl.handleClick { (instance) in
              self.closeView()
        }
        
        
        if(self.isShowCancel){
            userPreferencesDesignView.cancelLbl.isHidden = false
        }
        
        if(self.isFromEmailVerify){
            userPreferencesDesignView.userPreferencesOkLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN").uppercased()
            userPreferencesDesignView.headerImgView.image = UIImage(named:"ic_email_New")
            userPreferencesDesignView.userPreferencesNoteTextView.textAlignment = .center
        }
        if isFromBidding {
            userPreferencesDesignView.userPreferencesOkLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RE_OFFER_TXT").uppercased()
            userPreferencesDesignView.headerImgView.image = UIImage(named:"ic_decline_task")
            userPreferencesDesignView.userPreferencesNoteTextView.textAlignment = .left
            userPreferencesDesignView.cancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TXT").uppercased()
            userPreferencesDesignView.cancelLbl.handleClick { (instance) in
                  self.closeViewoffer()
            }
        }
    }
        
    func setWebView(){
         self.webView = WKWebView.init(frame: CGRect(x: 10, y:155, width: self.userPreferencesDesignView.frame.width - 20, height: self.userPreferencesDesignView.frame.height - 240))
          self.webView.navigationDelegate = self
          
          self.webView.backgroundColor = UIColor.clear
          self.userPreferencesDesignView.addSubview(self.webView)
          
          self.webView.scrollView.bounces = false
          
        
          let page_desc = htmlString
          let content = page_desc.replace("\n", withString: "<br>")
                         
          let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        

           if(Configurations.isRTLMode()){
               self.webView.loadHTMLString(headerString + "<html dir=\"rtl\"><body><p style=color:#343434>\(content)</p></body></html>", baseURL: nil)
           }else{
               self.webView.loadHTMLString(headerString + "<html><body><p style=color:#343434>\(content)</p></body></html>", baseURL:nil)
           }


          self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
          
    }
    
 
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print(webView.scrollView.contentSize.height)
            
            let width = Application.screenSize.width - 50
            var height = webView.scrollView.contentSize.height + 240
            
            if(height > Application.screenSize.height - 50){
                height = Application.screenSize.height - 50
            }
            self.userPreferencesDesignView.frame = CGRect(x:0, y:0, width: width, height: height)
            
            self.userPreferencesDesignView.frame.size = CGSize(width: width, height: height)
            
            self.userPreferencesDesignView.center = CGPoint(x: Application.screenSize.width / 2, y: self.containerView.frame.height / 2)
            
            
            self.webView.frame = CGRect(x: 10, y:155, width: self.userPreferencesDesignView.frame.width - 20, height: self.userPreferencesDesignView.frame.height - 240)
            
            
        }
    }
    
    func closeView(){
        userPreferencesDesignView.frame.origin.y = Application.screenSize.height + 2500
        userPreferencesDesignView.removeFromSuperview()
        userPreferencesDesignBGView.removeFromSuperview()
    }

    
    func myLableTapped(sender: MyLabel) {
        
        if isFromBidding {
        let biddingDetials = self.uv as! BiddingDetialsUV
        biddingDetials.openReofferView()
        closeView()
        return
        }
        
        
        
        
        if(self.userPreferencesDesignView != nil && sender == self.userPreferencesDesignView.userPreferencesOkLbl){
            if(self.isFromEmailVerify){
                let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
                accountVerificationUv.isForMobile = false
                self.uv.push(uv: accountVerificationUv)
            }
            closeView()
        }
    }
    func closeViewoffer(){
        let biddingDetials = self.uv as! BiddingDetialsUV
        //biddingDetials.biddingStatus(type: "Decline")
        biddingDetials.declinePopUp()
        closeView()
        return
        
    }
}
