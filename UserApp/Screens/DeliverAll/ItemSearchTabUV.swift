
import UIKit
import CoreLocation

class ItemSearchTabUV: ButtonBarPagerTabStripViewController, UISearchBarDelegate {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var buttonBarContainerView: UIView!
    
    let generalFunc = GeneralFunctions()
    
    var isOpenFromMainScreen = false
    
    var viewControllersArr:[UIViewController]!
    
    var currentLocation:CLLocation!
    var selectedAddress = ""
    
    var cusineArray = [NSDictionary]()
    var restaurantsArray = [NSDictionary]()
    var itemsArray = [NSDictionary]()
    var sectionCount = 0
    var sectionTitleArray = [String]()
    
    var searchBar:UISearchBar!
    
    var isLaunched = false
    
    var serachStarted = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.addBack()
        self.navigationItem.setHidesBackButton(true, animated:false)
        self.configRTL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settings.style.buttonBarItemTitleColor = SColors.Theme
        
        self.topHeaderView.backgroundColor = SColors.Theme
        buttonBarView.selectedBar.backgroundColor = UIColor.clear
        
        buttonBarView.backgroundColor = UIColor.clear
        
        buttonBarView.layer.zPosition = 9999
        
        //self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFICATIONS")
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = UIColor.white
            
            newCell?.label.font = UIFont.init(name: Fonts().semibold, size: 16)
            oldCell?.label.font = UIFont.init(name: Fonts().semibold, size: 16)
            
            oldCell?.label.backgroundColor = UIColor.clear
            newCell?.label.backgroundColor = SColors.Theme
            
            newCell?.backgroundColor = SColors.Theme
            oldCell?.backgroundColor = UIColor.clear
            
