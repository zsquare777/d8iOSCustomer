
import UIKit
import SysBaseLib

class ManageAccountUV: ParentViewUV,ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var deleteAccountView: UIView!
    @IBOutlet weak var profileLbl: MyLabel!
    @IBOutlet weak var deleteAccountLbl: MyLabel!
    @IBOutlet weak var profileArrowImg: UIImageView!
    @IBOutlet weak var deleteAcoountArrow: UIImageView!
    
    var cntView:UIView!
    var generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        
        if(type == 0){
            cntView = self.generalFunc.loadView(nibName: "ManageAccountScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
        }else if (type == 1){
            self.setData()
        }
    }
    func setData(){
        self.addBack()
        self.configRTL()
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MANAGE_ACCOUNT_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MANAGE_ACCOUNT_TXT")
        self.profileLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PERSONAL_DETAILS")
        self.deleteAccountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_ACCOUNT_TXT")
        self.profileView.backgroundColor = SColors.ThemeTxt
        self.deleteAccountView.backgroundColor = SColors.ThemeTxt
        
        self.profileView.handleClick { instance in
            let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
            self.push(uv: uv)
        }
        self.deleteAccountView.handleClick { instance in
            let uv = GeneralFunctions.instantiateViewController(pageName: "DeleteAccountUV") as! DeleteAccountUV
            self.push(uv: uv)
        
        }
        self.profileView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.deleteAccountView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        
        let rightImage = "ic_arrow_right"
              if(Configurations.isRTLMode()){
                   self.profileArrowImg.image = UIImage(named:rightImage)?.rotate(180)
                   self.deleteAcoountArrow.image = UIImage(named:rightImage)?.rotate(180)
               }else{
                   self.profileArrowImg.image = UIImage(named:rightImage)
                   self.deleteAcoountArrow.image = UIImage(named:rightImage)
               }
        
        GeneralFunctions.setImgTintColor(imgView: self.profileArrowImg, color: UIColor.lightGray)
        GeneralFunctions.setImgTintColor(imgView: self.deleteAcoountArrow, color: UIColor.lightGray)
    }
    
}
