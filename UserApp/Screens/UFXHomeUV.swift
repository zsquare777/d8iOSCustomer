

import UIKit
import SysBaseLib
import CoreLocation
import GoogleMobileAds
import FBAudienceNetwork
import AdSupport
import AdvancedPageControl


class UFXHomeUV: ParentViewUV, OnLocationUpdateDelegate, AddressFoundDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, MyLabelClickDelegate, iCarouselDataSource, iCarouselDelegate, MXParallaxHeaderDelegate, ParentViewUVDelegate,GADBannerViewDelegate,FBAdViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var rduView: UIView!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var imgSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var selectServiceLbl: MyLabel!
    
    @IBOutlet weak var selectSerivcesSubLbl: MyLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    //    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var noServiceAvailLbl: MyLabel!
    @IBOutlet weak var ufxDataVerticalStackView: UIStackView!
    @IBOutlet weak var ufxDataVerticalStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var allIn1MedicalCollectionView: UICollectionView!
    @IBOutlet weak var rduTopBarHeaderView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileLbl: MyLabel!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var walletImgView: UIImageView!
    @IBOutlet weak var walletLbl: MyLabel!
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var historyImgView: UIImageView!
    @IBOutlet weak var historyLbl: MyLabel!
    @IBOutlet weak var activeJobView: UIView!
    @IBOutlet weak var activeJobImgView: UIImageView!
    @IBOutlet weak var activeJobLbl: MyLabel!
    
    @IBOutlet weak var rduScrollView: UIScrollView!
    @IBOutlet weak var rduContentView: UIView!
    @IBOutlet weak var rduCollectionView: UICollectionView!
    @IBOutlet weak var rduTableView: UITableView!
    @IBOutlet weak var rduCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rduContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rduSeperatorView: UIView!
    @IBOutlet weak var nextBtn: MyButton!
    @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var nextBtnBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var scrollViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var imageSlideShowBGView: UIView!
    @IBOutlet weak var imgSlideShowBGViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topHeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var rduTableViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var pageControllerWidth: NSLayoutConstraint!
    @IBOutlet weak var parentPHView1: UIView!
    @IBOutlet weak var parentPHView2: UIView!
    @IBOutlet weak var parentPHView3: UIView!
    @IBOutlet weak var parentPHView4: UIView!
    @IBOutlet weak var parentPHView5: UIView!
    @IBOutlet weak var parentPHView6: UIView!
    @IBOutlet weak var parentPHView7: UIView!
    @IBOutlet weak var parentPHView8: UIView!
    @IBOutlet weak var parentPHView9: UIView!
    @IBOutlet weak var parentPHView10: UIView!
    @IBOutlet weak var parentPHView11: UIView!
    @IBOutlet weak var parentPHView12: UIView!
    @IBOutlet weak var parentPHView13: UIView!
    @IBOutlet weak var parentPHView16: UIView!
    @IBOutlet weak var parentPHView17: UIView!
    @IBOutlet weak var parentPHView18: UIView!
    @IBOutlet weak var parentPHView19: UIView!
    @IBOutlet weak var parentPHView14: UIView!
    @IBOutlet weak var parentPHView15: UIView!
    @IBOutlet weak var parentPHView20: UIView!
    @IBOutlet weak var parentPHView21: UIView!
    
    @IBOutlet weak var parentNewPHView: UIView!
    @IBOutlet weak var parentNewPHView1: UIView!
    @IBOutlet weak var parentNewPHView2: UIView!
    @IBOutlet weak var parentNewPHView3: UIView!
    @IBOutlet weak var parentNewPHView4: UIView!
    @IBOutlet weak var parentNewPHView5: UIView!
    @IBOutlet weak var parentNewPHView6: UIView!
    @IBOutlet weak var parentNewPHView7: UIView!
    @IBOutlet weak var parentNewPHView8: UIView!
    @IBOutlet weak var parentNewPHView9: UIView!
    @IBOutlet weak var parentNewPHView10: UIView!
    @IBOutlet weak var parentNewPHView11: UIView!
    
    @IBOutlet weak var subPHView: UIView!
    @IBOutlet weak var subPHTitleView: UIView!
    @IBOutlet weak var subPHView1: UIView!
    @IBOutlet weak var subPHView2: UIView!
    @IBOutlet weak var subPHView3: UIView!
    @IBOutlet weak var subPHView4: UIView!
    @IBOutlet weak var subPHView5: UIView!
    @IBOutlet weak var subPHView6: UIView!
    
    // Outlets For New Design
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var serviceColletionViewHight: NSLayoutConstraint!
    @IBOutlet weak var serviceCollectionViewWidth: NSLayoutConstraint!
    @IBOutlet weak var profileBottomView: UIView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var oranngeBotoomView: UIView!
    @IBOutlet weak var imageProfileView: UIView!
    @IBOutlet weak var moreLbl: MyLabel!
    @IBOutlet weak var topOrangeView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var profileTopVIew: UIView!
    @IBOutlet weak var selectServiceHeader: MyLabel!
    @IBOutlet weak var locationViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var roundViewHight: NSLayoutConstraint!
    @IBOutlet weak var roundViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var roundImageViewHight: NSLayoutConstraint!
    @IBOutlet weak var roundImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var userJoinLabel: MyLabel!
    
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var profileImageView: UIImageView!
  
    @IBOutlet weak var locationVIewWidth: NSLayoutConstraint!
    @IBOutlet weak var locationLblTraling: NSLayoutConstraint!
    @IBOutlet weak var imageProfileViewHight: NSLayoutConstraint!
    @IBOutlet weak var locationImage: UIImageView!
    
    @IBOutlet weak var arrowRightTrailing: NSLayoutConstraint!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var orangeBottomVIewBottom: NSLayoutConstraint!
    @IBOutlet weak var topImgicon: UIImageView!
    
    @IBOutlet weak var rduContentViewleading: NSLayoutConstraint!
    
    @IBOutlet weak var rduContentViewTraling: NSLayoutConstraint!
    
    @IBOutlet weak var profileBottomViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var roundImageViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var containerViewNewDesign: UIView!
    
    @IBOutlet weak var imaSlideShowNew: iCarousel!
    
    @IBOutlet weak var imgSlideShowHightNew: NSLayoutConstraint!
    
    @IBOutlet weak var imgSlideShowNewBg: UIView!
    
    @IBOutlet weak var imgSlideShowBgHight: NSLayoutConstraint!
    
    
    @IBOutlet weak var serviceTitle22Lbl: MyLabel!
    @IBOutlet weak var bannerTopCarosoulView22Height: NSLayoutConstraint!
    @IBOutlet weak var bannerTopView22Height: NSLayoutConstraint!
    @IBOutlet weak var bannerTopCarosoulView22: iCarousel!
    @IBOutlet weak var bannerTopView22: UIView!
    @IBOutlet weak var tableView22: UITableView!
    //@IBOutlet weak var tableView22Bottom: NSLayoutConstraint!
    @IBOutlet weak var tableView22BGView: UIView!
    @IBOutlet weak var tableView22Height: NSLayoutConstraint!
    
    //@IBOutlet weak var ufxSubCategoryRadioImage: UIImageView!
    
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    
    var getAddressFrmLocation:GetAddressFromLocation!
    
    var bannersItemList = [NSDictionary]()
    var cntView:UIView!
    
    let generalFunc = GeneralFunctions()
   
    
    var moreServicesView:SDragViewForMoreServices!
    var moreServicesBGView:UIView!
    
    var loaderView:UIView!
    
    var parentCategoryItems = [NSDictionary]()
    var subCategoryItems = [NSDictionary]()
    
    var currentItems = [NSDictionary]()
    var  viewArray = [UIView]()
    var currentCategory = ""
    var currentMode = "PARENT_MODE"
    var currentCategoryName = ""
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var moreTitle = ""
    var userProfileJson:NSDictionary!
    
    var getLocation:DeviceLocation!
    
    var enterLocLbl:MyLabel!
    var locationDialog:OpenEnableLocationView!
    
    var currentLocation:CLLocation!
    var menuImage = UIImageView()
    
    var isSafeAreaSet = false
    
    var isFronMainScreen = false
    var defaultLocation:CLLocation!
    
    var isScreenKilled = false
    
    var isLoadParentMenu = false
    
    var listOfParentGridCategories = [NSDictionary]()
    var listOfParentListCategories = [NSDictionary]()
    var listOfParentAllCategories = [NSDictionary]()
    var listItemArray = [NSDictionary]()
    var moreDataForMedical = [NSDictionary]()

    var btnSheetCollectionView:UICollectionView!
    
    var cancelBtnSheetLbl:MyLabel!
    
    var selectedCategoryIds = [NSMutableDictionary]()
    var selectedServiceParentID = ""
    var preSelectedServiceIdsString = ""
  
    var homeTabBar:HomeScreenTabBarUV!

    var isFirstLaunch = true
    var moreIconImage = ""
    
    var placeHolderView:UIView!
    var lblServiceSlect:MyLabel!
    var placeholderMarker:Placeholder!
    var isDataLoading = false
    var isViewGone = false
    // variable Declares for new Design
     var imaggBgArray = ["ic_taxi_bg" ,"ic_delivery_bg", "ic_services_bg"]
     var imageIconArray = ["taxi-driver" ,"delivery", "plumber1"]
     var cateGoryArray = ["" ,"", ""]
    var biddingID = ""
     var selectecSerivceIndex = 0
    var loadMasterService = false
    var strCateGory = "TAXI"
    var listArray = [NSDictionary]()
    var iconArray = [NSDictionary]()
    var bannerArray = [NSDictionary]()
    var masterCateGory = [NSDictionary]()
    var LIST_TABLE_CELL_HIGHT = 120
    var parallexHeaderHight = 1000
    var serviceCollectionWidth = 100
    var isFromSubCateGory = false
    var isIpad = false
    var isFromLocation = false
    var window: UIWindow?
    //  this condtion handels all thing for new Design find this for change if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP") == "No")
    
    var tableDataArrayFor22 = [NSDictionary] ()
    var moreDataFor22 = [NSDictionary] ()
    var shadowImageView:UIImageView!
    var shadowImageViewForSubCat:UIImageView!
    var titleView22:UIView!
    var searchBar:UISearchBar!
    var bannerView: GADBannerView!
    var adView: FBAdView?
    var isFrameSet = false
    var eForVideoConsultation = ""
    var isMedicalServices = false
    var timerScroll = Timer()
    var firstTimeBannerScroll = true
    var currentBannerScrollIndex = -1
    
    var isAllIn1Medical = false
   
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
           
            isAllIn1Medical = userProfileJson.get("ONLY_MEDICAL_SERVICE").uppercased() == "YES" ? true : false
            
            if(userProfileJson.get("RDU_HOME_PAGE_LAYOUT_DESIGN") == "Banner/Icon"){
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                cntView = self.generalFunc.loadView(nibName: "UFXHomeScreenDesignBI", uv: self, contentView: contentView)
                }else{
                    cntView = self.generalFunc.loadView(nibName: "UFXHomeScreenDesignNew", uv: self, contentView: contentView)
                    //UFXHomeScreenDesignNew
                }
            }else{
                
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){

                 cntView = self.generalFunc.loadView(nibName: "UFXHomeScreenDesign", uv: self, contentView: contentView)
                }else{
                   cntView = self.generalFunc.loadView(nibName: "UFXHomeScreenDesignNew", uv: self, contentView: contentView)
                }
                
            }
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                
                cntView = self.generalFunc.loadView(nibName: "UFXHomeScreenDesignNew", uv: self, contentView: contentView)
              
                self.bannerTopView22.isHidden = false
                self.tableView22.isHidden = false
                self.tableView22BGView.isHidden = false
                self.tableView22.delegate = self
                self.tableView22.dataSource = self
                
                self.tableView22.tableFooterView = UIView()
                if #available(iOS 15.0, *) {
                    self.tableView22.sectionHeaderTopPadding = 0
                } else {}
                
                self.tableView22.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                self.tableView22.register(UINib(nibName: "Table22HeaderTVCell", bundle: nil), forCellReuseIdentifier: "Table22HeaderTVCell")
                self.tableView22.register(UINib(nibName: "Table22ServicesTVCell", bundle: nil), forCellReuseIdentifier: "Table22ServicesTVCell")
                self.tableView22.register(UINib(nibName: "Table22BannerTVCell", bundle: nil), forCellReuseIdentifier: "Table22BannerTVCell")
                self.tableView22.register(UINib(nibName: "Table22IconTVCell", bundle: nil), forCellReuseIdentifier: "Table22IconTVCell")
                self.tableView22.register(UINib(nibName: "Table22ButtonTVCell", bundle: nil), forCellReuseIdentifier: "Table22ButtonTVCell")
                self.tableView22.register(UINib(nibName: "Table22GridTVCell", bundle: nil), forCellReuseIdentifier: "Table22GridTVCell")
                self.tableView22.register(UINib(nibName: "Table22CubeXServicesTVCell", bundle: nil), forCellReuseIdentifier: "Table22CubeXServicesTVCell")
                self.tableView22.register(UINib(nibName: "UFXHomeListCatTVCell", bundle: nil), forCellReuseIdentifier: "UFXHomeListCatTVCell")
            
            }
            
            self.contentView.addSubview(cntView)
            
            
            placeHolderView = self.generalFunc.loadView(nibName: "UFXHomeParentCategoryPV", uv: self, contentView: self.view)
            
            Application.window!.addSubview(placeHolderView)
            
            
          //  imgSlideShow.slideshowInterval = 5.0
            
            if(Configurations.isIponeXDevice()){
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom - 20, right: 0)
            }
            
            scrollView.bounces = false
            
           // loadBanners()
            
            setData()
            
           // addMenu()
            
           
            
            if(defaultLocation != nil){
                self.onLocationUpdate(location: self.defaultLocation)
            }else{
                getLocation = DeviceLocation(uv: self, isContinuous: false)
                getLocation.buildLocManager(locationUpdateDelegate: self)
            }
            
            //        GeneralFunctions.saveValue(key: "OPEN_RATING_SCREEN", value: "2229" as AnyObject)
            if(GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") != nil && (GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") as! String) != ""){
                
                let ratingUV = GeneralFunctions.instantiateViewController(pageName: "RatingUV") as! RatingUV
                ratingUV.iTripId = (GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") as! String)
                
                GeneralFunctions.removeValue(key: "OPEN_RATING_SCREEN")
                self.push(uv:ratingUV, isDirect: true)
            }
            
            
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
                //            navigationController?.navigationBar.barTintColor = SColors.Theme_1
                
                if(ServiceModule.isAnyDeliverAllOptionEnable()){
                    self.profileImgView.image = UIImage(named:"ic_Lmenu_wallet")
                    self.walletImgView.image = UIImage(named:"ic_menu_orders")
                }
               
                GeneralFunctions.setImgTintColor(imgView: self.profileImgView, color: UIColor.gray)
                GeneralFunctions.setImgTintColor(imgView: self.walletImgView, color: UIColor.gray)
                GeneralFunctions.setImgTintColor(imgView: self.historyImgView, color: UIColor.gray)
                GeneralFunctions.setImgTintColor(imgView: self.activeJobImgView, color: UIColor.gray)
               
                self.profileLbl.textColor = UIColor.gray
                self.walletLbl.textColor = UIColor.gray
                self.historyLbl.textColor = UIColor.gray
                self.activeJobLbl.textColor = UIColor.gray
                
                self.profileLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_PROFILE").uppercased()
                self.walletLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_WALLET").uppercased()
                self.historyLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_BOOKINGS").uppercased()
                self.activeJobLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_ACTIVE_JOBS").uppercased()
                
                if(ServiceModule.isAnyDeliverAllOptionEnable()){
                    self.profileLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_RDU_WALLET").uppercased()
                    self.walletLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDERS_TXT").uppercased()
                }
                
                let profileTapGue = UITapGestureRecognizer()
                let walletTapGue = UITapGestureRecognizer()
                let historyTapGue = UITapGestureRecognizer()
                let activeJobTapGue = UITapGestureRecognizer()
                
                
                historyTapGue.addTarget(self, action: #selector(self.openHistory))
                activeJobTapGue.addTarget(self, action: #selector(self.openActiveJobs))
                
                if(ServiceModule.isAnyDeliverAllOptionEnable()){
                    profileTapGue.addTarget(self, action: #selector(self.openWallet))
                    walletTapGue.addTarget(self, action: #selector(self.openProfile))
                }else{
                    profileTapGue.addTarget(self, action: #selector(self.openProfile))
                    walletTapGue.addTarget(self, action: #selector(self.openWallet))
                }
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                self.profileView.isUserInteractionEnabled = true
                self.walletView.isUserInteractionEnabled = true
                self.historyView.isUserInteractionEnabled = true
                self.activeJobView.isUserInteractionEnabled = true
                
                self.profileView.addGestureRecognizer(profileTapGue)
                self.walletView.addGestureRecognizer(walletTapGue)
                self.historyView.addGestureRecognizer(historyTapGue)
                self.activeJobView.addGestureRecognizer(activeJobTapGue)
                
                let APPSTORE_MODE_IOS = GeneralFunctions.getValue(key: Utils.APPSTORE_MODE_IOS_KEY)
                if(APPSTORE_MODE_IOS != nil && (APPSTORE_MODE_IOS as! String).uppercased() == "REVIEW"){
                    self.walletView.isHidden = true
                }
                }
                self.rduCollectionView.dataSource = self
                self.rduCollectionView.delegate = self
                self.rduCollectionView.register(UINib(nibName: "UFXJekIconCVC", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVC")
                self.rduCollectionView.bounces = false
                self.rduCollectionView.contentInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
                
                self.rduTableView.dataSource = self
                self.rduTableView.delegate = self
                self.rduTableView.bounces = false
                
                self.rduTableView.tableFooterView = UIView()
                if #available(iOS 15.0, *) {
                    self.rduTableView.sectionHeaderTopPadding = 0
                } else {}
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                self.rduTableView.register(UINib(nibName: "UFXJekIconTVC", bundle: nil), forCellReuseIdentifier: "UFXJekIconTVC")
                }
                
                self.rduTableView.register(UINib(nibName: "UFXHomeListCatTVCell", bundle: nil), forCellReuseIdentifier: "UFXHomeListCatTVCell")
                //            self.rduTableView.contentInset = UIEdgeInsetsMake(5, 0, GeneralFunctions.getSafeAreaInsets().bottom + 5, 0)
                
                self.rduScrollView.bounces = false
            }
            
            
           
            if(Configurations.isIponeXDevice() == true){
                if #available(iOS 11.0, *) {
                    //self.nextBtnHeight.constant = 20 + self.nextBtnHeight.constant
                } else {
                    // Fallback on earlier versions
                }
            }
            
            self.nextBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_NEXT_TXT"))
            self.nextBtn.setClickHandler { (instance) in
                if self.currentCategory.uppercased() != "BIDDING" {
                self.checkSelectedCategories(isFromSearch: false)
                }else{
                    self.checkBiddingData()
                }
            }
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                self.setDataNewD()
                
                if UIDevice.current.userInterfaceIdiom == .pad
                {
                    let offSet = Application.screenSize.width / 2
                    let height = Utils.getHeightOfBanner(widthOffset: offSet, ratio: "16:9")
                    
                    LIST_TABLE_CELL_HIGHT = Int(height)
                    isIpad = true
                    rduCollectionViewHeight.constant = 190
                    profileBottomViewHight.constant = 270
                    //parallexHeaderHight = 570
                    serviceCollectionWidth = 170
                    self.roundImageViewTop.constant = 30
                    if(self.userProfileJson.get("HOME_SCREEN_DESIGN_HEADER_VIEW") != "Profile"){
                    parallexHeaderHight = Int(Utils.getHeightOfBanner(widthOffset: 00, ratio: "16:9") + 130 + self.profileBottomView.height)
                    }else{
                        parallexHeaderHight = 570
                    }
                }else{
    //                if(self.userProfileJson.get("HOME_SCREEN_DESIGN_HEADER_VIEW") != "Profile"){
    //                    parallexHeaderHight = Int(Utils.getHeightOfBanner(widthOffset: 00, ratio: "16:9") + 50 + self.profileBottomView.height)
    //
    //                }else{
                       // parallexHeaderHight = Int(Utils.getHeightOfBanner(widthOffset: 00, ratio: "16:9") + 50 + self.profileBottomView.height)
                    parallexHeaderHight = Int(Utils.getHeightOfBanner(widthOffset: 00, ratio: "16:9") + (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? 50 : 40) + self.profileBottomView.height)
                    
                   // }
                }
            }
            if(self.isAllIn1Medical){
                self.isMedicalServices = true
                self.setUpAllIn1MedicalView()
            }
           
        }else if(type == 1){
            
            if(self.isAllIn1Medical){
                self.isMedicalServices = true
            }

            self.configRTL()
            self.isViewGone = false
            
        
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                
                self.navigationController?.navigationBar.zPosition = -1
                if self.homeTabBar != nil {
                    if(self.homeTabBar.navItem == nil){
                        self.homeTabBar.navItem = self.navigationItem
                        isFronMainScreen = true
                    }
                }
                
                
                if(self.rduScrollView != nil && self.rduScrollView.parallaxHeader != nil && self.rduScrollView.parallaxHeader.progress <= 0){
                    //self.selectServiceLbl.layer.shadowOpacity = 1.0;
                  //  self.selectServiceLbl.layer.masksToBounds = true
                    //self.selectServiceLbl.layer.addShadow(opacity: 0.9, radius: 2, UIColor.gray)
                    self.selectServiceLbl.layer.borderColor = UIColor.lightGray.cgColor
                }else{
                    //self.selectServiceLbl.layer.shadowOpacity = 0.0;
                    self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                }
                
                
        //        self.rduScrollView.setContentOffset(
        //            CGPoint(x: 0,y: -self.rduScrollView.contentInset.top),
        //            animated: false)
        //        self.scrollView.setContentOffset(
        //            CGPoint(x: 0,y: -self.scrollView.contentInset.top),
        //            animated: false)
                
                self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
                
                if(GeneralFunctions.isKeyExistInUserDefaults(key: "FROMCHECKOUT") == true && GeneralFunctions.getValue(key: "FROMCHECKOUT") as! Bool == true){
                    if(self.homeTabBar != nil && self.homeTabBar.tabbarHidden == true){
                        self.contentView.alpha = 0
                        UIView.animate(withDuration: 0.3, animations: {
                            self.homeTabBar.tabbarHidden = false
                            self.adView?.isHidden = false
                            if(self.bannerView != nil){
                                self.bannerView.isHidden = false
                            }
                            
                            self.homeTabBar.bannerAd.zPosition = 1
                            self.contentView.alpha = 1
                        })
                    }
                    
                    loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                    GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: false as AnyObject)
                }else{
                    if(isFirstLaunch == true){
                        
                        if(GeneralFunctions.isKeyExistInUserDefaults(key: "SERVICE_HOME_DATA") && GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String != ""){
                            
                            self.serviceResponseHandling(response: GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String)
                             
                        }else{
                            loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                        }
                        
                        self.isFirstLaunch = false
                    }
                }
            
                if(self.isFromSearchServicesUV == false){
                    GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: "" as AnyObject)
                }else{
                    self.isFromSearchServicesUV = false
                }
                 
                self.configRTL()
                
            }else{
                self.navigationController?.navigationBar.zPosition = -1
                if self.homeTabBar != nil {
                    if self.currentMode == "SUB_MODE"{
                       
                        self.navigationController?.setNavigationBarHidden(false, animated: true)
                        //self.homeTabBar.navigationController?.navigationBar.barTintColor = SColors.Theme
                        self.homeTabBar.setnavBarTintColor(color: SColors.Theme)
                        
                        

                        
                }else{
                    self.homeTabBar.navigationController?.isNavigationBarHidden = true
                    //self.homeTabBar.navigationController?.navigationBar.barTintColor = UIColor.white
                    self.homeTabBar.setnavBarTintColor(color: SColors.Theme)
                      
                       
                }
                      //self.homeTabBar.navigationController?.isNavigationBarHidden = true
                    if(self.homeTabBar.navItem == nil){
                        self.homeTabBar.navItem = self.navigationItem
                        isFronMainScreen = true
                      

                    }
                }
                
                self.rduScrollView.setContentOffset(
                    CGPoint(x: 0,y: -self.rduScrollView.contentInset.top),
                    animated: false)
                self.scrollView.setContentOffset(
                    CGPoint(x: 0,y: -self.scrollView.contentInset.top),
                    animated: false)
                
                self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
                
                if(GeneralFunctions.isKeyExistInUserDefaults(key: "FROMCHECKOUT") == true && GeneralFunctions.getValue(key: "FROMCHECKOUT") as! Bool == true){
                    if(self.homeTabBar != nil && self.homeTabBar.tabbarHidden == true){
                        self.contentView.alpha = 0
                        UIView.animate(withDuration: 0.3, animations: {
                            self.homeTabBar.tabbarHidden = false
                            self.adView?.isHidden = false
                            if(self.bannerView != nil){
                                self.bannerView.isHidden = false
                            }
                            self.homeTabBar.bannerAd.zPosition = 1
                            self.contentView.alpha = 1
                        })
                    }
                    
                    loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                    GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: false as AnyObject)
                }else{
                    if(isFirstLaunch == true){
                        if(GeneralFunctions.isKeyExistInUserDefaults(key: "SERVICE_HOME_DATA") && GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String != "" && self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
                            
                            
                            //Utils.delayWithSeconds(0.3) {
                                self.serviceResponseHandling(response: GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String)
                            //}
                            
                             
                        }else{
                            loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                        }
                        self.isFirstLaunch = false
                    }
                    
                    
                }
            
                if(self.isFromSearchServicesUV == false){
                    GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: "" as AnyObject)
                }else{
                    self.isFromSearchServicesUV = false
                }
                self.configRTL()
                userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                if GeneralFunctions.getMemberd() != "" {
                //self.userNameLbl.text =   self.generalFunc.getLanguageLabel(origValue: "Hello", key: "LBL_HELLO") + ", " + userProfileJson.get("vName")  + " " + userProfileJson.get("vLastName")
                    self.userNameLbl.text =   userProfileJson.get("vName")  + " " + userProfileJson.get("vLastName")
                   // self.userJoinLabel.textColor = UIColor.black
                self.userJoinLabel.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WALLET_BALANCE") + " : " + Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)//userProfileJson.get("tMemberSince")
                self.profileImageView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
                }
            }
            self.setApplicationStatusBar()
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                
                
                if(self.bannersItemList.count > 0){
                    
                    self.setnavBarTintColor(color: SColors.Theme)
                }else{
                    
                    self.setnavBarTintColor(color: SColors.Theme)
                    
                }
            }
            if Configurations.isRTLMode() {
                Utils.delayWithSeconds(0.8) {
                    self.timerScroll = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
                }
            
            
            }else{
                timerScroll = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
            }
            
        }else if(type == 2){
            
            
            
            if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes" || userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") {
                
                if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes"){
                    self.tableView22Height.constant = Application.screenSize.height - (self.topbarHeight + self.homeTabBar.kBarHeight + 50)
                    
                    let adSize = GADAdSizeFromCGSize(CGSize(width: Application.screenSize.width, height: 50))
                    bannerView = GADBannerView(adSize: adSize)
                    bannerView.adUnitID = userProfileJson.get("GOOGLE_ADMOB_ID") 
                    bannerView.rootViewController = self
                    bannerView.delegate = self
                    bannerView.load(GADRequest())
                }
                if(userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes"){
                    self.tableView22Height.constant = Application.screenSize.height - (self.topbarHeight + self.homeTabBar.kBarHeight + 50)
                
                    adView = FBAdView(placementID: self.userProfileJson.get("FACEBOOK_PLACEMENT_ID_IOS"), adSize: kFBAdSizeHeight50Banner, rootViewController: self)
                    var bottomBarHeight = 0.0
                    if(self.homeTabBar != nil){
                        bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 50 + self.topbarHeight)
                    }
                    if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes" && userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") {
                        bottomBarHeight = bottomBarHeight - 50
                    }
                    
                    adView?.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)
                    
                    FBAdSettings.setAdvertiserTrackingEnabled(false)
                    self.identifierForAdvertising()
                    adView?.delegate = self
                    adView?.loadAd()
                }
                
                if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes" && userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") {
                    
                    print("height:\(self.homeTabBar.kBarHeight)")
                    self.tableView22Height.constant = Application.screenSize.height - (self.topbarHeight + self.homeTabBar.kBarHeight + 100)
                }
                
            }else{
                self.tableView22Height.constant = Application.screenSize.height - (self.topbarHeight + self.homeTabBar.kBarHeight)
            }
            
        
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                self.addTitleView22()
            }
            self.placeHolderView.clipsToBounds = true
            self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height - self.homeTabBar.kBarHeight)
            if(self.isDataLoading == true){
                self.setPlaceHolderView()
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.appInBackground), name: NSNotification.Name(rawValue: Utils.appBGNotificationKey), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.appInForground), name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
            self.imgSlideShow.frame.origin.y = 0
            checkLocationEnabled()
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() != "YES"){
                addTitleView()
            }
            
            /* Testing Code */
            GeneralFunctions.removeValue(key: "UFX_PROVIDER_FLOW_ADDRESS_DETAIS")
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
                GeneralFunctions.saveValue(key: "UFXCartData", value: [[NSDictionary]]() as AnyObject)
            }
            
            addDriverNotificationObserver()
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "FROMCHECKOUT") == true && GeneralFunctions.getValue(key: "FROMCHECKOUT") as! Bool == true){
                if(self.homeTabBar != nil && self.homeTabBar.tabbarHidden == true){
                    self.contentView.alpha = 0
                    UIView.animate(withDuration: 0.3, animations: {
                        self.homeTabBar.tabbarHidden = false
                        self.adView?.isHidden = false
                        if(self.bannerView != nil){
                            self.bannerView.isHidden = false
                        }
                        self.homeTabBar.bannerAd.zPosition = 1
                        self.contentView.alpha = 1
                    })
                }
                
                loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: false as AnyObject)
            }else{
                if(isFirstLaunch == true){
                    loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                    self.isFirstLaunch = false
                }
            }
        
