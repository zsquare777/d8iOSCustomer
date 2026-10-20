

import UIKit
import SysBaseLib

class InviteFriendsUV: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate,UIGestureRecognizerDelegate{
    

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var shareHLbl: MyLabel!
    @IBOutlet weak var inviteCodeLbl: MyLabel!
    @IBOutlet weak var descLbl: MyLabel!
    @IBOutlet weak var shareBtn: MyButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    
    var PAGE_HEIGHT:CGFloat = 405
    
    var cntView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "InviteFriendsScreenDesign", uv: self, contentView: scrollView)
            self.scrollView.addSubview(cntView)
            
            self.addBack()
            
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
             Configurations.setAppThemeNavBar()
            
        }else if(type == 2){
            
            let randomInt = Int.random(in: 1..<5)

            print("randomInt:\(randomInt)")
            inviteCodeLbl.dashedBorderLayerWithColor(color: SColors.Theme.cgColor)
        }
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(){
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)

        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_TXT")
        
//        self.descLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_SHARE_TXT")
        self.descLbl.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("INVITE_DESCRIPTION_CONTENT"))
        self.shareHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_SHARE")
        
        self.shareBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVITE_FRIEND_TXT"))
        self.inviteCodeLbl.text = userProfileJson.get("vRefCode")
//        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        lpgr.minimumPressDuration = 0.1
//        lpgr.delaysTouchesBegan = true
//        lpgr.delegate = self
//        inviteCodeLbl.addGestureRecognizer(lpgr)
        self.inviteCodeLbl.isUserInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        
        self.inviteCodeLbl.addGestureRecognizer(longPressRecognizer)
          
        self.inviteCodeLbl.textColor = SColors.ThemeTxt
//        inviteCodeLbl.backgroundColor =  SColors.Theme.withAlphaComponent(0.2)
        
        self.shareBtn.clickDelegate = self
        
        self.descLbl.fit()
        
        var descTxtHeight = descLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().light, size: 16)!) - 20
        if(descTxtHeight < 0){
            descTxtHeight = 0
        }
        PAGE_HEIGHT = PAGE_HEIGHT + descTxtHeight
        
        cntView.frame.size = CGSize(width: self.cntView.frame.width, height: PAGE_HEIGHT)
        
        self.scrollView.bounces = false
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
        
        self.inviteCodeLbl.backgroundColor = SColors.Theme.light()
    }
    
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.shareBtn){
            let objectsToShare = ["\(self.userProfileJson.get("INVITE_SHARE_CONTENT"))"]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.shareBtn
            if #available(iOS 11.0, *) {
                activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                    if !completed {
                        DispatchQueue.main.async {
                            Configurations.setAppThemeNavBar()
                            return
                        }
                    }
                }
                DispatchQueue.main.async {
                    Configurations.setDefaultNavBar()
                }
//                UINavigationBar.appearance().backgroundColor = SColors.Theme
//                UIBarButtonItem.appearance().tintColor = SColors.ThemeTxt
                
            }
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
//    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
//        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Copy", key: "LBL_INVITE_COPY_CLIPBOARD") , uv: self)
//        UIPasteboard.general.string = self.inviteCodeLbl.text
//    }
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Copy", key: "LBL_INVITE_COPY_CLIPBOARD") , uv: self)
       UIPasteboard.general.string = self.inviteCodeLbl.text
    }
}
