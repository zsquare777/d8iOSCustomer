//
//  SearchRideDetialsUV.swift
//  UserApp
//
//  Created by # Admin on 12/12/22.
//

import UIKit
import SysBaseLib
import SafariServices
class SearchRideDetialsUV:  ParentViewUV,ParentViewUVDelegate,MyBtnClickDelegate,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var loaderView:UIView!
    var dataDic:NSDictionary!
    var editData:NSDictionary!
    var rideList = [NSDictionary]()
    
    
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var btnDriverDetails: MyButton!
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var btnContinue: MyButton!
    @IBOutlet weak var totoalLbl: MyLabel!
    @IBOutlet weak var totalPassengerLbl: MyLabel!
    @IBOutlet weak var totoalPrice: MyLabel!
   
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var tblPassengerView: UITableView!
    @IBOutlet weak var tblPassenerContentHight: NSLayoutConstraint!
    @IBOutlet weak var passenderDetialsTblContentView: UIView!
    @IBOutlet weak var bottomViewHight: NSLayoutConstraint!
    @IBOutlet weak var callImageView: UIImageView!
    @IBOutlet weak var mapDetailView: UIView!
    @IBOutlet weak var mapDetialsLbl: MyLabel!
    @IBOutlet weak var LocationContainerView: UIView!
    @IBOutlet weak var durationLbl: MyLabel!
    
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
    @IBOutlet weak var routeDetialsLbl: MyLabel!
    @IBOutlet weak var paymentDetialsLbl: MyLabel!
    @IBOutlet weak var payementTypeLbl: MyLabel!
    @IBOutlet weak var fareCntView: UIView!
    @IBOutlet weak var fareMainView: UIView!
    @IBOutlet weak var fareMainViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var payMentDetailsView: UIView!
    @IBOutlet weak var carDetialsView: UIView!
    @IBOutlet weak var carDetialsCntView: UIView!
    @IBOutlet weak var carMakeImgView: UIImageView!
    @IBOutlet weak var carModelImgView: UIImageView!
    @IBOutlet weak var carNameLbl: MyLabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var carDetialsLbl: MyLabel!
    @IBOutlet weak var carPlateLbl: MyLabel!
    @IBOutlet weak var carMakeLbl: MyLabel!
    @IBOutlet weak var carImageHight: NSLayoutConstraint!
    @IBOutlet weak var catDetialsViewTop: NSLayoutConstraint!
    @IBOutlet weak var additionalLbl: MyLabel!
    @IBOutlet weak var additionalLblTxt: MyLabel!
    
    @IBOutlet weak var driverDetialsView: UIView!
    @IBOutlet weak var driverDetialsLbl: MyLabel!
    @IBOutlet weak var driverDetailsMainView: UIView!
    @IBOutlet weak var driverNameLbl: MyLabel!
    @IBOutlet weak var driverNoLbl: MyLabel!
    @IBOutlet weak var driverImgView: UIImageView!
    @IBOutlet weak var driverCallImgView: UIImageView!
    @IBOutlet weak var cancelRideNewButton: MyButton!
    @IBOutlet weak var cancelRideNewHight: NSLayoutConstraint!
    var finalStrRP:NSMutableAttributedString!
    var noSeats = ""
    var isFromBook = false
    var myRideUV : MyRideUV!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "SearchRideDetailsScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
           
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            //self.btnContinue.isHidden = self.isFromBook
        }else if (type == 1){
            let getReceiptBtn = UIBarButtonItem(image: UIImage(named: "ic-contactus_new"), style: .plain, target: self, action:#selector(self.contactusTapped))
            self.navigationItem.rightBarButtonItem = getReceiptBtn
            self.addBack()
            self.configRTL()
            self.setData()
            self.setLocationView()
            self.setPriceView()
            self.setCarView()
            self.setDriverView()
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
    func setPriceView(){
        self.finalStrRP = NSMutableAttributedString.init(string: "")
        self.finalStrRP.append(self.getAttributedString(str: editData.get("PaymentModeTitle") + ": " ,color:UIColor(hex: 0x8FA1B4),isBold: false))
        self.finalStrRP.append(self.getAttributedString(str: editData.get("PaymentModeLabel") ,color:UIColor(hex: 0x1B2A3B),isBold: true))
        self.payementTypeLbl.attributedText = self.finalStrRP
        self.paymentDetialsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Payment Details", key: "LBL_PYMENT_DETAILS")
        self.fareMainView.cornerRadius = 10
        self.shadowOnview(view: self.fareCntView)
        
        self.fareMainView.masksToBounds = true
        self.fareMainView.borderWidth = 1
        self.fareMainView.borderColor = UIColor(hex: 0xDDDDDD)
        self.addFareDetails(dataDic: self.editData)
    }
    func setCarView (){
        self.shadowOnview(view: self.carDetialsCntView)
        self.carImageHight.constant = Utils.getHeightOfBanner(widthOffset: 40, ratio: "16:9")
        self.carDetialsLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RIDE_SHARE_CAR_DETAILS_TITLE")
        let carDict = self.editData.dictOf("carDetails")
        self.carNameLbl.text = carDict.get("cMake")
        self.carMakeLbl.text = carDict.get("cModel")
        self.carPlateLbl.text = carDict.get("cNumberPlate")
        
        self.carImgView.sd_setShowActivityIndicatorView(true)
        self.carImgView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
        Utils.delayWithSeconds(1) {
            self.carImgView.roundTo(corners: [.topLeft,.topRight], radius: 10)
        }
        
        self.carImgView.sd_setImage(with: URL(string: carDict.get("cImage") ), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        self.additionalLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RIDE_SHARE_ADDITIONAL_NOTES_TXT")
        self.additionalLblTxt.text = carDict.get("cNote")
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
    func setDriverView(){
        self.shadowOnview(view: self.driverDetailsMainView)
        self.driverDetialsLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Driver Details", key: "LBL_DRIVER_DETAILS")
        self.driverImgView.sd_setImage(with: URL(string: editData.get("DriverImg")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        self.driverNameLbl.text = editData.get("DriverName")
        self.driverNoLbl.text = editData.get("DriverPhone")
        self.driverNoLbl.textColor = SColors.Theme
        self.cancelRideNewButton.clickDelegate = self
        
        if self.editData.get("eStatus") == "Cancelled" ||  self.editData.get("eStatus") == "Declined"  {
            self.cancelRideNewButton.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_REASON"))
        }else{
            self.cancelRideNewButton.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_RIDE_SHARE_CANCEL"))
        }
        GeneralFunctions.setImgTintColor(imgView: self.driverCallImgView, color: SColors.Theme)
        self.driverCallImgView.handleClick { instance in
            if self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == "VOIP"{
            
                            self.audioCall()
                            return
            
                        }else if(self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == Utils.VIDEOCALL){
            
                            self.videoCall()
                            return
                        }else if (self.userProfileJson.get("CALLING_METHOD_RIDE_SHARE").uppercased() == Utils.VOIP_VIDEOCALL) {
                            let openListView = OpenListView(uv: self, containerView: self.view)
                            openListView.openNewList = true
                            openListView.isFromDate = true
                            openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                            if selectedItemId == 0 {
            
                                self.videoCall()
                            }else {
                                self.audioCall()
            
                            }
            
                            })
                            return
                        }else{
                            guard let url = URL(string: "telprompt://\(self.editData.get("DriverPhone"))"),
                                    UIApplication.shared.canOpenURL(url) else {
                                    return
                                }
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
        }
        if(Configurations.isRTLMode()){
            self.driverDetialsLbl.textAlignment = .right
        }
    }
    func setData()  {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Ride Details", key: "LBL_RIDE_SHARE_RIDE_DETAILS")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Ride Details", key: "LBL_RIDE_SHARE_RIDE_DETAILS")
        self.shadowOnview(view: bottomView)
       
        
 
     
        self.btnContinue.clickDelegate = self
        
        self.totalPassengerLbl.text = self.editData.get("vNoOfPassengerText")
        if isFromBook {
            
            self.bottomViewHight.constant = 0
            self.bottomView.isHidden = true
            self.totoalLbl.text = self.editData.get("PaymentText")
            self.btnContinue.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
            self.btnContinue.btnType = "Cancel"
            self.btnContinue.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
            if self.editData.get("eStatus") == "Cancelled" ||  self.editData.get("eStatus") == "Declined"{
                self.btnContinue.btnType = "Reason"
                self.btnContinue.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_REASON"))
                //self.btnDriverDetails.isHidden = true
            }else{
               // self.btnDriverDetails.isHidden = false
                //self.btnDriverDetails.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Driver Details", key: "LBL_DRIVER_DETAILS"))
                
            }
        }else{
            self.bottomViewHight.constant = 170
            self.bottomView.isHidden = false
            self.totoalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_TOTAL_PRICE")
            self.btnContinue.btnType = "Continue"
            self.btnContinue.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Continue", key: "LBL_RIDE_SHARE_CONTINUE"))
            self.btnContinue.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 0, cornerRadius: 10)
            //self.btnDriverDetails.isHidden = false
            //self.btnDriverDetails.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Driver Details", key: "LBL_DRIVER_DETAILS"))
            self.cancelRideNewButton.isHidden = true
            self.cancelRideNewHight.constant = 0
            self.fareMainViewHight.constant = 0
            self.fareCntView.isHidden = true
            let tempFrame = self.payMentDetailsView.frame.size.height
            self.catDetialsViewTop.constant = -tempFrame
            self.payMentDetailsView.isHidden = true
        }
        self.totoalPrice.textColor = SColors.Theme
        self.totoalPrice.text = self.editData.get("fPrice")
       
      
    }
    func myBtnTapped(sender: MyButton) {
        if sender.btnType == "Continue"{
            let bookingSummaryUV = GeneralFunctions.instantiateViewController(pageName: "BookingSummaryUV") as! BookingSummaryUV
            bookingSummaryUV.editData = self.editData
            bookingSummaryUV.noSeats = self.noSeats
            self.push(uv: bookingSummaryUV)
        }else if sender.btnType == "Cancel" {
            self.cancelBooking(position: 0)
        }else if sender == cancelRideNewButton{
            if self.editData.get("eStatus") == "Cancelled" ||  self.editData.get("eStatus") == "Declined" {
                self.generalFunc.setError(uv: self, title: "", content: editData.get("tCancelReason"))
            }else{
                self.cancelBooking(position: 0)
            }
        }
        else if sender.btnType == "Reason" {
            self.generalFunc.setError(uv: self, title: "", content: editData.get("tCancelReason"))
        }else if sender.btnType == "Driver"{
            let publishRideUV = GeneralFunctions.instantiateViewController(pageName: "PublishRideUV") as! PublishRideUV
            publishRideUV.PAGE_TYPE = "Details"
            publishRideUV.PAGE_TITILE = self.generalFunc.getLanguageLabel(origValue: "Details", key: "LBL_RIDE_SHARE_DETAILS")
            publishRideUV.editData = self.editData
            publishRideUV.isFromBook = true
            self.push(uv: publishRideUV)
           
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return editData.arrOf("BookingList").count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
       
        return 80
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerDetialsTVC", for: indexPath) as! PassengerDetialsTVC
            let arr =  self.editData.arrOf("BookingList")
            let item = arr[indexPath.item] as! NSDictionary
            Utils.createRoundedView(view:cell.userImageView, borderColor: SColors.Theme, borderWidth: 3)
            cell.userImageView.sd_setImage(with: URL(string: item.get("rider_ProfileImg")), placeholderImage:UIImage(named:"ic_no_pic_user"))
            cell.userNameLbl.text = item.get("rider_Name")
            cell.userNameLbl.textColor = SColors.Theme
            cell.userAddressLbl.text = ""
            cell.userNameLbl.isHidden = false
            self.shadowOnview(view: cell.mainView)
            cell.bottomView.isHidden = true
            cell.bottomViewHight.constant = 0
            //cell.userNameTop.constant = 10
            
            cell.callImageView.isHidden = true
            cell.mainView.backgroundColor = UIColor(hex: 0xf6f6f6)
        //cell.imageY.constant = 10
            return cell
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    func audioCall(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType]
        let assignedDic = ["Id":self.editData.get("iDriverId"), "Name": self.editData.get("DriverName"), "PImage": self.editData.get("DriverImg"), "type": "Passenger"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.editData.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
        return
    }
    func videoCall(){
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType, "isVideoCall":"Yes"]
        let assignedDic = ["Id":self.editData.get("iDriverId"), "Name": self.editData.get("DriverName"), "PImage": self.editData.get("DriverImg"), "type": "Passenger", "isVideoCall":"Yes"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.editData.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
        return
    }
    func cancelBooking(position:Int){
        let openCancelBooking = OpenCancelBooking(uv: self)
       
            openCancelBooking.isFromPublish = true
       
       
        openCancelBooking.cancelTrip(eTripType: "Ride", iTripId: self.editData.get("iPublishedRideId"), iCabBookingId: "") { (iCancelReasonId, reason) in
           
            self.continueCancelBooking(iRideId: self.editData.get("iPublishedRideId"), reason: reason, iCancelReasonId: iCancelReasonId)
           
        }
    }
    func continueCancelBooking(iRideId: String, reason:String, iCancelReasonId: String){
        let parameters = ["type":"CancelRideShareBooking", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iPublishedRideId": iRideId, "tCancelReason": reason, "iCancelReasonId": iCancelReasonId,"iBookingId" : self.editData.get("iBookingId")]
        
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
    func addFareDetails(dataDic:NSDictionary){

        
        
        self.fareMainView.cornerRadius = 10
        self.shadowOnview(view: self.fareCntView)
        
        self.fareMainView.masksToBounds = true
        self.fareMainView.borderWidth = 1
        self.fareMainView.borderColor = UIColor(hex: 0xDDDDDD)
        for fareSubView in self.fareMainView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        
        let fareDetailsNewArr = dataDic.arrOf("PriceBreakdown")
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        for i in 0..<fareDetailsNewArr.count
        {
            let dict_temp = fareDetailsNewArr[i] as! NSDictionary

            for (key, value) in dict_temp {
                _ = fareDetailsNewArr[i] as! NSDictionary
                let totalSubViewCounts = self.fareMainView.subviews.count

                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 80

                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))

                    viewCus.backgroundColor = UIColor(hex: 0xdedede)

                    //                    self.fareContainerView.addArrangedSubview(viewCus)
                    self.fareMainView.addSubview(viewCus)
                    //fairViewArray += [viewCus]

                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 80

                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 50))


                    let titleStr = key as? String ?? ""
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)



                    var font = UIFont(name: Fonts().regular, size: 16)!
                    var fontTitle = UIFont(name: Fonts().regular, size: 14)!

                    var widthOfTitle = titleStr.width(withConstrainedHeight: 50, font: fontTitle) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 50, font: font) + 15

                    if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                        widthOfvalue = ((viewWidth * 80) / 100)
                        widthOfTitle = ((viewWidth * 20) / 100)
                    }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }

                    let widthOfParentView = viewWidth - widthOfvalue

                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 50))
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView - 30, y: 0, width: widthOfvalue + 30, height: 50))

                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 50))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue + 30, height: 50))

                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                    }

                    lblTitle.textColor = UIColor(hex: 0x1B2A3B)
                    lblValue.textColor = SColors.Theme

                    lblValue.font = font
                    lblTitle.font = fontTitle
                    if(i == fareDetailsNewArr.count - 1){
                        lblTitle.fontFamilyWeight = "Bold"
                    }else{
                        lblTitle.fontFamilyWeight = "Semibold"
                    }
                    
                    lblValue.fontFamilyWeight = "Bold"
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


                    viewCus.backgroundColor = UIColor.white
                    self.fareMainView.addSubview(viewCus)

                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    lblValue.textColor = SColors.Theme
                    lblValue.font = UIFont(name: Fonts().regular, size: 16)!

                }


            }
        }

        
        self.fareMainViewHight.constant = CGFloat((self.fareMainView.subviews.count - totalSeperatorViews) * 50) + CGFloat((totalSeperatorViews * 1))
        self.fareCntView.isHidden = false
}
    @objc func contactusTapped(){
        let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
        self.push(uv: contactUsUv)
    }
    func getAttributedString(str:String,color:UIColor,isBold : Bool) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
       
        return attributedString
    }
}
