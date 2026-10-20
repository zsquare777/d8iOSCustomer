//
//  UFXServicesUV.swift
//  UserApp
//
//  Created by Apple on 23/12/22.
//


import UIKit
import SysBaseLib
import CoreLocation
import AdvancedPageControl

class UFXServicesUV: ParentViewUV,ParentViewUVDelegate, iCarouselDataSource, iCarouselDelegate, MXParallaxHeaderDelegate, OnLocationUpdateDelegate, AddressFoundDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var serviceTitle22Lbl: MyLabel!
    
    @IBOutlet weak var ufxDataVerticalStackView: UIStackView!
    @IBOutlet weak var ufxDataVerticalStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bannerTopCarosoulView22Height: NSLayoutConstraint!
    @IBOutlet weak var bannerTopView22Height: NSLayoutConstraint!
    @IBOutlet weak var bannerTopCarosoulView22: iCarousel!
    @IBOutlet weak var bannerTopView22: UIView!
    
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var pageControllerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageSlideShowBGView: UIView!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var imgSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var selectSerivcesSubLbl: MyLabel!
    
    @IBOutlet weak var nextBtn: MyButton!
    @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var nextBtnBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var noServiceAvailLbl: MyLabel!
    
    @IBOutlet weak var mainPHView: UIView!
    @IBOutlet weak var ph7View: UIView!
    @IBOutlet weak var ph6View: UIView!
    @IBOutlet weak var ph5View: UIView!
    @IBOutlet weak var ph4View: UIView!
    @IBOutlet weak var ph3View: UIView!
    @IBOutlet weak var ph2View: UIView!
    @IBOutlet weak var ph1View: UIView!
    
    @IBOutlet weak var anchorViewWidth: NSLayoutConstraint!
    @IBOutlet weak var anchorViewLeading: NSLayoutConstraint!
    
    
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    
    var shadowImageView:UIImageView!
    var shadowImageViewForSubCat:UIImageView!
    
    var titleView22:UIView!
    var enterLocLbl:MyLabel!
    
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var currentLocation:CLLocation!
    
    var locationDialog:OpenEnableLocationView!
    var getLocation:DeviceLocation!
    var getAddressFrmLocation:GetAddressFromLocation!
    
    var bannersItemList = [NSDictionary]()
    
    var userProfileJson:NSDictionary!
    var currentBannerScrollIndex = -1
    
    var currentCategory = ""
    var eForVideoConsultation = ""
    var isMedicalServices = false
    
    var selectedServiceParentID = ""
    var biddingID = ""
    
    var isDataLoading = false
    
    var currentItems = [NSDictionary]()
    var subCategoryItems = [NSDictionary]()
    
    var viewArray = [UIView]()
    var currentCategoryName = ""
    
    var currentMode = "PARENT_MODE"
    var selectedCategoryIds = [NSMutableDictionary]()
  
    var preSelectedServiceIdsString = ""
    var isFrameSet = false
    var loaderView:UIView!
    var isFromSearchServicesUV = false
    var placeholderMarker:Placeholder!
    var homeTabBar:HomeScreenTabBarUV!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if (type == 0) {
            
            cntView = self.generalFunc.loadView(nibName: "UFXServicesScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            
           
            scrollView.bounces = false
          
            self.setnavBarTintColor(color: SColors.Theme)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
         
            self.addTitleView22()
            
            
            if(self.currentLocation == nil){
                getLocation = DeviceLocation(uv: self, isContinuous: false)
                getLocation.buildLocManager(locationUpdateDelegate: self)
            }else{
                self.mainPHView.isHidden = false
                if(userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
                    self.selectedServiceParentID = userProfileJson.get("UBERX_PARENT_CAT_ID")
                }else{
                    if self.currentCategory.uppercased() == "BIDDING" {
                        self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID, category: "Bidding")
                    }else{
                        if(self.eForVideoConsultation.uppercased() == "YES") {
                            self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID, "Yes")
                        }else{
                            self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID)
                        }
                    }
                }
            }
            
        }else if (type == 1) {
            if(userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
                self.selectedServiceParentID = userProfileJson.get("UBERX_PARENT_CAT_ID")
                self.loadServiceCategory(parentCategoryId: self.selectedServiceParentID)
            }
            self.configRTL()
            self.addBack()
            if(self.isFromSearchServicesUV == false){
                GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: "" as AnyObject)
            }else{
                self.isFromSearchServicesUV = false
            }
            self.sepratorView.lightshadowOnCustomview()
          
        }else if (type == 2) {
            
            self.nextBtn.isHidden = false
            if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                if(self.view.safeAreaInsets.bottom > 0){
                    nextBtnBottomSpace.constant = 25
                }else{
                    nextBtnBottomSpace.constant = 40
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
           
            if(self.isDataLoading == true){
                self.setPlaceHolderView()
            }
            
            if self.homeTabBar != nil {
                self.addTitleView22()
            }
        }else if (type == 3) {
          //  self.navigationController?.setNavigationBarHidden(false, animated: false)
           // self.navigationController?.navigationBar.zPosition = -1
           // self.navigationController?.setNavigationBarHidden(false, animated: true)
           // self.setnavBarTintColor(color: SColors.Theme_1)
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
    
    
    func setBannerData22(){
        
        self.bannerTopView22.backgroundColor = UIColor.white
            
        self.bannerTopCarosoulView22.backgroundColor = UIColor.clear
            
        self.bannerTopCarosoulView22.type = .linear
        self.bannerTopCarosoulView22.scrollSpeed = 0.8
        self.bannerTopCarosoulView22.decelerationRate = 0.8
        self.bannerTopCarosoulView22.delegate = self
        self.bannerTopCarosoulView22.dataSource = self
        self.bannerTopCarosoulView22.bounces = false
        
        if self.bannersItemList.count <= 1 {
            self.bannerTopCarosoulView22.contentOffset = CGSize(width: 0, height: 0)
        }else{
            self.bannerTopCarosoulView22.contentOffset = CGSize(width: -15, height: 0)
        }
        
        if Configurations.isRTLMode() {
            self.bannerTopCarosoulView22.scrollToItem(at: self.currentBannerScrollIndex, animated: true)
        }
        self.bannerTopCarosoulView22.reloadData()
       
        if(self.bannersItemList.count > 0){
            self.bannerTopView22Height.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "",2.33)
            self.bannerTopCarosoulView22Height.constant =  self.bannerTopView22Height.constant
    
            self.scrollView.parallaxHeader.view = self.bannerTopView22
            self.scrollView.parallaxHeader.mode = .bottom
            self.scrollView.parallaxHeader.height = self.bannerTopView22Height.constant
            self.scrollView.parallaxHeader.minimumHeight = 0
            self.scrollView.parallaxHeader.delegate = self
        }else{
            self.bannerTopView22Height.constant = 0
            self.bannerTopCarosoulView22Height.constant = 0
            self.scrollView.parallaxHeader.view = self.containerView
            self.scrollView.parallaxHeader.mode = .bottom
            self.scrollView.parallaxHeader.height = 0
            self.scrollView.parallaxHeader.minimumHeight = 0
            self.scrollView.parallaxHeader.delegate = self
            self.containerView.frame.size = CGSize(width: self.view.frame.width, height: 0)

            self.view.layoutIfNeeded()
        }
        
        self.addTable22SubViews()
        
    }
    
    func addTable22SubViews(){
        
//        if(self.shadowImageViewForSubCat != nil){
//            self.shadowImageViewForSubCat.removeFromSuperview()
//            self.shadowImageViewForSubCat = nil
//        }
//        self.shadowImageViewForSubCat = UIImageView.init(frame: CGRect(x: 0, y: -45, width: Application.screenSize.width, height: 50))
//        shadowImageViewForSubCat.image = UIImage(named: "shadow_gray")
//
//        self.scrollView.addSubview(shadowImageViewForSubCat)
    
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
    
        
        
        let titleViewTapGue = UITapGestureRecognizer()
        titleViewTapGue.addTarget(self, action: #selector(self.titleViewTapped))

        titleView22.isUserInteractionEnabled = true
        titleView22.addGestureRecognizer(titleViewTapGue)
        
        if(self.selectedAddress != ""){
            self.enterLocLbl.text = self.selectedAddress
        }
        if self.homeTabBar != nil {
            self.homeTabBar.navItem.titleView = titleView22
        }else{
            self.navigationItem.titleView = titleView22
        }
        
       
        
        if(self.userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP").uppercased() == "YES"){
            
            if(self.selectedAddress != ""){
                self.enterLocLbl.text = self.selectedAddress
                
            }
        }
        
    }
    
    @objc func titleViewTapped(){
        openPlaceFinder()
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
        
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
        
        
    }
    
    func setPlaceHolderView(){
        
        self.mainPHView.isHidden = false
       
        placeholderMarker = Placeholder()
        let viewElements: [UIView] = [ph1View, ph2View, ph3View, ph4View, ph5View, ph6View, ph7View]
            
        placeholderMarker.register(viewElements)
        placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.mainPHView != nil){
            self.contentView.isHidden = false
            self.mainPHView.isHidden = true
        }
    }

    
    func onAddressFound(address: String, location: CLLocation, isPickUpMode: Bool, dataResult: String) {
        self.selectedLatitude = "\(location.coordinate.latitude)"
        self.selectedLongitude = "\(location.coordinate.longitude)"
        self.selectedAddress = address
        
        GeneralFunctions.saveValue(key: "user_current_latitude", value: String(self.selectedLatitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_longitude", value: String(self.selectedLongitude) as AnyObject)
        GeneralFunctions.saveValue(key: "user_current_Address", value: String(self.selectedAddress) as AnyObject)
        
        if self.selectedAddress != ""{
            
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
        if(self.enterLocLbl != nil){
            self.enterLocLbl.text = address
            
        }
        self.addTitleView22()
    }
    
    func loadServiceCategory(parentCategoryId:String, category :String = "", _ eForVideoConsultation:String = ""){
        
        self.mainPHView.isHidden = false
        self.isDataLoading = true
        currentCategory = category
        selectedServiceParentID = parentCategoryId
        scrollView.isHidden = true
        scrollView.scrollToTop()
        
        
        self.biddingID = ""
        

       
        var parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId": parentCategoryId,"vLatitude": self.selectedLatitude, "vLongitude": self.selectedLongitude, "eForVideoConsultation":eForVideoConsultation]
        if category.uppercased() == "BIDDING"{
            parameters["eCatType"] = category
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
        
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
                self.setBannerData22()
                
                self.setPageController()
                
                
                if(dataDict.get("Action") == "1"){
                    
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    // Cache Sub CategoriesData
                   // self.subServicesResponseHandling()
                    
                    self.currentItems.removeAll()
                    if(parentCategoryId != "0"){
                        self.subCategoryItems.removeAll()
                    }
                    
                    var categoryItems = [NSDictionary] ()
                    
                    for i in 0..<msgArr.count{
                        categoryItems += [msgArr[i] as! NSDictionary]
                    }
                    
                    self.currentItems.append(contentsOf: categoryItems)
                    
                  
                    self.selectSerivcesSubLbl.backgroundColor = UIColor(hex: 0xf1f1f1)
                   
                    self.serviceTitle22Lbl.text = dataDict.get("vParentCategoryName")
                    self.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
                    self.subCategoryItems.append(contentsOf: categoryItems)
                    

                    
                    self.eForVideoConsultation = eForVideoConsultation
                    self.setSubCategoryMode(vParentCategoryName: dataDict.get("vParentCategoryName"))
                    
                    
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
    
    func setSubCategoryMode(vParentCategoryName:String){
        
       // self.loadProviders(vCatID: <#T##String#>)
        
        viewArray.removeAll()
        self.currentCategoryName = ""
        self.serviceTitle22Lbl.layer.borderColor = UIColor.clear.cgColor
        
        self.anchorView.backgroundColor = UIColor(hex: 0xf9f9f9)
        self.anchorSubView.backgroundColor = SColors.Theme
        
        self.anchorView.isHidden = true //AnchorView Hide
        self.anchorViewWidth.constant = 0
        self.anchorViewLeading.constant = 0
        
        if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
            self.nextBtn.isHidden = false
        }
        
        SDImageCache.shared().clearMemory()
        self.currentMode = "SUB_MODE"
        //self.addTitleView()
        self.noServiceAvailLbl.isHidden = true
        
       // rduView.isHidden = true
        self.scrollView.isHidden = false
        
        self.selectedCategoryIds.removeAll()

        self.scrollView.parallaxHeader.view = self.containerView
        self.scrollView.parallaxHeader.mode = .bottom
        self.scrollView.parallaxHeader.height = 50
        self.scrollView.parallaxHeader.minimumHeight = 50
        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
        
            self.addBack()
            
            self.nextBtn.isHidden = false
            self.setBannerData22()
            
        }else{
           
            self.setBannerData22()
            
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
            

            
            parentGridView.backgroundColor = UIColor(hex: 0xFFFFFF)
            Utils.createRoundedView(view: parentGridView, borderColor: .clear, borderWidth: 0, cornerRadius: 8)
            
            parentGridView.layer.shadowColor = UIColor.lightGray.cgColor
            parentGridView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
            parentGridView.layer.shadowRadius = 1.5
            parentGridView.layer.shadowOpacity = 1
            parentGridView.layer.masksToBounds = false
            
            (parentGridView.subviews[3] as! UIView).isHidden = true
            
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
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.ThemeTxt)
                    (parentGridView.subviews[5]).backgroundColor = SColors.Theme
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
                                GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.ThemeTxt)
                                (parentGridView.subviews[5]).backgroundColor =  SColors.Theme
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
            if(userProfileJson.get("UBERX_PARENT_CAT_ID") != "0") {
                if(self.view.safeAreaInsets.bottom > 0){
                    nextBtnBottomSpace.constant = self.homeTabBar.kBarHeight + 25
                }else{
                    nextBtnBottomSpace.constant = self.homeTabBar.kBarHeight + 40
                }
            }else{
                if(self.view.safeAreaInsets.bottom > 0){
                    nextBtnBottomSpace.constant = 25
                }else{
                    nextBtnBottomSpace.constant = 40
                }
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
            self.cntView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.cntView.frame.height)
            }
        }
        
       self.setApplicationStatusBar()
        
    }
    
    @objc func itemTapped(catView:UIView, position:Int){
        if(position >=  self.currentItems.count){
            return
        }
        if(loaderView != nil && loaderView.isHidden == false){
            return
        }
      
        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE"){
           
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
    
    func setValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String, _ value:String){
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                self.selectedCategoryIds[i][keyOfValue] = value
                break
            }
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
    
    func getValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String) -> String{
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                return tempDataDict.get(keyOfValue)
            }
        }
        
        return ""
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
        self.pageController.isHidden = true
        pageControllerWidth.constant = CGFloat((self.bannersItemList.count * 15) + 15)
        if pageControllerWidth.constant > Application.screenSize.width {
            pageControllerWidth.constant = Application.screenSize.width - 40
        }
        self.pageController.numberOfPages = self.bannersItemList.count
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
    
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.bannersItemList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
     
        if(self.bannerTopCarosoulView22 == carousel){
            
            var mainView:UIView!
            var imgView:UIImageView!
            
            var widthMinusValue = 60
            if bannersItemList.count == 1 {
                widthMinusValue = 30
            }
            
            if (mainView == nil){
                
                
                let height = Utils.getHeightOfBanner(widthOffset: CGFloat(widthMinusValue), ratio: "",2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                
                
                //mainView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 60, height: height))
                imgView = UIImageView.init(frame: CGRect(x:0, y: 0, width: carousel.frame.size.width - CGFloat(widthMinusValue), height: height))

                //mainView.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - CGFloat(widthMinusValue))

                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
//                imgView.contentMode = .scaleAspectFit
//                imgView.layer.cornerRadius = 0
//                imgView.clipsToBounds = true
                
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
                //mainView.addSubview(imgView)
                
            }else{
                
                view?.backgroundColor = UIColor.init(hexString: self.bannersItemList[index].get("vStatusBarColor"), alpha: 1)
                
                
                
                imgView = view?.subviews[0] as? UIImageView
                
                let height = Utils.getHeightOfBanner(widthOffset: 60, ratio: "",2.33)
                let heightValue = Utils.getValueInPixel(value: height)
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 60)
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
//                imgView.contentMode = .scaleAspectFit
//                imgView.layer.cornerRadius = 0
//                imgView.clipsToBounds = true
                imgView.masksToBounds = true
                imgView.layer.masksToBounds = true
                imgView.contentMode = .scaleAspectFit
                
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
                imgView.cornerRadius = 16
              
            }
            
            return imgView
        }else{
            var imgView:UIImageView!
            if (view == nil){
                
                let height = Utils.getHeightOfBanner(widthOffset: 70, ratio: "16:9")
                let heightValue = Utils.getValueInPixel(value: height)
                
                
                imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 60, height: height))
                
                
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 60)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.contentMode = .scaleAspectFit
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
               
                
            }else{
                imgView = view as? UIImageView
                
                let height = Utils.getHeightOfBanner(widthOffset: 70, ratio: "16:9")
                let heightValue = Utils.getValueInPixel(value: height)
                let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 60)
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                
                imgView.contentMode = .scaleAspectFit
                imgView.layer.cornerRadius = 16
                imgView.clipsToBounds = true
              
            }
            
            return imgView
        }
        
    }
    
    
    
   func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
            
        if(self.bannerTopCarosoulView22 == carousel){
            
            if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
                if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                    self.bannerTopCarosoulView22.contentOffset = CGSize(width: 15, height: 0)
                }else{
                    self.bannerTopCarosoulView22.contentOffset = CGSize(width: -15, height: 0)
                }

            }else{
                self.bannerTopCarosoulView22.contentOffset = CGSize(width: 0, height: 0)
            }
           

           
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
        
        }
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if(self.bannerTopCarosoulView22 == carousel){
           
            //return value
            if(option == .spacing){
                if UIDevice.current.userInterfaceIdiom == .pad {
                   return value * 1.02
                }else{
                    return value * 1.04
                }
            }
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
    
    
}
