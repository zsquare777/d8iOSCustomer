

import UIKit
import GoogleMaps
import CoreTelephony

class Utils: NSObject {
    
    /* **************************************************************************************** */
    /* fontFName Is Required, You can get Actual Font Family Name which is installed in Project by this method
     print(UIFont.familyNames) */
    
    static let fontFname = "OpenSans"   //* REQUIRED *//   /* Print(UIFont.familyNames) */
    
    /* **************************************************************************************** */
    
    static let deviceType = "Ios"
    
    static var cabGeneralType_Ride = "Ride"
    static var cabGeneralType_Deliver = "Deliver"
    static var cabGeneralType_Ride_Deliver = "Ride-Deliver"
    static var cabGeneralType_UberX = "UberX"
    static var cabGeneralType_Multi_Delivery = "Multi-Delivery"
    static var cabGeneralType_Ride_Delivery_UberX = "Ride-Delivery-UberX"
    static let Cab_UberX_Type_Map = "MAP"
    static let Cab_UberX_Type_List = "LIST"
    static let SERVICE_CATEGORY_ARRAY = "SERVICE_CATEGORY_ARRAY"
    static let SERVICE_CATEGORY_ID = "SERVICE_CATEGORY_ID"
    static let DEFAULT_SERVICE_CATEGORY_ID = "DEFAULT_SERVICE_CATEGORY_ID"
    
     //# MultiDelivery Changes
    static let MULTI_DELIVERY_ENABLED = "MULTI_DELIVERY_ENABLED"
    static let MULTI_DELIVERY_DETAIL_STORED = "MULTI_DELIVERY_DETAIL_STORED" // Bool
    static let DELIVERY_DETAIL_DATA = "DELIVERY_DETAIL_DATA"
    
    static let CART_INFO_DATA = "CART_INFO_DATA"
    
    static let vTripStatusParams_1 = "NONE"
    static let vTripStatusParams_2 = "Requesting"
    static let vTripStatusParams_3 = "Active"
    static let vTripStatusParams_4 = "On Going Trip"
    static let vTripStatusParams_5 = "Not Active"
    
    static let AppServicesObserver = "AppServicesObserver"
    
    static let apnIDNotificationKey = "in.ubClone.ApnId"
    static let driverCallBackNotificationKey = "in.ubClone.DriverCallBack"
    static let appBGNotificationKey = "in.ubClone.appBG"
    static let appFGNotificationKey = "in.ubClone.appFG"
    static let tripMsgNotificationKey = "in.ubClone.TRIP.MESSAGE"
    
    static let USER_NOTIFICATION = "USER_NOTIFICATION"
    static let VOIP_NOTIFICATION = "VOIP_NOTIFICATION"
    
    static let LANGUAGE_OPTIONAL_KEY = "LANGUAGE_OPTIONAL"
    static let CURRENCY_OPTIONAL_KEY = "CURRENCY_OPTIONAL"
    
    static let PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_DRIVER = "ONLINE_DRIVER_LOC_"
    
    static let PUBNUB_UPDATE_LOC_CHANNEL_PREFIX_TRACKING = "ONLINE_TRACKING_LOC_"
    
    //    static let rtlLangTypeKey = "isRTL"
    static let googleMapLangCodeKey = "GOOGLE_MAP_LNG_CODE"
    static let deviceTokenKey = "DEVICE_TOKEN"
    
    static let APP_GCM_SENDER_ID_KEY = "GCM_SENDER_ID"
    
    static let PUBSUB_TECHNIQUE_KEY = "PUBSUB_TECHNIQUE"
    
    static let GOOGLE_IOS_PASSENGER_APP_GEO_KEY = "GOOGLE_IOS_GEO_KEY"
    static let GOOGLE_SERVER_IOS_PASSENGER_APP_KEY = "GOOGLE_SERVER_KEY"
    
    static let ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP_KEY = "ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP"
    
    static let SC_CONNECT_URL_KEY = "SC_CONNECT_URL"
    
    static let isUserLogIn = "IsUserLoggedIn"
    static let iMemberId_KEY = "iUserId"
    
    static let action_str = "Action"
    static let message_str = "message"
    static let appUserType = "Passenger"
    
    static let appName = "Passenger App"
    
    static let dailyRideCategoryType = "DAILYRIDES"
    static let rentalCategoryType = "RENTAL"
    
    
    static let defaultZoomLevel:Float = 16.5
    
    static let SESSION_OUT_VIEW_TAG = 91 // should not be -1
    static let SESSION_OUT_COVER_VIEW_TAG = 92 // should not be -1
    
    static let DATABASE_RTL_STR = "rtl"
    static let dateForateDateWithDay = "dd MMM, yyyy (EEE)"
    static let dateFormateInHeaderBar = "EEE, MMM d, yyyy"
    static let dateFormateInList = "dd-MMM-yyyy"
    static let dateFormateTimeOnly = "h:mm a"
    static let dateFormateWithTime = "EEE, MMM dd, yyyy' \(GeneralFunctions().getLanguageLabel(origValue: "at", key: "LBL_AT_TXT")) 'h:mm a"
    static let dateForateDateWithDayAndTime = "dd MMM, yyyy (EEE),  h:mm a"
    static let languageLabelsKey = "LanguageLabel"
    static let FACEBOOK_APPID_KEY = "FACEBOOK_APPID"
    static let LINK_FORGET_PASS_KEY = "LINK_FORGET_PASS_PAGE_PASSENGER"
    static let MOBILE_VERIFICATION_ENABLE_KEY = "MOBILE_VERIFICATION_ENABLE"
    static let LANGUAGE_LIST_KEY = "LANGUAGELIST"
    static let CURRENCY_LIST_KEY = "CURRENCYLIST"
    static let DEFAULT_LANGUAGE_TITLE_KEY = "DEFAULT_LANG_TITLE"
    static let DEFAULT_CURRENCY_TITLE_KEY = "DEFAULT_CURRENCY_TITLE"
    static let ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD = "ENABLE_PHONE_LOGIN_VIA_COUNTRY_SELECTION_METHOD"
    static let ENABLE_EMAIL_OPTIONAL = "ENABLE_EMAIL_OPTIONAL"
    
    static let LANGUAGE_CODE_KEY = "LANG_CODE"
    static let LANGUAGE_IS_RTL_KEY = "LANG_IS_RTL"
    static let GOOGLE_MAP_LANGUAGE_CODE_KEY = "GOOGLE_MAP_LANG_CODE"
    static let REFERRAL_SCHEME_ENABLE = "REFERRAL_SCHEME_ENABLE"
    static let SITE_TYPE_KEY = "SITE_TYPE"
    
    static let APPSTORE_MODE_IOS_KEY = "APPSTORE_MODE_IOS"
    
    static let OPEN_SETTINGS_URL_SCHEMA_KEY = "OPEN_SETTINGS_URL_SCHEMA"
    static let OPEN_LOCATION_SETTINGS_URL_SCHEMA_KEY = "OPEN_LOCATION_SETTINGS_URL_SCHEMA"
    
