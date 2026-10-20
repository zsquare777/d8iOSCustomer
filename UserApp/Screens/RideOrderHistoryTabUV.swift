
import UIKit

class RideOrderHistoryTabUV: ButtonBarPagerTabStripViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var buttonBarContainerView: UIView!
    
    let generalFunc = GeneralFunctions()
    var viewControllersArr:[UIViewController]!
    var homeTabBar:HomeScreenTabBarUV!
    var isOpenFromMainScreen = false
    var isFromUFXCheckOut = true
    var viewLoadForDelivery = false
    var isFromBidding = false
    var isDirectPush:Bool = false
    var isFromViewProfile:Bool = false
    var directToLiveTrack = false
    var ordeIdForDirectLiveTrack = ""
    var additionChargesDataDic:NSDictionary!
    
    @IBOutlet weak var sepratorStackView: UIStackView!
    @IBOutlet weak var biddingSepratorView: UIView!
    @IBOutlet weak var orderSepratorView: UIView!
    @IBOutlet weak var bookingSepratorView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addBack()
        self.configRTL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _ = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        self.settings.style.buttonBarItemTitleColor = SColors.Theme
        
        self.topHeaderView.backgroundColor = SColors.ThemeTxt
        buttonBarView.selectedBar.backgroundColor = UIColor.clear
        
        buttonBarView.backgroundColor = UIColor.clear
        
        buttonBarView.layer.zPosition = 9999
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = SColors.Theme
            
            newCell?.label.font = UIFont.init(name: Fonts().regular, size: 16)
            oldCell?.label.font = UIFont.init(name: Fonts().regular, size: 16)
            
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
        self.containerView.backgroundColor = UIColor(hex: 0xF1F1F1)
    }
    
    @objc func filterDataTapped(){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.backgroundColor = SColors.ThemeTxt //UIColor(hex: 0xF1F1F1)
            self.buttonBarContainerView.alpha = 1
            self.topHeaderView.alpha = 1
            self.buttonBarView.alpha = 1
            
        }, completion:{ _ in})
        
        if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0 && directToLiveTrack == false){
            
            //(viewControllersArr[0] as! RideHistoryUV).viewDidAppear(true)
            if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0){
                    //(viewControllersArr[0] as! RideHistoryUV).viewDidAppear(true)
            }
        }
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
        label.font = UIFont(name: Fonts().regular, size: 18)!
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        
        var navigationHeaderTitle = ""
        let  userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        if(ServiceModule.rideProduct){
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
        }else if(ServiceModule.deliveryProduct){
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
        }else{
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
        }
        label.text = navigationHeaderTitle
        label.textColor = SColors.ThemeTxt
        self.navigationItem.titleView = label
        if(self.homeTabBar != nil){
            self.homeTabBar.navItem.titleView = label
        }
        if isFromBidding{
            if(ServiceModule.isDeliverAllOnly() || ServiceModule.isAnyDeliverAllOptionEnable()){
            moveToViewController(at: 2, animated: true)
            }else{
                moveToViewController(at: 1, animated: true)
            }
            
            //pageTabBarController?.selectedIndex = 2
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
        let ordersListUV = GeneralFunctions.instantiateViewController(pageName: "OrdersListUV") as! OrdersListUV
        let biddingHistoryUV = GeneralFunctions.instantiateViewController(pageName: "BiddingHistoryUV") as! BiddingHistoryUV
        
        rideHistoryUV.homeTabBar = self.homeTabBar
        rideHistoryUV.viewLoadForDelivery = self.viewLoadForDelivery
        rideHistoryUV.isFromUFXCheckOut = self.isFromUFXCheckOut
        rideHistoryUV.isOpenFromMainScreen = self.isOpenFromMainScreen
        rideHistoryUV.isDirectPush = self.isDirectPush
        rideHistoryUV.isFromViewProfile = self.isFromViewProfile
        rideHistoryUV.navItem = self.navigationItem
        rideHistoryUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
        rideHistoryUV.directToLiveTrack = self.directToLiveTrack
        rideHistoryUV.rideOrderhistorytabUV = self
        rideHistoryUV.additionChargesDataDic = self.additionChargesDataDic
        
        ordersListUV.homeTabBar = self.homeTabBar
        ordersListUV.navItem = self.navigationItem
        ordersListUV.isDirectPush = self.isDirectPush
        ordersListUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
        ordersListUV.directToLiveTrack = self.directToLiveTrack
        
        
        biddingHistoryUV.homeTabBar = self.homeTabBar
        biddingHistoryUV.viewLoadForDelivery = self.viewLoadForDelivery
        biddingHistoryUV.isFromUFXCheckOut = self.isFromUFXCheckOut
        biddingHistoryUV.isOpenFromMainScreen = self.isOpenFromMainScreen
        biddingHistoryUV.isDirectPush = self.isDirectPush
        biddingHistoryUV.isFromViewProfile = self.isFromViewProfile
        biddingHistoryUV.navItem = self.navigationItem
        biddingHistoryUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
        biddingHistoryUV.directToLiveTrack = self.directToLiveTrack
        biddingHistoryUV.rideOrderhistorytabUV = self
        biddingHistoryUV.additionChargesDataDic = self.additionChargesDataDic
        
        var uvArr = [UIViewController]()

        if(ServiceModule.rideM || ServiceModule.deliveryM || ServiceModule.ufxM){
            uvArr += [rideHistoryUV]
            self.bookingSepratorView.isHidden = false
        }
        
        if(ServiceModule.isDeliverAllOnly() || ServiceModule.isAnyDeliverAllOptionEnable()){
            uvArr += [ordersListUV]
            self.orderSepratorView.isHidden = false
        }
        if ServiceModule.biddingM {
            uvArr += [biddingHistoryUV]
            self.biddingSepratorView.isHidden = false
        }
        
        viewControllersArr = uvArr
        
        return uvArr
    }
    
    override func close() {
        if(isOpenFromMainScreen || isFromUFXCheckOut == true || isFromBidding){
//        if(isFromUFXCheckOut == true){
            isFromBidding = false
            GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: true as AnyObject)
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            super.close()
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
