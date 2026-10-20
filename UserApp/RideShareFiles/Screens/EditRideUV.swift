//
//  EditRideUV.swift
//  UserApp
//
//  Created by # Admin on 05/12/22.
//

import UIKit
import SysBaseLib
import SafariServices
class EditRideUV: ParentViewUV,ParentViewUVDelegate,UITableViewDataSource,UITableViewDelegate,MyBtnClickDelegate {
    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    
    
    @IBOutlet weak var routeDetialsLbl: MyLabel!
    @IBOutlet weak var btnContactUs: MyButton!
    @IBOutlet weak var btnCancel: MyButton!
    @IBOutlet weak var noRequestLbl: MyLabel!
    @IBOutlet weak var mainViewLocation: UIView!
    @IBOutlet weak var startCityLbl: MyLabel!
    @IBOutlet weak var endCityLbl: MyLabel!
    @IBOutlet weak var startCityView: UIView!
    @IBOutlet weak var endCityView: UIView!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var dateTimeLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var startAddLbl: MyLabel!
    @IBOutlet weak var endAddLbl: MyLabel!
    @IBOutlet weak var startTimeLbl: MyLabel!
    @IBOutlet weak var endTimeLbl: MyLabel!
    @IBOutlet weak var perPassngerLbl: MyLabel!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var passengerDetialsView: UIView!
    @IBOutlet weak var passengerDetailsLbl: MyLabel!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tblPassengerView: UITableView!
    
    @IBOutlet weak var carDetialsView: UIView!
    @IBOutlet weak var carDetialsCntView: UIView!
    @IBOutlet weak var carMakeImgView: UIImageView!
    @IBOutlet weak var carModelImgView: UIImageView!
    @IBOutlet weak var carNameLbl: MyLabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var additionalLbl: MyLabel!
    @IBOutlet weak var additionalLblTxt: MyLabel!
    @IBOutlet weak var carDetialsLbl: MyLabel!
    @IBOutlet weak var carPlateLbl: MyLabel!
    @IBOutlet weak var carMakeLbl: MyLabel!
    @IBOutlet weak var carImageHight: NSLayoutConstraint!
    @IBOutlet weak var catDetialsViewTop: NSLayoutConstraint!
    @IBOutlet weak var tblViewHight: NSLayoutConstraint!
    var finalStrRP:NSMutableAttributedString!
    
    var isFromDecline = false
   
    
    