    static let FACEBOOK_LOGIN_KEY = "FACEBOOK_LOGIN"
    static let GOOGLE_LOGIN_KEY = "GOOGLE_LOGIN"
    static let APPLE_LOGIN_KEY = "ENABLE_APPLE_LOGIN_FOR_USER"
    static let LINKDIN_LOGIN_KEY = "LINKEDIN_LOGIN"
    static let SMART_LOGIN = "isSmartLoginEnable"
    
    static let VOIP = "VOIP"
    static let VIDEOCALL = "VIDEOCALL"
    static let NORMAL = "NORMAL"
    static let VOIP_VIDEOCALL = "VOIP-VIDEOCALL"
    
    static let SINCH = "SINCH"
    static let TWILIO = "TWILIO"
    static let LOCAL = "LOCAL"
    
    static let DEFAULT_PHONE_CODE_KEY = "DEFAULT_PHONE_CODE"
    
    static let SHOW_COUNTRY_LIST = "SHOW_COUNTRY_LIST"
    static let DEFAULT_COUNTRY_KEY = "DEFAULT_COUNTRY"
    static let DEFAULT_COUNTRY_CODE_KEY = "DEFAULT_COUNTRY_CODE"
    static let DEFAULT_COUNTRY_IMAGE_KEY = "DEFAULT_COUNTRY_IMAGE_KEY"
    
    static let ENABLE_PUBNUB_KEY = "ENABLE_PUBNUB";
    static let PUBNUB_PUB_KEY = "PUBNUB_PUBLISH_KEY";
    static let PUBNUB_SUB_KEY = "PUBNUB_SUBSCRIBE_KEY";
    static let PUBNUB_SEC_KEY = "PUBNUB_SECRET_KEY";
    static let DEVICE_SESSION_ID_KEY = "DEVICE_SESSION_ID"
    static let SESSION_ID_KEY = "APP_SESSION_ID"
    
    static let IS_WALLET_AMOUNT_UPDATE_KEY = "IS_WALLET_AMOUNT_UPDATE"
    
    static let TRIP_STATUS_MSG_PRFIX = "TRIP_STATUS_MSG_"
    
    static let FEMALE_ONLY_REQ_KEY = "FEMALE_ONLY_REQ"
    static let FILTER_HANDICAP_DRIVERS_KEY = "FILTER_HANDICAP_DRIVERS"
    
    static let FETCH_TRIP_STATUS_TIME_INTERVAL_KEY = "FETCH_TRIP_STATUS_TIME_INTERVAL"
    static let RIDER_REQUEST_ACCEPT_TIME_KEY = "RIDER_REQUEST_ACCEPT_TIME"
    
    static let releaseAllTaskObserverKey = "in.ubcApp.releaseAllTask"
    
    static let DELIVERY_DETAILS_REC_NAME_KEY = "DELIVERY_DETAILS_REC_NAME"
    static let DELIVERY_DETAILS_REC_MOB_KEY = "DELIVERY_DETAILS_REC_MOB"
    static let DELIVERY_DETAILS_PICKUP_INS_KEY = "DELIVERY_DETAILS_PICKUP_INS"
    static let DELIVERY_DETAILS_DELIVERY_INS_KEY = "DELIVERY_DETAILS_DELIVERY_INS"
    static let DELIVERY_DETAILS_PACKAGE_TYPE_KEY = "DELIVERY_DETAILS_PACKAGE_TYPE"
    static let DELIVERY_DETAILS_PACKAGE_TYPE_ID_KEY = "DELIVERY_DETAILS_PACKAGE_TYPE_ID"
    static let DELIVERY_DETAILS_PACKAGE_DETAILS_KEY = "DELIVERY_DETAILS_PACKAGE_DETAILS"
    
    static let USER_PROFILE_DICT_KEY = "USER_PROFILE_DICT"
    
    static let ALERT_DIALOG_BG_TAG = 987
    static let ALERT_DIALOG_CONTENT_TAG = 999
    
    static let WINDOW_ALERT_DIALOG_BG_TAG = 988
    static let WINDOW_ALERT_DIALOG_CONTENT_TAG = 990
    
    static let ImageUpload_DESIREDWIDTH:CGFloat = 1024
    static let ImageUpload_DESIREDHEIGHT:CGFloat = 1024
    static let ImageUpload_MINIMUM_WIDTH:CGFloat = 256
    static let ImageUpload_MINIMUM_HEIGHT:CGFloat = 256
    
    static let MAX_DATE_SELECTION_MONTH_FROM_CURRENT = 1
    static let minPasswordLength = 6
    static let minMobileLength = 3
    static let MAX_ROUTE_ANIM_INTERVAL:Double = 2500 // In Milliseconds
    static var isOwnerPostSendInquiry = ""
    
    static var driverMarkersPositionList = [NSDictionary]()
    
    static var giftCardImgData = [UIImage]()
    
    static var driverMarkerAnimFinished = true
    
    static func applicationVersion() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static func applicationBuild() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    static func versionBuild() -> String {
        
        let version = applicationVersion()
        let build = applicationBuild()
        
        return "v\(version)(\(build))"
    }
    
    static func checkText(textField:UITextField) -> Bool{
        if(getText(textField: textField).trim() == ""){
            return false
        }
        
        return true
    }
    
    static func getText(textField:UITextField) -> String{
        return textField.text!
    }
    
    static func checkText(textView:UITextView) -> Bool{
        if(getText(textView: textView).trim() == ""){
            return false
        }
        
        return true
    }
    
    static func getText(textView:UITextView) -> String{
        return textView.text!
    }
    
    static func setErrorFields(textField:ErrorTextField, error:String) -> Bool{
        textField.detail = error
        textField.isErrorRevealed = true
        
        //        var frame = textField.superview!.frame
        //        frame.size.height = frame.height + 10
        //
        //        textField.superview!.frame = frame
        
        return false
    }
    