//            if(self.isFromSearchServicesUV == false){
//                GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: "" as AnyObject)
//            }else{
//                self.isFromSearchServicesUV = false
//            }
            
            
        }else if(type == 3){
            self.isViewGone = true
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                
                self.removePlaceHolderView()
                
                self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appBGNotificationKey), object: nil)
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
                self.setCustomNavBarColor(isCustom: false)

                //NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.driverCallBackNotificationKey), object: nil)
            }
            else{
                self.removePlaceHolderView()
                //navigationController?.navigationBar.barTintColor = SColors.Theme
                self.homeTabBar.setnavBarTintColor(color: SColors.Theme)
                //self.homeTabBar.navigationController?.isNavigationBarHidden = false
                self.navigationController?.navigationBar.zPosition = 1
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appBGNotificationKey), object: nil)
                NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
                Configurations.setStatusBarStyle(style: SColors.ThemeSBStyle.uppercased() == "LIGHT" ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default)
                
            }
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.driverCallBackNotificationKey), object: nil)
            self.setApplicationStatusBar()
            
            if(self.titleView22 != nil){
                self.titleView22.removeFromSuperview()
                self.titleView22 = nil
            }
            if timerScroll != nil {
                timerScroll.invalidate()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            
            cntView.frame.size.height = cntView.frame.size.height
            isSafeAreaSet = true
        }
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
            self.roundView.layer.masksToBounds = true
            self.roundView.layer.cornerRadius = roundView.bounds.width / 2
            self.roundView.layer.borderColor = SColors.Theme.cgColor

            self.profileImageView.layer.masksToBounds = true
            self.profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            self.oranngeBotoomView.layer.masksToBounds = true
            self.oranngeBotoomView.layer.cornerRadius = oranngeBotoomView.bounds.width / 2
            self.topOrangeView.layer.masksToBounds = true
            self.topOrangeView.layer.cornerRadius = topOrangeView.bounds.width / 2
            self.topOrangeView.backgroundColor = SColors.Theme
            self.oranngeBotoomView.backgroundColor = SColors.Theme
            self.topImgicon.transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
            self.parentPHView2.layer.masksToBounds = true
            self.parentPHView2.layer.cornerRadius = parentPHView2.bounds.width / 2
            GeneralFunctions.setImgTintColor(imgView:self.topImgicon , color: UIColor.black)
            //GeneralFunctions.setImgTintColor(imgView:self.locationImage , color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView:self.locationImage , color: UIColor.black)
            //self.oranngeBotoomView
            
           
            //roundProfileView
            //self.setGradientBackground()
//            self.serviceCollectionView.layer.shadowOpacity = 0.7
//            self.serviceCollectionView.layer.shadowOffset = CGSize.zero
//            self.serviceCollectionView.layer.shadowColor = UIColor.lightGray.cgColor
            print(UIDevice().type)

            locationViewTop.constant = (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? 40 : 25)
            if(Configurations.isRTLMode()){
                self.moreLbl.textAlignment = .left
            }else{
                self.moreLbl.textAlignment = .right
            }
            
            Configurations.setStatusBarStyle(style: UIStatusBarStyle.default)
        }
    }
    
    func setUpAllIn1MedicalView(){
        
        self.allIn1MedicalCollectionView.isHidden = false
        let layout:UICollectionViewFlowLayout? = self.allIn1MedicalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        self.allIn1MedicalCollectionView.delegate = self
        self.allIn1MedicalCollectionView.dataSource = self
        self.allIn1MedicalCollectionView.register(UINib(nibName: "UFXJekIconCVCNew", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVCNew")
        self.allIn1MedicalCollectionView.register(UINib(nibName: "CategoryHeaderCVCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryHeaderCVCell")
        self.allIn1MedicalCollectionView.bounces = false
        
        self.allIn1MedicalCollectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 30, right: 0)
        
        
    }
    
    func setPlaceHolderView(){
            self.placeHolderView.alpha = 1.0
            placeholderMarker = Placeholder()
            var viewElements: [UIView] = [

                parentPHView1, parentPHView2, parentPHView3, parentPHView4, parentPHView5, parentPHView6, parentPHView7, parentPHView10, parentPHView11, parentPHView12, parentPHView13, parentPHView14, parentPHView15, parentPHView16, parentPHView17, parentPHView20, parentPHView21, parentNewPHView1, parentNewPHView2, parentNewPHView3, parentNewPHView4, parentNewPHView5, parentNewPHView6, parentNewPHView7, parentNewPHView8, parentNewPHView9, parentNewPHView10, parentNewPHView11
            ]
            
        if self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES" && isFromSubCateGory == false {
            if  self.currentMode == "PARENT_MODE" {
            self.parentNewPHView.isHidden = false
            self.parentPHView2.layer.masksToBounds = true
            self.parentPHView2.layer.cornerRadius = parentPHView2.bounds.width / 2
            }else{
                self.parentNewPHView.isHidden = true
            }
        }else{
            isFromSubCateGory = false
            self.parentNewPHView.isHidden = true
            
        }
            
            if(self.selectedServiceParentID == "" || self.selectedServiceParentID == "0"){
                self.subPHView.isHidden = true
            }else{
                self.subPHView.isHidden = false
                viewElements = [
                    
                    parentPHView1, parentPHView2, parentPHView3, parentPHView4, parentPHView5, parentPHView6, parentPHView7, parentPHView10, parentPHView11, parentPHView12, parentPHView13, parentPHView14, parentPHView15, parentPHView16, parentPHView17, parentPHView20, parentPHView21, subPHView1, subPHView2, subPHView3, subPHView4, subPHView5, subPHView6, parentNewPHView2, subPHTitleView, parentNewPHView1
                ]
            }
           
            placeholderMarker.register(viewElements)
            placeholderMarker.startAnimation()
        
        }
    func removePlaceHolderView(){
        if(self.placeHolderView != nil){
            self.contentView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.placeHolderView.alpha = 0.0},
                                            completion: {(value: Bool) in
                
                if(self.placeholderMarker != nil){
                    self.placeholderMarker.remove()
                }
                
                                                
            })
        }
    }
    
    
    func serviceResponseHandling(response:String, _ parentID:String = ""){
    
        var parentCategoryId = userProfileJson.get("UBERX_PARENT_CAT_ID")
        if(parentID != ""){
            parentCategoryId = parentID
        }
        
        UIView.animate(withDuration: 0.01, animations: {
            self.isDataLoading = false
            self.contentView.alpha = 1
            self.removePlaceHolderView()
            
        }, completion:{ _ in})
        
        if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true && ServiceModule.isDeliverAllOnly() && GeneralFunctions.isKeyExistInUserDefaults(key: "LOGED_IN_DELIVERALL")) {
            
            GeneralFunctions.removeValue(key: "LOGED_IN_DELIVERALL")
            let items =  GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray
            if items.count > 0
            {
                let cartUV = GeneralFunctions.instantiateViewController(pageName: "CartUV") as! CartUV
                cartUV.isFromMenu = true
                self.push(uv: cartUV)
            }
        }
        
        let dataDict = response.toDict()
        if self.userProfileJson.get("isSmartLoginEnable").uppercased() == "YES" {
        if (GeneralFunctions.isKeyExistInUserDefaults(key: "IS_POPUP_SHOW") == false || GeneralFunctions.getValue(key: "IS_POPUP_SHOW") as! Bool == true){
            if GeneralFunctions.isQuickLogInEnable(){
                
            }else{
            GeneralFunctions.saveValue(key: "IS_POPUP_SHOW", value: false as AnyObject)
            self.openSmartLogin()
            }
        }
        }
        self.moreIconImage = dataDict.get("MORE_ICON")
        self.bannersItemList.removeAll()

        let msgArr = dataDict.arrOf("BANNER_DATA")
        
        for i in 0..<msgArr.count{
            let tempItem = msgArr[i] as! NSDictionary
        
            self.bannersItemList.append(tempItem)
        }
        if Configurations.isRTLMode() {
            let count = self.bannersItemList.count
            for i in 0..<count/2 {
               (self.bannersItemList[i],self.bannersItemList[count - i - 1])  = (self.bannersItemList[count - i - 1],self.bannersItemList[i])
            }
           
        }
        
        if Configurations.isRTLMode() {
            currentBannerScrollIndex = self.bannersItemList.count
        }
        //self.setBannerData()
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            self.setBannerData22()
             
            
        }else{
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                self.setBannerData()
            }else{
                self.setBannerDataNewD()
            }
        }
        self.setPageController()
        
        if(dataDict.get("Action") == "1"){
            
            let msgArr = dataDict.arrOf(Utils.message_str)
            
            if(parentCategoryId == "0"){
                
               
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                    self.tableDataArrayFor22.removeAll()
                    self.tableDataArrayFor22 = dataDict.arrOf("HOME_SCREEN_DATA") as! [NSDictionary]
                    self.tableView22.reloadData()
                    
                   
                    for i in 0..<self.tableDataArrayFor22.count{
                        let getItem = self.tableDataArrayFor22[i]
                        
                        if getItem.get("MedicalServiceSection").uppercased() == "YES" {
                            self.moreDataForMedical = getItem.arrOf("MoreSubCategories") as! [NSDictionary]
                            self.isMedicalServices = true
                            if  self.lblServiceSlect != nil {
                                 self.lblServiceSlect.text = getItem.get("vCategoryTitle")
                             }else{
                                 self.moreTitle = getItem.get("vCategoryTitle")
                             }
                            
                            self.allIn1MedicalCollectionView.reloadData()
                        }
                    }
                    
                    if(self.bannersItemList.count > 0){
                        
                        self.setnavBarTintColor(color: SColors.Theme)
                    }else{
                        self.setnavBarTintColor(color: SColors.Theme)
                    }
                    
                }
            }
            

            // Cache Sub CategoriesData
            self.subServicesResponseHandling()
            
            self.currentItems.removeAll()
            if(parentCategoryId != "0"){
                self.subCategoryItems.removeAll()
            }
            
            var categoryItems = [NSDictionary] ()
            
            for i in 0..<msgArr.count{
                //self.eForVideoConsultation = (msgArr[i] as! NSDictionary).get("eVideoConsultEnable")
                categoryItems += [msgArr[i] as! NSDictionary]
            }
            
            self.currentItems.append(contentsOf: categoryItems)
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                if self.loadMasterService == false {
                    self.loadMasterService = true
                    self.masterCateGory = dataDict.arrOf("MASTER_SERVICE_CATEGORIES") as! [NSDictionary]
                }
             }
            if(parentCategoryId == "0"){
                
               // self.selectServiceLbl.backgroundColor = UIColor.white
                self.contentView.backgroundColor = UIColor.white
               // self.scrollView.contentInset = UIEdgeInsets(top: self.scrollView.contentInset.top, left: self.scrollView.contentInset.left, bottom: 50, right: self.scrollView.contentInset.right)
                
                self.parentCategoryItems.removeAll()
                
                self.parentCategoryItems.append(contentsOf: categoryItems)
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                self.setParentMode()
                    self.selectServiceLbl.backgroundColor = UIColor.white
                }else{
                    self.selectSerivcesSubLbl.backgroundColor = UIColor.white
                    self.setParentModeNewD()
                }
                //self.setParentMode()
            }else{
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                    self.selectServiceLbl.backgroundColor = UIColor(hex: 0xf1f1f1)
                }else{
                    self.selectSerivcesSubLbl.backgroundColor = UIColor(hex: 0xf1f1f1)
                }
               
                self.serviceTitle22Lbl.text = dataDict.get("vParentCategoryName")
                self.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
                self.subCategoryItems.append(contentsOf: categoryItems)
                
                if(self.homeTabBar != nil && self.currentMode != "SUB_MODE" && self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
                    UIView.animate(withDuration: 0.3, animations: {
                        self.homeTabBar.tabbarHidden = true
                        self.adView?.isHidden = true
                        if(self.bannerView != nil){
                            self.bannerView.isHidden = true
                        }
                        self.homeTabBar.bannerAd.zPosition = -1
                        
                        var frame = self.view.bounds;
                        frame.size.height = 500;
                        
                        self.view.frame = frame;
                    })
                }
                
                
                self.setSubCategoryMode(vParentCategoryName: dataDict.get("vParentCategoryName"))
            }
            
        }
        
    }
    
    
    func setCustomNavBarColor(isCustom:Bool){
        if(self.userProfileJson != nil && (ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct)){
            //            Configurations.setAppColorNavBar(bgColor: SColors.Theme_1, txtColor: SColors.ThemeTxt_1)
            
            if(isCustom && self.currentMode == "PARENT_MODE"){
               // navigationController?.navigationBar.barTintColor = SColors.Theme_1
                self.homeTabBar.setnavBarTintColor(color: SColors.Theme_1)
            }else{
                //navigationController?.navigationBar.barTintColor = SColors.Theme
                self.homeTabBar.setnavBarTintColor(color: SColors.Theme)
                
            }
        }
    }
    
    
    override func addBack() {
        if(isLoadParentMenu){
            isLoadParentMenu = false
            super.addBack()
            return
        }
        
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            self.setBannerData22()
            
        }