            for i in 0..<self.viewControllersArr.count{
                
                if((self.viewControllersArr[i] as! RestaurantSearchUV).tableView != nil){
                   
                    (self.viewControllersArr[i] as! RestaurantSearchUV).cusineArray = self.cusineArray
                    (self.viewControllersArr[i] as! RestaurantSearchUV).restaurantsArray = self.restaurantsArray
                    (self.viewControllersArr[i] as! RestaurantSearchUV).itemsArray = self.itemsArray
                }
                
            }
        
        }
        
        self.buttonBarContainerView.alpha = 0
        self.topHeaderView.alpha = 0
        self.buttonBarView.alpha = 0
        
        self.containerView.backgroundColor = UIColor(hex: 0xf1f1f1)
        
    }
    
    @objc func filterDataTapped(){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(isLaunched == false){
            searchBar = UISearchBar(frame: CGRect(x: 0, y:0 , width: self.view.frame.size.width - 120, height: 200))
             searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_RESTAURANT")
             searchBar.delegate = self
             if #available(iOS 13, *) {
                 searchBar.searchTextField.backgroundColor = UIColor.white
             }
             searchBar.enablesReturnKeyAutomatically = true
             searchBar.returnKeyType = .done
             searchBar.becomeFirstResponder()
             searchBar.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: SColors.Theme), for: .search, state: .normal)
             
             let leftNavBarButton = UIBarButtonItem(customView:searchBar)
             self.navigationItem.leftBarButtonItem = leftNavBarButton
             
             let rightButton: UIBarButtonItem = UIBarButtonItem.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelBtnAction))
             self.navigationItem.rightBarButtonItem = rightButton;
             
             //self.viewFirstLaunch = false
             
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view.backgroundColor = UIColor(hex: 0xf1f1f1)
                self.buttonBarContainerView.alpha = 1
                self.topHeaderView.alpha = 1
                self.buttonBarView.alpha = 1
                
            }, completion:{ _ in})
             
             if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0){
                 
                // (viewControllersArr[0] as! NotificationsUV).viewDidAppear(true)
             }
            
            self.isLaunched = true
        }
        
    }
    
    func dismissKeyboard()
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    @objc func cancelBtnAction()
    {
        self.close()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3
        {
            self.serachStarted = true
            self.getCusineList(searchText: searchText)
        }else
        {
            self.serachStarted = false
            self.sectionTitleArray.removeAll()
            self.cusineArray.removeAll()
            self.restaurantsArray.removeAll()
            self.itemsArray.removeAll()
            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).cusineArray = self.cusineArray
            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).restaurantsArray = self.restaurantsArray
            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).itemsArray = self.itemsArray
            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).sectionTitleArray = self.sectionTitleArray
            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.reloadData()
            

        }
    }
    
    func getCusineList(searchText:String)
    {
        
        let parameters = ["type":"loadSearchRestaurants","PassengerLon": "\(self.currentLocation.coordinate.longitude)", "PassengerLat": "\(self.currentLocation.coordinate.latitude)", "vAddress": self.selectedAddress,"searchword":searchText, "iUserId":GeneralFunctions.getMemberd(),"eSystem" : "DeliverAll"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
               
                self.sectionTitleArray.removeAll()
                self.cusineArray.removeAll()
                self.restaurantsArray.removeAll()
                self.itemsArray.removeAll()
                
                self.cusineArray = dataDict.arrOf("message_cusine") as! [NSDictionary]
                self.restaurantsArray = dataDict.arrOf("message") as! [NSDictionary]
                self.itemsArray = dataDict.arrOf("message_item") as! [NSDictionary]
                
                if self.cusineArray.count > 0
                {
                    self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUISINES"))
                    self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_TXT"))
                }
                
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).vTtype == "RestaurantSearchV"){
                        
                        if(self.restaurantsArray.count > 0){
                            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = false
                        }else{
                            if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl != nil){
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl.isHidden = false
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = true
                            }
                        }
                        
                    }
                    
                    if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).vTtype == "CusineSearchUV"){
                        
                        if self.cusineArray.count > 0
                        {
                            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = false
                            
                        }else{
                            
                            self.sectionTitleArray.removeAll()
                            if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl != nil){
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl.isHidden = false
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = true
                            }
                            
                        }
                        
                    }
                    
                    if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).vTtype == "ItemSearchUV"){
                        
                        if(self.itemsArray.count > 0){
                            (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = false
                        }else{
                            if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl != nil){
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl.isHidden = false
                                (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = true
                            }
                            
                        }
                        
                    }
                    
                    if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView != nil){
                        (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).cusineArray = self.cusineArray
                        (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).restaurantsArray = self.restaurantsArray
                        (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).itemsArray = self.itemsArray

                        (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).sectionTitleArray = self.sectionTitleArray
                        (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.reloadData()
                    }
                    
                    
                }else{
                   if((self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl != nil){
                       (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).noRecordLbl.isHidden = false
                       (self.viewControllersArr[self.currentIndex] as! RestaurantSearchUV).tableView.isHidden = true
                   }
                }
                    
//                    if self.cusineArray.count > 0 && self.restaurantsArray.count > 0
//                    {
//                        self.sectionCount = 2
//                        self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUISINES"))
//                        self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_TXT"))
//                        self.tableView.isHidden = false
//                        
//                    }else if (self.cusineArray.count > 0 && self.restaurantsArray.count == 0) || (self.cusineArray.count == 0 && self.restaurantsArray.count > 0)
//                    {
//                        if self.cusineArray.count > 0 && self.restaurantsArray.count == 0
//                        {
//                            self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUISINES"))
//                        }else{
//                            self.sectionTitleArray.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_TXT"))
//                        }
//                        self.sectionCount = 1
//                        self.tableView.isHidden = false
//                        
//                    }else{
//                        
//                        self.tableView.isHidden = true
//                    }
//                    
//                    self.tableView.reloadData()
                    
                
                
            }else{
                
            }
            
        })
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let restaurantSearchUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantSearchUV") as! RestaurantSearchUV
        let itemSearchUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantSearchUV") as! RestaurantSearchUV
        let cusineSearchUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantSearchUV") as! RestaurantSearchUV
        
        restaurantSearchUV.itemSearchTabBar = self
        itemSearchUV.itemSearchTabBar = self
        cusineSearchUV.itemSearchTabBar = self
        
        restaurantSearchUV.vTtype = "RestaurantSearchV"
        restaurantSearchUV.selectedAddress = self.selectedAddress
        restaurantSearchUV.currentLocation = self.currentLocation
        
        itemSearchUV.vTtype = "ItemSearchUV"
        itemSearchUV.selectedAddress = self.selectedAddress
        itemSearchUV.currentLocation = self.currentLocation
        
        cusineSearchUV.vTtype = "CusineSearchUV"
        cusineSearchUV.selectedAddress = self.selectedAddress
        cusineSearchUV.currentLocation = self.currentLocation
        
        
        var uvArr = [UIViewController]()
        
        // if(Configurations.isRTLMode() == true){
        // uvArr += [providerReviewsUv]
        //  uvArr += [providerGalleryUv]
        //  uvArr += [providerServicesUV]
        // }else{
        uvArr += [restaurantSearchUV]
        uvArr += [itemSearchUV]
        uvArr += [cusineSearchUV]
        
        viewControllersArr = uvArr
        
        return uvArr
    }
}
