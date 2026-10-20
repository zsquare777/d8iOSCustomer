

import UIKit
import CoreLocation
import GoogleMaps
import SysBaseLib

class AddAddressUV: ParentViewUV, MyBtnClickDelegate, OnLocationUpdateDelegate, AddressFoundDelegate, GMSMapViewDelegate, ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var serviceAreaHLbl: MyLabel!
    @IBOutlet weak var serviceAreaVLbl: MyLabel!
    @IBOutlet weak var myLocImgView: UIImageView!
    @IBOutlet weak var serviceAreaVContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceAreaVContainerView: UIView!
    @IBOutlet weak var serviceAddHLbl: MyLabel!
    @IBOutlet weak var buildingTxtField: MyTextField!
    @IBOutlet weak var landMarkTxtField: MyTextField!
    @IBOutlet weak var addressTypeTxtField: MyTextField!
    @IBOutlet weak var addAddressBtn: MyButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var changeLbl: MyLabel!
    @IBOutlet weak var checkImgView: UIImageView!
    @IBOutlet weak var selectLocImgView: UIImageView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    let generalFunc = GeneralFunctions()
    
    var userProfileJson:NSDictionary!
    
    var isDirectOpen = false
    
    var bookingType = ""
    var companyId = ""
    
    var isForGenie = false
    var isFromPickDrop = false
    var isFromHome = false
    var ufxSelectedVehicleTypeId = ""
    var ufxSelectedVehicleTypeName = ""
    var ufxSelectedLatitude = ""
    var ufxSelectedLongitude = ""
    var ufxSelectedAddress = ""
    var ufxSelectedQty = ""
    var gennieTitle = ""
    var ufXProviderFlow = false
    var ufxServiceItemDict:NSDictionary!
    
    let myLocTapGue = UITapGestureRecognizer()
    let serviceAreaTapGue = UITapGestureRecognizer()
    
    var currentSelectedLocation:CLLocation!
    
    var isScreenKilled = false
    var unwindToChoose = false
    var isFromMenu = false
    
    var isFirstLoc = true
    var currentLocation:CLLocation!
    var locationDialog:OpenEnableLocationView!
    var getLocation:DeviceLocation!
    var getAddressFrmLocation:GetAddressFromLocation!
    
    var isSelectingLocation = false
    var isSkipMapLocSelectOnChangeCamera = false
    var isSkipCurrentMoveOnAddress = false
    var isDisableMapLocSelectOnChangeCamera = false
    
    let placeMarker: GMSMarker = GMSMarker()
    
    var selAddress = ""
    
    var isFirstLoad = true
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            if(self.isForGenie && isFirstLoad){
                self.serviceAreaTapped()
                self.isFirstLoad = false
            }
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "AddAddressScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            //
            //        self.myLocTapGue.addTarget(self, action: #selector(self.myLocImgTapped))
            //        self.myLocImgView.isUserInteractionEnabled = true
            //        self.myLocImgView.addGestureRecognizer(myLocTapGue)
            
            self.changeLbl.isUserInteractionEnabled = true
            self.serviceAreaTapGue.addTarget(self, action: #selector(self.serviceAreaTapped))
            self.changeLbl.addGestureRecognizer(self.serviceAreaTapGue)
            
            self.backImgView.image = UIImage(named: "ic_nav_bar_back")!.addImagePadding(x: 20, y: 20)
            if Configurations.isRTLMode() {
                self.backImgView.image = UIImage(named: "ic_nav_bar_back")!.rotate(180).addImagePadding(x: 20, y: 20)
            }
            self.bottomBgView.layer.addShadow(opacity: 0.9, radius: 3, UIColor.lightGray)
            self.bottomBgView.layer.roundCorners(radius: 8)
            
            getLocation = DeviceLocation(uv: self , isContinuous: true)
            getLocation.buildLocManager(locationUpdateDelegate: self)
            
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
            GeneralFunctions.postNotificationSignal(key: EventService.resumeInst_key, obj: self)
            
            if(isScreenKilled == true){
                Utils.close(isAnimated: false, uv: self)
            }
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.backImgView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
            self.backImgView.layer.roundCorners(radius: 25)
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
        }else if(type == 3){
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        }
    }
    

    func onLocationUpdate(location: CLLocation) {
        
        if isFirstLoc == true
        {
            self.currentLocation = location
            checkLocationEnabled()
            if(getAddressFrmLocation == nil){
                getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
                getAddressFrmLocation.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                getAddressFrmLocation.setPickUpMode(isPickUpMode: true)
                getAddressFrmLocation.executeProcess(isOpenLoader: false, isAlertShow:false)
            }
        }
        
        isFirstLoc = false
    }
    
    func setData(){
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Add New Address", key: "LBL_ADD_NEW_ADDRESS_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Add New Address", key: "LBL_ADD_NEW_ADDRESS_TXT")
        self.serviceAreaHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NEW_ADDRESS_TXT").uppercased()
        
        self.mapView.delegate = self
        self.mapView.animate(toZoom: Utils.defaultZoomLevel)
        
        self.changeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE").uppercased()
        self.changeLbl.textColor = SColors.Theme
        
        Utils.createRoundedView(view:self.checkImgView, borderColor: SColors.Theme, borderWidth: 1)
        self.checkImgView.image = self.checkImgView.image?.addImagePadding(x: 25, y: 25)
        GeneralFunctions.setImgTintColor(imgView: self.checkImgView, color: SColors.ThemeTxt)
        self.checkImgView.backgroundColor = SColors.Theme
        
        
        self.serviceAreaVLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select your area", key: "LBL_SELECT_YOUR_AREA")
        
        self.serviceAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Service address", key: "LBL_SERVICE_ADDRESS_HINT_INFO")
        self.buildingTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Building/House/Flat No.", key: "LBL_JOB_LOCATION_HINT_INFO"))
        self.landMarkTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Landmark(e.g hospital,park etc.)", key: "LBL_LANDMARK_HINT_INFO"))
        self.addressTypeTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Nickname(optional-home,office etc.)", key: "LBL_ADDRESSTYPE_HINT_INFO"))
        
        self.addAddressBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Save", key: "LBL_SAVE_ADDRESS_TXT"))
        self.addAddressBtn.clickDelegate = self
        
        if(self.isForGenie == true){
            self.addressTypeTxtField.isHidden = true
            self.landMarkTxtField.isHidden = true
            self.buildingTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_STORE_NAME"))
            self.serviceAreaHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_STORE_LOCATION").uppercased()
            
            if(self.isFromPickDrop == true){
                self.landMarkTxtField.isHidden = false
                self.serviceAreaHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_PICK_UP_ADDRESS").uppercased()
                self.stackViewHeight.constant = self.stackViewHeight.constant - 50
                self.buildingTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_JOB_LOCATION_HINT_INFO"))
                self.landMarkTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_PERSON_NAME"))
                
            }else{
                self.stackViewHeight.constant = self.stackViewHeight.constant - 100
            }
        }
        
        
        
        if(self.ufxSelectedLatitude != "" && self.ufxSelectedLongitude != ""){
            self.currentSelectedLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.ufxSelectedLatitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.ufxSelectedLongitude))
            
            var addressHeight = self.ufxSelectedAddress.height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().light, size: 16)!)
            if(addressHeight < 50){
                addressHeight = 50
            }
            if(addressHeight > 150){
                addressHeight = 150
            }
            
            serviceAreaVContainerViewHeight.constant = addressHeight
            self.serviceAreaVLbl.text = self.ufxSelectedAddress
            self.selAddress = self.ufxSelectedAddress
        }
        
        getAddressFrmLocation = GetAddressFromLocation(uv: self, addressFoundDelegate: self)
        if(self.currentSelectedLocation == nil){
            self.getLocation = DeviceLocation(uv: self, isContinuous: true)
            self.getLocation.buildLocManager(locationUpdateDelegate: self)
            
            if(GeneralFunctions.hasLocationEnabled() == false){
                
                isDisableMapLocSelectOnChangeCamera = true
                self.selectLocImgView.isHidden = true
            }
            
        }else{
            isSkipCurrentMoveOnAddress = true
           
            getAddressFrmLocation.setLocation(latitude: self.currentSelectedLocation!.coordinate.latitude, longitude: self.currentSelectedLocation!.coordinate.longitude)
            getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: true)
            
            isSkipMapLocSelectOnChangeCamera = true
            self.animateGmapCamera(location: self.currentSelectedLocation!, zoomLevel: Utils.defaultZoomLevel)
            
        }
        
        self.backImgView.handleClick { (instanse) in
            self.close()
        }
    }
    
    func onAddressFound(address: String, location:CLLocation, isPickUpMode:Bool, dataResult:String) {
        if(address == ""){
            return
        }
      
        self.selectLocImgView.isHidden = false
        
        self.serviceAreaVLbl.text = address
        self.selAddress = address
        self.currentSelectedLocation = location
       
        self.isSelectingLocation = false
        
        if(isSkipCurrentMoveOnAddress == true){
            isSkipCurrentMoveOnAddress = false
            return
        }
        
        if(getCenterLocation().coordinate.latitude != location.coordinate.latitude || getCenterLocation().coordinate.longitude != location.coordinate.longitude){
            isSkipMapLocSelectOnChangeCamera = true
        }
        
        changeMarkerPosition(location: location, zoomLevel: self.mapView.camera.zoom)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      
        if(isSkipMapLocSelectOnChangeCamera == true){
            isSkipMapLocSelectOnChangeCamera = false
            if(self.selAddress != ""){
                self.serviceAreaVLbl.text = self.selAddress
            }
            return
        }
        if(isDisableMapLocSelectOnChangeCamera){
            return
        }
        self.isSelectingLocation = true
        
        self.serviceAreaVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
        getAddressFrmLocation.setLocation(latitude: getCenterLocation().coordinate.latitude, longitude: getCenterLocation().coordinate.longitude)
        getAddressFrmLocation.executeProcess(isOpenLoader: true, isAlertShow: false)
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.serviceAreaVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECTING_LOCATION_TXT")
    }
    
    func getCenterLocation() -> CLLocation{
        return CLLocation(latitude: self.mapView.camera.target.latitude, longitude: self.mapView.camera.target.longitude)
    }
    
    func changeMarkerPosition(location:CLLocation, zoomLevel:Float){
        placeMarker.position = location.coordinate
        
        placeMarker.icon = UIImage(named: "ic_map_pin")
        //placeMarker.map = self.mapView
        placeMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        
        self.animateGmapCamera(location: location, zoomLevel: Utils.defaultZoomLevel)
        
    }
    
    func animateGmapCamera(location:CLLocation, zoomLevel:Float){
        if(self.mapView == nil){
            return
        }
        
        var currentZoomLevel:Float = zoomLevel
        
        if(isFirstLoc == true){
            currentZoomLevel = Utils.defaultZoomLevel
            isFirstLoc = false
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude, zoom: currentZoomLevel)
        
        self.mapView.moveCamera(GMSCameraUpdate.setCamera(camera))
    
    }
    
    
    @objc func serviceAreaTapped(){
        
        
        let launchPlaceFinder = LaunchPlaceFinder(viewControllerUV: self)
        launchPlaceFinder.currInst = launchPlaceFinder
        launchPlaceFinder.fromAddAddress = true
        launchPlaceFinder.isForGenie = self.isForGenie
        launchPlaceFinder.isFromHome = self.isFromHome
        if(self.isFirstLoad && self.isForGenie){
            launchPlaceFinder.isFromGenieMainScreen = true
        }
        
        launchPlaceFinder.initializeFinder { (address, latitude, longitude) in
            
            //            self.selectedLatitude = "\(latitude)"
            //            self.selectedLongitude = "\(longitude)"
            //            self.enterLocLbl.text = address + " ⌄"
            
            self.currentSelectedLocation = CLLocation(latitude: latitude, longitude: longitude)
            //
            //                self.selectedLatitude = "\(latitude)"
            //                self.selectedLongitude = "\(longitude)"
            //                self.enterLocLbl.text = address + " ⌄"
            
            var addressHeight = address.height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().light, size: 16)!)
            if(addressHeight < 50){
                addressHeight = 50
            }
            if(addressHeight > 150){
                addressHeight = 150
            }
            self.serviceAreaVContainerViewHeight.constant = addressHeight
            
            self.serviceAreaVLbl.text = address
            self.selAddress = address
            self.selectLocImgView.isHidden = false
            
            self.isDisableMapLocSelectOnChangeCamera = false
            self.isSelectingLocation = false
            self.isSkipMapLocSelectOnChangeCamera = true
            
            self.changeMarkerPosition(location: self.currentSelectedLocation, zoomLevel: Utils.defaultZoomLevel)
        }
    }
    
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.addAddressBtn){
            checkData()
        }
    }
    
    func checkData(){
        if !isFromHome {
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        if(self.currentSelectedLocation == nil){
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
            return
        }
        
        let buildingEntered = Utils.checkText(textField: self.buildingTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.buildingTxtField.getTextField()!, error: required_str)
        let landMarkEntered = Utils.checkText(textField: self.landMarkTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.landMarkTxtField.getTextField()!, error: required_str)
        //        let addTypeEntered = Utils.checkText(textField: self.addressTypeTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.addressTypeTxtField.getTextField()!, error: required_str)
            if self.landMarkTxtField.isHidden == true {
        if(self.isForGenie && buildingEntered == true ){
            self.releaseAllTask()
            self.performSegue(withIdentifier: "unwindToGenieFindStore", sender: self)
            return
        }
        }else{
            if (self.isForGenie && buildingEntered == true && landMarkEntered == true) {
                self.releaseAllTask()
                self.performSegue(withIdentifier: "unwindToGenieFindStore", sender: self)
                return
            }
            }
        
        if (buildingEntered == false || landMarkEntered == false) {
            //            || addTypeEntered == false
            return;
        }
        
   
       self.addAddress()
      
        }else{
            let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            
            if(self.currentSelectedLocation == nil){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
                return
            }
            
            let buildingEntered = Utils.checkText(textField: self.buildingTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.buildingTxtField.getTextField()!, error: required_str)
            let landMarkEntered = Utils.checkText(textField: self.landMarkTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.landMarkTxtField.getTextField()!, error: required_str)
            //        let addTypeEntered = Utils.checkText(textField: self.addressTypeTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.addressTypeTxtField.getTextField()!, error: required_str)
        
            if(self.isForGenie && buildingEntered == true){
                self.releaseAllTask()
                //self.performSegue(withIdentifier: "unwindToGenieFindStore", sender: self)
                let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
                genieFindStoreUV.isFromPickDrop = self.isFromPickDrop
                genieFindStoreUV.isFromHome = self.isFromHome
                genieFindStoreUV.storeLat = "\(self.currentSelectedLocation.coordinate.latitude)"
                genieFindStoreUV.storeLong = "\(self.currentSelectedLocation.coordinate.longitude)"
                genieFindStoreUV.contactName = self.landMarkTxtField.text
                genieFindStoreUV.storeName = self.buildingTxtField.text
                genieFindStoreUV.storeAddress = self.serviceAreaVLbl.text!
                genieFindStoreUV.titleFromHome = self.gennieTitle
                self.push(uv: genieFindStoreUV)
                return
            }
            
            if (buildingEntered == false || landMarkEntered == false) {
                //            || addTypeEntered == false
                return;
            }
            
       
           self.addAddress()
        }
    }
    
    
    func addAddress(){
        
        let parameters = ["type":"UpdateUserAddressDetails","iUserId": GeneralFunctions.getMemberd(), "vBuildingNo": Utils.getText(textField: self.buildingTxtField.getTextField()!), "UserType": Utils.appUserType, "vLandmark": Utils.getText(textField: self.landMarkTxtField.getTextField()!), "vServiceAddress": self.serviceAreaVLbl.text!, "vAddressType": Utils.getText(textField: self.addressTypeTxtField.getTextField()!), "vLatitude": "\(self.currentSelectedLocation.coordinate.latitude)", "vLongitude": "\(self.currentSelectedLocation.coordinate.longitude)", "iSelectVehicalId": ufxSelectedVehicleTypeId, "iCompanyId": self.companyId, "eCatType":self.isForGenie ? "Genie" : ""]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.isScreenKilled = true
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    
                    let address = (parameters as NSDictionary).get("vAddressType") + "\n" + (parameters as NSDictionary).get("vBuildingNo") + ", " + (parameters as NSDictionary).get("vLandmark") + "\n" + (parameters as NSDictionary).get("vServiceAddress")
                    
                    if(dataDict.get("IsProceed").uppercased() == "NO"){
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Service is not available in your area.", key: "LBL_JOB_LOCATION_NOT_ALLOWED"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedId) in
                            
                            self.releaseAllTask()
                            self.close()
                        })
                        return
                    }
                    
                    if(self.ufXProviderFlow == true){
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Address added successfully.", key: "LBL_ADDRSS_ADD_SUCCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedId) in
                            self.releaseAllTask()
                            if self.unwindToChoose == true{
                                
                                self.performSegue(withIdentifier: "unwindToChooseAddress", sender: self)
                                return
                            }else
                            {
            
                                self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
                                return
                            }
                    
                        })
                        return
                    }
                    
                    if self.companyId == ""
                    {
                        self.releaseAllTask()
                        if(self.isDirectOpen == true){
                            if(self.bookingType == "LATER"){
                                let chooseServiceDateUv = GeneralFunctions.instantiateViewController(pageName: "ChooseServiceDateUV") as! ChooseServiceDateUV
                                chooseServiceDateUv.ufxSelectedVehicleTypeId = self.ufxSelectedVehicleTypeId
                                chooseServiceDateUv.ufxSelectedVehicleTypeName = self.ufxSelectedVehicleTypeName
                                chooseServiceDateUv.ufxSelectedQty = self.ufxSelectedQty
                                chooseServiceDateUv.ufxAddressId = dataDict.get("AddressId")
                                chooseServiceDateUv.ufxSelectedLatitude = "\(self.currentSelectedLocation.coordinate.latitude)"
                                chooseServiceDateUv.ufxSelectedLongitude = "\(self.currentSelectedLocation.coordinate.longitude)"
                                chooseServiceDateUv.isDirectOpenFromUFXAddress = self.isDirectOpen
                                chooseServiceDateUv.serviceAreaAddress = address
                                chooseServiceDateUv.ufxServiceItemDict = self.ufxServiceItemDict
                                self.push(uv: chooseServiceDateUv)
                            }else{
                                let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
                                mainScreenUv.ufxSelectedVehicleTypeId = self.ufxSelectedVehicleTypeId
                                mainScreenUv.ufxSelectedVehicleTypeName = self.ufxSelectedVehicleTypeName
                                mainScreenUv.ufxSelectedLatitude = self.ufxSelectedLatitude
                                mainScreenUv.ufxSelectedLongitude = self.ufxSelectedLongitude
                                mainScreenUv.ufxSelectedQty = self.ufxSelectedQty
                                mainScreenUv.isDirectOpenFromUFXAddress = self.isDirectOpen
                                mainScreenUv.ufxAddressId = dataDict.get("AddressId")
                                mainScreenUv.ufxSelectedLatitude = "\(self.currentSelectedLocation.coordinate.latitude)"
                                mainScreenUv.ufxSelectedLongitude = "\(self.currentSelectedLocation.coordinate.longitude)"
                                mainScreenUv.ufxServiceItemDict = self.ufxServiceItemDict
                                self.push(uv: mainScreenUv)
                            }
                            
                        }else{
                            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Address added successfully.", key: "LBL_ADDRSS_ADD_SUCCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedId) in
                                self.performSegue(withIdentifier: "unwindToChooseAddress", sender: self)
                            })
                        }
                        
                    }else{
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Address added successfully.", key: "LBL_ADDRSS_ADD_SUCCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedId) in
                            
                            self.releaseAllTask()
                            if self.unwindToChoose == true{
                                
                                self.performSegue(withIdentifier: "unwindToChooseAddress", sender: self)
                                
                            }else
                            {
                                self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
                            }
                            
                        })
                    }
                    
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func checkLocationEnabled(){
        if(locationDialog != nil){
            locationDialog.closeView()
            locationDialog = nil
        }
        
        if((GeneralFunctions.hasLocationEnabled() == false && self.currentLocation == nil) || InternetConnection.isConnectedToNetwork() == false)
        {
            
            locationDialog = OpenEnableLocationView(uv: self, containerView: self.contentView, menuImgView: UIImageView())
            locationDialog.currentInst = locationDialog
            locationDialog.setViewHandler(handler: { (latitude, longitude, address, isMenuOpen) in
                //                self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
                //                self.setTripLocation(selectedAddress: address, selectedLocation: CLLocation(latitude: latitude, longitude: longitude))
                
                self.locationDialog.closeView()
                self.locationDialog = nil
                self.onLocationUpdate(location: CLLocation(latitude: latitude, longitude: longitude))
            })
            
            locationDialog.show()
            
            return
        }
    }
    
    func releaseAllTask(){
        if(mapView != nil){
            mapView!.removeFromSuperview()
            mapView!.clear()
            mapView!.delegate = nil
            mapView = nil
        }
        
        if(getAddressFrmLocation != nil){
            getAddressFrmLocation!.addressFoundDelegate = nil
            getAddressFrmLocation = nil
        }
        
      
        
        if(self.getLocation != nil){
            self.getLocation!.locationUpdateDelegate = nil
            self.getLocation!.releaseLocationTask()
            self.getLocation = nil
        }
        
        self.removeAllViewsRef(view: self.view)
     
    }
    
    func removeAllViewsRef(view:UIView){
        let tempSubViews = view.subviews
        for i in 0..<tempSubViews.count {
            let tempView = tempSubViews[i]
            
            if let recognizers = tempView.gestureRecognizers {
                for recognizer in recognizers {
                    tempView.removeGestureRecognizer(recognizer)
                }
            }
            
            if(tempView as? MyButton != nil) {
                (tempView as! MyButton).clickDelegate = nil
            }
            
            if (tempView as? MyLabel != nil) {
                (tempView as! MyLabel).clickDelegate = nil
            }
            
            if (tempView as? MyTextField != nil) {
                (tempView as! MyTextField).myTxtFieldDelegate = nil
            }
            
            if(tempView as? UITableView != nil) {
                (tempView as! UITableView).delegate = nil
                (tempView as! UITableView).dataSource = nil
            }
            
            if(tempView as? UICollectionView != nil) {
                (tempView as! UICollectionView).delegate = nil
                (tempView as! UICollectionView).dataSource = nil
            }
            
            if(tempView.subviews.count > 0) {
                self.removeAllViewsRef(view: tempView)
                continue
            }
            
            tempView.removeFromSuperview()
         
        }
    }
    
    
}
