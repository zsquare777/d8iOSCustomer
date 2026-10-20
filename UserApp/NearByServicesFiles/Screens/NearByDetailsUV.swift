//
//  RentItemDetailsUV.swift
//  UserApp
//
//  Created by # Admin on 22/10/22.
//

import UIKit
import SysBaseLib
import AdvancedPageControl
import GoogleMaps

class NearByDetailsUV: ParentViewUV,ParentViewUVDelegate,iCarouselDataSource, iCarouselDelegate,MyBtnClickDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var scrCntView: UIView!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var topHeaderViewHight: NSLayoutConstraint!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var pageControllerWidth: NSLayoutConstraint!
    @IBOutlet weak var storeTypeImageView: UIImageView!
    var shadowImageView:UIImageView!
    @IBOutlet weak var lblStoreType: MyLabel!
    @IBOutlet weak var lblTitle: MyLabel!
    @IBOutlet weak var lblSubTitle: MyLabel!
    @IBOutlet weak var tblMainViewHight: NSLayoutConstraint!
    @IBOutlet weak var tblViewMainView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTimeStatus: UIView!
    @IBOutlet weak var lblOpenClose: MyLabel!
    @IBOutlet weak var lblOpenTime: MyLabel!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var lblAway: MyLabel!
    @IBOutlet weak var lblTime: MyLabel!
    @IBOutlet weak var locationImagView: UIImageView!
    @IBOutlet weak var lblAboutThisPlaceS: MyLabel!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var lblAboutThisStoreD: MyLabel!
    @IBOutlet weak var monStackView: UIStackView!
    @IBOutlet weak var monSHLbl: UILabel!
    @IBOutlet weak var monSVLbl: UILabel!
    @IBOutlet weak var tueStackView: UIStackView!
    @IBOutlet weak var tueSHLbl: UILabel!
    @IBOutlet weak var tueSVLbl: UILabel!
    @IBOutlet weak var wedStackView: UIStackView!
    @IBOutlet weak var wedSHLbl: UILabel!
    @IBOutlet weak var wedSVLbl: UILabel!
    @IBOutlet weak var thuStackView: UIStackView!
    @IBOutlet weak var thuSHLbl: UILabel!
    @IBOutlet weak var thuSVLbl: UILabel!
    @IBOutlet weak var friStackView: UIStackView!
    @IBOutlet weak var friSHLbl: UILabel!
    @IBOutlet weak var friSVLbl: UILabel!
    @IBOutlet weak var satStackView: UIStackView!
    @IBOutlet weak var satSHLbl: UILabel!
    @IBOutlet weak var satSVLbl: UILabel!
    @IBOutlet weak var sunStackView: UIStackView!
    @IBOutlet weak var sunSHLbl: UILabel!
    @IBOutlet weak var sunSVLbl: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailBGView: UIView!
    @IBOutlet weak var detailCloseBtn: UIButton!
    @IBOutlet weak var detailComapnyLbl: UILabel!
    @IBOutlet weak var detailCompAddLbl: UILabel!
    @IBOutlet weak var detailOpeHeaLbl: UILabel!
    
    @IBOutlet weak var timetouchView: UIView!
    var bannersItemList = [String]()
    var images = [NSDictionary]()
    var serviceList = [NSDictionary]()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    let generalFunc = GeneralFunctions()
    var data = NSDictionary()
    var isBottomViewHide = false
    var isFav = false
    var isfromMYlist = false
    var pickUpPinMarker:GMSMarker!
    var catID = ""
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAdress = ""
    var placeID = ""
    var nearByList = [NSDictionary]()
    var loaderView:UIView!
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
    if(type == 0){
        
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        cntView = self.generalFunc.loadView(nibName: "NearByDetailsScreenDesign", uv: self, contentView: containerView)
        self.containerView.addSubview(cntView)
        self.topHeaderView.isHidden = true
        self.containerView.alpha = 0
        self.containerView.isHidden = true
        self.tblView.register(UINib(nibName: "NearByCatTVCell", bundle: nil), forCellReuseIdentifier: "NearByCatTVCell")
        self.tblView.dataSource = self
        self.tblView.delegate = self
        
        self.getSerVices()
    }else if (type == 1) {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Details", key: "LBL_NEARBY_DETAILS")//title
        self.title = self.generalFunc.getLanguageLabel(origValue: "Details", key: "LBL_NEARBY_DETAILS")
        self.addBack()
        self.loadBanners()
        
    }else if (type == 2) {
       
        self.configRTL()
        self.containerView.isHidden = false
       
       
    }
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.bannersItemList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        var imgView:UIImageView!
       
        if (view == nil){
            
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
            imgView.backgroundColor = UIColor.systemGray5
            
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            
            
        }else{
            imgView = view as? UIImageView
            imgView.backgroundColor = UIColor.systemGray5
            
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            //
        }
        
        return imgView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {

        self.imgSlideShow.contentOffset = CGSize(width: 0, height: 0)
        pageController.setPage(carousel.currentItemIndex)
       
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        

        return value
       
    }
    func loadBanners(){
     
        
        let parameters = ["type":"getBanners","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            self.topHeaderView.isHidden = false
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    
                    for i in 0..<msgArr.count{
                        let tempItem = msgArr[i] as! NSDictionary
                        
                        
                    }
                    self.setHeaderView()
                    
                 
                }else{
                    
                    self.generalFunc.setError(uv: self)
                    
                    
                }
                
            }else{
                self.loadBanners()
                self.generalFunc.setError(uv: self)
            }
            
        })
    }
    func setHeaderView()  {
        self.topHeaderViewHight.constant =  Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
        self.pageController.setPage(0)
       
        self.pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.bannersItemList.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor:
                                                                SColors.Theme, dotsColor: UIColor.white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        
        self.pageController.backgroundColor = UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.7)
        self.pageController.layer.cornerRadius = 8
        self.pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        self.pageControllerWidth.constant = CGFloat((self.bannersItemList.count * 10) + 45)
        self.imgSlideShow.type = .linear
        self.imgSlideShow.bounces = false
        self.imgSlideShow.scrollSpeed = 0.8
        self.imgSlideShow.decelerationRate = 0.8
        self.imgSlideShow.delegate = self
        self.imgSlideShow.dataSource = self
        if(self.shadowImageView != nil){
            self.shadowImageView.removeFromSuperview()
            self.shadowImageView = nil
        }
       
        self.shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: topHeaderViewHight.constant - 50, width: Application.screenSize.width, height: 50))
        shadowImageView.image = UIImage(named: "ic_shadow_3")
      
        self.topHeaderView.addSubview(shadowImageView)
    }
    func setData() {
        
        self.lblTitle.text = self.nearByList[0].get("vTitle")
        self.lblSubTitle.text = self.nearByList[0].get("vAddress")
        self.lblStoreType.text = self.nearByList[0].get("vCategoryName")
        self.lblStoreType.textColor = SColors.ThemeTxt
        self.lblStoreType.backgroundColor = SColors.Theme
        self.locationImagView.image = UIImage.init(named: "ic_location_Neayby")
        self.timeImageView.image = UIImage.init(named: "ic_clock_Nearby")
        GeneralFunctions.setImgTintColor(imgView: self.storeTypeImageView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.locationImagView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.timeImageView, color: SColors.Theme)
        if(Configurations.isRTLMode()){
            self.lblAboutThisPlaceS.textAlignment = .right
        }
        self.storeTypeImageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0).concatenating(CGAffineTransform(scaleX: 1, y: -1))
        
        self.tblMainViewHight.constant = CGFloat(self.serviceList.count * 60) + 10
        self.lblAway.text = self.nearByList[0].get("duration")
        if self.nearByList[0].get("placesStatus").uppercased() == "CLOSED" {
            self.lblOpenClose.textColor = SColors.red
        }else{
            self.lblOpenClose.textColor = SColors.Green
        }
            self.lblOpenClose.handleClick { instance in
                self.timeSlotHandel()
            }
            self.lblOpenTime.handleClick { instance in
                self.timeSlotHandel()
            }
            self.timetouchView.handleClick { instance in
                self.timeSlotHandel()
            }
        
        self.prepareDetailView()
        self.lblOpenClose.text = self.nearByList[0].get("statusMessage").uppercased()
        self.lblOpenTime.text = self.nearByList[0].get("openCloseTimeMessage").uppercased()
        self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.anchorSubView.backgroundColor = SColors.Theme
        
        self.lblAboutThisStoreD.textAlignment = .justified
        
        self.lblAboutThisStoreD.text = self.nearByList[0].get("vAboutPlaces")
        if self.lblAboutThisStoreD.text != "" {
            self.lblAboutThisPlaceS.text = self.generalFunc.getLanguageLabel(origValue: "About this place", key: "LBL_NEARBY_ABOUT_PLACE")
        }else{
            self.lblAboutThisPlaceS.text = ""
            self.anchorView.isHidden = true
        }
        self.shadowOnview(view: self.tblViewMainView)
        Utils.delayWithSeconds(0.5) {
            Utils.delayWithSeconds(0.1) {
                let tempScrContHight = self.topHeaderViewHight.constant + self.lblTitle.frame.size.height + self.lblSubTitle.frame.size.height + 50 + self.viewTimeStatus.frame.size.height
                let scrContentHight = tempScrContHight + self.tblMainViewHight.constant + self.lblAboutThisStoreD.frame.size.height + self.lblAboutThisPlaceS.frame.size.height
                      self.scrView.contentSize = CGSize(width: self.scrView.contentSize.width, height: scrContentHight + 100)
                 
            }
        }
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    
    func myBtnTapped(sender: MyButton) {
        
    }
    func getSerVices()  {
        
        
        self.setLoader(ishidden: false)
        
        let parameters = ["type":"getNearByPlaces", "iMemberId":GeneralFunctions.getMemberd(), "iCategoryId" : catID , "vLongitude" :selectedLongitude , "vLatitude" : selectedLatitude ,"iNearByPlacesId" : placeID]
    
    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
    exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
    exeWebServerUrl.currInstance = exeWebServerUrl
    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
        self.setLoader(ishidden: true)
        if(response != ""){
            let dataDict = response.toDict()
            if(dataDict.get("Action") == "1"){
              
                self.bannersItemList.removeAll()
                self.nearByList = dataDict.arrOf("Places") as! [NSDictionary]
                self.bannersItemList = self.nearByList[0].arrOf("vImages") as! [String]
                self.serviceList = self.nearByList[0].arrOf("ServiceAction") as! [NSDictionary]
                self.setHeaderView()
                UIView.animate(withDuration: 0.2, animations: {
                    self.containerView.alpha = 1
                    self.containerView.isHidden = false
                    self.setHeaderView()
                    self.imgSlideShow.reloadData()
                    self.setData()
                    self.tblView.reloadData()
                }, completion:{ _ in
                })
             
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
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.serviceList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 65
        }else{
           return 60
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearByCatTVCell", for: indexPath) as! NearByCatTVCell
        let item = self.serviceList[indexPath.item]
        cell.descriptionLbl.text = item.get("vTitle")
        Utils.createRoundedView(view: cell.arrowView, borderColor: .clear, borderWidth: 0)
        cell.arrowView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        cell.containerView.backgroundColor = UIColor.white
        cell.containerView.tag = indexPath.row
        cell.descriptionLbl.textColor = SColors.blackColor
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value:35), height: Utils.getValueInPixel(value:35))
        cell.imgCategory.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        cell.containerView.handleClick { instance in
            self.handelCatgory(index: instance.tag)
        }
        if(Configurations.isRTLMode()){
            cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")?.rotate(180)
        }else{
            cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")
        }
        return cell
    }
   
    func handelCatgory(index : Int)  {
        let item = self.serviceList[index]
         if item.get("eType").uppercased() == "CALL" {
             guard let url = URL(string: "telprompt://\(item.get("vPhone"))"),
                     UIApplication.shared.canOpenURL(url) else {
                     return
                 }
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }else if item.get("eType").uppercased() == "LOCATION" {
             
             let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(selectedLatitude) ?? 0.0, longitude: Double(selectedLongitude) ?? 0.0)))
             source.name = self.selectedAdress
                     
             let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(item.get("vPlacesLocationLat")) ?? 0.0, longitude: Double(item.get("vPlacesLocationLong")) ?? 0.0)))
             destination.name = item.get("vPlacesLocation")
                     
             MKMapItem.openMaps(
               with: [source, destination],
               launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
             )

         }else if item.get("eType").uppercased() == "TAXI" {
             let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
             mainScreenUv.APP_TYPE = "Ride"
           
              mainScreenUv.ufxSelectedLatitude = self.selectedLatitude
              mainScreenUv.ufxSelectedLongitude = self.selectedLongitude
              mainScreenUv.ufxSelectedAddress = self.selectedAdress
              mainScreenUv.pickUpAddress = self.selectedAdress
             mainScreenUv.pickUpLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.selectedLongitude))
              mainScreenUv.nearByLat = item.get("vPlacesLocationLat")
              mainScreenUv.nearByLong = item.get("vPlacesLocationLong")
              mainScreenUv.nearByLocation = item.get("vPlacesLocation")
             mainScreenUv.isFromNearBy = true
             if item.get("eForMedicalService").uppercased() == "YES" {
                 mainScreenUv.isMedicalServices = true
             }else{
                 mainScreenUv.isMedicalServices = false
             }
             mainScreenUv.isFromUFXhomeScreen = true
             self.push(uv: mainScreenUv)
             return
         }else if item.get("eType").uppercased() == "DELIVERYALL" {
         
             let tempitem = self.serviceList[index]
             let item = tempitem.dictOf("CompanyDetails")
             let restDetailView = GeneralFunctions.instantiateViewController(pageName: "RestaurantDetailsUV") as! RestaurantDetailsUV
//             if self.currentLocation == nil
//             {
//                 self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
//             }
             restDetailView.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
            // restDetailView.currentLocation = self.currentLocation
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
             //let navController = AppSnackbarController(rootViewController: UINavigationController(rootViewController: restDetailView))
             GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: self.nearByList[0].get("iServiceId") as AnyObject)
             self.push(uv: restDetailView)
             
             
         }else if item.get("eType").uppercased() == "DISCOUNTOFFER" {
            
             let openListView = OpenListView(uv: self, containerView: self.view)
             openListView.openNewList = true
             openListView.isFromProfile = true
             openListView.isFromDiscount = true
             openListView.disCountTitle = item.get("vTitle")
             openListView.disCountSubTitle = item.get("vOfferDiscount")
             openListView.discountImage = item.get("vImage")
             
             openListView.showCameraSheet(currentInst: openListView, handler: { (selectedItemId) in
                           
             
             
                         })
             
         }else if item.get("eType").uppercased() == "GENIE" {
             let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
             genieFindStoreUV.isFromPickDrop = false
             genieFindStoreUV.isFromNearBy = true
             genieFindStoreUV.storeName = item.get("vStoreName")
             genieFindStoreUV.storeAddress = item.get("vPlacesLocation")
             genieFindStoreUV.storeLat = item.get("vPlacesLocationLat")
             genieFindStoreUV.storeLong = item.get("vPlacesLocationLong")
             self.push(uv: genieFindStoreUV)
         }
    }
    func prepareDetailView()
    {
       
        self.detailCloseBtn.backgroundColor = SColors.Theme
        self.detailCloseBtn.setTitleColor(SColors.ThemeTxt, for: .normal)
        self.detailCloseBtn.setTitle(self.generalFunc.getLanguageLabel(origValue: "Close", key: "LBL_CLOSE_TXT"), for: .normal)
        

        self.detailComapnyLbl.text = self.nearByList[0].get("vTitle")
        self.detailCompAddLbl.text = self.nearByList[0].get("vAddress")
        self.detailOpeHeaLbl.text = self.generalFunc.getLanguageLabel(origValue: "Opening Hours", key: "LBL_OPENING_HOURS")
        
        self.monSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MONDAY_TXT")
               self.tueSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TUESDAY_TXT")
               self.wedSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WEDNESDAY_TXT")
               self.thuSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_THURSDAY_TXT")
               self.friSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FRIDAY_TXT")
               self.satSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SATURDAY_TXT")
               self.sunSHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUNDAY_TXT")
               
               if(self.nearByList[0].get("vMonToSlot1") != ""){
                   self.monSVLbl.text = self.nearByList[0].get("vMonToSlot1")
               }else{
                   self.monSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if(self.nearByList[0].get("vTueToSlot1") != ""){
                   self.tueSVLbl.text = self.nearByList[0].get("vTueToSlot1")
               }else{
                   self.tueSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if(self.nearByList[0].get("vWedToSlot1") != ""){
                   self.wedSVLbl.text = self.nearByList[0].get("vWedToSlot1")
               }else{
                   self.wedSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if(self.nearByList[0].get("vThuToSlot1") != ""){
                   self.thuSVLbl.text = self.nearByList[0].get("vThuToSlot1")
               }else{
                   self.thuSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if(self.nearByList[0].get("vFriToSlot1") != ""){
                   self.friSVLbl.text = self.nearByList[0].get("vFriToSlot1")
               }else{
                   self.friSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if(self.nearByList[0].get("vSatToSlot1") != ""){
                   self.satSVLbl.text = self.nearByList[0].get("vSatToSlot1")
               }else{
                   self.satSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
               
               if (self.nearByList[0].get("vSunToSlot1") != ""){
                   self.sunSVLbl.text = self.nearByList[0].get("vSunToSlot1")
               }else{
                   self.sunSVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
               }
       
        
    }
    @IBAction func detailCloseBtnAction(_ sender: Any) {
     
        self.detailView.isHidden = true
        self.detailBGView.isHidden = true
        
    }
    func timeSlotHandel(){
        self.detailView.isHidden = false
        self.detailView.transform = CGAffineTransform(scaleX: 0, y: 0)
    
    UIView.animate(withDuration: 0.4, animations: {
        self.detailBGView.isHidden = false
        self.detailView.transform = CGAffineTransform(scaleX: 1, y: 1)
        
    }, completion:{ _ in
        
    })
    }
}