//        if(Configurations.isRTLMode()){
//            self.navigationDrawerController?.isRightPanGestureEnabled = false
//        }else{
//            self.navigationDrawerController?.isLeftPanGestureEnabled = false
//        }
        
        var backImg = UIImage(named: "ic_nav_bar_back")!
        if(Configurations.isRTLMode()){
            backImg = backImg.rotate(180)
        }
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: backImg, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.loadParentMode))
        self.homeTabBar.navItem.leftBarButtonItem = leftButton
    }
    
    override func close() {

        
        isScreenKilled = true
        
        if(getAddressFrmLocation != nil){
            getAddressFrmLocation.uv = nil
            getAddressFrmLocation.addressFoundDelegate = nil
            getAddressFrmLocation = nil
        }
        
        if(self.getLocation != nil){
            self.getLocation.locationUpdateDelegate = nil
            self.getLocation.uv = nil
            self.getLocation = nil
        }
        
        
        for subview in self.ufxDataVerticalStackView.subviews {
            subview.removeFromSuperview()
        }
        self.ufxDataVerticalStackView.removeFromSuperview()
        
        super.close()
    }
    
   
    
    func addDriverNotificationObserver(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.driverCallBackReceived(sender:)), name: NSNotification.Name(rawValue: Utils.driverCallBackNotificationKey), object: nil)
    }
    
    @objc func driverCallBackReceived(sender: NSNotification){
      
        let userInfo = sender.userInfo
        let msgData = (userInfo!["body"] as! String).toDict()
        
        let msgStr = msgData.get("Message")
        
        if(msgStr == "CabRequestAccepted" && msgData.get("eType") != Utils.cabGeneralType_UberX){
           
            let window = Application.window
            
            let getUserData = GetUserData(uv: self, window: window!)
            getUserData.getdata()
        }
    }
    
    
    @objc func openProfile(){
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
        
        if ServiceModule.isAnyDeliverAllOptionEnable()
        {
            walletView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        }else
        {
            profileView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            if ServiceModule.isAnyDeliverAllOptionEnable()
            {
                self.walletView.transform = .identity
            }else
            {
                self.profileView.transform = .identity
            }
            
        }) { (_) in
            
            if ServiceModule.isAnyDeliverAllOptionEnable()
            {
                let ordersListUV = GeneralFunctions.instantiateViewController(pageName: "OrdersListUV") as! OrdersListUV
                ordersListUV.isDirectPush = true
                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(ordersListUV, animated: true)
            }else
            {
                let manageProfileUv = GeneralFunctions.instantiateViewController(pageName: "ManageProfileUV") as! ManageProfileUV
                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageProfileUv, animated: true)
            }
            
        }
        
    }
    
    @objc func openWallet(){
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
        
        if(ServiceModule.isAnyDeliverAllOptionEnable()){
            profileView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        }else{
            walletView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            if(ServiceModule.isAnyDeliverAllOptionEnable()){
                self.profileView.transform = .identity
            }else{
                self.walletView.transform = .identity
            }
            
        }) { (_) in
            let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
        }
        
    }
    
    @objc func openHistory(){
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
        
        historyView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            self.historyView.transform = .identity
        }) { (_) in
            let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
            rideOrderHistoryTabUV.isFromViewProfile = true
            rideOrderHistoryTabUV.isFromUFXCheckOut = false
            self.push(uv: rideOrderHistoryTabUV)
            
            if(self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() == "YES"){
                
            }else{
                rideOrderHistoryTabUV.isDirectPush = true
            }
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(rideOrderHistoryTabUV, animated: true)
            
            /*let rideHistoryUv = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
            let myBookingsUv = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
            rideHistoryUv.HISTORY_TYPE = "PAST"
            rideHistoryUv.pageTabBarItem.title = self.generalFunc.getLanguageLabel(origValue: "PAST", key: "LBL_PAST").uppercased()
            
            myBookingsUv.pageTabBarItem.title = self.generalFunc.getLanguageLabel(origValue: "UPCOMING", key: "LBL_UPCOMING").uppercased()
            myBookingsUv.HISTORY_TYPE = "LATER"
            
            if(self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() == "YES"){
                let rideHistoryTabUv = RideHistoryTabUV(viewControllers: [rideHistoryUv, myBookingsUv], selectedIndex: 0)
                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(rideHistoryTabUv, animated: true)
            }else{
                rideHistoryUv.isDirectPush = true
                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(rideHistoryUv, animated: true)
            }*/
        }
        
        
    }
    
    @objc func openActiveJobs(){
        if(self.userProfileJson.get("eReviewModeLogin").uppercased() == "YES"){
            self.generalFunc.setAlertMessage(uv: self, title: "", content: "Please login/signup to proceed.", positiveBtn: "Ok", nagativeBtn: "") { (btn_id) in
                
                GeneralFunctions.logOutUser()
                
                GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                
                GeneralFunctions.restartApp(window: Application.window!)
            }
            return
        }
        
        activeJobView.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            self.activeJobView.transform = .identity
        }) { (_) in
            let myOnGoingTripsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripsUV") as! MyOnGoingTripsUV
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(myOnGoingTripsUV, animated: true)
        }
    }
    
    func addMenu(){
        if(isFronMainScreen){
            isLoadParentMenu = true
            self.addBack()
        }else{
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_all_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openMenu))
            self.homeTabBar.navItem.leftBarButtonItem = leftButton
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
    
    
    
    func addTitleView(){
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
        let titleView = generalFunc.loadView(nibName: "UFXHomeTitleView", uv: self, isWithOutSize: true)
        titleView.frame = CGRect(x: 0, y:0, width: Application.screenSize.width, height: 50)
        //        titleView.subviews[2].transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        (titleView.subviews[0] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOCATION_FOR_AVAILING_TXT")
        (titleView.subviews[1] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
        (titleView.subviews[2] as! UIImageView).transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
       
            GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
            (titleView.subviews[0] as! MyLabel).textColor = SColors.ThemeTxt
            (titleView.subviews[1] as! MyLabel).textColor = SColors.ThemeTxt
        
        //GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
    
        //GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
        self.enterLocLbl = (titleView.subviews[1] as! MyLabel)
        //self.enterLocLbl.textColor = SColors.Theme
        self.enterLocLbl.numberOfLines = 2
    
        if self.homeTabBar != nil {

            self.homeTabBar.navItem.titleView = titleView
        }
        let titleViewTapGue = UITapGestureRecognizer()
        titleViewTapGue.addTarget(self, action: #selector(self.titleViewTapped))

        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(titleViewTapGue)
        
        if(self.selectedAddress != ""){
            self.enterLocLbl.text = self.selectedAddress
        }
        
        if(self.homeTabBar != nil && self.currentMode == "PARENT_MODE"){
            self.homeTabBar.navItem.leftBarButtonItem = nil
        }
       
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
            self.locationLbl.textColor = UIColor.black
            self.locationLbl.handleClick { (instance) in
                self.titleViewTapped()
            }
            if(self.selectedAddress != ""){
                self.enterLocLbl.text = self.selectedAddress
                self.locationLbl.text = self.selectedAddress
            }
        }
        }else{
            let titleView = generalFunc.loadView(nibName: "UFXHomeTitleView", uv: self, isWithOutSize: true)
            titleView.frame = CGRect(x: 0, y:0, width: Application.screenSize.width, height: 50)
            //        titleView.subviews[2].transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
            (titleView.subviews[0] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOCATION_FOR_AVAILING_TXT")
            (titleView.subviews[1] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
            (titleView.subviews[2] as! UIImageView).transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        
            GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
        
            GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
            self.enterLocLbl = (titleView.subviews[1] as! MyLabel)
            self.enterLocLbl.numberOfLines = 2
        
            if self.homeTabBar != nil {

                self.homeTabBar.navItem.titleView = titleView
            }
            let titleViewTapGue = UITapGestureRecognizer()
            titleViewTapGue.addTarget(self, action: #selector(self.titleViewTapped))

            titleView.isUserInteractionEnabled = true
            titleView.addGestureRecognizer(titleViewTapGue)
            
            if(self.selectedAddress != ""){
                self.enterLocLbl.text = self.selectedAddress
            }
            
            if(self.homeTabBar != nil && self.currentMode == "PARENT_MODE"){
                self.homeTabBar.navItem.leftBarButtonItem = nil
            }
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
    
    func setData(){
        if(self.selectServiceLbl != nil){
            self.selectServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RDU_SERVICES_TITLE")
        }
        
        
        EventService.getInstance().buildConnection()
        
    }
    
    @objc func titleViewTapped(){
        openPlaceFinder()
    }
    
    func loadBanners(){
        if(ServiceModule.rideDeliveryUbexProduct){
            return
        }
        
        let parameters = ["type":"getBanners","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0..<msgArr.count{
                        let tempItem = msgArr[i] as! NSDictionary
                       
                        self.bannersItemList.append(tempItem)
                    }
                    
                   // self.imgSlideShow.contentScaleMode = .scaleToFill
                    //self.imgSlideShow.setImageInputs(self.bannersItemList)
                    
                    let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderImgTapped))
                    self.imgSlideShow.addGestureRecognizer(recognizer)
                    
                }else{
                    //                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                //                self.generalFunc.setError(uv: self)
            }
            
        })
    }
    
    @objc func sliderImgTapped(){
        //        imgSlideShow.presentFullScreenController(from: self)
    }
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
       
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
        if(parallaxHeader.progress <= 0){
           
            self.selectServiceLbl.layer.borderColor = UIColor.lightGray.cgColor
            
            
        }else{
            
            self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
        }
        }else{
            if(parallaxHeader.progress <= 0){
               
                if self.currentMode != "SUB_MODE"{
                    self.rduCollectionView.isHidden = true
                   // self.selectServiceHeader.layer.borderColor = UIColor.lightGray.cgColor
                }
                self.selectSerivcesSubLbl.layer.borderColor = UIColor.lightGray.cgColor
            }else{
                
                self.selectSerivcesSubLbl.layer.borderColor = UIColor.clear.cgColor
                if self.currentMode == "SUB_MODE" {
              
                    self.rduCollectionView.isHidden = true
                   

               
                }else{
                 
                    self.rduCollectionView.isHidden = false
                    self.imageProfileView.backgroundColor = UIColor.white
                    self.profileTopVIew.backgroundColor = UIColor.white
                   // self.selectServiceHeader.layer.borderColor = UIColor.clear.cgColor
                }
                
            }
        }
    }
    
    func setBannerData(){
        self.imageSlideShowBGView.backgroundColor = SColors.Theme
        
        self.imgSlideShowHeight.constant = Utils.getHeightOfBanner(widthOffset: 70, ratio: "16:9")
        self.imgSlideShowBGViewHeight.constant = (self.imgSlideShowHeight.constant * 75) / 100
        
        self.imgSlideShow.backgroundColor = UIColor.clear
      

        //imgSlideShow.scrollOffset = 0.8
        imgSlideShow.type = .linear
        imgSlideShow.scrollSpeed = 0.8
        imgSlideShow.decelerationRate = 0.8
        self.imgSlideShow.delegate = self
        self.imgSlideShow.dataSource = self
        self.imgSlideShow.reloadData()
        
        if(self.imgSlideShow.currentItemIndex == 0 && self.bannersItemList.count > 1){
            self.imgSlideShow.contentOffset = CGSize(width: -15, height: 0)
        } else if self.bannersItemList.count == 1 {
            self.imgSlideShow.contentOffset = CGSize(width: 15, height: 0)
        }
        
        //self.imgSlideShow.contentScaleMode = .scaleToFill
        //self.imgSlideShow.setImageInputs(self.bannersItemList)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderImgTapped))
        self.imgSlideShow.addGestureRecognizer(recognizer)
        
        if(self.bannersItemList.count > 0){
            
            //self.scrollView.parallaxHeader.view = nil
            self.rduScrollView.parallaxHeader.view = nil
            if(self.currentMode != "SUB_MODE"){
                self.containerView.backgroundColor = UIColor.white
                self.rduScrollView.parallaxHeader.view = self.containerView
                self.rduScrollView.parallaxHeader.mode = .bottom
                self.rduScrollView.parallaxHeader.height = self.imgSlideShowHeight.constant + 50
                self.rduScrollView.parallaxHeader.minimumHeight = 50
                self.rduScrollView.parallaxHeader.delegate = self
            }else{
                self.containerView.backgroundColor = UIColor.clear
                self.scrollView.parallaxHeader.view = self.containerView
                self.scrollView.parallaxHeader.mode = .bottom
                self.scrollView.parallaxHeader.height = self.imgSlideShowHeight.constant + 50
                self.scrollView.parallaxHeader.minimumHeight = 50
                self.scrollView.parallaxHeader.delegate = self
            }
            
            self.containerView.frame.size = CGSize(width: self.view.frame.width, height: self.imgSlideShowHeight.constant + 50)
        }else{
            self.rduScrollView.parallaxHeader.view = nil
            if(self.currentMode != "SUB_MODE"){
                self.containerView.backgroundColor = UIColor.white
                self.rduScrollView.parallaxHeader.view = self.containerView
                self.rduScrollView.parallaxHeader.mode = .bottom
                self.rduScrollView.parallaxHeader.height = 50
                self.rduScrollView.parallaxHeader.minimumHeight = 50
                self.rduScrollView.parallaxHeader.delegate = self
            }else{
                self.containerView.backgroundColor = UIColor.clear
                self.scrollView.parallaxHeader.view = self.containerView
                self.scrollView.parallaxHeader.mode = .bottom
                self.scrollView.parallaxHeader.height = 50
                self.scrollView.parallaxHeader.minimumHeight = 50
                self.scrollView.parallaxHeader.delegate = self
            }
            
            self.containerView.frame.size = CGSize(width: self.view.frame.width, height: 50)
        }
        self.setApplicationStatusBar()
    }
    
   
    
    func loadServiceCategory(parentCategoryId:String, category :String = "", _ eForVideoConsultation:String = ""){
        
        if isFromLocation == false {
           self.contentView.alpha = 0
        }
        currentCategory = category
        selectedServiceParentID = parentCategoryId
        scrollView.isHidden = true
        scrollView.scrollToTop()
        
        self.isDataLoading = true
        if(parentCategoryId != "0"){
            
            var dataDicArray = [NSDictionary]()
            if(category.uppercased() == "BIDDING"){
                dataDicArray = GetServicesData.getInstance().servicesResponsecBidding
            }else if(eForVideoConsultation.uppercased() == "YES"){
                self.eForVideoConsultation = "Yes"
                dataDicArray = GetServicesData.getInstance().servicesResponseVideoCall
            }else{
                dataDicArray = GetServicesData.getInstance().servicesResponseUFX
            }
            if(dataDicArray.count > 0){
                for i in 0..<dataDicArray.count{
                    
                    let item = dataDicArray[i]
                    if(parentCategoryId == item.get("id") && item.get("response") != ""){
                      
                        self.serviceResponseHandling(response: item.get("response"), parentCategoryId)
                        return
                        
                    }
                }
            }
            
            self.setPlaceHolderView()
           
        }
        
        self.biddingID = ""
        
//        loaderView =  self.generalFunc.addMDloader(contentView: self.view)
//        loaderView.backgroundColor = UIColor.clear
        
        var parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId": parentCategoryId,"vLatitude": self.selectedLatitude, "vLongitude": self.selectedLongitude, "eForVideoConsultation":eForVideoConsultation]
        if category.uppercased() == "BIDDING"{
            parameters["eCatType"] = category
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
        
            if(self.isScreenKilled == true){
                return
            }
            
            if(response != ""){
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.isDataLoading = false
                    self.contentView.alpha = 1
                    self.removePlaceHolderView()
                    
                }, completion:{ _ in
                   
                })
                
                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true && ServiceModule.isDeliverAllOnly() && GeneralFunctions.isKeyExistInUserDefaults(key: "LOGED_IN_DELIVERALL")) {
                    
                    GeneralFunctions.removeValue(key: "LOGED_IN_DELIVERALL")
                    let items =  GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray
                    if items.count > 0
                    {
                        let cartUV = GeneralFunctions.instantiateViewController(pageName: "CartUV") as! CartUV
                        cartUV.isFromMenu = true
                        self.push(uv: cartUV)
                    }
                }
                
                let dataDict = response.toDict()
                if self.userProfileJson.get("isSmartLoginEnable").uppercased() == "YES" {
                if (GeneralFunctions.isKeyExistInUserDefaults(key: "IS_POPUP_SHOW") == false || GeneralFunctions.getValue(key: "IS_POPUP_SHOW") as! Bool == true){
                    if GeneralFunctions.isQuickLogInEnable(){
                        
                    }else{
                    GeneralFunctions.saveValue(key: "IS_POPUP_SHOW", value: false as AnyObject)
                    self.openSmartLogin()
                    }
                }
                }
                self.moreIconImage = dataDict.get("MORE_ICON")
                self.bannersItemList.removeAll()
    
                let msgArr = dataDict.arrOf("BANNER_DATA")
                
                for i in 0..<msgArr.count{
                    let tempItem = msgArr[i] as! NSDictionary
                
                    self.bannersItemList.append(tempItem)
                }
                if Configurations.isRTLMode() {
                    let count = self.bannersItemList.count
                    for i in 0..<count/2 {
                       (self.bannersItemList[i],self.bannersItemList[count - i - 1])  = (self.bannersItemList[count - i - 1],self.bannersItemList[i])
                    }
                   
                }
                //self.setBannerData()
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                    self.setBannerData22()
                    
                    
                }else{
                    if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                        self.setBannerData()
                    }else{
                        self.setBannerDataNewD()
                    }
                }
                
                self.setPageController()
                
                
                if(dataDict.get("Action") == "1"){
                    
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    if(parentCategoryId == "0"){
                        
                        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                            self.tableDataArrayFor22.removeAll()
                            self.tableDataArrayFor22 = dataDict.arrOf("HOME_SCREEN_DATA") as! [NSDictionary]
                            
                            self.tableView22.reloadData()
                            for i in 0..<self.tableDataArrayFor22.count{
                                let getItem = self.tableDataArrayFor22[i]
                                
                               
                                
                                if getItem.get("MedicalServiceSection").uppercased() == "YES" {
                                    self.moreDataForMedical = getItem.arrOf("MoreSubCategories") as! [NSDictionary]
                                    self.isMedicalServices = true
                                    if  self.lblServiceSlect != nil {
                                         self.lblServiceSlect.text = getItem.get("vCategoryTitle")
                                     }else{
                                         self.moreTitle = getItem.get("vCategoryTitle")
                                     }
                                    
                                    self.allIn1MedicalCollectionView.reloadData()
                                }
                            }
                            
                            
                            if(self.bannersItemList.count > 0){
                                
                                self.setnavBarTintColor(color: SColors.Theme)
                            }else{
                                self.setnavBarTintColor(color: SColors.Theme)
                            }
                            
                            
                        }
                      
                    }
                    
                    // Cache Sub CategoriesData
                    self.subServicesResponseHandling()
                    
                    if(self.currentMode == "SUB_MODE" && self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
                        return
                    }
                    
                    self.currentItems.removeAll()
                    if(parentCategoryId != "0"){
                        self.subCategoryItems.removeAll()
                    }
                    
                    var categoryItems = [NSDictionary] ()
                    
                    for i in 0..<msgArr.count{
                        categoryItems += [msgArr[i] as! NSDictionary]
                    }
                    
                    self.currentItems.append(contentsOf: categoryItems)
                    if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                        if self.loadMasterService == false {
                            self.loadMasterService = true
                        self.masterCateGory = dataDict.arrOf("MASTER_SERVICE_CATEGORIES") as! [NSDictionary]
                        }
                     }
                    
                    
                    if(parentCategoryId == "0"){
                        
                       // self.selectServiceLbl.backgroundColor = UIColor.white
                        self.contentView.backgroundColor = UIColor.white
                       // self.scrollView.contentInset = UIEdgeInsets(top: self.scrollView.contentInset.top, left: self.scrollView.contentInset.left, bottom: 50, right: self.scrollView.contentInset.right)
                        
                        self.parentCategoryItems.removeAll()
                        
                        self.parentCategoryItems.append(contentsOf: categoryItems)
                        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                        self.setParentMode()
                            self.selectServiceLbl.backgroundColor = UIColor.white
                        }else{
                            self.selectSerivcesSubLbl.backgroundColor = UIColor.white
                            self.setParentModeNewD()
                        }
                        //self.setParentMode()
                    }else{
                        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                            self.selectServiceLbl.backgroundColor = UIColor(hex: 0xf1f1f1)
                        }else{
                            self.selectSerivcesSubLbl.backgroundColor = UIColor(hex: 0xf1f1f1)
                        }
                       
                        self.serviceTitle22Lbl.text = dataDict.get("vParentCategoryName")
                        self.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
                        self.subCategoryItems.append(contentsOf: categoryItems)
                        
                        if(self.homeTabBar != nil && self.currentMode != "SUB_MODE" && self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
                            UIView.animate(withDuration: 0.3, animations: {
                                self.homeTabBar.tabbarHidden = true
                                self.adView?.isHidden = true
                                if(self.bannerView != nil){
                                    self.bannerView.isHidden = true
                                }
                                self.homeTabBar.bannerAd.zPosition = -1
                                
                                var frame = self.view.bounds;
                                frame.size.height = 500;
                                
                                self.view.frame = frame;
                            })
                        }
                        
                        self.eForVideoConsultation = eForVideoConsultation
                        self.setSubCategoryMode(vParentCategoryName: dataDict.get("vParentCategoryName"))
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
               // self.loadServiceCategory(parentCategoryId:parentCategoryId)
                
            }
            
           self.scrollView.isHidden = false
            
        })
    }
    
    func checkSelectedCategories(isFromSearch : Bool){
        if(self.selectedLatitude == "" || self.selectedLongitude == ""){
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
            return
        }
        
        if(self.currentMode == "SUB_MODE" || isFromSearch){
            var selectedServiceIds = ""
            var vParentCategoryName = ""
            for i in 0..<self.selectedCategoryIds.count{
                let tempDataDict = self.selectedCategoryIds[i]
                if(tempDataDict.get("IS_SELECTED") == "Yes"){
                    selectedServiceIds = (selectedServiceIds == "") ? tempDataDict.get("iVehicleCategoryId") : "\(selectedServiceIds),\(tempDataDict.get("iVehicleCategoryId"))"
                    
                    if(vParentCategoryName == ""){
                        vParentCategoryName = tempDataDict.get("vParentCategoryName")
                    }
                }
            }
            
            Utils.printLog(msgData: "selectedServiceIds::\(selectedServiceIds)")
            
            if(selectedServiceIds != ""){
                let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                mainScreenUv.ufxSelectedVehicleTypeId = selectedServiceIds
                mainScreenUv.eForVideoConsultation = self.eForVideoConsultation
                mainScreenUv.ufxSelectedVehicleTypeParentId = selectedServiceParentID
                mainScreenUv.ufxSelectedVehicleTypeName = vParentCategoryName
                mainScreenUv.ufxSelectedLatitude = self.selectedLatitude
                mainScreenUv.ufxSelectedLongitude = self.selectedLongitude
                mainScreenUv.ufxSelectedAddress = self.selectedAddress
                self.push(uv: mainScreenUv)
            }else{
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE_TXT"), uv: self)
                return
            }
        }
    }
    func checkBiddingData() {
        if(self.selectedLatitude == "" || self.selectedLongitude == ""){
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
            return
        }
        if self.biddingID == "" {
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE_TXT"), uv: self)
            return
        }else{
            let bidInfromationUV = GeneralFunctions.instantiateViewController(pageName: "BidInfromationUV") as! BidInfromationUV
            bidInfromationUV.bidCategory = self.currentCategoryName
            bidInfromationUV.bidID = self.biddingID
            self.push(uv: bidInfromationUV)
        }
    }
    
    func setSubCategoryMode(vParentCategoryName:String){
        
       // self.loadProviders(vCatID: <#T##String#>)
        
        viewArray.removeAll()
        self.currentCategoryName = ""
        self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
        self.serviceTitle22Lbl.layer.borderColor = UIColor.clear.cgColor
        
        self.anchorView.backgroundColor = UIColor(hex: 0xf9f9f9)
        self.anchorSubView.backgroundColor = SColors.Theme
        
        if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
            self.nextBtn.isHidden = false
        }
        
        SDImageCache.shared().clearMemory()
        self.currentMode = "SUB_MODE"
        //self.addTitleView()
        self.noServiceAvailLbl.isHidden = true
        
        rduView.isHidden = true
        self.scrollView.isHidden = false
        
        self.selectedCategoryIds.removeAll()

        self.scrollView.parallaxHeader.view = self.containerView
        self.scrollView.parallaxHeader.mode = .bottom
        self.scrollView.parallaxHeader.height = 50
        self.scrollView.parallaxHeader.minimumHeight = 50
        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
        
            self.addBack()
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                self.nextBtn.isHidden = false
                self.setBannerData22()
                
            }else{
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                    self.setBannerData()
                }else{
                    self.setBannerDataNewD()
                }
            }
            
            
        }else{
           
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                self.setBannerData22()
                
            }else{
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                    self.setBannerData()
                }else{
                    self.setBannerDataNewD()
                }
            }
            
        }
        
        self.view.layoutIfNeeded()
        
        for subview in self.ufxDataVerticalStackView.subviews {
            subview.removeFromSuperview()
        }
        
        self.scrollView.scrollToTop()
        
        
        //        self.ufxDataVerticalStackView.hidden = true
        
        if(self.currentItems.count == 0 && userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available in selected category.", key: "LBL_NO_SUB_SERVICE_AVAIL")
            self.noServiceAvailLbl.isHidden = false
        }else if(self.currentItems.count == 0){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available.", key: "LBL_NO_SERVICE_AVAIL")
            self.noServiceAvailLbl.isHidden = false
        }
        
        self.selectedCategoryIds.removeAll()
        
        let preSelectedIdsArray = self.preSelectedServiceIdsString.components(separatedBy: ",")
        for i in 0..<self.currentItems.count{
            
            let horizontalStackView = (generalFunc.loadView(nibName: "UfxCategoryHorizontalStackViewDesign", uv: self).subviews[0]) as! UIStackView
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution  = UIStackView.Distribution.fillEqually
            horizontalStackView.spacing = 5
            
            
            let parentGridView = self.generalFunc.loadView(nibName: "UfxSubCategoryDesignItem", uv: self)
            parentGridView.tag = i
            
            parentGridView.layer.shadowRadius = 0.9
            parentGridView.layer.shadowOpacity = 0.9
            parentGridView.layer.shadowOffset = CGSize.zero
            parentGridView.layer.shadowColor = UIColor.darkGray.cgColor
            parentGridView.layer.cornerRadius = 8
            parentGridView.clipsToBounds = true
            //            parentGridView.frame.size = CGSize(width: self.view.frame.width, height: 100)
            
            //            (parentGridView.subviews[2] as! UIImageView).image = arrowImg!.imageRotatedByDegrees(270,flip: false)
            
            parentGridView.isUserInteractionEnabled = true
//            let parentTapGue = UITapGestureRecognizer()
//            parentTapGue.addTarget(self, action: #selector(self.itemTapped(sender:)))
//            parentGridView.addGestureRecognizer(parentTapGue)
            viewArray.append(parentGridView)
            let item = self.currentItems[i]
            
            //            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            //            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[2] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            
            
            let selectedDataDict = NSMutableDictionary()
            selectedDataDict["iVehicleCategoryId"] = item.get("iVehicleCategoryId")
            selectedDataDict["vParentCategoryName"] = vParentCategoryName
            
            if  item.get("eCatType").uppercased() == "BIDDING" {
                
            }else{
            if(preSelectedIdsArray.contains(item.get("iVehicleCategoryId"))){
                selectedDataDict["IS_SELECTED"] = "Yes"
            }else{
                selectedDataDict["IS_SELECTED"] = "No"
            }
            selectedCategoryIds += [selectedDataDict]
            }
            
            if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                
                let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                
                if(IS_SELECTED == "Yes"){
                    (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_liveTrackTrue")
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: UIColor.white)
                    (parentGridView.subviews[5]).backgroundColor = SColors.Theme
                    (parentGridView.subviews[1] as! UILabel).textColor = SColors.Theme
                    
                }else{
                    (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_add_plus")
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.Theme)
                    (parentGridView.subviews[5]).backgroundColor = UIColor.white
                    (parentGridView.subviews[1] as! UILabel).textColor = UIColor.black
                }
            }
            
            (parentGridView.subviews[1] as! UILabel).text = item.get("vCategory")
            
            
            print(item.get("vLogo_image"))
            (parentGridView.subviews[0] as! UIImageView).sd_setImage(with: URL(string: item.get("vLogo_image")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                (parentGridView.subviews[2]).isHidden = true
                //(parentGridView.subviews[4]).isHidden = false
                (parentGridView.subviews[4]).isHidden = true
                
                (parentGridView.subviews[4] as! BEMCheckBox).createSysBox()
                
                (parentGridView.subviews[4] as! BEMCheckBox).isUserInteractionEnabled = false
                
                (parentGridView.subviews[5]).borderColor = SColors.Theme
                   
                if  (item.get("eCatType").uppercased() == "BIDDING") {
                    (parentGridView.subviews[5]).isHidden = true
                    (parentGridView.subviews[4]).isHidden = true
                    (parentGridView.subviews[6]).isHidden = false
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[6])) as! UIImageView), color: SColors.Theme)
                    parentGridView.handleClick { (instance) in
                        self.currentCategoryName = item.get("vCategory")
                        self.setApplicationStatusBar()
                        if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                            self.biddingID = item.get("iBiddingId")
                            self.handleBiddingCategory()
                        }else{
                            self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                        }
                    }
                    
                    
                }else{
                    if(self.eForVideoConsultation.uppercased() == "YES"){
                        (parentGridView.subviews[5]).isHidden = true
                        (parentGridView.subviews[4]).isHidden = true
                        (parentGridView.subviews[6]).isHidden = false
                        GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[6])) as! UIImageView), color: SColors.Theme)
                    }
                parentGridView.handleClick { (instance) in
                    self.setApplicationStatusBar()
                    
                    if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                        let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                        
                        if(self.eForVideoConsultation.uppercased() == "YES"){
                            
                            let item = self.currentItems[parentGridView.tag]
                            let viewTemp = self.viewArray[parentGridView.tag]
                            ((viewTemp.subviews[6]) as! UIImageView).image = UIImage(named:"ic_select_true")
                            GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)
                            (viewTemp.subviews[5]).backgroundColor = SColors.Theme
                            //self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                            (viewTemp.subviews[1] as! UILabel).textColor = SColors.Theme
                            
                            self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                            
                            for i in 0..<self.currentItems.count{
                                let item = self.currentItems[i]
                                let viewTemp = self.viewArray[i]
                                
                                if i != parentGridView.tag{
                                    ((viewTemp.subviews[6])as! UIImageView).image = UIImage(named:"ic_select_false")
                                    GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)

                                    (viewTemp.subviews[5]).backgroundColor = UIColor.white
                                    (viewTemp.subviews[1] as! UILabel).textColor = UIColor.black
                                    
                                    self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "No")
                                    
                                }
                            }
                        }else{
                            if(IS_SELECTED == "No"){
                                (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_liveTrackTrue")
                                GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: UIColor.white)
                                (parentGridView.subviews[5]).backgroundColor = SColors.Theme
                                self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                                (parentGridView.subviews[1] as! UILabel).textColor = SColors.Theme
                                
                            }else{
                                (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_add_plus")
                                GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.Theme)
                                (parentGridView.subviews[5]).backgroundColor = UIColor.white
                                self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "No")
                                (parentGridView.subviews[1] as! UILabel).textColor = UIColor.black
                            }
                        }
                        
                    }else{
                        self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                    }
                }
                }
            }else{
                self.itemTapped(catView: parentGridView, position: parentGridView.tag)
            }
            
            
            if(Configurations.isRTLMode()){
                (parentGridView.subviews[2] as! UIImageView).transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[2] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            
            horizontalStackView.addArrangedSubview(parentGridView)
            
            if(i == (self.currentItems.count - 1)){
                (parentGridView.subviews[3]).isHidden = true
            }
            
            self.ufxDataVerticalStackView.addArrangedSubview(horizontalStackView)
        }
        self.scrollView.scrollToTop()
        
        self.ufxDataVerticalStackViewHeight.constant = CGFloat(self.ufxDataVerticalStackView.subviews.count * 110)
        
        if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
            if(self.view.safeAreaInsets.bottom > 0){
                nextBtnBottomSpace.constant = 25
            }else{
                nextBtnBottomSpace.constant = 40
            }
        }else{
            self.nextBtn.isHidden = true
            nextBtnBottomSpace.constant = -75
        }
        
        var extraScrollHeight = 0.0
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            self.nextBtn.isHidden = false
            extraScrollHeight = extraScrollHeight + 65.0
        }
        //self.scrollView.backgroundColor = UIColor.red
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.ufxDataVerticalStackViewHeight.constant + 10 + CGFloat(extraScrollHeight))
        
        if #available(iOS 15.0, *) {
            
            if !self.isFrameSet {
                self.isFrameSet = true
            self.cntView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.cntView.frame.height - self.homeTabBar.kBarHeight)
            }
        }
        
       self.setApplicationStatusBar()
        
    }
    
    func getValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String) -> String{
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                return tempDataDict.get(keyOfValue)
            }
        }
        
        return ""
    }
    
    func setValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String, _ value:String){
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                self.selectedCategoryIds[i][keyOfValue] = value
                break
            }
        }
    }
    
    
    func setParentMode(){
        
        self.selectedServiceParentID = "0"
        if(self.homeTabBar != nil){
            self.homeTabBar.navItem.leftBarButtonItem = nil
        }
        
        //self.scrollViewBottomSpace.constant = 0
        self.nextBtn.isHidden = true
        
        SDImageCache.shared().clearMemory()
        self.currentMode = "PARENT_MODE"
        //self.addTitleView()
        self.noServiceAvailLbl.isHidden = true
        
        self.ufxDataVerticalStackView.isHidden = false
        
        self.selectServiceLbl.layer.shadowOpacity = 0.0;
        self.selectServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RDU_SERVICES_TITLE")
        
        if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
            
//            if(self.currentMode != "SUB_MODE" || userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
//                self.setBannerData()
//            }
            //self.setBannerData()
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                self.setBannerData()
            }else{
                self.setBannerDataNewD()
            }
            
           // self.addMenu()
        }
        
        for subview in self.ufxDataVerticalStackView.subviews {
            subview.removeFromSuperview()
        }
        
        self.scrollView.scrollToTop()
        
        if(self.currentItems.count == 0 ){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available.", key: "LBL_NO_SERVICE_AVAIL")
            self.noServiceAvailLbl.isHidden = false
        }
        
        if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
            self.noServiceAvailLbl.isHidden = true
            rduView.isHidden = false
            self.scrollView.isHidden = true
            
            let GRID_TILES_MAX_COUNT = GeneralFunctions.parseInt(origValue: 1, data: self.userProfileJson.get("GRID_TILES_MAX_COUNT"))
            
            listOfParentGridCategories.removeAll()
            listOfParentListCategories.removeAll()
            listOfParentAllCategories.removeAll()
            listItemArray.removeAll()
            
            var listTotalHeight:CGFloat = 0.0
            var listCount = 0
            var gridCount = 0
            var moreAvailable = false
            var nextGridIconsItems = [NSDictionary]()
            
            for i in 0..<self.currentItems.count{
                let item = self.currentItems[i]
                
                let typeArray = item.get("eCatViewType").components(separatedBy: ",")
                if(self.userProfileJson.get("APP_HOME_PAGE_LIST_VIEW_ENABLED").uppercased() == "YES"){
                    
                    if(typeArray.contains("Icon")){
                        if(gridCount < GRID_TILES_MAX_COUNT){
                            listOfParentGridCategories.append(item)
                        }else{
                            nextGridIconsItems.append(item)
                            moreAvailable = true
                        }
                        gridCount = gridCount + 1
                        
                    }
                    
                    if(typeArray.contains("Banner") || typeArray.contains("List")){
                        
                        if(typeArray.contains("List")){
                            listItemArray.append(item)
                            listCount = listCount + 1
                            
                            var height = item.get("tListDescription").height(withConstrainedWidth: Application.screenSize.width - 105, font: UIFont.init(name: Fonts().light, size: 14)!) + 23 + item.get("vCategory").height(withConstrainedWidth: Application.screenSize.width - 105, font: UIFont.init(name: Fonts().semibold, size: 16)!)
                            
                            if(height < 90){
                                height = 90
                            }
                            
                            listTotalHeight = listTotalHeight + height
                            
                        }
                        
                        if(typeArray.contains("Banner")){
                            listOfParentListCategories.append(item)
                        }
                        
                    }
                    
                    
                }else{
                    
                    if(item.get("eShowType").uppercased() == "ICON" || item.get("eShowType").uppercased() == "ICON-BANNER"){
                        
                        if(gridCount < GRID_TILES_MAX_COUNT){
                            listOfParentGridCategories.append(item)
                        }else{
                            nextGridIconsItems.append(item)
                            moreAvailable = true
                        }
                        gridCount = gridCount + 1
                        
                        if(item.get("eShowType").uppercased() == "ICON-BANNER"){
                            listOfParentListCategories.append(item)
                        }
                    }else{
                        listOfParentListCategories.append(item)
                    }
                }
                
                //if(!typeArray.contains("List")){f
                    listOfParentAllCategories.append(item)
                //}
                
            }
            

            print(listOfParentListCategories.count)
            //listOfParentListCategories = listItemArray + listOfParentListCategories
            //listOfParentAllCategories = listOfParentAllCategories
            
            if(self.listOfParentGridCategories.count == 0){
                            if self.rduTableViewTopSpace != nil {
                            self.rduTableViewTopSpace.constant = 0
                            }
            }
            
            if(moreAvailable){
                let moreCategory = NSMutableDictionary()
                moreCategory["eCatType"] = "More"
                moreCategory["vLogo_image"] = self.moreIconImage
                moreCategory["vCategory"] = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")
                listOfParentGridCategories.append(moreCategory)
            }
            
            let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9") + 10
            
            var totalGridItems = gridCount > GRID_TILES_MAX_COUNT ? GRID_TILES_MAX_COUNT : gridCount
            
            if(gridCount > GRID_TILES_MAX_COUNT || moreAvailable){
                totalGridItems = totalGridItems + 1
            }
            let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
            
            var numOfRow:Double = Double(totalGridItems)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(totalGridItems)/Double(totalItemInRow)
            numOfRow = numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0)
            
            if(numOfRow.truncatingRemainder(dividingBy: Double(totalGridItems)) != 0){
                var numberOfRemainsItemsInRow = (totalItemInRow * Int(numOfRow)) - totalGridItems
                let numberOfRemainsItemsInRowOrig = (totalItemInRow * Int(numOfRow)) - totalGridItems
                
                var itemOfMore:NSDictionary!
                if(moreAvailable){
                    itemOfMore = listOfParentGridCategories[listOfParentGridCategories.count - 1]
                    
                    listOfParentGridCategories.remove(at: listOfParentGridCategories.count - 1)
                }
                
                var countOfRemains = 0
                while(numberOfRemainsItemsInRow > 0){
                    if(countOfRemains < nextGridIconsItems.count){
                        listOfParentGridCategories.append(nextGridIconsItems[countOfRemains])
                        numberOfRemainsItemsInRow = numberOfRemainsItemsInRow - 1
                        countOfRemains = countOfRemains + 1
                    }else{
                        numberOfRemainsItemsInRow = 0
                    }
                }
                
                if(itemOfMore != nil && numberOfRemainsItemsInRowOrig < nextGridIconsItems.count){
                    listOfParentGridCategories.append(itemOfMore)
                }
            }
            
            if(listOfParentListCategories.count == 0 || self.listOfParentGridCategories.count == 0){
                self.rduSeperatorView.isHidden = true
            }
            if(self.listOfParentGridCategories.count == 0){
                numOfRow = 0
            }
            
            self.rduCollectionViewHeight.constant = (CGFloat(numOfRow) * CGFloat(120))
            
            let count = listOfParentListCategories.count + listItemArray.count
            self.rduContentViewHeight.constant = (height * CGFloat(count)) + self.rduCollectionViewHeight.constant + (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom) + 20 : 50)
            
            self.rduContentViewHeight.constant = self.rduContentViewHeight.constant - (CGFloat(listCount) * height) + listTotalHeight
            
