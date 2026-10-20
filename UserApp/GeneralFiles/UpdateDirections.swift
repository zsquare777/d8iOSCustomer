

import UIKit
import GoogleMaps
import SysBaseLib

@objc protocol OnDirectionUpdateDelegate:AnyObject
{
    func onDirectionUpdate(directionResultDict:NSDictionary)
}

class UpdateDirections: NSObject, OnLocationUpdateDelegate {
    
    var userLocation:CLLocation!
    var timer:Timer!
    var uv:UIViewController!
    
    var getLoc:DeviceLocation!
    var gMap:GMSMapView!
    
    var destinationLocation:CLLocation!
    var fromLocation:CLLocation!
    
//    var isSwapLocation = false
    
    var listOfPoints = [String()]
    
    var listOfPaths = [GMSPolyline]()
    
    let generalFunc = GeneralFunctions()
    
    var isCurrentLocationEnabled = true
    
    var onDirectionUpdateDelegate:OnDirectionUpdateDelegate!
    
    var eTollSkipped = ""
    
    var ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP = ""
    
    var DESTINATION_UPDATE_TIME_INTERVAL_value:Double = 0.0

    init(uv:UIViewController, gMap:GMSMapView, destinationLocation:CLLocation){
        self.uv = uv
        self.gMap = gMap
        self.destinationLocation = destinationLocation
        super.init()
    }
    
//    init(uv:UIViewController, gMap:GMSMapView, destinationLocation:CLLocation, isSwapLocation:Bool){
//        self.uv = uv
//        self.gMap = gMap
//        self.destinationLocation = destinationLocation
//        self.navigateView = navigateView
//        self.isSwapLocation = isSwapLocation
//        
//        super.init()
//    }
    
    init(uv:UIViewController, gMap:GMSMapView, fromLocation:CLLocation, destinationLocation:CLLocation, isCurrentLocationEnabled:Bool){
        self.uv = uv
        self.gMap = gMap
        self.fromLocation = fromLocation
        self.destinationLocation = destinationLocation
        self.isCurrentLocationEnabled = isCurrentLocationEnabled
        
        super.init()
    }
    
    func setCurrentLocEnabled(isCurrentLocationEnabled:Bool){
        self.isCurrentLocationEnabled = isCurrentLocationEnabled
    }
    
    func changeLocation(fromLocation:CLLocation, destinationLocation:CLLocation){
        self.fromLocation = fromLocation
        self.destinationLocation = destinationLocation
    }
    
