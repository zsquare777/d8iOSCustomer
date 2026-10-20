import UIKit
import Foundation


@objc(CommonUtils)
class CommonUtils:NSObject {

    private static var instanceObj:CommonUtils!
    
    static func getInstance() -> CommonUtils{
        
        if(CommonUtils.instanceObj == nil){
            CommonUtils.instanceObj = CommonUtils()
        }
        
        return CommonUtils.instanceObj
        
    }
    
    static let appleAppId = "6499522228"
    
    static let idNo = "85"
    static let bNumber = "11941"
    static let pName = "a2zplush"
    
    
 //   let _webServer: String = "https://www.localservicespro.com/"
//    let _webServer: String = "https://www.aestheticbc.net/"
    let _webServer: String = "https://www.d8ideas.com/"
//    let _webServer: String = "https://www.bikri.pk/"
  //  let _webServer2: String = "https://www.localservicespro.com/"
    

    static let webServer: String = CommonUtils.getInstance()._webServer
//    static let webServer: String = CommonUtils.getInstance()._webServer

    static var webservice_path: String = webServer+"webservice_shark.php";

    let _packageName: String = Bundle.main.bundleIdentifier ?? ""
    static let google_geoCode_url: String = "https://maps.googleapis.com/maps/api/geocode/json"
    static let google_direction_url: String = "https://maps.googleapis.com/maps/api/directions/json"
    static let linkedin_url: String = "\(webServer)linkedin-login/linkedin-app.php"
    static let app_user_name = "Passenger"

    static let user_image_url = webServer + "webimages/upload/Passenger/"
    static let driver_image_url = webServer + "webimages/upload/Driver/"
    static let restaurant_image_url = webServer + "webimages/upload/Company/"
    static let PAYMENTLINK =  webServer+"assets/libraries/webview/payment_configuration_trip.php?";
    
    static let BUCKET_NAME = "system_\(pName.lowercased())_\(bNumber)"
    static let BUCKET_FILE_NAME = "IOS_USER_\(pName.lowercased())_\(bNumber).txt"
    static var BUCKET_PATH: String = "https://storage.googleapis.com/" + BUCKET_NAME + "/" + BUCKET_FILE_NAME;

}
