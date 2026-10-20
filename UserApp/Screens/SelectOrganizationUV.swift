

import UIKit
import SysBaseLib

class SelectOrganizationUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var noteLbl: MyLabel!
    @IBOutlet weak var organizationLbl: MyLabel!
    @IBOutlet weak var selectOrganizationView: UIView!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var completeBtn: MyButton!
    
    let generalFunc = GeneralFunctions()
    var containerViewHeight:CGFloat = 0
    
    var businessProfileUv:BusinessProfileUV!
    
    var userProfileJson:NSDictionary!
    
    var isSafeAreaSet = false
    var iphoneXBottomView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            if(self.parent == nil){
                return
            }
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "SelectOrganizationScreenDesign", uv: self, contentView: contentView))
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            businessProfileUv = (self.parent as! BusinessProfileUV)
            
            arrowImgView.transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
            GeneralFunctions.setImgTintColor(imgView: arrowImgView, color: UIColor(hex: 0x272727))
            
            setLabels()
            
            completeBtn.setClickHandler { (instance) in
                self.checkData()
            }
            selectOrganizationView.handleClick { (instance) in
                self.findOrganizationList()
            }
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            if(businessProfileUv == nil){
                self.viewDidLoad()
            }
        }
    }
    

    func setLabels(){
        self.noteLbl.text = generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ORGANIZATION_LINK_TO")
        self.organizationLbl.text = businessProfileUv.selectedOrganizationCompany == "" ? "-- \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TXT")) --" : businessProfileUv.selectedOrganizationCompany
        
        self.completeBtn.setButtonTitle(buttonTitle: generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_NEXT_TXT"))
        
    }

    func findOrganizationList(){
        if(businessProfileUv.organizationDataArr.count == 0){
            let parameters = ["type":"DisplayOrganizationList", "iUserProfileMasterId": businessProfileUv.profileListArr[businessProfileUv.selectedProfilePosition].get("iUserProfileMasterId"), "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd()]
            
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        
                        let dataArr = dataDict.arrOf(Utils.message_str)
                        self.businessProfileUv.organizationDataArr.removeAll()
                        
                        for i in 0 ..< dataArr.count{
                            let dataTemp = dataArr[i] as! NSDictionary
                            self.businessProfileUv.organizationDataArr.append(dataTemp)
                        }
                        
                        self.openOrganizationList()
                    }else{
                        //                    self.generalFunc.setError(uv: self, isCloseScreen: true)
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message") == "" ? "LBL_TRY_AGAIN_TXT" : dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btn_id) in
                            self.close()
                        })
                    }
                }else{
                    self.generalFunc.setError(uv: self, isCloseScreen: true)
                }
            })
        }else{
            self.openOrganizationList()
        }
    }
    
    func openOrganizationList(){
        self.businessProfileUv.openListOrganizationUv()
    }
    
    func checkData(){
        if(self.businessProfileUv.selectedOrganizationId != ""){
            self.businessProfileUv.openBusinessSummaryUv()
        }else{
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ORGANIZATION"), uv: self)
        }
    }
}
