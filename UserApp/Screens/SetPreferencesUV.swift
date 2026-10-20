

import UIKit
import SysBaseLib

class SetPreferencesUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderLbl: MyLabel!
    @IBOutlet weak var genderChkBox: BEMCheckBox!
    @IBOutlet weak var genderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var handiCapView: UIView!
    @IBOutlet weak var handiCapChkBox: BEMCheckBox!
    @IBOutlet weak var handiCapViewHeight: NSLayoutConstraint!
    @IBOutlet weak var handiCaplbl: MyLabel!
    
    let generalFunc = GeneralFunctions()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "SetPreferencesScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
        }
    }
    
    
    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Preferences", key: "LBL_PREFRANCE_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Preferences", key: "LBL_PREFRANCE_TXT")
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)

        
        
        
        self.genderLbl.text = self.generalFunc.getLanguageLabel(origValue: "Prefer Female Driver", key: "LBL_ACCEPT_FEMALE_REQ_ONLY")
        self.genderLbl.fit()
        
        self.handiCaplbl.text = self.generalFunc.getLanguageLabel(origValue: "Prefer Taxis with Handicap Accessibility", key: "LBL_MUST_HAVE_HANDICAP_ASS_CAR")
        self.handiCaplbl.fit()
        
        let HANDICAP_ACCESSIBILITY_OPTION = userProfileJson.get("HANDICAP_ACCESSIBILITY_OPTION")
        let FEMALE_RIDE_REQ_ENABLE = userProfileJson.get("FEMALE_RIDE_REQ_ENABLE")
        
        if(HANDICAP_ACCESSIBILITY_OPTION.uppercased() != "YES"){
            handiCapView.isHidden = true
            handiCapViewHeight.constant = 0
        }
        
        if(FEMALE_RIDE_REQ_ENABLE.uppercased() != "YES"){
            genderView.isHidden = true
            genderViewHeight.constant = 0
        }
        
        genderChkBox.addTarget(self, action: #selector(self.genderChkBoxValueChanged), for: .valueChanged)
        self.genderChkBox.boxType = .square
        self.genderChkBox.offAnimationType = .bounce
        self.genderChkBox.onAnimationType = .bounce
        self.genderChkBox.onCheckColor = SColors.ThemeTxt
        self.genderChkBox.onFillColor = SColors.Theme
        self.genderChkBox.onTintColor = SColors.Theme
        self.genderChkBox.tintColor = SColors.Theme_1
        
        
        self.handiCapChkBox.boxType = .square
        self.handiCapChkBox.offAnimationType = .bounce
        self.handiCapChkBox.onAnimationType = .bounce
        self.handiCapChkBox.onCheckColor = SColors.ThemeTxt
        self.handiCapChkBox.onFillColor = SColors.Theme
        self.handiCapChkBox.onTintColor = SColors.Theme
        self.handiCapChkBox.tintColor = SColors.Theme_1
    }

    @objc func genderChkBoxValueChanged(){
        print("Gender:\(genderChkBox.on)")
    }
}
