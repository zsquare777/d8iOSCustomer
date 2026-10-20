//
//  TrackingLiveUV.swift
//  UserApp
//
//  Created by Apple on 28/11/22.
//

import UIKit
import GoogleMaps
import SysBaseLib
import GoogleMobileAds


class TrackingLiveUV: ParentViewUV, ParentViewUVDelegate, OnLocationUpdateDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var googleMapContainerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var myLocImgView: UIImageView!
    @IBOutlet weak var trackingMarkerImgView: UIImageView!
    @IBOutlet weak var bottomTitleLbl: MyLabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var statusLbl: MyLabel!
    @IBOutlet weak var driverCallLbl: MyLabel!
    @IBOutlet weak var orgCallLbl: MyLabel!
    @IBOutlet weak var trackingStatusHLbl: MyLabel!
    
    var getLocation:DeviceLocation!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var dataDic = NSDictionary()
    
    var gMapView:GMSMapView!
    
    var currentLocation:CLLocation!
    
    var assignedDriverLocation:CLLocation!
    var assignedDriverMarker:GMSMarker!
    var updateFreqDriverLocTask:TaskScheduler!
    var assignedDriverRotatedLocation:CLLocation!
    var assignedDriverId = ""
    var assignedDriverData = [String:String]()
    
    var userProfileJson:NSDictionary!
    
    var passengerMarkerForTrack:GMSMarker!
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if type == 0 {
            
            cntView = self.generalFunc.loadView(nibName: "TrackingLiveScreenDesign", uv: self, contentView: contentView)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
           
            self.contentView.addSubview(cntView)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.setData()
                     
        }else if type == 1 {
            self.configRTL()
 
            self.addBack()
         
        }else if type == 2 {
            
            let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 0.0)
            self.gMapView = GMSMapView.map(withFrame: self.googleMapContainerView.frame, camera: camera)
        
            self.googleMapContainerView.addSubview(self.gMapView)
            self.gMapView.isMyLocationEnabled = false
            
