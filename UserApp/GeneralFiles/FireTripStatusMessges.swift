

import UIKit
import GoogleMaps
import AVFoundation
import GoogleSignIn
import Firebase
import Fabric
import IQKeyboardManagerSwift
import FBSDKCoreKit
import SysBaseLib
import AVFoundation
import ActivityKit

class FireTripStatusMessges: NSObject,AVAudioPlayerDelegate {
    
    var isFromPubSub = false
    let generalFunc = GeneralFunctions()
    
    var mainScreenUv:MainScreenUV!
    var ufxHomeScreenUv:UFXHomeUV!
    var myOnGoingTripDetailsUv:MyOnGoingTripDetailsUV!
    var trackingLiveUV:TrackingLiveUV!
    var trackingListUV:TrackingListUV!
    var trackAnySignupUV:TrackAnySignupUV!
    
    
    var orderListUV:OrdersListUV!
    var liveTrackUV:LiveTrackUV!
    var delAllUfxHomeScreenUv:DelAllUFXHomeUV!
    
    var ufxAdditionChargeUV:UFXAdditionalChargesUV!
    var rideHistoryUV:RideHistoryUV!
    var rideOrderHistoryTabUV:RideOrderHistoryTabUV!
    var biddingDetaisUV:BiddingDetialsUV!
    var ufxCheckOutUv:UFXCheckOutUV!
    var iDriverId = ""
    var liveTripId = ""
    
    var tmp_msg = ""
    
    var videoCallUV:VideoCallUV!
    var audioPlayer:AVAudioPlayer?
    
