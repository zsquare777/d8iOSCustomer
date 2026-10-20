
import UIKit
import SysBaseLib

class UFXProviderInfoUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var providerImgView: UIImageView!
    @IBOutlet weak var providerNameLbl: MyLabel!
    @IBOutlet weak var providerRatingView: RatingView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txtViewHeight: NSLayoutConstraint!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var driverData:NSDictionary!

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "UFXProviderInfoScreenDesign", uv: self, contentView: self.contentView)
            self.contentView.addSubview(cntView)
            
           // self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICE_DESCRIPTION")
            
            txtView.shadowColor = UIColor.lightGray
            txtView.shadowOffset = CGSize(width: 0, height: 0.0)
            txtView.shadowRadius = 2.0
            txtView.shadowOpacity = 1.0

            
            self.txtView.textContainerInset = UIEdgeInsets(top: 15,left: 15,bottom: 15,right: 15)
            
            self.providerNameLbl.text = self.driverData.get("Name") + " " + self.driverData.get("LastName")
            self.providerNameLbl.textColor = SColors.ThemeTxt
            providerImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(self.driverData.get("driver_id"))/\(self.driverData.get("driver_img"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            providerImgView.borderColor = SColors.ThemeTxt
            providerImgView.borderWidth = 2.0
            providerRatingView.rating = GeneralFunctions.parseFloat(origValue: 0, data: self.driverData.get("average_rating"))
            self.headerView.backgroundColor = SColors.Theme
            self.getInfo()
            
        }else if(type == 1){
            
            self.addBack()
            self.configRTL()
            
        }
    }
 
    
    func getInfo(){
        
        
        self.txtViewHeight.constant = self.driverData.get("tProfileDescription").height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont.init(name: Fonts().regular, size: 15)!) + 100
        if(self.txtViewHeight.constant > (Application.screenSize.height - 115 - (GeneralFunctions.getSafeAreaInsets().top + GeneralFunctions.getSafeAreaInsets().bottom))){
            self.txtViewHeight.constant = Application.screenSize.height - 115 - (GeneralFunctions.getSafeAreaInsets().top + GeneralFunctions.getSafeAreaInsets().bottom) - 100
        }
        
        let finalStr = NSMutableAttributedString.init(string: self.driverData.get("tProfileDescription"))
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().light, size: 14)]
        finalStr.addAttributes(attributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, finalStr.length))
        
        //let attributedTitleString = NSMutableAttributedString(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT") + " " + self.driverData.get("Name") + "\n")
        let attributedTitleString = NSMutableAttributedString(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ABOUT_EXPERT") + " " + "\n")
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 19)]
        attributedTitleString.addAttributes(yourOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedTitleString.length))
        let attributedSpaceString = NSMutableAttributedString(string:"\n")
        let spaceOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 10)]
        attributedSpaceString.addAttributes(spaceOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedSpaceString.length))
        attributedTitleString.append(attributedSpaceString)
        attributedTitleString.append(finalStr)
        self.txtView.attributedText = attributedTitleString
        self.txtView.isEditable = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
