

import UIKit
import SysBaseLib

class OpenTripFinishView: NSObject,MyBtnClickDelegate {
    
    
    typealias CompletionHandler = () -> Void
    
    var uv:UIViewController!
    var containerView:UIView!
    var userProfileJson:NSDictionary!

    let generalFunc = GeneralFunctions()
    
    var bgView:UIView!
    
    var tripFinishView:TripFinishView!
    
    var cancelReasonsDataDict:NSDictionary!
    
    var superView:UIView!
    
    var ufxDriverAcceptedReqNow = false
    var ufxReqLater = false

    var viewLoadForDelivery = false
    var isUnwindToHome = true
    var isFromUFXCheckOut = false
    var deliveryBooking = false
    var isFromTip = false
    var isFromBid = false
    var isNewDialouge = false
    var isFromMyRide = false
    var isFromMyBookRide = false
    var newbtnPostiveTitle = ""
    var newbtnNegativeTitle = ""
    var isFromNewPost = false
    var eType = ""
    init(uv:UIViewController){
        self.uv = uv
        super.init()
    }
    
    init(uv:UIViewController?, containerView:UIView){
        super.init()
        self.uv = uv
        self.containerView = containerView
    }

    func show(title:String, desc:String , _ isShowCancelbtn:Bool? = false, _ cancelBtnPosition:cancelButonPosition? = .right ,handler: @escaping CompletionHandler) {
           userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if(self.uv.navigationController != nil){
            superView = self.uv.navigationController!.view
        }else{
            superView = self.uv.view
        }
        
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.4
        bgView.frame = superView.frame
        
        bgView.center = CGPoint(x: superView.bounds.midX, y: superView.bounds.midY)
        if isNewDialouge {
            
           
            tripFinishView = TripFinishView(frame: CGRect(x:0, y: 0, width:Application.screenSize.width , height: Application.screenSize.height))
            bgView.backgroundColor = UIColor(hex: 0x000000).light(by: 20)
            tripFinishView.backgroundColor = UIColor.clear
            tripFinishView.mainView.backgroundColor = UIColor.clear
            tripFinishView.newTripFinishView.cornerRadius = 10
            
            tripFinishView.masksToBounds = true
            tripFinishView.newRoundView.backgroundColor = SColors.Theme.light(by: 30)
            tripFinishView.newRoundImageView.backgroundColor = SColors.Theme
            tripFinishView.newRoundImageView.image = UIImage(named: "ic_new_correct_")?.addImagePadding(x: 25, y: 25)
            tripFinishView.newTripFinishView.isHidden = false
            tripFinishView.newTitleLbl.text = title
            tripFinishView.newDiscriptionLbl.text = desc
            tripFinishView.btnNegative.setCustomColor(textColor: UIColor(hex: 0x1B2A3B), bgColor: SColors.ThemeTxt, pulseColor: UIColor.clear, borderColor: UIColor(hex: 0x1B2A3B), borderWidth: 1, cornerRadius: 10)
            tripFinishView.btnPositive.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: UIColor.clear, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
            tripFinishView.newTitleLbl.sizeToFit()
            tripFinishView.descriptionLabel.sizeToFit()
            tripFinishView.headerImageView.isHidden = true
            tripFinishView.descriptionLabel.isHidden = true
            tripFinishView.titleLabel.isHidden = true
            tripFinishView.positiveBtn.isHidden = true
            tripFinishView.negativeBtn.isHidden = true
            tripFinishView.btnStackView.isHidden = true
            tripFinishView.okTipBtn.isHidden = true
            tripFinishView.btnPositive.setButtonTitle(buttonTitle: newbtnPostiveTitle)
            tripFinishView.btnNegative.setButtonTitle(buttonTitle: newbtnNegativeTitle)
            tripFinishView.btnNegative.clickDelegate = self
            tripFinishView.btnPositive.clickDelegate = self
                
            let currentWindow = Application.window
            
            if(currentWindow != nil){
                currentWindow?.addSubview(bgView)
                currentWindow?.addSubview(tripFinishView)
            }else{
                self.uv.view.addSubview(bgView)
                self.uv.view.addSubview(tripFinishView)
            }
        }else{
            let width = Application.screenSize.width  > 380 ? 370 : Application.screenSize.width - 50
            tripFinishView = TripFinishView(frame: CGRect(x: superView.frame.width / 2, y: superView.frame.height / 2, width:width, height: 360))
            tripFinishView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
            tripFinishView.cornerRadius = 10
            tripFinishView.masksToBounds = true
            tripFinishView.layer.shadowOpacity = 0.5
            tripFinishView.layer.shadowOffset = CGSize(width: 0, height: 3)
            tripFinishView.layer.shadowColor = UIColor.black.cgColor
            
            let currentWindow = Application.window
            
            if(currentWindow != nil){
                currentWindow?.addSubview(bgView)
                currentWindow?.addSubview(tripFinishView)
            }else{
                self.uv.view.addSubview(bgView)
                self.uv.view.addSubview(tripFinishView)
            }
            
            var height:CGFloat = 360
            if isShowCancelbtn! {
                tripFinishView.negativeBtn.isHidden = false
                if cancelBtnPosition == cancelButonPosition.bottom {
                    tripFinishView.btnStackView.axis = .vertical
                    tripFinishView.btnStackView.spacing = 5
                    tripFinishView.negativeBtn.backgroundColor = .clear
                    tripFinishView.negativeBtn.borderWidth = 0
                    tripFinishView.negativeBtn.borderColor = .clear
                    tripFinishView.negativeBtn.setCustomTextColor(color: .gray)
                    height = height + 40
                    
                }else {
                    tripFinishView.btnStackView.axis = .horizontal
                    tripFinishView.btnStackView.distribution = .fillEqually
                    tripFinishView.negativeBtn.textColor = SColors.Theme
                    tripFinishView.negativeBtn.borderColor = SColors.Theme
                    tripFinishView.negativeBtn.borderWidth = 1
                    tripFinishView.negativeBtn.backgroundColor = .clear
                }
            }
            
            tripFinishView.descriptionLabel.sizeToFit()
            tripFinishView.descriptionLabel.numberOfLines = 0
            tripFinishView.titleLabel.font = UIFont(name: Fonts().semibold, size: 17)
            tripFinishView.descriptionLabel.font = UIFont(name: Fonts().regular , size: 14)
            if title == "" {
                
                if(ufxDriverAcceptedReqNow == true){
                    tripFinishView.titleLabel.text =  self.generalFunc.getLanguageLabel(origValue: "Booking Requested", key: "LBL_BOOKING_ACCEPTED")
                    
                    if viewLoadForDelivery == true{
                        tripFinishView.descriptionLabel.text = self.generalFunc.getLanguageLabel(origValue: "Driver has accepted your request and arriving at your location. You can check the status by tapping below button.", key: "LBL_ONGOING_TRIP_TXT")
                    }
                    else{
                        tripFinishView.descriptionLabel.text = self.generalFunc.getLanguageLabel(origValue: "Provider has accepted your request and arriving at your location. You can check the status by tapping below button.", key: "LBL_ONGOING_TRIP_TXT")
                    }
                    
                    tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "View On Going Trips", key: "LBL_VIEW_ON_GOING_TRIPS")
                    
                }else if(ufxReqLater == true){
                    
                    tripFinishView.titleLabel.text =  self.generalFunc.getLanguageLabel(origValue: "Booking Requested", key: "LBL_BOOKING_ACCEPTED")
                    
                    tripFinishView.descriptionLabel.text = self.generalFunc.getLanguageLabel(origValue: "Your provider has received the booking request and will get back to you shortly. You can check out the status of your request on the \"Your Jobs\" menu item.", key: "LBL_BOOKING_SUCESS_NOTE")
                    tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "View On Going Trips", key: "LBL_VIEW_BOOKINGS")
                    
                }else{
                    
                    tripFinishView.titleLabel.text =  self.generalFunc.getLanguageLabel(origValue: "Booking Finished", key: "LBL_BOOKING_ACCEPTED")
                    if(deliveryBooking == true){
                        tripFinishView.descriptionLabel.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_BOOKED")
                    }else{
                        tripFinishView.descriptionLabel.text = self.generalFunc.getLanguageLabel(origValue: "Your trip has been successfully booked.", key: "LBL_BOOKING_FINISHE_NOTE")
                    }
                    tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_BOOKINGS")
                }
                tripFinishView.negativeBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                
                tripFinishView.negativeBtn.handleClick { (btn) in
                    self.cancelMyBookingView()
                }
                tripFinishView.positiveBtn.handleClick { (btn) in
                    self.viewBookings()
                    handler()
                }
                
                
                height = height + tripFinishView.descriptionLabel.text!.height(withConstrainedWidth: width - 30, font: UIFont(name: Fonts().light, size: 15)!)
                
            }else  {
                
                Utils.createRoundedView(view: tripFinishView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
                tripFinishView.titleLabel.text = title
                tripFinishView.descriptionLabel.text = desc
                tripFinishView.descriptionLabel.fit()
                tripFinishView.frame.size = CGSize(width: width, height: height )
                tripFinishView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
                
                
                
                tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "OK THANKS", key: "LBL_OK_THANKS")
                
                if isFromTip{
                    tripFinishView.positiveBtn.isHidden = true
                    tripFinishView.okTipBtn.isHidden = false
                    tripFinishView.okTipBtn.text = self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT")
                    tripFinishView.okTipBtn.handleClick { (btn) in
                        self.closeView()
                        handler()
                    }
                    tripFinishView.okTipBtn.backgroundColor = SColors.Theme
                }
                
                tripFinishView.positiveBtn.handleClick { (btn) in
                    self.closeView()
                    handler()
                }
                if isFromBid {
//                    tripFinishView.negativeBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased()
//                    tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_BIDDINGS").uppercased()
                    tripFinishView.negativeBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                    tripFinishView.positiveBtn.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_BIDDING_TASK_TEXT")
                    tripFinishView.negativeBtn.handleClick { (btn) in
                        self.cancelMyBookingView()
                    }
                    tripFinishView.positiveBtn.handleClick { (btn) in
                        self.viewBookings()
                        handler()
                    }
                }
                height = height + tripFinishView.descriptionLabel.text!.height(withConstrainedWidth: width - 30, font: UIFont(name: Fonts().light, size: 15)!)
            }
            
            
            if height > Application.screenSize.height - 80 {
                height = Application.screenSize.height - 100
            }
            tripFinishView.frame.size = CGSize(width: width, height: height)
            tripFinishView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
            
