

import UIKit
import CoreLocation
import SysBaseLib

protocol AddressFoundDelegate {
    func onAddressFound(address:String, location:CLLocation, isPickUpMode:Bool, dataResult:String)
}

class GetAddressFromLocation: NSObject {
    
    typealias OnAddressFoundHandler = (_ address:String, _ location:CLLocation, _ isPickUpMode:Bool, _ dataResult:String) -> Void
    
    var uv:UIViewController!
    var location:CLLocation!
    
    var addressFoundDelegate:AddressFoundDelegate!
    
    let generalFunc = GeneralFunctions()
    
    var isPickUpMode = true
    
    var handler:OnAddressFoundHandler!
    
    init(uv:UIViewController, addressFoundDelegate:AddressFoundDelegate) {
        self.uv = uv
        self.addressFoundDelegate = addressFoundDelegate
        super.init()
    }
    
    init(uv:UIViewController) {
        self.uv = uv
        super.init()
    }

    func setLocation(latitude:Double, longitude:Double){
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func setPickUpMode(isPickUpMode:Bool){
        self.isPickUpMode = isPickUpMode
    }
    
    
    func setHandler(handler:@escaping OnAddressFoundHandler){
        self.handler = handler
    }
    
    func executeProcess(isOpenLoader:Bool, isAlertShow:Bool){
        if(location == nil){
            if(addressFoundDelegate != nil){
                addressFoundDelegate.onAddressFound(address: "", location: CLLocation(latitude: -180.0, longitude: -180.0
                ), isPickUpMode: self.isPickUpMode, dataResult: "")
            }else if(self.handler != nil){
                self.handler("", CLLocation(latitude: -180.0, longitude: -180.0), self.isPickUpMode, "")
            }
            return
        }
        
        let dataProvider = DataProvider()
        dataProvider.latitude = "\(location!.coordinate.latitude)"
        dataProvider.longitude = "\(location!.coordinate.longitude)"
        dataProvider.isLoading = isOpenLoader
        
        AppService.getInstance().executeService(uv: self.uv, data: dataProvider, service_type: Service.LOCATION_DATA) { (data_dict) in
            
            let address = data_dict.get("ADDRESS") 
            let LATITUDE = data_dict.get("LATITUDE")
            let LONGITUDE = data_dict.get("LONGITUDE")
            let RESPONSE_DATA = data_dict.get("RESPONSE_DATA")
            
            let location = CLLocation(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: LATITUDE), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: LONGITUDE))
            if(address == "" || LATITUDE == "0.0" || LONGITUDE == "0.0"){
                return
            }
            
            if(self.addressFoundDelegate != nil){
                self.addressFoundDelegate.onAddressFound(address: address, location: location, isPickUpMode: self.isPickUpMode, dataResult: RESPONSE_DATA)
            }else if(self.handler != nil){
                self.handler(address, location, self.isPickUpMode, RESPONSE_DATA)
            }
        }
    }
}
