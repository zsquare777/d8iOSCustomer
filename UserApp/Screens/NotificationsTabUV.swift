
import UIKit

class NotificationsTabUV: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var buttonBarContainerView: UIView!
    

    @IBOutlet weak var sepratorStackView: UIStackView!
    let generalFunc = GeneralFunctions()
    var isOpenFromMainScreen = false
    var viewControllersArr:[UIViewController]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addBack()
        self.configRTL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settings.style.buttonBarItemTitleColor = SColors.Theme
        
        self.topHeaderView.backgroundColor = SColors.ThemeTxt
        buttonBarView.selectedBar.backgroundColor = UIColor.clear
        
        buttonBarView.backgroundColor = UIColor.clear
        
        buttonBarView.layer.zPosition = 9999
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFICATIONS")
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = SColors.Theme
            
            newCell?.label.font = UIFont.init(name: Fonts().semibold, size: 16)
            oldCell?.label.font = UIFont.init(name: Fonts().semibold, size: 16)
            
            oldCell?.label.backgroundColor = SColors.ThemeTxt
            newCell?.label.backgroundColor = SColors.ThemeTxt
            newCell?.backgroundColor = SColors.ThemeTxt
            oldCell?.backgroundColor = SColors.ThemeTxt
           
            self.setSepratorView(index: newCell?.label.tag ?? 0)
        }
        
        self.buttonBarContainerView.alpha = 0
        self.topHeaderView.alpha = 0
        self.buttonBarView.alpha = 0
        
        self.containerView.backgroundColor = SColors.ThemeTxt
        
    }
    
    @objc func filterDataTapped(){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.backgroundColor = SColors.ThemeTxt
            self.buttonBarContainerView.alpha = 1
            self.topHeaderView.alpha = 1
            self.buttonBarView.alpha = 1
            
        }, completion:{ _ in})
        
        if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0){
            
           // (viewControllersArr[0] as! NotificationsUV).viewDidAppear(true)
        }
        
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let notificationUv = GeneralFunctions.instantiateViewController(pageName: "NotificationsUV") as! NotificationsUV
        let newsFeedUv = GeneralFunctions.instantiateViewController(pageName: "NotificationsUV") as! NotificationsUV
        let allUv = GeneralFunctions.instantiateViewController(pageName: "NotificationsUV") as! NotificationsUV
        
        notificationUv.type = "Notification"
        newsFeedUv.type = "News"
        allUv.type = "All"
        
        var uvArr = [UIViewController]()
        
        // if(Configurations.isRTLMode() == true){
        // uvArr += [providerReviewsUv]
        //  uvArr += [providerGalleryUv]
        //  uvArr += [providerServicesUV]
        // }else{
        uvArr += [allUv]
        uvArr += [notificationUv]
        uvArr += [newsFeedUv]
        
        viewControllersArr = uvArr
        
        return uvArr
    }
    func setSepratorView(index : Int)   {
        
        for tempView in sepratorStackView.subviews{
            if tempView.tag == index {
                tempView.backgroundColor = SColors.Theme
            }else{
                tempView.backgroundColor = UIColor(hex: 0xf6f6f6)
            }
        }
    }
}