            tripFinishView.positiveBtn.isUserInteractionEnabled = true
            tripFinishView.positiveBtn.backgroundColor = SColors.Theme
        }
    }
    
    @objc func cancelMyBookingView(){
      
         closeView()
        if isFromBid {
           // self.uv.navigationController!.popToRootViewController(animated: true)
            let window = Application.window
            
            let getUserData = GetUserData(uv: self.uv, window: window!)
            getUserData.getdata()
            return
            return
        }
        if(isFromUFXCheckOut == true){
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if (userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES" && userProfileJson.get("UBERX_PARENT_CAT_ID") != "0") {
                let window = Application.window
                
                let getUserData = GetUserData(uv: self.uv, window: window!)
                getUserData.getdata()
                return
                
            }
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                self.uv.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            }else{
                self.uv.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
            }
            
        }
        
        if self.viewLoadForDelivery == true{
            if self.uv.isKind(of: MainScreenUV.self)
            {
                (self.uv as! MainScreenUV).releaseAllTask()
                let window = Application.window
                
                let getUserData = GetUserData(uv: self.uv, window: window!)
                getUserData.getdata()
                return
            }
            
        }
        
        if(ServiceModule.rideDeliveryUbexProduct){
            if(self.uv.isKind(of: MainScreenUV.self)){
                (self.uv as! MainScreenUV).releaseAllTask()
            }
            if(isUnwindToHome){
                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.uv.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.uv.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }
        }
    }
    
    @objc func viewBookings(){
        closeView()
    
        var BOOKINGS_SECTION = false
        var ORDER_SECTION = false
        var BIDDING_SECTION = false
        
        if(ServiceModule.rideM || ServiceModule.deliveryM || ServiceModule.ufxM || ServiceModule.vcM){
            BOOKINGS_SECTION = true
        }
        
        if(ServiceModule.deliverallM || ServiceModule.runnerM || ServiceModule.genieM){
            ORDER_SECTION = true
        }
        
        if(ServiceModule.biddingM){
            BIDDING_SECTION = true
        }
        
        var mArray = [Bool]()
        if(BOOKINGS_SECTION == true){ mArray.append(BOOKINGS_SECTION) }
        if(ORDER_SECTION == true){ mArray.append(ORDER_SECTION) }
        if(BIDDING_SECTION == true){ mArray.append(BIDDING_SECTION) }
      
        if(mArray.count > 1){
            if(ufxDriverAcceptedReqNow == true){
                let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                rideOrderHistoryTabUV.isFromViewProfile = true
                rideOrderHistoryTabUV.viewLoadForDelivery = self.viewLoadForDelivery
                rideOrderHistoryTabUV.isFromUFXCheckOut = isFromUFXCheckOut
                if isFromBid {
                    rideOrderHistoryTabUV.isFromBidding = true
                }
                if(self.uv.isKind(of: MainScreenUV.self)){
                    (self.uv as! MainScreenUV).releaseAllTask()
                    rideOrderHistoryTabUV.isOpenFromMainScreen = true
                }
                self.uv.push(uv: rideOrderHistoryTabUV)
            }else{
                let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                rideOrderHistoryTabUV.isFromViewProfile = true
                rideOrderHistoryTabUV.isOpenFromMainScreen = true
                rideOrderHistoryTabUV.isFromUFXCheckOut = isFromUFXCheckOut
                if isFromBid {
                rideOrderHistoryTabUV.isFromBidding = true
                }
                if(self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() == "YES"){
                    rideOrderHistoryTabUV.isDirectPush = true
                }
                self.uv.push(uv: rideOrderHistoryTabUV)
            }
        }else{
            if(ufxDriverAcceptedReqNow == true){
                let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                //rideHistoryUV.homeTabBar = self.homeTabBar
                rideHistoryUV.isFromViewProfile = true
                rideHistoryUV.viewLoadForDelivery = self.viewLoadForDelivery
                rideHistoryUV.isFromUFXCheckOut = isFromUFXCheckOut
               
                rideHistoryUV.navItem = self.uv.navigationItem
                if(self.uv.isKind(of: MainScreenUV.self)){
                    (self.uv as! MainScreenUV).releaseAllTask()
                    rideHistoryUV.isOpenFromMainScreen = true
                }
                self.uv.push(uv: rideHistoryUV)
            }else{
                let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                //rideHistoryUV.homeTabBar = self.homeTabBar
                rideHistoryUV.isFromViewProfile = true
                rideHistoryUV.isOpenFromMainScreen = true
                rideHistoryUV.isFromUFXCheckOut = isFromUFXCheckOut
              //  rideHistoryUV.navItem = self.uv.navigationItem
                if(self.userProfileJson.get("RIDE_LATER_BOOKING_ENABLED").uppercased() == "YES"){
                    rideHistoryUV.isDirectPush = true
                }
                self.uv.push(uv: rideHistoryUV)
            }
        }
         
    }
    
    func closeView(){
        tripFinishView.frame.origin.y = Application.screenSize.height + 2500
        tripFinishView.removeFromSuperview()
        bgView.removeFromSuperview()
    }
    func myBtnTapped(sender: MyButton) {
        if isNewDialouge {
            tripFinishView.removeFromSuperview()
            bgView.removeFromSuperview()
            
            if sender == tripFinishView.btnPositive{
                if isFromMyRide{
                    let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideTabUV") as! MyRideTabUV
                    myRideUV.isfromPulished = true
                    self.uv.push(uv: myRideUV)
                    return
                }else if isFromMyBookRide{
                    let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideTabUV") as! MyRideTabUV
                    myRideUV.isfromBooking = true
                    self.uv.push(uv: myRideUV)
                    return
                }else if isFromNewPost{
                        let rentItemListUV = GeneralFunctions.instantiateViewController(pageName: "RentItemListUV") as! RentItemListUV
                        rentItemListUV.eType = self.eType
                        rentItemListUV.isFromMyList = true
                        self.uv.push(uv: rentItemListUV)
                        return
                }
                else{
                    let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                    manageWalletUV.isFromReedem = true
                    self.uv.push(uv: manageWalletUV)
                }
            }else if sender == tripFinishView.btnNegative{
                if isFromMyBookRide || isFromMyRide{
                    self.uv.navigationController?.popToRootViewController(animated: true)
                    return
                }
                self.uv.navigationController?.popViewController(animated: true)
            }
        }
        
    }
}

enum cancelButonPosition {
    case right
    case bottom
}
