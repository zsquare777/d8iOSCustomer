

import UIKit

class MyRideTabUV: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var buttonBarContainerView: UIView!
    let generalFunc = GeneralFunctions()
    var viewControllersArr:[UIViewController]!
    var isfromSeeAll = false
    var isfromBooking = false
    var isfromPulished = false
    
    @IBOutlet weak var sepratorStackView: UIStackView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addBack()
        self.configRTL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settings.style.buttonBarItemTitleColor = SColors.Theme
       
        self.topHeaderView.backgroundColor = UIColor.clear
        buttonBarView.selectedBar.backgroundColor = UIColor.clear
        
        buttonBarView.backgroundColor = UIColor.clear
        
        buttonBarView.layer.zPosition = 9999
    
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_MY_RIDES_TXT")
        
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
        self.setSepratorView(index: 0)
        self.containerView.backgroundColor = UIColor(hex: 0xf1f1f1)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.backgroundColor = SColors.ThemeTxt
            self.buttonBarContainerView.alpha = 1
            
            self.topHeaderView.alpha = 1
            self.buttonBarView.alpha = 1
            
        }, completion:{ _ in})
        
        
            if(isfromBooking){
            moveToViewController(at: 1, animated: true)
            }
        if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0){
            (viewControllersArr[0] as! MyRideUV).viewDidAppear(true)
        }
        
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideUV") as! MyRideUV
        let myRideUVBook = GeneralFunctions.instantiateViewController(pageName: "MyRideUV") as! MyRideUV
        myRideUV.LIST_TYPE = "Published"
        myRideUVBook.LIST_TYPE = "Book"

        var uvArr = [UIViewController]()
     
        uvArr += [myRideUV]
        uvArr += [myRideUVBook]
        
       
        
        viewControllersArr = uvArr
        
        return uvArr
    }
    override func close(){
       
        if isfromBooking || isfromPulished{
            
            self.navigationController!.popToRootViewController(animated: true)
         
        }else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
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