    var editData : NSDictionary!
    var selectedData = ""
    var loaderView:UIView!
    var bookID = ""
    var myRideUV  : MyRideUV!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "EditRideScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.tblPassengerView.register(UINib(nibName: "PassengerDetialsTVC", bundle: nil), forCellReuseIdentifier: "PassengerDetialsTVC")
            self.tblPassengerView.dataSource = self
            self.tblPassengerView.delegate = self
            self.getMyRide()
            self.setCarView()
        }else if (type == 1){
                        
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Ride Details", key: "LBL_RIDE_SHARE_RIDE_DETAILS")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Ride Details", key: "LBL_RIDE_SHARE_RIDE_DETAILS")
            let getReceiptBtn = UIBarButtonItem(image: UIImage(named: "ic-contactus_new"), style: .plain, target: self, action:#selector(self.contactusTapped))
            self.navigationItem.rightBarButtonItem = getReceiptBtn
            self.addBack()
            self.configRTL()
            
        }
    }
    func setData()  {
        self.addBack()
        self.configRTL()
        
        self.btnCancel.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_RIDE_SHARE_CANCEL"))
        self.btnContactUs.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Contact Us", key: "LBL_RIDE_SHARE_CONTACT_US"))
        self.btnContactUs.isHidden  = true
        self.btnCancel.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 10)
        self.btnCancel.clickDelegate = self
        self.btnContactUs.clickDelegate = self
        self.passengerDetailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Passenger Detials", key: "LBL_RIDE_SHARE_PASSENGER_DETAILS")
        self.noRequestLbl.text = self.generalFunc.getLanguageLabel(origValue: "Passenger Detials", key: "LBL_RIDE_SHARE_NO_REQUESTS_MSG")
        if editData.arrOf("BookingList").count > 0 {
        
            self.noRequestLbl.isHidden = true
            self.shadowOnview(view: self.bottomView)
       
            
            let arr =  self.editData.arrOf("BookingList")
            self.tblPassengerView.reloadData()
            //Utils.delayWithSeconds(1) {
               
                self.tblViewHight.constant = CGFloat.greatestFiniteMagnitude
                self.tblPassengerView.reloadData()
                self.tblPassengerView.layoutIfNeeded()
                self.tblViewHight.constant = self.tblPassengerView.contentSize.height
            //}
            self.catDetialsViewTop.constant = 0
        }else{
            self.noRequestLbl.isHidden = false
            self.catDetialsViewTop.constant = 10
        }
       
        if(Configurations.isRTLMode()){
            self.noRequestLbl.textAlignment = .right
            self.passengerDetailsLbl.textAlignment = .right
        }
    }
    func setCarView (){
        self.shadowOnview(view: self.carDetialsCntView)
        self.carImageHight.constant = Utils.getHeightOfBanner(widthOffset: 40, ratio: "16:9")
        self.carDetialsLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RIDE_SHARE_CAR_DETAILS_TITLE")
        let carDict = self.editData.dictOf("carDetails")
        self.carNameLbl.text = carDict.get("cMake")
        self.carMakeLbl.text = carDict.get("cModel")
        self.carPlateLbl.text = carDict.get("cNumberPlate")
        self.additionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RIDE_SHARE_ADDITIONAL_NOTES_TXT")
        self.additionalLblTxt.text = carDict.get("cNote")
        self.carImgView.sd_setShowActivityIndicatorView(true)
        self.carImgView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
        self.carImgView.sd_setImage(with: URL(string: carDict.get("cImage") ), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        Utils.delayWithSeconds(1) {
            self.carImgView.roundTo(corners: [.topLeft,.topRight], radius: 10)
        }
        self.carImgView.handleClick { instance in
            if let url = URL(string: carDict.get("cImage")) {
                    let svc = SFSafariViewController(url: url)
                    self.present(svc, animated: true, completion: nil)
            }
        }
        if(Configurations.isRTLMode()){
            self.carDetialsLbl.textAlignment = .right
            self.additionalLbl.textAlignment = .right
            self.additionalLblTxt.textAlignment = .right
        }
    }
    
    func setLocationView()  {
        self.shadowOnview(view: self.mainViewLocation)
        self.startCityLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Start Location", key: "LBL_RIDE_SHARE_DETAILS_START_LOC_TXT")
        self.routeDetialsLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Route Details", key: "LBL_RIDE_SHARE_ROUTE_DETAILS")
        self.startAddLbl.text = editData.get("tStartLocation")
        self.startCityView.layer.masksToBounds = true
        self.startCityView.layer.cornerRadius = self.startCityView.frame.width / 2
        self.endCityLbl.text =  self.generalFunc.getLanguageLabel(origValue: "End Location", key: "LBL_RIDE_SHARE_DETAILS_END_LOC_TXT")
        self.endAddLbl.text = editData.get("tEndLocation")
        self.endCityView.layer.masksToBounds = true
        self.endCityView.layer.cornerRadius = self.endCityView.frame.width / 2
        self.priceLbl.text = editData.get("fPrice")
        self.priceLbl.textColor = SColors.Theme
        self.dateTimeLbl.text = editData.get("StartDate")
        self.startTimeLbl.text = editData.get("StartTime")
        self.startTimeLbl.textColor = SColors.Theme
        self.endTimeLbl.text = editData.get("EndTime")
        self.endTimeLbl.textColor = SColors.Theme
        
        self.dottedView.backgroundColor = UIColor.clear
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.dottedView.createDashedLine(color: UIColor(hex: 0xDDDDDD), lineWidth: 2, true)
        })
            
        self.perPassngerLbl.text = editData.get("PriceLabel")
        self.LocationView.isHidden = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return editData.arrOf("BookingList").count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       

            return UITableView.automaticDimension
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerDetialsTVC", for: indexPath) as! PassengerDetialsTVC
            let arr =  self.editData.arrOf("BookingList")
            cell.mainView.backgroundColor = SColors.ThemeTxt
            let item = arr[indexPath.item] as! NSDictionary
            
            cell.userImageView.sd_setImage(with: URL(string: item.get("rider_ProfileImg")), placeholderImage:UIImage(named:"ic_no_pic_user"))
            cell.userNameLbl.text = item.get("rider_Name")
            
            cell.userAddressLbl.text = item.get("statusMessage")
            cell.btnAceept.tag = indexPath.row
            cell.btnDecline.tag = indexPath.row
            cell.btnAceept.clickDelegate = self
            cell.btnDecline.clickDelegate = self
            cell.seatLbl.text = item.get("BookedSeatsTxt")
            cell.imageViewIcon.isHidden = false
            cell.paymentLbl.text = item.get("PaymentLabel")
            cell.priceLbl.text = item.get("TotalFare")
            cell.priceLbl.textColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: cell.fareIconImgeView, color: SColors.Theme)
           self.finalStrRP = NSMutableAttributedString.init(string: "")
           self.finalStrRP.append(self.getAttributedString(str: item.get("PaymentModeTitle") + ": " ,color:UIColor(hex: 0x8FA1B4)))
           self.finalStrRP.append(self.getAttributedString(str:  item.get("PaymentModeLabel") ,color:UIColor(hex: 0x1B2A3B)))
         cell.paymentTypeLbl.attributedText = self.finalStrRP
          if item.get("eShowCallImg").uppercased() == "YES" {
              cell.callImageView.isHidden = false
          }else{
              cell.callImageView.isHidden = true
          }
        
        
            
            cell.seatLbl.isHidden = false
            if item.get("eStatus") == "Pending" || item.get("eStatus") == "Declined" || item.get("eStatus") == "Cancelled" {
               
                cell.bottomView.isHidden = false
                cell.btnAceept.btnType = "Accept"
                cell.btnAceept.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCEPT_TXT"))
                cell.btnDecline.setCustomColor(textColor: UIColor(hex: 0x1B2A3B), bgColor: SColors.ThemeTxt, pulseColor: UIColor(hex: 0x1B2A3B), borderColor:UIColor(hex: 0x1B2A3B), borderWidth: 1, cornerRadius: 10)
                if item.get("eStatus") == "Declined" || item.get("eStatus") == "Cancelled" {
                    cell.btnAceept.isHidden = true
                    cell.btnDecline.btnType = "View Reason"
                    cell.btnDecline.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_REASON"))
                }else{
                    cell.btnAceept.isHidden = false
                    cell.btnDecline.btnType = "Decline"
                    cell.btnDecline.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TXT"))
                  
                }
                cell.bottomViewHight.constant = 50
                cell.btnViewTop.constant = 15
            }else{
                cell.bottomView.isHidden = true
                cell.bottomViewHight.constant = 0
                cell.btnViewTop.constant = 0
            }
        
            cell.callImageView.handleClick { instance in
                if self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == "VOIP"{

                    self.audioCall(item: item)
                    return
                    
                }else if(self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == Utils.VIDEOCALL){
                    self.videoCall(item: item)
                    return
                }else if (self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == Utils.VOIP_VIDEOCALL) {
                    let openListView = OpenListView(uv: self, containerView: self.view)
                    openListView.openNewList = true
                    openListView.isFromDate = true
                    openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                                 
                    if selectedItemId == 0 {
                      
                        self.videoCall(item: item)
                    }else {
                        self.audioCall(item: item)
                       
                    }
                    
                    })
                    return
                }else{
                    guard let url = URL(string: "telprompt://\(item.get("rider_Phone"))"),
                            UIApplication.shared.canOpenURL(url) else {
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        if item.arrOf("PriceBreakdown").count > 0 {
            cell.fareIconImgeView.isHidden = false
        }else{
            cell.fareIconImgeView.isHidden = true
        }
        cell.fareIconImgeView.handleClick { instance in
            let fareBreakDownUv = GeneralFunctions.instantiateViewController(pageName: "FareBreakDownUV") as! FareBreakDownUV
            fareBreakDownUv.isfromRide = true
            fareBreakDownUv.rideArray = item.arrOf("PriceBreakdown")
            fareBreakDownUv.rideTitle = item.get("PriceBreakdownTitle")
            self.push(uv: fareBreakDownUv)
        }
        cell.priceLbl.handleClick { instance in
            let fareBreakDownUv = GeneralFunctions.instantiateViewController(pageName: "FareBreakDownUV") as! FareBreakDownUV
            fareBreakDownUv.isfromRide = true
            fareBreakDownUv.rideArray = item.arrOf("PriceBreakdown")
            fareBreakDownUv.rideTitle = item.get("PriceBreakdownTitle")
            self.push(uv: fareBreakDownUv)
        }
            
            self.shadowOnview(view: cell.mainView)
            return cell
        
    }
    
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 1.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnContactUs {
            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
            self.push(uv: contactUsUv)
        }else if sender == self.btnCancel {
            self.isFromDecline = false
            self.cancelBooking(position: 0)
            
        }else if sender.btnType == "View Reason" {
            let arr =  self.editData.arrOf("BookingList")
            let item = arr[sender.tag] as! NSDictionary
            bookID = item.get("iBookingId")
            self.generalFunc.setError(uv: self, title: "", content: item.get("DeclineReason"))
        }else if sender.btnType == "Accept" {
            let arr =  self.editData.arrOf("BookingList")
            let item = arr[sender.tag] as! NSDictionary
            bookID = item.get("iBookingId")
            self.bookingAccept(status: "Approved", bookID: item.get("iBookingId"), cancelID: "", cancelReason: "")
        }else if sender.btnType == "Decline" {
            let arr =  self.editData.arrOf("BookingList")
            let item = arr[sender.tag] as! NSDictionary
            bookID = item.get("iBookingId")
            self.isFromDecline = true
            self.cancelBooking(position: 0)
        }
    }
    func deleteRide(postId : String)  {
        //setLoader(ishidden: false)
        
        let parameters = ["type":"DeletePost", "iMemberId":GeneralFunctions.getMemberd(),"iRentItemPostId" : postId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
           // self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
              
                if(dataDict.get("Action") == "1"){
                   
                    
                   
                }else if dataDict.get("Action") == "0"{
                    
                }
                
            }else{
               
                
                
            }
        })
}
    func cancelBooking(position:Int){
        let openCancelBooking = OpenCancelBooking(uv: self)
        if isFromDecline {
            openCancelBooking.isFromDecline = true
        }else{
            openCancelBooking.isFromPublish = true
        }
       
        openCancelBooking.cancelTrip(eTripType: "Ride", iTripId: self.editData.get("iPublishedRideId"), iCabBookingId: "") { (iCancelReasonId, reason) in
            if !self.isFromDecline {
            self.continueCancelBooking(iRideId: self.editData.get("iPublishedRideId"), reason: reason, iCancelReasonId: iCancelReasonId)
            }else{
                self.bookingAccept(status: "Declined", bookID: self.bookID, cancelID: iCancelReasonId, cancelReason: reason)
            }
        }
    }
    func continueCancelBooking(iRideId: String, reason:String, iCancelReasonId: String){
        let parameters = ["type":"CancelPublishRide", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iPublishedRideId": iRideId, "tCancelReason": reason, "iCancelReasonId": iCancelReasonId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        //self.close()
                        if self.myRideUV != nil {
                            self.myRideUV.getlistAfterCancel()
                            self.close()
                        }
                    })
                }else{
                   
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    func getMyRide(){
        
        self.setLoader(ishidden: false)
        self.scrView.isHidden = true
        self.bottomView.isHidden = true
        let parameters = ["type":"GetPublishedRides","GeneralMemberId": GeneralFunctions.getMemberd(),"iPublishedRideId" : self.editData.get("iPublishedRideId")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.scrView.isHidden = false
            self.bottomView.isHidden = false
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let temp = dataDict.arrOf("message") as! [NSDictionary]
                    self.editData = temp[0]
                    self.setData()
                    self.setLocationView()

              }
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
    func bookingAccept(status : String,bookID: String,cancelID : String,cancelReason : String ) {
        self.setLoader(ishidden: false)
        var parameters = ["type":"UpdateBookingsStatus","GeneralMemberId": GeneralFunctions.getMemberd(),"iPublishedRideId" : self.editData.get("iPublishedRideId") ,"eStatus" : status ,"iBookingId" :self.bookID]
        
        if status == "Declined" {
            parameters["tCancelReason"] = cancelReason
            parameters["iCancelReasonId"] = cancelID
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                  
                  
                    _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content:self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: ""), completionHandler: { (btnClickedIndex) in
                        
                        self.getMyRide()
                    })
                
                   
                } else if(dataDict.get("Action") == "0"){
                    _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content:self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: ""), completionHandler: { (btnClickedIndex) in
                        
                        
                    })
                }
            }
        })
    }
    func audioCall(item : NSDictionary){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType]
        let assignedDic = ["Id":item.get("rider_iUserId"), "Name": item.get("rider_Name"), "PImage": item.get("DriverImg"), "type": "Passenger"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.editData.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
        return
    }
    func videoCall(item : NSDictionary){
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType, "isVideoCall":"Yes"]
        let assignedDic = ["Id":item.get("rider_iUserId"), "Name": item.get("rider_Name"), "PImage": item.get("DriverImg"), "type": "Passenger", "isVideoCall":"Yes"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.editData.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
        return
    }
    @objc func contactusTapped(){
        let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
        self.push(uv: contactUsUv)
    }
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
}