    func addReleaseObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Utils.releaseAllTaskObserverKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.releaseTask), name: NSNotification.Name(rawValue: Utils.releaseAllTaskObserverKey), object: nil)
    }
    func scheduleDirectionUpdate(eTollSkipped:String){
        self.eTollSkipped = eTollSkipped
        addReleaseObserver()
        if(timer != nil){
            timer!.invalidate()
        }

        ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP = GeneralFunctions.getValue(key: Utils.ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP_KEY) as! String

        let DESTINATION_UPDATE_TIME_INTERVAL = GeneralFunctions.getValue(key: "DESTINATION_UPDATE_TIME_INTERVAL")
        DESTINATION_UPDATE_TIME_INTERVAL_value = GeneralFunctions.parseDouble(origValue: 30, data: DESTINATION_UPDATE_TIME_INTERVAL == nil ? "30" : (DESTINATION_UPDATE_TIME_INTERVAL as! String)) * 60
        
        startTimer()
        
        if(isCurrentLocationEnabled){
            if(getLoc == nil){
                getLoc = DeviceLocation(uv: self.uv, isContinuous: true)
                getLoc.buildLocManager(locationUpdateDelegate: self)
            }else{
                getLoc.buildLocManager(locationUpdateDelegate: self)
                getLoc.resumeLocationUpdates()
            }
        }
        
    }
    
    private func startTimer(){
        if(timer != nil){
            timer!.invalidate()
            timer = nil
        }
        
       timer =  Timer.scheduledTimer(timeInterval: DESTINATION_UPDATE_TIME_INTERVAL_value, target: self, selector: #selector(updateDirections), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    func startDirectionUpdate(){
        startTimer()
    }
    
    func pauseDirectionUpdate(){
        if(timer != nil){
            timer!.invalidate()
        }
    }
    
    func stopFrequentUpdate(){
        if(timer != nil){
            timer!.invalidate()
        }
        
        if(getLoc != nil){
            getLoc.releaseLocationTask()
            getLoc.locationUpdateDelegate = nil
        }
    }
    
    @objc func releaseTask(){
        if(timer != nil){
            timer!.invalidate()
            timer = nil
        }
        
        if(getLoc != nil){
            getLoc.releaseLocationTask()
            getLoc.locationUpdateDelegate = nil
            getLoc = nil
        }
        
        for i in 0..<self.listOfPaths.count{
            self.listOfPaths[i].map = nil
        }
        
        self.listOfPaths.removeAll()
        self.listOfPoints.removeAll()
        GeneralFunctions.removeObserver(obj: self)
    }
    
    func onLocationUpdate(location: CLLocation) {
        
        if(self.userLocation == nil){
            self.userLocation = location
            updateDirections()
        }
        self.userLocation = location
    }
    
    @objc func updateDirections(){
        
        let fromLocation = userLocation == nil ? self.fromLocation : userLocation
        let destinationLocation = self.destinationLocation
        
        //        if(isSwapLocation){
        //            fromLocation = destinationLocation
        //            destinationLocation = userLocation == nil ? self.fromLocation : userLocation
        //        }
        
        if(gMap == nil || destinationLocation == nil || fromLocation == nil || destinationLocation!.coordinate.latitude == 0.0 || destinationLocation!.coordinate.longitude == 0.0){
            return
        }
        
        if(ENABLE_DIRECTION_SOURCE_DESTINATION_USER_APP.uppercased() == "NO"){
            if(self.onDirectionUpdateDelegate != nil){
                self.onDirectionUpdateDelegate!.onDirectionUpdate(directionResultDict: NSDictionary())
            }
        }else{
            
            let dataProvider = DataProvider()
            dataProvider.latitude = "\(fromLocation!.coordinate.latitude)"
            dataProvider.longitude = "\(fromLocation!.coordinate.longitude)"
            dataProvider.DLatitude = "\(destinationLocation!.coordinate.latitude)"
            dataProvider.DLongitude = "\(destinationLocation!.coordinate.longitude)"
            dataProvider.isLoading = false
            dataProvider.toll_avoid = eTollSkipped.uppercased() == "YES" ? true : false
           
            AppService.getInstance().executeService(uv: self.uv, data: dataProvider, service_type: Service.DIRECTION) { (data_dict) in
                       
                let pointsArray = data_dict.arrOf("ROUTES") as! [NSDictionary]
                let waypointsArray = data_dict.arrOf("WAYPOINTS_ORDER")
               
                if(pointsArray.count == 0){
                    return
                }
                
                if(self.onDirectionUpdateDelegate != nil){
                    let dic = ["duration":data_dict.get("DURATION"), "distance":data_dict.get("DISTANCE"), "pointsArray":pointsArray, "sourceAddress":data_dict.get("SourceAddress"), "endAddress": data_dict.get("DESTINATION_ADDRESS"), "waypointsArray":waypointsArray, "serviceName": data_dict.get("RESPONSE_TYPE")] as NSDictionary
                     self.onDirectionUpdateDelegate!.onDirectionUpdate(directionResultDict: dic)
                }
                        
                for i in 0..<self.listOfPaths.count{
                    self.listOfPaths[i].map = nil
                }
                self.listOfPaths.removeAll()
                self.listOfPoints.removeAll()
                
                let path = GMSMutablePath()
                for i in 0..<pointsArray.count{
                    let item = pointsArray[i]
                    
                    
                    path.add(CLLocationCoordinate2D(latitude: GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("latitude")), longitude: GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("longitude"))))
                    
                }
                
                self.addPolyLineWithEncodedStringInMap(encodedString: "", path)

            }

        }
        
    }
    
    func addPolyLineWithEncodedStringInMap(encodedString: String, _ pathFromPoints:GMSMutablePath? = nil) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyLine = GMSPolyline(path: encodedString == "" ? pathFromPoints : path)
        polyLine.strokeWidth = 5
        polyLine.strokeColor = UIColor.black
        polyLine.map = gMap
        
        self.listOfPaths += [polyLine]
    }
}
