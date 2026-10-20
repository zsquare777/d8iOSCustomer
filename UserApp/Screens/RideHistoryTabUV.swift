

import UIKit

class RideHistoryTabUV: PageTabBarController, PageTabBarControllerDelegate {
    
    let generalFunc = GeneralFunctions()
    
    var isOpenFromMainScreen = false
    var isFromUFXCheckOut = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.configRTL()
    }
    
    open override func prepare() {
        super.prepare()
        
        delegate = self
        preparePageTabBar()
        
        self.addBack()
        
       // let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
//        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
//        self.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
        
        if(ServiceModule.isRideOnly()){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
        }else if(ServiceModule.isDeliveryOnly()){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
        }else if(ServiceModule.isDeliverAllOnly()){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_ORDERS_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_ORDERS_TXT")
            
        }else{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
        }
        
        for i in 0..<self.viewControllers.count{
            if(self.viewControllers[i].isKind(of: RideHistoryUV.self)){
                let rideHistoryUv = self.viewControllers[i] as! RideHistoryUV
                rideHistoryUv.navItem = self.navigationItem
            }
        }
    }
    
    override func close() {
        
        if(isOpenFromMainScreen || isFromUFXCheckOut == true){
            GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: true as AnyObject)
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            super.close()
        }
    }

    
    fileprivate func preparePageTabBar() {
        pageTabBar.lineColor = SColors.Theme
    }
    
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
//        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
}