//            if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes") {
//            self.rduScrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.rduContentViewHeight.constant + 20)
//            }else {
//                self.rduScrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.rduContentViewHeight.constant )
//            }
            self.rduScrollView.scrollToTop()
            self.rduTableView.reloadData()
            self.rduCollectionView.reloadData()
            
            self.rduScrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom - 15) : 20), right: 0)

        }else{
            rduView.isHidden = true
            self.scrollView.isHidden = false
            
            let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
            //            let numOfRow = Int(((Double(self.currentItems.count) / Double(totalItemInRow)) < 1.0 ? 1.0 : (Double(self.currentItems.count) / Double(totalItemInRow))).roundTo(places: 0))
            
            let numOfRow:Double = Double(self.currentItems.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(self.currentItems.count)/Double(totalItemInRow)
            let numOfRow_int = Int(numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0))
            
            var currentIndex = 0
            var horizontalStackViewHeight:CGFloat = 0.0
            for _ in 0 ..< numOfRow_int{
                
                let horizontalStackView = (generalFunc.loadView(nibName: "UfxCategoryHorizontalStackViewDesign", uv: self).subviews[0]) as! UIStackView
                horizontalStackView.axis = .horizontal
                horizontalStackView.distribution  = UIStackView.Distribution.fillEqually
                horizontalStackView.spacing = 5
                
                for _ in 0 ..< totalItemInRow{
                    
                    if(currentIndex < self.currentItems.count){
                        
                        let parentGridView = self.generalFunc.loadView(nibName: "UFXJekIconCVC", uv: self) //UfxParentCategoryItemDesign
                        
                        parentGridView.tag = currentIndex
                        
                        //                        let parentTapGue = UITapGestureRecognizer()
                        //                        parentTapGue.addTarget(self, action: #selector(self.itemTapped(sender:)))
                        //                        parentGridView.addGestureRecognizer(parentTapGue)
                        
                        parentGridView.handleClick { (instance) in
                            self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                        }
                        
                        horizontalStackView.addArrangedSubview(parentGridView)
                        
                        //                        if(j == totalItemInRow - 1 || (currentIndex == (self.currentItems.count - 1))){
                        //                            (parentGridView.subviews[2]).isHidden = true
                        //                        }
                        //
                        //                        if(i == numOfRow - 1){ // && (currentIndex != (self.currentItems.count - 1))
                        //                            (parentGridView.subviews[3]).isHidden = true
                        //                        }
                        
                        let item = self.currentItems[currentIndex]
                        (parentGridView.subviews[0].subviews[1] as! MyLabel).text = item.get("vCategory")
                        
                        if(item.get("vCategory").contains(find: " ")){
                            (parentGridView.subviews[0].subviews[1] as! MyLabel).numberOfLines = 2
                        }else{
                            (parentGridView.subviews[0].subviews[1] as! MyLabel).numberOfLines = 1
                        }
                        
                        (parentGridView.subviews[0].subviews[1] as! MyLabel).textColor = UIColor(hex: 0x605F5F)
                        
                        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
                        
                        (parentGridView.subviews[0].subviews[0].subviews[0] as! UIImageView).sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                        })
                        
                        parentGridView.subviews[0].subviews[0].layer.borderColor = UIColor(hex: 0xe4e4e4).cgColor
                        parentGridView.subviews[0].subviews[0].layer.borderWidth = 1
                        parentGridView.subviews[0].subviews[0].layer.masksToBounds = true
                        parentGridView.subviews[0].subviews[0].layer.cornerRadius = 15
                        
                    }else{
                        
                        let view = UIView()
                        view.backgroundColor = UIColor.clear
                        horizontalStackView.addArrangedSubview(view)
                        
                    }
                    currentIndex = currentIndex + 1
                    
                }
                horizontalStackViewHeight = horizontalStackViewHeight + horizontalStackView.frame.size.height - 5
                self.ufxDataVerticalStackView.addArrangedSubview(horizontalStackView)
                
            }
            ufxDataVerticalStackView.spacing = 0
            self.ufxDataVerticalStackView.frame.size = CGSize(width: self.view.frame.width, height: horizontalStackViewHeight)
            
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: horizontalStackViewHeight)
            
        }
        
        
        
    }
    
    @objc func itemTapped(catView:UIView, position:Int){
        if(position >=  self.currentItems.count){
            return
        }
        if(loaderView != nil && loaderView.isHidden == false){
            return
        }
      
        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE"){
            self.selectServiceLbl.text = self.currentItems[position].get("vCategory")
            self.serviceTitle22Lbl.text = self.currentItems[position].get("vCategory")
            
            UIView.animate(withDuration: 0.1, animations: {
                catView.transform = .init(scaleX: 0.85, y: 0.85)
            }) { (_) in
                
                UIView.animate(withDuration: 0.1, animations: {
                    catView.transform = .identity
                }) { (_) in
                    self.loadServiceCategory(parentCategoryId: self.currentItems[position].get("iVehicleCategoryId"))
                }
//                self.loadServiceCategory(parentCategoryId: self.currentItems[sender.view!.tag].get("iVehicleCategoryId"))
            }
            
        }else if(self.currentMode == "SUB_MODE" || userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
            
            if(self.selectedLatitude == "" || self.selectedLongitude == ""){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
                return
            }
            
            checkSelectedCategory(iVehicleCategoryId: self.currentItems[position].get("iVehicleCategoryId"), position: position , categoryName: self.currentItems[position].get("vCategory"))
            
            return
        }
    }
    
    func checkSelectedCategory(iVehicleCategoryId: String, position:Int , categoryName: String){
        
        let parameters = ["type":"getServiceCategoryTypes","userId": GeneralFunctions.getMemberd(), "iVehicleCategoryId": iVehicleCategoryId, "UserType": Utils.appUserType, "vLatitude": self.selectedLatitude, "vLongitude": self.selectedLongitude, "eCheck": "Yes"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let ufxSelectServiceUV = GeneralFunctions.instantiateViewController(pageName: "UFXServiceSelectUV") as! UFXServiceSelectUV
                    ufxSelectServiceUV.dataDict = self.currentItems[position]
                    ufxSelectServiceUV.selectedLatitude = self.selectedLatitude
                    ufxSelectServiceUV.selectedLongitude = self.selectedLongitude
                    ufxSelectServiceUV.selectedAddress = self.selectedAddress
                    self.push(uv: ufxSelectServiceUV)
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    @objc func loadParentMode(){
        //self.selectServiceLbl.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.preSelectedServiceIdsString = ""
        self.currentItems.removeAll()
        self.currentItems.append(contentsOf: parentCategoryItems)
        isFrameSet = false
        self.contentView.alpha = 0
        if(self.homeTabBar != nil){
            
            UIView.animate(withDuration: 0.3, animations: {
                self.homeTabBar.tabbarHidden = false
                self.adView?.isHidden = false
                if(self.bannerView != nil){
                    self.bannerView.isHidden = false
                }
                self.homeTabBar.bannerAd.zPosition = 1
                self.contentView.alpha = 1
            })
        }
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
        self.selectServiceLbl.backgroundColor = UIColor.white
            setParentMode()
        }else{
            setParentModeNewD()
        }
        
        if #available(iOS 15.0, *) {
            self.cntView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.cntView.frame.height + self.homeTabBar.kBarHeight)
        }
        
        
    }
    
    func openPlaceFinder(){
        let launchPlaceFinder = LaunchPlaceFinder(viewControllerUV: self)
        launchPlaceFinder.currInst = launchPlaceFinder
        launchPlaceFinder.isFromUfxHome = true

        if(currentLocation != nil){
            launchPlaceFinder.setBiasLocation(sourceLocationPlaceLatitude: currentLocation.coordinate.latitude, sourceLocationPlaceLongitude: currentLocation.coordinate.longitude)
        }
        
        launchPlaceFinder.initializeFinder { (address, latitude, longitude) in
            
            if(self.currentLocation != nil){
                self.selectedLatitude = "\(latitude)"
                self.selectedLongitude = "\(longitude)"
                self.selectedAddress = address
                self.enterLocLbl.text = address
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                    self.locationLbl.text = address
                }
               
                if(self.currentMode != "SUB_MODE") {
                    self.isFromLocation = true
                    self.loadServiceCategory(parentCategoryId: self.userProfileJson.get("UBERX_PARENT_CAT_ID"))
                }else{
                    
                    self.imageProfileView.isHidden = true
                    self.isFromLocation = true
                    if self.currentCategory.uppercased() == "BIDDING" {
                        //self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID)
                        self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID, category: "Bidding")
                    }else{
                        if(self.eForVideoConsultation.uppercased() == "YES") {
                            self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID, "Yes")
                        }else{
                    self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID)
                        }
                    }
                }
                
            }else{
                self.onLocationUpdate(location: CLLocation(latitude: latitude, longitude: longitude))
            }
        }
    }
    
    
    func onLocationUpdate(location: CLLocation) {
        
        self.currentLocation = location
        
        if(getLocation != nil){
            getLocation.releaseLocationTask()
        }
        
        checkLocationEnabled()
        if(getAddressFrmLocation == nil){
            getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
            getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
            getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow:false)
        }
        
        GetServicesData.getInstance().getCategoriesDataForDeliverAll(lat: "\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)", address: "")
    }
    
    func onAddressFound(address: String, location: CLLocation, isPickUpMode: Bool, dataResult: String) {
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
        self.selectedAddress = address
        
        GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
        
        if self.selectedAddress != ""{
            
            self.isFromLocation = true
           loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
        }
        if(self.enterLocLbl != nil){
            self.enterLocLbl.text = address
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                self.locationLbl.text = address
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            return self.tableDataArrayFor22.count
        }else{
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                return listOfParentListCategories.count + listItemArray.count
            }else{

                return bannerArray.count + listArray.count
            }
        }
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       // return 1
        
         if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
             if isMedicalServices {
                 return self.moreDataForMedical.count//self.moreDataFor22.count
             }else{
                 return 1
             }
             
         }else{
             return 1
         }
             
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
            
        if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
            return self.moreDataFor22.count
        }else{
            return self.listOfParentGridCategories.count
        }
        }else{
            //Ui New Deisgn Chnages
            if (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
                if isMedicalServices {
                    return self.moreDataForMedical[section].arrOf("Services").count
                }else{
                return self.moreDataFor22.count
                }
            }
            else if collectionView == serviceCollectionView {
            if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
              
        
                return listOfParentListCategories.count
                
            }else{
                
                return iconArray.count
                
              
                
            }}
            else{
                return self.masterCateGory.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
             if (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
                 if isMedicalServices {
                
                    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryHeaderCVCell", for: indexPath) as? CategoryHeaderCVCell
                    sectionHeader?.sectionTitleLbl.text = self.moreDataForMedical[indexPath.section].get("vTitle")
                    sectionHeader?.sectionTitleLbl.isHidden = false
                             
                     if(self.isAllIn1Medical){
                         sectionHeader?.contentView.backgroundColor = UIColor.clear
                     }else{
                         sectionHeader?.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
                     }
            
                     return sectionHeader!
                  }else{
                     return UICollectionReusableView()
                  }
             }else{
                 return UICollectionReusableView()
             }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
            if isMedicalServices {
                return CGSize(width: collectionView.frame.size.width - 20, height:40)
            }else{
                return CGSize(width: 0, height:0)
            }
        }else{
            return CGSize(width: 0, height:0)
        }
    }
    
    func setGridData(dataArray:[NSDictionary]) -> ([NSDictionary], Double) {
            
            
            var gridCount = 0
            
            var moreAvailable = false
            var listOfParentGridCategories22 = [NSDictionary]()
            var nextGridIconsItems = [NSDictionary]()
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            let GRID_TILES_MAX_COUNT = GeneralFunctions.parseInt(origValue: 1, data: userProfileJson.get("GRID_TILES_MAX_COUNT"))
            
            for i in 0..<dataArray.count{
                let item = dataArray[i]
                
                if(gridCount < GRID_TILES_MAX_COUNT - 1){
                    listOfParentGridCategories22.append(item)
                }else{
                    nextGridIconsItems.append(item)
                    moreAvailable = true
                }
                gridCount = gridCount + 1
            }
            
            if(moreAvailable){
                let moreCategory = NSMutableDictionary()
                moreCategory["eCatType"] = "More"
                moreCategory["vLogo_image"] = self.moreIconImage
                moreCategory["vCategory"] = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")
                listOfParentGridCategories22.append(moreCategory)
            }
            
            var totalGridItems = gridCount > GRID_TILES_MAX_COUNT ? GRID_TILES_MAX_COUNT : gridCount
            
            if(gridCount > GRID_TILES_MAX_COUNT || moreAvailable){
                totalGridItems = totalGridItems + 1
            }
            let totalItemInRow = Int(Application.screenSize.width / 100) < 4 ? 4 : Int(Application.screenSize.width / 100)
            
            var numOfRow:Double = Double(totalGridItems)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(totalGridItems)/Double(totalItemInRow)
            numOfRow = numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0)
            
            if(numOfRow.truncatingRemainder(dividingBy: Double(totalGridItems)) != 0){
                var numberOfRemainsItemsInRow = (totalItemInRow * Int(numOfRow)) - totalGridItems
                let numberOfRemainsItemsInRowOrig = (totalItemInRow * Int(numOfRow)) - totalGridItems
                
                var itemOfMore:NSDictionary!
                if(moreAvailable){
                    itemOfMore = listOfParentGridCategories22[listOfParentGridCategories22.count - 1]
                    
                    listOfParentGridCategories22.remove(at: listOfParentGridCategories22.count - 1)
                }
                
                var countOfRemains = 0
                while(numberOfRemainsItemsInRow > 0){
                    if(countOfRemains < nextGridIconsItems.count){
                        listOfParentGridCategories22.append(nextGridIconsItems[countOfRemains])
                        numberOfRemainsItemsInRow = numberOfRemainsItemsInRow - 1
                        countOfRemains = countOfRemains + 1
                    }else{
                        numberOfRemainsItemsInRow = 0
                    }
                }
                
                if(itemOfMore != nil && numberOfRemainsItemsInRowOrig < nextGridIconsItems.count){
                    listOfParentGridCategories22.append(itemOfMore)
                }
            }
            
            
            return (listOfParentGridCategories22, (CGFloat(numOfRow) * CGFloat(120)))
        
            
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
//        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont.init(name: Fonts().bold, size: 15)
//        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
//        (view as! UITableViewHeaderFooterView).textLabel?.frame.origin.x = -10
//
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = MyLabel()
        myLabel.frame = CGRect(x: 15, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.init(name: Fonts().bold, size: 15)
        myLabel.fontFamilyWeight = "Bold"
        myLabel.setFontFamily()
        myLabel.textColor = UIColor.black
        let headerView = UIView()
        headerView.addSubview(myLabel)

        if(self.listItemArray.count > 0 && self.listOfParentGridCategories.count != 0){
            myLabel.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_SERVICES")
        }else{
            
            myLabel.text = ""
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(self.listItemArray.count > 0 && self.listOfParentGridCategories.count != 0){
            return 40
        }else{
            
            return CGFloat.leastNonzeroMagnitude
        }
            
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            
            
            
            var item : NSDictionary!
            item = self.tableDataArrayFor22[indexPath.row]
            
            if(item.get("eShowType") == "Header"){
                return 48
            }else if(item.get("eShowType") == "List"){
                return 175
            }else if(item.get("eShowType") == "Grid"){
                
                
                return self.setGridData(dataArray: item.arrOf("SubCategories") as! [NSDictionary]).1
                
            }else if(item.get("eShowType") == "Banner"){
                
                if(item.get("ePromoteBanner").uppercased() == "YES"){
                    return Utils.getHeightOfBanner(widthOffset: 30, ratio: "", 2.9) + 20
                }else{
                    return Utils.getHeightOfBanner(widthOffset: 30, ratio: "", 2.20) + 20
                }
            }else if(item.get("eShowType") == "Icon"){
                return 175
            }else if(item.get("eShowType") == "Button"){
                return 70
            }else if(item.get("eShowType") == "CubeXList"){
                
                var width = 125.0
                width = Application.screenSize.width - ((Application.screenSize.width * 0.20) + 40)
      
                return ((((width / 2) - 25) + 40) * 2) + (UIDevice.current.userInterfaceIdiom == .pad ? 120 : 60)
            }else if(item.get("eShowType") == "Service_Icon"){
                
                return ((Application.screenSize.width - 30) / 3) + 15
                
            }else if(item.get("eShowType") == "Service_List"){
               
                var height = item.get("tListDescription").height(withConstrainedWidth: Application.screenSize.width - 120, font: UIFont.init(name: Fonts().light, size: 14)!) + 23 + item.get("vCategory").height(withConstrainedWidth: Application.screenSize.width - 120, font: UIFont.init(name: Fonts().semibold, size: 16)!)
            
                if(height < 80){
                    height = 80
                }
                if(self.listItemArray.count - 1 == indexPath.row){
                    height = height + 5
                }
                return height + 40
            }
            
        }else{
            //let typeArray = item.get("eCatViewType").components(separatedBy: ",")
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
            if(indexPath.row < self.listItemArray.count){
                
                let item = self.listItemArray[indexPath.row]
                
                var height = item.get("tListDescription").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont.init(name: Fonts().light, size: 14)!) + 23 + item.get("vCategory").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont.init(name: Fonts().semibold, size: 16)!)
            
                if(height < 80){
                    height = 80
                }
                if(self.listItemArray.count - 1 == indexPath.row){
                    height = height + 5
                }
                return height
                
            }else{
                let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")
                return height + 10
            }
            }else{

                if(indexPath.row < listArray.count){
                    
                    return CGFloat(LIST_TABLE_CELL_HIGHT)
                    
                }else {
                    if listArray.count == 0 {
                let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")
                return height
                    }else{
                        let height = Utils.getHeightOfBanner(widthOffset: 10, ratio: "16:9")
                        return height
                    }
                }
            }
        }
        
        return 0
        
    }
    
    func getWidthOfItem() -> CGFloat{
        let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
        return (Application.screenSize.width / CGFloat(totalItemInRow)) - 10
    }
    func getWidthOfItemNew() -> CGFloat{
        let totalItemInRow = Int(self.view.frame.width / 100) < 3 ? 3 : Int(self.view.frame.width / 100)
        return (Application.screenSize.width / CGFloat(totalItemInRow)) - 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
        return CGSize(width: getWidthOfItem(), height: 115)
        }else {
            // display category collection view
            if collectionView == serviceCollectionView {

                return CGSize(width: getWidthOfItem(), height: 115)
            }else if (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
                if isMedicalServices {
                if self.moreDataForMedical[indexPath.section].get("GridView").uppercased() == "YES" {
                    return CGSize(width: (Application.screenSize.width / 2) - 10, height: 185)
                }else{
                return CGSize(width: getWidthOfItemNew() , height: 125)
                }
                }else{
                    return CGSize(width: getWidthOfItemNew() , height: 125)
                }
            }
            else{
                if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S || UIDevice().type == .iPhoneSE ){
                    return CGSize(width: 90, height: 110)//CGSize(width: getWidthOfItem3(), height: 140)
                }else {
                    if isIpad != true {
           return  CGSize(width: 110, height: 120)//CGSize(width: 110, height: 120)//CGSize(width: getWidthOfItem3(), height: 140)//CGSize(width: getWidthOfItem3(), height: 140)
                    }else{
                        return  CGSize(width: 170, height: 170)
                    }
            }
        }
    }
    }
    
    var grayBGApplied = false
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
            
            var item : NSDictionary!
            item = self.tableDataArrayFor22[indexPath.row]
            
            if(item.get("eShowType") == "Header"){
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22HeaderTVCell", for: indexPath) as! Table22HeaderTVCell
                
                cell.anchorViewWidth.constant = 0
                cell.titleLblLeadingSpace.constant = 10
                
                cell.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
                cell.anchorSubView.backgroundColor = SColors.Theme
                cell.titleLbl.text = item.get("vTitle")
                cell.lblTitley.constant = 12
                //cell.titleLbl.textColor = UIColor.init(hexString: item.get("vTextColor"))
                if(item.get("vBgColor") != ""){
                    cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                    cell.backgroundColor = UIColor.clear
                }
            
                return cell
            }else if(item.get("eShowType") == "Grid"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22GridTVCell") as! Table22GridTVCell
                
                cell.dataArray = self.setGridData(dataArray: item.arrOf("SubCategories") as! [NSDictionary]).0
                cell.listOfParentGridCategories = item.arrOf("SubCategories") as! [NSDictionary]
                cell.uv = self
                cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                cell.isVideoSection = item.get("VideoConsultSection")
                cell.gridCollectionView.reloadData()
                return cell
                
            }else if(item.get("eShowType") == "List"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22ServicesTVCell") as! Table22ServicesTVCell
            
                
                cell.isVideoSection = item.get("VideoConsultSection")
                cell.dataArray = item.arrOf("SubCategories") as! [NSDictionary]
                cell.getItem = item
                cell.listOfCount = GeneralFunctions.parseInt(origValue: 0, data: item.get("ListMaxCount"))
                cell.moreServiceImg = self.moreIconImage
                
              
                if(Configurations.isRTLMode()){
                Utils.delayWithSeconds(0.2) {
                cell.servicesCollectionView.reloadData()
                }
                }else{
                    cell.servicesCollectionView.reloadData()
                }
                cell.uv = self
                
                cell.serviceCntView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                cell.serviceNameTitleLbl.text = item.get("vCategoryName").uppercased()
                cell.serviceNameTitleLbl.textColor = UIColor.init(hexString: item.get("vTextColor"))
                
                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vIconImage"), width: Utils.getValueInPixel(value: 70) , height: Utils.getValueInPixel(value: 70))
                cell.serviceImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
                return cell
                
            }else if(item.get("eShowType") == "Banner"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22BannerTVCell") as! Table22BannerTVCell
                
                cell.bannerTopView.backgroundColor = UIColor.init(hexString: item.get("vBannerBgColor"), alpha: 1)
                cell.bannerTitleLbl.textColor = UIColor.white
                cell.arrowImgView.image = UIImage(named:"ic_banner_right")?.addImagePadding(x: 50, y: 50)
                cell.bannerTitleLbl.text = item.get("vCategoryName")
                
                if(item.get("vBgColor") != ""){
                    cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                }
                
                if(item.get("ePromoteBanner").uppercased() == "YES"){
                    cell.arrowImgView.isHidden = true
                    cell.bannerTitleLbl.isHidden = true
                    cell.bannerTopView.isHidden = true
                    cell.banenrImgView.layer.cornerRadius = 12
                    cell.banenrImgView.clipsToBounds = true
                    let vImage = Utils.getResizeImgURL(imgUrl: item.get("vBannerImage"), width: Utils.getValueInPixel(value: Application.screenSize.width - 30), height: 0)
                    
                    cell.banenrImgView.contentMode = .scaleAspectFit
                    print(cell.banenrImgView.frame)
                    cell.banenrImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                        //cell.banenrImgView.image = cell.banenrImgView.image?.withRoundedCorners(radius: 18)
                    })
                    
                }else{
                    cell.bannerTopView.isHidden = true
                    cell.bannerTitleLbl.isHidden = true
                    cell.arrowImgView.isHidden = true
                    cell.banenrImgView.contentMode = .scaleAspectFit
                    
                    cell.banenrImgView.layer.cornerRadius = 16
                    let vImage = Utils.getResizeImgURL(imgUrl: item.get("vBannerImage"), width: Utils.getValueInPixel(value: Application.screenSize.width - 30) , height:  0)
                    
                    cell.banenrImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        
                        //cell.banenrImgView.image = cell.banenrImgView.image?.withRoundedCorners(radius: 18)
                        
                        
                    })
                }
                
                cell.contentView.handleClick { (instance) in
                    
                    if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                        self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                        _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                        
                    }
                    
                    if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                        
                        var isVideo = "No"
                        if(item.get("VideoConsultSection").uppercased() == "YES"){
                            isVideo = "Yes"
                        }
                        self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), isVideo)
                        
                    }
                    
                    if item.get("eCatType").uppercased() == "BIDDING"{
                       // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                        
                        self.selectServiceLbl.text = item.get("vCategory")
                        self.serviceTitle22Lbl.text = item.get("vCategory")
                        self.loadServiceCategory(parentCategoryId: item.get("iBiddingId"), category: item.get("eCatType"), item.get("isVideoConsultEnable"))
                    }
                }
                
                return cell
                
            }else if(item.get("eShowType") == "Icon"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22IconTVCell") as! Table22IconTVCell
            
                cell.dataArray = item.arrOf("SubCategories") as! [NSDictionary]
    
                if(GeneralFunctions.parseInt(origValue: 0, data: item.get("ListMaxCount")) != 0){
                    cell.listOfCount = GeneralFunctions.parseInt(origValue: 0, data: item.get("ListMaxCount"))
                    cell.moreServiceImg = self.moreIconImage
                }
                
                
                //cell.iconCollectionView.reloadData()
                if(Configurations.isRTLMode()){
                Utils.delayWithSeconds(0.2) {
                    cell.iconCollectionView.reloadData()
                }
                }else{
                    cell.iconCollectionView.reloadData()
                }
                cell.uv = self
                
                if(item.get("vBgColor") != ""){
                    cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                }
                
                return cell
                
            }else if(item.get("eShowType") == "Button"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22ButtonTVCell") as! Table22ButtonTVCell
            
                
                cell.buttonLbl.text = item.get("vCategoryName")
                
                if(item.get("vButtonBgColor") != ""){
                    cell.buttonView.backgroundColor = UIColor.init(hexString: item.get("vButtonBgColor"), alpha: 1)
                }
                
                if(item.get("vButtonTextColor") != ""){
                    cell.buttonLbl.textColor = UIColor.init(hexString: item.get("vButtonTextColor"), alpha: 1)
                }
            
                if(item.get("vBgColor") != ""){
                    cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                }
                
                cell.buttonView.handleClick { (instance) in
                    if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                        self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                        _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                        

                    }
                    
                    if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                        
                        var isVideo = "No"
                        if(item.get("VideoConsultSection").uppercased() == "YES"){
                            isVideo = "Yes"
                        }
                        self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), isVideo)
                    }
                    
                    if item.get("eCatType").uppercased() == "BIDDING"{
                       // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                        
                        self.selectServiceLbl.text = item.get("vCategory")
                        self.serviceTitle22Lbl.text = item.get("vCategory")
                        self.loadServiceCategory(parentCategoryId: item.get("iBiddingId"), category: item.get("eCatType"), item.get("isVideoConsultEnable"))
                    }
                }
                
                return cell
                
            }else if(item.get("eShowType") == "CubeXList"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22CubeXServicesTVCell") as! Table22CubeXServicesTVCell
            
                
                cell.isVideoSection = item.get("VideoConsultSection")
                cell.dataArray = item.arrOf("SubCategories") as! [NSDictionary]
                cell.getItem = item
                cell.listOfCount = GeneralFunctions.parseInt(origValue: 0, data: item.get("ListMaxCount"))
                cell.moreServiceImg = self.moreIconImage
                
                cell.servicesCollectionView.reloadData()
                cell.uv = self
                
                cell.serviceCntView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                cell.serviceNameTitleLbl.text = item.get("vCategoryName").uppercased()
                cell.serviceNameTitleLbl.textColor = UIColor.init(hexString: item.get("vTextColor"))
                
               
                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vIconImage"), width: Utils.getValueInPixel(value: (Application.screenSize.width * 0.20)) , height: Utils.getValueInPixel(value: (Application.screenSize.width * 0.20)))
                print(vImage)
                cell.serviceImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
                return cell
                
            }else if(item.get("eShowType") == "Service_Icon"){
                
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "Table22IconTVCell") as! Table22IconTVCell
            
                cell.iconCollectionView.register(UINib.init(nibName: "SerrviceIconCVCell", bundle: nil), forCellWithReuseIdentifier: "SerrviceIconCVCell")
                
                self.tableView22.contentInset.bottom = 15
                cell.backgroundColor = .clear
                cell.isServiceIcon = true
                cell.dataArray = item.arrOf("SubCategories") as! [NSDictionary]
                cell.iconCollectionView.reloadData()
                cell.uv = self
                cell.iconCollectionView.backgroundColor = .clear
                if(item.get("vBgColor") != ""){
                    cell.contentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                }
       
                return cell
                
            }else if(item.get("eShowType") == "Service_List"){
                
                let cell = tableView22.dequeueReusableCell(withIdentifier: "UFXHomeListCatTVCell") as! UFXHomeListCatTVCell
                
                cell.cntView.clipsToBounds = true
                cell.cntView.layer.cornerRadius = 14.0
                cell.cntView.layer.borderWidth = 0.0
                cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
                cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
                cell.cntView.layer.shadowRadius = 4.0
                cell.cntView.layer.shadowOpacity = 0.7
                cell.cntView.layer.masksToBounds = false
                
                self.tableView22.backgroundColor = UIColor(hex: 0xf1f1f1)
                self.tableView22.contentInset.bottom = 30
                
                self.grayBGApplied = true
                
                if(self.grayBGApplied){
                    shadowImageView.image = UIImage(named: "ic_shadow_3")
                    
                }else{
                    shadowImageView.image = UIImage(named: "shadow1")
                   
                }
                
               // cell.selectionStyle = .none
              //  cell.backgroundColor = UIColor.clear
                
                cell.catTitleLbl.textColor = SColors.Theme
                cell.catTitleLbl.text = item.get("vCategory")
                cell.catDecLbl.text = item.get("tListDescription")
                
    //            if(self.listItemArray.count - 1 == indexPath.row){
    //                cell.catDecLblBottomSpace.constant = 28
    //            }else{
    //                cell.catDecLblBottomSpace.constant = 8
    //            }
                
                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 70), height: Utils.getValueInPixel(value: 70))
                cell.catImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                    if(image != nil){
                        cell.catImgView.image = image
                    }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                        cell.catImgView.image = UIImage(named: item.get("vListLogo"))
                    }else{
                        cell.catImgView.image = UIImage(named: "ic_no_icon")
                    }
                })
               
                cell.cntView.handleClick { (instance) in
                    
                    if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                        self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                        _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                        

                    }
                    
                    if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                        
                        var isVideo = "No"
                        if(item.get("VideoConsultSection").uppercased() == "YES"){
                            isVideo = "Yes"
                        }
                        self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), isVideo)
                        
                    }
                    
                    if item.get("eCatType").uppercased() == "BIDDING"{
                       // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                        
                        self.selectServiceLbl.text = item.get("vCategory")
                        self.serviceTitle22Lbl.text = item.get("vCategory")
                        self.loadServiceCategory(parentCategoryId: item.get("iBiddingId"), category: item.get("eCatType"), item.get("isVideoConsultEnable"))
                    }
                }
                
                return cell
                
            }
            
        }else{
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                if(indexPath.row < listArray.count){
                     
                    
                    var item : NSDictionary!
                    item = self.listArray[indexPath.row]
                     let cell = tableView.dequeueReusableCell(withIdentifier: "UFXJekIconTVCNew", for: indexPath) as! UFXJekIconTVCNew
                    //cell.categoryImgView.contentMode = .scaleAspectFit
                    var offSet = Application.screenSize.width - cell.categoryImgView.width
                    let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Int(0) , height: Utils.getValueInPixel(value: Utils.getHeightOfBanner(widthOffset: offSet, ratio: "16:9")))
                    cell.categoryImgView.contentMode = .scaleAspectFit
                    cell.categoryImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                        
                        if(image != nil){
                            cell.categoryImgView.contentMode = .scaleToFill
                            cell.categoryImgView.image = image
                        }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                            cell.categoryImgView.contentMode = .scaleToFill
                            cell.categoryImgView.image = UIImage(named: item.get("vListLogo"))
            //        cell.categoryLbl.layer.masksToBounds = true
                        }else{
                            cell.categoryImgView.image = UIImage(named: "ic_no_icon")
                        }
                    })
                    
                   

                    cell.categoryLbl.text = item.get("vCategoryBanner").uppercased() != "" ? item.get("vCategoryBanner").uppercased() : item.get("vCategory").uppercased()
                    cell.CategoryDesLbl.text = item.get("tListDescription")
                    cell.categoryLbl.textColor = SColors.Theme
                    cell.categoryLbl.layer.cornerRadius = 5
                    
                    if cell.CategoryDesLbl.text == ""{
                        cell.categoryLblY.constant = 0
                    }else{
                        cell.categoryLblY.constant = -20
                    }
        //            DispatchQueue.main.async {
        //            cell.cateGoryView.clipsToBounds = true
        //            cell.cateGoryView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        //            }
                    if(Configurations.isRTLMode()){
                        DispatchQueue.main.async {
                            cell.categoryImgView.roundTo(corners: [.bottomLeft, .topLeft], radius: 10)
                            cell.cateGoryView.roundTo(corners: [.bottomRight, .topRight], radius: 6)
                        }
                    }else{
                    DispatchQueue.main.async {
                        cell.categoryImgView.roundTo(corners: [.bottomRight, .topRight], radius: 10)
                        cell.cateGoryView.roundTo(corners: [.bottomLeft, .topLeft], radius: 6)
                        
                    }
                    }
                    // manageIpad View
                    if isIpad == true {
                        if(Configurations.isRTLMode()){
                            DispatchQueue.main.async {
                                cell.categoryImgView.roundTo(corners: [.bottomLeft, .topLeft], radius: 15)
                                cell.cateGoryView.roundTo(corners: [.bottomRight, .topRight], radius: 10)
                            }
                        }else{
                        DispatchQueue.main.async {
                            cell.categoryImgView.roundTo(corners: [.bottomRight, .topRight], radius: 15)
                            cell.cateGoryView.roundTo(corners: [.bottomLeft, .topLeft], radius: 10)
                        }
                        }
                        cell.categoryViewLeading.constant = -30
                    }
                   // Utils.createRoundedView(view: cell.categoryImgView, borderColor: .clear, borderWidth: 0, cornerRadius: 10)
                    
                    
                    cell.selectionStyle = .none
                    cell.backgroundColor = UIColor.clear
                    
                    var CornerImg = UIImage(named: "ic_btn_rightarrow")!
                    if(Configurations.isRTLMode()){
                        CornerImg = CornerImg.rotate(180)
                    }
                    
                    cell.bottomCornerImgView.image = CornerImg
                

                    
                    Utils.createRoundedView(view: cell.bottomCornerView, borderColor: .clear, borderWidth: 0, cornerRadius: 0)
                    GeneralFunctions.setImgTintColor(imgView: cell.bottomCornerImgView, color: .white)
                    
                    return cell
                 
                
                 
             }else{
                
                    var item :NSDictionary!

                    item = bannerArray[indexPath.row - listArray.count ]
                 
                 let cell = tableView.dequeueReusableCell(withIdentifier: "UFXJekIconTVC", for: indexPath) as! UFXJekIconTVC
                 
                 //cell.categoryImgView.backgroundColor = UIColor(hex: 0xadadad)
                 cell.categoryImgView.contentMode = .scaleAspectFit
                 
                 let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: Utils.getWidthOfBanner(widthOffset: 30)), height: Utils.getValueInPixel(value: Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")))
                 
                 cell.categoryImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                     //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                     if(image != nil){
                         cell.categoryImgView.contentMode = .scaleToFill
                         cell.categoryImgView.image = image
                     }else if(item.get("vBannerImage") != "" && !item.get("vBannerImage").contains(find: "http")){
                        cell.categoryImgView.contentMode = .scaleToFill
                         cell.categoryImgView.image = UIImage(named: item.get("vBannerImage"))
                     }else{
                         cell.categoryImgView.image = UIImage(named: "ic_no_icon")
                     }
                 })
                 
                 cell.categoryLbl.text = item.get("vCategoryBanner") != "" ? item.get("vCategoryBanner") : item.get("vCategory")
                 
                 cell.bookNowLbl.text = item.get("tBannerButtonText") == "" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_NOW") : item.get("tBannerButtonText")
                 cell.bookNowLbl.backgroundColor = SColors.Theme
                 cell.bookNowLbl.textColor = SColors.ThemeTxt
                 
                 cell.bookNowLbl.layer.masksToBounds = true
                 cell.bookNowLbl.layer.cornerRadius = 5
                 
                 cell.categoryLbl.layer.masksToBounds = true
                 cell.categoryLbl.layer.cornerRadius = 5
                 

                 Utils.createRoundedView(view: cell.categoryImgView, borderColor: .clear, borderWidth: 0, cornerRadius: 10)
                 cell.imgBGView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                 cell.imgBGView.layer.roundCorners(radius: 10)
                 
                 
                 cell.selectionStyle = .none
                 cell.backgroundColor = UIColor.clear
    //            cell.rightMargin.constant = 25
    //           cell.leftMargin.constant = 25
    //            cell.categoryLblLeading.constant = 25
                 var CornerImg = UIImage(named: "ic_btn_rightarrow")!
                 if(Configurations.isRTLMode()){
                     CornerImg = CornerImg.rotate(180)
                 }
                 
                 cell.bottomCornerImgView.image = CornerImg
                 cell.bottomCornerView.backgroundColor = SColors.Theme
                 if(Configurations.isRTLMode()){
                    cell.bottomCornerView.roundTo(corners: [.bottomLeft], radius: 6)
                     
                 }else{
                    cell.bottomCornerView.roundTo(corners: [.bottomRight], radius: 6)
                   
                 }
                 
                 Utils.createRoundedView(view: cell.bottomCornerView, borderColor: .clear, borderWidth: 0, cornerRadius: 0)
                 GeneralFunctions.setImgTintColor(imgView: cell.bottomCornerImgView, color: .white)
                 
                 return cell
                 }
            }else{
                if(indexPath.row < self.listItemArray.count){
                    
                    let item = self.listItemArray[indexPath.row]
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UFXHomeListCatTVCell", for: indexPath) as! UFXHomeListCatTVCell
                    
                    cell.selectionStyle = .none
                    cell.backgroundColor = UIColor.clear
                    
                    cell.catTitleLbl.textColor = SColors.Theme
                    cell.catTitleLbl.text = item.get("vCategory")
                    cell.catDecLbl.text = item.get("tListDescription")
                    
        //            if(self.listItemArray.count - 1 == indexPath.row){
        //                cell.catDecLblBottomSpace.constant = 28
        //            }else{
        //                cell.catDecLblBottomSpace.constant = 8
        //            }
                    
                    let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 70), height: Utils.getValueInPixel(value: 70))
                    cell.catImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                        if(image != nil){
                            cell.catImgView.image = image
                        }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                            cell.catImgView.image = UIImage(named: item.get("vListLogo"))
                        }else{
                            cell.catImgView.image = UIImage(named: "ic_no_icon")
                        }
                    })
                    
                    return cell
                    
                }else{
                    
                    let item = self.listOfParentListCategories[indexPath.row - self.listItemArray.count]
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UFXJekIconTVC", for: indexPath) as! UFXJekIconTVC
                    
                    //cell.categoryImgView.backgroundColor = UIColor(hex: 0xadadad)
                    //cell.categoryImgView.contentMode = .scaleAspectFit
                    
                    let vImage = Utils.getResizeImgURL(imgUrl: item.get("vBannerImage"), width: Utils.getValueInPixel(value: Utils.getWidthOfBanner(widthOffset: 30)), height: Utils.getValueInPixel(value: Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")))
                    
                    cell.categoryImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                        if(image != nil){
                            cell.categoryImgView.image = image
                        }else if(item.get("vBannerImage") != "" && !item.get("vBannerImage").contains(find: "http")){
                            cell.categoryImgView.image = UIImage(named: item.get("vBannerImage"))
                        }else{
                            cell.categoryImgView.image = UIImage(named: "ic_no_icon")
                        }
                    })
                    
                    cell.categoryLbl.text = item.get("vCategoryBanner") != "" ? item.get("vCategoryBanner") : item.get("vCategory")
                    
                    cell.bookNowLbl.text = item.get("tBannerButtonText") == "" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_NOW") : item.get("tBannerButtonText")
                    cell.bookNowLbl.backgroundColor = SColors.Theme
                    cell.bookNowLbl.textColor = SColors.ThemeTxt
                    
                    cell.bookNowLbl.layer.masksToBounds = true
                    cell.bookNowLbl.layer.cornerRadius = 5
                    
                    cell.categoryLbl.layer.masksToBounds = true
                    cell.categoryLbl.layer.cornerRadius = 5
                    

                    Utils.createRoundedView(view: cell.categoryImgView, borderColor: .clear, borderWidth: 0, cornerRadius: 10)
                    cell.imgBGView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                    cell.imgBGView.layer.roundCorners(radius: 10)
                    
                    
                    cell.selectionStyle = .none
                    cell.backgroundColor = UIColor.clear
                    
                    var CornerImg = UIImage(named: "ic_btn_rightarrow")!
                    if(Configurations.isRTLMode()){
                        CornerImg = CornerImg.rotate(180)
                    }
                    
                    cell.bottomCornerImgView.image = CornerImg
                    cell.bottomCornerView.backgroundColor = SColors.Theme
                    if(Configurations.isRTLMode()){
                        cell.bottomCornerView.roundTo(corners: [.bottomLeft], radius: 6)
                        
                    }else{
                        cell.bottomCornerView.roundTo(corners: [.bottomRight], radius: 6)
                      
                    }
                    
                    Utils.createRoundedView(view: cell.bottomCornerView, borderColor: .clear, borderWidth: 0, cornerRadius: 0)
                    GeneralFunctions.setImgTintColor(imgView: cell.bottomCornerImgView, color: .white)
                    
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
            if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVCNew", for: indexPath) as! UFXJekIconCVC
                cell.viewContentTop.constant = 2
                cell.imageCenter.constant = -20
                cell.bgViewHight.constant = 50
                cell.bgViewWidhth.constant = 50
                var item:NSDictionary!
                item = self.moreDataFor22[indexPath.item]
                self.shadowOnview(view: cell.viewContent)
                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 50), height: Utils.getValueInPixel(value: 50))
                cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                    if(image != nil){
                        cell.iconImgView.image = image
                    }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                        cell.iconImgView.image = UIImage(named: item.get("vListLogo"))
                    }else{
                       cell.iconImgView.image = UIImage(named: "ic_no_icon")
                    }
                })
                cell.bgView.backgroundColor = UIColor.clear
                cell.categoryLbl.text = item.get("vCategory")
                if(item.get("vCategory").contains(find: " ")){
                    cell.categoryLbl.numberOfLines = 2
                }else{
                    cell.categoryLbl.numberOfLines = 1
                }
                cell.backgroundColor = UIColor.clear
                return cell
            }
            else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVC", for: indexPath) as! UFXJekIconCVC
        
        var item:NSDictionary!
        
        if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
            if isMedicalServices {
                //let temp =
                item =  self.moreDataForMedical[indexPath.section].arrOf("Services")[indexPath.row] as? NSDictionary
            }else{
            item = self.moreDataFor22[indexPath.item]
            }
        }else{
            item = self.listOfParentGridCategories[indexPath.item]
        }
        
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
        
        print(vImage)
        cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
            if(image != nil){
                cell.iconImgView.image = image
            }else if(item.get("vLogo_image") != "" && !item.get("vLogo_image").contains(find: "http")){
                cell.iconImgView.image = UIImage(named: item.get("vLogo_image"))
            }else{
               cell.iconImgView.image = UIImage(named: "ic_no_icon")
            }
        })

        cell.bgView.backgroundColor = UIColor.clear
        cell.categoryLbl.text = item.get("vCategory")
        if(item.get("vCategory").contains(find: " ")){
            cell.categoryLbl.numberOfLines = 2
        }else{
            cell.categoryLbl.numberOfLines = 1
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
            }
        }else{
            // new Design Ui changes
            if (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVCNew", for: indexPath) as! UFXJekIconCVC
                var item:NSDictionary!
               
                if isMedicalServices {
                    item =  self.moreDataForMedical[indexPath.section].arrOf("Services")[indexPath.row] as? NSDictionary
                }else{
                    item = self.moreDataFor22[indexPath.item]
                }
                
                cell.viewContentTop.constant = 2
                
                if isMedicalServices {
                    if self.moreDataForMedical[indexPath.section].get("GridView").uppercased() == "YES" {
                        cell.subTitlelbl.isHidden = false
                        cell.bgViewHight.constant = 60
                        cell.bgViewWidhth.constant = 60
                        cell.imageCenter.constant = -38
                        self.shadowOnview(view: cell.viewContent)
                                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
                        
                                cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                                    //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                                    if(image != nil){
                                        cell.iconImgView.image = image
                                    }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                                        cell.iconImgView.image = UIImage(named: item.get("vListLogo"))
                                    }else{
                                        cell.iconImgView.image = UIImage(named: "ic_no_icon")
                                    }
                                })
                    }else{
                        cell.subTitlelbl.isHidden = true
                        cell.imageCenter.constant = -20
                        cell.bgViewHight.constant = 50
                        cell.bgViewWidhth.constant = 50
                        self.shadowOnview(view: cell.viewContent)
                                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 50), height: Utils.getValueInPixel(value: 50))
                        
                                cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                                    //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                                    if(image != nil){
                                        cell.iconImgView.image = image
                                    }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                                        cell.iconImgView.image = UIImage(named: item.get("vListLogo"))
                                    }else{
                                        cell.iconImgView.image = UIImage(named: "ic_no_icon")
                                    }
                                })
                    }
                }else{
                    cell.subTitlelbl.isHidden = true
                    cell.imageCenter.constant = -20
                    cell.bgViewHight.constant = 50
                    cell.bgViewWidhth.constant = 50
                    self.shadowOnview(view: cell.viewContent)
                            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 50), height: Utils.getValueInPixel(value: 50))
                    
                            cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                                //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                                if(image != nil){
                                    cell.iconImgView.image = image
                                }else if(item.get("vListLogo") != "" && !item.get("vListLogo").contains(find: "http")){
                                    cell.iconImgView.image = UIImage(named: item.get("vListLogo"))
                                }else{
                                    cell.iconImgView.image = UIImage(named: "ic_no_icon")
                                }
                            })
                    
                            
                }
               
             
                
                        cell.bgView.backgroundColor = UIColor.clear
                        cell.categoryLbl.text = item.get("vCategory")
                        cell.subTitlelbl.text = item.get("tListDescription")
                        
                       
                        if(item.get("vCategory").contains(find: " ")){
                            cell.categoryLbl.numberOfLines = 2
                        }else{
                        cell.categoryLbl.numberOfLines = 1
                        }
               
                        cell.backgroundColor = UIColor.clear
                
                        return cell
            }
           else if collectionView == serviceCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVC", for: indexPath) as! UFXJekIconCVC
                var item:NSDictionary!
                if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
                    item = self.listOfParentListCategories[indexPath.item ]
                }else{
                    item = self.iconArray[indexPath.item]
                }
                //item = iconArray[indexPath.item]
     
                       
                
                
                        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
                
                        cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                            if(image != nil){
                                cell.iconImgView.image = image
                            }else if(item.get("vLogo_image") != "" && !item.get("vLogo_image").contains(find: "http")){
                                cell.iconImgView.image = UIImage(named: item.get("vLogo_image"))
                            }else{
                                cell.iconImgView.image = UIImage(named: "ic_no_icon")
                            }
                        })
                
                        
                
                        cell.bgView.backgroundColor = UIColor.clear
                
                
                        cell.categoryLbl.text = item.get("vCategory")
                
                        if(item.get("vCategory").contains(find: " ")){
                            cell.categoryLbl.numberOfLines = 2
                        }else{
                            cell.categoryLbl.numberOfLines = 1
                        }
                        cell.backgroundColor = UIColor.clear
                
                        return cell
            }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXServiceCVC", for: indexPath) as! UFXServiceCVC
            
            var item = self.masterCateGory[indexPath.item]

                cell.lblCategory.text = item.get("vCategoryName").uppercased()
            let vImageServiceBg = Utils.getResizeImgURL(imgUrl: item.get("vBgImage"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vIconImage"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
                cell.serviceImgView.sd_setImage(with: URL(string: vImageServiceBg), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                   
                    if(image != nil){
                        cell.serviceImgView.image = image
                    }
                })
                cell.iconImageView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                    if(image != nil){
                        cell.iconImageView.image = image
                    }
                })
            if indexPath.item == selectecSerivceIndex {
                cell.serviceImgView.layer.borderColor = SColors.Theme.cgColor
                cell.serviceImgView.layer.masksToBounds = true
                cell.serviceImgView.contentMode = .scaleToFill
                cell.serviceImgView.layer.borderWidth = 2
               // cell.lblCategory.textColor = UIColor.gray
              

            }else{
                cell.serviceImgView.layer.borderColor = SColors.Theme.cgColor
                cell.serviceImgView.layer.masksToBounds = true
                cell.serviceImgView.contentMode = .scaleToFill
                cell.serviceImgView.layer.borderWidth = 0
                //cell.lblCategory.textColor = UIColor.white
            }

            
            return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
        if(loaderView != nil && loaderView.isHidden == false){
            return
        }
        
    
        UIView.animate(withDuration: 0.1, animations: {
            if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }) { (_) in
            if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                cell.transform = .identity
            }
        }
        
        var itemDic:NSDictionary
        if(indexPath.row < self.listItemArray.count){
            itemDic = self.listItemArray[indexPath.row]
        }else{
            itemDic = self.listOfParentListCategories[indexPath.row - self.listItemArray.count]
        }
        
        if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
