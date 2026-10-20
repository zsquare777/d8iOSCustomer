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

class RentItemDetailsUV: ParentViewUV,ParentViewUVDelegate,iCarouselDataSource, iCarouselDelegate,MyBtnClickDelegate {
    
    
    
    
    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var scrCntView: UIView!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var topHeaderViewHight: NSLayoutConstraint!
    var shadowImageView:UIImageView!
    @IBOutlet weak var nameLbl: MyLabel!
    @IBOutlet weak var conditionLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var addLbl: MyLabel!
    @IBOutlet weak var updatedByLbl: MyLabel!
    @IBOutlet weak var descriptionLbl: MyLabel!
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var pageControllerWidth: NSLayoutConstraint!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var locationTop: NSLayoutConstraint!
    @IBOutlet weak var pickUpViewHight: NSLayoutConstraint!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var detailsLbl: MyLabel!
    @IBOutlet weak var detailsMainView: UIView!
    @IBOutlet weak var durationLbl: MyLabel!
    @IBOutlet weak var detialsMainViewHight: NSLayoutConstraint!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationAnchorView: UIView!
    @IBOutlet weak var locationHLbl: MyLabel!
    @IBOutlet weak var locationLbl: MyLabel!
    @IBOutlet weak var locationAnchorSubView: UIView!
    @IBOutlet weak var PickUpView: UIView!
    @IBOutlet weak var PickUpAnchorView: UIView!
    @IBOutlet weak var PickUpAnchorSubView: UIView!
    @IBOutlet weak var pickUpTimeView: UIView!
    
    
    @IBOutlet weak var mapViewHight: NSLayoutConstraint!
    @IBOutlet weak var PickUpLbl: MyLabel!
    @IBOutlet weak var DateViewHight: NSLayoutConstraint!
    @IBOutlet weak var PickUpSubViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var mainViewHight: NSLayoutConstraint!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var gMapImageView: UIImageView!
    @IBOutlet weak var directionImgView: UIImageView!
    