    static func createRoundedView(view:UIView, borderColor:UIColor, borderWidth:CGFloat){
        view.layer.cornerRadius = view.frame.size.width / 2;
        view.clipsToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
    static func createRoundedView(view:UIView, borderColor:UIColor, borderWidth:CGFloat, cornerRadius:CGFloat){
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
    
    static func createBoarderedView(view:UIView, borderColor:UIColor, borderWidth:CGFloat){
        view.clipsToBounds = true
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
    
    static func printNsData(someNSData:Data){
        let theString:NSString = NSString(data: someNSData, encoding: String.Encoding.utf8.rawValue)!
        Utils.printLog(msgData: theString.description)
    }
    
    static func showSnakeBar(msg:String, uv:UIViewController){
        
        guard let snackbar = uv.snackbarController?.snackbar else {
            return
        }
        
        snackbar.text = msg
        
        //        let snkBarCnt = SnackbarController()
        //        snkBarCnt.snackbar.text = msg
        //        snkBarCnt.show(uv, sender: uv)
        snackbar.rightViews = [UIView()]
        _ = uv.snackbarController?.animate(snackbar: .visible, delay: 1)
        _ = uv.snackbarController?.animate(snackbar: .hidden, delay: 4)
    }
    
    static func showSnakeBar(msg:String, uv:UIViewController, btnTitle:String, delayShow:TimeInterval, delayHide:TimeInterval) -> FlatButton{
        
        var actionButton = FlatButton()
        guard let snackbar = uv.snackbarController?.snackbar else {
            return actionButton
        }
        
        snackbar.text = msg
        
        //        let snkBarCnt = SnackbarController()
        //        snkBarCnt.snackbar.text = msg
        //        snkBarCnt.show(uv, sender: uv)
        
        if(btnTitle != ""){
            //            myBtn = MyButton()
            
            actionButton = FlatButton(title: btnTitle, titleColor: Color.yellow.base)
            actionButton.pulseAnimation = .backing
            actionButton.titleLabel?.font = uv.snackbarController?.snackbar.textLabel.font
            
            //            myBtn.frame.size = CGSize(width: 100, height: 35)
            //            myBtn.setButtonTitle(buttonTitle: btnTitle)
            snackbar.rightViews = [actionButton]
        }
        _ = uv.snackbarController?.animate(snackbar: .visible, delay: delayShow)
        _ = uv.snackbarController?.animate(snackbar: .hidden, delay: delayHide)
        
        return actionButton
    }
    
    static func textToImage(drawText: NSString, inImage: UIImage, atYPoint:NSInteger)->UIImage{
        
        // Setup the font specific variables
        let textColor: UIColor = UIColor.white
        let textFont: UIFont =  UIFont.init(name: Fonts().regular, size: 16)!
        
        //Setup the image context using the passed image.
        // UIGraphicsBeginImageContext(inImage.size)
        
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0);
        
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .center
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.draw(in: CGRect(x:0, y:0, width: inImage.size.width, height: inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        let rect: CGRect = CGRect(x:5, y: Utils.convertPxToPoints(pix: atYPoint), width: inImage.size.width - 4, height: inImage.size.height/1.5)
        
        //Now Draw the text into an image.
        
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
    
    static func convertPxToPoints(pix:NSInteger) -> CGFloat{
        return CGFloat(CGFloat(pix)/UIScreen.main.scale)
    }
    
    static func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    static func convertDateMillis(date:NSDate) -> Int64{
        let nowDouble = date.timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    static func updateMarker(marker:GMSMarker,googleMap:GMSMapView, coordinates: CLLocationCoordinate2D, rotationAngle: Double, duration: Double) {
        
        
        
        // Movement
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        //        CATransaction.setCompletionBlock({
        //            let tempData = getNextBufferedLocationData(marker: marker)
        //
        //            if(tempData != nil){
        //                let tempData = tempData! as NSDictionary
        //                let location = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("vLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("vLongitude")))
        //
        //                if(Utils.getCurrentMarkerPositionCount(marker: marker) > 1){
        ////                    Utils.removeBufferedLocationWithId(iDriverId: tempData.get("iDriverId"))
        ////
        ////                    Utils.updateMarker(marker: marker, googleMap: googleMap, coordinates: location.coordinate, rotationAngle: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("RotationAngle")), duration: duration)
        //                }
        //
        //            }
        //
        //
        //        })
        
        if(rotationAngle != -1){
            // Keep Rotation Short
            //            CATransaction.begin()
            //            CATransaction.setAnimationDuration(0.5)
            marker.rotation = rotationAngle
            //            CATransaction.commit()
        }
        
        marker.position = coordinates
        
        
        CATransaction.commit()
    }
    
    static func updateMarkerOnTrip(marker:GMSMarker,googleMap:GMSMapView?, coordinates: CLLocationCoordinate2D, rotationAngle: Double, duration: Double, iDriverId:String, LocTime:String, isMoveMapToLocation:Bool) {
        
        DispatchQueue.main.async {
            Utils.setMarkerUserData(marker: marker, isAnimte: "No")
            
            
            // if(Utils.driverMarkerAnimFinished == true){
            Utils.driverMarkerAnimFinished = false
            
            Utils.printLog(msgData: "DTT: Anim Begin")
            // Movement
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            CATransaction.setCompletionBlock({
                
                
                Utils.removeBufferedLocation(iDriverId: iDriverId, LocTime: LocTime)
                
                
                let tempData = getNextBufferedLocationData(marker: marker)
                
                if(tempData != nil){
                    
                    Utils.driverMarkerAnimFinished = true
                    
                    let tempData = tempData! as NSDictionary
                    let location = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("vLatitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("vLongitude")))
                    
                    //let newDuration = driverMarkersPositionList.count > 0 ? (duration / Double(driverMarkersPositionList.count * 4)) : duration
                    
                    //let newDuration = Double.random(in: 0..<5)
                    
                    let newDuration = driverMarkersPositionList.count > 0 ? (MainScreenUV.defaultMarkerAnimDuration / Double(driverMarkersPositionList.count * 2)) : MainScreenUV.defaultMarkerAnimDuration
                    
                    
                    Utils.printLog(msgData: "DTT: Anim Complete")
                    Utils.updateMarkerOnTrip(marker: marker, googleMap: googleMap, coordinates: location.coordinate, rotationAngle: GeneralFunctions.parseDouble(origValue: 0.0, data: tempData.get("RotationAngle")), duration: newDuration, iDriverId: tempData.get("iDriverId"), LocTime: tempData.get("LocTime"), isMoveMapToLocation: MainScreenUV.isDriverLocTrack)
                    
                    
                }else{
                    Utils.printLog(msgData: "DTT: Anim Complete")
                    Utils.driverMarkerAnimFinished = true
                    Utils.setMarkerUserData(marker: marker, isAnimte: "Yes")
                }
                
            })
            if(rotationAngle != -1){
                marker.rotation = rotationAngle
            }
            marker.position = coordinates
            
            if(isMoveMapToLocation && googleMap != nil){
                
                CATransaction.begin()
                CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
                
                let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude,
                                                      longitude: coordinates.longitude, zoom: googleMap!.camera.zoom)
                googleMap!.animate(to: camera) //.animate(with: GMSCameraUpdate.setCamera(camera))
                
                CATransaction.commit()
                
            }
            
            CATransaction.commit()
            //  }
            
        }
        
        //        if(Utils.driverMarkerAnimFinished == false){
        //            return
        //        }
        
        
        
        
        
        
        //        if(isMoveMapToLocation && googleMap != nil){
        //            CATransaction.begin()
        //            CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        //            let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude,
        //                                                              longitude: coordinates.longitude, zoom: googleMap!.camera.zoom)
        //            googleMap!.animate(to: camera)
        //            CATransaction.commit()
        //        }
        
        
        
    }
    
    static func setMarkerUserData(marker:GMSMarker, isAnimte:String){
        if(marker.userData == nil){
            return
        }
        
        let tmpUserData = marker.userData as! NSDictionary
        
        var tempData = [String:String]()
        tempData["vLatitude"] = tmpUserData.get("vLatitude")
        tempData["vLongitude"] = tmpUserData.get("vLongitude")
        tempData["iDriverId"] = tmpUserData.get("iDriverId")
        tempData["RotationAngle"] = tmpUserData.get("RotationAngle")
        tempData["LocTime"] = tmpUserData.get("LocTime")
        tempData["isAnimCompleted"] = isAnimte
        
        marker.userData = tempData as! NSDictionary
    }
    
    static func getCurrentMarkerPositionCount(marker:GMSMarker) -> Int{
        
        if(marker.title == nil || marker.title! == ""){
            return 0
        }
        
        var count = 0
        
        for i in 0..<driverMarkersPositionList.count{
            let item = driverMarkersPositionList[i]
            if(item.get("iDriverId") == marker.title!.replace("DriverId", withString: "")){
                count = count + 1
            }
        }
        
        return count
    }
    
    static func removeBufferedLocation(position:String){
        
        let position_final = GeneralFunctions.parseInt(origValue: -1, data: position)
        if(position_final != -1 && driverMarkersPositionList.count > position_final){
            driverMarkersPositionList.remove(at: position_final)
        }
    }
    
    static func removeBufferedLocation(iDriverId:String, LocTime:String){
        
        for i in 0..<driverMarkersPositionList.count{
            let item = driverMarkersPositionList[i]
            if(item.get("iDriverId") == iDriverId && item.get("LocTime") == LocTime){
                Utils.removeBufferedLocation(position: "\(i)")
                break
            }
        }
    }
    
    static func getNextBufferedLocationData(marker:GMSMarker) -> [String:String]?{
        
        for i in 0..<driverMarkersPositionList.count{
            let item = driverMarkersPositionList[i]
            if(item.get("iDriverId") == marker.title!.replace("DriverId", withString: "")){
                var tempItem = item as! [String:String]
                tempItem["Position"] = "\(i)"
                return tempItem
            }
        }
        
        return nil
    }
    
    static func getCurrentMarkerPosition(marker:GMSMarker) -> Int{
        
        if(marker.title == nil || marker.title! == ""){
            return -1
        }
        
        for i in 0..<driverMarkersPositionList.count{
            let item = driverMarkersPositionList[i]
            if(item.get("iDriverId") == marker.title!.replace("DriverId", withString: "")){
                return i
            }
        }
        
        return -1
    }
    
    static func getLastLocationDataOfMarker(marker:GMSMarker) -> NSDictionary{
        if(marker.title == nil || marker.title! == ""){
            return NSDictionary()
        }
        
        let lastIndex = driverMarkersPositionList.count - 1
        
        for i in 0..<driverMarkersPositionList.count{
            let item = driverMarkersPositionList[lastIndex - i]
            if(item.get("iDriverId") == marker.title!.replace("DriverId", withString: "")){
                return item
            }
        }
        
        return NSDictionary()
    }
    
    
    static func getCurrentDateInAppLocal(dateFormat:String, timeZone:String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        formatter.calendar = Calendar(identifier: .gregorian)
        let date = Date()
        formatter.timeZone = TimeZone(identifier: timeZone)
        let dateInGrogrian = formatter.string(from: date)
        
        
        let appLocalDate = Utils.convertDateGregorianToAppLocale(date: dateInGrogrian, dateFormate: dateFormat)
        
        
        return appLocalDate
    }
    
    static func convertDateToFormate(date:Date, formate:String) -> String{
        
        let finalFormatter = DateFormatter()
        finalFormatter.locale = Locale(identifier: "en_US_POSIX")
        finalFormatter.dateFormat = formate
        
        let finalDate = finalFormatter.string(from: date)
        
        return finalDate
    }
    static func convertStringToDate(dateStr:String, dateFormat:String) -> Date{
        let finalFormatter = DateFormatter()
        finalFormatter.locale = Locale(identifier: "en_US_POSIX")
        finalFormatter.dateFormat = dateFormat
        let finalDate = finalFormatter.date(from: dateStr)
        
        if(finalDate == nil){
            return Date()
        }
        
        
        return finalDate!
    }
    
    static func convertDateFormateInAppLocal(date:Date, toDateFormate:String) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = toDateFormate
        formatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
        return formatter.string(from: date)
    }
    
    static func convertDateGregorianToAppLocale(date:String, dateFormate:String) -> Date{
        
        if(date == ""){
            return Date()
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.locale = Locale.init(identifier: "en_GB")
        formatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        formatter.dateFormat = dateFormate
        formatter.calendar = Calendar(identifier: .gregorian)
        //        let date = Date()
        let dateInGrogrian = formatter.date(from: date)
        
        if(dateInGrogrian == nil){
            return Date()
        }
        
        formatter.calendar = Calendar(identifier: Configurations.getCalendarIdentifire())
        //        formatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        
        let dateStr = formatter.string(from: dateInGrogrian!)
        
        
        return Utils.convertStringToDate(dateStr: dateStr, dateFormat: dateFormate)
        
        //        dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
    }
    
    static func convertDateAppLocaleToGregorian(date:String, dateFormate:String) -> Date{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormate
        formatter.calendar = Calendar(identifier: .gregorian)
        //        let date = Date()
        let dateInAppLocal = formatter.date(from: date)
        
        
        formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        //        formatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        
        let dateStr = formatter.string(from: dateInAppLocal!)
        
        
        return Utils.convertStringToDate(dateStr: dateStr, dateFormat: dateFormate)
        
        //        dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
    }
    
//    static func getCurrentDateInGrogrian(dateFormat:String, timeZone:String) -> Date{
//        let formatter = DateFormatter()
//        formatter.dateFormat = dateFormat
//        formatter.calendar = Calendar(identifier: .gregorian)
//        let date = Date()
//        formatter.timeZone = TimeZone(identifier: timeZone)
//        let dateInGrogrian = formatter.string(from: date)
//
//        return convertStringToDate(dateStr: dateInGrogrian, dateFormat: dateFormat)
//    }

    static func getCurrentDateInGrogrian(dateFormat:String, timeZone:String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en")
        var defaultCal = Calendar(identifier: Configurations.getCalendarIdentifire())
        defaultCal.locale = Locale(identifier: "en")
        formatter.calendar = defaultCal
        let date = Date()
        
        formatter.timeZone = TimeZone(identifier: timeZone)
        let dateInAppLocal = formatter.string(from: date)
        
        var geCal = Calendar(identifier: Calendar.Identifier.gregorian)
        geCal.locale = Locale(identifier: "en")
        formatter.calendar = geCal
        formatter.locale = Locale(identifier: "en")
        
        let dateGregorian = formatter.date(from: dateInAppLocal)
        
        if(dateGregorian == nil){
            return Date()
        }
        return dateGregorian!
    }
    
    static func printLog(msgData:String){
        print(msgData)
    }
    
    static func isMyAppInBackground() -> Bool{
        let state: UIApplication.State = UIApplication.shared.applicationState
        
        if state == UIApplication.State.background {
            return true
        }else{
            return false
        }
        //        else if state == UIApplicationState.Active {
        //
        //            return false
        //        }
    }
    
    static func getAppState() -> UIApplication.State{
        let state: UIApplication.State = UIApplication.shared.applicationState
        return state
    }
    
    static func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    static func resetAppNotifications(){
        UIApplication.shared.applicationIconBadgeNumber = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    static func hideKeyboard(uv:UIViewController?){
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else if(uv != nil){
            uv!.view.endEditing(true)
        }
    }
    
    static func close(isAnimated:Bool, uv:UIViewController){
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else{
            uv.view.endEditing(true)
        }
        
        if(uv.navigationController == nil || uv.navigationController?.viewControllers.count == 1){
            uv.dismiss(animated: isAnimated, completion: nil)
        }else{
            uv.navigationController?.popViewController(animated: isAnimated)
        }
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func formateSecondsToHours(seconds:String) -> String{
        
        let generalFunc = GeneralFunctions()
        
        var secondsValue = Int(GeneralFunctions.parseDouble(origValue: 0, data: seconds))
        
        if(secondsValue < 60){
            secondsValue = 60
        }
        
        let (h,m,_) = Utils.secondsToHoursMinutesSeconds(seconds: secondsValue)
        
        var formattedText = ""
        
        if(h > 0){
            formattedText = "\(h)"
        }
        
        if(m > 0){
//            let minute = m < 10 ? "0\(m)" : "\(m)"
            let minute = "\(m)"
            formattedText = "\(formattedText)\(h > 0 ? ":\(minute)" : "\(minute)")"
        }
        
        if(h > 0){
            formattedText = "\(formattedText)\n\(generalFunc.getLanguageLabel(origValue: "", key: h > 1 ? "LBL_HOURS_TXT" : "LBL_HOUR_TXT").lowercased())"
        }else{
            formattedText = "\(formattedText)\n\(generalFunc.getLanguageLabel(origValue: "", key: m > 1 ? "LBL_MINS_SMALL" : "LBL_MIN_SMALL").lowercased())"
        }
        
        return formattedText
    }
    
    
   static func deviceInfo() -> String {
    
        let currentDevice = UIDevice.current
        let dictDevice = ["Name" : currentDevice.name,"IOSVersion" : currentDevice.systemVersion,"Model" : currentDevice.type.rawValue, "IdentifierForVendor" : currentDevice.identifierForVendor!.description]
        let strDevice = (dictDevice as NSDictionary).toJsonStr()
    
        return strDevice
   }
    
    static func getDeviceCountryCode() -> String{
//
//        let networkInfo = CTTelephonyNetworkInfo()
//        let carrier = networkInfo.subscriberCellularProvider
//
//        // Get carrier name
//        let carrierName = carrier?.carrierName
//
//        print(carrier)
        if(Locale.current.regionCode != nil){
            return Locale.current.regionCode!
        }
        
        return ""
    }
    
    static func getWidthOfBanner(widthOffset:CGFloat) -> CGFloat{
        return Application.screenSize.width - widthOffset
    }
    
    static func getHeightOfBanner(widthOffset:CGFloat, ratio:String, _ rationInFloat:CGFloat = 0.0) -> CGFloat{
        if(ratio == "4:3"){
            return (Utils.getWidthOfBanner(widthOffset: widthOffset) / 1.33333333333)
        }
        
        if(rationInFloat > 0.0){
            return (Utils.getWidthOfBanner(widthOffset: widthOffset) / rationInFloat)
        }
        return (Utils.getWidthOfBanner(widthOffset: widthOffset) / 1.77777778)
    }
    
    
    static func getValueInPixel(value:CGFloat) -> Int{
        return Int(value * UIScreen.main.scale)
    }
    
    static func getResizeImgURL(imgUrl:String, width:Int, height:Int) -> String{
        let imgURL_final = imgUrl.replace(" ", withString: "%20")
        let resizeUrl = "\(CommonUtils.webServer)resizeImg.php?src=\(imgURL_final)&w=\(width)&h=\(height)"
        return resizeUrl
    }
    
    static func getResizeImgURL(imgUrl:String, width:Int, height:Int, MAX_WIDTH:Int) -> String{
        let imgURL_final = imgUrl.replace(" ", withString: "%20")
        let resizeUrl = "\(CommonUtils.webServer)resizeImg.php?src=\(imgURL_final)&w=\(width)&h=\(height)&IMG_MAX_WIDTH=\(MAX_WIDTH)"
        return resizeUrl
    }
    
    static func getResizeImgURL(imgUrl:String, width:Int, height:Int, MAX_HEIGHT:Int) -> String{
        let imgURL_final = imgUrl.replace(" ", withString: "%20")
        let resizeUrl = "\(CommonUtils.webServer)resizeImg.php?src=\(imgURL_final)&w=\(width)&h=\(height)&IMG_MAX_HEIGHT=\(MAX_HEIGHT)"
        return resizeUrl
    }
    
    static func getResizeImgURL(imgUrl:String, width:Int, height:Int, MAX_WIDTH:Int, MAX_HEIGHT:Int) -> String{
        let imgURL_final = imgUrl.replace(" ", withString: "%20")
        let resizeUrl = "\(CommonUtils.webServer)resizeImg.php?src=\(imgURL_final)&w=\(width)&h=\(height)&IMG_MAX_WIDTH=\(MAX_WIDTH)&IMG_MAX_WIDTH=\(MAX_HEIGHT)"
        return resizeUrl
    }
    
    static func removeAppInactiveStateNotifications(){
        let notificationArr = UIApplication.shared.scheduledLocalNotifications
        
        if(notificationArr != nil){
            for i in 0..<notificationArr!.count{
                let notification = notificationArr![i] as UILocalNotification
                
                if(notification.userInfo != nil && notification.userInfo!["APP_INACTIVE_STATE_NOTIFICATION"] != nil){
                    UIApplication.shared.cancelLocalNotification(notification)
                }
            }
        }
    }
    
    static func addAppInactiveStateNotification(seconds:Int){
        
        var userInfo = [String:String]()
        userInfo["APP_INACTIVE_STATE_NOTIFICATION"] = "Yes"
        LocalNotification.dispatchlocalNotification(with: "", body: (GeneralFunctions()).getLanguageLabel(origValue: "App is inactive. You may no longer to receive any updates.", key: "LBL_APP_INACTIVE_STATE_ALERT_NOTIFICATION_USER"), userInfo: userInfo as NSDictionary, at: Date().addedBy(seconds: seconds))
    }
    
    static func getFontWeightList(familyName:String) -> [String]{
        
        var lightDetected = false
        var regularDetected = false
        var mediumDetected = false
        var boldDetected = false
        var lightWeight = 0.0
        var fontFamilyArray = ["OpenSans-Light", "OpenSans-Regular", "OpenSans-SemiBold", "OpenSans-Bold"]
        for fontName in UIFont.fontNames(forFamilyName: familyName){
            let font = UIFont.init(name: fontName, size: 14)
            if(font?.isItalic ?? false){
                continue
            }
            let font2 =  UIFont.systemFont(ofSize: 14, weight: font?.weight ?? UIFont.Weight(rawValue: 0.0))
            
            let fontAttributeKey = UIFontDescriptor.AttributeName.init(rawValue: "NSCTFontUIUsageAttribute")
            if let fontWeight = font2.fontDescriptor.fontAttributes[fontAttributeKey] as? String{
                
                if(fontWeight == "CTFontLightUsage"){
                    var newWeight = 0.0
                    if(lightWeight != 0.0){
                        newWeight = Double((font?.weight)!.rawValue)
                    }
                    if(Double((font?.weight)!.rawValue) < 0.0 && lightWeight == 0.0){
                        lightWeight = Double((font?.weight)!.rawValue)
                    }
                    if(lightWeight > newWeight){
                        continue
                    }
                    fontFamilyArray.remove(at: 0)
                    fontFamilyArray.insert(fontName, at: 0)
                    lightDetected = true
                }else if (fontWeight == "CTFontRegularUsage"){
                    fontFamilyArray.remove(at: 1)
                    fontFamilyArray.insert(fontName, at: 1)
                    regularDetected = true
                }else if (fontWeight == "CTFontMediumUsage" || fontWeight == "CTFontDemiUsage"){
                    fontFamilyArray.remove(at: 2)
                    fontFamilyArray.insert(fontName, at: 2)
                    mediumDetected = true
                }else if (fontWeight == "CTFontBoldUsage"){
                    fontFamilyArray.remove(at: 3)
                    fontFamilyArray.insert(fontName, at: 3)
                    boldDetected = true
                }
            }
        }
        
        if(lightDetected == false && regularDetected == true){
            let regular = fontFamilyArray[1]
            fontFamilyArray.remove(at: 0)
            fontFamilyArray.insert(regular, at: 0)
        }
        if (mediumDetected == false && regularDetected == true){
            let regular = fontFamilyArray[1]
            fontFamilyArray.remove(at: 2)
            fontFamilyArray.insert(regular, at: 2)
        }
        if (boldDetected == false && boldDetected == true){
            let regular = fontFamilyArray[1]
            fontFamilyArray.remove(at: 3)
            fontFamilyArray.insert(regular, at: 3)
        }
        
        return fontFamilyArray
        
    }
}


public enum ModelApp : String {

//Simulator
case simulator     = "simulator/sandbox",

//iPod
iPod1              = "iPod 1",
iPod2              = "iPod 2",
iPod3              = "iPod 3",
iPod4              = "iPod 4",
iPod5              = "iPod 5",
iPod6              = "iPod 6",
iPod7              = "iPod 7",

//iPad
iPad2              = "iPad 2",
iPad3              = "iPad 3",
iPad4              = "iPad 4",
iPadAir            = "iPad Air ",
iPadAir2           = "iPad Air 2",
iPadAir3           = "iPad Air 3",
iPadAir4           = "iPad Air 4",
iPad5              = "iPad 5", //iPad 2017
iPad6              = "iPad 6", //iPad 2018
iPad7              = "iPad 7", //iPad 2019
iPad8              = "iPad 8", //iPad 2020

//iPad Mini
iPadMini           = "iPad Mini",
iPadMini2          = "iPad Mini 2",
iPadMini3          = "iPad Mini 3",
iPadMini4          = "iPad Mini 4",
iPadMini5          = "iPad Mini 5",

//iPad Pro
iPadPro9_7         = "iPad Pro 9.7\"",
iPadPro10_5        = "iPad Pro 10.5\"",
iPadPro11          = "iPad Pro 11\"",
iPadPro2_11        = "iPad Pro 11\" 2nd gen",
iPadPro12_9        = "iPad Pro 12.9\"",
iPadPro2_12_9      = "iPad Pro 2 12.9\"",
iPadPro3_12_9      = "iPad Pro 3 12.9\"",
iPadPro4_12_9      = "iPad Pro 4 12.9\"",

//iPhone
iPhone4            = "iPhone 4",
iPhone4S           = "iPhone 4S",
iPhone5            = "iPhone 5",
iPhone5S           = "iPhone 5S",
iPhone5C           = "iPhone 5C",
iPhone6            = "iPhone 6",
iPhone6Plus        = "iPhone 6 Plus",
iPhone6S           = "iPhone 6S",
iPhone6SPlus       = "iPhone 6S Plus",
iPhoneSE           = "iPhone SE",
iPhone7            = "iPhone 7",
iPhone7Plus        = "iPhone 7 Plus",
iPhone8            = "iPhone 8",
iPhone8Plus        = "iPhone 8 Plus",
iPhoneX            = "iPhone X",
iPhoneXS           = "iPhone XS",
iPhoneXSMax        = "iPhone XS Max",
iPhoneXR           = "iPhone XR",
iPhone11           = "iPhone 11",
iPhone11Pro        = "iPhone 11 Pro",
iPhone11ProMax     = "iPhone 11 Pro Max",
iPhoneSE2          = "iPhone SE 2nd gen",
iPhone12Mini       = "iPhone 12 Mini",
iPhone12           = "iPhone 12",
iPhone12Pro        = "iPhone 12 Pro",
iPhone12ProMax     = "iPhone 12 Pro Max",

// Apple Watch
AppleWatch1         = "Apple Watch 1gen",
AppleWatchS1        = "Apple Watch Series 1",
AppleWatchS2        = "Apple Watch Series 2",
AppleWatchS3        = "Apple Watch Series 3",
AppleWatchS4        = "Apple Watch Series 4",
AppleWatchS5        = "Apple Watch Series 5",
AppleWatchSE        = "Apple Watch Special Edition",
AppleWatchS6        = "Apple Watch Series 6",

//Apple TV
AppleTV1           = "Apple TV 1gen",
AppleTV2           = "Apple TV 2gen",
AppleTV3           = "Apple TV 3gen",
AppleTV4           = "Apple TV 4gen",
AppleTV_4K         = "Apple TV 4K",

unrecognized       = "?unrecognized?"
}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {

var typeApp: ModelApp {
    var systemInfo = utsname()
    uname(&systemInfo)
    let modelCode = withUnsafePointer(to: &systemInfo.machine) {
        $0.withMemoryRebound(to: CChar.self, capacity: 1) {
            ptr in String.init(validatingUTF8: ptr)
        }
    }

    let modelMap : [String: ModelApp] = [

        //Simulator
        "i386"      : .simulator,
        "x86_64"    : .simulator,

        //iPod
        "iPod1,1"   : .iPod1,
        "iPod2,1"   : .iPod2,
        "iPod3,1"   : .iPod3,
        "iPod4,1"   : .iPod4,
        "iPod5,1"   : .iPod5,
        "iPod7,1"   : .iPod6,
        "iPod9,1"   : .iPod7,

        //iPad
        "iPad2,1"   : .iPad2,
        "iPad2,2"   : .iPad2,
        "iPad2,3"   : .iPad2,
        "iPad2,4"   : .iPad2,
        "iPad3,1"   : .iPad3,
        "iPad3,2"   : .iPad3,
        "iPad3,3"   : .iPad3,
        "iPad3,4"   : .iPad4,
        "iPad3,5"   : .iPad4,
        "iPad3,6"   : .iPad4,
        "iPad6,11"  : .iPad5, //iPad 2017
        "iPad6,12"  : .iPad5,
        "iPad7,5"   : .iPad6, //iPad 2018
        "iPad7,6"   : .iPad6,
        "iPad7,11"  : .iPad7, //iPad 2019
        "iPad7,12"  : .iPad7,
        "iPad11,6"  : .iPad8, //iPad 2020
        "iPad11,7"  : .iPad8,

        //iPad Mini
        "iPad2,5"   : .iPadMini,
        "iPad2,6"   : .iPadMini,
        "iPad2,7"   : .iPadMini,
        "iPad4,4"   : .iPadMini2,
        "iPad4,5"   : .iPadMini2,
        "iPad4,6"   : .iPadMini2,
        "iPad4,7"   : .iPadMini3,
        "iPad4,8"   : .iPadMini3,
        "iPad4,9"   : .iPadMini3,
        "iPad5,1"   : .iPadMini4,
        "iPad5,2"   : .iPadMini4,
        "iPad11,1"  : .iPadMini5,
        "iPad11,2"  : .iPadMini5,

        //iPad Pro
        "iPad6,3"   : .iPadPro9_7,
        "iPad6,4"   : .iPadPro9_7,
        "iPad7,3"   : .iPadPro10_5,
        "iPad7,4"   : .iPadPro10_5,
        "iPad6,7"   : .iPadPro12_9,
        "iPad6,8"   : .iPadPro12_9,
        "iPad7,1"   : .iPadPro2_12_9,
        "iPad7,2"   : .iPadPro2_12_9,
        "iPad8,1"   : .iPadPro11,
        "iPad8,2"   : .iPadPro11,
        "iPad8,3"   : .iPadPro11,
        "iPad8,4"   : .iPadPro11,
        "iPad8,9"   : .iPadPro2_11,
        "iPad8,10"  : .iPadPro2_11,
        "iPad8,5"   : .iPadPro3_12_9,
        "iPad8,6"   : .iPadPro3_12_9,
        "iPad8,7"   : .iPadPro3_12_9,
        "iPad8,8"   : .iPadPro3_12_9,
        "iPad8,11"  : .iPadPro4_12_9,
        "iPad8,12"  : .iPadPro4_12_9,

        //iPad Air
        "iPad4,1"   : .iPadAir,
        "iPad4,2"   : .iPadAir,
        "iPad4,3"   : .iPadAir,
        "iPad5,3"   : .iPadAir2,
        "iPad5,4"   : .iPadAir2,
        "iPad11,3"  : .iPadAir3,
        "iPad11,4"  : .iPadAir3,
        "iPad13,1"  : .iPadAir4,
        "iPad13,2"  : .iPadAir4,
        

        //iPhone
        "iPhone3,1" : .iPhone4,
        "iPhone3,2" : .iPhone4,
        "iPhone3,3" : .iPhone4,
        "iPhone4,1" : .iPhone4S,
        "iPhone5,1" : .iPhone5,
        "iPhone5,2" : .iPhone5,
        "iPhone5,3" : .iPhone5C,
        "iPhone5,4" : .iPhone5C,
        "iPhone6,1" : .iPhone5S,
        "iPhone6,2" : .iPhone5S,
        "iPhone7,1" : .iPhone6Plus,
        "iPhone7,2" : .iPhone6,
        "iPhone8,1" : .iPhone6S,
        "iPhone8,2" : .iPhone6SPlus,
        "iPhone8,4" : .iPhoneSE,
        "iPhone9,1" : .iPhone7,
        "iPhone9,3" : .iPhone7,
        "iPhone9,2" : .iPhone7Plus,
        "iPhone9,4" : .iPhone7Plus,
        "iPhone10,1" : .iPhone8,
        "iPhone10,4" : .iPhone8,
        "iPhone10,2" : .iPhone8Plus,
        "iPhone10,5" : .iPhone8Plus,
        "iPhone10,3" : .iPhoneX,
        "iPhone10,6" : .iPhoneX,
        "iPhone11,2" : .iPhoneXS,
        "iPhone11,4" : .iPhoneXSMax,
        "iPhone11,6" : .iPhoneXSMax,
        "iPhone11,8" : .iPhoneXR,
        "iPhone12,1" : .iPhone11,
        "iPhone12,3" : .iPhone11Pro,
        "iPhone12,5" : .iPhone11ProMax,
        "iPhone12,8" : .iPhoneSE2,
        "iPhone13,1" : .iPhone12Mini,
        "iPhone13,2" : .iPhone12,
        "iPhone13,3" : .iPhone12Pro,
        "iPhone13,4" : .iPhone12ProMax,
        
        // Apple Watch
        "Watch1,1" : .AppleWatch1,
        "Watch1,2" : .AppleWatch1,
        "Watch2,6" : .AppleWatchS1,
        "Watch2,7" : .AppleWatchS1,
        "Watch2,3" : .AppleWatchS2,
        "Watch2,4" : .AppleWatchS2,
        "Watch3,1" : .AppleWatchS3,
        "Watch3,2" : .AppleWatchS3,
        "Watch3,3" : .AppleWatchS3,
        "Watch3,4" : .AppleWatchS3,
        "Watch4,1" : .AppleWatchS4,
        "Watch4,2" : .AppleWatchS4,
        "Watch4,3" : .AppleWatchS4,
        "Watch4,4" : .AppleWatchS4,
        "Watch5,1" : .AppleWatchS5,
        "Watch5,2" : .AppleWatchS5,
        "Watch5,3" : .AppleWatchS5,
        "Watch5,4" : .AppleWatchS5,
        "Watch5,9" : .AppleWatchSE,
        "Watch5,10" : .AppleWatchSE,
        "Watch5,11" : .AppleWatchSE,
        "Watch5,12" : .AppleWatchSE,
        "Watch6,1" : .AppleWatchS6,
        "Watch6,2" : .AppleWatchS6,
        "Watch6,3" : .AppleWatchS6,
        "Watch6,4" : .AppleWatchS6,

        //Apple TV
        "AppleTV1,1" : .AppleTV1,
        "AppleTV2,1" : .AppleTV2,
        "AppleTV3,1" : .AppleTV3,
        "AppleTV3,2" : .AppleTV3,
        "AppleTV5,3" : .AppleTV4,
        "AppleTV6,2" : .AppleTV_4K
    ]

    if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
        if model == .simulator {
            if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                    return simModel
                }
            }
        }
        return model
    }
    return ModelApp.unrecognized
  }
    
        /// Returns `true` if the device has a notch
        var hasNotch: Bool {
            guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
            if UIDevice.current.orientation.isPortrait {
                return window.safeAreaInsets.top >= 44
            } else {
                return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
            }
        }
    

}



struct ServiceModule {
    
    static var rideProduct = false;
    static var deliveryProduct = false;
    static var serviceProviderProduct = false;
    static var rideDeliveryUbexProduct = false;
    static var rideDeliveryProduct = false;
    static var isAnyDeliverOptionEnable = false
    static var isDeliverOnlyEnable = false
    
    static var rideM = false
    static var deliveryM = false
    static var ufxM = false
    static var deliverallM = false
    static var genieM = false
    static var runnerM = false
    static var biddingM = false
    static var vcM = false
    static var cubex = false
    static var deliveryKing = false
    init(dataDict:NSDictionary) {
        
        let data = dataDict
        
        if(data.count > 0){
            /********************* App type Check ************************/
            if(data.get("APP_TYPE").uppercased() == Utils.cabGeneralType_Ride.uppercased()){
                ServiceModule.rideProduct = true
            }else if(data.get("APP_TYPE").uppercased() == Utils.cabGeneralType_Deliver.uppercased() || data.get("APP_TYPE").uppercased() == "Delivery".uppercased()){
                ServiceModule.deliveryProduct = true
           }else if(data.get("APP_TYPE").uppercased() == Utils.cabGeneralType_UberX.uppercased()){
                ServiceModule.serviceProviderProduct = true
            }else if(data.get("APP_TYPE").uppercased() == Utils.cabGeneralType_Ride_Delivery_UberX.uppercased()){
                ServiceModule.rideDeliveryUbexProduct = true
            }else if(data.get("APP_TYPE").uppercased() == Utils.cabGeneralType_Ride_Deliver.uppercased() || data.get("APP_TYPE").uppercased() == "Ride-Delivery".uppercased()){
                ServiceModule.rideDeliveryProduct = true
            }
            
           
            GeneralFunctions.saveValue(key: "DELIVERALL", value: (data.get("DELIVERALL").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "ONLYDELIVERALL", value: (data.get("ONLYDELIVERALL").uppercased() == "YES" ? true : false) as AnyObject)
           // ServiceModule.isAnyDeliverOptionEnable = false//(GeneralFunctions.getValue(key: "DELIVERALL") as! Bool)
            ServiceModule.isDeliverOnlyEnable = (GeneralFunctions.getValue(key: "ONLYDELIVERALL") as! Bool)
            
            /********************* Module Check ************************/
            GeneralFunctions.saveValue(key: "RIDE_ENABLED", value: (data.get("RIDE_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "DELIVERY_ENABLED", value: (data.get("DELIVERY_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "UFX_ENABLED", value: (data.get("UFX_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "DELIVERALL_ENABLED", value: (data.get("DELIVERALL_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "GENIE_ENABLED", value: (data.get("GENIE_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "RUNNER_ENABLED", value: (data.get("RUNNER_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "BIDDING_ENABLED", value: (data.get("BIDDING_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "VC_ENABLED", value: (data.get("VC_ENABLED").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "IS_CUBEX_APP", value: (data.get("IS_CUBEX_APP").uppercased() == "YES" ? true : false) as AnyObject)
            GeneralFunctions.saveValue(key: "IS_DELIVERYKING_APP", value: (data.get("IS_DELIVERYKING_APP").uppercased() == "YES" ? true : false) as AnyObject)
            
            ServiceModule.rideM = (GeneralFunctions.getValue(key: "RIDE_ENABLED") as! Bool)
            ServiceModule.deliveryM = (GeneralFunctions.getValue(key: "DELIVERY_ENABLED") as! Bool)
            ServiceModule.ufxM = (GeneralFunctions.getValue(key: "UFX_ENABLED") as! Bool)
            ServiceModule.deliverallM = (GeneralFunctions.getValue(key: "DELIVERALL_ENABLED") as! Bool)
            ServiceModule.genieM = (GeneralFunctions.getValue(key: "GENIE_ENABLED") as! Bool)
            ServiceModule.runnerM = (GeneralFunctions.getValue(key: "RUNNER_ENABLED") as! Bool)
            ServiceModule.biddingM = (GeneralFunctions.getValue(key: "BIDDING_ENABLED") as! Bool)
            ServiceModule.vcM = (GeneralFunctions.getValue(key: "VC_ENABLED") as! Bool)
            ServiceModule.cubex = (GeneralFunctions.getValue(key: "IS_CUBEX_APP") as! Bool)
            ServiceModule.deliveryKing = (GeneralFunctions.getValue(key: "IS_DELIVERYKING_APP") as! Bool)
        }
    
    }
    

    static func isAnyDeliverAllOptionEnable() -> Bool{
        if(ServiceModule.deliverallM || ServiceModule.runnerM || ServiceModule.genieM || ServiceModule.isDeliverOnlyEnable){
            
            return true
        }else{
            return false
        }
    }
    
    static func isDeliverAllOnly() -> Bool{
        
        if(ServiceModule.rideM || ServiceModule.deliveryM || ServiceModule.ufxM || ServiceModule.biddingM || ServiceModule.vcM){
            return false
        }else{
            return true
        }
    }

    static func isRideOnly() -> Bool{
        
        if(ServiceModule.rideProduct || (ServiceModule.rideM && !ServiceModule.ufxM && !ServiceModule.deliveryM && !ServiceModule.deliverallM && !ServiceModule.biddingM && !ServiceModule.vcM && !ServiceModule.genieM && !ServiceModule.runnerM)){
            return true
        }
        
        return false
    }
    
    static func isDeliveryOnly() -> Bool{
        
        if(ServiceModule.deliveryProduct || (!ServiceModule.rideM && !ServiceModule.ufxM && ServiceModule.deliveryM && !ServiceModule.deliverallM && !ServiceModule.biddingM && !ServiceModule.vcM && !ServiceModule.genieM && !ServiceModule.runnerM)){
            return true
        }
        
        return false
    }
    
    static func isRideDeliveryOnly() -> Bool{
        
        if(ServiceModule.rideDeliveryProduct || (ServiceModule.rideM && !ServiceModule.ufxM && ServiceModule.deliveryM && !ServiceModule.deliverallM && !ServiceModule.biddingM && !ServiceModule.vcM && !ServiceModule.genieM && !ServiceModule.runnerM)){
            return true
        }
        
        return false
    }
    
    static func isUFXOnly() -> Bool{
        
        if(ServiceModule.serviceProviderProduct || (!ServiceModule.rideM && ServiceModule.ufxM && !ServiceModule.deliveryM && !ServiceModule.deliverallM && !ServiceModule.biddingM && !ServiceModule.vcM && !ServiceModule.genieM && !ServiceModule.runnerM)){
            return true
        }
        
        return false
    }
}
