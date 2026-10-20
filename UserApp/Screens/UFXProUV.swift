//
//  UFXProUV.swift
//  UserApp
//
//  Created by Apple on 13/12/22.
//

import UIKit
import SysBaseLib
import CoreLocation
import GoogleMobileAds
import FBAudienceNetwork
import AdSupport
import AdvancedPageControl
import WebKit

struct UFXProTitleView{
    var eViewType = ""
    var titleText = ""
    var subTitleText = ""
    var vImage = ""
    var isShowAll = ""
    var topPadding = ""
}

struct UFXProBannerView{
    var isScroll = false
    var bannerHeight = 0.0
    var bannerWidth = 0.0
    var imagesArray = [NSDictionary]()
    var displayCount = 1
    var isFullWidth = false
    var isBookBtn = false
    var bookBtnTxt = ""
    var isClickable = false
    var isOnlyImage = false
    var AddTopPadding = false
    var AddBottomPadding = false
    var eServiceType : String = ""
    var displaySize = ""
}
struct UFXProDestinationView{
    var titleText = ""
    var subTitleText = ""
    var isWhereToViewShow = false
    var destLat = ""
    var destLong = ""
    
}
struct RideDeliveryBoxView{
    var servicesArray = [NSDictionary]()
    
}
struct ParcelDeliveryGridView{
    var servicesArray = [NSDictionary]()
    
}
struct UFXProVBoxView{
    var servicesArray = [NSDictionary]()
}
struct UFXProListView{
    var servicesArray = NSDictionary()
}
struct UFXProServiceBannerStyleView{
    var servicesArray = [UFXProServiceBanner]()
    var displayCount = 1
    var isFullWidth = false
    var bannerHeight = 0.0
    var bannerWidth = 0.0
    var isClickable = false
}

struct UFXProServiceBanner{
    var bannerIcon = ""
    var bannerIconAllignment = "right"
    var bannerTitletxt = ""
    var bannerSubTitleTxt = ""
    var bannerSubServices = [NSDictionary]()
    var bannerBgColor = ""
    var vCategoryTitle = ""
    
}

struct UFXProHBoxView{
    var servicesArray = [NSDictionary]()
}


