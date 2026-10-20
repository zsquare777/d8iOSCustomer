
import UIKit
import CoreLocation
import GoogleMaps
import SysBaseLib
import AdvancedPageControl


class MoreDeliveriesUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, iCarouselDataSource, iCarouselDelegate, OnLocationUpdateDelegate, AddressFoundDelegate, OnTaskRunCalledDelegate, ParentViewUVDelegate,UICollectionViewDelegateFlowLayout, MXParallaxHeaderDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var rideDelHeaderCarouseView: iCarousel!
    @IBOutlet weak var rideDeliveryHeaderView: UIView!
    @IBOutlet weak var rideDeliveryTableView: UITableView!
    @IBOutlet weak var bannerTopView22: UIView!
    @IBOutlet weak var bannerTopCarlosView: iCarousel!
    @IBOutlet weak var bannerTopCarlosViewHight: NSLayoutConstraint!
    @IBOutlet weak var bannerTopview22Hight: NSLayoutConstraint!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var pageControllerWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var plView1: UIView!
    @IBOutlet weak var plView2: UIView!
    @IBOutlet weak var plView3: UIView!
    @IBOutlet weak var plView4: UIView!
    @IBOutlet weak var plView5: UIView!
    @IBOutlet weak var plView6: UIView!
    @IBOutlet weak var plView7: UIView!
    @IBOutlet weak var plView8: UIView!
    @IBOutlet weak var plView9: UIView!
    @IBOutlet weak var plView10: UIView!
    @IBOutlet weak var plView11: UIView!
    @IBOutlet weak var plView12: UIView!
    @IBOutlet weak var plView13: UIView!
    
    @IBOutlet weak var mplView1: UIView!
    @IBOutlet weak var mplView2: UIView!
    @IBOutlet weak var mplView3: UIView!
    @IBOutlet weak var mplView4: UIView!
    @IBOutlet weak var mplView5: UIView!
    @IBOutlet weak var mplView6: UIView!
    @IBOutlet weak var mplView7: UIView!
    @IBOutlet weak var mplView8: UIView!
    @IBOutlet weak var mplView9: UIView!
    @IBOutlet weak var mplView10: UIView!
    @IBOutlet weak var mplView11: UIView!
    @IBOutlet weak var mplView12: UIView!
    @IBOutlet weak var mplView13: UIView!
    @IBOutlet weak var mplView14: UIView!
    @IBOutlet weak var mplView15: UIView!
    @IBOutlet weak var mplView16: UIView!
    @IBOutlet weak var mplView17: UIView!
    @IBOutlet weak var mplView18: UIView!
    @IBOutlet weak var mplView19: UIView!
    @IBOutlet weak var mplView20: UIView!
    @IBOutlet weak var mplView21: UIView!
    @IBOutlet weak var mplView22: UIView!
    @IBOutlet weak var mplView23: UIView!
    @IBOutlet weak var mplView24: UIView!
    @IBOutlet weak var mplView25: UIView!
    @IBOutlet weak var mplView26: UIView!
    @IBOutlet weak var mplView27: UIView!
    @IBOutlet weak var mplView28: UIView!
   
    
    var navItem:UINavigationItem!
    
    var cntView:UIView!
    
    var rideDeliveryCntView:UIView!
    //var collectionMoreService = UICollectionView()
    var iVehicleCategoryId = ""
    var vCategoryName = ""
    
    let generalFunc = GeneralFunctions()

    var userProfileJson:NSDictionary!
    
    var isMenuAdded = false
    var isSafeAreaSet:Bool = false
    var loaderView:UIView!

    var cateroriesDataArr = [CategoriesDataHolder]()
    
    var isFirstRun = true
    
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    
    var homeTabBar:HomeScreenTabBarUV!
    
    var rideDeliveryServicesArray = [NSDictionary] ()
    var rideDeliveryBannersArray = [NSDictionary] ()
    
    var favoriteLocationArray = NSMutableArray()
    var FAV_HOME = "0"
    var FAV_WORK = "1"
    
    var isHomePlaceAdded = false
    var isWorkPlaceAdded = false
    
    var homeLoc:CLLocation!
    var workLoc:CLLocation!
    
    var gMapView:GMSMapView!
    var currentLocation:CLLocation?
    var getLocation:DeviceLocation!
    var tempLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var navigationColorArray = [UIColor]()
    
    var isFromOpneCatType = false
    var catType = ""
    var caousoulDragiing = false
    var getAddressFrmLocation:GetAddressFromLocation!
    var currentAddress = ""
    
    var selectedCabTypeId = ""
    var listOfDrivers = [NSDictionary]()
    var driverMarkerList = [GMSMarker]()
    var RESTRICTION_KM_NEAREST_TAXI:Double = 4
    var ONLINE_DRIVER_LIST_UPDATE_TIME_INTERVAL:Double = 60
    var DRIVER_ARRIVED_MIN_TIME_PER_MINUTE:Double = 3
    var updateDriverListTask:TaskScheduler!
    
    var placeHolderView:UIView!
    let placeholderMarker = Placeholder()
    
    var moreDeliveriesPlaceHolderView:UIView!
    let moreDeliveriesPlaceHolderMarker = Placeholder()
    
    var isRideServiceAvailble = false
    var isDataLoaded = false
    
    var bannerScrollTask:TaskScheduler!
    
    var currentBannerScrollIndex = -1
    var firstTimeBannerScroll = true
    var bannersItemList = [NSDictionary]()
    var shadowImageView:UIImageView!
    var shadowImageViewForSubCat:UIImageView!
    var imageSlideShowPageController: UIPageControl!
    var isFirstLoad = true
    var isNewFlow:Bool{
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        if(userProfileJson.get("ENABLE_RIDE_DELIVERY_NEW_FLOW").uppercased() == "YES" && isFromOpneCatType == false){
            return true
        }else{
            return false
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            cntView = self.generalFunc.loadView(nibName: "MoreDeliveriesScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            
            self.tableView.delegate = self
            self.tableView.bounces = false
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.register(UINib(nibName: "MoreDeliveriesTVC", bundle: nil), forCellReuseIdentifier: "MoreDeliveriesTVC")
            self.tableView.register(UINib(nibName: "UFXJekIconTVC", bundle: nil), forCellReuseIdentifier: "UFXJekIconTVC")
            
            if(isNewFlow){
                
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                
                rideDeliveryCntView = self.generalFunc.loadView(nibName: "RideDeliveryScreenDesign", uv: self, contentView: contentView)
                
                self.contentView.addSubview(rideDeliveryCntView)
                
                placeHolderView = self.generalFunc.loadView(nibName: "RideDeliveryHomePagePV", uv: self, contentView: self.view)
                
                self.contentView.addSubview(placeHolderView)
                
                self.setFavLocations()
                self.rideDeliveryTableView.delegate = self
                self.rideDeliveryTableView.bounces = false
                self.rideDeliveryTableView.dataSource = self
                self.rideDeliveryTableView.tableFooterView = UIView()
                if #available(iOS 15.0, *) {
                    self.rideDeliveryTableView.sectionHeaderTopPadding = 0
                } else {}
                self.rideDeliveryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
                self.rideDeliveryTableView.register(UINib(nibName: "RideDeliveryCollectionCell", bundle: nil), forCellReuseIdentifier: "RideDeliveryCollectionCell")
                self.rideDeliveryTableView.register(UINib(nibName: "ProfileTVCell", bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
                self.rideDeliveryTableView.register(UINib(nibName: "RideDeliveryMapCell", bundle: nil), forCellReuseIdentifier: "RideDeliveryMapCell")
                
                self.rideDeliveryTableView.parallaxHeader.view = self.rideDeliveryHeaderView
                self.rideDeliveryTableView.parallaxHeader.height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                self.rideDeliveryTableView.parallaxHeader.mode = .bottom
                self.rideDeliveryTableView.parallaxHeader.minimumHeight = 0
                
                self.rideDeliveryTableView.isHidden = true
                self.rideDeliveryHeaderView.backgroundColor = UIColor.clear
                self.rideDelHeaderCarouseView.backgroundColor = UIColor.clear
             
                self.rideDelHeaderCarouseView.type = .linear
                self.rideDelHeaderCarouseView.scrollSpeed = 0.8
                self.rideDelHeaderCarouseView.decelerationRate = 0.8
                self.rideDelHeaderCarouseView.delegate = self
                self.rideDelHeaderCarouseView.dataSource = self
                self.rideDelHeaderCarouseView.bounces = false
                
                self.getLocation = DeviceLocation(uv: self, isContinuous: true)
                self.getLocation.buildLocManager(locationUpdateDelegate: self)
                
                getAddressFrmLocation = GetAddressFromLocation(uv: self)
                getAddressFrmLocation.addressFoundDelegate = self
                
                
            
                
            }else{
                moreDeliveriesPlaceHolderView = self.generalFunc.loadView(nibName: "MoreDeliveriesGeneralPV", uv: self, contentView: self.contentView)
                
                self.contentView.addSubview(moreDeliveriesPlaceHolderView)
                self.moreDeliveriesPlaceHolderView.frame = self.contentView.bounds
                self.moreDeliveriesPlaceHolderView.layoutIfNeeded()
                self.moreDeliveriesPlaceHolderView.alpha = 0.0
            }
            
            self.addBack()
            
            if(isMenuAdded == true){
                addMenu()
            }
            
            if(homeTabBar == nil){
                setData()
               // addTitleView()
            }
            
        }else if(type == 1){
            
            if(isNewFlow){
            
                if(isDataLoaded == false){
                    
                    if(isNewFlow){
                        let viewElements: [UIView] = [

                            plView1, plView2, plView3, plView4, plView5, plView6, plView7, plView8, plView9, plView10, plView11, plView12, plView13
                        ]
                        placeholderMarker.register(viewElements)
                        placeholderMarker.startAnimation()
                    }

                }
                
                
                self.setFavLocations()
                self.rideDeliveryTableView.reloadData()
                self.rideDelHeaderCarouseView.reloadData()
                
                if(self.navigationColorArray.count > 0){
                    
                    self.setnavBarTintColor(color: SColors.Theme)
                    
                }
            
            }
            
        }else if(type == 2){
            self.contentView.frame = self.view.bounds
            
            if(isFirstRun){
                getCategoryDetailData()
                isFirstRun = false
                
                if(isNewFlow){
                    self.imageSlideShowPageController = UIPageControl.init(frame: CGRect(x: 10, y: Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9") - 23, width: Application.screenSize.width - 20, height:20))
                    self.imageSlideShowPageController.currentPage = 0
                    self.imageSlideShowPageController.isUserInteractionEnabled = false
                    self.imageSlideShowPageController.tintColor = UIColor.lightGray
                    self.imageSlideShowPageController.hidesForSinglePage = true
                    self.imageSlideShowPageController.pageIndicatorTintColor = UIColor.lightGray
                    self.imageSlideShowPageController.currentPageIndicatorTintColor = SColors.ThemeTxt
                    self.rideDelHeaderCarouseView.addSubview(self.imageSlideShowPageController)
                }
            }
            
            self.setViewframes()
            
            
        }else if(type == 3){
           
            self.setnavBarTintColor(color:SColors.Theme)
            
            self.removePlaceHolderView()
            
            if(self.bannerScrollTask != nil){
                self.bannerScrollTask.stopRepeatingTask()
            }
        }
    }
    

   
//    override func viewDidLayoutSubviews() {
//
//        if(isSafeAreaSet == false){
//
//            if(cntView != nil){
//                self.cntView.frame = self.view.frame
//                cntView.frame.size.height = cntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
//
//
//                if(isNewFlow){
//                    self.rideDeliveryCntView.frame = self.view.frame
//                    rideDeliveryCntView.frame.size.height = rideDeliveryCntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
//
//                }
//
//            }
//
//            isSafeAreaSet = true
//        }
//    }
//
    
    func setViewframes(){
        if(isNewFlow){
    
            if(self.bannerScrollTask != nil){
                self.firstTimeBannerScroll = true
                self.bannerScrollTask.startRepeatingTask()
            }
            
            self.rideDeliveryCntView.frame = self.contentView.bounds
            self.placeHolderView.frame = self.contentView.bounds
            self.placeHolderView.layoutIfNeeded()
            
            
            
        }else{
            
            self.moreDeliveriesPlaceHolderView.frame = self.contentView.bounds
            self.moreDeliveriesPlaceHolderView.layoutIfNeeded()
            self.moreDeliveriesPlaceHolderView.alpha = 0.0
            
            if(isDataLoaded == false){
                let viewElements2: [UIView] = [

                    mplView1, mplView2, mplView3, mplView4, mplView5, mplView6, mplView7, mplView8, mplView9, mplView10, mplView11, mplView12, mplView13, mplView15, mplView16, mplView17, mplView18, mplView19, mplView20, mplView21, mplView22, mplView23, mplView24, mplView25, mplView26, mplView27, mplView27
                ]
                moreDeliveriesPlaceHolderMarker.register(viewElements2)
                moreDeliveriesPlaceHolderMarker.startAnimation()
                
                UIView.animate(withDuration: 0.05, animations: {self.moreDeliveriesPlaceHolderView.alpha = 1.0},
                                                completion: {(value: Bool) in
                                                    
                                                            })
            }
            
        }
        
        if(homeTabBar != nil){
            addTitleView()
        }
        if isFirstLoad {
        isFirstLoad = false
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 20 + (homeTabBar != nil ? homeTabBar.kBarHeight - GeneralFunctions.getSafeAreaInsets().bottom - 20 : 0), right: 0)
        }
    }
    
    func initializeUpdateDriverListTask(){
        if(updateDriverListTask == nil){
            
            updateDriverListTask = TaskScheduler(interval: ONLINE_DRIVER_LIST_UPDATE_TIME_INTERVAL)
            updateDriverListTask.currInst = updateDriverListTask
            updateDriverListTask.setTaskRunListener(onTaskRunCalled: self)
            updateDriverListTask.isAvoidFirstRun = true
            updateDriverListTask.startRepeatingTask()
        }
        
    }
    
    func initializeBannerFreqTask(){
        if(bannerScrollTask == nil){
            
            bannerScrollTask = TaskScheduler(interval: 9.0)
            bannerScrollTask.currInst = bannerScrollTask
            bannerScrollTask.setTaskRunListener(onTaskRunCalled: self)
            bannerScrollTask.isAvoidFirstRun = true
            bannerScrollTask.startRepeatingTask()
        }
        
    }
    
    
    func onTaskRun(currInst: TaskScheduler) {
        
        if(currInst == self.bannerScrollTask){
            if(self.rideDelHeaderCarouseView != nil && self.firstTimeBannerScroll == false){
                if(self.cateroriesDataArr.count - 1 == self.rideDelHeaderCarouseView.currentItemIndex){
                    self.currentBannerScrollIndex = -1
                }else{
                    self.currentBannerScrollIndex = self.rideDelHeaderCarouseView.currentItemIndex
                }
                self.currentBannerScrollIndex = self.currentBannerScrollIndex + 1
                self.rideDelHeaderCarouseView.scrollToItem(at: self.currentBannerScrollIndex, animated: true)
            }else{
                self.firstTimeBannerScroll = false
            }
        }else if(currInst == self.updateDriverListTask){
            if(self.currentLocation != nil){
                self.getAvailableCars()
            }
        }
        
    }
    
    
    func onLocationUpdate(location: CLLocation) {
       
        self.currentLocation = location
        
        getAddressFrmLocation.setLocation(latitude: self.currentLocation!.coordinate.latitude, longitude: self.currentLocation!.coordinate.longitude)
        getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
        getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow:false)
        
        self.rideDeliveryTableView.reloadData()
        
    }
    
    func onAddressFound(address: String, location: CLLocation, isPickUpMode:Bool, dataResult:String) {
        self.currentAddress = address
    }
    
    func addMenu(){
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_all_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openMenu))
        self.navItem.leftBarButtonItem = leftButton
    }
    
    func addTitleView(){
        
        let navHeight = self.navigationController!.navigationBar.frame.height
        let width = (((navHeight) * 350) / 119)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: 45))
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let image = UIImage(named: "ic_your_logo")
        imageView.image = image
        
        if(self.homeTabBar == nil){
            self.navigationController?.navigationItem.titleView = imageView
        }else{
            self.homeTabBar.navItem.titleView = imageView
        }
        
    }
 
    
    @objc func openMenu(){
//        if(Configurations.isRTLMode()){
//            self.navigationDrawerController?.isRightPanGestureEnabled = true
//            self.navigationDrawerController?.toggleRightView()
//
//        }else{
//            self.navigationDrawerController?.isLeftPanGestureEnabled = true
//            self.navigationDrawerController?.toggleLeftView()
//        }
    }
    
    
    func removePlaceHolderView(){
        if(self.placeHolderView != nil){
            self.contentView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.placeHolderView.alpha = 0.0},
                                            completion: {(value: Bool) in
                                                self.placeHolderView.removeFromSuperview()
                                                        })
        }
        
        if(self.moreDeliveriesPlaceHolderView != nil){
            self.contentView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.moreDeliveriesPlaceHolderView.alpha = 0.0},
                                            completion: {(value: Bool) in
                                                self.moreDeliveriesPlaceHolderView.removeFromSuperview()
                                                        })
        }
        
    }
    
    func setData(){
        self.navigationItem.title = vCategoryName
        self.title = vCategoryName
    }
    
    func setFavLocations(){
        
        self.favoriteLocationArray.removeAllObjects()
        
        self.favoriteLocationArray.add(Headline.init(title: "", image: "", id: "", attributedTitle: NSMutableAttributedString.init(string: ""), rightSideImage: ""))
        let userHomeLocationAddress = GeneralFunctions.getValue(key: "userHomeLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userHomeLocationAddress") as! String) : ""
        let userWorkLocationAddress = GeneralFunctions.getValue(key: "userWorkLocationAddress") != nil ? (GeneralFunctions.getValue(key: "userWorkLocationAddress") as! String) : ""
       
        if(userHomeLocationAddress != ""){
            isHomePlaceAdded = true
            
            let finalStr = NSMutableAttributedString.init(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PLACE") + "\n")
            
            let attributedTitleString = NSMutableAttributedString(string:(GeneralFunctions.getValue(key: "userHomeLocationAddress") as? String ?? ""))
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 13)]
            attributedTitleString.addAttributes(yourOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedTitleString.length))
            finalStr.append(attributedTitleString)
            
            let homeLatitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userHomeLocationLatitude") as! String)
            let homeLongitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userHomeLocationLongitude") as! String)
            
            self.favoriteLocationArray.add(Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_PLACE"), image: "ic_search_home", id: FAV_HOME, attributedTitle:finalStr, rightSideImage: "ic_edit"))
            
            self.homeLoc = CLLocation(latitude: homeLatitude, longitude: homeLongitude)
            
        }else{
            self.favoriteLocationArray.add(Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_HOME_PLACE_TXT"), image: "ic_search_home", id: FAV_HOME, attributedTitle:NSMutableAttributedString.init(string: ""), rightSideImage: "ic_add_plus"))
            isHomePlaceAdded = false
        }
        

        if(userWorkLocationAddress != ""){
            isWorkPlaceAdded = true
            
            let finalStr = NSMutableAttributedString.init(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORK_PLACE") + "\n")
            
            let attributedTitleString = NSMutableAttributedString(string:(GeneralFunctions.getValue(key: "userWorkLocationAddress") as? String ?? ""))
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.init(name: Fonts().semibold, size: 13)]
            attributedTitleString.addAttributes(yourOtherAttributes as [NSAttributedString.Key : Any], range: NSMakeRange(0, attributedTitleString.length))
            finalStr.append(attributedTitleString)
            
            let workLatitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userWorkLocationLatitude") as! String)
            let workLongitude = GeneralFunctions.parseDouble(origValue: 0.0, data: GeneralFunctions.getValue(key: "userWorkLocationLongitude") as! String)
            
            self.favoriteLocationArray.add(Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORK_PLACE"), image: "ic_search_work", id: FAV_WORK, attributedTitle:finalStr, rightSideImage: "ic_edit"))
            
            self.workLoc = CLLocation(latitude: workLatitude, longitude: workLongitude)
            
        }else{
            self.favoriteLocationArray.add(Headline.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_WORK_PLACE_TXT"), image: "ic_search_work", id: FAV_WORK, attributedTitle:NSMutableAttributedString.init(string: ""), rightSideImage: "ic_add_plus"))
            
            isWorkPlaceAdded = false
        }
    }
    
    @objc func homePlaceEditTapped(){
        let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
        addDestinationUv.SCREEN_TYPE = "HOME"
        addDestinationUv.centerLocation = self.homeLoc
        addDestinationUv.isFromRideDelivery = true
       
        addDestinationUv.isPickUpMode = false
      
        self.push(uv: addDestinationUv)
    }
    
    @objc func workPlaceEditTapped(){
        let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
        addDestinationUv.SCREEN_TYPE = "WORK"
        addDestinationUv.centerLocation = self.workLoc
        addDestinationUv.isFromRideDelivery = true
        
        addDestinationUv.isPickUpMode = false
        
        self.push(uv: addDestinationUv)
    }
    

    func getCategoryDetailData(){
//        if(loaderView == nil){
//            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
//            loaderView.backgroundColor = UIColor.clear
//        }else{
//            loaderView.isHidden = false
//        }
        
     
        
        let parameters = ["type": "getServiceCategoryDetails", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "iVehicleCategoryId":isNewFlow == true ? "0" : self.iVehicleCategoryId,"vLatitude" : self.selectedLatitude, "vLongitude" : self.selectedLongitude]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess { [self] (response) in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    self.catType = dataDict.get("eFor")
                    self.removePlaceHolderView()
                    self.isDataLoaded = true
                    
                    if(self.isNewFlow){
                        
                        
                        self.navigationController?.setNavigationBarHidden(false, animated: true)
                        self.setViewframes()
                        
                        self.rideDeliveryTableView.isHidden = false
                        
                        self.rideDeliveryServicesArray = response.toDict().arrOf(Utils.message_str) as! [NSDictionary]
                        self.rideDeliveryBannersArray = response.toDict().arrOf("bannerArray")  as! [NSDictionary]
                        
                        for i in 0..<self.rideDeliveryBannersArray.count{
                            let item = self.rideDeliveryBannersArray[i]
                            self.navigationColorArray.append(UIColor.init(hexString: item.get("vStatusBarColor"), alpha: 1))
                        }
                        
                        
                        for i in 0..<self.rideDeliveryServicesArray.count{
                            let item = self.rideDeliveryServicesArray[i]
                            if(item.get("eCatType") == "Ride"){
                                self.isRideServiceAvailble = true
                                break
                            }
                        }
                        
                        self.rideDelHeaderCarouseView.reloadData()
                        self.rideDeliveryTableView.reloadData()
                        
                        
                        if(Configurations.isRTLMode()){
                            self.imageSlideShowPageController.currentPage = 0
                            var newreverseArray = [NSDictionary]()
                            let totalIndices = self.rideDeliveryBannersArray.count - 1
                            for arrayIndex in 0...totalIndices {
                                newreverseArray.append(self.rideDeliveryBannersArray[totalIndices - arrayIndex])
                            }
                            self.rideDeliveryBannersArray = newreverseArray
            
                            self.rideDelHeaderCarouseView.scrollToItem(at: self.rideDeliveryBannersArray.count, duration: 0)
                            self.imageSlideShowPageController.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

                        }
                        
                        self.initializeBannerFreqTask()
                        self.initializeUpdateDriverListTask()
                    }
                    

                    for i in 0..<msgArr.count{
                        let tmpDict = msgArr[i] as! NSMutableDictionary
                        let holder = CategoriesDataHolder()
                        let vImage = Utils.getResizeImgURL(imgUrl: tmpDict.get("vImage"), width: Utils.getValueInPixel(value: Utils.getWidthOfBanner(widthOffset: 30)), height: Utils.getValueInPixel(value: Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")))
                        tmpDict["vImage"] = tmpDict.get("vImage") //vImage
                        holder.categoriesDataDict = tmpDict
                        
                        if(dataDict.get("eDetailPageView").uppercased() == "ICON"){
                            
        
                            holder.subCategoriesDataArr = tmpDict.arrOf("SubCategory")
                            
                            var maxSubCatHeight:CGFloat = 0
                            
                            for j in 0..<holder.subCategoriesDataArr.count{
                                let subTempItem = holder.subCategoriesDataArr[j] as! NSMutableDictionary
                                
                                let vCategory = subTempItem.get("vCategory")
                                let tCategoryDesc = subTempItem.get("tCategoryDesc")
                                
                                let iconImgURL = Utils.getResizeImgURL(imgUrl: subTempItem.get("vImage"), width: Utils.getValueInPixel(value: 150), height: Utils.getValueInPixel(value: 150))
                                
                                subTempItem["vImage"] = iconImgURL
                                
                                let vCategoryHeight = vCategory.height(withConstrainedWidth: Application.screenSize.width - 144, font: UIFont(name: Fonts().semibold, size: 16)!)
                                
                                let tCategoryDescHeight = tCategoryDesc.height(withConstrainedWidth: Application.screenSize.width - 144, font: UIFont(name: Fonts().light, size: 14)!)
                                
                                
                                let totalRowHeight = (vCategoryHeight + tCategoryDescHeight + 50) < 132 ? 132 : (vCategoryHeight + tCategoryDescHeight + 50)
                                if(totalRowHeight > maxSubCatHeight){
                                    maxSubCatHeight = totalRowHeight
                                }
                                holder.subCategoriesExtraHeightContainer.append(totalRowHeight)
                            }
                            
                            maxSubCatHeight = maxSubCatHeight + 15
                            
                            let parentCategory = tmpDict.get("vCategory").uppercased()
                            
                            let parentDescription = tmpDict.get("tCategoryDesc")
                    
                            
                            let parentCategoryHeight = parentCategory.height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont(name: Fonts().semibold, size: 18)!)
                            
                            let parentCategoryDescHeight = parentDescription.height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont(name: Fonts().light, size: 12)!)
                            holder.subItemRowHeight = maxSubCatHeight
                            //holder.itemRowHeight = 35 + parentCategoryHeight + parentCategoryDescHeight + maxSubCatHeight
                            holder.itemRowHeight =  parentCategoryHeight + parentCategoryDescHeight
                        }else{
                            
                            
                            let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")
                            holder.itemRowHeight = height + 10
                        }
                        
                        self.cateroriesDataArr.append(holder)
                    }
                    
                    let bannerData = dataDict.arrOf("BANNER_DATA")
                    self.bannersItemList = bannerData as! [NSDictionary]
                    if self.bannersItemList.count > 0 {
                        self.setBannerData22()
                        self.setPageController()
                    }
                    self.tableView.reloadData()
                    
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btn_id) in
                        self.close()
                    })
                }
            }else{
                self.getCategoryDetailData()
            }
            //self.loaderView.isHidden = true
        }
    }
    
    func getAvailableCars(){
        
//        if(self.gMapView != nil){
//            if(loaderView == nil){
//                loaderView =  self.generalFunc.addMDloader(contentView: self.gMapView)
//                loaderView.backgroundColor = UIColor.clear
//            }else{
//                loaderView.isHidden = false
//            }
//        }
        
      
        let parameters = ["type": "getOnlineDriversRideDelivery", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "PickUpLatitude":"\(self.currentLocation!.coordinate.latitude)", "PickUpLongitude":"\(self.currentLocation!.coordinate.longitude)", "PickUpAddress":"", "DestLatitude":"", "DestLongitude":"", "DestAddress":"", "eType":userProfileJson.get("APP_TYPE")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess { (response) in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let msgArr = dataDict.arrOf("DriverList")
                    self.listOfDrivers = msgArr as! [NSDictionary]
                    
                    //let previousContentHeight = self.rideDeliveryTableView.contentSize.height
                  //  let previousContentOffset = self.rideDeliveryTableView.contentOffset.y
                    self.rideDeliveryTableView.reloadData()
                   // let currentContentOffset = self.rideDeliveryTableView.contentSize.height - previousContentHeight + previousContentOffset
                  //  self.rideDeliveryTableView.contentOffset = CGPoint(x: 0, y: currentContentOffset)
    
                    
                }else{
//                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btn_id) in
//                        self.close()
//                    })
                }
            }else{
                //self.getCategoryDetailData()
            }
           // self.loaderView.isHidden = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
    
        if(tableView == self.rideDeliveryTableView){
            return self.isRideServiceAvailble == true ? 3 : 2
        }else{
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.rideDeliveryTableView){
            
            if(section == 0){
                return 1
            }else if(section == 1){
                if(self.isRideServiceAvailble == true){
                    return self.favoriteLocationArray.count
                }else{
                    return 1
                }
                
            }else{
                return 1
            }
            
        }else{
            
            if self.catType.uppercased() == "DeliverAllCategory".uppercased() {
                if self.cateroriesDataArr.count == 0 {
                    return 0
                }else {
                return 1
                }
            }else {
               return self.cateroriesDataArr.count
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == self.rideDeliveryTableView){
            
            if(indexPath.section == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "RideDeliveryCollectionCell", for: indexPath) as! RideDeliveryCollectionCell
                
                cell.moreDeliveriesUV = self
                cell.rideDeliveryServicesDataArray.removeAll()
                cell.rideDeliveryServicesDataArray = self.rideDeliveryServicesArray
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
                cell.collectionView.reloadData()
                return cell
                
            }else if(indexPath.section == 1){
                
                if(self.isRideServiceAvailble == true){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
                    cell.selectionStyle = .none
                    
                    
                    if(indexPath.row == self.favoriteLocationArray.count - 1 || indexPath.row == 0){
                        cell.saparaterLine.isHidden = true
                    }else{
                        cell.saparaterLine.isHidden = false
                    }
                    
                    if(indexPath.row == 0){
                        cell.rideDelWhereToLbl.isHidden = false
                        cell.rideDelWhereToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WHERE_TO")
                    }else{
                        
                        cell.rideDelWhereToLbl.isHidden = true
                        let headerData = self.favoriteLocationArray[indexPath.row] as! Headline
                        if(headerData.attributedTitle == NSMutableAttributedString.init(string: "")){
                            cell.titleLbl.text = headerData.title
                        }else{
                            cell.titleLbl.attributedText = headerData.attributedTitle
                        }
                        
                        cell.iconImgView.backgroundColor = SColors.Theme
                        
                        cell.iconImgView.image = UIImage(named:headerData.image)!.addImagePadding(x: 20, y: 20)
                        GeneralFunctions.setImgTintColor(imgView: cell.iconImgView, color: UIColor.white)
                        
                        var rightImage = ""
                        if(headerData.rightSideImage == ""){
                            rightImage = "ic_arrow_right"
                        }else{
                            rightImage = headerData.rightSideImage
                        }
                        
                        cell.nextArrowContainerView.tag = Int(headerData.id)!
                        
                        cell.nextArrowContainerView.handleClick { (instance) in
                            
                            if("\(instance.tag)" == self.FAV_HOME){
                                self.homePlaceEditTapped()
                            }
                            
                            if("\(instance.tag)" == self.FAV_WORK){
                                self.workPlaceEditTapped()
                            }
                        }
                        
                        
                        if(headerData.id == FAV_WORK || headerData.id == FAV_HOME){
                            if(Configurations.isRTLMode()){
                                cell.nextArrowImgView.image = UIImage(named:rightImage)?.addImagePadding(x: 22, y: 22)?.rotate(180)
                            }else{
                                cell.nextArrowImgView.image = UIImage(named:rightImage)?.addImagePadding(x: 22, y: 22)
                            }
                        }else{
                            if(Configurations.isRTLMode()){
                                cell.nextArrowImgView.image = UIImage(named:rightImage)?.rotate(180)
                            }else{
                                cell.nextArrowImgView.image = UIImage(named:rightImage)
                            }
                        }
                        
                        GeneralFunctions.setImgTintColor(imgView: cell.nextArrowImgView, color: UIColor.lightGray)
                    }
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RideDeliveryMapCell", for: indexPath) as! RideDeliveryMapCell
                
                    cell.selectionStyle = .none
                    
                    if(self.gMapView != nil){
                        self.gMapView.removeFromSuperview()
                    }
                    
                    let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                                          longitude: 0.0, zoom: Utils.defaultZoomLevel)
                    self.gMapView = GMSMapView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width - 40, height: 180), camera: camera)
                    cell.mapView.addSubview(self.gMapView)
                    
                    if(self.currentLocation != nil){
                        
                        self.tempLocation = self.currentLocation!
                       

                        let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation!.coordinate.latitude,
                                                              longitude: self.currentLocation!.coordinate.longitude, zoom: Utils.defaultZoomLevel)
                       
                
                        self.gMapView.moveCamera(GMSCameraUpdate.setCamera(camera))
                        
                        
                    }
                    
                    if(self.gMapView != nil && self.currentLocation != nil){
                        self.filterDrivers()
                    }
                    

                    cell.mapView.isUserInteractionEnabled = false
                    return cell
                }
             
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RideDeliveryMapCell", for: indexPath) as! RideDeliveryMapCell
            
                cell.selectionStyle = .none
                
                if(self.gMapView != nil){
                    self.gMapView.removeFromSuperview()
                }
                
                let camera = GMSCameraPosition.camera(withLatitude: 0.0,
                                                      longitude: 0.0, zoom: Utils.defaultZoomLevel)
                self.gMapView = GMSMapView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width - 40, height: 180), camera: camera)
                cell.mapView.addSubview(self.gMapView)
                
                if(self.currentLocation != nil){
                    
                    self.tempLocation = self.currentLocation!
                   

                    let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation!.coordinate.latitude,
                                                          longitude: self.currentLocation!.coordinate.longitude, zoom: Utils.defaultZoomLevel)
                   
            
                    self.gMapView.moveCamera(GMSCameraUpdate.setCamera(camera))
                    
                    
                }
                
                if(self.gMapView != nil && self.currentLocation != nil){
                    self.filterDrivers()
                }
                

                cell.mapView.isUserInteractionEnabled = false
                return cell
            }
            
        }else{
            let tmpDataHolder = self.cateroriesDataArr[indexPath.item]
            let item = tmpDataHolder.categoriesDataDict!
            
            if(tmpDataHolder.subCategoriesDataArr != nil){
                let cell = tableView.dequeueReusableCell(withIdentifier: "MoreDeliveriesTVC", for: indexPath) as! MoreDeliveriesTVC
                
                cell.tag = indexPath.row
                if indexPath.row == 0 {
                    cell.headerLblTop.constant = 10
                }else{
                    cell.headerLblTop.constant = 10
                }
                cell.collectionView.tag = indexPath.row
                
                cell.headerLbl.text = item.get("vCategory")
                
                cell.descLbl.text = item.get("tCategoryDesc")
                
                let subItemRowHeight = tmpDataHolder.subItemRowHeight
                
                cell.subItemRowHeight = subItemRowHeight
                cell.subCategoriesDataArr = tmpDataHolder.subCategoriesDataArr
                cell.subCategoriesExtraHeightContainer = tmpDataHolder.subCategoriesExtraHeightContainer
                
                cell.collectionView.register(UINib(nibName: "MoreDeliveriesCVC", bundle: nil), forCellWithReuseIdentifier: "MoreDeliveriesCVC")
                
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.isHidden = false
                cell.collectionView.isScrollEnabled = false
               
                //cell.collectionViewHeight.constant = subItemRowHeight

                let cellSize = CGSize(width: Application.screenSize.width - 20 , height: subItemRowHeight)
                
                cell.collectionView.reloadData()
                
                //let layout = UICollectionViewFlowLayout()
                //layout.scrollDirection = .vertical
//                layout.itemSize = cellSize
//                layout.minimumLineSpacing = 0.0
//                layout.minimumInteritemSpacing = 0.0
//                cell.collectionView.collectionViewLayout.invalidateLayout()
//                cell.collectionView.setCollectionViewLayout(layout, animated: false)
                
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
                
                return cell
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "UFXJekIconTVC", for: indexPath) as! UFXJekIconTVC
                cell.collectionView.register(UINib(nibName: "UFXJekIconCVCNew", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVCNew")
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.tag = -1
                cell.collectionView.isScrollEnabled = false
                cell.selectionStyle = .none
                Utils.delayWithSeconds(3) {
                    cell.collectionView.layoutIfNeeded()
                    cell.collectionView.reloadData()
                    
                }
               
//                let layout = UICollectionViewFlowLayout()
//                layout.scrollDirection = .horizontal
//                cell.collectionView.isScrollEnabled = true
                cell.backgroundColor = UIColor.clear
                return cell
//                cell.tag = indexPath.row
//
//                cell.categoryImgView.backgroundColor = UIColor(hex: 0xadadad)
//                cell.categoryImgView.contentMode = .scaleAspectFit
//                //cell.rightMargin.constant = 10
//                //cell.leftMargin.constant = 10
//
//                cell.categoryImgView.sd_setImage(with: URL(string: item.get("vImage")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//                    //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
//                    if(image != nil){
//                        cell.categoryImgView.image = image
//                    }else if(item.get("vImage") != "" && !item.get("vImage").contains(find: "http")){
//                        cell.categoryImgView.image = UIImage(named: item.get("vImage"))
//                    }else{
//                        cell.categoryImgView.image = UIImage(named: "ic_no_icon")
//                    }
//                })
//
//                cell.categoryLbl.text = item.get("vCategoryBanner") != "" ? item.get("vCategoryBanner") : item.get("vCategory")
//
//                cell.bookNowLbl.text = item.get("tBannerButtonText") == "" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_NOW") : item.get("tBannerButtonText")
//                cell.bookNowLbl.backgroundColor = SColors.Theme
//                cell.bookNowLbl.textColor = SColors.ThemeTxt
//
//                cell.bookNowLbl.layer.masksToBounds = true
//                cell.bookNowLbl.layer.cornerRadius = 5
//
//                cell.categoryLbl.layer.masksToBounds = true
//                cell.categoryLbl.layer.cornerRadius = 5
//
//
//                cell.categoryImgView.layer.borderColor = UIColor(hex: 0xe4e4e4).cgColor
//                cell.categoryImgView.layer.borderWidth = 1
//                cell.categoryImgView.layer.masksToBounds = true
//                cell.categoryImgView.layer.cornerRadius = 10
               
                //self.collectionMoreService = cell.collectionView
                
                //cell.backgroundColor = UIColor.clear
                //cell.collectionView.reloadData()

                
//                cell.selectionStyle = .none
//
//                var CornerImg = UIImage(named: "ic_btn_rightarrow")!
//                if(Configurations.isRTLMode()){
//                    CornerImg = CornerImg.rotate(180)
//                }
//
//                cell.bottomCornerImgView.image = CornerImg
//                cell.bottomCornerView.backgroundColor = SColors.Theme
//                if(Configurations.isRTLMode()){
//                    cell.bottomCornerView.roundTo(corners: [.bottomLeft], radius: 6)
//                }else{
//                    cell.bottomCornerView.roundTo(corners: [.bottomRight], radius: 6)
//                }
//
//                Utils.createRoundedView(view: cell.bottomCornerView, borderColor: .clear, borderWidth: 0, cornerRadius: 0)
//                GeneralFunctions.setImgTintColor(imgView: cell.bottomCornerImgView, color: .white)
                
            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView == self.rideDeliveryTableView){
            
            if(indexPath.section == 0){
                return ((Application.screenSize.width - 60) / 3) + 60
            }else if(indexPath.section == 1){
                if(self.isRideServiceAvailble == true){
                    let selectedFAVRow = (self.favoriteLocationArray[indexPath.row] as! Headline).id
                    if(selectedFAVRow == FAV_HOME && isHomePlaceAdded){
                        return 90
                    }else if(selectedFAVRow == FAV_WORK && isWorkPlaceAdded){
                        return 90
                    }else{
                        return 65
                    }
                }else{
                    return 375
                }
                
            }else{
                return 375
            }
            
            
        }else{
            let tmpDataHolder:CategoriesDataHolder = self.cateroriesDataArr[indexPath.item] as CategoriesDataHolder
           // return 330
            if(tmpDataHolder.subCategoriesDataArr != nil){

                let rowHeightCount:Int = (tmpDataHolder.subCategoriesDataArr.count)
                if (rowHeightCount <= 0){
                    return tmpDataHolder.itemRowHeight
                }else{
                    var  extraSpace = 40
                    
                     if (Configurations.isRTLMode()) && !UIDevice.current.model.hasPrefix("iPad"){
                           extraSpace = 60
                        }
                    
                    if UIDevice.current.model.hasPrefix("iPad") {
                        extraSpace = 60
                    }
                    return ((tmpDataHolder.itemRowHeight + (CGFloat(rowHeightCount) * tmpDataHolder.subItemRowHeight))) + CGFloat(extraSpace)
                }

            }else{
             
                let collectionViewSize = Application.screenSize.width  - 20//collectionView.frame.size.width - padding
                
                let hight = ((collectionViewSize / 1) + 25)
                return CGFloat((self.cateroriesDataArr.count / 1 )) * hight + 70
                
            }
        }
        
     
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == -1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVCNew", for: indexPath) as! UFXJekIconCVC

            let tmpDataHolder = self.cateroriesDataArr[indexPath.item]
            let item = tmpDataHolder.categoriesDataDict!
           
            cell.viewContent.layer.addShadow(opacity: 1.0, radius: 3, UIColor.gray)
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 68), height: Utils.getValueInPixel(value: 68))
            cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon")) { (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

            }
            //cell.iconImgView.image =