//             && (self.userProfileJson.get("RIDE_DELIVERY_SHOW_TYPE").uppercased() == "BANNER" || self.userProfileJson.get("RIDE_DELIVERY_SHOW_TYPE").uppercased() == "ICON-BANNER")
            
            self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
            _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: itemDic)
            

        }
        
        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && itemDic.get("eCatType").uppercased() == "SERVICEPROVIDER"){
            
            self.selectServiceLbl.text = itemDic.get("vCategory")
            
            
            self.loadServiceCategory(parentCategoryId: itemDic.get("iVehicleCategoryId"))
  
        }
        }else{
            // Ui New Design Changes
            if(loaderView != nil && loaderView.isHidden == false){
                return
            }
            
            
                
            UIView.animate(withDuration: 0.1, animations: {
                if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                    cell.transform = .init(scaleX: 0.95, y: 0.95)
                }
            }) { (_) in
                if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                    cell.transform = .identity
                }
            }
            
            var item:NSDictionary!
                
                if(indexPath.row < self.listArray.count){
                    item = self.listArray[indexPath.row]
                    }else{
                item = self.bannerArray[indexPath.row - self.listArray.count]
            }
                
                
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
    //             && (self.userProfileJson.get("RIDE_DELIVERY_SHOW_TYPE").uppercased() == "BANNER" || self.userProfileJson.get("RIDE_DELIVERY_SHOW_TYPE").uppercased() == "ICON-BANNER")
                
                self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                

            }
            
            if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                
                
                self.selectServiceLbl.text = item.get("vCategory")
                self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"))
            }
        }
    }
    
    
    
    func goToDeliverAllScreen(screenType:String){
        let deliver_all_app_url = URL(string: "\(self.userProfileJson.get("\(screenType.uppercased())_APP_IOS_PACKAGE_NAME"))://?serviceId=\(screenType.uppercased() == "DELIVER_ALL" ? "" : self.userProfileJson.get("\(screenType.uppercased())_APP_SERVICE_ID"))")
        
        if(deliver_all_app_url != nil){
            if(UIApplication.shared.canOpenURL(deliver_all_app_url!)){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(deliver_all_app_url!)
                } else {
                    UIApplication.shared.openURL(deliver_all_app_url!)
                }
            }else{
                let introduceDeliverAllUV = GeneralFunctions.instantiateViewController(pageName: "IntroduceDeliverAllUV") as! IntroduceDeliverAllUV
                introduceDeliverAllUV.screenType = screenType
                self.push(uv: introduceDeliverAllUV)
            }
        }else{
            let introduceDeliverAllUV = GeneralFunctions.instantiateViewController(pageName: "IntroduceDeliverAllUV") as! IntroduceDeliverAllUV
            introduceDeliverAllUV.screenType = screenType
            self.push(uv: introduceDeliverAllUV)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let GRID_TILES_MAX_COUNT = GeneralFunctions.parseInt(origValue: 1, data: self.userProfileJson.get("GRID_TILES_MAX_COUNT"))
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
        if(loaderView != nil && loaderView.isHidden == false){
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }) { (_) in
            if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
                cell.transform = .identity
            }
        }
        
