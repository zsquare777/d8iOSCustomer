//
//  SearchRideDetialsUV.swift
//  UserApp
//
//  Created by # Admin on 12/12/22.
//

import UIKit
import SysBaseLib
import GoogleMaps
class UserRequestUV:  ParentViewUV,ParentViewUVDelegate,MyBtnClickDelegate,OnDirectionUpdateDelegate {
    

    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var loaderView:UIView!
    var dataDic:NSDictionary!
    var editData:NSDictionary!
    var rideList = [NSDictionary]()
    
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userContactLbl: MyLabel!
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var maxPassengerLimitLbl: MyLabel!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var startCity: MyLabel!
    @IBOutlet weak var endCity: MyLabel!
    @IBOutlet weak var startAddress: MyLabel!
    @IBOutlet weak var endAddress: MyLabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var startTimeLbl: MyLabel!
    @IBOutlet weak var endTimeLbl: MyLabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var toFromView: UIView!
    @IBOutlet weak var btnContinue: MyButton!
    @IBOutlet weak var totoalLbl: MyLabel!
    @IBOutlet weak var totalPassengerLbl: MyLabel!
    @IBOutlet weak var totoalPrice: MyLabel!
    @IBOutlet weak var btnDecline: MyButton!
    
    @IBOutlet weak var gMap: GMSMapView!
    var driverMarket : GMSMarker = GMSMarker()
    var userMarker : GMSMarker = GMSMarker()
    var noSeats = ""
    var currentLocation = CLLocation()
    var destLocation = CLLocation()
    var updateDirection:UpdateDirections!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "UserRequestsScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
           
            
        }else if (type == 1){
            self.addBack()
            self.configRTL()
            self.setData()
            self.setLocationView()
        }else if (type == 2){
            
            
        }
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
    func setLocationView()  {
        startView.layer.masksToBounds = true
        startView.layer.cornerRadius = self.startView.frame.width / 2
        endView.layer.masksToBounds = true
        endView.layer.cornerRadius = self.endView.frame.width / 2
        self.startTimeLbl.text = self.editData.get("StartTime")
        self.startTimeLbl.textColor = SColors.Theme
        self.toFromView.backgroundColor = SColors.Theme
        self.startCity.text = self.editData.get("tStartCity")
        self.startAddress.text = self.editData.get("tStartLocation")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
        self.toFromView.createDashedLine(color: SColors.Theme, lineWidth: 2, true)
        })
      
            self.endTimeLbl.text = self.editData.get("EndTime")
            self.endTimeLbl.textColor = SColors.Theme
            self.endCity.text = self.editData.get("tEndCity")
            self.endAddress.text = self.editData.get("tEndLocation")
            self.locationView.isHidden = false
    }
    func setData()  {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Booking Request", key: "LBL_RIDE_SHARE_BOOKING_REQUEST")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Booking Request", key: "LBL_RIDE_SHARE_BOOKING_REQUEST")
        self.shadowOnview(view: bottomView)
        self.topHeaderView.backgroundColor = SColors.Theme
        self.userimageView.sd_setImage(with: URL(string: editData.get("DriverImg")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        Utils.createRoundedView(view:self.userimageView, borderColor: SColors.Theme, borderWidth: 3)
        userNameLbl.text = editData.get("DriverName")
        userNameLbl.textColor = SColors.ThemeTxt
        userContactLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Contact", key: "LBL_RIDE_SHARE_CONTACT_TXT") + " " + editData.get("DriverName")
        userContactLbl.textColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: self.groupImageView, color: UIColor.gray)
        self.groupImageView.isHidden = true
        maxPassengerLimitLbl.textColor = UIColor.gray
        maxPassengerLimitLbl.text = editData.get("iAvailableSeatsText")
        dateLbl.text = editData.get("StartDate")
        dateLbl.textColor =  UIColor.gray
        btnContinue.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Accept", key: "LBL_ACCEPT_TXT") )
        self.btnContinue.clickDelegate = self
        btnDecline.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Decline", key: "LBL_DECLINE_TXT") )
        self.btnDecline.clickDelegate = self
        self.btnDecline.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.totalPassengerLbl.text = self.editData.get("NoOfSeatTxt")
        self.totoalLbl.text = self.generalFunc.getLanguageLabel(origValue: "Total Price", key: "LBL_RIDE_SHARE_TOTAL_PRICE")
        self.totoalPrice.textColor = SColors.Theme
        self.totoalPrice.text = self.editData.get("fPrice")
        self.currentLocation = CLLocation(latitude: Double(self.editData.get("tStartLat"))!, longitude: Double(self.editData.get("tStartLong"))!)
        self.destLocation = CLLocation(latitude: Double(self.editData.get("tEndLat"))!, longitude: Double(self.editData.get("tEndLong"))!)
        self.addUserLocMarker(location:self.currentLocation )
        self.destLocMarker(location: self.destLocation)
        self.boundMapFromSourceToDest()
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnContinue {

            //self.bookingAccept(status: "Approved")
            self.bookingAccept(status: "Approved", cancelID: "", cancelReason: "")
        }else if sender == self.btnDecline {
            //self.bookingAccept(status: "Declined")
            self.cancelBooking(position: 0)
        }
    }
    func bookingAccept(status : String,cancelID : String,cancelReason : String) {
        self.setLoader(ishidden: false)
        var parameters = ["type":"UpdateBookingsStatus","GeneralMemberId": GeneralFunctions.getMemberd(),"iPublishedRideId" : self.editData.get("iPublishedRideId") ,"eStatus" : status ,"iBookingId" :self.editData.get("iBookingId") ]
        if status == "Declined" {
            if status == "Declined" {
                parameters["tCancelReason"] = cancelReason
                parameters["iCancelReasonId"] = cancelID
            }
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                  
                    if status == "Approved" {
                        let orderPlacedUV = GeneralFunctions.instantiateViewController(pageName: "OrderPlacedUV") as! OrderPlacedUV
                        orderPlacedUV.hintMsgForPublishRide = self.editData.get("DriverName") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_TRAVEL_WITH_YOU_TXT")
                        orderPlacedUV.isFromBookedRide = true
                        self.push(uv: orderPlacedUV)
                    }else if status == "Declined" {
                        self.close()
                    }
                    

                   
                }
            }
        })
    }
    func bookingDecline() {
        
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
    }
    func addUserLocMarker(location: CLLocation){
        
        
            let pickUpMarkerView = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
            pickUpMarkerView.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
            
            let label = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 40))
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
       
            label.text = self.editData.get("tStartLocation")
        
            label.textColor = UIColor(hex: 0x1e5b99)
            label.numberOfLines = 2
            pickUpMarkerView.addSubview(label)
            let markerImage = pickUpMarkerView.getImage()
            let markerView = UIImageView(image: markerImage)
            markerView.layer.shadowOpacity = 0.2
            markerView.layer.shadowColor = UIColor.black.cgColor
            markerView.layer.shadowRadius = 15
            self.userMarker.groundAnchor = CGPoint(0.5, 0.5)
            self.userMarker.position = location.coordinate
            self.userMarker.iconView = markerView
            self.userMarker.map = self.gMap
        }
    func destLocMarker(location: CLLocation){
        
        
            let pickUpMarkerView = self.generalFunc.loadView(nibName: "PickUpMarkerView", uv: self, isWithOutSize: true)
            pickUpMarkerView.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
            
            let label = UILabel(frame: CGRect(x: 5, y: 0, width: 100, height: 40))
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
       
            label.text = self.editData.get("tEndLocation")
        
            label.textColor = UIColor(hex: 0x1e5b99)
            label.numberOfLines = 2
            pickUpMarkerView.addSubview(label)
            let markerImage = pickUpMarkerView.getImage()
            let markerView = UIImageView(image: markerImage)
            markerView.layer.shadowOpacity = 0.2
            markerView.layer.shadowColor = UIColor.black.cgColor
            markerView.layer.shadowRadius = 15
        
            self.driverMarket.groundAnchor = CGPoint(0.5, 0.5)
            self.driverMarket.position = location.coordinate
            self.driverMarket.iconView = markerView
            self.driverMarket.map = self.gMap
        }
    func boundMapFromSourceToDest(){
        self.currentLocation = CLLocation(latitude: Double(self.editData.get("tStartLat"))!, longitude: Double(self.editData.get("tStartLong"))!)
        self.destLocation = CLLocation(latitude: Double(self.editData.get("tEndLat"))!, longitude: Double(self.editData.get("tEndLong"))!)
       
            self.gMap.clear()
            userMarker.map = nil
            driverMarket.map = nil

            self.addUserLocMarker(location: self.currentLocation)
            self.destLocMarker(location: self.destLocation)
            updateDirection = UpdateDirections(uv: self, gMap: self.gMap, fromLocation: currentLocation, destinationLocation: destLocation, isCurrentLocationEnabled: false)
            //updateDirection.onDirectionUpdateDelegate = self
            updateDirection.setCurrentLocEnabled(isCurrentLocationEnabled: false)
            updateDirection.scheduleDirectionUpdate(eTollSkipped: "Yes")
            let maxZoomLevel:Float = 17
            if(self.gMap != nil && self.gMap.minZoom < maxZoomLevel - 3.5){
                self.gMap.setMinZoom(self.gMap.minZoom, maxZoom: maxZoomLevel - 3.5)
            }
            
            var bounds = GMSCoordinateBounds()
            let orgLocation = CLLocation(latitude: self.currentLocation.coordinate.latitude, longitude:  self.currentLocation.coordinate.longitude)
            let destLocationTemp = CLLocation(latitude: self.destLocation.coordinate.latitude, longitude:  self.destLocation.coordinate.longitude)
            bounds =  bounds.includingCoordinate(orgLocation.coordinate)
            bounds =  bounds.includingCoordinate(destLocationTemp.coordinate)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if(self.gMap != nil){
                    if(self.gMap.minZoom < maxZoomLevel){
                        self.gMap.setMinZoom(self.gMap.minZoom, maxZoom: maxZoomLevel)
                    }
                    
                }
                
            }
            
            if(self.gMap != nil){
                self.gMap.animate(with: update)
            }
            
            
            CATransaction.commit()
        }
    
    func onDirectionUpdate(directionResultDict: NSDictionary) {
        
    }
    func cancelBooking(position:Int){
        let openCancelBooking = OpenCancelBooking(uv: self)
        
            openCancelBooking.isFromDecline = true
       
       
        openCancelBooking.cancelTrip(eTripType: "Ride", iTripId: self.editData.get("iPublishedRideId"), iCabBookingId: "") { (iCancelReasonId, reason) in
           
                self.bookingAccept(status: "Declined", cancelID: iCancelReasonId, cancelReason: reason)
            
        }
    }
}

