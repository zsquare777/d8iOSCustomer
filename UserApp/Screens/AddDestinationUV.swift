

import UIKit
import GoogleMaps
import CoreLocation
import SysBaseLib

class AddDestinationUV: ParentViewUV, GMSMapViewDelegate, OnLocationUpdateDelegate, AddressFoundDelegate, MyBtnClickDelegate, ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var googleMapContainerView: UIView!
    @IBOutlet weak var addLocationBtn: MyButton!
    @IBOutlet weak var locAreaView: UIView!
    @IBOutlet weak var locLbl: MyLabel!
    @IBOutlet weak var selectLocImgView: UIImageView!
    
    @IBOutlet weak var viewRounded: UIView!
    @IBOutlet weak var editLocImgView: UIImageView!
    @IBOutlet weak var locContView: UIView!
    @IBOutlet weak var serviceAddHLbl: MyLabel!
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var changeLbl: MyLabel!
    @IBOutlet weak var checkImgView: UIImageView!
    var publishRideUV:PublishRideUV!
    var bookRideUV:BookRideUV!
    var centerLocation:CLLocation!
    
    var SCREEN_TYPE = "DESTINATION"
    
    let generalFunc = GeneralFunctions()
    
    var isFirstLocationUpdate = true
    var isPageLoaded = false
    var gMapView:GMSMapView!
    
    var isFromRecentLocView = false
    var isFromSearchPlaces = false
    var isFromRideDelivery = false
    
    var isFromSelectLoc = false
    var isFromMainScreen = false
    
    var getLocation:DeviceLocation!
    var rentItemPostUV:RentItemNewPostUV!
    var getAddressFrmLocation:GetAddressFromLocation!
    
    var selectedLocation:CLLocation!
    var selectedAddress = ""
    
    let placeMarker: GMSMarker = GMSMarker()
    
//    var isSkipCurrentChange = false
    var isSelectingLocation = false
    var isSkipMapLocSelectOnChangeCamera = false
    var isSkipCurrentMoveOnAddress = false
    
    var iUserFavAddressId = ""
    var userProfileJson:NSDictionary!
    
    /* MSP Changes*/
    var disableMSP = false
    var isPickUpMode = true
    var isFromInitialView = true
  
    var isDisableMapLocSelectOnChangeCamera = false
    var isPickMiss = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "AddDestinationScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            let userFavouriteAddressArr = userProfileJson.arrOf("UserFavouriteAddress")
            if(userFavouriteAddressArr.count > 0){
                for i in 0..<userFavouriteAddressArr.count {
                    let dataItem = userFavouriteAddressArr[i] as! NSDictionary
                    if(dataItem.get("eType").uppercased() == self.SCREEN_TYPE.uppercased()){
                        self.iUserFavAddressId = dataItem.get("iUserFavAddressId")
                    }
                }
            }
            
            self.bottomBgView.layer.addShadow(opacity: 0.9, radius: 3, UIColor.lightGray)
            self.backImgView.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.backImgView.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            
            self.changeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE").uppercased()
            self.changeLbl.textColor = SColors.Theme
    //        self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Service address", key: "LBL_SERVICE_ADDRESS_HINT_INFO")
            
        }else if(type == 1){
            
            self.configRTL()
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.backImgView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.backImgView.layer.roundCorners(radius: 25)
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//            self.viewRounded.roundTo(corners: [.topLeft,.topRight], radius: 15)
        }else if(type == 2){
            if(isPageLoaded == false){
                
                isPageLoaded = true
                
                let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 0.0)
    //            gMapView = GMSMapView.map(withFrame: self.googleMapContainerView.frame, camera: camera)
                gMapView = GMSMapView.map(withFrame: CGRect(x: 0, y:0, width: self.googleMapContainerView.frame.size.width, height: self.googleMapContainerView.frame.size.height), camera: camera)
                //        googleMapContainerView = gMapView
                //        gMapView = GMSMapView()
                //            gMapView.isMyLocationEnabled = true
                gMapView.delegate = self
                self.googleMapContainerView.addSubview(gMapView)
                
                setData()
                
            }
        }else if(type == 3){
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }
    }
    

    func setData(){
        if(SCREEN_TYPE == "DESTINATION"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LOCATION_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LOCATION_TXT")
            self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LOCATION_TXT")
        }else if(SCREEN_TYPE == "PICKUP"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_PICK_UP_LOCATION_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_PICK_UP_LOCATION_TXT")
            self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_LOC")
        }else if(SCREEN_TYPE == "HOME"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_LOCATION_TXT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_LOCATION_TXT")
            self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOME_LOCATION_TXT")
        }else if(SCREEN_TYPE == "WORK"){
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORKLOCATION")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORKLOCATION")
            self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WORKLOCATION")
        }else{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_LOC")
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_LOC")
            self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_LOC")
        }
        
        //self.locContView.layer.shadowColor = UIColor.lightGray.cgColor
        //self.locContView.layer.shadowOffset = CGSize(width: 0, height: 0)
       // self.locContView.layer.shadowRadius = 1.5
       // self.locContView.layer.shadowOpacity = 1
       //self.locContView.layer.masksToBounds = false
        
        self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_LOC")
        
        Utils.createRoundedView(view:self.checkImgView, borderColor: .clear, borderWidth: 0)
       // self.checkImgView.image = self.checkImgView.image?.addImagePadding(x: 25, y: 25)
       //' GeneralFunctions.setImgTintColor(imgView: self.checkImgView, color: SColors.Theme)
        
        self.addLocationBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_LOC"))
        self.addLocationBtn.clickDelegate = self
        //        self.addLocationBtn.unwindToActiveTrip
        
        getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
        
        if(centerLocation == nil){
            self.getLocation = DeviceLocation(uv: self, isContinuous: true)
            self.getLocation.buildLocManager(locationUpdateDelegate: self)
            
            if(GeneralFunctions.hasLocationEnabled() == false){
                self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_LOC")
                isDisableMapLocSelectOnChangeCamera = true
                self.selectLocImgView.isHidden = true
            }
            
        }else{
            isSkipCurrentMoveOnAddress = true
            self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
            
            getAddressFrmLocation.setLocation(latitude: centerLocation!.coordinate.latitude, longitude: centerLocation!.coordinate.longitude)
            getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: true)
            
            isSkipMapLocSelectOnChangeCamera = true
            self.animateGmapCamera(location: centerLocation!, zoomLevel: Utils.defaultZoomLevel)
            
        }
        
