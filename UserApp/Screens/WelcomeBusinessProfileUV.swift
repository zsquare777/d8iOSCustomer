

import UIKit
import SysBaseLib

class WelcomeBusinessProfileUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var welcomeImgView: UIImageView!
    @IBOutlet weak var welcomeHLbl: MyLabel!
    @IBOutlet weak var welcomeSubLbl: MyLabel!
    @IBOutlet weak var startBtn: MyButton!
    
    let generalFunc = GeneralFunctions()
    var containerViewHeight:CGFloat = 0
    
    var businessProfileUv:BusinessProfileUV!
    
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
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "WelcomeBusinessProfileScreenDesign", uv: self, contentView: contentView))
            
            businessProfileUv = (self.parent as! BusinessProfileUV)
            
            let dataDict = self.businessProfileUv.profileListArr[self.businessProfileUv.selectedProfilePosition]
            
            startBtn.setButtonTitle(buttonTitle: dataDict.get("vScreenButtonText"))
            welcomeHLbl.text = dataDict.get("vScreenTitle")
            welcomeSubLbl.text = dataDict.get("tDescription")

            welcomeImgView.showImgLoader(.gray)
            welcomeImgView.sd_setImage(with: URL(string: dataDict.get("vWelcomeImage")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            })
            
            self.startBtn.setClickHandler { (instance) in
                self.businessProfileUv.openBusinessEmailUv()
            }
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            if(businessProfileUv == nil){
                viewDidLoad()
            }
        }
    }
    
    

}