    func fireTripMsg(_ messageStr:String, _ isFromPubSub:Bool, _ receivedBy:String){
        self.isFromPubSub = isFromPubSub
        
        tmp_msg = GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_PUSH_MESSAGE") ? GeneralFunctions.getValue(key: "OLD_PUSH_MESSAGE") as! String : ""
        if(tmp_msg == messageStr){
            return
        }
        GeneralFunctions.saveValue(key: "OLD_PUSH_MESSAGE", value: messageStr as AnyObject)
        
    
        let result = messageStr.toDict()
        
        if(result.count != 0){
            let isMsgExist = GeneralFunctions.isTripStatusMsgExist(msgDataDict: result, isFromPubSub: isFromPubSub)
            
            Utils.printLog(msgData: "isMsgExist:\(isMsgExist)")
            if(isMsgExist == true){
                return
            }
        
        var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
        
        if(viewController != nil){
            viewController = GeneralFunctions.getVisibleViewController(viewController, isCheckAll: true)
        }
        if(viewController != nil && viewController!.isKind(of: MainScreenUV.self)){
            self.mainScreenUv = (viewController as! MainScreenUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: MainScreenUV.self)){
                    self.mainScreenUv = (currentViewCOntroller as! MainScreenUV)
                    self.myOnGoingTripDetailsUv = nil
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: TrackingLiveUV.self)){
            self.trackingLiveUV = (viewController as! TrackingLiveUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: TrackingLiveUV.self)){
                    self.trackingLiveUV = (currentViewCOntroller as! TrackingLiveUV)
                    break
                }
            }
        }
           
        if(viewController != nil && viewController!.isKind(of: MyOnGoingTripDetailsUV.self)){
            self.myOnGoingTripDetailsUv = (viewController as! MyOnGoingTripDetailsUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: MyOnGoingTripDetailsUV.self)){
                    self.myOnGoingTripDetailsUv = (currentViewCOntroller as! MyOnGoingTripDetailsUV)
                    self.mainScreenUv = nil
                    break
                }
            }
        }
          
        if(viewController != nil && viewController!.isKind(of: MyOnGoingTripDetailsUV.self)){
            self.myOnGoingTripDetailsUv = (viewController as! MyOnGoingTripDetailsUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: MyOnGoingTripDetailsUV.self)){
                    self.myOnGoingTripDetailsUv = (currentViewCOntroller as! MyOnGoingTripDetailsUV)
                    self.mainScreenUv = nil
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: OrdersListUV.self)){
            self.orderListUV = (viewController as! OrdersListUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: OrdersListUV.self)){
                    self.orderListUV = (currentViewCOntroller as! OrdersListUV)
                    //self.myOnGoingTripDetailsUv = nil
                    break
                }
            }
        }
        
        if(viewController != nil && viewController!.isKind(of: LiveTrackUV.self)){
            self.liveTrackUV = (viewController as! LiveTrackUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: LiveTrackUV.self)){
                    self.liveTrackUV = (currentViewCOntroller as! LiveTrackUV)
                    //  self.mainScreenUv = nil
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: RideOrderHistoryTabUV.self)){
            self.rideOrderHistoryTabUV = (viewController as! RideOrderHistoryTabUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: RideOrderHistoryTabUV.self)){
                    self.rideOrderHistoryTabUV = (currentViewCOntroller as! RideOrderHistoryTabUV)
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: RideHistoryUV.self)){
            self.rideHistoryUV = (viewController as! RideHistoryUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: RideHistoryUV.self)){
                    self.rideHistoryUV = (currentViewCOntroller as! RideHistoryUV)
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: UFXAdditionalChargesUV.self)){
            self.ufxAdditionChargeUV = (viewController as! UFXAdditionalChargesUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: UFXAdditionalChargesUV.self)){
                    self.ufxAdditionChargeUV = (currentViewCOntroller as! UFXAdditionalChargesUV)
                    break
                }
            }
        }
            
            if(viewController != nil && viewController!.isKind(of: UFXCheckOutUV.self)){
                        self.ufxCheckOutUv = (viewController as! UFXCheckOutUV)
                    }else if(viewController != nil && viewController!.navigationController != nil){
                        for i in 0..<viewController!.navigationController!.viewControllers.count{
                            let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                                
                            if(currentViewCOntroller.isKind(of: UFXCheckOutUV.self)){
                                self.ufxCheckOutUv = (currentViewCOntroller as! UFXCheckOutUV)
                                break
                            }
                        }
                    }
            
            
        if(viewController != nil && viewController!.isKind(of: VideoCallUV.self)){
            self.videoCallUV = (viewController as! VideoCallUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: VideoCallUV.self)){
                    self.videoCallUV = (currentViewCOntroller as! VideoCallUV)
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: TrackAnySignupUV.self)){
            self.trackAnySignupUV = (viewController as! TrackAnySignupUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: TrackAnySignupUV.self)){
                    self.trackAnySignupUV = (currentViewCOntroller as! TrackAnySignupUV)
                    break
                }
            }
        }
      
        if(viewController != nil && viewController!.isKind(of: TrackingListUV.self)){
            self.trackingListUV = (viewController as! TrackingListUV)
        }else if(viewController != nil && viewController!.navigationController != nil){
            for i in 0..<viewController!.navigationController!.viewControllers.count{
                let currentViewCOntroller = viewController!.navigationController!.viewControllers[i]
                
                if(currentViewCOntroller.isKind(of: TrackingListUV.self)){
                    self.trackingListUV = (currentViewCOntroller as! TrackingListUV)
                    break
                }
            }
        }
            
        if(viewController != nil && viewController!.isKind(of: BiddingDetialsUV.self)){
                self.biddingDetaisUV = (viewController as! BiddingDetialsUV)
            }
        
        if(viewController?.navigationController != nil && viewController?.navigationController!.viewControllers.count == 1){
//            viewController = nil
        }
        
        let msg_str = result.get("Message")
        let msg_pub_str = result.get("MsgType")
            if msg_str == "RiderShareBooking"  {
                let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                if(viewController != nil){
                    
                    let userRequestUV = GeneralFunctions.instantiateViewController(pageName: "UserRequestUV") as! UserRequestUV
                    userRequestUV.editData = result.dictOf("notiData")
                   // userRequestUV.passengerJsonDetail_dict = result
                   // userRequestUV.initializedMiliSeconds = Utils.currentTimeMillis()
                    
                    viewController!.closeMenu()
                    
                    GeneralFunctions.removeAllAlertViewFromNavBar(uv: viewController!)
                    
                    //viewController!.push(uv: cabRequestedUV)
                    DispatchQueue.main.async() {
                        if(viewController!.navigationController == nil){
                            let navController = UINavigationController(rootViewController: userRequestUV)
                            //navController.navigationBar.isTranslucent = false
                            viewController!.present(navController, animated: false, completion: nil)
                        }else{
                            viewController!.navigationController?.pushViewController(userRequestUV, animated: false)
                        }
                    }
                   
                    
                }
                
                return
            }
        if(msg_pub_str != "" && msg_pub_str == "CHAT"){
            
            if(Application.window != nil && Application.window?.rootViewController != nil){
                if(GeneralFunctions.getVisibleViewController(Application.window!.rootViewController) != nil && GeneralFunctions.getVisibleViewController(GeneralFunctions.getVisibleViewController(nil, isCheckAll: true), isCheckAll: true)?.className != "MessagesViewController"){
                    
                    self.manageChatScreen(notification: result)
                    return
                    
                }else if(GeneralFunctions.getVisibleViewController(GeneralFunctions.getVisibleViewController(nil, isCheckAll: true), isCheckAll: true)?.className == "MessagesViewController"){
                   
                    if result.get("vSound") != "" {
                    let finalSound = GeneralFunctions.reNameNotificationSound(result.get("vSound"))
                    let tempSoundName = finalSound.split(separator: ".")
                    self.playSound(soundPath: Bundle.main.path(forResource: String(tempSoundName[0]) , ofType: "wav")!)
                    }
                    if GeneralFunctions.getValue(key: "ChatAssignedtripId") as! String != result.get("iTripId")
                    {
                        GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)?.dismiss(animated: false, completion: {self.manageChatScreen(notification: result)})
                        
                        return
                    }
                    
                }
            }
            return
        }
        
        let eType = result.get("eType")
        var contentMsg = result.get("vTitle")
        let driverName = result.get("driverName")
        let vRideNo = result.get("vRideNo")
        let iTripId = result.get("iTripId")
        let biddingId = result.get("iBiddingPostId")
        
            
            if eType == "Bidding" {
                
                if msg_str == "BiddingTaskFinished" {
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        //self.biddingDetaisUV.getData()
                        viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                        let ratingUV = GeneralFunctions.instantiateViewController(pageName: "RatingUV") as! RatingUV
                        ratingUV.iTripId = biddingId
                        ratingUV.isBidding = true
                        viewController!.push(uv: ratingUV, isDirect: true)
                    })
                    
                }else if msg_str == "BiddingTaskAccepted" ||  msg_str == "BiddingTaskReoffered" {
                    if self.biddingDetaisUV == nil {
                        self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            let biddingDetials = GeneralFunctions.instantiateViewController(pageName: "BiddingDetialsUV") as! BiddingDetialsUV
                            biddingDetials.biddingPostId = biddingId
                            let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                            
                            if viewController != nil{
                                
                                viewController?.push(uv: biddingDetials, isDirect: true)
                            }else{
                                Application.window!.rootViewController?.push(uv: biddingDetials, isDirect: true)
                            }
                        })
                    }else{
                        self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            self.biddingDetaisUV.getData()
                        })
                    }
                }
                else {
                viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                if myOnGoingTripDetailsUv != nil {
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        self.myOnGoingTripDetailsUv.dataArrList.removeAll()
                        self.myOnGoingTripDetailsUv.tableView.reloadData()
                        self.myOnGoingTripDetailsUv.biddingId = biddingId
                        self.myOnGoingTripDetailsUv.getData()
                    })
                }else  if msg_str == "BiddingTaskArrived" || msg_str == "BiddingTaskStarted" || msg_str == "BiddingTaskOngoing" {
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
//                        self.myOnGoingTripDetailsUv.dataArrList.removeAll()
//                        self.myOnGoingTripDetailsUv.tableView.reloadData()
//                        self.myOnGoingTripDetailsUv.biddingId = biddingId
//                        self.myOnGoingTripDetailsUv.getData()
                        let chatUv = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                        chatUv.isBidding = true
                        chatUv.biddingId = biddingId
                        let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                        
                        if viewController != nil{
                            
                            viewController?.push(uv: chatUv, isDirect: false)
                        }else{
                            Application.window!.rootViewController?.push(uv: chatUv, isDirect: true)
                        }
                    })
                }
                else if  self.biddingDetaisUV != nil {
                 
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        self.biddingDetaisUV.getData()
                    })
                }else{
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        //self.biddingDetaisUV.getData()
                    })
                }

                }
                }
               
               
                
            if(msg_pub_str == "TrackMemberPaired" && self.trackAnySignupUV != nil){
                
                self.trackAnySignupUV.setSuccessView()
                return
            }
            
            if(msg_pub_str == "TrackMemberRemoved" && self.trackingListUV != nil){
                
                self.trackingListUV.getTrackingList()
                return
            }
        
            
            if liveTrackUV != nil
            {
                if(msg_pub_str == "LocationUpdateOnTrip"){
                    let iDriverId = result.get("iDriverId")
                    let vLatitude = result.get("vLatitude")
                    let vLongitude = result.get("vLongitude")
                    
                    if iDriverId == self.liveTrackUV.assignedDriverId
                    {
                        self.liveTrackUV.driverLocation = CLLocation(latitude: Double(vLatitude)!, longitude: Double(vLongitude)!)
                        self.liveTrackUV.updateAssignedDriverMarker(driverLocation:self.liveTrackUV.driverLocation, dataDict: nil)
                    }
                    return
                    
                }else{
                    if result.get("iOrderId") == self.liveTrackUV.orderId
                    {
                        if contentMsg != ""
                        {
                            self.liveTrackUV.showCancelView = true
                            
                            self.liveTrackUV.orderStatusMessage = contentMsg
                            self.generalFunc.setAlertMessage(uv: self.liveTrackUV, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                self.liveTrackUV.getData()
                            })
                        }
                        return
                        
                    }else
                    {
                        if contentMsg != ""
                        {
                            if(Application.window != nil && Application.window?.rootViewController != nil && GeneralFunctions.getMemberd() != ""){
                                (GeneralFunctions()).setError(uv: nil, title: "", content: contentMsg)
                            }
                        }
                        return
                    }
                    
                }
                
            }else if msg_str == "OrderDelivered" {
                
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                   // self.liveTrackUV.getData()
                    
                    let liveTracKUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                    
                    liveTracKUv.orderId = result.get("iOrderId")
                    liveTracKUv.showCancelView = true
                    let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                    
                    if viewController != nil{
                        
                        viewController?.push(uv: liveTracKUv, isDirect: false)
                    }else{
                        Application.window!.rootViewController?.push(uv: liveTracKUv, isDirect: false)
                    }
                })
               
            }else if msg_str == "OrderConfirmByRestaurant" {
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_DETAILS"), completionHandler: { (btnClickedIndex) in
                  
                    if btnClickedIndex == 1 {
                    let liveTracKUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                    
                    liveTracKUv.orderId = result.get("iOrderId")
                    liveTracKUv.showCancelView = false
                    let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                    
                    if viewController != nil{
                        
                        viewController?.push(uv: liveTracKUv, isDirect: false)
                    }else{
                        Application.window!.rootViewController?.push(uv: liveTracKUv, isDirect: false)
                    }
                }
                })
                return
            }
            else
            {
                if(msg_str == "OrderCancelByAdmin" || msg_str == "OrderDeclineByRestaurant"){
                    
                    if self.orderListUV != nil
                    {
                        self.generalFunc.setAlertMessage(uv: self.orderListUV, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            self.orderListUV.getOrdersList()
                        })
                        
                        
                    }else{
                        if(Application.window != nil && Application.window?.rootViewController != nil && GeneralFunctions.getMemberd() != ""){
                            (GeneralFunctions()).setError(uv: nil, title: "", content: contentMsg)
                        }
                    }
                    return
                    
                }
                
            }
            
            
        if(msg_pub_str == "TwilioVideocall" && result.get("isDecline") != "Yes"){
            
            print("Video Call Generated")
            var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
            
            if(viewController != nil){
                viewController = GeneralFunctions.getVisibleViewController(viewController)
            }
            
            let videoCallUV = GeneralFunctions.instantiateViewController(pageName: "VideoCallUV") as! VideoCallUV
            videoCallUV.isOutGoing = false
            videoCallUV.messageDataDic = result
            
            viewController?.push(uv: videoCallUV, isDirect: true)
            return
        }
            
        if(msg_str == "TwilioVideocall" && result.get("isDecline") == "Yes"){

            if(self.videoCallUV != nil){
                (viewController as! VideoCallUV).callEnd()
            }

            return
        }
            
        if(msg_pub_str == "TrackMember"){
            
            self.trackingListUV?.getTrackingList(false)
            self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                
            })
            return
        }
            // For Cubjek Only
        if(msg_pub_str == "LocationUpdate"){
            let iDriverId = result.get("iDriverId")
            let vLatitude = result.get("vLatitude")
            let vLongitude = result.get("vLongitude")
            
            DispatchQueue.main.async {
                
                if(self.trackingLiveUV != nil &&  ("ONLINE_TRACKING_LOC_" + self.trackingLiveUV.assignedDriverId == result.get("ChannelName"))){
                    DispatchQueue.main.async {
                        self.trackingLiveUV?.updateDriverLocation(iDriverId: iDriverId, latitude: vLatitude, longitude: vLongitude, dataDict: result)
                    }
                    return
                }
                
                self.mainScreenUv?.updateDriverLocationBeforeTrip(iDriverId: iDriverId, latitude: vLatitude, longitude: vLongitude, dataDict: result)
                
            }
            
        }else if(msg_pub_str == "TripRequestCancel"){
            if self.mainScreenUv != nil {
            self.mainScreenUv?.incCountOfRequestToDriver()
            }
           
                if self.ufxCheckOutUv != nil {
                    if result.get("isDecline") == "Yes" {
                        self.ufxCheckOutUv?.isCancelTrip = true
                    }else{
                        self.ufxCheckOutUv?.isCancelTrip = false
                }
                    self.ufxCheckOutUv?.stopDriverRequestQueue()
                    self.ufxCheckOutUv?.noDriverAvailView(isHidden: false)
            }
            
         
        }else if(msg_pub_str == "LocationUpdateOnTrip"){
            let iDriverId = result.get("iDriverId")
            let vLatitude = result.get("vLatitude")
            let vLongitude = result.get("vLongitude")
            
            if(self.myOnGoingTripDetailsUv != nil){
                DispatchQueue.main.async {
                    self.myOnGoingTripDetailsUv?.updateDriverLocation(iDriverId: iDriverId, latitude: vLatitude, longitude: vLongitude)
                }
            }else if(self.trackingLiveUV != nil){
                DispatchQueue.main.async {
                    self.trackingLiveUV?.updateDriverLocation(iDriverId: iDriverId, latitude: vLatitude, longitude: vLongitude, dataDict: result)
                }
            }else if(self.mainScreenUv != nil){
                DispatchQueue.main.async {
                    
                    self.mainScreenUv?.updateDriverLocation(iDriverId: iDriverId, latitude: vLatitude, longitude: vLongitude, dataDict: result)
                }
            }
            
        }else if(msg_pub_str == "DriverArrived"){
            
            if(eType == Utils.cabGeneralType_UberX){
                if(self.myOnGoingTripDetailsUv != nil){
                    if(contentMsg == ""){
                        contentMsg = "\(generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROVIDER")) \(driverName)  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_ARRIVED_NOTIMSG")) \(vRideNo)"
                    }
                    self.generalFunc.setAlertMessage(uv: self.myOnGoingTripDetailsUv, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                    })
                }else{
                    if(contentMsg == ""){
                        contentMsg = "\(generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_DRIVER_TXT")) \(driverName)  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_ARRIVED_NOTIMSG")) \(vRideNo)"
                    }
                    //                    (self.mainScreenUv == nil ? (self.myOnGoingTripDetailsUv == nil ? self.ufxHomeScreenUv : self.myOnGoingTripDetailsUv) : self.mainScreenUv)
                    self.generalFunc.setAlertMessage(uv: viewController, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                    })
                }
            }else{
                if(contentMsg == ""){
                    if(eType == Utils.cabGeneralType_Ride){
                        contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_ARRIVED_NOTIFY_TXT")
                    }else{
                        contentMsg = "\(generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_DRIVER_TXT")) \(driverName)  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_ARRIVED_NOTIMSG")) \(vRideNo)"
                    }
                }
                //                (self.mainScreenUv == nil ? (self.myOnGoingTripDetailsUv == nil ? self.ufxHomeScreenUv : self.myOnGoingTripDetailsUv) : self.mainScreenUv)
                self.generalFunc.setAlertMessage(uv: viewController, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                })
            }
            
            if(self.mainScreenUv != nil && eType != Utils.cabGeneralType_UberX){
                DispatchQueue.main.async {
                    self.mainScreenUv?.setDriverArrivedStatus()
                }
            }else if(self.myOnGoingTripDetailsUv != nil){
                let iDriverId = result.get("iDriverId")
                
                DispatchQueue.main.async {
                    self.myOnGoingTripDetailsUv?.setDriverArrivedStatus(iDriverId: iDriverId)
                }
                
            }
            
        }else if(msg_pub_str == "Notification"){
            self.generalFunc.setAlertMessage(uv: viewController, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
            })
        }else if(msg_str != ""){
            
            if(msg_str == "TripStarted"){
                if(contentMsg == ""){
                    if(eType == Utils.cabGeneralType_Ride){
                        contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_START_TRIP_DIALOG_TXT")
                    }else{
                        contentMsg = "\(generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_DRIVER_TXT")) \(driverName)  \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_START_NOTIMSG")) \(vRideNo)"
                    }
                }
                //               (self.mainScreenUv == nil ? (self.myOnGoingTripDetailsUv == nil ? self.ufxHomeScreenUv : self.myOnGoingTripDetailsUv) : self.mainScreenUv)
                self.generalFunc.setError(uv: viewController, title: "", content:  contentMsg)
                
            }else if(msg_str == "TripCancelledByDriver" || msg_str == "TripEnd" || msg_str == "TripCancelled"){
                if(contentMsg == ""){
                    
                    if(msg_str == "TripCancelledByDriver"){
                        contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PREFIX_TRIP_CANCEL_DRIVER") + " " + result.get("Reason") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TRIP_BY_DRIVER_MSG_SUFFIX")
                        
                    }else{
                        if(eType == Utils.cabGeneralType_Ride){
                            contentMsg = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_END_TRIP_DIALOG_TXT")
                        }else{
                            contentMsg = "\(driverName) \(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_END_NOTIMSG")) \(vRideNo)"
                        }
                    }
                }
                
                
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: EventService.TRIP_COMPLETE_NOTI_OBSERVER_KEY), object: self, userInfo: ["body":String(describing: result.toJsonStr())])
                
                var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                
                if(viewController != nil){
                    viewController = GeneralFunctions.getVisibleViewController(viewController)
                }
                
                if result.get("Is_Last_Delivery") == "Yes" && eType == "Multi-Delivery"
                {
                    self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0
                        {
                
                            if(viewController != nil && viewController?.className != "RideMultiDetailUV"){
                                let rideDetailUV = GeneralFunctions.instantiateViewController(pageName: "RideDetailUV") as! RideDetailUV
                                if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                                    GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                                }
                               rideDetailUV.iTripId = iTripId
                                if self.mainScreenUv != nil{
                                    if (self.mainScreenUv.liveTrackTripId != ""){
                                        rideDetailUV.mainScreenUv = self.mainScreenUv
                                    }
                                }
                                
                                viewController!.push(uv: rideDetailUV, isDirect: true)
                                return
                                
                                
//                                let rideMultiDetailUV = GeneralFunctions.instantiateViewController(pageName: "RideMultiDetailUV") as! RideMultiDetailUV
//
//                                if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
//                                    GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
//                                }
//                                rideMultiDetailUV.endedDeliveryTripId = iTripId
//                                if self.mainScreenUv != nil{
//                                    if (self.mainScreenUv.liveTrackTripId != ""){
//                                        rideMultiDetailUV.mainScreenUv = self.mainScreenUv
//
//                                    }
//                                }
//
//                                viewController!.push(uv: rideMultiDetailUV, isDirect: true)
//                                return
                            }
                        }else{
                            
                            
                            if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                                GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                            }
                            
                            if self.mainScreenUv != nil{
                                if (self.mainScreenUv.liveTrackTripId != "")
                                {
                                    self.mainScreenUv.liveTrackTripId = ""
//                                    self.mainScreenUv.performSegue(withIdentifier: "unwindToMyOnGoingTripsScreen", sender: self)
                                    self.mainScreenUv.performSegue(withIdentifier: "unwindToRideHistoryScreen", sender: self)
                                }
                            }
                         
                        }
                    })
                    if(eType != Utils.cabGeneralType_UberX){
                        
                        if(eType != "Multi-Delivery")
                        {
                            GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            
                            
                        }
                        
                        //viewController = nil
                    }else{
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                    
                    return
                }
                else
                {
                    if eType != "Multi-Delivery"
                    {
                        viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                        self.generalFunc.setAlertMessage(uv: viewController == nil ? nil : viewController, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            if(eType != Utils.cabGeneralType_UberX){
                                let window = Application.window
                                //                        (self.mainScreenUv == nil ? (self.myOnGoingTripDetailsUv == nil ? self.ufxHomeScreenUv : self.myOnGoingTripDetailsUv) : self.mainScreenUv)
                                let getUserData = GetUserData(uv: viewController, window: window!)
                                getUserData.getdata()
                            }else{
                                if(viewController != nil && (msg_str == "TripEnd" || (msg_str == "TripCancelledByDriver" && result.get("ShowTripFare").uppercased() == "TRUE"))){
                            
                                if(eType == Utils.cabGeneralType_UberX && viewController!.isKind(of: MyOnGoingTripDetailsUV.self)){
                                   let myOnGoingTripDetailsUv_tmp = viewController as! MyOnGoingTripDetailsUV
                                
                                   if(myOnGoingTripDetailsUv_tmp.dataDict.get("iTripId") == iTripId){
                                    myOnGoingTripDetailsUv_tmp.releaseAllTask()
                                   }
                                  }
                            
                                 let ratingUV = GeneralFunctions.instantiateViewController(pageName: "RatingUV") as! RatingUV
                                 ratingUV.iTripId = iTripId
                                 viewController!.push(uv: ratingUV, isDirect: true)
                                }
                             }
                        })
                       
                        return
                    }else
                    {
                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            if self.mainScreenUv != nil
                            {
                                
                                if(GeneralFunctions.isKeyExistInUserDefaults(key: "OLD_USER_PROFILE_MULTI") == true){
                                    GeneralFunctions.saveValue(key:  Utils.USER_PROFILE_DICT_KEY, value: GeneralFunctions.getValue(key: "OLD_USER_PROFILE_MULTI") as AnyObject)
                                }
                                if(self.mainScreenUv.liveTrackTripId != "" && msg_str != "TripCancelledByDriver"){
                                    if self.mainScreenUv.liveTrackTripId == result.get("iTripId")
                                    {
//                                        self.mainScreenUv.performSegue(withIdentifier: "unwindToMyOnGoingTripsScreen", sender: self)
                                        self.mainScreenUv.performSegue(withIdentifier: "unwindToRideHistoryScreen", sender: self)
                                    }
                                    return
                                }else if (msg_str == "TripCancelledByDriver"){
                                    if (self.mainScreenUv.liveTrackTripId != ""){
//                                        self.mainScreenUv.performSegue(withIdentifier: "unwindToMyOnGoingTripsScreen", sender: self)
                                        self.mainScreenUv.performSegue(withIdentifier: "unwindToRideHistoryScreen", sender: self)
                                    }
                                }
                                
                            }else if self.myOnGoingTripDetailsUv != nil
                            {
                                
                                self.myOnGoingTripDetailsUv.dataArrList.removeAll()
                                self.myOnGoingTripDetailsUv.tableView.reloadData()
                                
                                self.myOnGoingTripDetailsUv.getData()
                            }
                            
                        })
                      
                        return
                    }
                    if(eType != Utils.cabGeneralType_UberX){
                        
                        if(eType != "Multi-Delivery")
                        {
                            GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            
                            
                        }
                        
                        //viewController = nil
                    }else{
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                }
                
                
            }else if(msg_str == "VerifyCharges" || msg_str == "VerifyTollCharges"){
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    
                    if(result.get("eType").uppercased() != Utils.cabGeneralType_UberX){
                        
                        if(viewController != nil){
                            viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                            
                            if(self.ufxAdditionChargeUV != nil){
                               
                                self.ufxAdditionChargeUV.tripData = result
                                self.ufxAdditionChargeUV.setData()
                                return
                                
                            }
                        }
                        let uFXAdditionalChargesUV = GeneralFunctions.instantiateViewController(pageName: "UFXAdditionalChargesUV") as! UFXAdditionalChargesUV
                        uFXAdditionalChargesUV.tripData = result
                        uFXAdditionalChargesUV.verifyChargesByNoti = true
                        uFXAdditionalChargesUV.iTripId = result.get("iTripId")
                        viewController?.push(uv: uFXAdditionalChargesUV, isDirect: true)
                        return
                    }
                    
                    var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                    
                    if(viewController != nil){
                        viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                        
                        if(self.ufxAdditionChargeUV != nil){
                           
                            self.ufxAdditionChargeUV.tripData = result
                            self.ufxAdditionChargeUV.setData()
                            return
                            
                        }
                        
                        if(self.myOnGoingTripDetailsUv != nil){
                            
                            self.myOnGoingTripDetailsUv.iTripId = result.get("iTripId")
                            let uFXAdditionalChargesUV = GeneralFunctions.instantiateViewController(pageName: "UFXAdditionalChargesUV") as! UFXAdditionalChargesUV
                            uFXAdditionalChargesUV.tripData = result
                            uFXAdditionalChargesUV.iTripId = result.get("iTripId")
                            viewController?.push(uv: uFXAdditionalChargesUV)
                            return
                            
                        }
                        
                      
                        if(ServiceModule.rideDeliveryUbexProduct){
                            if(self.rideOrderHistoryTabUV != nil){
                                let uFXAdditionalChargesUV = GeneralFunctions.instantiateViewController(pageName: "UFXAdditionalChargesUV") as! UFXAdditionalChargesUV
                                uFXAdditionalChargesUV.tripData = result
                                uFXAdditionalChargesUV.iTripId = result.get("iTripId")
                                viewController?.push(uv: uFXAdditionalChargesUV)
                                return
                            }
                        }else{
                            if(self.rideHistoryUV != nil){
                                 
                                let uv = self.rideHistoryUV
                                let myOnGoingTripDetailsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                                
                                for i in 0 ..< uv!.dataArrList.count{
                                    
                                    let item = uv!.dataArrList[i]
                                    if(item.get("iTripId") == result.get("iTripId")){
                                        myOnGoingTripDetailsUV.iTripId = result.get("iTripId")
                                        myOnGoingTripDetailsUV.dataDict = item
                                        myOnGoingTripDetailsUV.additionChargesDataDic = result
                                        viewController?.push(uv: myOnGoingTripDetailsUV)
                                        return
                                    }
                                }
                            }
                        }
                        
                        
        
                        if(ServiceModule.rideM && ServiceModule.deliveryM && ServiceModule.ufxM) {
                            if (ServiceModule.biddingM || ServiceModule.isAnyDeliverAllOptionEnable()) {
                                let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                                rideOrderHistoryTabUV.isFromViewProfile = true
                                rideOrderHistoryTabUV.isDirectPush = true
                                rideOrderHistoryTabUV.isFromUFXCheckOut = false
                                rideOrderHistoryTabUV.additionChargesDataDic = result
                                viewController?.push(uv: rideOrderHistoryTabUV)
                            }else{
                                let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                                rideHistoryUV.isFromViewProfile = true
                                rideHistoryUV.navItem = viewController?.navigationItem
                                rideHistoryUV.additionChargesDataDic = result
                                viewController?.push(uv: rideHistoryUV)
                            }
                        }else{
                            if (ServiceModule.biddingM) {
                                let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
                                rideOrderHistoryTabUV.isFromViewProfile = true
                                rideOrderHistoryTabUV.isDirectPush = true
                                rideOrderHistoryTabUV.isFromUFXCheckOut = false
                                rideOrderHistoryTabUV.additionChargesDataDic = result
                                viewController?.push(uv: rideOrderHistoryTabUV)
                            }else{
                                let rideHistoryUV = GeneralFunctions.instantiateViewController(pageName: "RideHistoryUV") as! RideHistoryUV
                                rideHistoryUV.isFromViewProfile = true
                                rideHistoryUV.navItem = viewController?.navigationItem
                                rideHistoryUV.additionChargesDataDic = result
                                viewController?.push(uv: rideHistoryUV)
                            }
                        }
                        
                    }
                    
                })
            
            }else if(msg_str == "VerifyChargesDeclined"){
                
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    
                    var viewController = Application.window != nil ? (Application.window!.rootViewController != nil ? (Application.window!.rootViewController!) : nil) : nil
                    
                    if(viewController != nil){
                        viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
                        
                        if(self.ufxAdditionChargeUV != nil){
                           
                            let window = Application.window
                            let getUserData = GetUserData(uv: viewController, window: window!)
                            getUserData.getdata()
                            return
                            
                        }
                    }
                })
                
            }else if(msg_str == "OutstandingGenerated"){
                self.generalFunc.setAlertMessage(uv: nil, title: "", content: contentMsg, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_PAYMENT_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    GeneralFunctions.addPayment(url: result.get("PAYMENT_URL"), uv: nil)
                    
                })
                return
            }
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: Utils.driverCallBackNotificationKey), object: self, userInfo: ["body":String(describing: result.toJsonStr())])
            
              self.startLiveActivity(result: result.dictOf("LiveActivityData"), id: result.get("iTripId"))
            
           }
            
            if(msg_pub_str == "GoPayVerifyAmount"){
                
                (GeneralFunctions()).setError(uv: Application.window!.rootViewController!, title: "", content: result.get("vTitle"))
            }
            
            // FROM ADMIN
            if(msg_pub_str == "" && result.get("vTitle") != ""){
                
                (GeneralFunctions()).setError(uv: Application.window!.rootViewController!, title: "", content: result.get("vTitle"))
            }// .........
            
        }else if(messageStr.trim() != ""){
                if(Application.window != nil && Application.window?.rootViewController != nil ){
                    //&& Utils.isMyAppInBackground() == false
                    (GeneralFunctions()).setError(uv: Application.window!.rootViewController!, title: "", content: messageStr)
                }
        }
    }
    
    func manageChatScreen(notification:NSDictionary)
    {
        let receiverName = notification.get("FromMemberName")
        let receiverId = notification.get("iFromMemberId")
        let tripId = notification.get("iTripId")
        let fromMemberImageName = notification.get("FromMemberImageName")
        
        GeneralFunctions.saveValue(key: "ChatAssignedtripId", value:tripId as AnyObject)
        let chatUv = GeneralFunctions.instantiateViewController(pageName: "MessagesViewController") as! MessagesViewController
        chatUv.receiverId = receiverId
        chatUv.receiverDisplayName = receiverName
        chatUv.assignedtripId = tripId
        chatUv.bookingNo = notification.get("vBookingNo")
        chatUv.pPicName = fromMemberImageName
        
        if notification.get("eType") == "Bidding"{
            chatUv.isBidding = true
            chatUv.assignedtripId = notification.get("iBiddingPostId")
            chatUv.driverId = notification.get("iDriverId")
        }
        let viewController = GeneralFunctions.getVisibleViewController(nil, isCheckAll: true)
        
        if viewController != nil{
            
            viewController?.push(uv: chatUv, isDirect: true)
        }else{
            Application.window!.rootViewController?.push(uv: chatUv, isDirect: true)
        }
        
    }
   
    func playSound(soundPath: String)
    {
        let fileURL = NSURL(fileURLWithPath: soundPath)
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fileURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    
    func startLiveActivity(result:NSDictionary, id:String) {
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
      
        if(userProfileJson.get("ENABLE_NOTIFICATION_LIVE_ACTIVITY").uppercased() == "YES" && (result.get("APP_TYPE").uppercased() == "RIDE" || result.get("APP_TYPE").uppercased() == "DELIVERALL")){
            print("Allow Live Activity")
        }else{
            return
        }
        
        if(result.get("STATUS").uppercased() != "CABREQUESTACCEPTED" && result.get("APP_TYPE").uppercased() == "RIDE"){
            return
        }
        
        Task.init {
            do {
               
                let activityData = result
                print(activityData)
                
                if(activityData.get("APP_TYPE").uppercased() == "RIDE"){
                    let driverImgPath = try await self.downloadImage(from: URL(string: activityData.get("DRIVER_IMG")) ?? nil)
                    let driverCarImgPath = try await self.downloadImage(from: URL(string: activityData.get("VEHICLE_TYPE_IMG")) ?? nil)
                  
                    var driverImgPathStr = ""
                    var driverCarImgPathStr = ""
                    if #available(iOS 16.0, *) {
                        driverImgPathStr = driverImgPath?.path() ?? ""
                        driverCarImgPathStr = driverCarImgPath?.path() ?? ""
                    } else {
                        driverImgPathStr = ""
                        driverCarImgPathStr = ""
                    }
                    
                    let rideAttributes = RideAttributes(DRIVER_IMG: driverImgPathStr , VEHICLE_TYPE_IMG: driverCarImgPathStr)

                   // activityData.get("DISTANCE_STEP")
                    let initialContentState = RideAttributes.RideStatus(APP_TYPE: activityData.get("APP_TYPE"), STATUS: activityData.get("STATUS"),APP_NAME: activityData.get("APP_NAME"), DISTANCE_STEP: activityData.get("DISTANCE_STEP"), DRIVER_IMG: "", DRIVER_LICENSE_PLATE: activityData.get("DRIVER_LICENSE_PLATE"), DRIVER_VEHICLE: activityData.get("DRIVER_VEHICLE"), ETA: activityData.get("ETA"), ETA_SUBTITLE: activityData.get("ETA_SUBTITLE"), ETA_TITLE: activityData.get("ETA_TITLE"), VEHICLE_TYPE_IMG: "")
                    

                    do {
                        if #available(iOS 16.1, *) {
                            let rideActivity = try Activity<RideAttributes>.request(
                                attributes: rideAttributes,
                                contentState: initialContentState,
                                pushType: .token)
                        
                            Task {

                                for await data in rideActivity.pushTokenUpdates {
                                    let myToken = data.map {String(format: "%02x", $0)}.joined()
                                    // Keep this myToken for sending push notifications

                                    DispatchQueue.main.async {
                                        self.updateLiveActivityTokenToServer(token: myToken, orderId: "", tripId: id)
                                        print("pushToken", myToken)
                                    }

                                }

                            }
                        } else {
                            // Fallback on earlier versions
                        }
                        print("Live Activity Started")
                    } catch (let error) {
                        print("Error in Live Activity:\(error)")
                    }
                }else if(activityData.get("APP_TYPE").uppercased() == "DELIVERALL"){
                    
                    let deliverAllAttributes = DeliverAllAttributes(DRIVER_IMG: "")
                    
                    print(activityData.get("STATUS"))
                    let initialCntStateForDeliverAll = DeliverAllAttributes.DeliverAllStatus(APP_TYPE: activityData.get("APP_TYPE"), APP_NAME: activityData.get("APP_NAME"), ORDER_STAGE: activityData.get("ORDER_STAGE"), DISTANCE_STEP: activityData.get("DISTANCE_STEP"), ETA: activityData.get("ETA"), ETA_SUBTITLE: activityData.get("ETA_SUBTITLE"), ETA_TITLE: activityData.get("ETA_TITLE"), STORE_NAME: activityData.get("STORE_NAME"))
                    

                    do {
                        if #available(iOS 16.1, *) {
                            let deliverAllActivity = try Activity<DeliverAllAttributes>.request(
                                attributes: deliverAllAttributes,
                                contentState: initialCntStateForDeliverAll,
                                pushType: .token)
                        
                            Task {

                                for await data in deliverAllActivity.pushTokenUpdates {
                                    let myToken = data.map {String(format: "%02x", $0)}.joined()
                                    // Keep this myToken for sending push notifications

                                    DispatchQueue.main.async {
                                        self.updateLiveActivityTokenToServer(token: myToken, orderId: id, tripId: "")
                                        print("pushToken", myToken)
                                    }

                                }

                            }
                        } else {
                            // Fallback on earlier versions
                        }
                        print("Live Activity Started")
                    } catch (let error) {
                        print("Error in Live Activity:\(error)")
                    }
                }
                
            }catch {
               
            }
        }
        
    }
    
    private func downloadImage(from url: URL?) async throws -> URL? {
        
        if(url == nil){
            return nil
        }
        let bundleID = Bundle.main.bundleIdentifier!
        guard var destination = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: ("group.\(bundleID).LiveActivityData"))
        else {
            return nil
            
        }

        destination = destination.appendingPathComponent(url!.lastPathComponent)
        if #available(iOS 16.0, *) {
            guard !FileManager.default.fileExists(atPath: destination.path()) else {
                print("No need to download \(url!.lastPathComponent) as it already exists.")
                return destination
            }
        } else {
            // Fallback on earlier versions
        }

        if #available(iOS 16.0, *) {
            let (source, _) = try await URLSession.shared.download(from: url!)
            try FileManager.default.moveItem(at: source, to: destination)
            print("Done downloading \(url!.lastPathComponent)!")
            return destination
            
        } else {
            return nil
        }
        
        
    }
    
    func updateLiveActivityTokenToServer(token:String, orderId:String, tripId:String){
        
        let parameters = ["type":"UpdateLiveActivityToken", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "LiveActivityToken":token, "iTripId": tripId, "iOrderId": orderId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                }else{
                    
                    self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }else{
                self.updateLiveActivityTokenToServer(token: token, orderId:orderId, tripId:tripId)
            }
        })
    }
}
