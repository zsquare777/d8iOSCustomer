

import UIKit
import CoreLocation

class LaunchPlaceFinder: NSObject, OnPlaceSelectDelegate { //GMSAutocompleteViewControllerDelegate
    typealias CompletionHandler = (_ address:String, _ latitude:Double, _ longitude:Double) -> Void
    
//    var autocompleteController:GMSAutocompleteViewController?
    
    let generalFunc = GeneralFunctions()
    
    var sourceLocationPlaceLatitude = 0.0
    var sourceLocationPlaceLongitude = 0.0
    
    var viewControllerUV:UIViewController?
    
    var completeBlock:CompletionHandler?
    
    var currInst:LaunchPlaceFinder!
    
    var searchPlaceUv:SearchPlacesUV!
    
    var currentCabType = ""
    
    var SCREEN_TYPE = ""
    var fromAddAddress = false
    var isFromSelectLoc = false
    
    var isDriverAssigned = false
    
    var isFromDeliverAll = false
    
    var pickUpAddress = ""
    var pickUpLocation:CLLocation!
    var destAddress = ""
    var destLocation:CLLocation!
    
    var isForGenie = false
    var isFromHome = false
    var isFromRideLater = false
    var addressContainerView:AddressContainerView!
    var isFromGenieMainScreen = false
    var isFromRideLatter = false
    var isFromUfxHome = false
    var isAssignedMoreAddress = false
    var closeScreenCloser : (() -> ())?
    init(viewControllerUV:UIViewController) {
        self.viewControllerUV = viewControllerUV
        super.init()
    }
    
    func setBiasLocation(sourceLocationPlaceLatitude:Double, sourceLocationPlaceLongitude:Double){
        self.sourceLocationPlaceLatitude = sourceLocationPlaceLatitude
        self.sourceLocationPlaceLongitude = sourceLocationPlaceLongitude
    }
    
    func initializeFinder(completionHandler: @escaping CompletionHandler){

        self.completeBlock = completionHandler
        
        searchPlaceUv = (GeneralFunctions.instantiateViewController(pageName: "SearchPlacesUV") as! SearchPlacesUV)
        searchPlaceUv.isFromDeliverAll = self.isFromDeliverAll
        searchPlaceUv.isFromSelectLoc = isFromSelectLoc
        searchPlaceUv.SCREEN_TYPE = self.SCREEN_TYPE
        searchPlaceUv.isDriverAssigned = isDriverAssigned
        searchPlaceUv.currentCabType = currentCabType
        searchPlaceUv.isForGenie = self.isForGenie
        searchPlaceUv.isAssignedMoreAddress = isAssignedMoreAddress
        searchPlaceUv.isFromGenieMainScreen = self.isFromGenieMainScreen
        searchPlaceUv.isFromHome = self.isFromHome
        searchPlaceUv.isFromRideLatter = self.isFromRideLatter
        searchPlaceUv.isFromUfxHome = self.isFromUfxHome
        searchPlaceUv.closeScreenCloser = {
            self.closeScreenCloser?()
        }
        if(sourceLocationPlaceLongitude != 0.0 && sourceLocationPlaceLatitude != 0.0){
            searchPlaceUv.locationBias = CLLocation(latitude: sourceLocationPlaceLatitude, longitude: sourceLocationPlaceLongitude)
        }
        
        
        let navController = UINavigationController(rootViewController: searchPlaceUv)
        navController.navigationBar.isTranslucent = false
        
        if(viewControllerUV!.isKind(of: MainScreenUV.self)){
            
            navController.modalPresentationStyle = .custom
            navController.transitioningDelegate = (viewControllerUV as! MainScreenUV).currentTransition
            searchPlaceUv.isPickUpMode = (viewControllerUV as! MainScreenUV).isPickUpMode
            searchPlaceUv.pickUpAddress = self.pickUpAddress
            searchPlaceUv.pickUpLocation = self.pickUpLocation
            searchPlaceUv.destAddress = self.destAddress
            searchPlaceUv.destLocation = self.destLocation
            searchPlaceUv.addressContainerView = self.addressContainerView
          
            searchPlaceUv.isFromMainScreen = true
        }else{
            searchPlaceUv.viewControllerUV = self.viewControllerUV
        }
                
        searchPlaceUv.placeSelectDelegate = self
        searchPlaceUv.fromAddAddress = self.fromAddAddress
        
        self.viewControllerUV!.present(navController, animated: true, completion: nil)
    }
    
    func onPlaceSelectCancel(searchBar: UISearchBar, searchPlaceUv: SearchPlacesUV) {
        
        if(viewControllerUV!.isKind(of: MainScreenUV.self)){
            /* Book For Someone Else View.*/
            if((viewControllerUV as! MainScreenUV).requestPickUpView != nil){
                let mainUV = (viewControllerUV as! MainScreenUV)
                mainUV.addPickUpMarkerWithTimeLbl()
                mainUV.pickUpCustomMarker.zIndex = 1
                mainUV.pickUpCustomMarker.map = mainUV.gMapView
            }/* .................*/
        }
       
        searchPlaceUv.placeSelectDelegate = nil
        searchPlaceUv.isScreenKilled = true
        searchPlaceUv.close()
        if let mainUV = viewControllerUV as? MainScreenUV , mainUV.isDirectDestFromHome{
            mainUV.navigationController?.popToRootViewController(animated: true)
        }
    
    }
    
    func onPlaceSelected(location: CLLocation, address: String, searchBar: UISearchBar, searchPlaceUv: SearchPlacesUV) {
        searchPlaceUv.placeSelectDelegate = nil
        searchPlaceUv.isScreenKilled = true
        searchPlaceUv.close()
        
        if(self.completeBlock != nil){
            self.completeBlock!(address, location.coordinate.latitude, location.coordinate.longitude)
        }
    }
    
    /*func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        if(place.coordinate.latitude == 0.0 || place.coordinate.latitude == -180.0 || place.coordinate.longitude == 0.0 || place.coordinate.longitude == -180.0){
            self.generalFunc.setError(uv: self.viewControllerUV!, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_LOCATION_FOUND_TXT"))
            return
        }
        
        autocompleteController!.dismiss(animated: true, completion: {
           
            if(self.completeBlock != nil){
                self.completeBlock!(place.formattedAddress!, place.coordinate.latitude, place.coordinate.longitude)
            }
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        autocompleteController!.dismiss(animated: true, completion: nil)
    }
    
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }*/
}