class UFXProUV: ParentViewUV,ParentViewUVDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, OnLocationUpdateDelegate, AddressFoundDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GADBannerViewDelegate, FBAdViewDelegate, iCarouselDataSource, iCarouselDelegate,MyBtnClickDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLogo: UIImageView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewSearchBg: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTitleLbl: MyLabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var locationImgView: UIImageView!
    @IBOutlet weak var downArrowImgView: UIImageView!
    @IBOutlet weak var tableViewBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var mainPHView: UIView!
    @IBOutlet weak var phView1: UIView!
    @IBOutlet weak var phView2: UIView!
    @IBOutlet weak var phView3: UIView!
    @IBOutlet weak var phView4: UIView!
    @IBOutlet weak var phView5: UIView!
    @IBOutlet weak var phView6: UIView!
    @IBOutlet weak var phView7: UIView!
    @IBOutlet weak var phView8: UIView!
    @IBOutlet weak var phView9: UIView!
    @IBOutlet weak var phView13: UIView!
    @IBOutlet weak var phView14: UIView!
    
    // Ride Delivery Related Outlet
    
    @IBOutlet weak var welcomeLbl: MyLabel!
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var whereToView: UIView!
    @IBOutlet weak var whereToLbl: MyLabel!
    @IBOutlet weak var nowLbl: MyLabel!
    @IBOutlet weak var nowView: UIView!
    @IBOutlet weak var transParentViewHight: NSLayoutConstraint!
    @IBOutlet weak var userNameY: NSLayoutConstraint!
    @IBOutlet weak var tblViewTop: NSLayoutConstraint!
    var cntView:UIView!
    var enterLocLbl:MyLabel!
    var locationDialog:OpenEnableLocationView!
    var getLocation:DeviceLocation!
    var getAddressFrmLocation:GetAddressFromLocation!
    
    let generalFunc = GeneralFunctions()
    var homeTabBar:HomeScreenTabBarUV!
    var userProfileJson:NSDictionary!
    
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var currentLocation:CLLocation!
    
    var tableTopInset = 40.0
    
    var servicesRowDataArray = NSMutableArray()
    
    var moreServicesView:SDragViewForMoreServices!
    var moreServicesBGView:UIView!
    var btnSheetCollectionView:UICollectionView!
    
    var selectedServiceParentID = ""
    var selectedCategoryIds = [NSMutableDictionary]()
    var moreDataFor22 = [NSDictionary] ()
    var moreTitle = ""
    var uFXProBannerView = UFXProBannerView()
    
    var bannerView: GADBannerView!
    var adView: FBAdView?
    
    var placeholderMarker:Placeholder!
    
    var isFrameSet = false
    var isFirstLoc = false
    var tempLbl = MyLabel()
    
    var isGoogleAdLoad = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if (type == 0) {
            
            if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
                cntView = self.generalFunc.loadView(nibName: "RideDeliveryNewHomeScreenDesign", uv: self, contentView: contentView)
            } else if ServiceModule.serviceProviderProduct {
                cntView = self.generalFunc.loadView(nibName: "UberXScreenDesign", uv: self, contentView: contentView)
            } else{
                cntView = self.generalFunc.loadView(nibName: "UFXProScreenDesign", uv: self, contentView: contentView)
            }
          
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            self.contentView.addSubview(cntView)
            if ServiceModule.deliveryProduct{
                self.view.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
                self.tableView.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
            }
           
            
            if(GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") != nil && (GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") as! String) != ""){
                
                let ratingUV = GeneralFunctions.instantiateViewController(pageName: "RatingUV") as! RatingUV
                ratingUV.iTripId = (GeneralFunctions.getValue(key: "OPEN_RATING_SCREEN") as! String)
                
                GeneralFunctions.removeValue(key: "OPEN_RATING_SCREEN")
                self.push(uv:ratingUV, isDirect: true)
            }
            
            self.mainPHView.isHidden = false
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.setData()
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "SERVICE_HOME_DATA") && GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String != ""){
                
                let dataDict = (GeneralFunctions.getValue(key: "SERVICE_HOME_DATA") as! String).toDict()
                if(dataDict.get("Action") == "1"){
                    
                    self.setRowDataArray(dataDic:dataDict)
                    
                }
            }
            
        }else if (type == 1) {
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.tableView.isHidden = false
            self.headerView.isHidden = false
            self.configRTL()
            
            if ServiceModule.deliveryKing || ServiceModule.deliveryProduct{
               
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated: false)
                
            }else{
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.navigationItem.setHidesBackButton(true, animated: false)
            }
            
        }else if (type == 2) {
            
            
            if(currentLocation == nil){
                self.checkLocationEnabled()
            }
            
            if(isFrameSet == false){
                self.isFrameSet = true
                cntView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
                self.contentView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
                NotificationCenter.default.addObserver(self, selector: #selector(self.appInForground), name: NSNotification.Name(rawValue: Utils.appFGNotificationKey), object: nil)
            }
            
            if  ServiceModule.rideDeliveryProduct || ServiceModule.cubex || ServiceModule.rideProduct {
                self.userNameLbl.text = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
            }
            
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
            
            self.setAdView()
            
            //  self.tableView.reloadData()
            if ServiceModule.deliveryKing || ServiceModule.deliveryProduct{
                self.addTitleView()
            }
            
            
            
            
        }else if (type == 3) {
            self.tableView.isHidden = true
            self.headerView.isHidden = true
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    override func viewDidLayoutSubviews() {
        
        if #available(iOS 11.0, *) {
            let topSafeArea = view.safeAreaInsets.top
            print(topSafeArea)
            if topSafeArea <= 20 {
                if  ServiceModule.rideProduct {
                    self.userNameY.constant =  -10
                    self.headerViewHeight.constant = 160
                }
            }
        }
        
        
    }
    
    func setData(){
        //GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: "" as AnyObject)
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        self.setHeaderView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {}
        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
            self.tableView.contentInset = UIEdgeInsets(top: tableTopInset, left: 0, bottom: 00, right: 0)
        }else{
            self.tableView.contentInset = UIEdgeInsets(top: tableTopInset, left: 0, bottom: 40, right: 0)
        }
        self.tableView.register(UINib(nibName: "UFXProTitleViewTVCell", bundle: nil), forCellReuseIdentifier: "UFXProTitleViewTVCell")
        self.tableView.register(UINib(nibName: "UFXProBannerViewTVCell", bundle: nil), forCellReuseIdentifier: "UFXProBannerViewTVCell")
        self.tableView.register(UINib(nibName: "UFXProCarosulBannerViewTVCell", bundle: nil), forCellReuseIdentifier: "UFXProCarosulBannerViewTVCell")
        self.tableView.register(UINib(nibName: "UFXProVBoxTVCell", bundle: nil), forCellReuseIdentifier: "UFXProVBoxTVCell")
        self.tableView.register(UINib(nibName: "UFXProServiceBannerTVCell", bundle: nil), forCellReuseIdentifier: "UFXProServiceBannerTVCell")
        self.tableView.register(UINib(nibName: "UFXProHBoxTVCell", bundle: nil), forCellReuseIdentifier: "UFXProHBoxTVCell")
        self.tableView.register(UINib(nibName: "UfxProRecentLocationTVCell", bundle: nil), forCellReuseIdentifier: "UfxProRecentLocationTVCell")
        self.tableView.register(UINib(nibName: "RideDeliveryProBoxTVCell", bundle: nil), forCellReuseIdentifier: "RideDeliveryProBoxTVCell")
        self.tableView.register(UINib(nibName: "UFXProListTVCell", bundle: nil), forCellReuseIdentifier: "UFXProListTVCell")
        self.tableView.register(UINib(nibName: "ParcelListTVC", bundle: nil), forCellReuseIdentifier: "ParcelListTVC")
        self.tableView.register(UINib(nibName: "ParcelDeliveryBoxTVC", bundle: nil), forCellReuseIdentifier: "ParcelDeliveryBoxTVC")
        getLocation = DeviceLocation(uv: self, isContinuous: false)
        getLocation.buildLocManager(locationUpdateDelegate: self)
        
        if self.userProfileJson.get("isSmartLoginEnable").uppercased() == "YES" {
            if (GeneralFunctions.isKeyExistInUserDefaults(key: "IS_POPUP_SHOW") == false || GeneralFunctions.getValue(key: "IS_POPUP_SHOW") as! Bool == true){
                if GeneralFunctions.isQuickLogInEnable(){
                    
                }else{
                    GeneralFunctions.saveValue(key: "IS_POPUP_SHOW", value: false as AnyObject)
                    self.openSmartLogin()
                }
            }
        }
        
    }
    
    func openSmartLogin() {
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.openNewList = true
        openListView.showCameraSheet(currentInst: openListView, handler: { (selectedItemId) in
        })
    }
    
    func setPlaceHolderView(){
        
        self.mainPHView.isHidden = false
        
        placeholderMarker = Placeholder()
        let viewElements: [UIView] = [phView1, phView2, phView3, phView4, phView5, phView6, phView7, phView8, phView9, phView13, phView14]
        
        placeholderMarker.register(viewElements)
        placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.mainPHView != nil){
            self.contentView.isHidden = false
            self.mainPHView.isHidden = true
        }
    }
    
    func setAdView(){
           
           userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
           if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes" || userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") {
               
               if(userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes"){
                   self.tableViewBottomSpace.constant = self.tableViewBottomSpace.constant + 50
                   
                   let adSize = GADAdSizeFromCGSize(CGSize(width: Application.screenSize.width, height: 50))
                   bannerView = GADBannerView(adSize: adSize)
                   bannerView.adUnitID = userProfileJson.get("GOOGLE_ADMOB_ID")
                   bannerView.rootViewController = self
                   bannerView.delegate = self
                   bannerView.load(GADRequest())
               }
               if(userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes"){
                   Utils.delayWithSeconds(1) {
                       self.tableViewBottomSpace.constant = self.tableViewBottomSpace.constant + 50

                       self.adView = FBAdView(placementID: self.userProfileJson.get("FACEBOOK_PLACEMENT_ID_IOS"), adSize: kFBAdSizeHeight50Banner, rootViewController: self)
                       var bottomBarHeight = 0.0
                       if(self.homeTabBar != nil){
                           bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 100)
                       }
                       if(self.userProfileJson.get("ENABLE_GOOGLE_ADS") == "Yes" && self.userProfileJson.get("ENABLE_FACEBOOK_ADS") == "Yes") {
                           bottomBarHeight = bottomBarHeight - 50
                       }

                       self.adView?.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)

                       FBAdSettings.setAdvertiserTrackingEnabled(false)
                       _ = self.identifierForAdvertising()
                       self.adView?.delegate = self
                       self.adView?.loadAd()
                   }
               }
               
               
           }else{
               self.tableViewBottomSpace.constant = 0
           }
       }
    
    
    // MARK: - Marketplace insertion

    private let marketplaceIntroJSON: [String: Any] = [
        "eViewType": "IntroView",
        "vTitle": "Muamalat Marketplace",
        "vSubtitle": "Discover, buy, sell and rent properties, vehicles and general goods through a trusted marketplace guided by Islamic values and Shariah-compliant principles.",
        "vImage": ""
    ]

    private let realEstateBannerJSON: [String: Any] = [
        "eViewType": "BannerView",
        "eServiceType": "BuySell",
        "isScroll": "No",
        "displayCount": "1",
        "isFullView": "No",
        "isOnlyImage": "No",
        "AddTopPadding": "Yes",
        "AddBottomPadding": "No",
        "imagesArr": [[
            "vCategoryName": "Buy, Sell & Rent Real Estate",
            "vCategoryTitle": "Buy, Sell & Rent Real Estate",
            "vCategory": "Buy, Sell & Rent Real Estate",
            "vImage": "https://www.d8ideas.com/webimages/upload/MasterServiceCategories/20221223192400179.png",
            "vTextColor": "#000000",
            "vBgColor": "#e0e0e0",
            "isClickable": "Yes",
            "PromotionalTagText": "Click to View Details",
            "rentestateSection": "Yes",
            "servicesArr": [[
                "vTitle": "Residential Apartment",
                "iCategoryId": "10",
                "vCategory": "Residential Apartment",
                "vImage": "https://www.d8ideas.com/webimages/upload/rentitem/20221224181329134.png",
                "vImage1": "https://www.d8ideas.com/webimages/upload/rentitem/20221224181329134.png",
                "eCatType": "Webview",
                "vListLogo": "https://www.d8ideas.com/webimages/upload/rentitem/20221224181329134.png"
            ]]
        ]],
        "vImageWidth": "2012",
        "vImageHeight": "1030",
        "isClickable": "Yes"
    ]


    func addMarketplaceBeforeQuranicPrinciple(_ source: [NSDictionary]) -> [NSDictionary] {

        let webviewTitle = generalFunc.getLanguageLabel(origValue: "", key: userProfileJson.get("webview_title"))
        let webviewDescription = generalFunc.getLanguageLabel(origValue: "", key: userProfileJson.get("webview_description"))
        let webviewIconText = generalFunc.getLanguageLabel(origValue: "Icon Webview", key: userProfileJson.get("webview_icon_text"))

        var intro = marketplaceIntroJSON
        intro["vTitle"] = webviewTitle
        intro["vSubtitle"] = webviewDescription

        var banner = realEstateBannerJSON
        if var imagesArr = banner["imagesArr"] as? [[String: Any]], !imagesArr.isEmpty {
            imagesArr[0]["vCategoryName"] = webviewIconText
            banner["imagesArr"] = imagesArr
        }

        let introDict = intro as NSDictionary
        let bannerDict = banner as NSDictionary

        var result = [NSDictionary]()
        var inserted = false

        for item in source {
            if !inserted,
               item.get("eViewType").caseInsensitiveCompare("TitleView") == .orderedSame,
               item.get("vTitle").contains("Principle") {
                result.append(introDict)
                result.append(bannerDict)
                inserted = true
            }
            result.append(item)
        }

        
        if !inserted {
            result.append(introDict)
            result.append(bannerDict)
        }

        return result
    }
    
    func setRowDataArray(dataDic:NSDictionary){
        
        self.removePlaceHolderView()
        self.servicesRowDataArray.removeAllObjects()
        var dataArray = dataDic.arrOf("HOME_SCREEN_DATA")
//        dataArray = self.addMarketplaceBeforeQuranicPrinciple(dataArray as! [NSDictionary]) as NSArray
        
        for i in 0..<dataArray.count{
            
            let dict = dataArray[i] as! NSDictionary
            if(dict.get("eViewType") == "IntroView"){
                
                let uFXProTitleView = UFXProTitleView(eViewType: dict.get("eViewType"), titleText: dict.get("vTitle"), subTitleText: dict.get("vSubtitle"), vImage: dict.get("vImage"),isShowAll:dict.get("isShowAll"),topPadding: dict.get("AddTopPadding"))
                self.servicesRowDataArray.add(uFXProTitleView)
                
            }else if(dict.get("eViewType") == "BannerView"){
                
                let uFXProBannerView1 = UFXProBannerView(isScroll: (dict.get("isScroll") == "Yes" ? true : false), bannerHeight: GeneralFunctions.parseDouble(origValue: 0.0, data: dict.get("vImageHeight")), bannerWidth: GeneralFunctions.parseDouble(origValue: 0.0, data: dict.get("vImageWidth")), imagesArray: dict.arrOf("imagesArr") as! [NSDictionary], displayCount: GeneralFunctions.parseInt(origValue: 0, data: dict.get("displayCount")), isFullWidth: (dict.get("isFullView") == "Yes" ? true : false), isBookBtn:(dict.get("BookBtn") == "Yes" ? true : false), bookBtnTxt:dict.get("BookBtnText"), isClickable:(dict.get("isClickable") == "Yes" ? true : false), isOnlyImage:(dict.get("isOnlyImage") == "Yes" ? true : false), AddTopPadding:(dict.get("AddTopPadding") == "Yes" ? true : false), AddBottomPadding:(dict.get("AddBottomPadding") == "Yes" ? true : false), eServiceType: (dict.get("eServiceType")))
                
                self.servicesRowDataArray.add(uFXProBannerView1)
            }else if(dict.get("eViewType") == "GridView"){
                
                let vBoxView = UFXProVBoxView(servicesArray: dict.arrOf("servicesArr") as! [NSDictionary])
                self.servicesRowDataArray.add(vBoxView)
            }else if(dict.get("eViewType") == "TitleView"){
                
                let uFXProTitleView = UFXProTitleView(titleText: dict.get("vTitle"), subTitleText: dict.get("vSubtitle"),isShowAll:dict.get("isShowAll"),topPadding: dict.get("AddTopPadding"))
                self.servicesRowDataArray.add(uFXProTitleView)
                
            }else if(dict.get("eViewType") == "ServiceBannerView"){
                
                var bannerArray = [UFXProServiceBanner]()
                let imgArray = dict.arrOf("imagesArr")
                for j in 0..<imgArray.count{
                    
                    let dic = imgArray[j] as! NSDictionary
                    bannerArray.append(UFXProServiceBanner(bannerIcon: dic.get("vImage"), bannerIconAllignment: "left", bannerTitletxt: dic.get("vCategoryName"), bannerSubTitleTxt: dic.get("vCategoryDesc"), bannerSubServices: dic.arrOf("servicesArr") as! [NSDictionary], bannerBgColor: dic.get("vBgColor"), vCategoryTitle:dic.get("vCategoryTitle")))
                }
                
                let uFXProServiceBannerStyleView = UFXProServiceBannerStyleView(servicesArray: bannerArray, displayCount: GeneralFunctions.parseInt(origValue: 0, data: dict.get("displayCount")), isFullWidth: false, bannerHeight: 135.0, isClickable:(dict.get("isClickable") == "Yes" ? true : false))
                self.servicesRowDataArray.add(uFXProServiceBannerStyleView)
                
            }else if(dict.get("eViewType") == "ServiceListView"){
                if dict.get("eServiceType") == "Other" {
                    let rideDeliveryBoxView = RideDeliveryBoxView(servicesArray: dict.arrOf("servicesArr") as! [NSDictionary])
                    self.servicesRowDataArray.add(rideDeliveryBoxView)
                }else{
                    let uFXProHBoxView = UFXProHBoxView(servicesArray: dict.arrOf("servicesArr") as! [NSDictionary])
                    self.servicesRowDataArray.add(uFXProHBoxView)
                }
            }else if(dict.get("eViewType") == "DestinationDetailView") {
                let locArray = dict.arrOf("DestinationLocations")
                if dict.get("isShowEnterLocation") == "Yes"{
                    
                    let uFXProDestinationView = UFXProDestinationView(titleText: "", subTitleText: "",isWhereToViewShow: true)
                    self.servicesRowDataArray.add(uFXProDestinationView)
                }
                for j in 0..<locArray.count{
                    let dict = locArray[j] as! NSDictionary
                    let uFXProDestinationView = UFXProDestinationView(titleText: dict.get("tDaddressMain"), subTitleText: dict.get("tDaddressSub"),isWhereToViewShow: false, destLat: dict.get("tEndLat"),destLong:dict.get("tEndLong"))
                    self.servicesRowDataArray.add(uFXProDestinationView)
                }
            }else if(dict.get("eViewType") == "ListView"){
                
                let serArray = dict.arrOf("servicesArr")
               
                for j in 0..<serArray.count{
                    let dictArr = serArray[j] as! NSDictionary
                    let vListView = UFXProListView(servicesArray: dictArr )
                    self.servicesRowDataArray.add(vListView)
                }
            
            }else if(dict.get("eViewType") == "GridIconView"){
                
                let parcelDeliveryGridView = ParcelDeliveryGridView(servicesArray: dict.arrOf("servicesArr") as! [NSDictionary])
                self.servicesRowDataArray.add(parcelDeliveryGridView)
            
        }
            
            self.tableView.reloadData()
            
        }
    }
    
    func setHeaderView(){
        if  ServiceModule.rideProduct {
            self.headerView.backgroundColor = SColors.Theme
            self.welcomeLbl.textColor = SColors.ThemeTxt
            self.userNameLbl.textColor = SColors.ThemeTxt
            self.welcomeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HELLO")
            self.userNameLbl.text = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
            self.whereToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WHERE_TO")
            self.whereToView.shadowColor = UIColor.black
            self.whereToView.shadowOffset = CGSize(width: 0, height: 0.0)
            self.whereToView.shadowRadius = 1.0
            self.whereToView.shadowOpacity = 0.7
            self.whereToView.masksToBounds = false
            if self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() != "YES"{
                self.nowView.isHidden = true
            }
            self.nowLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOW")
            self.whereToView.handleClick { instance in
                self.openDestinationView()
            }
            self.nowView.handleClick { instance in
                self.directOpenSchduleView()
            }
            self.profileImgView.handleClick{ (prefView) in
                let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
                self.push(uv: uv)
            }
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
            
        }else if  ServiceModule.rideDeliveryProduct || ServiceModule.cubex{
            self.headerView.backgroundColor = SColors.Theme
            self.welcomeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WELCOME_TXT")
            self.welcomeLbl.textColor = SColors.ThemeTxt
            self.userNameLbl.textColor = SColors.ThemeTxt
            self.userNameLbl.text = userProfileJson.get("vName") + " " + userProfileJson.get("vLastName")
            self.whereToView.isHidden = true
            self.headerViewHeight.constant = 120
            self.userNameY.constant = 30
            //            if GeneralFunctions.getSafeAreaInsets().top != 0{
            //                self.headerViewHeight.constant = 100
            //                self.userNameY.constant = 20
            //            }
            
            self.transParentViewHight.constant = 0
            self.profileImgView.handleClick{ (prefView) in
                let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
                self.push(uv: uv)
            }
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
            
        } else if ServiceModule.serviceProviderProduct {
            
            self.headerView.backgroundColor = SColors.Theme
            self.headerView.layer.shadowOpacity = 1.0
            self.headerView.layer.shadowRadius = 2.0
            self.headerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.headerView.layer.shadowColor = UIColor.lightGray.cgColor
            self.headerView.layer.masksToBounds = false
            self.headerView.clipsToBounds = true
            self.headerView.layer.cornerRadius = 13
            self.headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            self.headerViewHeight.constant = 140
        
//
            GeneralFunctions.setImgTintColor(imgView: self.locationImgView, color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: self.downArrowImgView, color: SColors.ThemeTxt)
            
            self.addSearhBar()
            
            self.addressTitleLbl.textColor = SColors.ThemeTxt
            self.addressTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
            if(self.selectedAddress != ""){
                self.addressTitleLbl.text = self.selectedAddress
            }
            self.addressView.handleClick { instance in
                self.openPlaceFinder()
            }
            self.viewSearchBg.layer.shadowOpacity = 1.0
            self.viewSearchBg.layer.shadowRadius = 2.0
            self.viewSearchBg.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.viewSearchBg.layer.shadowColor = UIColor.lightGray.cgColor
            self.viewSearchBg.layer.masksToBounds = false
            self.viewSearchBg.cornerRadius = 8.0

        }else if ServiceModule.deliveryKing || ServiceModule.deliveryProduct {
            self.headerView.isHidden = true
            self.headerViewHeight.constant = 0
            self.tblViewTop.constant = 35
            self.addTitleView()
        }
        else{
            
            self.menuImgView.handleClick{ (prefView) in
//                let uv = GeneralFunctions.instantiateViewController(pageName: "ViewProfileUV") as! ViewProfileUV
//                uv.isAddBackButton = true
//                self.push(uv: uv)
                self.tabBarController?.selectedIndex = 3
            }
            
            GeneralFunctions.setImgTintColor(imgView: self.menuImgView, color: SColors.ThemeTxt)
            
            self.headerView.backgroundColor = SColors.Theme
            self.headerView.layer.shadowOpacity = 1.0
            self.headerView.layer.shadowRadius = 2.0
            self.headerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.headerView.layer.shadowColor = UIColor.lightGray.cgColor
            self.headerView.layer.masksToBounds = false
            
            
            GeneralFunctions.setImgTintColor(imgView: self.locationImgView, color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: self.downArrowImgView, color: SColors.ThemeTxt)
            
            self.addSearhBar()
            
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
            
            self.addressTitleLbl.textColor = SColors.ThemeTxt
            self.addressTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_LOC_HINT_TXT")
            if(self.selectedAddress != ""){
                self.addressTitleLbl.text = self.selectedAddress
            }
            
            self.addressView.handleClick { instance in
                self.openPlaceFinder()
            }
            
            self.profileImgView.handleClick{ (prefView) in
                let uv = GeneralFunctions.instantiateViewController(pageName: "EditProfileUV") as! EditProfileUV
                self.push(uv: uv)
            }
            self.profileImgView.sd_setImage(with: URL(string: "\(CommonUtils.user_image_url)\(GeneralFunctions.getMemberd())/\(userProfileJson.get("vImgName"))"), placeholderImage:UIImage(named:"ic_no_pic_user"))
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
                self.addressTitleLbl.text = address
                
                self.getServiceCategoriesPro()
                
            }else{
                self.onLocationUpdate(location: CLLocation(latitude: latitude, longitude: longitude))
            }
        }
    }
    
    func onLocationUpdate(location: CLLocation) {
        print("📍 onLocationUpdate:", location.coordinate)
        if(self.isFirstLoc == false){
            self.currentLocation = location
            
            if(getLocation != nil){
                getLocation.releaseLocationTask()
            }
            
            checkLocationEnabled()
            if(getAddressFrmLocation == nil){
//                getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
//                getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//                getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
//                getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow:false)
                self.requestAddress(for: location)
            }
            
            Utils.delayWithSeconds(4) {
                if self.selectedAddress == "" {
                    self.reverseGeocodeFallback(location)
                }
            }
            
            GetServicesData.getInstance().getCategoriesDataForDeliverAll(lat: "\(location.coordinate.latitude)", long: "\(location.coordinate.longitude)", address: "")
            
            self.selectedLatitude = "\(location.coordinate.latitude)"
            self.selectedLongitude = "\(location.coordinate.longitude)"
            
            self.getServiceCategoriesPro()
            
            self.isFirstLoc = true
        }
        
    }
    
    func reverseGeocodeFallback(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let p = placemarks?.first else {
                print("❌ CLGeocoder failed:", error as Any)
                return
            }
            let address = [p.name, p.subLocality, p.locality, p.administrativeArea, p.country]
                .compactMap { $0 }
                .joined(separator: ", ")
            print("✅ CLGeocoder address:", address)
            DispatchQueue.main.async {
                self.onAddressFound(address: address, location: location, isPickUpMode: true, dataResult: "")
            }
        }
    }
    
    func requestAddress(for location: CLLocation, retries: Int = 2) {
        getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
        getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
        getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow: false)

        if retries > 0 {
            Utils.delayWithSeconds(8) {
                if self.selectedAddress == "" {
                    self.requestAddress(for: location, retries: retries - 1)
                }
            }
        }
    }
    
    func onAddressFound(address: String, location: CLLocation, isPickUpMode: Bool, dataResult: String) {
        print("🏠 onAddressFound:", address, "| lbl nil?:", addressTitleLbl == nil, enterLocLbl == nil)
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
        self.selectedAddress = address
        
        GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
        
        if self.selectedAddress != ""{
            
            //self.isFromLocation = true
            //loadServiceCategory(parentCategoryId: userProfileJson.get("UBERX_PARENT_CAT_ID"))
        }
        if(self.addressTitleLbl != nil){
            self.addressTitleLbl.text = address
        }
        if(self.enterLocLbl != nil){
            self.enterLocLbl.text = address
            
        }
        
        
    }
    
    func addSearhBar(){
        if (GeneralFunctions.parseDouble(origValue: 0.0, data: userProfileJson.get("UBERX_CAT_ID"))) > 0 {
            if(self.searchBar != nil){
                self.searchBar.isHidden = true
            }
        }else {
            
            
            self.searchBar.sizeToFit()
            self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_Search")
            self.searchBar.delegate = self
            
            searchBar.backgroundImage = UIImage()
            if #available(iOS 13.0, *) {
                
                searchBar.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            
            self.searchBar.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: SColors.blackColor), for: .search, state: .normal)
            self.tableView.keyboardDismissMode = .onDrag
            
            self.searchBar.cornerRadius = 8
            self.searchBar.clipsToBounds = true
            self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_SERVICES")
            
            
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
                            
                            //searchField.borderStyle = UITextBorderStyle.RoundedRect
                            searchField.handleClick { (view) in
                                self.openSearchSearvices()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func openSearchSearvices()  {
        let searchSearvicesUV = GeneralFunctions.instantiateViewController(pageName: "SearchSearvicesUV") as! SearchSearvicesUV
        self.searchBar.endEditing(true)
        self.searchBar.resignFirstResponder()
        self.push(uv: searchSearvicesUV)
    }
    
    
    @objc func appInForground(){
        checkLocationEnabled()
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
                    //self.openMenu()
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
    
    
    func getServiceCategoriesPro(){
        
        if(self.servicesRowDataArray.count == 0){
            self.setPlaceHolderView()
        }
        
        
//        let parameters = ["type":"getServiceCategoriesPro", "userId": GeneralFunctions.getMemberd(), "parentId": "0","vLatitude": self.selectedLatitude, "vLongitude": self.selectedLongitude]
        
        let parameters = ["type":"getServiceCategoriesProNew", "userId": GeneralFunctions.getMemberd(), "parentId": "0","vLatitude": self.selectedLatitude, "vLongitude": self.selectedLongitude]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    
                    self.setRowDataArray(dataDic:dataDict)
                    if ServiceModule.deliveryProduct{
                        self.moreDataFor22 = dataDict.arrOf("DELIVERY_SERVICES") as! [NSDictionary]
                        
                    }
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else {
                self.generalFunc.setError(uv: self)
            }
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servicesRowDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(self.servicesRowDataArray[indexPath.row] as? UFXProTitleView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProTitleViewTVCell", for: indexPath) as! UFXProTitleViewTVCell
            
            let uFXProTitleView = self.servicesRowDataArray[indexPath.row] as! UFXProTitleView
            
            
            if(uFXProTitleView.eViewType == "IntroView"){
                
                cell.imagView.isHidden = true
                cell.titleLbl.font = UIFont.init(name: Fonts().bold, size: 22)
                cell.titleLbl.setFontFamily()
                cell.titleLbl.text = uFXProTitleView.titleText
                cell.titleLbl.textColor = UIColor(hex: 0x1B5827)
                cell.seeAllLbl.isHidden = true
                
                cell.imagView.sd_setImage(with: URL(string: uFXProTitleView.vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                })
                
            }else{
                if uFXProTitleView.isShowAll == "Yes"{
                    cell.seeAllLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEE_ALL")
                    cell.seeAllLbl.isHidden = false
                    cell.seeAllLbl.handleClick { instance in
                        if let tabVC = self.tabBarController {
                            if (tabVC.viewControllers?.count ?? 0) > 1 {
                                tabVC.selectedIndex = 1
                                return
                            }
                        }
//                        let rideDeliveryNewServicesUV = (GeneralFunctions.instantiateViewController(pageName: "RideDeliveryNewServicesUV") as! RideDeliveryNewServicesUV)
//                        self.push(uv: rideDeliveryNewServicesUV)
                    }
                }else{
                    cell.seeAllLbl.isHidden = true
                }
                
                cell.imagView.isHidden = true
                cell.titleLbl.font = UIFont.init(name: Fonts().regular, size: 18)
                cell.titleLbl.setFontFamily()
                cell.titleLbl.text = uFXProTitleView.titleText
                cell.titleLbl.textColor = UIColor(hex: 0x1B5827)
            }
            
            if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
                if uFXProTitleView.topPadding == "No" {
                    cell.titleLblTop.constant = 0
                }else{
                    cell.titleLblTop.constant = 20
                }
            }else if ServiceModule.serviceProviderProduct {
                cell.titleLblTop.constant = 0
            }else if ServiceModule.deliveryKing {
                if uFXProTitleView.topPadding == "No" || uFXProTitleView.topPadding == ""{
                    cell.titleLblTop.constant = 5
                }else{
                    cell.titleLblTop.constant = 20
                }
            }else if ServiceModule.deliveryProduct{
                self.tempLbl = cell.titleLbl
                Utils.delayWithSeconds(0.0) {
                    let rect = CGSize(width: cell.titleLbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
                    let labelSize = cell.titleLbl.text?.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: cell.titleLbl.font!], context: nil)
                    let linecount =  Int(ceil(CGFloat(labelSize?.height ?? 0.0) / cell.titleLbl.font.lineHeight))
                   
                    
                    if (uFXProTitleView.topPadding == "No" || uFXProTitleView.topPadding == "") && linecount == 1{
                        cell.titleLblTop.constant = 5
                    }else{
                        cell.titleLblTop.constant = 15
                    }
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                
                cell.titleLbl.numberOfLines = 2
                cell.contentView.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
//                cell.titleLbl.textColor = SColors.Theme
                cell.titleLbl.textColor = UIColor(hex: 0x1B5827)
                
            }
            
            cell.subTitleLbl.text = uFXProTitleView.subTitleText
            cell.subTitleLbl.textColor = UIColor.black
            
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProDestinationView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UfxProRecentLocationTVCell", for: indexPath) as! UfxProRecentLocationTVCell
            
            let uFXProDestinationView = self.servicesRowDataArray[indexPath.row] as! UFXProDestinationView
            if uFXProDestinationView.isWhereToViewShow{
                cell.titleLbl.isHidden = true
                cell.subTitleLbl.isHidden = true
                cell.cloclImgView.isHidden = true
                cell.whereToView.isHidden = false
                cell.sepratorView.isHidden = true
                cell.whereTOLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WHERE_TO")
                cell.scheduleView.backgroundColor = SColors.Theme
                cell.nowLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOW")
                cell.nowLbl.textColor = SColors.ThemeTxt
                if self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() == "YES"{
                    cell.scheduleView.isHidden = false
                }else{
                    cell.scheduleView.isHidden = true
                }
                cell.scheduleView.handleClick { instance in
                    self.directOpenSchduleView()
                }
                GeneralFunctions.setImgTintColor(imgView:cell.clockImgView, color: SColors.ThemeTxt)
                GeneralFunctions.setImgTintColor(imgView:cell.arrowImgView, color: SColors.ThemeTxt)
                cell.whereToView.handleClick { instance in
                    self.openDestinationView()
                    
                }
                
            }else{
                cell.sepratorView.isHidden = false
                cell.titleLbl.isHidden = false
                cell.subTitleLbl.isHidden = false
                cell.cloclImgView.isHidden = false
                cell.whereToView.isHidden = true
                cell.titleLbl.text = uFXProDestinationView.titleText
                cell.subTitleLbl.text = uFXProDestinationView.subTitleText
                cell.contentView.handleClick { instance in
                    let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                    mainScreenUv.APP_TYPE = "Ride"
                    mainScreenUv.ufxSelectedLatitude = self.selectedLatitude
                    mainScreenUv.ufxSelectedLongitude = self.selectedLongitude
                    mainScreenUv.ufxSelectedAddress = self.selectedAddress
                    mainScreenUv.pickUpAddress = self.selectedAddress
                    mainScreenUv.pickUpLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLongitude))
                    mainScreenUv.nearByLat = uFXProDestinationView.destLat
                    mainScreenUv.nearByLong = uFXProDestinationView.destLong
                    mainScreenUv.nearByLocation = uFXProDestinationView.titleText
                    mainScreenUv.isFromNearBy = true
                    mainScreenUv.isFromUFXhomeScreen = true
                    self.push(uv: mainScreenUv)
                }
                
                    GeneralFunctions.setImgTintColor(imgView: cell.cloclImgView, color: UIColor(hex: 0x333333))
                
            }
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? RideDeliveryBoxView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RideDeliveryProBoxTVCell", for: indexPath) as! RideDeliveryProBoxTVCell
            
            let rideDeliveryBoxView = self.servicesRowDataArray[indexPath.row] as! RideDeliveryBoxView
            
            cell.uv = self
            cell.riideDeliveryBoxView = rideDeliveryBoxView
            cell.setData()
            cell.didSelectBoxCloser = { selectedAt in
                
                if rideDeliveryBoxView.servicesArray.count > selectedAt {
                    self.openCategory(item: rideDeliveryBoxView.servicesArray[selectedAt])
                }
            }
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProBannerView != nil){
            
            let uFXProBannerView = self.servicesRowDataArray[indexPath.row] as! UFXProBannerView
            
            if(uFXProBannerView.isScroll){
                let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProCarosulBannerViewTVCell", for: indexPath) as! UFXProCarosulBannerViewTVCell
                
                self.uFXProBannerView = uFXProBannerView
                cell.carosoulView.type = .linear
                //self.imgeSlideView.isPagingEnabled = true
                cell.carosoulView.scrollSpeed = 0.8
                cell.carosoulView.decelerationRate = 0.8
                cell.carosoulView.delegate = self
                cell.carosoulView.dataSource = self
                // cell.carosoulView.contentOffset = CGSize(width: -15, height: 0)
                
                Utils.delayWithSeconds(0.0) {
                    cell.carosoulView.reloadData()
                    
                    if(cell.carosoulView.currentItemIndex == 0){
                        if self.uFXProBannerView.imagesArray.count == 1 && (ServiceModule.deliveryKing || ServiceModule.deliveryProduct){
                            cell.carosoulView.contentOffset = CGSize(width: 0, height: 0)
                        }else{
                            cell.carosoulView.contentOffset = CGSize(width: -15, height: 0)
                        }
                    }
                }
                if ServiceModule.deliveryProduct{
                    cell.contentView.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
                    cell.carosoulView.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProBannerViewTVCell", for: indexPath) as! UFXProBannerViewTVCell
                cell.uFXProBannerView = uFXProBannerView
                
                cell.fullBannerLeading.constant = 0
                cell.fullBannerTrailing.constant = 0
                
                //Add this
                if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex || ServiceModule.serviceProviderProduct{
                    cell.fullBannerImgView.cornerRadius = 8.0
                    cell.titleBannerView1.cornerRadius = 8.0
                    cell.titleBannerView1.cornerRadius = 8.0
                    cell.onlyBannerImgView2.cornerRadius = 8.0
                    cell.onlyBannerImgView2.cornerRadius = 8.0
                }

                if(uFXProBannerView.isOnlyImage == true && uFXProBannerView.displayCount == 1){
                    
                    cell.fullBannerImgView.handleClick { instance in
                        
                        if(uFXProBannerView.imagesArray.count == 1 && uFXProBannerView.isScroll == false){
                            
                            if(uFXProBannerView.isClickable) || ((uFXProBannerView.imagesArray[0]).get("isClickable") as NSString).boolValue{
                                
                                var item = uFXProBannerView.imagesArray[0]
                                let subServices : [NSDictionary] = item.arrOf("servicesArr") as! [NSDictionary]
                                
                                if (item.arrOf("servicesArr").count) > 1{
                                    self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
                                }else if (subServices.count > 0){
                                    self.openCategory(item: subServices.first ?? NSDictionary())
                                }else {
                                    self.openCategory(item: item)
                                }
                            }
                        }
                    }
                    
                    if (uFXProBannerView.isFullWidth){
                        cell.fullBannerLeading.constant = 0
                        cell.fullBannerTrailing.constant = 0
                       
                        
                    }else{
                        cell.fullBannerLeading.constant = 15
                        cell.fullBannerTrailing.constant = 15
                    }
                    
                    if(uFXProBannerView.isBookBtn){
                        
                        if(uFXProBannerView.AddTopPadding){
                            cell.bannerTxtTopSpace.constant = 10
                        }else{
                            cell.bannerTxtTopSpace.constant = 0
                        }
                        
                        if(uFXProBannerView.AddBottomPadding){
                            cell.bannerTxtBottomSpace.constant = 10
                        }else{
                            cell.bannerTxtBottomSpace.constant = 0
                        }
                        
                        cell.bannerTxtView.isHidden = false
                        cell.fullBannerImgView.isHidden = true
                        cell.titleBannerStackView.isHidden = true
                        
                        cell.bannerTxtTitleLbl.text = (uFXProBannerView.imagesArray[0]).get("vCategoryName")
                        cell.bannerTxtSubTitleLbl.text = (uFXProBannerView.imagesArray[0]).get("vCategoryDesc")
                        
                        cell.bannerTxtBookNowLbl.text = uFXProBannerView.bookBtnTxt
                        
                        cell.fullBannerImgView.contentMode = .scaleAspectFit
                        cell.bannerTxtImgView.sd_setImage(with: URL(string: (uFXProBannerView.imagesArray[0]).get("vImage")), placeholderImage:nil)
                        
                        cell.bannerTxtView.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vBgColor"), alpha: 1)
                        
                    }else{
                        
                        
                        if(uFXProBannerView.AddTopPadding){
                            if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
                                cell.fullBannerTopSpace.constant = 15
                            }else{
                                cell.fullBannerTopSpace.constant = 10
                            }
                        }else{
                            cell.fullBannerTopSpace.constant = 0
                        }
                        
                        if(uFXProBannerView.AddBottomPadding){
                            cell.fullBannerBottomSpace.constant = 10
                        }else{
                            cell.fullBannerBottomSpace.constant = 0
                        }
                        
                        cell.bannerTxtView.cornerRadius = 10
                        cell.bannerTxtView.isHidden = true
                        cell.fullBannerImgView.isHidden = false
                        cell.titleBannerStackView.isHidden = true
                        
                        cell.fullBannerImgView.contentMode = .scaleAspectFit
                        
                        cell.fullBannerImgView.sd_setImage(with: URL(string: (uFXProBannerView.imagesArray[0]).get("vImage")), placeholderImage:nil)
                        
                    }
                    
                }else{
                    
                    if(uFXProBannerView.AddTopPadding){
                        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
                            cell.bannerStackTopSpace.constant = 15
                        }else{
                            cell.bannerStackTopSpace.constant = 10
                        }
                        
                    }else{
                        cell.bannerStackTopSpace.constant = 0
                    }
                    
                    if(uFXProBannerView.AddBottomPadding){
                        cell.bannerStackBottomSpace.constant = 10
                    }else{
                        cell.bannerStackBottomSpace.constant = 0
                    }
                    
                    cell.bannerTxtView.isHidden = true
                    cell.fullBannerImgView.isHidden = true
                    cell.titleBannerStackView.isHidden = false
                    cell.titleBannerImgView1.contentMode = .scaleAspectFit
                    cell.titleBannerImgView2.contentMode = .scaleAspectFit
                    
                    cell.titleBannerView1.handleClick { instance in
                        
                        if(uFXProBannerView.imagesArray.count > 0 && uFXProBannerView.isScroll == false){
                            
                            if(uFXProBannerView.isClickable) || ((uFXProBannerView.imagesArray[0]).get("isClickable") as NSString).boolValue{
                                
                                let item = uFXProBannerView.imagesArray[0]
                                let subServices = item.arrOf("servicesArr") as! [NSDictionary]
                                
//                                if(subServices.count == 1){
//                                    self.openCategory(item: subServices[0])
//                                }else{
//                                    self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
//                                }
                                
                                //to manage the new banner images clicks
                                if (subServices.count > 1) {
                                    self.openMoreView(dataArray: subServices, moreTitle:item.get("vCategoryTitle"))
                                }else if (subServices.count > 0){
                                    self.openCategory(item: subServices.first ?? NSDictionary())
                                }else {
                                    self.openCategory(item: item)
                                }
                            }
                        }
                    }
                    
                    cell.titleBannerView2.handleClick { instance in
                        if(uFXProBannerView.imagesArray.count > 1 && uFXProBannerView.isScroll == false){
                            
                            if(uFXProBannerView.isClickable) || ((uFXProBannerView.imagesArray[1]).get("isClickable") as NSString).boolValue{
                                
                                let item = uFXProBannerView.imagesArray[1]
                                
                                let subServices = item.arrOf("servicesArr") as! [NSDictionary]
                                
//                                if(subServices.count == 1){
//                                    self.openCategory(item: subServices[0])
//                                }else{
//                                    self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
//                                }
                                
                                //to manage the new banner images clicks
                                if (subServices.count > 1) {
                                    self.openMoreView(dataArray: subServices, moreTitle:item.get("vCategoryTitle"))
                                }else if (subServices.count > 0){
                                    self.openCategory(item: subServices.first ?? NSDictionary())
                                }else {
                                    self.openCategory(item: item)
                                }
                            }
                        }
                    }
                    
                    cell.fullBanner1CenterImgView.contentMode = .scaleAspectFit
                    cell.titleBannerImgView1.contentMode = .scaleAspectFit
                    cell.titleBannerImgView2.contentMode = .scaleAspectFit
                    cell.promoLbl1.backgroundColor = SColors.Theme
                    cell.promoLbl2.backgroundColor = SColors.Theme
                    cell.promoLbl1.textColor = SColors.ThemeTxt
                    cell.promoLbl2.textColor = SColors.ThemeTxt
                    cell.promoLbl1.isHidden = true
                    cell.promoLbl2.isHidden = true
                    if(uFXProBannerView.displayCount == 1 && uFXProBannerView.imagesArray.count > 0){
                        
                        
                        if((uFXProBannerView.imagesArray[0]).get("PromotionalTagText") != ""){
                            cell.promoLbl1.text = (uFXProBannerView.imagesArray[0]).get("PromotionalTagText")
                            cell.promoLbl1.isHidden = false
                        }else{
                            cell.promoLbl1.text = ""
                            cell.promoLbl1.isHidden = true
                            
                        }
                        
                        cell.titleBannerView1.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vBgColor"), alpha: 1)
                        
                        cell.titleBannerLbl1.text = (uFXProBannerView.imagesArray[0]).get("vCategoryName")
                        cell.titleBannerLbl1.textColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vTextColor"), alpha: 1)
                        let vImage = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[0]).get("vImage"), width: Utils.getValueInPixel(value: 230) , height: Utils.getValueInPixel(value: 120))
                        // cell.fullBanner1CenterImgView.sd_setImage(with: URL(string: vImage), placeholderImage:UIImage(named:"ic_no_icon"))
                        
                        cell.fullBanner1CenterImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                            
                            if(Configurations.isRTLMode()){
                                cell.fullBanner1CenterImgView.image = cell.fullBanner1CenterImgView.image?.imageFlippedForRightToLeftLayoutDirection()
                            }
                        })
                        
                        
                        cell.onlyBannerImgView1.isHidden = true
                        cell.onlyBannerImgView2.isHidden = true
                        cell.titleBannerView2.isHidden = true
                        cell.titleBannerView1.isHidden = false
                        cell.fullBanner1CenterImgView.isHidden = false
                        
                        cell.titleBannerLbl1TopSpace.constant = 30
                        cell.titleBannerLbl1TrailingSpace.constant = (Application.screenSize.width / 2) + 30
                        
                        
                    }else{
                        
                        
                        cell.titleBannerLbl1TopSpace.constant = 10
                        cell.titleBannerLbl1TrailingSpace.constant = 10
                        
                        if(uFXProBannerView.isOnlyImage){
                            
                            // cell.fullBanner1CenterImgView.isHidden = true
                            cell.titleBannerView1.isHidden = true
                            cell.titleBannerView2.isHidden = true
                            cell.onlyBannerImgView1.isHidden = false
                            cell.onlyBannerImgView2.isHidden = false
                            cell.fullBanner1CenterImgView.isHidden = true
                            
                            cell.onlyBannerImgView1.contentMode = .scaleAspectFit
                            cell.onlyBannerImgView2.contentMode = .scaleAspectFit
                            
                            
                            let ration = (uFXProBannerView.bannerWidth * 2) / uFXProBannerView.bannerHeight
                            let height = Utils.getHeightOfBanner(widthOffset: 40, ratio: "", ration)
                            
                            let vImage = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[0]).get("vImage"), width: Utils.getValueInPixel(value: (Application.screenSize.width - 40) / 2) , height: Utils.getValueInPixel(value: height))
                            let vImage1 = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[1]).get("vImage"), width: Utils.getValueInPixel(value: (Application.screenSize.width - 40) / 2) , height: Utils.getValueInPixel(value: height))
                            
                            cell.onlyBannerImgView1.sd_setImage(with: URL(string:vImage), placeholderImage:nil)
                            
                            cell.onlyBannerImgView2.sd_setImage(with: URL(string:vImage1), placeholderImage:nil)
                            
                            cell.onlyBannerImgView1.roundCorners(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 10)
                            cell.onlyBannerImgView2.roundCorners(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 10)
                            
                            cell.onlyBannerImgView1.handleClick { instance in

                                if(uFXProBannerView.imagesArray.count > 0 && uFXProBannerView.isScroll == false){
                                    
                                    if (uFXProBannerView.isClickable)  || ((uFXProBannerView.imagesArray[0]).get("isClickable") as NSString).boolValue{
                                        let item = uFXProBannerView.imagesArray[0]
                                        let subServices = item.arrOf("servicesArr") as! [NSDictionary]
                                        
//                                        if(subServices.count == 1){
//                                            self.openCategory(item: subServices[0])
//                                        }else{
//                                            self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
//                                        }
                                        //to manage the new banner images clicks
                                        if (subServices.count > 1) {
                                            self.openMoreView(dataArray: subServices, moreTitle:item.get("vCategoryTitle"))
                                        }else if (subServices.count > 0){
                                            self.openCategory(item: subServices.first ?? NSDictionary())
                                        }else {
                                            self.openCategory(item: item)
                                        }

                                    }
                                }
                            }
                            
                            cell.onlyBannerImgView2.handleClick { instance in
                                
                                    if(uFXProBannerView.imagesArray.count > 1 && uFXProBannerView.isScroll == false){

                                        if(uFXProBannerView.isClickable) || ((uFXProBannerView.imagesArray[1]).get("isClickable") as NSString).boolValue{
                                            
                                        let item = uFXProBannerView.imagesArray[1]
                                        
                                        let subServices = item.arrOf("servicesArr") as! [NSDictionary]
                                        
//                                        if(subServices.count == 1){
//                                            self.openCategory(item: subServices[0])
//                                        }else{
//                                            self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
//                                        }
                                            //to manage the new banner images clicks
                                            if (subServices.count > 1) {
                                                self.openMoreView(dataArray: subServices, moreTitle:item.get("vCategoryTitle"))
                                            }else if (subServices.count > 0){
                                                self.openCategory(item: subServices.first ?? NSDictionary())
                                            }else {
                                                self.openCategory(item: item)
                                            }
                                    }
                                }
                            }
                            
                        }else{
                            
                            cell.titleBannerView1.isHidden = false
                            cell.titleBannerView2.isHidden = false
                            cell.onlyBannerImgView1.isHidden = true
                            cell.onlyBannerImgView2.isHidden = true
                            if((uFXProBannerView.imagesArray[0]).get("PromotionalTagText") != ""){
                                cell.promoLbl1.text = (uFXProBannerView.imagesArray[0]).get("PromotionalTagText")
                                cell.promoLbl1.isHidden = false
                                
                            }else{
                                cell.promoLbl1.text = ""
                                cell.promoLbl1.isHidden = true
                                
                                
                            }
                            
                            if((uFXProBannerView.imagesArray[1]).get("PromotionalTagText") != ""){
                                cell.promoLbl2.text = (uFXProBannerView.imagesArray[1]).get("PromotionalTagText")
                                cell.promoLbl2.isHidden = false
                                
                            }else{
                                cell.promoLbl2.text = ""
                                cell.promoLbl2.isHidden = true
                                
                            }
                            
                            cell.titleBannerView2.isHidden = false
                            cell.titleBannerImgView1.isHidden = false
                            cell.fullBanner1CenterImgView.isHidden = true
                            
                            
                            let vImage = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[0]).get("vImage"), width: Utils.getValueInPixel(value: 160) , height: Utils.getValueInPixel(value: 105))
                            let vImage1 = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[1]).get("vImage"), width: Utils.getValueInPixel(value: 160) , height: Utils.getValueInPixel(value: 105))
                            
                            //cell.titleBannerImgView1.sd_setImage(with: URL(string: vImage), placeholderImage:nil)
                            //cell.titleBannerImgView2.sd_setImage(with: URL(string: vImage1), placeholderImage:nil)
                            
                            cell.titleBannerImgView1.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                                
                                if(Configurations.isRTLMode()){
                                    cell.titleBannerImgView1.image = cell.titleBannerImgView1.image?.imageFlippedForRightToLeftLayoutDirection()
                                }
                            })
                            
                            cell.titleBannerImgView2.sd_setImage(with: URL(string: vImage1), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                                
                                if(Configurations.isRTLMode()){
                                    cell.titleBannerImgView2.image = cell.titleBannerImgView2.image?.imageFlippedForRightToLeftLayoutDirection()
                                }
                            })
                            
                            cell.titleBannerLbl1.text = (uFXProBannerView.imagesArray[0]).get("vCategoryName")
                            cell.titleBnnerLbl2.text = (uFXProBannerView.imagesArray[1]).get("vCategoryName")
                            cell.titleBnnerLbl2.textColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[1]).get("vTextColor"), alpha: 1)
                            cell.titleBannerLbl1.textColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vTextColor"), alpha: 1)
                            
                            
                            
                            
                            
                            cell.titleBannerView1.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vBgColor"), alpha: 1)
                            
                            cell.titleBannerView2.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[1]).get("vBgColor"), alpha: 1)
                        }
                        
                        
                    }
                }
                
                return cell
            }
            
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProVBoxView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProVBoxTVCell", for: indexPath) as! UFXProVBoxTVCell
            
            cell.uv = self
            
            let uFXProVBoxView = self.servicesRowDataArray[indexPath.row] as! UFXProVBoxView
            
            cell.uFXProVBoxView = uFXProVBoxView
            
            cell.setData()
            
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProServiceBannerStyleView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProServiceBannerTVCell", for: indexPath) as! UFXProServiceBannerTVCell
            
            cell.uv = self
            let uFXProServiceBannerStyleView = self.servicesRowDataArray[indexPath.row] as! UFXProServiceBannerStyleView
            
            cell.uFXProServiceBannerStyleView = uFXProServiceBannerStyleView
            
            if(uFXProServiceBannerStyleView.servicesArray.count > 1){
                cell.dataArray = uFXProServiceBannerStyleView.servicesArray[0].bannerSubServices
                cell.dataArray1 = uFXProServiceBannerStyleView.servicesArray[1].bannerSubServices
                
            }else if(uFXProServiceBannerStyleView.servicesArray.count > 0){
                cell.dataArray = uFXProServiceBannerStyleView.servicesArray[0].bannerSubServices
            }
            
            cell.setData()
            
            cell.dataCntView.handleClick { instance in
                
                if(uFXProServiceBannerStyleView.isClickable){
                    
                    if(uFXProServiceBannerStyleView.servicesArray.count > 0){
                        let uFXProServiceBanner = uFXProServiceBannerStyleView.servicesArray[0]
                        
                        if(uFXProServiceBanner.bannerSubServices.count == 1){
                            self.openCategory(item: uFXProServiceBanner.bannerSubServices[0])
                        }else{
                            self.openMoreView(dataArray: uFXProServiceBanner.bannerSubServices , moreTitle:uFXProServiceBanner.vCategoryTitle)
                        }
                    }
                }
            }
            
            cell.dataCntView1.handleClick { instance in
                
                if(uFXProServiceBannerStyleView.isClickable){
                    
                    if(uFXProServiceBannerStyleView.servicesArray.count > 1){
                        let uFXProServiceBanner = uFXProServiceBannerStyleView.servicesArray[1]
                        self.openMoreView(dataArray: uFXProServiceBanner.bannerSubServices, moreTitle:uFXProServiceBanner.vCategoryTitle)
                    }
                }
            }
            
            cell.iconCollectionViewLeadingSpace.constant = 0
            cell.iconCollectionViewTrailingSpace.constant = 0
            cell.subTitleTopSpace.constant = 5
            cell.titleLblLeadingSpace.constant = 10
            cell.titleLblHeight.constant = 50
            if(uFXProServiceBannerStyleView.servicesArray.count > 1){
                cell.dataCntView.backgroundColor = UIColor.init(hexString: uFXProServiceBannerStyleView.servicesArray[0].bannerBgColor, alpha: 1)
                cell.dataCntView1.backgroundColor = UIColor.init(hexString: uFXProServiceBannerStyleView.servicesArray[1].bannerBgColor, alpha: 1)
                
                
                cell.titleLbl.text = uFXProServiceBannerStyleView.servicesArray[0].bannerTitletxt
                cell.subTitleLbl.text = uFXProServiceBannerStyleView.servicesArray[0].bannerSubTitleTxt
                
                cell.titleLbl1.text = uFXProServiceBannerStyleView.servicesArray[1].bannerTitletxt
                cell.subTitleLbl1.text = uFXProServiceBannerStyleView.servicesArray[1].bannerSubTitleTxt
                
                cell.dataCntView.isHidden = false
                cell.dataCntView1.isHidden = false
                
                
                
                cell.topCornerImgView.sd_setImage(with: URL(string: uFXProServiceBannerStyleView.servicesArray[0].bannerIcon), placeholderImage:nil)
                cell.topCornerImgView1.sd_setImage(with: URL(string: uFXProServiceBannerStyleView.servicesArray[1].bannerIcon), placeholderImage:nil)
                
            }else{
                
                cell.iconCollectionViewLeadingSpace.constant = 50
                cell.iconCollectionViewTrailingSpace.constant = 10
                cell.subTitleTopSpace.constant = 0
                cell.titleLblHeight.constant = 40
                cell.titleLblLeadingSpace.constant = 60
                cell.dataCntView.backgroundColor = UIColor.init(hexString: uFXProServiceBannerStyleView.servicesArray[0].bannerBgColor, alpha: 1)
                cell.titleLbl.text = uFXProServiceBannerStyleView.servicesArray[0].bannerTitletxt
                cell.subTitleLbl.text = uFXProServiceBannerStyleView.servicesArray[0].bannerSubTitleTxt
                
                cell.dataCntView.isHidden = false
                cell.dataCntView1.isHidden = true
                
                cell.topCornerImgView.sd_setImage(with: URL(string: uFXProServiceBannerStyleView.servicesArray[0].bannerIcon), placeholderImage:nil)
            }
            
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProHBoxView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProHBoxTVCell", for: indexPath) as! UFXProHBoxTVCell
            cell.uv = self
            
            let uFXProHBoxView = self.servicesRowDataArray[indexPath.row] as! UFXProHBoxView
            
            cell.uFXProHBoxView = uFXProHBoxView
            
            cell.setData()
            
            return cell
        }else if (self.servicesRowDataArray[indexPath.row] as? UFXProListView != nil) && ServiceModule.deliveryProduct{
            let uFXProListView = self.servicesRowDataArray[indexPath.row] as! UFXProListView
            let item = uFXProListView.servicesArray
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelListTVC", for: indexPath) as! ParcelListTVC
            
           
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
    
            cell.imgParentView.borderColor = UIColor.init(hexString: "E6E6E6", alpha: 1)
            cell.imgParentView.borderWidth = 1.0
            cell.catTitleLbl.text = item.get("vCategory")
            cell.catDecLbl.text = item.get("tListDescription")
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 45), height: Utils.getValueInPixel(value: 45))
            cell.catImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
              
               
            })
            return cell
        }else if (self.servicesRowDataArray[indexPath.row] as? UFXProListView != nil){
            let uFXProListView = self.servicesRowDataArray[indexPath.row] as! UFXProListView
            let item = uFXProListView.servicesArray
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProListTVCell", for: indexPath) as! UFXProListTVCell
            
            cell.cntView.clipsToBounds = true
            cell.cntView.layer.cornerRadius = 8
            cell.cntView.layer.borderWidth = 0.0
            cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.cntView.layer.shadowRadius = 2.0
            cell.cntView.layer.shadowOpacity = 0.5
            cell.cntView.layer.masksToBounds = false
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
    
            
            cell.catTitleLbl.text = item.get("vCategory")
            cell.catDecLbl.text = item.get("tListDescription")
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 95), height: Utils.getValueInPixel(value: 95))
            cell.catImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
              
               
            })
            Utils.delayWithSeconds(0.1) {
                cell.catImgView.roundTo(corners: [.bottomLeft,.topLeft], radius: 8)
                
            }
            cell.cntView.handleClick { (instance) in
                
                
                
                _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
                
                
            }
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? ParcelDeliveryGridView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelDeliveryBoxTVC", for: indexPath) as! ParcelDeliveryBoxTVC
            
            let parcelDeliveryGridView = self.servicesRowDataArray[indexPath.row] as! ParcelDeliveryGridView
            cell.cntView.clipsToBounds = true
            cell.cntView.layer.cornerRadius = 8
            cell.cntView.layer.borderWidth = 0.0
            cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.cntView.layer.shadowRadius = 2.0
            cell.cntView.layer.shadowOpacity = 0.5
            cell.cntView.layer.masksToBounds = false
            cell.selectionStyle = .none
            cell.uv = self
            cell.parcelDeliveryGridView = parcelDeliveryGridView
            cell.setData()
            cell.sendBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_SEND_PARCEL_BTN_TXT"))
            
            cell.sendBtn.isUserInteractionEnabled = true
            cell.sendBtn.clickDelegate = self
            cell.sendBtn.btnType = "SEND_PARCEL"
            cell.contentView.backgroundColor = SColors.parcelDeliveryHomeScreenBgColor
            return cell
        }
        else{
            
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.servicesRowDataArray[indexPath.row] as? UFXProTitleView != nil){
            
            let uFXProTitleView = self.servicesRowDataArray[indexPath.row] as? UFXProTitleView
            if(uFXProTitleView?.subTitleText == ""){
                if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex{
                    if uFXProTitleView?.topPadding == "No" {
                        return 35
                    }
                    return 55
                } else if ServiceModule.serviceProviderProduct {
                    return 30
                }else if ServiceModule.deliveryKing {
                    if uFXProTitleView?.topPadding == "Yes"{
                        return 55
                    }
                    return 35
                }else if ServiceModule.deliveryProduct{
                    
                    if uFXProTitleView?.titleText != ""{
                       
                        
                        let rect = CGSize(width: self.tempLbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
                        let labelSize = uFXProTitleView?.titleText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.tempLbl.font!], context: nil)
                        let linecount =  Int(ceil(CGFloat(labelSize?.height ?? 0.0) / self.tempLbl.font.lineHeight))
                        if (uFXProTitleView?.topPadding == "No" || uFXProTitleView?.topPadding == "") && linecount == 1{
                            return 40
                        }else if uFXProTitleView?.topPadding == "Yes" && linecount == 1 {
                            return 55
                        }else{
                            return 75
                        }
                    }else{
                        return 40
                    }
                }
                
                return 60
            }else{
                
                let height = (uFXProTitleView?.subTitleText.height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont(name: Fonts().regular, size: 13)!) ?? 0.0)
                return height + 60
            }
            
        }
        if(self.servicesRowDataArray[indexPath.row] as? UFXProListView != nil) && ServiceModule.deliveryProduct{
            
              return 80

        }
        if(self.servicesRowDataArray[indexPath.row] as? UFXProListView != nil){
            
              return 115

        }
        if(self.servicesRowDataArray[indexPath.row] as? UFXProBannerView != nil){
            
            let uFXProBannerView = self.servicesRowDataArray[indexPath.row] as! UFXProBannerView
            
            if(uFXProBannerView.isBookBtn){
                let ration = uFXProBannerView.bannerWidth / uFXProBannerView.bannerHeight
                
                return Utils.getHeightOfBanner(widthOffset: 0, ratio: "", ration) + 90
            }
            
            
            if(uFXProBannerView.isOnlyImage == false && uFXProBannerView.displayCount == 1 && uFXProBannerView.isScroll == true){
                let ration = uFXProBannerView.bannerWidth / uFXProBannerView.bannerHeight
                if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex{
                    return Utils.getHeightOfBanner(widthOffset: 60, ratio: "", ration)
                }
                if uFXProBannerView.imagesArray.count == 1 && (ServiceModule.deliveryKing || ServiceModule.deliveryProduct) {
                    return Utils.getHeightOfBanner(widthOffset: 30, ratio: "", ration) + 20
                }
                return Utils.getHeightOfBanner(widthOffset: 60, ratio: "", ration) + 20
            }else if(uFXProBannerView.isOnlyImage == true && uFXProBannerView.isScroll == false){
                
                var extraHeight = 0
                if(uFXProBannerView.AddTopPadding){
                    if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex{
                            extraHeight = extraHeight + 15
                    }else{
                        extraHeight = extraHeight + 10
                    }
                }
                if(uFXProBannerView.AddBottomPadding){
                    extraHeight = extraHeight + 10
                }
                
                var ration = 0.0
                
                if(uFXProBannerView.displayCount == 1){
                    ration = uFXProBannerView.bannerWidth / uFXProBannerView.bannerHeight
                }else{
                    ration = (uFXProBannerView.bannerWidth * 2) / uFXProBannerView.bannerHeight
                    return Utils.getHeightOfBanner(widthOffset: 40, ratio: "", ration) + CGFloat(extraHeight)
                }
                
                
                if(uFXProBannerView.isFullWidth){
                    return Utils.getHeightOfBanner(widthOffset: 0, ratio: "", ration) + CGFloat(extraHeight)
                }else{
                    return Utils.getHeightOfBanner(widthOffset: 30, ratio: "", ration) + CGFloat(extraHeight)
                }
                
                
                
            }else if(uFXProBannerView.isOnlyImage == false && uFXProBannerView.displayCount > 1 && uFXProBannerView.isScroll == false){
                
                return 140
            }else{
                return 135
            }
            
        }
        
        if(self.servicesRowDataArray[indexPath.row] as? UFXProVBoxView != nil){
            if ServiceModule.deliveryKing {
              return ((Application.screenSize.width - 36) / 3) + 20
            }else {
                var width = 125.0
                var height = 145.0
                
                if(Int(((Application.screenSize.width - 30) / width)) <= 2){
                    width = 110.0
                    height = 130.0
                }
                let boxCountPerRow = Int(((Application.screenSize.width - 30) / width))
                
                var numberOfRow = Int((self.servicesRowDataArray[indexPath.row] as! UFXProVBoxView).servicesArray.count / boxCountPerRow)
                if((self.servicesRowDataArray[indexPath.row] as! UFXProVBoxView).servicesArray.count % boxCountPerRow > 0){
                    numberOfRow = numberOfRow + 1
                }
                
                return CGFloat((numberOfRow * Int(height)) + (numberOfRow * 10) + 15)
            }
        }
        
        if(self.servicesRowDataArray[indexPath.row] as? UFXProServiceBannerStyleView != nil){
            
            let uFXProServiceBannerStyleView = self.servicesRowDataArray[indexPath.row] as! UFXProServiceBannerStyleView
            
            if(uFXProServiceBannerStyleView.servicesArray.count > 1){
                
                let height = uFXProServiceBannerStyleView.servicesArray[0].bannerSubTitleTxt.height(withConstrainedWidth: ((Application.screenSize.width - 40) / 2) - 20, font: UIFont(name: Fonts().light, size: 12)!) + 80
                let height1 = uFXProServiceBannerStyleView.servicesArray[1].bannerSubTitleTxt.height(withConstrainedWidth: ((Application.screenSize.width - 40) / 2) - 20, font: UIFont(name: Fonts().light, size: 12)!) + 80
                
                var extraHeight = 0
                
                if(uFXProServiceBannerStyleView.servicesArray[0].bannerSubServices.count > 0 || uFXProServiceBannerStyleView.servicesArray[0].bannerSubServices.count > 1){
                    extraHeight = 80
                }
                
                return ((height > height1) ? height : height1) + CGFloat(extraHeight)
                
            }else{
                
                var extraHeight = 0
                
                if(uFXProServiceBannerStyleView.servicesArray.count > 0){
                    
                    if(uFXProServiceBannerStyleView.servicesArray[0].bannerSubServices.count > 0){
                        extraHeight = 80
                    }
                }
                return uFXProServiceBannerStyleView.servicesArray[0].bannerSubTitleTxt.height(withConstrainedWidth: Application.screenSize.width - 110, font: UIFont(name: Fonts().light, size: 12)!) + 65 + CGFloat(extraHeight)
            }
            
        }
        
        
        if(self.servicesRowDataArray[indexPath.row] as? UFXProHBoxView != nil){
            if  ServiceModule.rideProduct {
                return ((Application.screenSize.width / 4)) + 15
            }
            return ((Application.screenSize.width / 4)) + 30
        }
        if(self.servicesRowDataArray[indexPath.row] as? RideDeliveryBoxView != nil){
            
            return ((Application.screenSize.width / 3)) + 80
            
        }
        if(self.servicesRowDataArray[indexPath.row] as? UFXProDestinationView != nil){
            let uFXProDestinationView = self.servicesRowDataArray[indexPath.row] as! UFXProDestinationView
            if uFXProDestinationView.isWhereToViewShow {
                return 50
            }else{
                return 66
            }
        }
        if(self.servicesRowDataArray[indexPath.row] as? ParcelDeliveryGridView != nil){
            
            
           
            var height = ((Application.screenSize.width - 40) / 4) + 20

            var numberOfRow = Int((self.servicesRowDataArray[indexPath.row] as! ParcelDeliveryGridView).servicesArray.count / 4)
            if((self.servicesRowDataArray[indexPath.row] as! ParcelDeliveryGridView).servicesArray.count % 4 > 0){
                numberOfRow = numberOfRow + 1
            }
            
            return CGFloat((numberOfRow * Int(height)) + 90)
        }
        return 0
    }
    
    func openMoreView(dataArray:[NSDictionary], moreTitle:String){
        
        self.moreTitle = moreTitle
        
        if self.moreServicesView == nil{
            self.addMoreServiceView()
        }
        
        titleView.text = self.moreTitle
        
        self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
        self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
        self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
        self.moreServicesView.dragViewAnimatedTopMargin = 0
        self.btnSheetCollectionView.reloadData()
        self.moreServicesBGView.isHidden = false
        
        self.moreDataFor22 = dataArray
        
    }
    
    var titleView:MyLabel!
    func addMoreServiceView(){
        // INITIALIZE FILTERVIEW
        let window = UIApplication.shared.delegate!.window!
        
        moreServicesBGView = UIView.init(frame: CGRect(x: 0, y:0 , width: (window?.frame.width)!, height: (window?.frame.height)!))
        moreServicesBGView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        moreServicesBGView.isHidden = true
        Application.window!.addSubview(moreServicesBGView)
        moreServicesView = SDragViewForMoreServices(dragViewAnimatedTopSpace:0, viewDefaultHeightConstant:0, uv:self)
        Application.window!.addSubview(moreServicesView)
        
        let topBGViw:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: 44))
        topBGViw.clipsToBounds = true
        topBGViw.backgroundColor = SColors.Theme
        moreServicesView.addSubview(topBGViw)
        let stackView = UIStackView.init(frame: CGRect(x: 15, y: 0, width: Application.screenSize.width - 30 , height: topBGViw.frame.size.height))
        
        topBGViw.addSubview(stackView)
        
        
        let imgBg = UIView(frame: CGRect(x: Application.screenSize.width - 60, y: 8, width: 30, height: 30))
        if(Configurations.isRTLMode()){
            imgBg.frame =  CGRect(x: 5, y: imgBg.frame.origin.y, width: imgBg.frame.width, height: imgBg.frame.height)
        }
        imgBg.layer.cornerRadius = imgBg.frame.size.width / 2
        imgBg.clipsToBounds = true
        imgBg.backgroundColor = UIColor.white
        imgBg.handleClick { instance in
            self.closeMoreServices()
        }
        let imageViewCancel = UIImageView(frame: CGRect(x:5 , y: 5, width: 20, height: 20))
        //        if(Configurations.isRTLMode()){
        //            imgBg.frame =  CGRect(x: 10, y: 5, width: 25, height: 25)
        //        }
        imageViewCancel.image = UIImage.init(named: "cm_close_white")
        GeneralFunctions.setImgTintColor(imgView: imageViewCancel, color: SColors.Theme)
        let ViewCancelTransparent = UIImageView(frame: CGRect(x:imageViewCancel.frame.origin.x , y: 7, width: 50, height: 50))
        ViewCancelTransparent.backgroundColor = UIColor.clear
        ViewCancelTransparent.handleClick { instance in
            self.closeMoreServices()
        }
        titleView = MyLabel(frame: CGRect(x: 1, y: 0, width: Application.screenSize.width - 20, height: topBGViw.frame.size.height))
        if(Configurations.isRTLMode()){
            titleView.frame = CGRect(x: Application.screenSize.width - 60, y: 0, width:  Application.screenSize.width - 60, height: topBGViw.frame.size.height)
        }
        titleView.text = self.moreTitle
        
        titleView.textAlignment = .natural
        titleView.backgroundColor = UIColor.clear
        titleView.textColor = SColors.ThemeTxt
        titleView.font = UIFont(name: Fonts().light, size: 17)!
        // lblServiceSlect = titleView
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
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.btnSheetCollectionView.delegate = self
        self.btnSheetCollectionView.dataSource = self
        self.btnSheetCollectionView.backgroundColor = .white
        self.btnSheetCollectionView.register(UINib(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
        self.btnSheetCollectionView.bounces = false
        self.btnSheetCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.btnSheetCollectionView.showsVerticalScrollIndicator = false
        
        self.btnSheetCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 15, bottom: 10, right: 15)
        
        self.moreServicesView.addSubview(self.btnSheetCollectionView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: topBGViw.frame.size.height),
            stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: stackView.superview!.rightAnchor, constant: 15),
        ])
    }
    
    func closeMoreServices(){
        // scrollView.setContentOffset(.zero, animated: false)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreDataFor22.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        cell.cntView.clipsToBounds = true
        cell.cntView.layer.cornerRadius = 10.0
        cell.cntView.layer.borderColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.borderWidth = 0.5
        cell.cntView.layer.shadowColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cntView.layer.shadowRadius = 1.5
        cell.cntView.layer.shadowOpacity = 1
        cell.cntView.layer.masksToBounds = false
        
        let item = self.moreDataFor22[indexPath.item]
        cell.serTitleLbl.text = item.get("vCategory")
        cell.serTitleLbl.textColor = UIColor(hex: 0x1B2A3B)
        
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 56) , height: Utils.getValueInPixel(value: 56))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            cell.cntView.layer.cornerRadius = 10.0
        })
        
        // cell.imageParentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
        cell.imageParentView.cornerRadius = 23
        cell.imageParentView.isHidden = false
        cell.serImgView.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 120.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            width = 150.0
        }
        //var height = 140.0
        
        let applicationWidth = Application.screenSize.width
        
        var boxMaxCount = Int((applicationWidth / width).rounded(.towardZero))
        var extraSpace =  Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) - Double((boxMaxCount * 15) + 15)
        extraSpace = abs(extraSpace)
        if(Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) < Double((boxMaxCount * 15) + 15)){
            width = 105.0
            boxMaxCount = Int((applicationWidth / width).rounded(.towardZero))
            extraSpace =  Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) - Double((boxMaxCount * 15) + 15)
        }
        
        width = width + Double((extraSpace / Double(boxMaxCount)))
        
        return CGSize(width: width, height: width * 1.21)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.closeMoreServices()
        let item = self.moreDataFor22[indexPath.row]
        
        self.openCategory(item: item)
        
    }
    
    func openCategory(item:NSDictionary){
        
        // Check for eType = "Webview" first (higher priority)
        let eType = item.get("eType")
        let eCatType = item.get("eCatType")
        
        // Handle Webview types
        if(eCatType.uppercased() == "WEBVIEW" || eType.uppercased() == "WEBVIEW") {
            var webviewTitle = generalFunc.getLanguageLabel(origValue: "", key: userProfileJson.get("webview_title"))
            
            // If eType is Webview, use vCategoryName as title
            if eType.uppercased() == "WEBVIEW" {
                webviewTitle = item.get("vCategoryName")
            }
            
            let webviewLink = item.get("vWebviewUrl")
            print("vWebviewUrl: \(webviewLink)")
            openFullScreenWebView(title: webviewTitle, link: webviewLink)
            return
        }
        
        // Handle RideReserve
        if(eCatType.uppercased() == "RIDERESERVE") {
            directOpenSchduleView()
            return
        }
        
        // Handle AddStop
        if(eCatType.uppercased() == "ADDSTOP") {
            _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item, addStop: true)
            return
        }
        
        // Handle ServiceProvider
        if(eCatType.uppercased() == "SERVICEPROVIDER"){
            
            if  item.get("iParentId") != "0" {
                let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                mainScreenUv.ufxSelectedVehicleTypeId = item.get("iVehicleCategoryId")
                mainScreenUv.eForVideoConsultation = item.get("eVideoConsultEnable")
                mainScreenUv.ufxSelectedVehicleTypeParentId = item.get("iParentId")
                mainScreenUv.ufxSelectedVehicleTypeName = item.get("vParentCategoryName")
                mainScreenUv.ufxSelectedLatitude = self.selectedLatitude
                mainScreenUv.ufxSelectedLongitude = self.selectedLongitude
                mainScreenUv.ufxSelectedAddress = self.selectedAddress
                self.push(uv: mainScreenUv)
                return
            }
            let uFXServicesUV = GeneralFunctions.instantiateViewController(pageName: "UFXServicesUV") as! UFXServicesUV
            uFXServicesUV.currentCategory = ""
            uFXServicesUV.currentMode = "SUB_MODE"
            uFXServicesUV.selectedAddress = self.selectedAddress
            uFXServicesUV.selectedLatitude = self.selectedLatitude
            uFXServicesUV.selectedLongitude = self.selectedLongitude
            uFXServicesUV.currentLocation = self.currentLocation
            uFXServicesUV.eForVideoConsultation = item.get("isVideoConsultEnable")
            
            uFXServicesUV.selectedServiceParentID = item.get("iVehicleCategoryId")
            self.push(uv: uFXServicesUV)
            return
        }
        
        // Handle Bidding
        if(eCatType.uppercased() == "BIDDING") {
            let uFXServicesUV = GeneralFunctions.instantiateViewController(pageName: "UFXServicesUV") as! UFXServicesUV
            uFXServicesUV.currentCategory = ""
            uFXServicesUV.currentMode = "SUB_MODE"
            uFXServicesUV.selectedAddress = self.selectedAddress
            uFXServicesUV.selectedLatitude = self.selectedLatitude
            uFXServicesUV.selectedLongitude = self.selectedLongitude
            uFXServicesUV.currentLocation = self.currentLocation
            uFXServicesUV.eForVideoConsultation = ""
            uFXServicesUV.selectedServiceParentID = item.get("iBiddingId")
            uFXServicesUV.currentCategory = item.get("eCatType")
            self.push(uv: uFXServicesUV)
            return
        }
        
        // Default handler
        _ = OpenCatType.init(uv: self, navItem: self.homeTabBar.navItem, item: item)
    }
    
   
    func openFullScreenWebView(title: String, link: String) {
        guard let url = URL(string: link), !link.isEmpty else { return }

        let webVC = UIViewController()
        webVC.title = title
        webVC.view.backgroundColor = .white

        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webVC.view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: webVC.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: webVC.view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: webVC.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: webVC.view.trailingAnchor)
        ])

        webView.load(URLRequest(url: url))

        webVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: webVC,
            action: #selector(UIViewController.dismissWebVC)
        )

        let nav = UINavigationController(rootViewController: webVC)

    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = SColors.Theme
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.tintColor = .white

        nav.modalPresentationStyle = .fullScreen

        self.present(nav, animated: true)
    }
 
    
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
    }
    
    func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
            
            Utils.delayWithSeconds(0.5) {
                var bottomBarHeight = 0.0
                if(self.homeTabBar != nil){
                    bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 55)
                }
                self.tableView.contentInset = UIEdgeInsets(top: self.tableTopInset, left: 0, bottom: 40, right: 0)
                bannerView.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)
                self.isGoogleAdLoad = true
                self.cntView.addSubview(bannerView)
            }
            
        }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
        print("bannerViewDidReceiveAd")
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        
        self.tableViewBottomSpace.constant = 0
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
        
        self.tableViewBottomSpace.constant = 0
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
            Utils.delayWithSeconds(0.5) {
                if  self.isGoogleAdLoad {
                    var bottomBarHeight = 0.0
                    if(self.homeTabBar != nil){
                        bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 100)
                    }
                    self.adView?.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)
                    self.tableView.contentInset = UIEdgeInsets(top: self.tableTopInset, left: 0, bottom: 80, right: 0)
                }else{
                    var bottomBarHeight = 0.0
                    if(self.homeTabBar != nil){
                        bottomBarHeight = Application.screenSize.height - (self.homeTabBar.kBarHeight + 50)
                    }
                    self.adView?.frame = CGRect(x: 0, y: bottomBarHeight, width: Application.screenSize.width, height: 50)
                    self.tableView.contentInset = UIEdgeInsets(top: self.tableTopInset, left: 0, bottom: 40, right: 0)
                }
                self.cntView.addSubview(adView)
            }

        }
    
    
    func checkSelectedCategories(isFromSearch : Bool){
        if(self.selectedLatitude == "" || self.selectedLongitude == ""){
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
            return
        }
        
        if(isFromSearch){
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
                // mainScreenUv.eForVideoConsultation = self.eForVideoConsultation
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
    
    
    var isFromSearchServicesUV = false
    @IBAction func unwindToUFXProScreen(_ segue:UIStoryboardSegue) {
        
        
        if(segue.source.isKind(of: MainScreenUV.self)){
            let mainScreenUv = segue.source as! MainScreenUV
            
            
            
        }else if(segue.source.isKind(of: MultiDeliveryOptionsUV.self) || segue.source.isKind(of: UFXCheckOutUV.self) || segue.source.isKind(of: MyOnGoingTripsUV.self) || segue.source.isKind(of: RideHistoryUV.self)) {
            
            
        }else if(segue.source.isKind(of: SearchSearvicesUV.self)) {
            
            self.isFromSearchServicesUV = true
            let searchSearvicesUV = segue.source as! SearchSearvicesUV
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){
                
                //  self.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
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
            }else if(self.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && searchSearvicesUV.dataDic.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                
                let uFXServicesUV = GeneralFunctions.instantiateViewController(pageName: "UFXServicesUV") as! UFXServicesUV
                uFXServicesUV.currentCategory = ""
                uFXServicesUV.currentMode = "SUB_MODE"
                uFXServicesUV.selectedAddress = self.selectedAddress
                uFXServicesUV.selectedLatitude = self.selectedLatitude
                uFXServicesUV.selectedLongitude = self.selectedLongitude
                uFXServicesUV.currentLocation = self.currentLocation
                uFXServicesUV.eForVideoConsultation = searchSearvicesUV.dataDic.get("isVideoConsultEnable")
                
                uFXServicesUV.selectedServiceParentID = searchSearvicesUV.dataDic.get("iVehicleCategoryId")
                self.push(uv: uFXServicesUV)
            }
            if searchSearvicesUV.dataDic.get("eCatType").uppercased() == "BIDDING"{
                // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                if searchSearvicesUV.dataDic.get("iParentId") != "0" {
                    let bidInfromationUV = GeneralFunctions.instantiateViewController(pageName: "BidInfromationUV") as! BidInfromationUV
                    bidInfromationUV.bidCategory = searchSearvicesUV.dataDic.get("vCategory")
                    bidInfromationUV.bidID =  searchSearvicesUV.dataDic.get("iBiddingId")
                    self.push(uv: bidInfromationUV)
                    
                }else{
                    
                    let uFXServicesUV = GeneralFunctions.instantiateViewController(pageName: "UFXServicesUV") as! UFXServicesUV
                    uFXServicesUV.currentCategory = ""
                    uFXServicesUV.currentMode = "SUB_MODE"
                    uFXServicesUV.selectedAddress = self.selectedAddress
                    uFXServicesUV.selectedLatitude = self.selectedLatitude
                    uFXServicesUV.selectedLongitude = self.selectedLongitude
                    uFXServicesUV.currentLocation = self.currentLocation
                    uFXServicesUV.eForVideoConsultation = searchSearvicesUV.dataDic.get("isVideoConsultEnable")
                    uFXServicesUV.selectedServiceParentID = searchSearvicesUV.dataDic.get("iBiddingId")
                    uFXServicesUV.currentCategory = searchSearvicesUV.dataDic.get("eCatType")
                    self.push(uv: uFXServicesUV)
                }
            }
        }
    }
    
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.uFXProBannerView.imagesArray.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        let image = (self.uFXProBannerView.imagesArray[index]).get("vImage")
        
        var widthMinusValue = 60
        if self.uFXProBannerView.imagesArray.count == 1 && (ServiceModule.deliveryKing || ServiceModule.deliveryProduct){
            widthMinusValue = 30
        }
        var imgView:UIImageView!
        if (view == nil){
            
            let ration = self.uFXProBannerView.bannerWidth / self.uFXProBannerView.bannerHeight
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: Int(carousel.frame.size.width) - widthMinusValue, height: Int(Utils.getHeightOfBanner(widthOffset: CGFloat(widthMinusValue), ratio: "", ration))))
            
            imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
            imgView.sd_setImage(with: URL(string: image), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            
            imgView.masksToBounds = true
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFit
            
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
            imgView.cornerRadius = 16
            
            
        }else{
            imgView = view as? UIImageView
            
            imgView.sd_setImage(with: URL(string: image), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            
            imgView.masksToBounds = true
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFit
            
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
            
            imgView.cornerRadius = 16
            
        }
        
        //        if(carousel.currentItemIndex == 0 || self.uFXProBannerView.imagesArray.count - 1 == carousel.currentItemIndex) {
        //            if(self.uFXProBannerView.imagesArray.count - 1 == carousel.currentItemIndex){
        //                carousel.contentOffset = CGSize(width: 15, height: 0)
        //            }else{
        //                carousel.contentOffset = CGSize(width: -15, height: 0)
        //            }
        //
        //        }else{
        //            carousel.contentOffset = CGSize(width: 0, height: 0)
        //        }
        
        return imgView
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
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        if(carousel.currentItemIndex == 0 || self.uFXProBannerView.imagesArray.count - 1 == carousel.currentItemIndex) {
            if(self.uFXProBannerView.imagesArray.count - 1 == carousel.currentItemIndex){
                carousel.contentOffset = CGSize(width: 15, height: 0)
            }else{
                carousel.contentOffset = CGSize(width: -15, height: 0)
            }
            
        }else{
            carousel.contentOffset = CGSize(width: 0, height: 0)
        }
        
    }
    func directOpenSchduleView (){
        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
        mainScreenUv.isFromNow = true
        mainScreenUv.isFromUFXhomeScreen = true
        mainScreenUv.APP_TYPE = "Ride"
        self.push(uv: mainScreenUv)
    }
    func openDestinationView (){
        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
        mainScreenUv.APP_TYPE = "Ride"
        mainScreenUv.pickUpLocation =  CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLongitude))
        mainScreenUv.pickUpAddress = self.selectedAddress
        mainScreenUv.isFromUFXhomeScreen = true
        mainScreenUv.isDirectDestFromHome = true
        
        self.push(uv: mainScreenUv)
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
        
        
       
            if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
           
            }
            if(self.selectedAddress != ""){
                self.enterLocLbl.text = self.selectedAddress
                
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
            
           
        }
        
    }
    @objc func titleViewTapped(){
        openPlaceFinder()
    }
    func myBtnTapped(sender: MyButton) {
        if sender.btnType == "SEND_PARCEL"{
            self.openMoreView(dataArray: self.moreDataFor22, moreTitle:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_SEND_PARCEL_BTN_TXT") )
        }
    }
}

extension UIViewController {
    @objc func dismissWebVC() {
        self.dismiss(animated: true)
    }
}
