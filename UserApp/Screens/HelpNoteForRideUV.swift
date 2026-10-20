
/* Help note changes for Ride*/

import UIKit
import WebKit
import SysBaseLib

class HelpNoteForRideUV: ParentViewUV, MyBtnClickDelegate , WKNavigationDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomLbl: MyLabel!
    @IBOutlet weak var agreeBtn: MyButton!
    @IBOutlet weak var cancelVw: UIImageView!
    
    let generalFunc = GeneralFunctions()
    var isRideLater = false
    var webView:WKWebView!
    var passengerLimitText = ""
    var loaderView:UIView!
    
    var isFromUFX = false
    var isFromMultiDelivery = false
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "HelpNoteForRideScreenDesign", uv: self, contentView: contentView))
            
            setData()
            
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
            
        }else if(type == 1){
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            self.navigationController?.navigationBar.isHidden = true
            
            self.configRTL()
            UIView.animate(withDuration: 0.15, animations: {
                self.contentView.alpha = 1.0
            })
            
        }else if(type == 3){
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    func setData(){
        
        self.bottomLbl.isHidden = true
        self.agreeBtn.isHidden = true
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        
        self.bottomLbl.text = passengerLimitText
        self.bottomLbl.textColor = SColors.red
        
        if(Configurations.isRTLMode()){
            self.bottomLbl.textAlignment = .right
        }else{
            self.bottomLbl.textAlignment = .left
        }
        
        self.agreeBtn.setButtonTitle(buttonTitle:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AGREE") )
        self.agreeBtn.clickDelegate = self
        
        self.cancelVw.image = UIImage(named:"ic_cancel_forgotpass")?.addImagePadding(x: 20, y: 20)
        self.cancelVw.layer.addShadow(opacity: 0.7, radius: 2)
        self.cancelVw.layer.cornerRadius = 19
        self.cancelVw.backgroundColor = UIColor(hex: 0xffffff)
        self.cancelVw.layer.shadowColor = UIColor.gray.cgColor
        self.cancelVw.handleClick { (instance) in
            self.close()
        }
        
        let bottomLblHeight = passengerLimitText.height(withConstrainedWidth: Application.screenSize.width - 40 , font: UIFont(name: Fonts().regular, size: 15)!)
        
        self.webView = WKWebView.init(frame: CGRect(x: 20, y:60, width: Application.screenSize.width - 40, height: Application.screenSize.height - 158 - bottomLblHeight - GeneralFunctions.getSafeAreaInsets().top - GeneralFunctions.getSafeAreaInsets().bottom ))
        self.webView.navigationDelegate = self
        
        self.webView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.webView)
        
        self.webView.scrollView.bounces = false
        
       self.webView.scrollView.showsVerticalScrollIndicator = false
       self.webView.scrollView.showsHorizontalScrollIndicator = false
        
        let url : NSString = userProfileJson.get("RESTRICT_PASSENGER_LIMIT_INFO_URL") as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
        // let stringFormat = String(format: "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"font.css\"></head>")
        self.webView.load(URLRequest(url: URL(string: urlStr as String)!))
        
        
//         if(Configurations.isRTLMode()){
//             self.webView.loadHTMLString(headerString + "<html dir=\"rtl\"><body><p>\(content)</p></body></html>", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
//         }else{
//             self.webView.loadHTMLString(headerString + "<html><body><p>\(content)</p></body></html>", baseURL:nil)
//         }
//
//         self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        
//        let stringFormat = String(format: "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"font.css\"></head>")
//
//        if(Configurations.isRTLMode()){
//            self.webView.loadHTMLString(stringFormat + "<html dir=\"rtl\"><body><p><h1>\(content)</h1></p></body></html>", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
//        }else{
//            self.webView.loadHTMLString(stringFormat + "<html><body><p><h1>\(content)</h1></p></body></html>", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "font", ofType: "css")!))
//        }
//
//        self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    
    func myBtnTapped(sender: MyButton) {
        
        if(self.isFromUFX){
            self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
        }else if(self.isFromMultiDelivery){
            self.performSegue(withIdentifier: "unwindToAskForPayUV", sender: self)
        }else{
            self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.bottomLbl.isHidden = false
            self.agreeBtn.isHidden = false
            self.loaderView.isHidden = true
        }
    }
}