//        self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
//        self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:true, closeFull:true)
           
        self.closeMoreServices()
        continueCollectionViewItemClick(collectionView: collectionView, indexPath: indexPath)
        }else{
            // New Design layout Changes RZ
            if collectionView == serviceCollectionView  || (collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
            if(loaderView != nil && loaderView.isHidden == false){
                        return
                    }
                    
//                    UIView.animate(withDuration: 0.3, animations: {
//                        if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
//                            cell.transform = .init(scaleX: 0.95, y: 0.95)
//                        }
//                    }) { (_) in
//                        if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
//                            cell.transform = .identity
//                        }
//                    }
                    
            //        self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
            //        self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:true, closeFull:true)
                    
                    self.closeMoreServices()
                    continueCollectionViewItemClick(collectionView: collectionView, indexPath: indexPath)
            }else{
                if selectecSerivceIndex != indexPath.item{
                strCateGory = self.cateGoryArray[indexPath.item]
                selectecSerivceIndex = indexPath.item
                self.loadData()
                //self.gettingCategoryHight()
                self.rduScrollView.scrollToTop()
                //self.rduCollectionView.reloadData()
                self.serviceCollectionView.reloadData()
                self.rduTableView.reloadData()
                return
            }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = tableView.cellForRow(at: indexPath) as? UFXJekIconTVC {
                cell.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
                cell.transform = .init(scaleX: 0.85, y: 0.85)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? UFXJekIconCVC {
                cell.transform = .identity
            }
        }
    }
    
    func continueCollectionViewItemClick(collectionView: UICollectionView, indexPath: IndexPath){
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
        var item:NSDictionary!
        
        if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
            if isMedicalServices {
                isMedicalServices = false
                item =  self.moreDataForMedical[indexPath.section].arrOf("Services")[indexPath.row] as? NSDictionary
                if item.get("eCatType") == "ServiceProvider" {
                    if item.get("eVideoConsultEnable") == "Yes" && item.get("iParentId") == "0"  {
                        self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), "YES")
                    }else if item.get("eVideoConsultEnable") == "Yes"  &&  item.get("iParentId") != "0" {
                        self.selectedCategoryIds.removeAll()
                        let selectedDataDict = NSMutableDictionary()
                        selectedDataDict["iVehicleCategoryId"] = item.get("iVehicleCategoryId")
                        selectedDataDict["vParentCategoryName"] = item.get("vParentCategoryName")
                        selectedDataDict["IS_SELECTED"] = "Yes"
                        self.selectedCategoryIds += [selectedDataDict]
                        self.eForVideoConsultation = "Yes"
                        self.selectedServiceParentID = item.get("iParentId")
                        self.checkSelectedCategories(isFromSearch: true)
                    }else{
                        if item.get("iParentId") == "0" {
                            self.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), "NO")
                        }else{
                            let selectedDataDict = NSMutableDictionary()
                            selectedDataDict["iVehicleCategoryId"] = item.get("iVehicleCategoryId")
                            selectedDataDict["vParentCategoryName"] = item.get("vParentCategoryName")
                            selectedDataDict["IS_SELECTED"] = "Yes"
                            self.selectedCategoryIds += [selectedDataDict]
                            self.eForVideoConsultation = "No"
                            self.selectedServiceParentID = item.get("iParentId")
                            self.checkSelectedCategories(isFromSearch: true)
                        }
                    }
                    return
                }
               
            }else{
                item = self.moreDataFor22[indexPath.row]
            }
            
            //self.mor[indexPath.row]
            
        }else{
            
            item = self.iconArray[indexPath.row]
        }
        
        if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

            self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
            self.selectSerivcesSubLbl.layer.borderColor = UIColor.clear.cgColor
            _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
            
        }
        
        let eCatType = item.get("eCatType")
        if(eCatType.uppercased() == "MORE"){
            
            if self.moreServicesView == nil{
                self.addMoreServiceView()
            }

            self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
            self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
            self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
            self.moreServicesView.dragViewAnimatedTopMargin = 0
            self.btnSheetCollectionView.reloadData()
            self.moreServicesBGView.isHidden = false
            
        }else if(item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
            if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE"){
               
                self.selectServiceLbl.text = item.get("vCategory")
                self.selectSerivcesSubLbl.text = item.get("vCategory")
                self.parentNewPHView.isHidden = true
                isFromSubCateGory = true
                loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"))
            }
        }else if (item.get("eCatType").uppercased() == "BIDDING") {
            self.selectServiceLbl.text = item.get("vCategory")
            self.serviceTitle22Lbl.text = item.get("vCategory")
            self.loadServiceCategory(parentCategoryId: item.get("iBiddingId"), category: item.get("eCatType"), item.get("isVideoConsultEnable"))
        }
        }else{
            var item:NSDictionary!
            
            if(collectionView == self.btnSheetCollectionView || collectionView == self.allIn1MedicalCollectionView){
                item = self.moreDataFor22[indexPath.row]
                
            }else{
                item = self.listOfParentGridCategories[indexPath.row]
            }
            
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                
            }
            
            let eCatType = item.get("eCatType")
            if(eCatType.uppercased() == "MORE"){
                
                if self.moreServicesView == nil{
                    self.addMoreServiceView()
                }

                self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
                self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
                self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
                self.moreServicesView.dragViewAnimatedTopMargin = 0
                self.btnSheetCollectionView.reloadData()
                self.moreServicesBGView.isHidden = false
                
            }else if(item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE"){
                   
                    self.selectServiceLbl.text = item.get("vCategory")
                    loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"))
                }
            }
        }
    }
    
    func myLableTapped(sender: MyLabel) {
        if(self.cancelBtnSheetLbl != nil && sender == cancelBtnSheetLbl){
           
            self.closeMoreServices()
        }
    }
    
    func addMoreServiceView(){
        // INITIALIZE FILTERVIEW
        let window = UIApplication.shared.delegate!.window!
        
        moreServicesBGView = UIView.init(frame: CGRect(x: 0, y:0 , width: (window?.frame.width)!, height: (window?.frame.height)!))
        moreServicesBGView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        moreServicesBGView.isHidden = true
        Application.window!.addSubview(moreServicesBGView)
        moreServicesView = SDragViewForMoreServices(dragViewAnimatedTopSpace:0, viewDefaultHeightConstant:0, uv:self)
        Application.window!.addSubview(moreServicesView)
        
        // ADD Naviation View
        let widthOfCancelTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").width(withConstrainedHeight: 64, font: UIFont(name: Fonts().light, size: 17)!)
        
        let topBGViw:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: 44))
        topBGViw.clipsToBounds = true
        topBGViw.backgroundColor = SColors.Theme
        moreServicesView.addSubview(topBGViw)
        let stackView = UIStackView.init(frame: CGRect(x: 10, y: 0, width: Application.screenSize.width - 20 , height: topBGViw.frame.size.height))
        topBGViw.addSubview(stackView)
         
        cancelBtnSheetLbl = MyLabel(frame: CGRect(x: Application.screenSize.width - 10 - widthOfCancelTxt, y: 0, width: Application.screenSize.width - 20, height: topBGViw.frame.size.height))
         
        cancelBtnSheetLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
        cancelBtnSheetLbl.textAlignment = .natural
        cancelBtnSheetLbl.backgroundColor = UIColor.clear
        cancelBtnSheetLbl.textColor = SColors.ThemeTxt
        cancelBtnSheetLbl.setClickDelegate(clickDelegate: self)
        cancelBtnSheetLbl.font = UIFont(name: Fonts().light, size: 17)!
       
        var imgBg = UIView(frame: CGRect(x: Application.screenSize.width - 50, y: 8, width: 30, height: 30))
        if(Configurations.isRTLMode()){
            imgBg.frame =  CGRect(x: 5, y: 7, width: 25, height: 25)
        }
        imgBg.layer.cornerRadius = imgBg.frame.size.width / 2
        imgBg.clipsToBounds = true
        imgBg.backgroundColor = UIColor.white
        imgBg.handleClick { instance in
            self.closeMoreServices()
        }
        let imageViewCancel = UIImageView(frame: CGRect(x:5 , y: 5, width: 20, height: 20))
//        if(Configurations.isRTLMode()){
//            imageViewCancel.frame =  CGRect(x: 5, y: , width: 20, height: 20)
//        }
        imageViewCancel.image = UIImage.init(named: "cm_close_white")
        GeneralFunctions.setImgTintColor(imgView: imageViewCancel, color: SColors.Theme)
        let ViewCancelTransparent = UIImageView(frame: CGRect(x:imageViewCancel.frame.origin.x , y: 7, width: 50, height: 50))
        ViewCancelTransparent.backgroundColor = UIColor.clear
        ViewCancelTransparent.handleClick { instance in
            self.closeMoreServices()
        }
        let titleView = MyLabel(frame: CGRect(x: 1, y: 0, width: Application.screenSize.width - 20, height: topBGViw.frame.size.height))
         if(Configurations.isRTLMode()){
             titleView.frame = CGRect(x: 40, y: 0, width:  Application.screenSize.width - 60, height: topBGViw.frame.size.height)
         }
        titleView.text = self.moreTitle//self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE")
       
        titleView.textAlignment = .natural
        titleView.backgroundColor = UIColor.clear
        titleView.textColor = SColors.ThemeTxt
        titleView.font = UIFont(name: Fonts().light, size: 17)!
        lblServiceSlect = titleView
        //stackView.addArrangedSubview(titleView)
        //stackView.addSubview(titleView)
        //stackView.addArrangedSubview((imageViewCancel))
        stackView.addSubview(titleView)
        stackView.addSubview(imgBg)
        imgBg.addSubview(imageViewCancel)
        stackView.addSubview(ViewCancelTransparent)
        
        // ADD CollectionView IN MoreServicesView
        self.btnSheetCollectionView = UICollectionView(frame: CGRect(x: 0, y: topBGViw.frame.size.height, width: Application.screenSize.width, height: Application.screenSize.height - topBGViw.frame.size.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.btnSheetCollectionView.delegate = self
        self.btnSheetCollectionView.dataSource = self
        self.btnSheetCollectionView.backgroundColor = .white
        self.btnSheetCollectionView.register(UINib(nibName: "UFXJekIconCVCNew", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVCNew")
        self.btnSheetCollectionView.register(UINib(nibName: "CategoryHeaderCVCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryHeaderCVCell")
        self.btnSheetCollectionView.bounces = false
        self.btnSheetCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        self.btnSheetCollectionView.contentInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        self.moreServicesView.addSubview(self.btnSheetCollectionView)
    }
    
    func closeMoreServices(){
        scrollView.setContentOffset(.zero, animated: false)
        if(moreServicesView != nil){
            
            self.moreServicesView.isFromMoremedical = false
            self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:true, closeFull:true)
        }
    }
    
    @objc func moreServicesViewSwipePerformed(){
        if(self.moreServicesView.bgViewIsHidden == true){
            self.moreServicesBGView.isHidden = true
        }else{
            self.moreServicesBGView.isHidden = false
        }
    }
    
    func changeLanguage(){
        
        let langCode = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        let parameters = ["type":"changelanguagelabel","vLang": langCode]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    _ = UIApplication.shared.delegate!.window!
                    
                    GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
                    
                    
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_CODE_KEY, value: dataDict.get("vCode") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_IS_RTL_KEY, value: dataDict.get("eType") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY, value: dataDict.get("vTitle") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: dataDict.get("vGMapLangCode") as AnyObject)
                    GeneralFunctions.languageLabels = nil
                    Configurations.setAppLocal()
                    
                    let delAllUfxHomeUV = GeneralFunctions.instantiateViewController(pageName: "DelAllUFXHomeUV") as! DelAllUFXHomeUV
                    delAllUfxHomeUV.navItem = self.homeTabBar.navItem
                    self.push(uv: delAllUfxHomeUV)
                    
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    var isFromSearchServicesUV = false
    @IBAction func unwindToUFXHomeScreen(_ segue:UIStoryboardSegue) {
      
        
        if(segue.source.isKind(of: MainScreenUV.self)){
            let mainScreenUv = segue.source as! MainScreenUV
            
            if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
               
                if(self.homeTabBar != nil && self.currentMode != "SUB_MODE"){
                    if(self.homeTabBar != nil && self.homeTabBar.tabbarHidden == true){
                        self.contentView.alpha = 0
                        UIView.animate(withDuration: 0.3, animations: {
                            self.homeTabBar.tabbarHidden = false
                            self.adView?.isHidden = false
                            if(self.bannerView != nil){
                                self.bannerView.isHidden = false
                            }
                            self.homeTabBar.bannerAd.zPosition = 1
                            self.contentView.alpha = 1
                        })
                    }
                }
                
                self.preSelectedServiceIdsString = mainScreenUv.ufxSelectedVehicleTypeId
                loadServiceCategory(parentCategoryId: self.selectedServiceParentID)
                
            }else{
                loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
                
                if(mainScreenUv.currentCabGeneralType == Utils.cabGeneralType_UberX){
                    let opnTripFinishView = OpenTripFinishView(uv: self)
                    opnTripFinishView.ufxDriverAcceptedReqNow = mainScreenUv.ufxDriverAcceptedReqNow
                    opnTripFinishView.ufxReqLater = mainScreenUv.selectedDate != "" ? true : false
                    opnTripFinishView.isUnwindToHome = false
                    opnTripFinishView.show(title: "", desc:"", true,.bottom ) {
                    }
                }
            }
            
        }else if(segue.source.isKind(of: MultiDeliveryOptionsUV.self) || segue.source.isKind(of: UFXCheckOutUV.self) || segue.source.isKind(of: MyOnGoingTripsUV.self) || segue.source.isKind(of: RideHistoryUV.self)) {
            
            if(segue.source.isKind(of: UFXCheckOutUV.self) || segue.source.isKind(of: MyOnGoingTripsUV.self)){
                self.preSelectedServiceIdsString = ""
            }
            
            if(self.homeTabBar != nil && self.homeTabBar.tabbarHidden == true){
                self.contentView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.homeTabBar.tabbarHidden = false
                    self.adView?.isHidden = false
                    if(self.bannerView != nil){
                        self.bannerView.isHidden = false
                    }
                    self.homeTabBar.bannerAd.zPosition = 1
                    self.contentView.alpha = 1
                })
            }
            
            loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
        }else if(segue.source.isKind(of: SearchSearvicesUV.self)) {
            
            self.isFromSearchServicesUV = true
            let searchSearvicesUV = segue.source as! SearchSearvicesUV
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: searchSearvicesUV.dataDic)
                

            }
            if searchSearvicesUV.dataDic.get("iParentId") != "0" && searchSearvicesUV.dataDic.get("eCatType").uppercased() == "SERVICEPROVIDER" {
                let selectedDataDict = NSMutableDictionary()
                selectedDataDict["iVehicleCategoryId"] = searchSearvicesUV.dataDic.get("iVehicleCategoryId")
                selectedDataDict["vParentCategoryName"] = searchSearvicesUV.dataDic.get("vParentCategoryName")
                selectedDataDict["IS_SELECTED"] = "Yes"
                selectedCategoryIds += [selectedDataDict]
                selectedServiceParentID = searchSearvicesUV.dataDic.get("iParentId")
                self.checkSelectedCategories(isFromSearch: true)
            }else if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE" && searchSearvicesUV.dataDic.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                
                self.loadServiceCategory(parentCategoryId: searchSearvicesUV.dataDic.get("iVehicleCategoryId"))
            }
            if searchSearvicesUV.dataDic.get("eCatType").uppercased() == "BIDDING"{
               // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                if searchSearvicesUV.dataDic.get("iParentId") != "0" {
                    let bidInfromationUV = GeneralFunctions.instantiateViewController(pageName: "BidInfromationUV") as! BidInfromationUV
                    bidInfromationUV.bidCategory = searchSearvicesUV.dataDic.get("vCategory")
                    bidInfromationUV.bidID =  searchSearvicesUV.dataDic.get("iBiddingId")
                    self.push(uv: bidInfromationUV)
                    
                }else{
                self.selectServiceLbl.text = searchSearvicesUV.dataDic.get("vCategory")
                self.serviceTitle22Lbl.text = searchSearvicesUV.dataDic.get("vCategory")
                self.loadServiceCategory(parentCategoryId: searchSearvicesUV.dataDic.get("iBiddingId"), category: searchSearvicesUV.dataDic.get("eCatType"), searchSearvicesUV.dataDic.get("isVideoConsultEnable"))
                }
            }
        }
    }
    
    
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.bannersItemList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
     
        if(self.bannerTopCarosoulView22 == carousel && !ServiceModule.isDeliverAllOnly()){
            
            var mainView:UIView!
            var imgView:UIImageView!
          
            if (mainView == nil){
                
                //&& !ServiceModule.isDeliverAllOnly()
             
                
                let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                let heightValue = Utils.getValueInPixel(value: height)
                
                
                mainView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
                imgView = UIImageView.init(frame: CGRect(x:0, y: 0, width: carousel.frame.size.width, height: height))
                
                mainView.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.contentMode = .scaleAspectFit
                imgView.layer.cornerRadius = 0
                imgView.clipsToBounds = true
                
                mainView.addSubview(imgView)
                
                
            }else{
                
                view?.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                
                imgView = view?.subviews[0] as? UIImageView
                
                let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                let heightValue = Utils.getValueInPixel(value: height)
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width)
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.contentMode = .scaleAspectFit
                imgView.layer.cornerRadius = 0
                imgView.clipsToBounds = true
              
            }
            
            return mainView
        }else{
            var imgView:UIImageView!
            if (view == nil){
                
                var widthMinusValue = 60
                if bannersItemList.count == 1 {
                    widthMinusValue = 38
                }
                
                let height = Utils.getHeightOfBanner(widthOffset: CGFloat(widthMinusValue), ratio: "" , 2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                
                imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - CGFloat(widthMinusValue), height: height))
                imgView.backgroundColor = UIColor.systemGray5
                
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width - CGFloat(widthMinusValue))
                