    @IBOutlet weak var gMapContainerView: UIView!
    @IBOutlet weak var PickUpSubView: UIView!
    @IBOutlet weak var PickUpviewHight: NSLayoutConstraint!
    @IBOutlet weak var gMap: GMSMapView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var btnContactInfo: MyButton!
    @IBOutlet weak var bottomViewhight: NSLayoutConstraint!
    @IBOutlet weak var addressLblBottom: NSLayoutConstraint!
    @IBOutlet weak var descriptioHLbl: MyLabel!
    @IBOutlet weak var descriptionDLbl: MyLabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var btnCall: MyButton!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    @IBOutlet weak var descriptionSubView: UIView!
    @IBOutlet weak var pickupViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var detailsViewTop: NSLayoutConstraint!
    @IBOutlet weak var durationLblWidth: NSLayoutConstraint!
    var globlaPullContorleer = RentUserInfoUV()
    private var originalPullUpControllerViewSize: CGSize = .zero
    var bannersItemList = [String]()
    var images = [NSDictionary]()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    let generalFunc = GeneralFunctions()
    var data = NSDictionary()
    var isBottomViewHide = false
    var isFav = false
    var isfromMYlist = false
    var pickUpPinMarker:GMSMarker!
    var tempButtonWidth = 0.0
    var rentItemHomeuv : RentItemHomeUV!
    var isContactOwner = false
    var eType = ""
    var isOwnerPostSendInquiry = ""
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        if(type == 0){
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            cntView = self.generalFunc.loadView(nibName: "RentItemDetailsUV", uv: self, contentView: containerView)
            self.containerView.addSubview(cntView)
            self.topHeaderView.isHidden = true
            self.containerView.alpha = 0
            self.containerView.isHidden = true
            self.bottomView.isHidden = isBottomViewHide
            self.btnContactInfo.isHidden = isBottomViewHide
            self.shareView.isHidden =  true
            tempButtonWidth = Application.screenSize.width + 20
            if isBottomViewHide {self.bottomViewhight.constant = 0}
            self.bottomView.backgroundColor = SColors.Theme
            
            //        self.btnCall.clipsToBounds = true
            //        self.btnContactInfo.clipsToBounds = true
            self.btnCall.masksToBounds = true
            self.btnContactInfo.masksToBounds = true
            self.btnCall.layer.cornerRadius = 10.0
            self.btnContactInfo.layer.cornerRadius = 10.0
            
        }else if (type == 1) {
            // self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Product Details", key: "LBL_RENT_PRODUCT_DETAILS")//title
            //self.title = self.generalFunc.getLanguageLabel(origValue: "Product Details", key: "LBL_RENT_PRODUCT_DETAILS")
            self.setData()
            let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_receipt")!.resize(toWidth: 25)!.resize(toHeight: 25)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.getReceiptTapped))
            self.navigationItem.rightBarButtonItem = nil
            self.addBack()
            Utils.createRoundedView(view: self.shareView, borderColor: .clear, borderWidth: 0)
            self.shareView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
            
            if self.data.get("eIsFavourite").uppercased() == "YES" {
                self.isFav = true
                shareImageView.image = UIImage(named: "ic_sel_favStore")!.tintTo(color: SColors.red)!
            }else{
                self.isFav = false
                shareImageView.image = UIImage(named: "ic_dis_favStore")!.tintTo(color: SColors.red)!
            }
            self.shareView.handleClick { instance in
                self.isFav = !self.isFav
                if self.isFav {
                    self.shareImageView.image = UIImage(named: "ic_sel_favStore")!.tintTo(color: SColors.red)!
                }else{
                    self.shareImageView.image = UIImage(named: "ic_dis_favStore")!.tintTo(color: SColors.red)!
                }
                self.favPost()
            }
        }else if (type == 2) {
            
            
            self.containerView.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                self.containerView.alpha = 1
                self.images = self.data.arrOf("Images") as! [NSDictionary]
                self.loadBanners()
            }, completion:{ _ in
            })
        } else if (type == 3) {
            Utils.isOwnerPostSendInquiry = ""
        }
    }
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.images.count
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        var imgView:UIImageView!
        let tempData = self.images[index]
        
        if (view == nil){
            
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
            imgView.backgroundColor = UIColor.systemGray5
            
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:tempData.get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            
            
        }else{
            imgView = view as? UIImageView
            imgView.backgroundColor = UIColor.systemGray5
            
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: tempData.get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            //
        }
        imgView.handleClick { instance in
            if let url = URL(string: tempData.get("vImage")) {
                UIApplication.shared.open(url)
            }
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
        self.bannersItemList.removeAll()
        
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
                        
                        self.bannersItemList.append(tempItem.get("vImage"))
                    }
                    self.setHeaderView()
                    
                    
                }else{
                    
                    self.generalFunc.setError(uv: self)
                    
                    //self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
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
        
        self.pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.images.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor:
                                                                SColors.Theme, dotsColor: UIColor.white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        
        self.pageController.backgroundColor = UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.7)
        self.pageController.layer.cornerRadius = 8
        self.pageController.layer.masksToBounds = true
        if self.images.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        self.pageControllerWidth.constant = CGFloat((self.images.count * 10) + 45)
        self.imgSlideShow.type = .linear
        self.imgSlideShow.bounces = false
        self.imgSlideShow.scrollSpeed = 0.8
        self.imgSlideShow.decelerationRate = 0.8
        self.imgSlideShow.delegate = self
        self.imgSlideShow.dataSource = self
        
        self.topHeaderView.roundTo(corners: [.bottomLeft,.bottomRight], radius: 15)
        //        if(self.shadowImageView != nil){
        //            self.shadowImageView.removeFromSuperview()
        //            self.shadowImageView = nil
        //        }
        //
        //        self.shadowImageView = UIImageView.init(frame: CGRect(x: 0, y: topHeaderViewHight.constant - 50, width: Application.screenSize.width, height: 50))
        //        shadowImageView.image = UIImage(named: "shadow1")
        //
        //        self.topHeaderView.addSubview(shadowImageView)
    }
    func setData() {
        if Utils.isOwnerPostSendInquiry == "TRUE" {
            self.sepratorView.isHidden = true
            self.btnCall.isHidden = false
            self.btnContactInfo.isHidden = true
        } else {
            if self.data.get("isOwnerPostSendInquiry") == "Yes" {
                self.btnContactInfo.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_SEND_INQUIRY_TXT"))
                
                self.sepratorView.isHidden = true
                
                self.btnCall.isHidden = false
                self.btnContactInfo.isHidden = true
            }else{
                self.btnContactInfo.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Contact Owner", key: "LBL_RENT_CONTACT_OWNER"))
                self.btnContactInfo.isHidden = false
                self.btnCall.isHidden = true
                self.sepratorView.isHidden = true
                
                
            }
        }
        
        
        
        
        
        self.btnContactInfo.clickDelegate = self
        self.btnContactInfo.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: UIColor.clear, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        self.btnCall.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: UIColor.clear, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        self.btnCall.setButtonTitle(buttonTitle:  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_CONTACT_OWNER"))
        self.btnCall.clickDelegate = self
        self.nameLbl.textColor = SColors.textColor
        self.nameLbl.text = self.data.get("vItemName")
        if self.data.get("vItemName") == ""{
            self.nameLbl.text = " "
        }
        self.conditionLbl.text = ""
        self.priceLbl.text =  self.data.get("fAmount")
        if self.data.get("eRentItemDuration") != ""{
            self.durationLbl.text = self.data.get("eRentItemDuration")
            self.durationLblWidth.constant = 40
        }else{
            self.durationLbl.text = ""
            self.durationLblWidth.constant = 0
        }
        self.priceLbl.textColor = SColors.Theme
        self.addLbl.text = ""//self.data.get("vAddress")
        self.updatedByLbl.text = self.data.get("PostedTxt")
        self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.anchorSubView.backgroundColor = SColors.Theme
        //self.detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Detials", key: "LBL_RENT_ITEM_DETAILS")
        if eType == "RentEstate" {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PROPERTY_DETAIL")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PROPERTY_DETAIL")
            self.detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Property Details", key: "LBL_RENT_PROPERTY_DETAIL")
        }else if eType == "RentCars" {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_CAR_DETAILS")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_CAR_DETAILS")
            self.detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RENT_CAR_DETAILS")
        }
        else{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_DETAILS")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_DETAILS")
            
            self.detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_DETAILS")
        }
        let rentFiledNewArr = self.data.arrOf("RentitemFieldarray")
        self.addDetails()
        self.addslotStep8()
        self.descriptionDLbl.textColor = SColors.textColor
        for i in 0..<rentFiledNewArr.count {
            let dict_temp = rentFiledNewArr[i] as! NSDictionary
            
            if dict_temp.get("eDescription") == "Yes" {
                //self.descriptionLbl.text = dict_temp.get("Item Information")
                //self.descriptionDLbl.text = dict_temp.get("Item Information")
                for (key, value) in dict_temp {
                    
                    if key as! String != "eDescription"
                    {
                        //self.step8descriptionLbl.text =  Configurations.convertNumToAppLocal(numStr: value as! String)
                        self.descriptionDLbl.text =  Configurations.convertNumToAppLocal(numStr: value as! String)
                    }
                }
            }
        }
        if self.descriptionDLbl.text == "" {
            self.descriptionView.isHidden = true
            self.pickupViewTop.constant = -75
            self.descriptioHLbl.isHidden = true
        }
        self.descriptioHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Description", key: "LBL_RENT_DESCRIPTION_TXT")
        
        self.locationAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.locationAnchorSubView.backgroundColor = SColors.Theme
        self.locationHLbl.textColor = SColors.textColor
        self.locationHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Location", key: "LBL_RENT_LOCATION")
        self.locationLbl.textColor = SColors.textColor
        if self.data.get("eIsUserAddressDisplay") == "Yes"{
            self.locationLbl.isUserInteractionEnabled = true
            self.locationLbl.text = self.data.get("vAddress")
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
            self.locationLbl.addGestureRecognizer(longPressRecognizer)
            self.addressLblBottom.constant = 10
            self.locationView.isHidden = false
        }else{
            self.addressLblBottom.constant = -20
            self.locationLbl.isHidden = true
            self.locationLbl.backgroundColor = UIColor.clear
            self.locationView.isHidden = true
        }
        
        
        //        self.shadowOnview(view: self.descriptionView)
        self.shadowOnview(view: self.directionView)
        self.shadowOnview(view: self.detailsMainView)
        //        self.shadowOnview(view: self.descriptionSubView)
        //        self.shadowOnview(view: self.gMapContainerView)
        let location = CLLocation(latitude: Double(self.data.get("vLatitude"))!, longitude: Double(self.data.get("vLongitude"))!)
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Utils.defaultZoomLevel)
        self.gMap.camera = camera
        
        let marker = GMSMarker(position: location.coordinate)
        marker.icon = UIImage.init(named: "ic_black_loc")
        marker.map = self.gMap
        self.gMap.isUserInteractionEnabled = false
        self.bottomView.roundTo(corners: [.topLeft, .topRight], radius: 00)
        self.shadowOnview(view: self.PickUpSubView)
        self.gMap.layer.cornerRadius = 10
        self.gMap.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.PickUpAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.PickUpAnchorSubView.backgroundColor = SColors.Theme
        self.pickUpTimeView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.detailsView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.descriptionView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.gMapContainerView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.gMapContainerView.layer.cornerRadius = 10
        if self.eType == "RentCars"{
            self.PickUpLbl.text =  self.generalFunc.getLanguageLabel(origValue: "your availability", key: "LBL_RENT_ESTATE_AVAILABILTY_TXT")
        }else{
            self.PickUpLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pickup Avaliability", key: "LBL_RENT_ITEM_PICKUP_AVAILBILITY")
        }
        if(Configurations.isRTLMode()){
            self.PickUpLbl.textAlignment = .right
            self.detailsLbl.textAlignment = .right
            self.locationHLbl.textAlignment = .right
        }
        
        Utils.delayWithSeconds(0.1) {
            let tempScrContHight = self.topHeaderViewHight.constant + self.nameLbl.frame.size.height + self.conditionLbl.frame.size.height + self.priceLbl.frame.size.height + self.addLbl.frame.size.height + self.updatedByLbl.frame.size.height
            var scrContentHight = tempScrContHight + self.descriptionLbl.frame.size.height + self.detailsView.frame.size.height + self.PickUpView.frame.size.height
            if self.descriptionDLbl.text != "" {
                scrContentHight += self.descriptionView.frame.size.height
            }
            
            if self.data.get("eIsUserAddressDisplay") == "Yes" {
                scrContentHight += self.locationView.frame.size.height
            }
            self.scrView.contentSize = CGSize(width: self.scrView.contentSize.width, height: scrContentHight + 100)
            self.mainViewHight.constant = self.scrView.contentSize.height + 50
            print(scrContentHight)
        }
        self.directionView.handleClick { instance in
            let openNavOption = OpenNavOption(uv: self, containerView: self.view, placeLatitude: self.data.get("vLatitude"), placeLongitude: self.data.get("vLongitude"), address: self.data.get("vAddress"))
            openNavOption.chooseOption()
        }
        GeneralFunctions.setImgTintColor(imgView: self.directionImgView, color: UIColor(hex: 0x007AFF))
        
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    @objc func getReceiptTapped(){
        
    }
    
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnContactInfo{
            
            let rentSendInquiryUv = GeneralFunctions.instantiateViewController(pageName: "RentSendInquiryUv") as! RentSendInquiryUv
            rentSendInquiryUv.rentItemDetialsUV = self
            rentSendInquiryUv.data = self.data
            self.push(uv: rentSendInquiryUv)
            
        }else if sender == self.btnCall {
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            if self.userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == "VOIP"{
                
                self.audioCall()
                return
                
            }else if(userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == Utils.VIDEOCALL){
                
                self.videoCall()
                return
            }else if (userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == Utils.VOIP_VIDEOCALL) {
                let openListView = OpenListView(uv: self, containerView: self.view)
                openListView.openNewList = true
                openListView.isFromDate = true
                openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                    // 0 for video 1 for camera
                    if selectedItemId == 0 {
                        
                        self.videoCall()
                    }else {
                        self.audioCall()
                        
                    }
                    
                })
                return
            }else{
                print(self.data.get("vUserPhone"))
                guard let url = URL(string: "telprompt://\(self.data.get("vUserPhone"))"),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
    }
    func favPost()  {
        
        
        
        var  parameters = ["type":"UpdateUserFavouriteRentPost", "iMemberId":GeneralFunctions.getMemberd(), "iRentItemPostId" : self.data.get("iRentItemPostId")]
        if isFav {
            parameters["eIsFavourite"] = "Yes"
        }else{
            parameters["eIsFavourite"] = "No"
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    
                    
                }
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func addDetails()  {
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        
        let rentFiledNewArr = self.data.arrOf("RentitemFieldarray")
        for view in self.detailsMainView.subviews {
            view.removeFromSuperview()
        }
        for i in 0..<rentFiledNewArr.count {
            let dict_temp = rentFiledNewArr[i] as! NSDictionary
            
            
            if  dict_temp.get("eName") == "Yes" ||  dict_temp.get("eDescription") == "Yes" {
                
            }else{
                for (key, value) in dict_temp {
                    
                    let totalSubViewCounts = self.detailsMainView.subviews.count
                    
                    
                    let viewWidth = Application.screenSize.width - 60
                    
                    //                let viewCus1 = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))
                    //
                    //                viewCus1.backgroundColor = UIColor(hex: 0xdedede)
                    //                totalSeperatorViews = totalSeperatorViews + 1
                    //
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts) * 40), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font = UIFont(name: Fonts().semibold, size: 14)!
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 40
                    if(widthOfTitle > ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 70) / 100)){
                        widthOfvalue = ((viewWidth * 70) / 100)
                        widthOfTitle = ((viewWidth * 30) / 100)
                    }else if(widthOfTitle < ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 70) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }
                    
                    let widthOfParentView = viewWidth - widthOfvalue
                    
                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 40))
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 40))
                    
                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 40))
                        
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 28)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 30)
                    }
                    
                    lblTitle.textColor =  SColors.textColor//UIColor.black
                    lblValue.textColor = SColors.Theme
                    
                    
                    
                    lblTitle.font = font
                    lblValue.font = font
                    
                    lblTitle.fontFamilyWeight = "Medium"
                    lblValue.fontFamilyWeight = "Medium"
                    lblTitle.setFontFamily()
                    lblValue.setFontFamily()
                    
                    lblTitle.numberOfLines = 2
                    lblValue.numberOfLines = 2
                    
                    lblTitle.minimumScaleFactor = 0.5
                    lblValue.minimumScaleFactor = 0.5
                    
                    lblTitle.text = titleStr
                    lblValue.text = valueStr
                    
                    viewCus.addSubview(lblTitle)
                    viewCus.addSubview(lblValue)
                    //                    self.detailsMainView.addSubview(viewCus1)
                    self.detailsMainView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    
                    
                }
                self.detialsMainViewHight.constant = CGFloat((self.detailsMainView.subviews.count) * 40 )
            }
        }
        if self.detialsMainViewHight.constant < 10 {
            self.detailsView.isHidden = true
            Utils.delayWithSeconds(1) {
                self.locationTop.constant = -40
            }
            
        }else{
            self.detailsView.isHidden = false
            self.locationTop.constant = 0
            
        }
    }
    
    func addslotStep8()  {
        let rentFiledNewArr = self.data.arrOf("timeslot")
        if rentFiledNewArr.count == 0 {
            self.pickUpTimeView.isHidden = true
            self.detailsViewTop.constant = -80
        }else{
            self.detailsViewTop.constant = 20
            self.pickUpTimeView.isHidden = false
            for view in self.PickUpSubView.subviews {
                view.removeFromSuperview()
            }
            for i in 0..<rentFiledNewArr.count {
                let dict_temp = rentFiledNewArr[i] as! NSDictionary
                
                
                if  dict_temp.get("Name") == "Yes" ||  dict_temp.get("Description") == "Yes" {
                    
                }else{
                    for (key, value) in dict_temp {
                        
                        let totalSubViewCounts = self.PickUpSubView.subviews.count
                        
                        
                        let viewWidth = Application.screenSize.width - 80
                        
                        let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts) * 40), width: viewWidth, height: 40))
                        
                        let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                        let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                        
                        
                        var font = UIFont(name: Fonts().semibold, size: 16)!
                        var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 17
                        var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 17
                        if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                            widthOfvalue = ((viewWidth * 80) / 100)
                            widthOfTitle = ((viewWidth * 20) / 100)
                        }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                            widthOfvalue = viewWidth - widthOfTitle
                        }
                        
                        let widthOfParentView = viewWidth - widthOfvalue
                        
                        var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 40))
                        var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 40))
                        
                        if(Configurations.isRTLMode()){
                            lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                            lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 40))
                            
                            lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                            lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        }else{
                            lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                            lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                        }
                        
                        lblTitle.textColor = UIColor.black
                        lblValue.textColor = SColors.Theme
                        
                        
                        
                        lblTitle.font = font
                        lblValue.font = font
                        
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        
                        lblTitle.numberOfLines = 2
                        lblValue.numberOfLines = 2
                        
                        lblTitle.minimumScaleFactor = 0.5
                        lblValue.minimumScaleFactor = 0.5
                        
                        lblTitle.text = titleStr
                        lblValue.text = valueStr
                        
                        viewCus.addSubview(lblTitle)
                        viewCus.addSubview(lblValue)
                        
                        self.PickUpSubView.addSubview(viewCus)
                        
                        if(Configurations.isRTLMode()){
                            lblValue.textAlignment = .left
                        }else{
                            lblValue.textAlignment = .right
                        }
                        
                        
                        
                    }
                    self.pickUpViewHight.constant = CGFloat((self.PickUpSubView.subviews.count) * 40 )
                }
            }
        }
    }
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Copy", key: "LBL_RENT_ADDRESS_COPY_CLIPBOARD") , uv: self)
        UIPasteboard.general.string = self.locationLbl.text
    }
    func getDataFromQury(){
        self.btnCall.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_CONTACT_OWNER"))
        self.isContactOwner = true
        //        if self.data.get("eIsUserNumberDisplay") == "Yes" {
        self.sepratorView.isHidden = true
        self.btnCall.isHidden = false
        self.btnContactInfo.isHidden = true
        
        //        }
    }
    
    
    func audioCall(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType]
        let assignedDic = ["Id":self.data.get("iUserId"), "Name": self.data.get("vUserName"), "PImage": self.data.get("vUserImage"), "type": "Passenger"]
        
        
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.data.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
        return
    }
    func videoCall(){
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType, "isVideoCall":"Yes"]
        let assignedDic = ["Id":self.data.get("iUserId"), "Name": self.data.get("vUserName"), "PImage": self.data.get("vUserImage"), "type": "Passenger", "isVideoCall":"Yes"]
        
        
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.data.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
        return
    }
    override func close(){
        
        if rentItemHomeuv != nil {
            if self.isContactOwner{
                rentItemHomeuv.rentData.removeAll()
                rentItemHomeuv.tableView.reloadData()
                rentItemHomeuv.getPost()
                self.navigationController?.popViewController(animated: true)
                return
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

