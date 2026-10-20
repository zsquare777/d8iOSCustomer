

import UIKit
import SysBaseLib

class MaintenancePageUV: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate  {

    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var maintennanceImgView: UIImageView!
    @IBOutlet weak var contentLbl: MyLabel!
    @IBOutlet weak var headerLbl: MyLabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imgViewHight: NSLayoutConstraint!
    @IBOutlet weak var negativeBtn: MyButton!
    @IBOutlet weak var positiveBtn: MyButton!
    
    @IBOutlet weak var contactUsView: UIView!
    @IBOutlet weak var contactusImgView: UIImageView!
    
    var isFromSessionOut = false
    var dataDic = NSDictionary()
    let generalFunc = GeneralFunctions()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
            
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "MaintenancePageScreenDesign", uv: self, contentView: contentView))
           
            //GeneralFunctions.setImgTintColor(imgView: maintennanceImgView, color: UIColor(hex: 0x333333))
            
        }else if(type == 1){
            
            self.configRTL()
            self.setData()
            self.scrView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60 , right: 0)
            
            let height = Utils.getHeightOfBanner(widthOffset: 40, ratio: "4:3")
            self.imgViewHight.constant = height
            self.headerLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDic.get("message_title") , key: dataDic.get("message_title") )
            self.contentLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDic.get("message") , key: dataDic.get("message") )
            self.positiveBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_OK"))
            self.negativeBtn.setButtonTitleWithoutUppercased(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Try Again", key: "LBL_TRY_AGAIN_BTN_TXT"))
            if dataDic.get("isSessionExpired").uppercased() == "YES"{
                self.maintennanceImgView.image = UIImage(named: "ic_session_out")
                self.contactUsView.isHidden = true
                self.negativeBtn.isHidden = true
            }else if dataDic.get("isAppUpdate").uppercased() == "YES"{
                self.maintennanceImgView.image = UIImage(named: "ic_new_update")
                self.contactUsView.isHidden = true
                self.positiveBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Update", key: "LBL_UPDATE_GENERAL"))
            }else if dataDic.get("isAppRestrict").uppercased() == "YES"{
                self.maintennanceImgView.image = UIImage(named: "ic_country_restriction")
                self.contactUsView.isHidden = true
            }else if dataDic.get("isAppMaintenance").uppercased() == "YES"{
                self.maintennanceImgView.image = UIImage(named: "ic_under_maintaince")
                self.contactUsView.isHidden = false
            }else if dataDic.get("isAccountDeleted").uppercased() == "YES" || dataDic.get("isAccountInactive").uppercased() == "YES"{
                self.maintennanceImgView.image = UIImage(named: "ic_account_inactive")
                self.contactUsView.isHidden = false
            }else{
                self.maintennanceImgView.image = UIImage(named: "ic_under_maintaince")
                self.headerLbl.text = self.generalFunc.getLanguageLabel(origValue: "Under Maintenance", key: "LBL_MAINTENANCE_HEADER_MSG")
                self.contentLbl.text = self.generalFunc.getLanguageLabel(origValue: "Site is under maintenance. Please stay with us and check back later.", key: "LBL_MAINTENANCE_CONTENT_MSG")
                self.contactUsView.isHidden = false
            }
            if  dataDic.get("isSessionExpired").uppercased() == "YES"{
                GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                GeneralFunctions.logOutUser()
            }
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationItem.setHidesBackButton(true, animated: false)
            Configurations.setDefaultStatusBar()
        }
    }
    

    func myBtnTapped(sender: MyButton) {
//        if(sender == contactUsBtn){
//            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
//            self.push(uv: contactUsUv)
//        }
        if sender == positiveBtn {
            if  dataDic.get("isSessionExpired").uppercased() == "YES"{
                GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                GeneralFunctions.logOutUser()
                GeneralFunctions.restartApp(window: Application.window!)
            }else if dataDic.get("isAppUpdate").uppercased() == "YES"{
                let myUrl = "itms-apps://itunes.apple.com/app/bars/id\(CommonUtils.appleAppId)"
                if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
                GeneralFunctions.restartApp(window: Application.window!)
            }else if dataDic.get("isAccountDeleted").uppercased() == "YES" || dataDic.get("isAccountInactive").uppercased() == "YES"{
                GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: EventService.removeSCInst_key, obj: self)
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                GeneralFunctions.logOutUser()
                GeneralFunctions.restartApp(window: Application.window!)
            }else if dataDic.get("isAppRestrict").uppercased() == "YES"{
                exit(0)
            }else if dataDic.get("isAppMaintenance").uppercased() == "YES"{
                exit(0)
            }
            else{
                exit(0)
            }
            
        }else if sender == negativeBtn{
            
            GeneralFunctions.restartApp(window: Application.window!)
        }
    }
    func setData(){
        
        
        self.positiveBtn.clickDelegate = self
        self.positiveBtn.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        
        self.negativeBtn.clickDelegate = self
        self.negativeBtn.setCustomColor(textColor: UIColor(hex: 0x1A2B3A), bgColor: SColors.ThemeTxt, pulseColor: UIColor(hex: 0x1A2B3A), borderColor: UIColor(hex: 0x1A2B3A), borderWidth: 1, cornerRadius: 10)
        
        self.contactUsView.backgroundColor = SColors.Theme
        self.contactusImgView.image = UIImage(named: "ic_contactus_new")
        Utils.createRoundedView(view: self.contactUsView, borderColor: UIColor.clear, borderWidth: 0)
        
        self.contactUsView.handleClick { instance in
            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationItem.setHidesBackButton(false, animated: false)
           self.push(uv: contactUsUv)
        }
    }

}