//                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage: nil)
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
                
                
            }else{
                imgView = view as? UIImageView
                imgView.backgroundColor = UIColor.systemGray5
                
                let height = Utils.getHeightOfBanner(widthOffset: 60, ratio: "", 2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width - 60)
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
                
            }
            
            return imgView
        }
        
    }
    
    
    
   func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
            
       if(self.bannerTopCarosoulView22 == carousel && !ServiceModule.isDeliverAllOnly()){
            self.imgSlideShow.contentOffset = CGSize(width: 0, height: 0)
            
            if(self.bannersItemList.count > 0){
                
                self.homeTabBar.setnavBarTintColor(color: SColors.Theme)
                
            }else{
                self.setnavBarTintColor(color: SColors.Theme)
            }
            pageController.setPage(carousel.currentItemIndex)
        }else{
            if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
                if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                    self.imgSlideShow.contentOffset = CGSize(width: 15, height: 0)
                }else{
                    self.imgSlideShow.contentOffset = CGSize(width: -15, height: 0)
                }
                
            }else{
                self.imgSlideShow.contentOffset = CGSize(width: 0, height: 0)
            }
            
            // New banner list with new disign change
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
                if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
                    if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                        self.imaSlideShowNew.contentOffset = CGSize(width: 15, height: 0)
                    }else{
                        self.imaSlideShowNew.contentOffset = CGSize(width: -15, height: 0)
                    }

                }else{
                    self.imaSlideShowNew.contentOffset = CGSize(width: 0, height: 0)
                }
            }
        }
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if(self.bannerTopCarosoulView22 == carousel && !ServiceModule.isDeliverAllOnly()){
           
            return value
        }else{
            if(option == .spacing){
                if UIDevice.current.userInterfaceIdiom == .pad {
                   return value * 1.02
                }else{
                    return value * 1.04
                }
            }
            return value
        }
        
    }
    
    
    
    // Code for the new Design set Parent Mode
    func setParentModeNewD(){
        
        
        self.eForVideoConsultation = ""
        self.homeTabBar.navItem.leftBarButtonItem = nil
        //self.scrollViewBottomSpace.constant = 0
         
        self.nextBtn.isHidden = true
        let backImg = UIImage(named: "ic_right_aarow")!
       // backImg = backImg.rotate(180)
        self.imgMore.image = backImg
        GeneralFunctions.setImgTintColor(imgView: self.imgMore, color: UIColor.lightGray)
        SDImageCache.shared().clearMemory()
        self.currentMode = "PARENT_MODE"
        //self.addTitleView()
        //self.noServiceAvailLbl.isHidden = true
        self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available.", key: "LBL_NO_SERVICE_AVAIL")
        self.ufxDataVerticalStackView.isHidden = false
        
        self.selectServiceLbl.layer.shadowOpacity = 0.0;
        self.selectServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "Our Services", key: "LBL_OUR_PRODUCTS")
        
        if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
            
//            if(self.currentMode != "SUB_MODE" || userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
//                self.setBannerData()
//            }
            
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_22").uppercased() == "YES"){
                self.setBannerData22()
                
            }else{
                if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() != "YES"){
                    self.setBannerData()
                }else{
                    self.setBannerDataNewD()
                }
            }
            
           // self.addMenu()
        }
        
        for subview in self.ufxDataVerticalStackView.subviews {
            subview.removeFromSuperview()
        }
        
        self.scrollView.scrollToTop()
        
        if(self.currentItems.count == 0 ){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available.", key: "LBL_NO_SERVICE_AVAIL")
            //self.noServiceAvailLbl.isHidden = false
        }
        
        if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
            //self.noServiceAvailLbl.isHidden = true
            rduView.isHidden = false
            
            //self.rduContentView.roundTo([.topRight, .topLeft], radius: 50)
            //self.rduView.roundTo([.topRight, .topLeft], radius: 50)
            
            self.scrollView.isHidden = true
            self.profileBottomView.roundTo(corners: [.topRight, .topLeft], radius: 25)
            
            let GRID_TILES_MAX_COUNT = GeneralFunctions.parseInt(origValue: 1, data: self.userProfileJson.get("GRID_TILES_MAX_COUNT"))
            
            var gridCount = 0
            var moreAvailable = false
            var nextGridIconsItems = [NSDictionary]()
            
            self.loadData()
//            for i in 0..<self.currentItems.count{
//                let item = self.currentItems[i]
//                let typeArray = item.get("eCatViewType").components(separatedBy: ",")
//                if(item.get("eShowType").uppercased() == "ICON" || item.get("eShowType").uppercased() == "ICON-BANNER"){
//                    if(gridCount < GRID_TILES_MAX_COUNT){
//                        listOfParentGridCategories.append(item)
//                    }else{
//                        nextGridIconsItems.append(item)
//                        moreAvailable = true
//                    }
//                    gridCount = gridCount + 1
//
//                    if(item.get("eShowType").uppercased() == "ICON-BANNER") || (item.get("eShowType").uppercased() == "ICON"){
//                        listOfParentListCategories.append(item)
//                        if (item.get("eCatType").uppercased() == "DELIVERALL") || (item.get("eCatType").uppercased() == "DELIVERY") || (item.get("eCatType").uppercased() == "MOREDELIVERY"){
//                            if(typeArray.contains("Icon")){
//                               iconOfDeliveryCategorirs.append(item)
//                            }
//                            if (typeArray.contains("Banner")){
//                                listOfDeliveryCategorirs.append(item)
//                            }
//                            if (typeArray.contains("List")){
//                                bannerOfDeliveryCategorirs.append(item)
//                                }
//                        }else if  (item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
//                            if(typeArray.contains("Icon")){
//                                iconOfService.append(item)
//                            }
//                            if (typeArray.contains("Banner")){
//                                listOfService.append(item)
//                            }
//                            if (typeArray.contains("List")){
//                                bannerOfService.append(item)
//                                }
//                        }else if(item.get("eCatType").uppercased() == "RIDE") || (item.get("eCatType").uppercased() == "MOTORIDE") ||  (item.get("eCatType").uppercased() == "RENTAL") || (item.get("eCatType").uppercased() == "MOTORENTAL") || (item.get("eCatType").uppercased() == "FLY"){
//
//                            if(typeArray.contains("Icon")){
//                                iconOfTexiDeliveris.append(item)
//                            }
//                            if (typeArray.contains("Banner")){
//                                listOfTexiDeliveris.append(item)
//                            }
//                            if (typeArray.contains("List")){
//                                bannerOfTexiDeliveris.append(item)
//                                }
//                        }
//                    }
//
//
//                }else{
//                    listOfParentListCategories.append(item)
//                    if (item.get("eCatType").uppercased() == "DELIVERALL") || (item.get("eCatType").uppercased() == "DELIVERY") || (item.get("eCatType").uppercased() == "MOREDELIVERY"){
//                        listOfDeliveryCategorirs.append(item)
//                    }else if  (item.get("eCatType").uppercased() == "DONATION"){
//
//                    }
//                    else{
//
//                        listOfTexiDeliveris.append(item)
//                    }
//
//                }
//
//                if item.get("eShowType").uppercased() != "BANNER"{
//                listOfParentAllCategories.append(item)
//                }
//            }
            
            if(moreAvailable){
                let moreCategory = NSMutableDictionary()
                moreCategory["eCatType"] = "More"
                moreCategory["vLogo_image"] = self.moreIconImage
                moreCategory["vCategory"] = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")
                listOfParentGridCategories.append(moreCategory)
            }
            
           // let count = listOfTexiDeliveris.count
            let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9") + 10
            
            var totalGridItems = gridCount > GRID_TILES_MAX_COUNT ? GRID_TILES_MAX_COUNT : gridCount
            
            if(gridCount > GRID_TILES_MAX_COUNT || moreAvailable){
                totalGridItems = totalGridItems + 1
            }
            let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
            
            //var numOfRow:Double = Double(iconOfTexiDeliveris.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(totalGridItems)/Double(totalItemInRow)
            //var numOfRow:Double = Double(listOfParentAllCategories.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(listOfParentAllCategories.count)/Double(totalItemInRow)
//            numOfRow = numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0)
//
//            if(numOfRow.truncatingRemainder(dividingBy: Double(totalGridItems)) != 0){
//                var numberOfRemainsItemsInRow = (totalItemInRow * Int(numOfRow)) - totalGridItems
//                let numberOfRemainsItemsInRowOrig = (totalItemInRow * Int(numOfRow)) - totalGridItems
//
//                var itemOfMore:NSDictionary!
//                if(moreAvailable){
//                    itemOfMore = listOfParentGridCategories[listOfParentGridCategories.count - 1]
//
//                    listOfParentGridCategories.remove(at: listOfParentGridCategories.count - 1)
//                }
//
//                var countOfRemains = 0
//                while(numberOfRemainsItemsInRow > 0){
//                    if(countOfRemains < nextGridIconsItems.count){
//                        listOfParentGridCategories.append(nextGridIconsItems[countOfRemains])
//                        numberOfRemainsItemsInRow = numberOfRemainsItemsInRow - 1
//                        countOfRemains = countOfRemains + 1
//                    }else{
//                        numberOfRemainsItemsInRow = 0
//                    }
//                }
//
//                if(itemOfMore != nil && numberOfRemainsItemsInRowOrig < nextGridIconsItems.count){
//                    listOfParentGridCategories.append(itemOfMore)
//                }
//            }
            
            if(listOfParentListCategories.count == 0 || self.listOfParentGridCategories.count == 0){
                self.rduSeperatorView.isHidden = true
            }
           // if(self.listOfParentGridCategories.count == 0){
            //    numOfRow = 0
           // }
           
//            if selectecSerivceIndex == 0 && listOfTexiDeliveris.count == 0{
//                self.noServiceAvailLbl.isHidden = false
//            }else if selectecSerivceIndex == 1 && listOfDeliveryCategorirs.count == 0 {
//                self.noServiceAvailLbl.isHidden = false
//            }else{
//                self.noServiceAvailLbl.isHidden = true
//            }
            
//            self.serviceColletionViewHight.constant = (CGFloat(numOfRow) * CGFloat(120))
//            self.rduContentViewHeight.constant = (height * CGFloat(count)) + (120 * CGFloat(bannerOfTexiDeliveris.count)) + (CGFloat(self.serviceColletionViewHight.constant)) +  (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom + 10) : 50)
//            self.rduScrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.rduContentViewHeight.constant + 50)
            //self.gettingCategoryHight()
            self.rduTableView.isHidden = false
            self.serviceCollectionView.isHidden = false
            self.rduScrollView.scrollToTop()
            self.rduTableView.reloadData()
            self.rduCollectionView.reloadData()
            self.serviceCollectionView.reloadData()
            
        }else{
            rduView.isHidden = true
            self.scrollView.isHidden = false
            
            let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
            //            let numOfRow = Int(((Double(self.currentItems.count) / Double(totalItemInRow)) < 1.0 ? 1.0 : (Double(self.currentItems.count) / Double(totalItemInRow))).roundTo(places: 0))
            
            let numOfRow:Double = Double(self.currentItems.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(self.currentItems.count)/Double(totalItemInRow)
            let numOfRow_int = Int(numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0))
            
            var currentIndex = 0
            var horizontalStackViewHeight:CGFloat = 0.0
            for _ in 0 ..< numOfRow_int{
                
                let horizontalStackView = (generalFunc.loadView(nibName: "UfxCategoryHorizontalStackViewDesign", uv: self).subviews[0]) as! UIStackView
                horizontalStackView.axis = .horizontal
                horizontalStackView.distribution  = UIStackView.Distribution.fillEqually
                horizontalStackView.spacing = 5
                
                for _ in 0 ..< totalItemInRow{
                    
                    if(currentIndex < self.currentItems.count){
                        
                        let parentGridView = self.generalFunc.loadView(nibName: "UFXJekIconCVC", uv: self) //UfxParentCategoryItemDesign
                        
                        parentGridView.tag = currentIndex
                        
                        //                        let parentTapGue = UITapGestureRecognizer()
                        //                        parentTapGue.addTarget(self, action: #selector(self.itemTapped(sender:)))
                        //                        parentGridView.addGestureRecognizer(parentTapGue)
                        
                        parentGridView.handleClick { (instance) in
                            self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                        }
                        
                        horizontalStackView.addArrangedSubview(parentGridView)
                        
                        //                        if(j == totalItemInRow - 1 || (currentIndex == (self.currentItems.count - 1))){
                        //                            (parentGridView.subviews[2]).isHidden = true
                        //                        }
                        //
                        //                        if(i == numOfRow - 1){ // && (currentIndex != (self.currentItems.count - 1))
                        //                            (parentGridView.subviews[3]).isHidden = true
                        //                        }
                        
                        let item = self.currentItems[currentIndex]
                        (parentGridView.subviews[0].subviews[1] as! MyLabel).text = item.get("vCategory")
                        
                        if(item.get("vCategory").contains(find: " ")){
                            (parentGridView.subviews[0].subviews[1] as! MyLabel).numberOfLines = 2
                        }else{
                            (parentGridView.subviews[0].subviews[1] as! MyLabel).numberOfLines = 1
                        }
                        
                        (parentGridView.subviews[0].subviews[1] as! MyLabel).textColor = UIColor(hex: 0x605F5F)
                        
                        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
                        
                        (parentGridView.subviews[0].subviews[0].subviews[0] as! UIImageView).sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            //                        GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
                        })
                        
                        parentGridView.subviews[0].subviews[0].layer.borderColor = UIColor(hex: 0xe4e4e4).cgColor
                        parentGridView.subviews[0].subviews[0].layer.borderWidth = 1
                        parentGridView.subviews[0].subviews[0].layer.masksToBounds = true
                        parentGridView.subviews[0].subviews[0].layer.cornerRadius = 15
                        
                    }else{
                        
                        let view = UIView()
                        view.backgroundColor = UIColor.clear
                        horizontalStackView.addArrangedSubview(view)
                        
                    }
                    currentIndex = currentIndex + 1
                    
                }
                horizontalStackViewHeight = horizontalStackViewHeight + horizontalStackView.frame.size.height - 5
                self.ufxDataVerticalStackView.addArrangedSubview(horizontalStackView)
                
            }
            ufxDataVerticalStackView.spacing = 0
            self.ufxDataVerticalStackView.frame.size = CGSize(width: self.view.frame.width, height: horizontalStackViewHeight)
            
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: horizontalStackViewHeight)
            
        }
        

    }
    // New design Parent mode top view handel with this function
    func setBannerDataNewD(){
            self.imageSlideShowBGView.backgroundColor = SColors.Theme
            
            self.imgSlideShowHeight.constant = Utils.getHeightOfBanner(widthOffset: 70, ratio: "16:9")
            self.imgSlideShowBGViewHeight.constant =  (self.imgSlideShowHeight.constant * 75) / 100
            
            self.imgSlideShow.backgroundColor = UIColor.clear
            if(self.imgSlideShow.currentItemIndex == 0 && self.bannersItemList.count > 1){
                self.imgSlideShow.contentOffset = CGSize(width: -15, height: 0)
            } else if self.bannersItemList.count == 1 {
                self.imgSlideShow.contentOffset = CGSize(width: 15, height: 0)
            }
        
            imgSlideShow.type = .linear
            imgSlideShow.scrollSpeed = 0.8
            imgSlideShow.decelerationRate = 0.8
            self.imgSlideShow.delegate = self
            self.imgSlideShow.dataSource = self
        
        if(self.imgSlideShow.currentItemIndex == 0 && self.bannersItemList.count > 1){
           // print(self.imgSlideShow.contentOffset)
            Utils.delayWithSeconds(0.2) {
                self.imgSlideShow.contentOffset = CGSize(width: -15, height: 0)
            }
           
        } else if self.bannersItemList.count == 1 {
            self.imgSlideShow.contentOffset = CGSize(width: 15, height: 0)
        }
            self.imgSlideShow.reloadData()
            //self.imgSlideShow.contentScaleM ode = .scaleToFill
            //self.imgSlideShow.setImageInputs(self.bannersItemList)
            if(self.currentMode != "SUB_MODE"){
               // self.imageSlideShowBGView.backgroundColor = SColors.Theme
                if(self.imaSlideShowNew.currentItemIndex == 0 && self.bannersItemList.count > 1){
                    self.imaSlideShowNew.contentOffset = CGSize(width: -15, height: 0)
                }
                self.imgSlideShowNewBg.backgroundColor = UIColor.clear
                self.imgSlideShowHightNew.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                self.imgSlideShowBgHight.constant =  (self.imgSlideShowHeight.constant * 75) / 100
                
                self.imaSlideShowNew.backgroundColor = UIColor.clear
              
                imaSlideShowNew.type = .linear
                imaSlideShowNew.scrollSpeed = 0.8
                imaSlideShowNew.decelerationRate = 0.8
                self.imaSlideShowNew.delegate = self
                self.imaSlideShowNew.dataSource = self
                self.imaSlideShowNew.reloadData()
              
            }
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderImgTapped))
            self.imgSlideShow.addGestureRecognizer(recognizer)
            
            if(self.bannersItemList.count > 0){
                
               
                self.rduScrollView.parallaxHeader.view = nil
                if(self.currentMode != "SUB_MODE"){
                   
                    self.containerView.backgroundColor = UIColor.white//UIColor.yellow
                    if self.isViewGone == false {
                    self.homeTabBar.navigationController?.isNavigationBarHidden = true
                    }else{
                        self.homeTabBar.navigationController?.isNavigationBarHidden = false
                    }
                        //do something if it's an instance of that class
                        //self.homeTabBar.navigationController?.isNavigationBarHidden = true
//                    if(GeneralFunctions.getVisibleViewController(Application.window!.rootViewController) != nil && GeneralFunctions.getVisibleViewController(Application.window!.rootViewController)!.className == "UFXHomeUV")
//                    {
//                        self.homeTabBar.navigationController?.isNavigationBarHidden = true
//                    }
//                    else{
//                        self.homeTabBar.navigationController?.isNavigationBarHidden = false
//                    }
                   //self.homeTabBar.navigationController?.navigationBar.barTintColor = UIColor.white

                    self.rduScrollView.parallaxHeader.view = imageProfileView
                    self.rduScrollView.parallaxHeader.mode = .bottom
                    self.rduScrollView.parallaxHeader.height = CGFloat(parallexHeaderHight)
                    self.rduScrollView.parallaxHeader.minimumHeight = (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? 80 : 60)//80
                        
                    self.rduScrollView.parallaxHeader.delegate = self
                    self.imgMore.isHidden = false
                    self.moreLbl.isHidden = false
                 
                    self.topOrangeView.isHidden = false
                    self.profileTopVIew.isHidden = false
                    self.locationView.isHidden = false
                    self.selectServiceHeader.isHidden = false
                    self.rduCollectionView.isHidden = false
                    self.oranngeBotoomView.isHidden = false
                    self.imageProfileView.frame.size = CGSize(width: self.imageProfileView.frame.width, height: 100)
                    self.view.layoutIfNeeded()
                    
                }else{
                    
                    self.homeTabBar.navigationController?.isNavigationBarHidden = false
                    //self.homeTabBar.navigationController?.navigationBar.barTintColor = SColors.Theme
                    self.setnavBarTintColor(color: SColors.Theme)
                    
                    self.containerView.backgroundColor = UIColor.clear
                    self.containerView.backgroundColor = UIColor.clear
                    self.scrollView.parallaxHeader.view = self.containerView
                    self.scrollView.parallaxHeader.mode = .bottom
                    self.scrollView.parallaxHeader.height = self.imgSlideShowHeight.constant + 50
                    self.scrollView.parallaxHeader.minimumHeight = 50
                    self.scrollView.parallaxHeader.delegate = self
                    self.containerView.frame.size = CGSize(width: self.view.frame.width, height: self.imgSlideShowHeight.constant + 50)
    //                self.rduView.backgroundColor = UIColor.white
    //                self.rduContentView.backgroundColor = UIColor.white
    //                self.scrollView.parallaxHeader.view = self.imageProfileView
    //
    //                self.scrollView.parallaxHeader.mode = .bottom
    //                self.scrollView.parallaxHeader.height = 500
    //                self.scrollView.parallaxHeader.minimumHeight = 500
    //                self.scrollView.parallaxHeader.delegate = self
    //                self.locationView.isHidden = true
    //                self.imgMore.isHidden = true
    //                self.moreLbl.isHidden = true
    //                self.oranngeBotoomView.isHidden = true
    //                self.topOrangeView.isHidden = true
    //                self.profileTopVIew.isHidden = true
    //                self.selectServiceHeader.isHidden = true
    //                self.rduCollectionView.isHidden = true
    //                self.imageProfileView.frame.size = CGSize(width: self.imageProfileView.frame.width, height: 40)
    //                self.view.layoutIfNeeded()
                }
                
               
                
            }else{
                
                
                if(self.currentMode != "SUB_MODE"){
                    
                    self.rduScrollView.parallaxHeader.view = nil
                    if self.isViewGone == false {
                    self.homeTabBar.navigationController?.isNavigationBarHidden = true
                    }else{
                        self.homeTabBar.navigationController?.isNavigationBarHidden = false
                    }
                    //self.homeTabBar.navigationController?.isNavigationBarHidden = true
                    //self.homeTabBar.navigationController?.navigationBar.barTintColor = UIColor.white
                    self.rduScrollView.parallaxHeader.view = imageProfileView
                    self.rduScrollView.parallaxHeader.mode = .bottom
                    self.imageProfileView.backgroundColor = UIColor(red: 243.0, green: 243.0, blue: 243.0, alpha: 1)
                    
                    //self.rduScrollView.parallaxHeader.height =  CGFloat(parallexHeaderHight)
                    if(self.userProfileJson.get("HOME_SCREEN_DESIGN_HEADER_VIEW") != "Profile"){
                    self.rduScrollView.parallaxHeader.height = (self.profileBottomView.height) + (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? 80 : 70)
                                         
                                       }else{
                    self.rduScrollView.parallaxHeader.height = CGFloat(parallexHeaderHight)
                                       }
                    self.rduScrollView.parallaxHeader.minimumHeight =  (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? 80 : 60)
                    self.rduScrollView.parallaxHeader.delegate = self
                    self.imgMore.isHidden = false
                    self.moreLbl.isHidden = false
                    self.oranngeBotoomView.isHidden = false
                    self.topOrangeView.isHidden = false
                    self.profileTopVIew.isHidden = false
                    self.locationView.isHidden = false
                    self.rduCollectionView.isHidden = false
                   // self.setApplicationStatusBar()
                    self.selectServiceHeader.isHidden = false
                    self.imageProfileView.frame.size = CGSize(width: self.imageProfileView.frame.width, height: 100)
                    self.view.layoutIfNeeded()
                    
                }else{
                    self.homeTabBar.navigationController?.isNavigationBarHidden = false
                    //self.homeTabBar.navigationController?.navigationBar.barTintColor = SColors.Theme
                    self.setnavBarTintColor(color: SColors.Theme)
                    self.containerView.backgroundColor = UIColor.clear
                    self.scrollView.parallaxHeader.view = self.containerView
                    self.scrollView.parallaxHeader.mode = .bottom
                    self.scrollView.parallaxHeader.height = 50
                    self.scrollView.parallaxHeader.minimumHeight = 50
                    self.scrollView.parallaxHeader.delegate = self
                    self.containerView.frame.size = CGSize(width: self.view.frame.width, height: 50)
    //                self.scrollView.parallaxHeader.view = nil
    //                self.homeTabBar.navigationController?.isNavigationBarHidden = false
    //                self.homeTabBar.navigationController?.navigationBar.barTintColor = SColors.Theme
    //
    //                self.imageProfileView.backgroundColor = self.scrollView.backgroundColor
    //                self.scrollView.parallaxHeader.view = imageProfileView
    //
    //                self.locationView.isHidden = true
    //                self.imgMore.isHidden = true
    //                self.moreLbl.isHidden = true
    //                self.oranngeBotoomView.isHidden = true
    //                self.topOrangeView.isHidden = true
    //                self.profileTopVIew.isHidden = true
    //                self.scrollView.parallaxHeader.mode = .bottom
    //                self.scrollView.parallaxHeader.height = 50
    //                self.scrollView.parallaxHeader.minimumHeight = 50
    //                self.scrollView.parallaxHeader.delegate = self
    //                self.rduCollectionView.isHidden = true
    //                self.selectServiceHeader.isHidden = true
    //                self.imageProfileView.frame.size = CGSize(width: self.imageProfileView.frame.width, height: 40)
                     
                    self.view.layoutIfNeeded()
                   
                     
                }

                
            }
        if(self.userProfileJson.get("HOME_SCREEN_DESIGN_HEADER_VIEW") != "Profile"){
            self.roundView.isHidden = true
            self.userNameLbl.isHidden = true
            self.userJoinLabel.isHidden = true
            self.topOrangeView.isHidden = true
            self.oranngeBotoomView.isHidden = true
            self.arrowRightTrailing.constant = 10
        }else{
            self.containerViewNewDesign.isHidden = true
        }
        self.setApplicationStatusBar()
            //self.topOrangeView.isHidden = true
           // self.oranngeBotoomView.isHidden = true
    }