//            cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//
//                if(image != nil){
//                    cell.iconImgView.image = image
//                }else if(item.get("vImage") != "" && !item.get("vImage").contains(find: "http")){
//                    cell.iconImgView.image = UIImage(named: item.get("vImage"))
//                }else{
//                   cell.iconImgView.image = UIImage(named: "ic_no_icon")
//                }
//            })
            //cell.bgView.backgroundColor = UIColor.clear
            cell.categoryLbl.text = item.get("vCategoryBanner") != "" ? item.get("vCategoryBanner") : item.get("vCategory")
            if(item.get("vCategory").contains(find: " ")){
                cell.categoryLbl.numberOfLines = 2
            }else{
                cell.categoryLbl.numberOfLines = 1
            }
            //cell.backgroundColor = UIColor.clear
            return cell
        }else {
            
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreDeliveriesCVC", for: indexPath) as! MoreDeliveriesCVC
        
     
        let holder = self.cateroriesDataArr[collectionView.tag]
        let itemDataDict = holder.subCategoriesDataArr[indexPath.row] as! NSDictionary
        

        cell.titleLbl.text = itemDataDict.get("vCategory")
        cell.subTitleLbl.text = itemDataDict.get("tCategoryDesc")
   
        var CornerImg = UIImage(named: "ic_btn_rightarrow")!
        if(Configurations.isRTLMode()){
            CornerImg = CornerImg.rotate(180)
        }

            Utils.createRoundedView(view: cell.parentView, borderColor: .clear, borderWidth: 0, cornerRadius: 10)
            cell.parentView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
        
        
        cell.iconImgView.sd_setImage(with: URL(string: itemDataDict.get("vImage")), placeholderImage: UIImage(named:"ic_no_icon")) { (image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in

        }
        
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == -1 {
           return self.cateroriesDataArr.count
        }else {
        return self.cateroriesDataArr[collectionView.tag].subCategoriesDataArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == -1 {
            let tmpDataHolder = self.cateroriesDataArr[indexPath.item]
            let item = tmpDataHolder.categoriesDataDict!
            _ = OpenCatType.init(uv: self, navItem: self.navItem, item: item)
        }
            else {
        let holder = self.cateroriesDataArr[collectionView.tag]
        let item = holder.subCategoriesDataArr[indexPath.row] as! NSDictionary
        
         _ = OpenCatType.init(uv: self, navItem: self.navItem, item: item)
        }
    }
    func getWidthOfItemNew() -> CGFloat{
        let totalItemInRow = 2//Int(self.view.frame.width / 110) < 2 ? 2 : Int(self.view.frame.width / 110)
        return (Application.screenSize.width / CGFloat(totalItemInRow)) - 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == -1 {
            let padding: CGFloat =  20
            //let collectionViewSize = collectionView.frame.size.width - padding
            let collectionViewSize = Application.screenSize.width  - 120//collectionView.frame.size.width - padding
            
            return CGSize(width: collectionViewSize / 2 , height: (collectionViewSize / 2) + 25 )
        }else {
            let padding: CGFloat =  50
            let collectionViewSize = collectionView.frame.size.width - padding
            
            return CGSize(width: Application.screenSize.width - 20, height: 150)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == -1 {
           

            return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        }else {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        let tempWidht = collectionViewSize/2

        let totalCellWidth =  tempWidht * CGFloat(collectionView.numberOfItems(inSection: 0))
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)

        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + CGFloat(totalSpacingWidth))) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == self.rideDeliveryTableView){
           
             if(self.isRideServiceAvailble == true && indexPath.section == 1){
                let selectedFAVRow = (self.favoriteLocationArray[indexPath.row] as! Headline).id
               
                switch selectedFAVRow {
                case FAV_HOME:
                    if(GeneralFunctions.getMemberd() == ""){
                        self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignInUV"))
                    }else{
                        if(isHomePlaceAdded){
                            homePlaceTapped()
                        }else{
                            homePlaceEditTapped()
                        }
                    }
                    break
                case FAV_WORK:
                    if(GeneralFunctions.getMemberd() == ""){
                        self.push(uv: GeneralFunctions.instantiateViewController(pageName: "SignInUV"))
                    }else{
                        if(isWorkPlaceAdded){
                            workPlaceTapped()
                        }else{
                            workPlaceEditTapped()
                        }
                    }
                    break
                default:
                    break
                }
            }
        }else{
            let holder = self.cateroriesDataArr[indexPath.row]
            //let item = holder.subCategoriesDataArr[indexPath.row] as! NSDictionary
         
            
            _ = OpenCatType.init(uv: self, navItem: self.navItem, item: holder.categoriesDataDict)
        }
        
    
    }
    
    @objc func homePlaceTapped(){
        //        self.close()
        //        self.mainScreenUV.continueLocationSelected(selectedLocation: , selectedAddress: (GeneralFunctions.getValue(key: "userHomeLocationAddress") as! String))
        
        for i in 0..<self.rideDeliveryServicesArray.count{
            
            let item = self.rideDeliveryServicesArray[i]
            if(item.get("eCatType").uppercased() == "RIDE"){
                let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                mainScreenUv.APP_TYPE = "Ride"
                mainScreenUv.vTitleFromUFX = item.get("vCategory")
                mainScreenUv.pickUpLocation = self.currentLocation
                mainScreenUv.pickUpAddress = self.currentAddress
               
                mainScreenUv.isFromUFXhomeScreen = true
                self.push(uv: mainScreenUv)
                
                Utils.delayWithSeconds(1.0) {
                    mainScreenUv.homePlaceViewTapped()
                }
                
            }
        }
        
    }
    
    
    @objc func workPlaceTapped(){
        for i in 0..<self.rideDeliveryServicesArray.count{
            
            let item = self.rideDeliveryServicesArray[i]
            if(item.get("eCatType").uppercased() == "RIDE"){
                let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                mainScreenUv.APP_TYPE = "Ride"
                mainScreenUv.vTitleFromUFX = item.get("vCategory")
                mainScreenUv.pickUpLocation = self.currentLocation
                mainScreenUv.pickUpAddress = self.currentAddress
                
                mainScreenUv.isFromUFXhomeScreen = true
                self.push(uv: mainScreenUv)
                
                Utils.delayWithSeconds(1.0) {
                    mainScreenUv.workPlaceViewTapped()
                }
                
            }
        }
        
        
    }
    
    func setCabTypeId(selectedCabTypeId:String){
        self.selectedCabTypeId =  selectedCabTypeId
    
    }
    
    func getDriverMarkerList() -> [GMSMarker]{
        return self.driverMarkerList
    }
    
    func setDriverMarkerList(driverMarkerList:[GMSMarker]){
        self.driverMarkerList = driverMarkerList
    }
    
    func getDriverMarkerOnPubNubMsg(iDriverId:String, isRemoveFromList:Bool) -> GMSMarker?{
        
        var driverMarkerList = self.getDriverMarkerList()
        
        for i in 0..<driverMarkerList.count{
            let marker = driverMarkerList[i]
            let driver_id = marker.title?.replace("DriverId", withString: "")
            if(driver_id == iDriverId){
                if(isRemoveFromList){
                    driverMarkerList.remove(at: i)
                    self.setDriverMarkerList(driverMarkerList: driverMarkerList)
                }
                
                return marker
            }
        }
        
        return nil
    }
    
    func drawMarker(location:CLLocation, Name:String, driverData:NSDictionary) -> GMSMarker{
        if(self.gMapView == nil){
            return GMSMarker()
        }
        let eIconType = driverData.get("eIconType")
        
        var iconId = "ic_driver_car_pin"
        if(eIconType == "Bike"){
            iconId = "ic_bike"
        }else if(eIconType == "Cycle"){
            iconId = "ic_cycle"
        }else if(eIconType == "Truck"){
            iconId = "ic_truck"
        }else if(eIconType == "Fly"){
            iconId = "ic_fly"
        }
        
        let driverMarker = GMSMarker()
        
        driverMarker.position = location.coordinate
        driverMarker.title = "DriverId\(driverData.get("driver_id"))"
        
        driverMarker.icon = UIImage(named: iconId)
        driverMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        
        driverMarker.isFlat = true
        driverMarker.rotation = 0
        driverMarker.map = self.gMapView
        driverMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        
        return driverMarker
    }
    
    func removeDriversFromMap(isUnSubscribeAll:Bool){
        if(driverMarkerList.count > 0){
            for i in 0..<driverMarkerList.count {
                driverMarkerList[i].map = nil
            }
            self.driverMarkerList.removeAll()
        }
      
    }
    
    func filterDrivers(){
        
        var lowestKM = 0.0
        var isFirst_lowestKM = true
        
        var currentLoadedDrivers = [NSDictionary]()
        
        var driverMarkerListTemp = [GMSMarker]()
        
        var bounds = GMSCoordinateBounds()
        bounds =  bounds.includingCoordinate(self.currentLocation!.coordinate)
        

        for i in 0..<listOfDrivers.count{
            let driverData = listOfDrivers[i]
            var driverData1 = listOfDrivers[i] as! [String: String]
            
            
            let driverName = driverData.get("Name")
           
            
            let driverLocLatitude = GeneralFunctions.parseDouble(origValue: 0.0, data: driverData.get("vLatitude"))
            let driverLocLongitude = GeneralFunctions.parseDouble(origValue: 0.0, data: driverData.get("vLongitude"))
            
            let distance = self.currentLocation!.distance(from: CLLocation(latitude: driverLocLatitude, longitude: driverLocLongitude)) / 1000
            
            if(isFirst_lowestKM == true){
                lowestKM = distance
                isFirst_lowestKM = false
            }else {
                if (distance < lowestKM) {
                    lowestKM = distance
                }
            }
            
    
            if (distance < RESTRICTION_KM_NEAREST_TAXI){

            //                distance < RESTRICTION_KM_NEAREST_TAXI
                
                driverData1["DIST_TO_PICKUP"] = "\(distance)"
                
//                currentLoadedDrivers += [driverData1 as NSDictionary]
                
                let eIconType = driverData.get("eIconType")
                
              
                driverData1["eIconType"] = "\(eIconType)"
                
                let driverMarker = self.drawMarker(location: CLLocation(latitude: driverLocLatitude, longitude: driverLocLongitude), Name: driverName, driverData: driverData)
                
                driverMarkerListTemp += [driverMarker]
                
                bounds =  bounds.includingCoordinate(CLLocation(latitude: driverLocLatitude, longitude: driverLocLongitude).coordinate)

                 currentLoadedDrivers += [driverData1 as NSDictionary]
            }
        }
    
        //self.removeDriversFromMap(isUnSubscribeAll: false)
        self.driverMarkerList.append(contentsOf: driverMarkerListTemp)
        
    }
    
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        if(self.bannerTopCarlosView == carousel) {
            return self.bannersItemList.count
        }else {
        if(self.imageSlideShowPageController != nil){
            self.imageSlideShowPageController.numberOfPages = self.rideDeliveryBannersArray.count
        }
        return self.rideDeliveryBannersArray.count
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        if(self.bannerTopCarlosView == carousel){
            
            var mainView:UIView!
            var imgView:UIImageView!
            var widthMinusValue = 60
            if bannersItemList.count == 1 {
                widthMinusValue = 45
            }
            if (imgView == nil){
                
                let height = Utils.getHeightOfBanner(widthOffset: CGFloat(widthMinusValue), ratio: "",2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                
                
               // mainView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
                imgView = UIImageView.init(frame: CGRect(x:0, y: 0, width: carousel.frame.size.width - CGFloat(widthMinusValue), height: height))
                imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
               // mainView.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - CGFloat(widthMinusValue))
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                
                print(Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue))
                
                
                
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
                
                
            }else{
                
                view?.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                
                imgView = view?.subviews[0] as? UIImageView
                imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
                let height = Utils.getHeightOfBanner(widthOffset: CGFloat(widthMinusValue), ratio: "",2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - CGFloat(widthMinusValue))
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
              
            }
            
            return imgView
        }
        
        else {
        let item = self.rideDeliveryBannersArray[index]
        
        var mainView:UIView!
        var imgView:UIImageView!
        var titleLbl:MyLabel!
        var subTitleLbl:MyLabel!
        var buttonLbl:MyLabel!
        if (view == nil){
        
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            
            let heightValue = Utils.getValueInPixel(value: height)
            
            
            mainView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))
            
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))
            
            let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 0)
            
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width:widthValue, height: heightValue)), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                 

                
            })
            
            
            
           // imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
            
            imgView.contentMode = .scaleAspectFit
           // imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
            mainView.addSubview(imgView)
            
            titleLbl = MyLabel.init(frame: CGRect(x:20, y:15, width: carousel.frame.size.width - 40, height: 25))
            titleLbl.font = UIFont(name: Fonts().semibold, size: 18)!
            titleLbl.fontFamilyWeight = "Medium"
            titleLbl.setFontFamily()
            titleLbl.numberOfLines = 1
            titleLbl.text = item.get("vTitle")
            titleLbl.textColor = UIColor.init(hexString: item.get("vTextColor"), alpha: 1)
            mainView.addSubview(titleLbl)
            
            subTitleLbl = MyLabel.init(frame: CGRect(x:20, y: titleLbl.frame.origin.y + titleLbl.frame.height + 5, width: carousel.frame.size.width - 40, height: 50))
            subTitleLbl.font = UIFont(name: Fonts().regular, size: 15)!
            subTitleLbl.fontFamilyWeight = "Regular"
            subTitleLbl.setFontFamily()
            subTitleLbl.numberOfLines = 2
            subTitleLbl.text = item.get("vSubtitle")
            subTitleLbl.textColor = UIColor.init(hexString: item.get("vTextColor"), alpha: 1)
            mainView.addSubview(subTitleLbl)
            
            buttonLbl = MyLabel.init(frame: CGRect(x:20, y:subTitleLbl.frame.origin.y + subTitleLbl.frame.height + 20, width: 150, height: 45))
            buttonLbl.font = UIFont(name: Fonts().semibold, size: 16)!
            buttonLbl.fontFamilyWeight = "Medium"
            buttonLbl.setFontFamily()
            buttonLbl.textAlignment = .center
            buttonLbl.numberOfLines = 1
            buttonLbl.paddingLeft = 15
            buttonLbl.paddingRight = 15
            buttonLbl.text = item.get("vBtnTtitle")
            buttonLbl.backgroundColor = UIColor.init(hexString: item.get("vBtnBgColor"), alpha: 1)
            buttonLbl.textColor = UIColor.init(hexString: item.get("vBtnTextColor"), alpha: 1)
            buttonLbl.cornerRadius = 22
            buttonLbl.clipsToBounds = true
            mainView.addSubview(buttonLbl)
            
            mainView.isUserInteractionEnabled = true
            buttonLbl.isUserInteractionEnabled = true
            buttonLbl.tag = index
            buttonLbl.handleClick { (instance) in
                
                let item = self.rideDeliveryBannersArray[instance.tag]
                _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
            }
            
        }
        
        return mainView
        }
    }
   

    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        
        if(self.bannerTopCarlosView == carousel){
            if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
                if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                    self.bannerTopCarlosView.contentOffset = CGSize(width: 15, height: 0)
                }else{
                    self.bannerTopCarlosView.contentOffset = CGSize(width: -15, height: 0)
                }

            }else{
                self.bannerTopCarlosView.contentOffset = CGSize(width: 0, height: 0)
            }
            
        }else {
        
        
        if(carousel.currentItemIndex >= 0 && self.navigationColorArray.count > 0){
            
            if(self.imageSlideShowPageController != nil){
                self.imageSlideShowPageController.currentPage = carousel.currentItemIndex
            }
            
            
            self.setnavBarTintColor(color:SColors.Theme)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.alpha = 1
            }, completion: {_ in
                
            })
        }
        
        }
    }
    
  
    func carouselDidScroll(_ carousel: iCarousel) {
        if(self.caousoulDragiing == true){
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.alpha = 0.8
                self.caousoulDragiing = false
            }, completion: nil)
        }
        
    }
    
    
    func carouselWillBeginDragging(_ carousel: iCarousel) {
        self.caousoulDragiing = true
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        UIView.animate(withDuration: 0.1, animations: {
            self.navigationController?.navigationBar.alpha = 1
        }, completion: nil)
    }
   
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if(self.bannerTopCarlosView == carousel){
           
            if(option == .spacing){
                if UIDevice.current.userInterfaceIdiom == .pad {
                   return value * 1.02
                }else{
                    return value * 1.04
                }
            }
            return value
            
        }else {
        if(option == .spacing){
            if UIDevice.current.userInterfaceIdiom == .pad {
               return value * 1.0
            }else{
                return value * 1.0
            }
        }
        return value
        }
    }
    
    @IBAction func unwindToMoreDeliveriesScreen(_ segue:UIStoryboardSegue) {
      
        
    }
    func setBannerData22(){
        
        
        self.bannerTopView22.backgroundColor = UIColor.clear
            
        self.bannerTopCarlosView.backgroundColor = UIColor.clear
            
        self.bannerTopCarlosView.type = .linear
        self.bannerTopCarlosView.scrollSpeed = 0.8
        self.bannerTopCarlosView.decelerationRate = 0.8
        self.bannerTopCarlosView.delegate = self
        self.bannerTopCarlosView.dataSource = self
        self.bannerTopCarlosView.bounces = false
        //Utils.delayWithSeconds(1) {
            if self.bannersItemList.count <= 1 {
                self.bannerTopCarlosView.contentOffset = CGSize(width: 0, height: 0)
            }else{
                self.bannerTopCarlosView.contentOffset = CGSize(width: -15, height: 0)
            }
            
            self.bannerTopCarlosView.reloadData()
       // }
       
          
        self.tableView.parallaxHeader.view = nil
      
        if(self.bannersItemList.count > 0){
            
            self.setnavBarTintColor(color: SColors.Theme)
                
                self.bannerTopView22.isHidden = false
                self.tableView.isHidden = false
            self.bannerTopview22Hight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "" , 2.33)
            self.bannerTopCarlosViewHight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "" , 2.33)
                
                self.tableView.parallaxHeader.view = self.bannerTopView22
                self.tableView.parallaxHeader.mode = .bottom
                self.tableView.parallaxHeader.height = self.bannerTopview22Hight.constant
                self.tableView.parallaxHeader.minimumHeight = 0
                self.tableView.parallaxHeader.delegate = self
              
    }
        self.addTable22SubViews()
    }
    func addTable22SubViews(){
        
//        if(self.shadowImageView != nil){
//            self.shadowImageView.removeFromSuperview()
//            self.shadowImageView = nil
//        }
//        self.shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: -45, width: Application.screenSize.width, height: 50))
//        shadowImageView.image = UIImage(named: "shadow1")
//
//        self.tableView.addSubview(shadowImageView)
        
    }
    func setPageController(){
        pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.bannersItemList.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor: SColors.Theme.dark(by: 0), dotsColor: .white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        //pageController.backgroundColor =  SColors.btBg.withAlphaComponent(0.7)//UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 1.0)
       // pageController.opacity = 0.8//SColors.Theme
        pageController.backgroundColor =  UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.5)
        pageController.layer.cornerRadius = 8
        pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        self.pageController.isHidden = true
        pageControllerWidth.constant = CGFloat((self.bannersItemList.count * 15) + 15)
        if pageControllerWidth.constant > Application.screenSize.width {
            pageControllerWidth.constant = Application.screenSize.width - 40
        }
        pageController.tintColor = SColors.Theme
    }
}


class CategoriesDataHolder  {
    var categoriesDataDict:NSDictionary!
    var subCategoriesDataArr:NSArray!
    var subCategoriesExtraHeightContainer = [CGFloat]()
    var itemRowHeight:CGFloat = 0
    var subItemRowHeight:CGFloat = 0
}