//        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LONG_TOUCH_CHANGE_LOC_TXT"), uv: self)
        
        let placeTapGue = UITapGestureRecognizer()
        placeTapGue.addTarget(self, action: #selector(self.launchPlaceFinder))
        
        
        changeLbl.isUserInteractionEnabled = true
        changeLbl.addGestureRecognizer(placeTapGue)
    
        
        
        //self.editLocImgView.isUserInteractionEnabled = true
       // self.editLocImgView.addGestureRecognizer(placeTapGue)
        //self.editLocImgView.backgroundColor = SColors.Theme
        
        
       // self.editLocImgView.image = UIImage.init(named: "ic_new_edit")
        //self.editLocImgView.image? = (editLocImgView.image?.addImagePadding(x: 12, y: 12))!
       // GeneralFunctions.setImgTintColor(imgView: self.editLocImgView, color: SColors.ThemeTxt)
        self.backImgView.handleClick { (instanse) in
            self.close()
        }
    }
    
    @objc func launchPlaceFinder(){
        let launchPlaceFinder = LaunchPlaceFinder(viewControllerUV: self)
        launchPlaceFinder.currInst = launchPlaceFinder
        launchPlaceFinder.isFromSelectLoc = true
        if(centerLocation != nil){
            launchPlaceFinder.setBiasLocation(sourceLocationPlaceLatitude: centerLocation!.coordinate.latitude, sourceLocationPlaceLongitude: centerLocation!.coordinate.longitude)
        }
        
        launchPlaceFinder.initializeFinder { (address, latitude, longitude) in
            
            self.selectedAddress = address
            self.selectedLocation = CLLocation(latitude: latitude, longitude: longitude)
            
            self.isDisableMapLocSelectOnChangeCamera = false
            
            self.selectLocImgView.isHidden = false
            
            self.isSelectingLocation = false
            
            self.isSkipMapLocSelectOnChangeCamera = true
            
            self.changeMarkerPosition(location: self.selectedLocation, zoomLevel: Utils.defaultZoomLevel)
            self.locLbl.text = address
        }
    }
    
    override func close() {
        releaseAllTask()
        super.close()
    }
    deinit {
        releaseAllTask()
    }
    
    func releaseAllTask(isDismiss:Bool = true){
        
        if(gMapView != nil){
            gMapView!.removeFromSuperview()
            gMapView!.clear()
            gMapView!.delegate = nil
            gMapView = nil
        }
        
        
        if(self.getLocation != nil){
            self.getLocation!.locationUpdateDelegate = nil
            self.getLocation!.releaseLocationTask()
            self.getLocation = nil
        }
        
        if(getAddressFrmLocation != nil){
            getAddressFrmLocation!.addressFoundDelegate = nil
            getAddressFrmLocation = nil
        }
        
        GeneralFunctions.removeObserver(obj: self)
        
        
        if(isDismiss){
//            self.dismiss(animated: false, completion: nil)
//            self.navigationController?.dismiss(animated: false, completion: nil)
        }
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
//        getAddressFrmLocation.setLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: true)
        
//        self.animateGmapCamera(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    func onLocationUpdate(location: CLLocation) {
        if(gMapView == nil){
            releaseAllTask()
            return
        }
        if(isFirstLocationUpdate == true){
            
            isDisableMapLocSelectOnChangeCamera = false
            isSkipCurrentMoveOnAddress = true
            isSkipMapLocSelectOnChangeCamera = true
            
            self.animateGmapCamera(location: location, zoomLevel: Utils.defaultZoomLevel)
            
            getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: true)
            
            self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
            
        }
        
        
        isFirstLocationUpdate = false
    }
    
    func onAddressFound(address: String, location:CLLocation, isPickUpMode:Bool, dataResult:String) {
        if(address == ""){
            return
        }
        
        self.selectLocImgView.isHidden = false
        
        self.locLbl.text = address
        
        
        
        self.selectedAddress = address
        self.selectedLocation = location
        
        self.isSelectingLocation = false
        
        if(isSkipCurrentMoveOnAddress == true){
            isSkipCurrentMoveOnAddress = false
            return
        }
        
        if(getCenterLocation().coordinate.latitude != location.coordinate.latitude || getCenterLocation().coordinate.longitude != location.coordinate.longitude){
            isSkipMapLocSelectOnChangeCamera = true
        }
        
        changeMarkerPosition(location: location, zoomLevel: self.gMapView.camera.zoom)
    }
    
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if(isSkipMapLocSelectOnChangeCamera == true){
            isSkipMapLocSelectOnChangeCamera = false
            return
        }
        if(isDisableMapLocSelectOnChangeCamera){
            return
        }
        
        self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
            
        self.isSelectingLocation = true

        getAddressFrmLocation.setLocation(latitude: getCenterLocation().coordinate.latitude, longitude: getCenterLocation().coordinate.longitude)
        getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: false)
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.locLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
    }
    
    func getCenterLocation() -> CLLocation{
        return CLLocation(latitude: self.gMapView.camera.target.latitude, longitude: self.gMapView.camera.target.longitude)
    }
    
    func changeMarkerPosition(location:CLLocation, zoomLevel:Float){
        placeMarker.position = location.coordinate
        
        placeMarker.icon = UIImage(named: "ic_destination_place_image")
//        placeMarker.map = self.gMapView
        placeMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        
        self.animateGmapCamera(location: location, zoomLevel: zoomLevel)
        
    }
    
    
    func animateGmapCamera(location:CLLocation, zoomLevel:Float){
        if(self.gMapView == nil){
            return
        }

        var currentZoomLevel:Float = zoomLevel
        
        if(isFirstLocationUpdate == true){
            currentZoomLevel = Utils.defaultZoomLevel
            isFirstLocationUpdate = false
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude, zoom: currentZoomLevel)
        
//        if(isSkipCurrentChange == false){
            self.gMapView.moveCamera(GMSCameraUpdate.setCamera(camera))
//        }else{
//            isSkipCurrentChange = false
//        }
//        self.gMapView.animate(to: camera)
    }

    func addToServer(vAddress:String, vLatitude:String, vLongitude:String, eType:String){
        let parameters = ["type":"UpdateUserFavouriteAddress","iUserId": GeneralFunctions.getMemberd(), "eUserType": Utils.appUserType, "vAddress": vAddress, "vLatitude": vLatitude, "vLongitude": vLongitude, "eType": eType, "iUserFavAddressId": iUserFavAddressId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    _ = SetUserData(uv: self, userProfileJson: dataDict, isStoreUserId: false)

                    self.releaseAllTask()
                    if self.isPickMiss {
                        self.performSegue(withIdentifier: "unwindToSearchPlaceScreen", sender: self)
                        return
                    }
                    if(self.isFromMainScreen == true){
                        
                        self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                        return
                    }
                    if(self.isFromSearchPlaces == true){
                        self.performSegue(withIdentifier: "unwindToSearchPlaceScreen", sender: self)
                    }else if(self.isFromRideDelivery == true){
                        GeneralFunctions.setSelectedLocations(latitude: self.selectedLocation!.coordinate.latitude, longitude: self.selectedLocation!.coordinate.longitude, address: self.selectedAddress, type: self.SCREEN_TYPE)
                        self.close()
                    }else if(self.isFromRecentLocView == false && (self.SCREEN_TYPE == "HOME" || self.SCREEN_TYPE == "WORK")){
                        self.performSegue(withIdentifier: "unwindToViewProfileScreen", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == self.addLocationBtn){
            if(self.selectedLocation == nil || self.isSelectingLocation == true){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
            }else{
                if(self.SCREEN_TYPE == "HOME" || self.SCREEN_TYPE == "WORK"){
                    
                    self.addToServer(vAddress: "\(selectedAddress)", vLatitude: "\(selectedLocation.coordinate.latitude)", vLongitude: "\(selectedLocation.coordinate.longitude)", eType: self.SCREEN_TYPE == "HOME" ? "Home" : "Work")
                    
                    return
                }
                releaseAllTask()
                if(self.isFromMainScreen == true && self.isPickUpMode == false){
                    self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                    return
                }
                if self.SCREEN_TYPE == "STEPPER" {
                    
                    if rentItemPostUV != nil {
                        
                        self.rentItemPostUV.getLocation(adress: self.selectedAddress, lat: "\(selectedLocation.coordinate.latitude)", long: "\(selectedLocation.coordinate.longitude)")
                    }
                    self.close()
                   return
                }

                if(self.isFromSearchPlaces == true){
                    self.performSegue(withIdentifier: "unwindToSearchPlaceScreen", sender: self)
                }else if SCREEN_TYPE == "PublishStartLocation" {
                    if publishRideUV != nil {
                        publishRideUV.startLat = "\(selectedLocation.coordinate.latitude)"
                        publishRideUV.startLong = "\(selectedLocation.coordinate.longitude)"
                        publishRideUV.startAdd = selectedAddress
                        publishRideUV.getStratAddress()
                        self.close()
                    }
                }
                else if SCREEN_TYPE == "PublishEndLocation" {
                    if publishRideUV != nil {
                        publishRideUV.endLat = "\(selectedLocation.coordinate.latitude)"
                        publishRideUV.endLong = "\(selectedLocation.coordinate.longitude)"
                        publishRideUV.endAdd = selectedAddress
                        publishRideUV.getEndAdress()
                        self.close()
                    }
                }else if SCREEN_TYPE == "BookStartLocation" && bookRideUV != nil{
                    bookRideUV.startLat = "\(selectedLocation.coordinate.latitude)"
                    bookRideUV.startLong = "\(selectedLocation.coordinate.longitude)"
                    bookRideUV.startAdd = selectedAddress
                    bookRideUV.getStratAddress()
                    self.close()
                }else if SCREEN_TYPE == "BookEndLocation" && bookRideUV != nil{
                    bookRideUV.endLat = "\(selectedLocation.coordinate.latitude)"
                    bookRideUV.endLong = "\(selectedLocation.coordinate.longitude)"
                    bookRideUV.endAdd = selectedAddress
                    bookRideUV.getEndAdress()
                    self.close()
                }
                else if(self.isFromRideDelivery == true){
                    GeneralFunctions.setSelectedLocations(latitude: self.selectedLocation!.coordinate.latitude, longitude: self.selectedLocation!.coordinate.longitude, address: self.selectedAddress, type: self.SCREEN_TYPE)
                    self.close()
                }else if(self.isFromRecentLocView == false && (self.SCREEN_TYPE == "HOME" || self.SCREEN_TYPE == "WORK")){
                    self.performSegue(withIdentifier: "unwindToViewProfileScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                }
            }
        }
    }
    
}