//    func setApplicationStatusBar(){
//        if(self.navigationController?.navigationBar.isHidden == true){
//            Configurations.setStatusBarStyle(style: .default)
//        }else{
//            Configurations.setStatusBarStyle(style: SColors.ThemeSBStyle.uppercased() == "LIGHT" ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default)
//        }
//    }
    func setDataNewD()   {
        self.rduTableView.register(UINib(nibName: "UFXJekIconTVC", bundle: nil), forCellReuseIdentifier: "UFXJekIconTVC")
        self.rduTableView.register(UINib(nibName: "UFXJekIconTVCNew", bundle: nil), forCellReuseIdentifier: "UFXJekIconTVCNew")
        
        self.rduTableView.register(UINib(nibName: "UFXJekIconTVC", bundle: nil), forCellReuseIdentifier: "UFXJekIconTVC")
        self.rduCollectionView.register(UINib(nibName: "UFXServiceCVC", bundle: nil), forCellWithReuseIdentifier: "UFXServiceCVC")
        self.serviceCollectionView.register(UINib(nibName: "UFXJekIconCVC", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVC")
        scrollView.delegate = self
        rduScrollView.delegate = self
        self.rduTableView.isScrollEnabled = false
        self.serviceCollectionView.dataSource = self
        self.serviceCollectionView.delegate = self
        cateGoryArray = [self.generalFunc.getLanguageLabel(origValue: "TAXI", key: "LBL_TEXI_ADMIN").uppercased(),self.generalFunc.getLanguageLabel(origValue: "DELIVERY", key: "LBL_DELIVERY").uppercased(),self.generalFunc.getLanguageLabel(origValue: "SERVICES", key: "LBL_SERVICES").uppercased()]
        self.moreLbl.setClickHandler { (instance) in
            if self.moreServicesView == nil{
                self.addMoreServiceView()
            }

            self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
            self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
            self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
            self.moreServicesView.dragViewAnimatedTopMargin = 0
            self.btnSheetCollectionView.reloadData()
            self.moreServicesBGView.isHidden = false
            
        }
        self.imgMore.handleClick { (instance) in
           if self.moreServicesView == nil{
               self.addMoreServiceView()
           }

           self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
           self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
           self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
           self.moreServicesView.dragViewAnimatedTopMargin = 0
           self.btnSheetCollectionView.reloadData()
           self.moreServicesBGView.isHidden = false
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       
        if rduScrollView.isAtTop{
            self.rduScrollView.scrollToTop()
        }
        if self.scrollView.isAtTop{
            self.scrollView.scrollToTop()
        }
    }
    
//    func gettingCategoryHight()  {
//        var count = 0
//
//        let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9") + 10
//
//        //var totalGridItems = gridCount > GRID_TILES_MAX_COUNT ? GRID_TILES_MAX_COUNT : gridCount
//
//
//        let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
//
//        var numOfRow : Double!
//        var hightOfList : CGFloat!
//        count = bannerArray.count//listOfService.count
//
//        numOfRow = Double(iconArray.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(iconArray.count)/Double(totalItemInRow)
//        hightOfList = (120 * CGFloat(listArray.count))
//        numOfRow = numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0)
//        if iconArray.count == 0 {
//            self.serviceColletionViewHight.constant = 0
//        }else{
//        self.serviceColletionViewHight.constant = (CGFloat(numOfRow) * CGFloat(120))
//        }
//        if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S || UIDevice().type == .iPhoneSE) {
//
//            self.locationLblTraling.constant = 50
//             self.serviceCollectionViewWidth.constant = 300//100 * 3 + 50
//        }else{
//            self.serviceCollectionViewWidth.constant = CGFloat(100 * self.masterCateGory.count + 50)
//
//        }
//        self.rduContentViewHeight.constant = (height * CGFloat(count)) + hightOfList + (CGFloat(self.serviceColletionViewHight.constant)) +  (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom + 10) : 50)
//
//
//
//    self.rduScrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.rduContentViewHeight.constant)
//    }
//
    func loadData() {
        
        if !self.isFromLocation {
        self.iconArray.removeAll()
        self.bannerArray.removeAll()
        self.listArray.removeAll()
        self.listOfParentListCategories.removeAll()
        //let GRID_TILES_MAX_COUNT = GeneralFunctions.parseInt(origValue: 1, data: self.userProfileJson.get("GRID_TILES_MAX_COUNT"))
        
        //var gridCount = 0
       // var moreAvailable = false
        //var nextGridIconsItems = [NSDictionary]()
        if self.masterCateGory.count != 0 {
            let item = self.masterCateGory[selectecSerivceIndex]
           let subCate = item.arrOf("SubCategories") as! [NSDictionary]
            for i in 0..<subCate.count {
            let itemsub = subCate[i]
                let typeArray = itemsub.get("eCatViewType").components(separatedBy: ",")
                if(itemsub.get("eShowType").uppercased() == "ICON" || itemsub.get("eShowType").uppercased() == "ICON-BANNER"){
                    

                   
                    if(itemsub.get("eShowType").uppercased() == "ICON-BANNER") || (itemsub.get("eShowType").uppercased() == "ICON"){
                        listOfParentListCategories.append(itemsub)
                        
                            if(typeArray.contains("Icon")){
                                iconArray.append(itemsub)
                            }
                            if (typeArray.contains("Banner")){
                                bannerArray.append(itemsub)
                            }
                            if (typeArray.contains("List")){
                                listArray.append(itemsub)
                                }
                        
                    }
                  
                    
                }else{
                  
                    listOfParentListCategories.append(itemsub)
                    if(itemsub.get("eShowType").uppercased() == "BANNER"){
                        bannerArray.append(itemsub)
                    }
                    if(itemsub.get("eShowType").uppercased() == "LIST"){
                        listArray.append(itemsub)
                    }
//                        if(typeArray.contains("Icon")){
//                            iconArray.append(itemsub)
//                        }
//                        if (typeArray.contains("Banner")){
//                            bannerArray.append(itemsub)
//                        }
//                        if (typeArray.contains("List")){
                            //listArray.append(itemsub)
                          //  }
                    
                }
                
                if item.get("eShowType").uppercased() != "BANNER"{
                listOfParentAllCategories.append(item)
                }
        }
        }
        
//        if(moreAvailable){
//            let moreCategory = NSMutableDictionary()
//            moreCategory["eCatType"] = "More"
//            moreCategory["vLogo_image"] = self.moreIconImage
//            moreCategory["vCategory"] = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")
//            listOfParentGridCategories.append(moreCategory)
//        }
        
        let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9") + 10
        
        //var totalGridItems = gridCount > GRID_TILES_MAX_COUNT ? GRID_TILES_MAX_COUNT : gridCount
        
        //if(gridCount > GRID_TILES_MAX_COUNT || moreAvailable){
           // totalGridItems = totalGridItems + 1
        //}
            // view hight Calculate form here
        let totalItemInRow = Int(self.view.frame.width / 100) < 4 ? 4 : Int(self.view.frame.width / 100)
        
        var numOfRow:Double = Double(iconArray.count)/Double(totalItemInRow) < 1 ? Double(1.0) : Double(iconArray.count)/Double(totalItemInRow)
        numOfRow = numOfRow.rounded() >= numOfRow ? numOfRow.rounded() : (numOfRow.rounded() + 1.0)
        
//        if(numOfRow.truncatingRemainder(dividingBy: Double(totalGridItems)) != 0){
//            var numberOfRemainsItemsInRow = (totalItemInRow * Int(numOfRow)) - totalGridItems
//            let numberOfRemainsItemsInRowOrig = (totalItemInRow * Int(numOfRow)) - totalGridItems
            
//            var itemOfMore:NSDictionary!
//            if(moreAvailable){
//                itemOfMore = listOfParentGridCategories[listOfParentGridCategories.count - 1]
//
//                listOfParentGridCategories.remove(at: listOfParentGridCategories.count - 1)
//            }
            
//            var countOfRemains = 0
//            while(numberOfRemainsItemsInRow > 0){
//                if(countOfRemains < nextGridIconsItems.count){
//                    listOfParentGridCategories.append(nextGridIconsItems[countOfRemains])
//                    numberOfRemainsItemsInRow = numberOfRemainsItemsInRow - 1
//                    countOfRemains = countOfRemains + 1
//                }else{
//                    numberOfRemainsItemsInRow = 0
//                }
//            }
//
//            if(itemOfMore != nil && numberOfRemainsItemsInRowOrig < nextGridIconsItems.count){
//                listOfParentGridCategories.append(itemOfMore)
//            }
//        }
        let count = bannerArray.count
        var hightOfList : CGFloat!
        hightOfList = (CGFloat(LIST_TABLE_CELL_HIGHT) * CGFloat(listArray.count))
        if iconArray.count == 0 {
            self.serviceColletionViewHight.constant = 0
        }else{
        self.serviceColletionViewHight.constant = (CGFloat(numOfRow) * CGFloat(120))
        }
        self.rduContentViewHeight.constant = (height * CGFloat(count)) + hightOfList + self.serviceColletionViewHight.constant //+ (GeneralFunctions.getSafeAreaInsets().bottom > 0 ? (GeneralFunctions.getSafeAreaInsets().bottom) + 20 : 50)
        
        
        
        self.rduScrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.rduContentViewHeight.constant)
        
        self.rduScrollView.scrollToTop()
        self.rduTableView.reloadData()
        self.rduCollectionView.reloadData()
        
        if listArray.count == 0  {
            self.rduContentView.backgroundColor = UIColor.white
            self.rduContentView.cornerRadius = 10
            self.rduContentViewleading.constant = 10
            self.rduContentViewTraling.constant = 10
            self.rduContentView.layer.addShadow(opacity: 0.7, radius: 1)
            self.rduContentView.layer.shadowColor = UIColor.gray.cgColor
            //self.serviceCollectionView.backgroundColor = UIColor.white
        }else{
            //self.serviceCollectionView.backgroundColor = UIColor.clear
            self.rduContentView.backgroundColor = UIColor.clear
            self.rduContentView.cornerRadius = 0
            self.rduContentViewleading.constant = 0
            self.rduContentViewTraling.constant = 0
        }
        
    if (UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S || UIDevice().type == .iPhoneSE) {
       
        self.serviceCollectionViewWidth.constant = CGFloat(100 * self.masterCateGory.count)
        roundViewHight.constant = 100
        roundViewWidth.constant = 100
        roundImageViewHight.constant = 85
        roundImageViewWidth.constant = 85
       
    }else{
        self.serviceCollectionViewWidth.constant = CGFloat(serviceCollectionWidth * self.masterCateGory.count + 50)
        
    }
   
        }else{
            self.isFromLocation = false
        }
    }
    func setApplicationStatusBar(){
        Utils.delayWithSeconds(1) {
            if(self.navigationController?.navigationBar.isHidden == true){
               Configurations.setStatusBarStyle(style: .default)
            }else{
                Configurations.setStatusBarStyle(style: SColors.ThemeSBStyle.uppercased() == "LIGHT" ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default)
            }
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        
        var bottomBarHeight = 0.0
        if(self.homeTabBar != nil){
            bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 50 + self.topbarHeight)
        }
       
        bannerView.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)
        self.cntView.addSubview(bannerView)

    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        
        self.tableView22Height.constant = self.tableView22Height.constant + 50
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
        
        self.tableView22Height.constant = self.tableView22Height.constant + 50
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
        
        self.cntView.addSubview(adView)
    }
}



extension UFXHomeUV: UISearchBarDelegate{
    
    
    func setBannerData22(){
        

        self.bannerTopView22.backgroundColor = UIColor.white
            
        self.bannerTopCarosoulView22.backgroundColor = UIColor.clear
            
        self.bannerTopCarosoulView22.type = .linear
        self.bannerTopCarosoulView22.scrollSpeed = 0.8
        self.bannerTopCarosoulView22.decelerationRate = 0.8
        self.bannerTopCarosoulView22.delegate = self
        self.bannerTopCarosoulView22.dataSource = self
        self.bannerTopCarosoulView22.bounces = false
        if Configurations.isRTLMode() {
            self.bannerTopCarosoulView22.scrollToItem(at: self.currentBannerScrollIndex, animated: true)
        }
        self.bannerTopCarosoulView22.reloadData()
          
        if(self.isAllIn1Medical){
            self.allIn1MedicalCollectionView.parallaxHeader.view = nil
        }
        
        self.tableView22.parallaxHeader.view = nil
        self.scrollView.parallaxHeader.view = nil
        if(self.bannersItemList.count > 0){
            if(self.currentMode != "SUB_MODE"){
                
                self.bannerTopView22.isHidden = false
                //self.bannerTopView22Height.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
                
                self.bannerTopView22Height.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "",2.33)
                
                self.bannerTopCarosoulView22Height.constant =  self.bannerTopView22Height.constant
                
                if(self.isAllIn1Medical){
                    
                    self.allIn1MedicalCollectionView.isHidden = false
                    self.allIn1MedicalCollectionView.parallaxHeader.view = self.bannerTopView22
                    self.allIn1MedicalCollectionView.parallaxHeader.mode = .bottom
                    self.allIn1MedicalCollectionView.parallaxHeader.height = self.bannerTopView22Height.constant
                    self.allIn1MedicalCollectionView.parallaxHeader.minimumHeight = 0
                    self.allIn1MedicalCollectionView.parallaxHeader.delegate = self
                }else{
                    self.tableView22BGView.isHidden = false
                    self.tableView22.isHidden = false
                    self.tableView22.parallaxHeader.view = self.bannerTopView22
                    self.tableView22.parallaxHeader.mode = .bottom
                    self.tableView22.parallaxHeader.height = self.bannerTopView22Height.constant
                    self.tableView22.parallaxHeader.minimumHeight = 0
                    self.tableView22.parallaxHeader.delegate = self
                }
              
            }else{
                //self.bannerTopView22.isHidden = true
                if(self.isAllIn1Medical){
                    self.allIn1MedicalCollectionView.isHidden = true
                }
                self.tableView22.isHidden = true
                self.tableView22BGView.isHidden = true
            
                self.bannerTopView22Height.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
        
                self.scrollView.parallaxHeader.view = self.bannerTopView22
                self.scrollView.parallaxHeader.mode = .bottom
                self.scrollView.parallaxHeader.height = self.bannerTopView22Height.constant
                self.scrollView.parallaxHeader.minimumHeight = 0
                self.scrollView.parallaxHeader.delegate = self
                

            }
        }else{
            if(self.currentMode != "SUB_MODE"){
                
                self.bannerTopView22.isHidden = false
                
                self.bannerTopView22.backgroundColor = SColors.Theme
                self.bannerTopView22Height.constant = 70
                self.bannerTopCarosoulView22Height.constant =  0
                
                if(self.isAllIn1Medical){
                    self.allIn1MedicalCollectionView.parallaxHeader.view = self.bannerTopView22
                    self.allIn1MedicalCollectionView.isHidden = false
                    self.allIn1MedicalCollectionView.parallaxHeader.mode = .bottom
                    self.allIn1MedicalCollectionView.parallaxHeader.height = self.bannerTopView22Height.constant
                    self.allIn1MedicalCollectionView.parallaxHeader.minimumHeight = 0
                }else{
                    self.tableView22.parallaxHeader.view = self.bannerTopView22
                    self.tableView22BGView.isHidden = false
                    self.tableView22.isHidden = false
                    self.tableView22.parallaxHeader.mode = .bottom
                    self.tableView22.parallaxHeader.height = self.bannerTopView22Height.constant
                    self.tableView22.parallaxHeader.minimumHeight = 0
                }
              
            }else{
                
                if(self.isAllIn1Medical){
                    self.allIn1MedicalCollectionView.isHidden = true
                }
                self.bannerTopView22.isHidden = true
                self.tableView22.isHidden = true
                self.tableView22BGView.isHidden = true
                
                self.homeTabBar.navigationController?.isNavigationBarHidden = false
                //self.homeTabBar.navigationController?.navigationBar.barTintColor = SColors.Theme
                self.setnavBarTintColor(color: SColors.Theme)
                self.containerView.backgroundColor = UIColor.clear
                self.scrollView.parallaxHeader.view = self.containerView
                self.scrollView.parallaxHeader.mode = .bottom
                self.scrollView.parallaxHeader.height = 0
                self.scrollView.parallaxHeader.minimumHeight = 0
                self.scrollView.parallaxHeader.delegate = self
                self.containerView.frame.size = CGSize(width: self.view.frame.width, height: 0)

                self.view.layoutIfNeeded()

            }
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.sliderImgTapped))
        self.imgSlideShow.addGestureRecognizer(recognizer)
      
    
        self.addTable22SubViews()
        
        

        if(self.userProfileJson.get("ENABLE_APP_HOME_SCREEN_SEARCH").uppercased() == "YES"){
            self.addSearhBar()
        }
        
        self.tableView22.reloadData()
        if(self.isAllIn1Medical){
            self.allIn1MedicalCollectionView.reloadData()
        }
    }
    
    
    func addTable22SubViews(){
        
        if(self.shadowImageView != nil){
            self.shadowImageView.removeFromSuperview()
            self.shadowImageView = nil
        }
        self.shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: -45, width: Application.screenSize.width, height: 50))
    
        if(self.grayBGApplied){
            shadowImageView.image = UIImage(named: "ic_shadow_3")
        }else{
            shadowImageView.image = UIImage(named: "shadow1")
        }
        
        if(self.isAllIn1Medical){
            shadowImageView.image = UIImage(named: "ic_shadow_3")
            self.allIn1MedicalCollectionView.addSubview(shadowImageView)
        }else{
            if(!ServiceModule.isDeliverAllOnly()){
                self.tableView22.addSubview(shadowImageView)
            }
            
        }
        
        if(self.shadowImageViewForSubCat != nil){
            self.shadowImageViewForSubCat.removeFromSuperview()
            self.shadowImageViewForSubCat = nil
        }
        self.shadowImageViewForSubCat = UIImageView.init(frame: CGRect(x: 0, y: -45, width: Application.screenSize.width, height: 50))
        shadowImageViewForSubCat.image = UIImage(named: "shadow_gray")
        
        self.scrollView.addSubview(shadowImageViewForSubCat)
    
        
        self.addTitleView22()
    }
    
    func addTitleView22(){
        
        if(self.titleView22 != nil){
            self.titleView22.removeFromSuperview()
            self.titleView22 = nil
        }
        
        
        self.titleView22 = generalFunc.loadView(nibName: "UFXHomeTitleView", uv: self, isWithOutSize: true)
        
        titleView22.frame = CGRect(x: 10, y: 0, width: Application.screenSize.width - 20, height: 50)
        //        titleView.subviews[2].transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        (titleView22.subviews[0] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOCATION_FOR_AVAILING_TXT")
        (titleView22.subviews[1] as! MyLabel).text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
        (titleView22.subviews[2] as! UIImageView).transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
       
            GeneralFunctions.setImgTintColor(imgView: (titleView22.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: (titleView22.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
            (titleView22.subviews[0] as! MyLabel).textColor = SColors.ThemeTxt
            (titleView22.subviews[1] as! MyLabel).textColor = SColors.ThemeTxt
        
        //GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[3] as! UIImageView), color: SColors.ThemeTxt)
    
        //GeneralFunctions.setImgTintColor(imgView: (titleView.subviews[2] as! UIImageView), color: SColors.ThemeTxt)
        self.enterLocLbl = (titleView22.subviews[1] as! MyLabel)
        //self.enterLocLbl.textColor = SColors.Theme
        self.enterLocLbl.numberOfLines = 1
    
        if self.homeTabBar != nil {

            self.homeTabBar.navItem.titleView = titleView22
        }
        
        
        let titleViewTapGue = UITapGestureRecognizer()
        titleViewTapGue.addTarget(self, action: #selector(self.titleViewTapped))

        titleView22.isUserInteractionEnabled = true
        titleView22.addGestureRecognizer(titleViewTapGue)
        
        if(self.selectedAddress != ""){
            self.enterLocLbl.text = self.selectedAddress
        }
        
        if(self.homeTabBar != nil && self.currentMode == "PARENT_MODE"){
            self.homeTabBar.navItem.leftBarButtonItem = nil
        }
       
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
            self.locationLbl.textColor = UIColor.black
            self.locationLbl.handleClick { (instance) in
                self.titleViewTapped()
            }
            if(self.selectedAddress != ""){
                self.enterLocLbl.text = self.selectedAddress
                self.locationLbl.text = self.selectedAddress
            }
        }
        
    }
    
    func addSearhBar(){
        if (GeneralFunctions.parseDouble(origValue: 0.0, data: userProfileJson.get("UBERX_CAT_ID"))) > 0 {
            if(self.searchBar != nil){
                self.searchBar.isHidden = true
            }
        }else {
        if(self.searchBar == nil){
            self.searchBar = UISearchBar()
            
            self.searchBar.sizeToFit()
            self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_Search")
            self.searchBar.delegate = self
            
            searchBar.backgroundImage = UIImage()
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            
            self.searchBar.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: SColors.Theme), for: .search, state: .normal)
            self.tableView22.keyboardDismissMode = .onDrag
            
            self.searchBar.cornerRadius = 8
            self.searchBar.clipsToBounds = true
            self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_SERVICES")
        
           
            self.searchBar.frame = CGRect(x: 15, y: self.bannersItemList.count > 0 ? (0 - (Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9") + 10)) : -65, width: Application.screenSize.width - 30, height: 40)
           // self.searchBar.frame.size = CGSize(width: Application.screenSize.width - 30, height: 40)

            
            self.tableView22.addSubview(self.searchBar)
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.handleClick { (view) in
                    self.openSearchSearvices()
                }

            } else {
                // Fallback on earlier versions
                for subview in searchBar.subviews {
                    print (subview)
                    
                    for view in subview.subviews {
                        if let searchField = view as? UITextField {
                            searchField.backgroundColor = UIColor.white
                            searchField.handleClick { (view) in
                                self.openSearchSearvices()
                            }
                            
                        }
                    }
                }
            }

            print(self.tableView22.subviews)
        }
        }
    }
    
    func openSearchSearvices()  {
        let searchSearvicesUV = GeneralFunctions.instantiateViewController(pageName: "SearchSearvicesUV") as! SearchSearvicesUV
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        self.push(uv: searchSearvicesUV)
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        //view.shadowPath = UIBezierPath(roundedRect:view.bounds, cornerRadius:view.layer.cornerRadius).cgPath
    }
    func handleMore()   {
        if self.moreServicesView == nil{
            self.addMoreServiceView()
        }

        self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
        if isMedicalServices {
        self.moreServicesView.isFromMoremedical = true
        self.moreServicesView.dragViewAnimatedTopMargin = 0//Application.screenSize.height - 350
        self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
        self.moreServicesView.dragViewAnimatedTopMargin = 0
        }else{
            self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
            self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
            self.moreServicesView.dragViewAnimatedTopMargin = 0
        }
        self.btnSheetCollectionView.reloadData()
        self.btnSheetCollectionView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.moreServicesView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.moreServicesBGView.isHidden = false
    }
    
    func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }

    func handleBiddingCategory()   {

        for i in 0..<self.currentItems.count{
            let item = currentItems[i]
            let viewTemp = viewArray[i]
            if self.biddingID == item.get("iBiddingId"){
                ((viewTemp.subviews[6]) as! UIImageView).image = UIImage(named:"ic_select_true")
                GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)
                (viewTemp.subviews[5]).backgroundColor = SColors.Theme
                //self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                (viewTemp.subviews[1] as! UILabel).textColor = SColors.Theme
            }else{
                ((viewTemp.subviews[6])as! UIImageView).image = UIImage(named:"ic_select_false")
                GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)

                (viewTemp.subviews[5]).backgroundColor = UIColor.white
                (viewTemp.subviews[1] as! UILabel).textColor = UIColor.black
            }
            
        }
    }
    func openSmartLogin() {
    let openListView = OpenListView(uv: self, containerView: self.view)
    openListView.openNewList = true
    //openListView.isFromDate = true
    openListView.showCameraSheet(currentInst: openListView, handler: { (selectedItemId) in
                  
    
    
                })
    }
    func setPageController(){
        
       
        self.pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.bannersItemList.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor:
                                                                SColors.Theme, dotsColor: UIColor.white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        //self.pageController.setPage(0)
        if bannerTopCarosoulView22 != nil {
            bannerTopCarosoulView22.currentItemIndex = 0
        }
        if Configurations.isRTLMode() {
           
            self.pageController.setPage(currentBannerScrollIndex)
           
        }else{
            self.pageController.setPage(0)
        }
        pageController.backgroundColor =  UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.5)
       
        pageController.layer.cornerRadius = 8
        pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        
        pageControllerWidth.constant = CGFloat((self.bannersItemList.count * 15) + 15)
        if pageControllerWidth.constant > Application.screenSize.width {
            pageControllerWidth.constant = Application.screenSize.width - 40
        }
        self.pageController.numberOfPages = self.bannersItemList.count
    }
    @objc func autoScroll()   {
        if self.bannersItemList.count > 1 {
           
            if Configurations.isRTLMode() {
                if(self.bannerTopCarosoulView22 != nil && self.firstTimeBannerScroll == false){
                    if(self.bannerTopCarosoulView22.currentItemIndex == 0){
                        self.currentBannerScrollIndex = self.bannersItemList.count
                    }else{
                        self.currentBannerScrollIndex = self.bannerTopCarosoulView22.currentItemIndex
                    }
                    
                    self.currentBannerScrollIndex = self.currentBannerScrollIndex - 1
                    self.bannerTopCarosoulView22.scrollToItem(at: self.currentBannerScrollIndex, animated: true)
                }else{
                    self.firstTimeBannerScroll = false
                }
            }else{
        if(self.bannerTopCarosoulView22 != nil && self.firstTimeBannerScroll == false){
            if(self.bannersItemList.count - 1 == self.bannerTopCarosoulView22.currentItemIndex){
                self.currentBannerScrollIndex = -1
            }else{
                self.currentBannerScrollIndex = self.bannerTopCarosoulView22.currentItemIndex
            }
            self.currentBannerScrollIndex = self.currentBannerScrollIndex + 1
            self.bannerTopCarosoulView22.scrollToItem(at: self.currentBannerScrollIndex, animated: true)
        }else{
            self.firstTimeBannerScroll = false
        }
            }
        }else{
            timerScroll.invalidate()
        }
    }
}
   extension UFXHomeUV{
    
    func subServicesResponseHandling(){
        
        for i in 0..<self.tableDataArrayFor22.count{
            let item = self.tableDataArrayFor22[i]
            if item.get("eType").uppercased() == "UBERX" {

                self.moreDataFor22 =  item.arrOf("SubCategories") as! [NSDictionary]
                // Cache Data
                GetServicesData.getInstance().getCategoriesData(lat: self.selectedLatitude, long: self.selectedLongitude, servicesArrayDic: self.moreDataFor22)

            }

            if item.get("eType").uppercased() == "BIDDING" {

                // Cache Data
                GetServicesData.getInstance().getCategoriesDataForBidding(lat: self.selectedLatitude, long: self.selectedLongitude, servicesArrayDic: item.arrOf("SubCategories") as! [NSDictionary])

            }

            if item.get("eType").uppercased() == "VIDEOCONSULT" {

                // Cache Data
                GetServicesData.getInstance().getCategoriesDataForVideo(lat: self.selectedLatitude, long: self.selectedLongitude, servicesArrayDic: item.arrOf("SubCategories") as! [NSDictionary])

            }
        }
    }
    
    func loadProviders(vCatID:String){
        
       // LoadProviders.getInstance().getProvidersData(lat: self.selectedLatitude, long: self.selectedLongitude, vCatID: vCatID, pAdd: self.selectedAddress)
    }
    
    
    
    
}
