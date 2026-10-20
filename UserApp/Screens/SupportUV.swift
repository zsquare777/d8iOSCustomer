

import UIKit
import SafariServices
import LiveChat
import SysBaseLib


class SupportUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let generalFunc = GeneralFunctions()
    
    var MENU_ABOUTUS = "1"
    var MENU_CONTACTUS = "2"
    var MENU_HELP = "3"
    var MENU_PRIVACY = "4"
    var MENU_TERMS_CONDITION = "5"
    var MENU_LIVE_CHAT = "6"
    
    var userProfileJson:NSDictionary!
    var isOnlyPrivacyAndTerms = false
    var isLiveChatEnabled = true
    var chatLicenseID = "" // Cube Demo
    
    var items = [NSDictionary]()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "SupportScreenDesign", uv: self, contentView: contentView))
            self.setnavBarTintColor(color: SColors.Theme)
            if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.USER_PROFILE_DICT_KEY) == true){
                userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    
                /* Live Chat Settings .*/
                self.isLiveChatEnabled = userProfileJson.get("ENABLE_LIVE_CHAT") == "Yes" ? true : false
                self.chatLicenseID = userProfileJson.get("LIVE_CHAT_LICENCE_NUMBER") /* Live Chat Settings .*/
            }
            
            self.addBack()
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.register(UINib(nibName: "SupportItemsListTVCell", bundle: nil), forCellReuseIdentifier: "SupportItemsListTVCell")

            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if (type == 2) {
            //self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    
    func setData(){
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUPPORT_HEADER_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUPPORT_HEADER_TXT")
        
        if(isOnlyPrivacyAndTerms){
            
            if userProfileJson != nil {
            if(userProfileJson.get("showPrivacyPolicy").uppercased() == "YES"){
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT"),"Image" : "ic_Lmenu_privacy","ID" : MENU_PRIVACY] as NSDictionary)
            }
            
            if(userProfileJson.get("showTermsCondition").uppercased() == "YES"){
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_AND_CONDITION"),"Image" : "ic_Lmenu_terms_condition","ID" : MENU_TERMS_CONDITION] as NSDictionary)
            }
            }else{
                 items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT"),"Image" : "ic_Lmenu_privacy","ID" : MENU_PRIVACY] as NSDictionary)
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_AND_CONDITION"),"Image" : "ic_Lmenu_terms_condition","ID" : MENU_TERMS_CONDITION] as NSDictionary)
            }
        
            
        }else{
            if(userProfileJson.get("showAboutUs").uppercased() == "YES"){
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT_US_TXT"),"Image" : "ic_Lmenu_aboutUs","ID" : MENU_ABOUTUS] as NSDictionary)
            }
            
            if(userProfileJson.get("showPrivacyPolicy").uppercased() == "YES"){
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PRIVACY_POLICY_TEXT"),"Image" : "ic_Lmenu_privacy","ID" : MENU_PRIVACY] as NSDictionary)
            }
            
            if(userProfileJson.get("showTermsCondition").uppercased() == "YES"){
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_AND_CONDITION"),"Image" : "ic_Lmenu_terms_condition","ID" : MENU_TERMS_CONDITION] as NSDictionary)
            }
            
            if(isLiveChatEnabled){
                
                items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LIVE_CHAT"),"Image" : "ic_Live_Chat","ID" : MENU_LIVE_CHAT] as NSDictionary)
            }
            items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"),"Image" : "ic_Lmenu_contactUs","ID" : MENU_CONTACTUS] as NSDictionary)
            items.append(["Title" : self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAQ_TXT"),"Image" : "ic_Lmenu_help","ID" : MENU_HELP] as NSDictionary)
            
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupportItemsListTVCell", for: indexPath) as! SupportItemsListTVCell
        cell.backgroundColor = UIColor.clear
        
        let title = items[indexPath.row].object(forKey: "Title") as! String
        let imageName = items[indexPath.row].object(forKey: "Image") as! String
        cell.menuLbl.text = title
        cell.menuLbl.removeGestureRecognizer(cell.menuLbl.tapGue)
        cell.menuImgView.image = UIImage(named: imageName)
        cell.menuLbl.textColor = UIColor(hex: 0x272727)
        GeneralFunctions.setImgTintColor(imgView: cell.menuImgView, color: UIColor(hex: 0x272727))
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMenuId = items[indexPath.item].object(forKey: "ID") as! String
        
        switch selectedMenuId {
        
        case MENU_ABOUTUS:
            openAbout()
            break
        case MENU_PRIVACY:
            openPrivacy()
            break
        case MENU_TERMS_CONDITION:
            openTerms()
            break
        case MENU_CONTACTUS:
            openContactUs()
            break
        case MENU_HELP:
            openHelp()
            break
        case MENU_LIVE_CHAT:
            openLiveChat()
            break
        default:
            break
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
    
    func openLiveChat(){
        
        LiveChat.presentChat()
        
    }/* Live Chat Settings .*/
    
}