//            self.getLocation = DeviceLocation(uv: self, isContinuous: true)
//            self.getLocation.buildLocManager(locationUpdateDelegate: self)
            
            EventService.getInstance().buildConnection()
            
            if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
                self.addTrackingUserMarker()
            }else{
                self.addPassengerMarker()
            }
            
            
        }else if type == 3 {
            
            
        }
    }
    
    override func close(){
        
        if(self.gMapView != nil){
            //self.getLocation.locationUpdateDelegate = nil
           // self.getLocation = nil
            self.gMapView.clear()
            self.gMapView.delegate = nil
            self.gMapView = nil
        }
        
        super.close()
        
    }
    
    func onLocationUpdate(location: CLLocation) {
        
//        self.currentLocation = location
//
//        self.myLocImgTapped()
       
    }
    
    func setData(){
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_LIVE_TRACKING_TXT")
        
        self.bottomView.layer.shadowOpacity = 1.0
        self.bottomView.layer.shadowRadius = 2.0
        self.bottomView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        Utils.createRoundedView(view: self.bottomView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        self.bottomView.layer.masksToBounds = false
        
        self.myLocImgView.image = UIImage(named:"ic_my_location_view")!.addImagePadding(x: 25, y: 25)
        self.myLocImgView.isHidden = false
        self.myLocImgView.shadowColor = UIColor.lightGray
        self.myLocImgView.shadowOffset = CGSize(width: 0, height: 0.0)
        self.myLocImgView.shadowRadius = 2.0
        self.myLocImgView.shadowOpacity = 1.0
        self.myLocImgView.masksToBounds = false
        self.myLocImgView.shadowPath = UIBezierPath(roundedRect:self.myLocImgView.bounds, cornerRadius:self.myLocImgView.layer.cornerRadius).cgPath
        
        let userLocTapGue = UITapGestureRecognizer()
        userLocTapGue.addTarget(self, action: #selector(self.myLocImgTapped))
        myLocImgView.isUserInteractionEnabled = true
        myLocImgView.addGestureRecognizer(userLocTapGue)
        
        GeneralFunctions.setImgTintColor(imgView: self.trackingMarkerImgView, color: SColors.Theme)
        
        self.bottomTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_LIVE_TRACKING_TXT")
        
        self.userNameLbl.text = dataDic.get("userName")
    
        self.profileImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: dataDic.get("vImage"), width: Utils.getValueInPixel(value: 80), height: Utils.getValueInPixel(value: 80))), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        self.orgCallLbl.backgroundColor = SColors.Theme
        self.driverCallLbl.backgroundColor = SColors.Theme
        self.orgCallLbl.textColor = SColors.ThemeTxt
        self.driverCallLbl.textColor = SColors.ThemeTxt
        
        self.orgCallLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_CALL_ORG_TXT")
        self.driverCallLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_CALL_DRIVER_TXT")
        GeneralFunctions.setImgTintColor(imgView: self.myLocImgView, color: SColors.Theme)
        
        self.orgCallLbl.addImage(originalText: "  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_CALL_ORG_TXT"))" , image: UIImage(named: "ic_eme_call")!.resize(toWidth: 13)!.resize(toHeight: 13)!, color: SColors.ThemeTxt, position:  Configurations.isRTLMode() ? .right : .left,0, 0, "")
        self.driverCallLbl.addImage(originalText: "  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_CALL_DRIVER_TXT"))" , image: UIImage(named: "ic_eme_call")!.resize(toWidth: 13)!.resize(toHeight: 13)!, color: SColors.ThemeTxt, position:  Configurations.isRTLMode() ? .right : .left,0, 0, "")
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            
            self.orgCallLbl.addImage(originalText: "  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_TXT"))" , image: UIImage(named: "ic_eme_call")!.resize(toWidth: 13)!.resize(toHeight: 13)!, color: SColors.ThemeTxt, position:  Configurations.isRTLMode() ? .right : .left,0, 0, "")
            self.driverCallLbl.isHidden = true
            
            self.trackingStatusHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_TRACKING_STATUS_TXT") + ":"
            
            if(dataDic.get("LocationTrackingStatus").uppercased() == "YES"){
                self.statusLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ACTIVE_STATUS")
                self.statusLbl.textColor = SColors.green
                
            }else{
                self.statusLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INACTIVE_STATUS")
                self.statusLbl.textColor = UIColor(hex: 0xb90d1b)
                
            }
            
            self.orgCallLbl.handleClick { instance in
                UIApplication.shared.openURL(NSURL(string: ("telprompt:\(self.dataDic.get("userPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
            }
        }else{
            self.statusLbl.text = dataDic.get("TripStatusDisplay")
            
            self.orgCallLbl.handleClick { instance in
                UIApplication.shared.openURL(NSURL(string: ("telprompt:\(self.dataDic.get("orgPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
            }
            
            self.driverCallLbl.handleClick { instance in
                UIApplication.shared.openURL(NSURL(string: ("telprompt:\(self.dataDic.get("driverPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
            }
        }
        
    }
    
    @objc func myLocImgTapped(){
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            var currentZoomLevel:Float = self.gMapView.camera.zoom
            
            if(currentZoomLevel < Utils.defaultZoomLevel){
                currentZoomLevel = Utils.defaultZoomLevel
            }
            

            if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
                let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation.coordinate.latitude,
                                                      longitude: self.currentLocation.coordinate.longitude, zoom: Utils.defaultZoomLevel)
                
                self.gMapView.animate(to: camera)
                
            }
        }else{
            self.boundMapFromSourceToDestForTracking()
        }
        
    }
    
    func boundMapFromSourceToDestForTracking(){
//        Utils.printLog(msgData: "GoogleMapMaxZoom:\(self.gMapView.maxZoom)")
//        let maxZoomLevel = self.gMapView.maxZoom
        let maxZoomLevel:Float = 17
        if(self.gMapView != nil && self.gMapView.minZoom < maxZoomLevel - 3.5){
            self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: maxZoomLevel - 3.5)
        }
        
        var bounds = GMSCoordinateBounds()
        
        let orgLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("orgLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("orgLongitude")))
        bounds =  bounds.includingCoordinate(orgLocation.coordinate)
        
        if(self.assignedDriverLocation != nil){
            bounds =  bounds.includingCoordinate(self.assignedDriverLocation.coordinate)
        }
        
        
        let usersLocationArray = self.dataDic.arrOf("userList") as! [NSDictionary]
        for i in 0..<usersLocationArray.count{
            
            let uLoc = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: usersLocationArray[i].get("vLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: usersLocationArray[i].get("vLongitude")))
           
            bounds =  bounds.includingCoordinate(uLoc.coordinate)
           
        }
        
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            if(self.gMapView != nil){
                if(self.gMapView.minZoom < maxZoomLevel){
                    self.gMapView.setMinZoom(self.gMapView.minZoom, maxZoom: maxZoomLevel)
                }
                
            }
            
        }
        
        if(self.gMapView != nil){
            self.gMapView.animate(with: update)
        }
        
        
        CATransaction.commit()
    }
    
    func addPassengerMarker(){
           
            let oLoc = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("orgLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("orgLongitude")))
            let passengerMarker = GMSMarker()
            passengerMarker.position = oLoc.coordinate
            
            passengerMarker.icon = UIImage(named: "ic_Tracking_Company")
            passengerMarker.map = self.gMapView
            passengerMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            passengerMarker.groundAnchor = CGPoint(x: 0.5, y: 1.0)
            
            
            let usersLocationArray = self.dataDic.arrOf("userList") as! [NSDictionary]
            for i in 0..<usersLocationArray.count{
                
                var imageName = "ic_rentalmap_marker"
                if(self.dataDic.get("iTrackServiceUserId") == usersLocationArray[i].get("iTrackServiceUserId")){
                    imageName = "ic_tracking_home"
                    
                }
                let uLoc = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: usersLocationArray[i].get("vLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: usersLocationArray[i].get("vLongitude")))
               
                let marker = GMSMarker()
                marker.icon = UIImage(named: imageName)
                marker.position = uLoc.coordinate
                marker.isTappable = true
                marker.title = usersLocationArray[i].get("userName")
                marker.snippet = usersLocationArray[i].get("vAddress")
                marker.map = self.gMapView
                marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                marker.groundAnchor = CGPoint(x: 0.5, y: 1.0)
              
            }
            
            self.assignedDriverId = self.dataDic.get("iDriverId")
            subscribeToDriverLocChannel()
            
            self.boundMapFromSourceToDestForTracking()
            
            self.updateDriverLocation(iDriverId: self.dataDic.get("iDriverId"), latitude: self.dataDic.get("driverLatitude"), longitude: self.dataDic.get("driverLongitude"), dataDict: self.dataDic)
         
        }
    
    
    func addTrackingUserMarker(){
       
//        let puppyGif = UIImage.gifImageWithName("ma")
//        let imageView = UIImageView(image: puppyGif)
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                                 
        let oLoc = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("userLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: self.dataDic.get("userLongitude")))
        passengerMarkerForTrack = GMSMarker()
        passengerMarkerForTrack.position = oLoc.coordinate

        passengerMarkerForTrack.icon = UIImage(named: "ic_user_loc")
        passengerMarkerForTrack.map = self.gMapView
        //passengerMarkerForTrack.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        //passengerMarkerForTrack.groundAnchor = CGPoint(x: 0.5, y: 1.0)


        self.assignedDriverId = self.dataDic.get("iTrackServiceUserId")
        
        subscribeToTrackingLocChannel()
        
        var currentZoomLevel:Float = self.gMapView.camera.zoom
        
        if(currentZoomLevel < Utils.defaultZoomLevel){
            currentZoomLevel = Utils.defaultZoomLevel
        }
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            
            let camera = GMSCameraPosition.camera(withLatitude: oLoc.coordinate.latitude,
                                                  longitude: oLoc.coordinate.longitude, zoom: Utils.defaultZoomLevel)
            
            self.gMapView.animate(to: camera)
            
            
        }
        
        self.updateDriverLocation(iDriverId: self.dataDic.get("iTrackServiceUserId"), latitude: self.dataDic.get("userLatitude"), longitude: self.dataDic.get("userLongitude"), dataDict: self.dataDic)
     
    }
    
    func updateDriverLocation(iDriverId:String, latitude:String, longitude:String, dataDict:NSDictionary){
       
        self.currentLocation = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: latitude), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: longitude))
        updateAssignedDriverMarker(driverLocation: self.currentLocation, dataDict: dataDict)
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
//            if(dataDict.get("onlineStatus").uppercased() == "YES"){
            if(dataDict.get("LocationTrackingStatus").uppercased() == "YES"){
                self.statusLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ACTIVE_STATUS")
                self.statusLbl.textColor = SColors.green
                
            }else{
                self.statusLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INACTIVE_STATUS")
                self.statusLbl.textColor = UIColor(hex: 0xb90d1b)
                
            }
        }
        
    
    }
    
    func updateAssignedDriverMarker(driverLocation:CLLocation, dataDict:NSDictionary?){

        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES" && passengerMarkerForTrack != nil){
            
            self.assignedDriverLocation = driverLocation
            
            passengerMarkerForTrack.position = driverLocation.coordinate

            passengerMarkerForTrack.icon = UIImage(named: "ic_user_loc")
            passengerMarkerForTrack.map = self.gMapView
            //passengerMarkerForTrack.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            //passengerMarkerForTrack.groundAnchor = CGPoint(x: 0.5, y: 1.0)
           
            let camera = GMSCameraPosition.camera(withLatitude: driverLocation.coordinate.latitude,
                                                  longitude: driverLocation.coordinate.longitude, zoom: Utils.defaultZoomLevel)
            
            if(self.gMapView != nil){
                self.gMapView.animate(to: camera)
            }
            
            
        }else{
            self.assignedDriverLocation = driverLocation

            if(self.assignedDriverMarker == nil){
                let driverMarker = GMSMarker()
                self.assignedDriverMarker = driverMarker
            }


            var rotationAngle:Double = -1
            if(assignedDriverRotatedLocation != nil){
                rotationAngle = assignedDriverRotatedLocation.bearingToLocationDegrees(destinationLocation: driverLocation, currentRotation: assignedDriverMarker.rotation)
                if(rotationAngle != -1){
                    assignedDriverRotatedLocation = driverLocation
                }
            }else{
                assignedDriverRotatedLocation = driverLocation
            }

            if(dataDict != nil && self.assignedDriverMarker != nil){

                var tempData = [String:String]()
                tempData["vLatitude"] = "\(driverLocation.coordinate.latitude)"
                tempData["vLongitude"] = "\(driverLocation.coordinate.longitude)"
                tempData["iDriverId"] = "\(self.assignedDriverId)"
                tempData["RotationAngle"] = "\(rotationAngle)"
                tempData["LocTime"] = "\(dataDict!.get("LocTime"))"
                tempData["isAnimCompleted"] = "No"


                if(self.assignedDriverMarker.userData == nil){
                    self.assignedDriverMarker.userData = tempData


                    Utils.updateMarkerOnTrip(marker: assignedDriverMarker, googleMap: self.gMapView, coordinates: driverLocation.coordinate, rotationAngle: rotationAngle, duration: MainScreenUV.defaultMarkerAnimDuration, iDriverId: self.assignedDriverId, LocTime: "", isMoveMapToLocation: MainScreenUV.isDriverLocTrack)
                }else{
                    let tmpUserData = self.assignedDriverMarker.userData as! NSDictionary
                    let locTime = Int64(tmpUserData.get("LocTime"))
                    let newLocTime = Int64(dataDict!.get("LocTime"))

                    if(locTime == nil || newLocTime == nil){
                        Utils.updateMarkerOnTrip(marker: assignedDriverMarker, googleMap: self.gMapView, coordinates: driverLocation.coordinate, rotationAngle: rotationAngle, duration: MainScreenUV.defaultMarkerAnimDuration, iDriverId: self.assignedDriverId, LocTime: "", isMoveMapToLocation: MainScreenUV.isDriverLocTrack)
                    }else if((newLocTime! - locTime!) > Int64(0)){
                        if(Utils.driverMarkerAnimFinished == true && Utils.driverMarkersPositionList.count == 0){

                            Utils.updateMarkerOnTrip(marker: assignedDriverMarker, googleMap: self.gMapView, coordinates: driverLocation.coordinate, rotationAngle: rotationAngle, duration: MainScreenUV.defaultMarkerAnimDuration, iDriverId: self.assignedDriverId, LocTime: "", isMoveMapToLocation: MainScreenUV.isDriverLocTrack)
                        }else{
                            Utils.driverMarkersPositionList.append(tempData as NSDictionary)
                        }
                    }
                }
            }else{
                Utils.updateMarkerOnTrip(marker: assignedDriverMarker, googleMap: self.gMapView, coordinates: driverLocation.coordinate, rotationAngle: rotationAngle, duration: MainScreenUV.defaultMarkerAnimDuration, iDriverId: self.assignedDriverId, LocTime: "", isMoveMapToLocation: MainScreenUV.isDriverLocTrack)
            }



            assignedDriverMarker.title = self.assignedDriverId
            //        assignedDriverMarker.icon = UIImage(named: "ic_driver_car_pin")

            let eIconType = assignedDriverData["eIconType"]

            let iconId = "ic_bus"

           
            assignedDriverMarker.icon = UIImage(named: iconId)
            assignedDriverMarker.map = self.gMapView
            assignedDriverMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            assignedDriverMarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            assignedDriverMarker.isFlat = true


    //        if(isMapMoveToDriverLoc == false){
    //
    //            if(self.gMapView != nil){
    //                let camera = GMSCameraPosition.camera(withLatitude: self.assignedDriverLocation!.coordinate.latitude,
    //                                                      longitude: self.assignedDriverLocation!.coordinate.longitude, zoom: self.gMapView.camera.zoom)
    //                self.gMapView.moveCamera(GMSCameraUpdate.setCamera(camera))
    //            }
    //
    //            isMapMoveToDriverLoc = true
    //        }
        }
        
        

    }
    
    func subscribeToDriverLocChannel(){
        var channels =  [String]()
        channels += ["\(Utils.PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_DRIVER)\(self.assignedDriverId)"]
        
        for i in 0..<channels.count{
            
            AppService.getInstance().executeService(data: EventInformationBuilder().setChanelList(channel_list: channels[i]).build(), event: .SUBSCRIBE)
        }

    }
    
    func subscribeToTrackingLocChannel(){
        var channels =  [String]()
        channels += ["\(Utils.PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_TRACKING)\(self.assignedDriverId)"]
        
        for i in 0..<channels.count{
            
            AppService.getInstance().executeService(data: EventInformationBuilder().setChanelList(channel_list: channels[i]).build(), event: .SUBSCRIBE)
        }

    }
    
    
}
