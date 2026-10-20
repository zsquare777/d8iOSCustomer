

import UIKit
import SysBaseLib
import CoreLocation
import WebKit
import AdvancedPageControl
import SysBaseLib
import GoogleMobileAds
import FBAudienceNetwork
import AdSupport
class RentItemHomeUV: ParentViewUV, UIScrollViewDelegate, OnLocationUpdateDelegate, AddressFoundDelegate, UITableViewDelegate, UITableViewDataSource, MyLabelClickDelegate , UICollectionViewDelegate , UICollectionViewDataSource, iCarouselDataSource, iCarouselDelegate, MXParallaxHeaderDelegate, WKNavigationDelegate, ParentViewUVDelegate ,GADBannerViewDelegate,FBAdViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placesLbl: MyLabel!
    @IBOutlet weak var filtersLbl: MyLabel!
    @IBOutlet weak var relevanceLbl: MyLabel!
    @IBOutlet weak var relevanceDownImg: UIImageView!
    
    @IBOutlet weak var newHeaderView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var imgSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerBackView: UIView!
    
    @IBOutlet weak var filterAplliedCheckImgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblNodata: MyLabel!
    @IBOutlet weak var noServiceAviImgView: UIImageView!
    @IBOutlet weak var editLocLbl: MyLabel!
    @IBOutlet weak var noServiceSubLbl: MyLabel!
    @IBOutlet weak var noServiceAvailLbl: MyLabel!
    
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    
    // Relevance View outlets
    @IBOutlet weak var relevanceBKView: UIView!
    @IBOutlet weak var relevanceMainView: UIView!
    @IBOutlet weak var relevanceMainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var relevanceCloseLbl: UILabel!
    @IBOutlet weak var relevanceStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var relevanceTitleLbl: MyLabel!
    @IBOutlet weak var relevanceStackview: UIStackView!
    @IBOutlet weak var releRelLbl: MyLabel!
    @IBOutlet weak var relRatingLbl: MyLabel!
    @IBOutlet weak var relTimeLbl: MyLabel!
    @IBOutlet weak var relCostLTHLbl: MyLabel!
    @IBOutlet weak var relCostHTLLbl: MyLabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartitemCountLbl: UILabel!
    @IBOutlet weak var cartImgView: UIImageView!
    @IBOutlet weak var cartViewBottomSpace: NSLayoutConstraint!
    
    // Bottom Rating View
    @IBOutlet weak var ratingBottomView: UIView!
    @IBOutlet weak var ratingBottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ratingCompanyLbl: MyLabel!
    @IBOutlet weak var ratingCancelImgView: UIImageView!
    @IBOutlet weak var ratingBar: RatingView!
    @IBOutlet weak var ratingBottom: NSLayoutConstraint!
    
    //searchHeaderView
    @IBOutlet weak var searchHeaderView: UIView!
    @IBOutlet weak var searchIconImgView: UIImageView!
    @IBOutlet weak var searchLbl: MyLabel!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var preferenceView: UIView!
    @IBOutlet weak var preferenceImgView: UIImageView!
    @IBOutlet weak var cuisinesLbl: MyLabel!
    @IBOutlet weak var cuisinesCollectionView: UICollectionView!
    
    @IBOutlet weak var newListingMainView: UIView!
    @IBOutlet weak var wantMoreLbl: MyLabel!
    @IBOutlet weak var newListView: UIView!
    @IBOutlet weak var newListingLbl: MyLabel!
    
    @IBOutlet weak var topMsgView: UIView!
    @IBOutlet weak var searchHeaderView2: UIView!
    @IBOutlet weak var preferenceImgView2: UIImageView!
    @IBOutlet weak var prefRenceView2: UIView!
    
    @IBOutlet weak var cusinesView: UIView!
    @IBOutlet weak var cusinessCollectionView: UIView!

    @IBOutlet weak var cussinessCollectionMainViewHight: NSLayoutConstraint!
    @IBOutlet weak var searchView2: UIView!
    @IBOutlet weak var searchIconImgView2: UIImageView!
    @IBOutlet weak var searchLbl2: MyLabel!
    @IBOutlet weak var resCategoryTableView: UITableView!
    @IBOutlet weak var containerViewheight: NSLayoutConstraint!
    @IBOutlet weak var headerHight: NSLayoutConstraint!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var advancPageControllerWidhth: NSLayoutConstraint!
    
    @IBOutlet weak var filterImageView: UIImageView!
    
    
    var shadowImageView:UIImageView!
    var lastRatingDic:NSDictionary!
    
    var relevanceViewItemTextColor:UIColor!

    var getAddressFrmLocation:GetAddressFromLocation!
    
    var bannersItemList = [String]()
    var cntView:UIView!
    
    var navItem:UINavigationItem!
    let generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    
    var parentCategoryItems = [NSDictionary]()
    var subCategoryItems = [NSDictionary]()
    
    var currentItems = [NSDictionary]()
    
    var currentMode = "PARENT_MODE"
    
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var subFiltertID = ""
    var subFiltertOptionID = ""
    var selectedData = [String]()
    var selectedOptionData = [String]()
    
    var userProfileJson:NSDictionary!
    
    var getLocation:DeviceLocation!
    
    var enterLocLbl:MyLabel!
    var locationDialog:OpenEnableLocationView!
    
    var currentLocation:CLLocation!
    var menuImage = UIImageView()
    
    var isSafeAreaSet = false
    
    var isFirstLoc = true
    
    var restaurantsList = [NSDictionary]()
    var nextPage_str = 1
    var isLoadingMore = false
    var isNextPageAvail = false
    
    var filetrView:SDragViewForFilter!
    var filterBGView:UIView!
    var filterTableView: UITableView!
    var catList = [NSDictionary]()
    var filterResetLbl:UILabel!
    var applyLbl:UILabel!
    var setFilterCheckedArrayForSection0 = [Bool]()
    var setFilterCheckedArrayForSection1 = [Bool]()
    var tempSetFilterCheckedArrayForSection0 = [Bool]()
    var tempSetFilterCheckedArrayForSection1 = [Bool]()
    
    @IBOutlet weak var anchorView2: UIView!
    @IBOutlet weak var anchorSubview2: UIView!
    var filterApplied = false
    var dataLoading = false
    var bottomDataLoading = false
    
    var selctedRelevance = ""
    var isFromCategory = false
    var cancelratingTapGue:UITapGestureRecognizer!
    var ratingTapGue:UITapGestureRecognizer!
    
    var parallexHeaderViewHeight:CGFloat = 250.0
    var lastScrollPosition:CGPoint!
    var dragingStartFromZero = false
    var cartHeight:CGFloat = 0.0
    var isOfferAvilable = false
    
    var homeTabBar:HomeScreenTabBarUV!
    
    var msgLbl:MyLabel!
    
    var selectedCuisineIndex = 0
    var selectedCuisineId = ""
    var refreshControl: OffsetableRefreshControl!
    
    var isEnableCategoryWiseListing = false
    var categoryWiseListArray = [NSDictionary]()
    var categorySeeAllModeEnable = false
    var sectedcategoryID = ""
    var whoDetailView:WhoDetailView!
   
    var centerloader:UIView!
    
    var tableViewBGView:UIView!
    var resCatTableBGView:UIView!
    var pageControl1:AdvancedPageControlView!
    var isLoad1 = true
    var bannerView: GADBannerView!
    var adView: FBAdView?
    var googleAdLoad = false
    var fbAdLoad = false
    var rentCategoryId = ""
    var rentData = [NSDictionary]()
    var catID = ""
    var eType = ""
    var searchKeyWord = ""
    var isFromSearch = false
    var isLoadFristTime = false
    var isLoadFristTimeStr = "No"
    var isBuySell = "Yes"
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
             
            cntView = self.generalFunc.loadView(nibName: "RentItemHomeScreenDesign", uv: self, contentView: contentView) //,
            self.contentView.addSubview(cntView)
            
            
           
            
           // GeneralFunctions.saveValue(key: "ispriceshow", value: "" as AnyObject)
    
            self.cuisinesCollectionView.register(UINib(nibName: "RentCuisinesCVC", bundle: nil), forCellWithReuseIdentifier: "RentCuisinesCVC")
            self.cuisinesCollectionView.dataSource = self
            self.cuisinesCollectionView.delegate = self
            self.cuisinesCollectionView.reloadData()
            self.cuisinesCollectionView.bounces = false
           
                self.cuisinesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            
            self.searchHeaderView.backgroundColor = SColors.Theme
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 101, height: 120)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.scrollDirection = .horizontal
            self.cuisinesCollectionView!.collectionViewLayout = layout
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            addTitleView()
            setData()
            self.newHeaderView.backgroundColor = SColors.Theme
            
            let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
            if serviceCategoryArray.count > 1
            {
                
                self.addBack()
                
            }else
            {
                if(ServiceModule.isDeliverAllOnly())
                {
                    self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 50, right: 0)
                   
                    addMenu()
                }else
                {
                    self.addBack()
                }
                
            }
            self.cartView.isHidden = true
            
            
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OUT_OF_DELIVERY_AREA").uppercased()
            self.noServiceAvailLbl.textColor = SColors.Theme
            self.noServiceSubLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_AREA_NOTE")
            self.editLocLbl.backgroundColor = SColors.Theme
            self.editLocLbl.textColor = SColors.ThemeTxt
            self.editLocLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT_LOCATION")
            let editLocTapGue = UITapGestureRecognizer()
            editLocTapGue.addTarget(self, action: #selector(self.titleViewTapped))
            self.editLocLbl.isUserInteractionEnabled = true
            self.editLocLbl.addGestureRecognizer(editLocTapGue)
            
            self.resCategoryTableView.register(UINib(nibName: "RentCategoryListTVCell", bundle: nil), forCellReuseIdentifier: "RentCategoryListTVCell")
            
            ratingCancelImgView.image? = (ratingCancelImgView.image?.addImagePadding(x: 10, y: 10))!
            
            
            
          
            self.contentView.alpha = 0
            
            if(self.userProfileJson.get("ENABLE_CATEGORY_WISE_STORES").uppercased() == "YES"){
                self.isEnableCategoryWiseListing = true
            }
            if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes") && self.homeTabBar != nil {
                
                
                let adSize = GADAdSizeFromCGSize(CGSize(width: Application.screenSize.width, height: 50))
                bannerView = GADBannerView(adSize: adSize)
                bannerView.adUnitID = userProfileJson.get("GOOGLE_ADMOB_ID")
                bannerView.rootViewController = self
                bannerView.delegate = self
                bannerView.load(GADRequest())
            }
            Utils.delayWithSeconds(0.5) {
                if(self.userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") && self.homeTabBar != nil {
                   
                   
                    
                    self.adView = FBAdView(placementID: self.userProfileJson.get("FACEBOOK_PLACEMENT_ID_IOS"), adSize: kFBAdSizeHeight50Banner, rootViewController: self)
                    self.adView?.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: 50)
                    
                    FBAdSettings.setAdvertiserTrackingEnabled(false)
                   
                    self.adView?.delegate = self
                    self.adView?.loadAd()
                }
            }
            //self.loadBanners()
            self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_SEARCH")
            self.searchBar.delegate = self
            self.searchBar.clipsToBounds = true
            //self.searchBar.sizeToFit()
            self.searchBar.cornerRadius = 8
            searchBar.backgroundImage = UIImage()
            if #available(iOS 13, *) {
                searchBar.searchTextField.backgroundColor = UIColor.white
                
            }

            self.contentView.isHidden = true
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        }else if(type == 1){
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.navigationController?.navigationBar.layer.zPosition = 1
            GeneralFunctions.postNotificationSignal(key: EventService.resumeInst_key, obj: self)
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]


            self.newListingMainView.backgroundColor = UIColor(hex: 0xf6f6f6)
            self.wantMoreLbl.textColor = SColors.blackColor
            self.newListView.layer.borderWidth = 1
            self.newListView.layer.borderColor = UIColor.black.cgColor
            self.newListView.backgroundColor = UIColor(hex: 0x1B2A3B)
            self.newListingLbl.textColor = SColors.ThemeTxt
            self.newListingLbl.text = "+" + self.generalFunc.getLanguageLabel(origValue: "+ Start New Listing", key: "LBL_RENT_NEW_LISTING_TXT")
            
            if(self.eType.uppercased() == "RENTESTATE"){
                self.wantMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "Want to sell something?", key: "LBL_REAL_ESTATE_ITEM_TXT")
            }else if(self.eType.uppercased() == "RENTCARS"){
                self.wantMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "Have a car to sell or rent out?", key: "LBL_RENT_CAR_ITEM_TXT")
            }else if(self.eType.uppercased() == "RENTITEM"){
                self.wantMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "Have an item to sell or rent out?", key: "LBL_RENT_SELL_ITEM_TXT")
            }
            
            self.topMsgView.backgroundColor = SColors.Theme
            Utils.delayWithSeconds(0.5) {
               // self.newHeaderView.roundTo(corners: [.bottomLeft,.bottomRight], radius: 40)
            }
            
            self.newListingMainView.handleClick { (searchView) in
                let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
                rentItemNewPostUV.rentCatId = self.catID
                rentItemNewPostUV.eType = self.eType
                rentItemNewPostUV.isFromHome = true
                self.push(uv: rentItemNewPostUV)
            }
            if(self.msgLbl != nil){
                self.msgLbl.isHidden = true
            }
            
                cartHeight = 0
                self.cartView.isHidden = true
                self.cartitemCountLbl.isHidden = true
                self.cartitemCountLbl.text = ""
            
            self.cartitemCountLbl.backgroundColor = UIColor.black
            
            
            
            //cuisinesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "")
            self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
            self.anchorSubView.backgroundColor = SColors.Theme
            if isLoadFristTimeStr == "No" {
            isFromSearch = false
                
            self.getPost()
            }
        }else if(type == 2){
            let userProfileJsonDict = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.configRTL()
            let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
            if (serviceCategoryArray.count == 1 && (ServiceModule.isDeliverAllOnly())){
                let item = (serviceCategoryArray[0] as! NSDictionary)
                if(item.get("eShowTerms").uppercased() == "YES"){
                    let openAgeTerms = OpenAgeTerms()
                    //openAgeTerms.deliverAllUFXHome = self
                    openAgeTerms.openAgeTermsView(item:item)
                }
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.appInBackground), name: NSNotification.Name(rawValue: Utils.appBGNotificationKey), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.appInForground), name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
            //self.imgSlideShow.frame.origin.y = 0
            Utils.delayWithSeconds(1) {
                //self.imgSlideShow.contentOffset = CGSize(width: -15, height: 0)
            }
            
            
            
            self.addFilterView()
            if(self.selectedLatitude == "" && self.selectedLongitude == ""){
                checkLocationEnabled()
                getLocation = DeviceLocation(uv: self, isContinuous: false)
                getLocation.buildLocManager(locationUpdateDelegate: self)
                self.configRTL()
            }
            
            self.tableView.parallaxHeader.delegate = self
            self.containerView.frame.size = CGSize(width: self.view.frame.width, height: containerView.height)
            addTitleView()
            
           
            
            let height: CGFloat = 50 //whatever height you want to add to the existing height
            let bounds = self.navigationController!.navigationBar.bounds
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
            
            if(self.categorySeeAllModeEnable == true){
                self.addBackButtonForSeeAll()
            }
            if isLoadFristTimeStr == "No" {
            isFromSearch = false
            isLoadFristTimeStr = "Yes"
            self.getPost()
            }
            
           // self.searchBar.setPlaceholderTextColorTo(color: UIColor(hex: 0x8FA1B4),textColor: UIColor(hex: 0x1B2A3B))
        }else if(type == 3){
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appBGNotificationKey), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
            
            if (filterBGView != nil &&  filetrView != nil){
                filterBGView.removeFromSuperview()
                filetrView.removeFromSuperview()
            }
        }
    }
    
  
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        
        if(parallaxHeader.progress <= 0){
            
            self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            //self.selectServiceLbl.layer.shadowOpacity = 0.0;
            self.containerView.layer.borderColor = UIColor.clear.cgColor
        }
        
    }

    override func close() {
        
        if(categorySeeAllModeEnable){
            self.isEnableCategoryWiseListing = true
            UIView.transition(with: self.resCategoryTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.resCategoryTableView.isHidden = false
            })
            
            self.categorySeeAllModeEnable = false
            self.sectedcategoryID = ""
            self.refreshTableViewPageContent()
            //self.getRestaurantDetails(location: self.currentLocation, withFilter: false)
            
            self.setHeaderView()
            
            let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
            if (serviceCategoryArray.count == 1){
                if(self.homeTabBar == nil){
                    
                    if(self.navItem == nil){
                       
                       self.navigationItem.leftBarButtonItem = nil;
                    }else{
                       self.navItem.leftBarButtonItem = nil;
                    }
                }else{
                    if self.homeTabBar.navItem == nil {
                        self.homeTabBar.navItem =  self.navigationItem
                    }
                    self.homeTabBar.navItem.leftBarButtonItem = nil;
                }
            }
           
        }else{
            super.close()
        }
    }
   
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        refreshControl.endRefreshing()
        self.refreshTableViewPageContent()
        isFromSearch = false
        self.getPost()
        //self.getRestaurantDetails(location: self.currentLocation, withFilter: self.filterApplied)
        
    }
   
    
    override func viewDidLayoutSubviews() {

        
    }
    
    
    
    func addMenu(){
        if(self.navItem != nil){
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_all_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openMenu))
            self.navItem.leftBarButtonItem = leftButton
        }
        
    }
    
    
    
   
    
    @objc func openRestaurantSearchUV()
    {
        if(self.userProfileJson.get("isShowSearchedItemEnabled").uppercased() == "YES"){
            let itemSearchTabUV = GeneralFunctions.instantiateViewController(pageName: "ItemSearchTabUV") as! ItemSearchTabUV
            
            if self.currentLocation == nil
            {
                self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
            }
            itemSearchTabUV.selectedAddress = self.selectedAddress
            itemSearchTabUV.currentLocation = self.currentLocation
            self.push(uv: itemSearchTabUV)
        }else{
            let restaurantSearchOldUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantSearchOldUV") as! RestaurantSearchOldUV
            
            if self.currentLocation == nil
            {
                self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
            }
            restaurantSearchOldUV.selectedAddress = self.selectedAddress
            restaurantSearchOldUV.currentLocation = self.currentLocation
            self.push(uv: restaurantSearchOldUV)
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
  
    @objc func appInBackground(){
    }
    @objc func appInForground(){
        checkLocationEnabled()
    }
    
    func setData(){
        
        prefRenceView2.handleClick { (prefView) in
            let rentitemFilterUV = GeneralFunctions.instantiateViewController(pageName: "RentitemFilterUV") as! RentitemFilterUV
            rentitemFilterUV.selectedData = self.selectedData
            rentitemFilterUV.selectedDataOption = self.selectedOptionData
            rentitemFilterUV.catID = self.catID
            rentitemFilterUV.eType = self.eType
            rentitemFilterUV.rentItemHomeUv = self
            self.push(uv: rentitemFilterUV)
        }
        if(self.selectedLatitude != "" && self.selectedLongitude != ""){
            self.currentLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLongitude))
        
            //self.getRestaurantDetails(location: self.currentLocation, withFilter: false)
            
            self.enterLocLbl.text = self.selectedAddress
        
            GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
            GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
            GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
        }else{
            getLocation = DeviceLocation(uv: self , isContinuous: true)
            getLocation.buildLocManager(locationUpdateDelegate: self)
        }
    }
    
    
    
   
    
    func checkLocationEnabled(){
        if(locationDialog != nil){
            locationDialog.closeView()
            locationDialog = nil
        }
        
        if((GeneralFunctions.hasLocationEnabled() == false && self.currentLocation == nil) || InternetConnection.isConnectedToNetwork() == false)
        {
            
            locationDialog = OpenEnableLocationView(uv: self, containerView: self.cntView, menuImgView: UIImageView())
            locationDialog.currentInst = locationDialog
            locationDialog.setViewHandler(handler: { (latitude, longitude, address, isMenuOpen) in
                //                self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
                //                self.setTripLocation(selectedAddress: address, selectedLocation: CLLocation(latitude: latitude, longitude: longitude))
                
                if(isMenuOpen){
                    self.openMenu()
                }else{
                    self.locationDialog.closeView()
                    self.locationDialog = nil
                    self.onLocationUpdate(location: CLLocation(latitude: latitude, longitude: longitude))
                }
            })
            
            locationDialog.show()
            
            return
        }
    }

    func addBackButtonForSeeAll(){
        
        var backImg = UIImage(named: "ic_nav_bar_back")!
        if(Configurations.isRTLMode()){
            backImg = backImg.rotate(180)
        }
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: backImg, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.close))
        
        if(self.homeTabBar == nil){
            
            if(self.navItem == nil){
               
               self.navigationItem.leftBarButtonItem = leftButton;
            }else{
               self.navItem.leftBarButtonItem = leftButton;
            }
        }else{
            if self.homeTabBar.navItem == nil {
                self.homeTabBar.navItem =  self.navigationItem
            }
            self.homeTabBar.navItem.leftBarButtonItem = leftButton;
        }
        
    }
    
    func addTitleView(){
        let titleView = generalFunc.loadView(nibName: "UFXHomeTitleView", uv: self, isWithOutSize: true)
        titleView.frame = CGRect(x: 0, y:0, width: Application.screenSize.width, height: 50)
        //        titleView.subviews[2].transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        (titleView.subviews[0] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOCATION_FOR_AVAILING_TXT")
        (titleView.subviews[1] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
        (titleView.subviews[2] as! UIImageView).transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        
        GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
        GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
        self.enterLocLbl = (titleView.subviews[1] as! MyLabel)
        if(self.selectedAddress != ""){
            self.enterLocLbl.text = self.selectedAddress
            self.enterLocLbl.textColor = SColors.ThemeTxt
        }
        
        //GeneralFunctions.setImgTintColor(imgView: self.filterImageView, color: SColors.Theme)
        let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
        
        if(self.homeTabBar == nil){
            if(ServiceModule.isDeliverAllOnly()){
                if serviceCategoryArray.count > 1{
                    self.navigationItem.titleView = titleView
                }else{
                    self.navItem.titleView = titleView
                }
            }else{
                self.navigationItem.titleView = titleView
            }
        }else{
            if self.homeTabBar.navItem == nil {
                self.homeTabBar.navItem =  self.navigationItem
            }
            if(ServiceModule.isDeliverAllOnly()){
                if serviceCategoryArray.count > 1{
                    self.homeTabBar.navItem.titleView = titleView
                }else{
                    self.homeTabBar.navItem.titleView = titleView
                }
            }else{
                self.homeTabBar.navItem.titleView = titleView
            }
        }
        
        
        let titleViewTapGue = UITapGestureRecognizer()
        titleViewTapGue.addTarget(self, action: #selector(self.titleViewTapped))
        
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(titleViewTapGue)
        
       // let searchImg = UIImage(named: "ic_search")!
//        let rightButton: UIBarButtonItem = UIBarButtonItem(image: searchImg, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openRestaurantSearchUV))


//        if(self.userProfileJson.get("ONLYDELIVERALL").uppercased() == "YES"){
//            if serviceCategoryArray.count > 1{
//                self.navigationItem.rightBarButtonItem = rightButton
//            }else{
//                self.navItem.rightBarButtonItem = rightButton;
//            }
//        }else{
//            self.navigationItem.rightBarButtonItem = rightButton
//        }

        
//        if(self.userProfileJson.get("ONLYDELIVERALL").uppercased() == "YES"){
//            if serviceCategoryArray.count > 1{
//                self.navigationItem.rightBarButtonItem = rightButton
//            }else{
//                self.navItem.rightBarButtonItem = rightButton;
//            }
//        }else{
//            self.navigationItem.rightBarButtonItem = rightButton
//        }
////=======
//        if(self.homeTabBar == nil){
//            if(self.userProfileJson.get("ONLYDELIVERALL").uppercased() == "YES"){
//                if serviceCategoryArray.count > 1{
//                    self.navigationItem.rightBarButtonItem = rightButton
//                }else{
//                    self.navItem.rightBarButtonItem = rightButton;
//                }
//            }else{
//                self.navigationItem.rightBarButtonItem = rightButton
//            }
//        }else{
//            if(self.userProfileJson.get("ONLYDELIVERALL").uppercased() == "YES"){
//                if serviceCategoryArray.count > 1{
//                    self.homeTabBar.navItem.rightBarButtonItem = rightButton
//                }else{
//                    self.homeTabBar.navItem.rightBarButtonItem = rightButton;
//                }
//            }else{
//                self.homeTabBar.navItem.rightBarButtonItem = rightButton
//            }
//        }

        
        
        let filterTapGue = UITapGestureRecognizer()
        filterTapGue.addTarget(self, action: #selector(self.filterTapped))
        filtersLbl.isUserInteractionEnabled = true
        filtersLbl.addGestureRecognizer(filterTapGue)
        
        let relevanceTapGue = UITapGestureRecognizer()
        relevanceTapGue.addTarget(self, action: #selector(self.relevanceTapped))
        relevanceLbl.isUserInteractionEnabled = true
        relevanceLbl.addGestureRecognizer(relevanceTapGue)
        
        placesLbl.textColor = UIColor.black
        filtersLbl.textColor = SColors.Theme
        relevanceLbl.textColor = SColors.Theme
        placesLbl.font = UIFont(name: Fonts().semibold, size: 16.0)
        filtersLbl.font = UIFont(name: Fonts().semibold, size: 16.0)
        relevanceLbl.font = UIFont(name: Fonts().semibold, size: 16.0)
        filtersLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FILTER").uppercased()
        relevanceLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RELEVANCE").uppercased()
        GeneralFunctions.setImgTintColor(imgView: self.relevanceDownImg, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.filterAplliedCheckImgView, color: SColors.Theme)
        
        self.setRelevanceView()
        
    }
    
    @objc func titleViewTapped(){
        openPlaceFinder()
    }
    
    func setRelevanceView()
    {
        let swipeDownForRelevanceView = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDownForRelevanceView))
        swipeDownForRelevanceView.direction = UISwipeGestureRecognizer.Direction.down
        self.relevanceMainView.addGestureRecognizer(swipeDownForRelevanceView)
        
        self.relevanceCloseLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSE_TXT").uppercased()
        self.relevanceCloseLbl.textColor = SColors.Red
        let relCloseTapGue = UITapGestureRecognizer()
        relCloseTapGue.addTarget(self, action: #selector(self.closeRelevanceView))
        relevanceCloseLbl.isUserInteractionEnabled = true
        relevanceCloseLbl.addGestureRecognizer(relCloseTapGue)
      
        self.relevanceTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SORT_BY").uppercased()
        
        self.releRelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RELEVANCE")
        self.releRelLbl.setClickDelegate(clickDelegate: self)
        
        self.relRatingLbl.text = self.generalFunc.getLanguageLabel(origValue: "Rating", key: "LBL_RATING")
        self.relRatingLbl.setClickDelegate(clickDelegate: self)
        
        self.relTimeLbl.text = self.generalFunc.getLanguageLabel(origValue: "Time", key: "LBL_TIME")
        self.relTimeLbl.setClickDelegate(clickDelegate: self)
        
        if GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  == self.userProfileJson.get("FOOD_APP_SERVICE_ID")
        {
            self.relCostLTHLbl.isHidden = false
            self.relCostHTLLbl.isHidden = false
            self.relCostLTHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COST_LTOH")
            self.relCostLTHLbl.setClickDelegate(clickDelegate: self)
            
            self.relCostHTLLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COST_HTOL")
            self.relCostHTLLbl.setClickDelegate(clickDelegate: self)
        }else
        {
            self.relCostLTHLbl.isHidden = true
            self.relCostHTLLbl.isHidden = true
        }
        
        
        self.relevanceViewItemTextColor = self.releRelLbl.textColor
        self.selctedRelevance = "relevance"
        
    
    }
    
    
    @objc func relevanceTapped()
    {
        
   /*     if self.relevanceLbl.text == self.releRelLbl.text
        {
            self.releRelLbl.textColor = SColors.Theme
            self.relRatingLbl.textColor = self.relevanceViewItemTextColor
            self.relTimeLbl.textColor = self.relevanceViewItemTextColor
            self.relCostLTHLbl.textColor = self.relevanceViewItemTextColor
            self.relCostHTLLbl.textColor = self.relevanceViewItemTextColor
        }else if self.relevanceLbl.text == self.relRatingLbl.text
        {
            self.releRelLbl.textColor = self.relevanceViewItemTextColor
            self.relRatingLbl.textColor = SColors.Theme
            self.relTimeLbl.textColor = self.relevanceViewItemTextColor
            self.relCostLTHLbl.textColor = self.relevanceViewItemTextColor
            self.relCostHTLLbl.textColor = self.relevanceViewItemTextColor
        }else if self.relevanceLbl.text == self.relTimeLbl.text
        {
            self.releRelLbl.textColor = self.relevanceViewItemTextColor
            self.relRatingLbl.textColor = self.relevanceViewItemTextColor
            self.relTimeLbl.textColor = SColors.Theme
            self.relCostLTHLbl.textColor = self.relevanceViewItemTextColor
            self.relCostHTLLbl.textColor = self.relevanceViewItemTextColor
        }else if self.relevanceLbl.text == self.relCostLTHLbl.text
        {
            self.releRelLbl.textColor = self.relevanceViewItemTextColor
            self.relRatingLbl.textColor = self.relevanceViewItemTextColor
            self.relTimeLbl.textColor = self.relevanceViewItemTextColor
            self.relCostLTHLbl.textColor = SColors.Theme
            self.relCostHTLLbl.textColor = self.relevanceViewItemTextColor
        }else if self.relevanceLbl.text == self.relCostHTLLbl.text
        {
            self.releRelLbl.textColor = self.relevanceViewItemTextColor
            self.relRatingLbl.textColor = self.relevanceViewItemTextColor
            self.relTimeLbl.textColor = self.relevanceViewItemTextColor
            self.relCostLTHLbl.textColor = self.relevanceViewItemTextColor
            self.relCostHTLLbl.textColor = SColors.Theme
        }
        view.layoutIfNeeded()
        
        if GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  == self.userProfileJson.get("FOOD_APP_SERVICE_ID")
        {
            self.relevanceStackViewHeight.constant = 200
            self.relevanceMainViewHeight.constant = 280 + GeneralFunctions.getSafeAreaInsets().bottom
        }else
        {
            self.relevanceStackViewHeight.constant = 120
            self.relevanceMainViewHeight.constant = 200 + GeneralFunctions.getSafeAreaInsets().bottom
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.relevanceBKView.isHidden = false
            self.view.layoutIfNeeded()
        })
        */
        var filterTitleArr = [String]()
        filterTitleArr.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RELEVANCE"))
        filterTitleArr.append( self.generalFunc.getLanguageLabel(origValue: "Rating", key: "LBL_RATING"))
        filterTitleArr.append(self.generalFunc.getLanguageLabel(origValue: "Time", key: "LBL_TIME"))
        if GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  == "1"  /*self.userProfileJson.get("FOOD_APP_SERVICE_ID") */  {
            filterTitleArr.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COST_LTOH"))
            filterTitleArr.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COST_HTOL"))
        }
        let openListView = OpenListView(uv: self, containerView: self.cntView)
        openListView.selectedItem = self.selctedRelevance
        openListView.show(isSelectedImageShow: true, listObjects: filterTitleArr, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SORT_BY").uppercased(), currentInst: openListView, .bottom) { (selectedIndex) in
            self.selctedRelevance = filterTitleArr[selectedIndex].lowercased()
            self.refreshTableViewPageContent()
           // self.getRestaurantDetails(location: self.currentLocation, withFilter: self.filterApplied)
        }
    }
    
    @objc func closeRelevanceView()
    {
        
        view.layoutIfNeeded()
        self.relevanceMainViewHeight.constant = 0
        
        UIView.animate(withDuration: 0.4, animations: {
            self.relevanceBKView.isHidden = true
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func swipeDownForRelevanceView()
    {
        closeRelevanceView()
    }
    
    func myLableTapped(sender:MyLabel){
        
       
    }
    
    func addFilterView()
    {
//        // INITIALIZE FILTERVIEW
//        let window = UIApplication.shared.delegate!.window!
//        filterBGView = UIView.init(frame: CGRect(x: 0, y:0 , width: (window?.frame.width)!, height: (window?.frame.height)!))
//        filterBGView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        filterBGView.isHidden = true
//        self.navigationController?.view.addSubview(filterBGView)
//        //filetrView = SDragViewForFilter(dragViewAnimatedTopSpace:Application.screenSize.height / 2, viewDefaultHeightConstant:0, uv:self)
//        self.navigationController?.view.addSubview(filetrView)
//
//        // ADD CLOSE LBL WITH GESTURE ACTION
//        let closeLbl = UILabel.init(frame: CGRect(x: 15, y:20 , width: 100, height: 20))
//        closeLbl.textColor = SColors.Red
//        closeLbl.textAlignment = .left
//        closeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSE_TXT").uppercased()
//        closeLbl.autoresizingMask = [.flexibleBottomMargin]
//        closeLbl.font = UIFont.init(name: Fonts().semibold, size: 16)
//        self.filetrView.addSubview(closeLbl)
//
//        let filterCloseTapGue = UITapGestureRecognizer()
//        filterCloseTapGue.addTarget(self, action: #selector(self.filterTapped))
//        closeLbl.isUserInteractionEnabled = true
//        closeLbl.addGestureRecognizer(filterCloseTapGue)
//
//        // ADD RESET LBL WITH GESTURE ACTION
//        filterResetLbl = UILabel.init(frame: CGRect(x: filetrView.frame.size.width - 115, y:20 , width: 100, height: 20))
//        filterResetLbl.textColor = UIColor.red
//        filterResetLbl.text = self.generalFunc.getLanguageLabel(origValue: "Reset", key: "LBL_RESET").uppercased()
//        filterResetLbl.textAlignment = .right
//        filterResetLbl.autoresizingMask = [.flexibleBottomMargin,.flexibleLeftMargin]
//        filterResetLbl.font = UIFont.init(name: Fonts().regular, size: 16)
//        filterResetLbl.isHidden = true
//        self.filetrView.addSubview(filterResetLbl)
//
//        let filterResetTapGue = UITapGestureRecognizer()
//        filterResetTapGue.addTarget(self, action: #selector(self.resetTapped))
//        filterResetLbl.isUserInteractionEnabled = true
//        filterResetLbl.addGestureRecognizer(filterResetTapGue)
//
//
//        // ADD TABLEVIEW IN FILTERVIEW
//        self.filterTableView = UITableView.init(frame: CGRect(x: 0, y:60 , width: filetrView.frame.size.width, height: filetrView.frame.size.height - (Configurations.isIponeXDevice() ? 130 : 110)))
//        self.filterTableView.register(UINib(nibName: "RestaurantsFilterTVCell", bundle: nil), forCellReuseIdentifier: "RestaurantsFilterTVCell")
//        self.filterTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
//        self.filterTableView.dataSource = self
//        self.filterTableView.delegate = self
//        self.filterTableView.bounces = true
//        self.filterTableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        self.filterTableView.tableFooterView = UIView()
//        if #available(iOS 15.0, *) {
//            self.filterTableView.sectionHeaderTopPadding = 0
//        } else {}
//        self.filetrView.addSubview(self.filterTableView)
//
//        // ADD APPLY LBL WITH GESTURE ACTION
//        applyLbl = UILabel.init(frame: CGRect(x: 0, y:self.filterTableView.frame.origin.y + self.filterTableView.frame.size.height, width: filetrView.frame.size.width, height: Configurations.isIponeXDevice() ? 70 : 50))
//        applyLbl.textColor = UIColor.white
//        applyLbl.backgroundColor = UIColor(hex: 0xdddddd)
//        applyLbl.textAlignment = .center
//        applyLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY_FILTER").uppercased()
//        applyLbl.autoresizingMask = [.flexibleWidth,.flexibleHeight,.flexibleTopMargin]
//        applyLbl.font = UIFont.init(name: Fonts().semibold, size: 17)
//        self.filetrView.addSubview(applyLbl)
//
//        let applyFilterTapGue = UITapGestureRecognizer()
//        applyFilterTapGue.addTarget(self, action: #selector(self.applyFilterTapped))
//        applyLbl.addGestureRecognizer(applyFilterTapGue)
        
    }
    
    //* Filter Tap Action Methods
    @objc func filterTapped(){
        
        self.setFilterCheckedArrayForSection0 = self.tempSetFilterCheckedArrayForSection0
        self.setFilterCheckedArrayForSection1 = self.tempSetFilterCheckedArrayForSection1
        
        self.filterTableView.reloadData()
        if self.filterApplied == true{
            self.filterResetLbl.isHidden = false
        }else{
            
            self.setFilterCheckedArrayForSection0.removeAll()
            self.setFilterCheckedArrayForSection1.removeAll()
            
            self.setFilterCheckedArrayForSection0.append(false)
            /* FAV STORES CHANGES*/
            if(self.userProfileJson.get("ENABLE_FAVORITE_STORE_MODULE").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
                self.setFilterCheckedArrayForSection0.append(false)
            }
           
        }
        
        self.performSelctionProcessAction()
        
        self.perfomFilterAction()
    }
    
    func perfomFilterAction()
    {
        self.filetrView.perfomViewOpenORCloseAction()
        if self.filetrView.bgViewIsHidden == true
        {
            self.filterBGView.isHidden = true
        }else{
            
            self.filterTableView.reloadData()
            self.filterBGView.isHidden = false
        }
    }
    
    func filterViewSwipePerformed()
    {
        if self.filetrView.bgViewIsHidden == true
        {
            self.filterBGView.isHidden = true
        }else{
            
            self.filterBGView.isHidden = false
        }
    }
    //*
    
    @objc func applyFilterTapped()
    {
        self.tempSetFilterCheckedArrayForSection0 = self.setFilterCheckedArrayForSection0
        self.tempSetFilterCheckedArrayForSection1 = self.setFilterCheckedArrayForSection1
        
        self.refreshTableViewPageContent()
        self.filterAplliedCheckImgView.isHidden = false
        self.filterApplied = true
        self.perfomFilterAction()
        //self.getRestaurantDetails(location: self.currentLocation, withFilter: true)
        
    }
    
    
    
    
    //* Filter Tabelview Selction Process
    func performSelctionProcessAction()
    {
        var reset = true
        for i in 0..<self.setFilterCheckedArrayForSection0.count
        {
            if self.setFilterCheckedArrayForSection0[i] == true
            {
                reset = false
            }
        }
        for i in 0..<self.setFilterCheckedArrayForSection1.count
        {
            if self.setFilterCheckedArrayForSection1[i] == true
            {
                reset = false
            }
        }
        
        if reset == false{
            
            UIView.animate(withDuration: 0.4, animations: {
                self.applyLbl.isUserInteractionEnabled = true
                self.applyLbl.backgroundColor = SColors.Theme
                self.applyLbl.textColor = UIColor.white
            }, completion:{ _ in})
            
        }else
        {
            UIView.animate(withDuration: 0.4, animations: {
                self.applyLbl.isUserInteractionEnabled = false
                self.applyLbl.backgroundColor = UIColor(hex: 0xdddddd)
                self.applyLbl.textColor = UIColor.white
            }, completion:{ _ in})
        }
    }
    
    //* Tableview Methods for Main Restaurants List View & FilterView
    func numberOfSections(in tableView: UITableView) -> Int {
        
       
        if rentData.count == 0  {
          return 1
        }else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if tableView == self.filterTableView
        {
            
           // if section == 0
          //  {
                return self.generalFunc.getLanguageLabel(origValue: "SHOW RESTAURANTS WITH", key: "LBL_SHOW_RESTAURANTS_WITH")
          //  }else{
           //     return self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUISINES")
          //  }
        }
        else
        {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         if(tableView == self.resCategoryTableView){
            
            
            let categoryHview = CategoryHeaderViewRent(frame: CGRect(x:0, y: 0, width: Application.screenSize.width, height: 55))
             if eType == "RentEstate"{
                 categoryHview.headerlbl.text = self.generalFunc.getLanguageLabel(origValue: "All Properties", key: "LBL_RENT_ALL_REALESTATE_TXT")
             }else if eType == "RentCars" {
                 categoryHview.headerlbl.text = self.generalFunc.getLanguageLabel(origValue: "All Cars", key: "LBL_RENT_ALL_CARS_TXT")
             }else if eType == "RentItem" {
                 categoryHview.headerlbl.text = self.generalFunc.getLanguageLabel(origValue: "All Items", key: "LBL_RENT_ALL_GENERALITEMS_TXT")
             }
             //"Find A item"
             categoryHview.headerlbl.fontFamilyWeight = "Bold"
             categoryHview.headerlbl.setFontFamily()
             categoryHview.buySellView.isHidden = false
             categoryHview.buySellView.borderColor = UIColor(hex: 0x8FA1B4)
             categoryHview.buySellView.borderWidth = 1
          
             categoryHview.anchoeView.isHidden = true
             categoryHview.anchorSubView.isHidden = true
             categoryHview.sellLbl.text = self.generalFunc.getLanguageLabel(origValue: "Rent", key: "LBL_RENT_TXT")
             categoryHview.buylbl.text = self.generalFunc.getLanguageLabel(origValue: "Buy", key: "LBL_BUY_TXT")
             if  self.isBuySell == "Yes"{
                 categoryHview.buyView.backgroundColor = UIColor(hex: 0x1B2A3B)
                 categoryHview.buylbl.textColor = SColors.ThemeTxt
                 categoryHview.sellView.backgroundColor = SColors.ThemeTxt
                 categoryHview.sellLbl.textColor = UIColor(hex: 0x1B2A3B)
             }else{
                 categoryHview.buyView.backgroundColor = SColors.ThemeTxt
                 categoryHview.buylbl.textColor = UIColor(hex: 0x1B2A3B)
                 categoryHview.sellView.backgroundColor = UIColor(hex: 0x1B2A3B)
                 categoryHview.sellLbl.textColor = SColors.ThemeTxt
             }
             
             categoryHview.buyView.handleClick { instance in
                 if self.isBuySell != "Yes" {
                     self.isBuySell = "Yes"
                     self.isFromCategory = true
                     //self.rentData.removeAll()
                     self.resCategoryTableView.reloadData()
                     self.getPost()
                 }
             }
             categoryHview.sellView.handleClick { instance in
                 if self.isBuySell != "No" {
                     self.isBuySell = "No"
                    
                     self.isFromCategory = true
                     //self.rentData.removeAll()
                     self.resCategoryTableView.reloadData()
                     self.getPost()
                 }
             }
            return categoryHview
            
        }else{
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if rentData.count == 0  {
          return 0
        }else {
            return 1
        }
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == self.resCategoryTableView) {
            if rentData.count == 0 {
                return UITableViewCell()
            }else{
                let cell = self.resCategoryTableView.dequeueReusableCell(withIdentifier: "RentCategoryListTVCell") as! RentCategoryListTVCell
                
                cell.advertiseView.isHidden = true
                cell.isBuySell = self.isBuySell
                cell.currentLocation = self.currentLocation
                cell.uv = self as UIViewController
                cell.dataArray = self.rentData
                cell.eType = self.eType
                cell.collectionFlowLayout.scrollDirection = .vertical
                cell.collectionView.reloadData()
                
                
                
                
                return cell
            }
    }else {
        return UITableViewCell()

    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.filterTableView
        {
            
            if indexPath.section == 0
            {
                if self.setFilterCheckedArrayForSection0[indexPath.row] == true
                {
                    self.setFilterCheckedArrayForSection0[indexPath.row] = false
                }else{
                    
                    self.setFilterCheckedArrayForSection0[indexPath.row] = true
                }
                
            }else
            {
                if self.setFilterCheckedArrayForSection1[indexPath.row] == true
                {
                    self.setFilterCheckedArrayForSection1[indexPath.row] = false
                }else{
                    
                    self.setFilterCheckedArrayForSection1[indexPath.row] = true
                }
                
            }
            self.performSelctionProcessAction()
            self.filterTableView.reloadRows(at: [indexPath], with: .automatic)
            
        }else{
            
            
            let item = self.restaurantsList[indexPath.row]
            let restDetailView = GeneralFunctions.instantiateViewController(pageName: "RestaurantDetailsUV") as! RestaurantDetailsUV
            if self.currentLocation == nil
            {
                self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
            }
            restDetailView.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
            restDetailView.currentLocation = self.currentLocation
            restDetailView.restaurantName =  item.get("vCompany")
            restDetailView.companyId = item.get("iCompanyId")
            restDetailView.restaurantcoverImagePath = item.get("vCoverImage")
            restDetailView.restaurantAddress = item.get("vCaddress")
            restDetailView.favSelected = item.get("eFavStore").uppercased() == "YES" ? true : false
            restDetailView.restaurantRating = item.get("vAvgRating")
            restDetailView.restaurantCuisine = item.get("Restaurant_Cuisine")
            restDetailView.safetyEnable = item.get("Restaurant_Safety_Status")
            restDetailView.safetyEnaImgURL = item.get("Restaurant_Safety_Icon")
            restDetailView.safetyDetailURL = item.get("Restaurant_Safety_URL")
           
            
            self.push(uv: restDetailView)
            //self.present(navController, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
            return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView == self.resCategoryTableView){
            if isFromCategory {
                return  0
            }else{
                var hight = 232
                if self.isBuySell == "YES"{
                    hight = 215
                }
                let dataList = self.rentData//self.categoryWiseListArray[indexPath.section].arrOf("subData") as! [NSDictionary]
                
                if dataList.count > 2 {
                    if dataList.count % 2 == 0 {
                        return CGFloat(hight * (dataList.count / 2))
                    } else {
                        return CGFloat(hight * ((dataList.count / 2) + 1))
                    }
                    
                }
                return  CGFloat(hight)
                
            }
        }
        
        if tableView == self.filterTableView
        {
            return 45
        }else{
           
            return 135
           

        }
    }
    

    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(self.restaurantsList.count > 0){
            let cellRect = tableView.rectForRow(at: IndexPath(row: self.restaurantsList.count - 1, section: 0))
            let completelyVisible = tableView.bounds.contains(cellRect)

            if(completelyVisible && bottomDataLoading == false && self.isNextPageAvail == true){
                self.bottomDataLoading = true
                self.lastScrollPosition = self.tableView.contentOffset
                self.addFooterView()
                self.isLoadingMore=true
               // self.getRestaurantDetails(location: self.currentLocation, withFilter: self.filterApplied)
            }
        }

    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if (tableView == self.resCategoryTableView){
            return
        }
        
        if tableView == self.filterTableView
        {
            
        }else{
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! RestaurantsListCell
            
            UIView.animate(withDuration: 0.1, animations: {
                cell.containerView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }, completion:{ _ in
                
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        if (tableView == self.resCategoryTableView){
            return
        }
        
        
        if tableView == self.filterTableView
        {}else{
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? RestaurantsListCell {
                UIView.animate(withDuration: 0.1, animations: {
                    cell.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion:{ _ in
                })
            }
        }
    }
    
    

    func setHeaderView(){
        

        //self.resCategoryTableView.tableHeaderView = nil
        self.resCategoryTableView.reloadData()
        self.resCategoryTableView.separatorStyle = .none
        self.tableView.parallaxHeader.view = nil
        self.resCategoryTableView.parallaxHeader.view = nil
        self.imgSlideShow.isHidden = false
        self.imgSlideShow.bounces = false
        
        
        //if(self.bannersItemList.count > 0 && self.isEnableCategoryWiseListing == true){
        if (self.bannersItemList.count == 0) {
            self.imgSlideShowHeight.constant = 0
            self.imgSlideShow.isHidden = true
        }else {
            self.imgSlideShowHeight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "", 2.33)
            self.imgSlideShow.isHidden = false
        }
//        self.imgSlideShowHeight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "", 2.33)
            self.headerHight.constant = 0
            self.searchHeaderView.isHidden = true
            self.searchHeaderView2.isHidden = false
            self.imgSlideShow.backgroundColor = UIColor.clear
            self.bannerBackView.backgroundColor = SColors.ThemeTxt
           
            self.parallexHeaderViewHeight = self.imgSlideShowHeight.constant + (self.isEnableCategoryWiseListing == true ? 190 : 245)
            

                (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).parallaxHeader.view = self.containerView
            if catList.count == 0 {
                (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).parallaxHeader.height = self.parallexHeaderViewHeight - 175
                self.cusinesView.isHidden = true
                self.cuisinesCollectionView.isHidden = true
            }else{
                (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).parallaxHeader.height = self.parallexHeaderViewHeight + 55
                self.cusinesView.isHidden = false
                self.cuisinesCollectionView.isHidden = false
            }
                
                (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).parallaxHeader.mode = .bottom
                self.isEnableCategoryWiseListing == true ? (self.tableView.parallaxHeader.minimumHeight = self.parallexHeaderViewHeight - self.imgSlideShowHeight.constant - 120) : (self.tableView.parallaxHeader.minimumHeight = self.parallexHeaderViewHeight - self.imgSlideShowHeight.constant - 155)
        
        
            self.imgSlideShow.type = .linear
            self.imgSlideShow.scrollSpeed = 0.8
            self.imgSlideShow.decelerationRate = 0.8
            self.imgSlideShow.delegate = self
            self.imgSlideShow.dataSource = self
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderImgTapped))
            self.imgSlideShow.addGestureRecognizer(recognizer)
            
            self.refreshControl = OffsetableRefreshControl(offset: -self.parallexHeaderViewHeight)
            
            self.refreshControl.addTarget(self, action:
                #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            self.refreshControl.tintColor = SColors.ThemeTxt
            
            var frame = (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).bounds
            frame.origin.y = -frame.size.height
            if(self.isEnableCategoryWiseListing == true){
                if(resCatTableBGView == nil){
                    
                    if #available(iOS 10.0, *) {
                        (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).refreshControl = self.refreshControl
                    } else {
                        (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).addSubview(self.refreshControl)
                    }
                    
                    resCatTableBGView = UIView(frame: frame)
                    resCatTableBGView.autoresizingMask = .flexibleWidth
                    resCatTableBGView.backgroundColor = SColors.Theme
                    self.resCategoryTableView.insertSubview(resCatTableBGView, at: 0)
                }
            }else{
                if(tableViewBGView == nil){
                    
                    if #available(iOS 10.0, *) {
                        (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).refreshControl = self.refreshControl
                    } else {
                        (self.isEnableCategoryWiseListing == true ? self.resCategoryTableView : self.tableView).addSubview(self.refreshControl)
                    }
                    
                    tableViewBGView = UIView(frame: frame)
                    tableViewBGView.autoresizingMask = .flexibleWidth
                    tableViewBGView.backgroundColor = SColors.Theme
                    self.tableView.insertSubview(tableViewBGView, at: 0)
                }
            }
            
            self.imgSlideShow.reloadData()
            if(self.imgSlideShow.currentItemIndex == 0 && self.bannersItemList.count > 1){
                self.imgSlideShow.contentOffset = CGSize(width: 0, height: 0)
            }
        self.pageController.setPage(self.imgSlideShow.currentItemIndex)
       
        self.pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.bannersItemList.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor:
                                                                SColors.Theme, dotsColor: UIColor.white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        
        pageController.backgroundColor = UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.7)
        //SColors.btBg.withAlphaComponent(0.7)//UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 1.0)
       // pageController.opacity = 0.8//SColors.Theme
        pageController.layer.cornerRadius = 8
        pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        self.pageController.isHidden = true
        advancPageControllerWidhth.constant = CGFloat((self.bannersItemList.count * 10) + 45)
        if advancPageControllerWidhth.constant > Application.screenSize.width {
            advancPageControllerWidhth.constant = Application.screenSize.width - 40
        }
        self.pageController.tintColor = SColors.Theme
        }
    

    
    
    
    func addFooterView(){
        let loaderView =  self.generalFunc.addMDloader(contentView: self.tableView, isAddToParent: false)
        loaderView.backgroundColor = UIColor(hex: 0xf1f1f1)
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.tableView.tableFooterView  = loaderView
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
        
    }
    
    

    
    @objc func bottomDataLoad(){
       self.bottomDataLoading = false
    }
    
    
    
    
    @objc func sliderImgTapped(){
        
    }
    
    func openPlaceFinder(){
        
        let launchPlaceFinder = LaunchPlaceFinder(viewControllerUV: self)
        launchPlaceFinder.isFromDeliverAll = true
        launchPlaceFinder.currInst = launchPlaceFinder
        
        if(currentLocation != nil){
            launchPlaceFinder.setBiasLocation(sourceLocationPlaceLatitude: currentLocation.coordinate.latitude, sourceLocationPlaceLongitude: currentLocation.coordinate.longitude)
        }
        
        launchPlaceFinder.initializeFinder { (address, latitude, longitude) in
            
            if(self.currentLocation != nil){
                self.selectedLatitude = "\(latitude)"
                self.selectedLongitude = "\(longitude)"
                self.selectedAddress = address
                self.enterLocLbl.text = address
                self.currentLocation = CLLocation(latitude: Double(self.selectedLatitude)!, longitude: Double(self.selectedLongitude)!)
                
                GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
                GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
                GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
                
                self.refreshTableViewPageContent()
                //self.getRestaurantDetails(location: self.currentLocation, withFilter: false)
                //self.getCusineList()
                
            }else{
                self.onLocationUpdate(location: CLLocation(latitude: latitude, longitude: longitude))
            }
        }
    }
    
    func onLocationUpdate(location: CLLocation) {
        
        if isFirstLoc == true
        {
            isFirstLoc = false
            
            self.currentLocation = location
            
            self.refreshTableViewPageContent()
            getLocation.releaseLocationTask()
            //self.getRestaurantDetails(location: self.currentLocation, withFilter: false)
            checkLocationEnabled()
            if(getAddressFrmLocation == nil){
                getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
                getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
                getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow:false)
            }
        }
    }
    
    func onAddressFound(address: String, location: CLLocation, isPickUpMode: Bool, dataResult: String) {
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
        self.selectedAddress = address
        self.enterLocLbl.text = address
        
        
        GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
    }
    
    func refreshTableViewPageContent()
    {
        
        self.isNextPageAvail = false
        self.nextPage_str = 1
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if scrollView.contentOffset.y <= -(parallexHeaderViewHeight + 60.0) && self.isFirstLoc == false
//        {
//            self.refreshLoader.alpha = 1
//            self.refreshLoader.isHidden = false
//            self.refreshLoader.startAnimating()
//            if self.dataLoading == false{
//                self.dataLoading = true
//
//                self.refreshTableViewPageContent()
//                self.tableView.contentInset = UIEdgeInsets(top: self.parallexHeaderViewHeight + 60.0, left: 0, bottom: 0, right: 0)
//
//                Utils.delayWithSeconds(0.5, completion: {
//                    self.getRestaurantDetails(location: self.currentLocation, withFilter: self.filterApplied)
//                })
//
//            }
//        }else{
//            self.refreshLoader.alpha = 0
//        }
    }
    
    @IBAction func unwindToDelAllUFXHomeScreen(_ segue:UIStoryboardSegue) {
        //        unwindToSignUp
        
        //if(segue.source.isKind(of: SignInUV.self)){
        
        //            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        //            self.setupRatingView()
        //}
        
        if(segue.source.isKind(of: FoodRatingUV.self))
        {
            
            self.ratingBottomViewHeight.constant = 0
            
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        }
        
    }
    
    func textToImage(drawText: NSString, inImage: UIImage, atYPoint:NSInteger, color:UIColor)->UIImage{
        
        // Setup the font specific variables
        
        let textFont: UIFont = UIFont.init(name: Fonts().regular, size: 12)!
        
        let label = UILabel.init(frame: CGRect(x:0, y: 0, width: 20, height: 20))
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.font = textFont
        label.textAlignment = .center
        label.text = drawText as String
        
        let img1 = inImage
        //create image 2
        let img2 = UIImage.init(named: "ic_fillCartBG")!
        
        // create label
        
        // use UIGraphicsBeginImageContext() to draw them on top of each other
        //start drawing
        UIGraphicsBeginImageContext(img1.size)
        //draw image1
        img1.draw(in: CGRect(x: 0, y: 0, width: (img1.size.width), height: (img1.size.height)))
        //draw image2
        img2.draw(in: CGRect(x: 11, y: 0, width: 22, height: 22))
        //draw label
        label.drawText(in: CGRect(x: 12, y: 0, width: label.frame.size.width, height: label.frame.size.height))
        //get the final image
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return resultImage!
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
            DispatchQueue.main.async {
                self.whoDetailView.activityIndicator.startAnimating()
            }
           
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.whoDetailView.activityIndicator.stopAnimating()
        }
    }
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        if self.bannersItemList.count == 0 {
            return 1
        }else{
            return self.bannersItemList.count
        }
        
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        var imgView:UIImageView!

        if (view == nil){
            
           // let height = Utils.getHeightOfBanner(widthOffset: 50, ratio: "16:9")
            let height = Utils.getHeightOfBanner(widthOffset: 60, ratio: "", 2.33)
            let heightValue = Utils.getValueInPixel(value: height)
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: Int(carousel.frame.size.width) - 60, height: Int(height)))
            imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
            
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width - 60 )
            if self.bannersItemList.count == 0 {
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: "", width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                
            }else{
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            }
//            imgView.contentMode = .scaleAspectFit
//            imgView.layer.cornerRadius = 10
//            imgView.clipsToBounds = true
            imgView.masksToBounds = true
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFit
            
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
            imgView.cornerRadius = 16
            
        }else{
            imgView = view as? UIImageView
            imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
            
            let height = Utils.getHeightOfBanner(widthOffset: 60, ratio: "",2.33)
            let heightValue = Utils.getValueInPixel(value: height)
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width - 60)
            if self.bannersItemList.count == 0 {
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: "", width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                
            }else{
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            }
            
//            imgView.contentMode = .scaleAspectFit
//            imgView.layer.cornerRadius = 0
//            imgView.clipsToBounds = true
            imgView.masksToBounds = true
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFit
            
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
            imgView.cornerRadius = 16
            
        }
        
        return imgView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
            if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                self.imgSlideShow.contentOffset = CGSize(width: 10, height: 0)
            }else{
                self.imgSlideShow.contentOffset = CGSize(width: -10, height: 0)
            }

        }else{
            self.imgSlideShow.contentOffset = CGSize(width: 0, height: 0)
        }
       
  
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if(option == .spacing){
            if UIDevice.current.userInterfaceIdiom == .pad {
                return value * 1.02
            }else{
                return value * 1.04
            }
        }
        return value
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentCuisinesCVC", for: indexPath) as! RentCuisinesCVC
        
        cell.layer.cornerRadius = 8.0
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        
        cell.cntView.backgroundColor = UIColor.white
        cell.titleLbl.textColor = UIColor.black
        
        
        cell.imgViewHight.constant = 46
        cell.imgViewWidth.constant = 46
      
        cell.titleLbl.text = self.catList[indexPath.item].get("vTitle")
        
        var font = UIFont(name: Fonts().bold, size: 12)!
        cell.titleLbl.font = font
        cell.titleLbl.fontFamilyWeight = "Bold"
        cell.titleLbl.setFontFamily()
        cell.selectedView.isHidden = !(selectedCuisineIndex == indexPath.item)
        cell.selectedView.backgroundColor = SColors.Theme
        
        if(selectedCuisineIndex == indexPath.item){
            
        cell.cntView.layer.borderWidth = 1
        cell.cntView.layer.borderColor =  SColors.Theme.cgColor
        cell.titleLbl.textColor = SColors.ThemeTxt
        cell.cntView.backgroundColor =  SColors.Theme
        let cusineImg = self.catList[indexPath.item].get("vImage1")
        cell.iconBGView.backgroundColor = UIColor.clear
            let valueInPixels = Utils.getValueInPixel(value: 46)
            cell.iconImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: cusineImg, width: valueInPixels, height: valueInPixels, MAX_HEIGHT: valueInPixels)), placeholderImage:nil)
          
        }else{
            //cell.cntView.borderColor = UIColor.clear
            cell.cntView.layer.borderWidth = 00
            cell.cntView.layer.borderColor =  UIColor.clear.cgColor
            cell.titleLbl.textColor = SColors.blackColor
            cell.cntView.backgroundColor = UIColor.white
            let cusineImg = self.catList[indexPath.item].get("vImage")
            cell.iconBGView.backgroundColor = UIColor.clear
            let valueInPixels = Utils.getValueInPixel(value: 46)
            cell.iconImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: cusineImg, width: valueInPixels, height: valueInPixels, MAX_HEIGHT: valueInPixels)), placeholderImage:nil)
           
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndex = self.selectedCuisineIndex
        self.selectedCuisineIndex = indexPath.item
        Utils.isOwnerPostSendInquiry = ""
        
        if(previousIndex == self.selectedCuisineIndex){
//            self.selectedCuisineIndex = 0
//            collectionView.reloadData()
            return
        }
        
        
        var loadIndexPath:[IndexPath] = [IndexPath]()
        loadIndexPath.append(indexPath)
        if(previousIndex != -1){
            loadIndexPath.append(IndexPath(item: previousIndex, section: 0))
        }
        collectionView.reloadItems(at: loadIndexPath)
        selectedCuisineId = ""
        catID = self.catList[indexPath.item].get("iCategoryId")
        isFromSearch = false
        isFromCategory = true
        self.rentData.removeAll()
        self.resCategoryTableView.reloadData()
        self.getPost()
        //self.getRestaurantDetails(location: self.currentLocation, withFilter: false , true)
    }
    
    func addTable22SubViews(){
        
        if(self.shadowImageView != nil){
            self.shadowImageView.removeFromSuperview()
            self.shadowImageView = nil
        }
       
//        self.shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: imgSlideShowHeight.constant - 50, width: Application.screenSize.width, height: 50))
//        shadowImageView.image = UIImage(named: "ic_shadow_3")
      
       // self.imgSlideShow.addSubview(shadowImageView)
        pageController.backgroundColor =  UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.5)
        //SColors.btBg.withAlphaComponent(0.7)//UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 1.0)
        //pageController.opacity = 0.8//SColors.Theme
        pageController.layer.cornerRadius = 8
        pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        self.pageController.isHidden = true
        advancPageControllerWidhth.constant = CGFloat((self.bannersItemList.count * 15) + 15)
        if advancPageControllerWidhth.constant > Application.screenSize.width {
            advancPageControllerWidhth.constant = Application.screenSize.width - 40
        }
        self.pageController.numberOfPages = self.bannersItemList.count
        
       }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        
        self.googleAdLoad = true
        if GeneralFunctions.getSafeAreaInsets().bottom != 0 {
        bannerView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - (64 + GeneralFunctions.getSafeAreaInsets().bottom) - 50, width: Application.screenSize.width, height: 50)
        }else{
            bannerView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - 64 - 50, width: Application.screenSize.width, height: 50)
        }
        
        self.cntView.addSubview(bannerView)

    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
      print("bannerViewDidReceiveAd")
    }
   
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        
       
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    // fb add
    
    func adView(_ adView: FBAdView, didFailWithError error: Error) {
        
        
      print("Ad failed to load with error: \(error.localizedDescription)")
    }

    func adViewDidLoad(_ adView: FBAdView) {
      print("Ad was loaded and ready to be displayed")
      showAd()
    }

    private func showAd() {
      guard let adView = adView, adView.isAdValid else {
        return
      }
        self.fbAdLoad = true
        if !googleAdLoad{
            if GeneralFunctions.getSafeAreaInsets().bottom != 0 {
                adView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - (64 + GeneralFunctions.getSafeAreaInsets().bottom) - 50, width: Application.screenSize.width, height: 50)
            }else{
                adView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - 64 - 50, width: Application.screenSize.width, height: 50)
            }
        }else{
            if GeneralFunctions.getSafeAreaInsets().bottom != 0 {
                adView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - (64 + GeneralFunctions.getSafeAreaInsets().bottom) - 100, width: Application.screenSize.width, height: 50)
            }else{
                adView.frame = CGRect(x: 0, y: self.cntView.frame.size.height - 64 - 100, width: Application.screenSize.width, height: 50)
            }
        }
       
        self.cntView.addSubview(adView)
    }
    func getPost()  {
        
        self.lblNodata.isHidden = true
        if !isFromSearch {
            self.setLoader(ishidden: false)
            //self.resCategoryTableView.isHidden = true
        }
        
        let parameters = ["type":"GetRentPostForAllUser", "iMemberId":GeneralFunctions.getMemberd(), "iCategoryId" : catID,"search_keyword" : searchKeyWord,"passengerLat": self.selectedLatitude , "passengerLon": self.selectedLongitude,"eType" : self.eType ,"iSubCategoryIds" : self.subFiltertID , "iSelectedOptionIds" : self.subFiltertOptionID, "isBuySell" : isBuySell]
    
    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
    exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
    exeWebServerUrl.currInstance = exeWebServerUrl
    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
        self.searchBar.isLoading = false
        self.isFromCategory = false
        if !self.isFromSearch {self.setLoader(ishidden: true)}
        if(response != ""){
            let dataDict = response.toDict()
            self.rentData.removeAll()
            if(dataDict.get("Action") == "1"){
                self.resCategoryTableView.isHidden = false
                if  !self.isLoadFristTime {
                self.catList = dataDict.dictOf(Utils.message_str).arrOf("CategoriesData") as! [NSDictionary]
                self.cuisinesCollectionView.reloadData()
                }
                self.tableView.isHidden = false
                self.rentData = dataDict.dictOf(Utils.message_str).arrOf("RentItemData") as! [NSDictionary]
                if  self.rentData.count == 0 {
                    self.lblNodata.isHidden = false
                    self.lblNodata.text = self.generalFunc.getLanguageLabel(origValue: dataDict.dictOf(Utils.message_str).get("message1"), key: dataDict.dictOf(Utils.message_str).get("message1"))
                    //self.resCategoryTableView.isScrollEnabled = false
                }else{
                    
                    self.lblNodata.isHidden = true
                   
                }
                self.addTable22SubViews()
                self.cuisinesLbl.text = dataDict.dictOf(Utils.message_str).get("MainCatTitle")
                if(Configurations.isRTLMode()){
                    self.cuisinesLbl.textAlignment = .right
                }
                self.bannersItemList.removeAll()
                let msgArr = dataDict.arrOf("BANNER_DATA")
                for i in 0..<msgArr.count{
                    let tempItem = msgArr[i] as! NSDictionary
                    self.bannersItemList.append(tempItem.get("vImage"))
                }
                
                
                self.contentView.isHidden = false
                if self.isLoadFristTimeStr == "Yes" {
                self.isLoadFristTime = true
                }
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.alpha = 1
                    self.setHeaderView()
                    self.imgSlideShow.contentOffset = CGSize(width: -10, height: 0)
                    self.imgSlideShow.reloadData()
                    
                }, completion:{ _ in
                })
                self.resCategoryTableView.reloadData()
            }else{
            }
            
        }else{
            self.generalFunc.setError(uv: self)
            
            
        }
    })
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            //loaderView =  self.generalFunc.addMDloader(contentView: self.view, Application.screenSize.height - 200)
            loaderView.backgroundColor = UIColor.clear
            self.view.isUserInteractionEnabled = !ishidden
        }else if(loaderView != nil){
            if isFromCategory{
                loaderView.frame.origin.y = Application.screenSize.height - 200
            }else{
                loaderView.frame.origin.y = Application.screenSize.height / 2
            }
            loaderView.isHidden = ishidden
            self.view.isUserInteractionEnabled = ishidden
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.isFromSearch = true
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)

        if trimmedString.count >= 3
        {
            searchBar.isLoading = true
            searchKeyWord = trimmedString
            self.getPost()
        }else
        {
            searchBar.isLoading = false
            if searchText == ""{
                searchKeyWord = searchText
                self.getPost()
               
                self.view.endEditing(true)
                self.searchBar.endEditing(true)
                searchBar.resignFirstResponder()
            }
            
            
            //self.tableView.isHidden = true
        }
    }
    func dismissKeyboard()
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dismissKeyboard()
        
    }
    @objc func keyboardWillDisappear(sender: NSNotification){
        self.resCategoryTableView.isScrollEnabled = true
        
    }
    @objc func keyboardWillAppear(sender: NSNotification){
        self.resCategoryTableView.isScrollEnabled = false
    }
    func getSubFilter(id : String ,optID : String, selectedDataTemp : [String],selectedOptDataTemp : [String])  {
        self.subFiltertID = id
        self.subFiltertOptionID = optID
        self.selectedData = selectedDataTemp
        self.selectedOptionData = selectedOptDataTemp
        self.isFromCategory = true
        self.getPost()
    }
    
}



