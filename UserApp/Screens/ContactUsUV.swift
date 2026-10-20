

import UIKit
import SysBaseLib

class ContactUsUV: ParentViewUV, MyBtnClickDelegate, UITextViewDelegate, ParentViewUVDelegate {


    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    /*Create IBOutlet*/
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var headerTitleLbl: MyLabel!
    @IBOutlet weak var headerDescLbl: MyLabel!
    @IBOutlet weak var headerSubTitleLbl: MyLabel!
    @IBOutlet weak var commentTxtView: KMPlaceholderTextView!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var queryTxtView: KMPlaceholderTextView!
    @IBOutlet weak var requiredCommentTxtLbl: MyLabel!
    @IBOutlet weak var requiredQueryTxtLbl: MyLabel!
    @IBOutlet weak var submitBtn: MyButton!
    
    @IBOutlet weak var viewHeaderLogoBG : UIView!
    @IBOutlet weak var viewTFBG : UIView!
    
    var PAGE_HEIGHT:CGFloat = 580
    
    let generalFunc = GeneralFunctions()
    
    var cntView:UIView!
    
    var isSafeAreaSet = false
    
    var isPageLoaded = false
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "ContactUsScreenDesign", uv: self, contentView: scrollView)
            self.scrollView.addSubview(cntView)
            self.scrollView.bounces = false

            self.addBack()
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            self.setnavBarTintColor(color: SColors.Theme)
            Configurations.setAppThemeNavBar()
            
        }else if(type == 2){
            setScrollViewContent()
        }
    }
    
    
    func setData(){
        
        self.viewHeaderLogoBG.backgroundColor = SColors.Theme
        
        commentTxtView.addShadowWithCornerRadius_new(Opacity:0.5)
        queryTxtView.addShadowWithCornerRadius_new(Opacity:0.5)
        viewTFBG.addShadowWithCornerRadius_new()
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_HEADER_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_HEADER_TXT")
        
        self.headerTitleLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "How can we help you?", key: "LBL_CONTACT_US_SUBHEADER_TXT"))"
        self.headerDescLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_DETAIL_TXT"))"
        
        self.headerSubTitleLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RES_TO_CONTACT"))"
        self.headerSubTitleLbl.fit()
        self.commentTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_SUBJECT_HINT_CONTACT_TXT")
        self.commentTxtView.delegate = self
        
        self.subTitleLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YOUR_QUERY"))"
        self.subTitleLbl.fit()
        self.queryTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YOUR_QUERY") //0010603: Delivery All | user app | contact us - In both texts field same hint texts there
        self.queryTxtView.delegate = self
        
        self.requiredQueryTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        self.requiredCommentTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        self.requiredQueryTxtLbl.isHidden = true
        self.requiredCommentTxtLbl.isHidden = true
        
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEND_QUERY_BTN_TXT"))
        self.submitBtn.clickDelegate = self
        
        let headerDescHeight = headerDescLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont(name: Fonts().regular, size: 15)!)
        PAGE_HEIGHT = PAGE_HEIGHT + headerDescHeight
    }
    
    func setScrollViewContent(){
        self.contentView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT)
        self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT)
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.PAGE_HEIGHT)
    }

    func submitContactQuery(){
        let parameters = ["type":"sendContactQuery", "UserType": Utils.appUserType, "UserId": GeneralFunctions.getMemberd(),"message": queryTxtView.text!, "subject": commentTxtView.text!]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.commentTxtView.text = ""
                    self.queryTxtView.text = ""
                }
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.submitBtn){
            if(self.commentTxtView.text!.trim() == "" && self.queryTxtView.text!.trim() == ""){
                self.requiredCommentTxtLbl.isHidden = false
                self.requiredQueryTxtLbl.isHidden = false
                return
            }
            
            if(self.commentTxtView.text!.trim() == ""){
                self.requiredCommentTxtLbl.isHidden = false
                return
            }
            
            if(self.queryTxtView.text!.trim() == ""){
                self.requiredQueryTxtLbl.isHidden = false
                return
            }
            submitContactQuery()
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if(textView == self.commentTxtView){
            self.requiredCommentTxtLbl.isHidden = true
        }else if(textView == self.queryTxtView){
            self.requiredQueryTxtLbl.isHidden = true
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
