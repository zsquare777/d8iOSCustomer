

import UIKit
import SysBaseLib

class OpenCatType: NSObject{

    var uv:UIViewController!
    var navItem:UINavigationItem!
    var item:NSDictionary!
    let generalFunc = GeneralFunctions()
    

    var termsChecked = false
    var termsArray = NSMutableArray()
    var isDirectAdressOpen = false
    var addStop = false

    
    init(uv:UIViewController, navItem:UINavigationItem, item:NSDictionary, addStop:Bool = false){
        super.init()
        
        self.uv = uv
        self.navItem = navItem
        self.item = item
        self.addStop = addStop
        self.openCatView()
    }
    

    func openCatView(){
     
        if(item.get("eShowTerms").uppercased() == "YES"){
            let openAgeTerms = OpenAgeTerms()
            openAgeTerms.openCatType = self
            openAgeTerms.openAgeTermsView(item:item)
        }else{
            if item.get("eSelectStore").uppercased() == "YES" {
                self.isDirectAdressOpen = true
            }
            self.continueToOpen()
        }
        
    }
    
    
    func continueToOpen(){
        
        if  ((item.get("eCatType").uppercased() == "ADDSTOP") || (item.get("eCatType").uppercased() == "RIDE") || (item.get("eCatType").uppercased() == "RIDERESERVE") || item.get("eCatType").uppercased() == "RIDEPOOL") && self.uv.isKind(of: UFXProUV.self) && item.get("vPageTitle") != "" {
            let addStopMiddiatorUV = GeneralFunctions.instantiateViewController(pageName: "AddStopMiddiatorUV") as! AddStopMiddiatorUV
            addStopMiddiatorUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
            addStopMiddiatorUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
            addStopMiddiatorUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
            addStopMiddiatorUV.item = self.item
            self.uv.push(uv: addStopMiddiatorUV)
            return
        }
        
        
        if(item.get("eCatType").uppercased() == "RIDE") || (item.get("eCatType").uppercased() == "RIDERESERVE") || (item.get("eCatType").uppercased() == "ADDSTOP"){
            
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            mainScreenUv.isAssignedMoreAddress = self.addStop
            mainScreenUv.vTitleFromUFX = item.get("vCategory")
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            
            if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXProUV).selectedAddress
                
            }
            if(self.uv.isKind(of: AddStopMiddiatorUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! AddStopMiddiatorUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! AddStopMiddiatorUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! AddStopMiddiatorUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! AddStopMiddiatorUV).selectedAddress
                
            }
            if item.get("eForMedicalService").uppercased() == "YES" {
                mainScreenUv.isMedicalServices = true
            }else{
                mainScreenUv.isMedicalServices = false
            }
            
            //schedule ride open
            if (item.get("eCatType").uppercased() == "RIDERESERVE") {
                mainScreenUv.isFromNow = true
            }
            mainScreenUv.isFromUFXhomeScreen = true
            self.uv.push(uv: mainScreenUv)
            return
           
        } else if(item.get("eCatType").uppercased() == "TRACKANYSERVICE"){
            
            self.checkTrackingProfileSetup(memberType: item.get("MemberType"), itemData: item)
            return
            
        }else if(item.get("eCatType").uppercased() == "TRACKSERVICE"){
            
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackingListUV") as! TrackingListUV
            mainScreenUv.typeDataDic = item
            self.uv.push(uv: mainScreenUv)
            return
            
        } else if(item.get("eCatType").uppercased() == "TRACKSERVICEADD"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "SetupProfileHomeUV") as! SetupProfileHomeUV
            mainScreenUv.dataDic = item
            self.uv.push(uv: mainScreenUv)
            return
            
        }else if(item.get("eCatType").uppercased() == "RIDEPOOL"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            mainScreenUv.POOL_TYPE = "Yes"
            mainScreenUv.vTitleFromUFX = item.get("vCategory")
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXProUV).selectedAddress
                
            }
            mainScreenUv.isFromUFXhomeScreen = true
            self.uv.push(uv: mainScreenUv)
            return
        }else if(item.get("eCatType").uppercased() == "MOTORIDE"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXProUV).selectedAddress
                
            }
            mainScreenUv.vTitleFromUFX = item.get("vCategory")
            mainScreenUv.eShowOnlyMoto = true
            mainScreenUv.isFromUFXhomeScreen = true
            self.uv.push(uv: mainScreenUv)
            return
            
        }else if(item.get("eCatType").uppercased() == "RENTAL"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            
            if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXProUV).selectedAddress
            }
            
            mainScreenUv.vTitleFromUFX = item.get("vCategory")
            mainScreenUv.eShowOnlyRental = true
            mainScreenUv.isFromUFXhomeScreen = true
            self.uv.push(uv: mainScreenUv)
            return
        }else if(item.get("eCatType").uppercased() == "MOTORENTAL"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            
            if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
                mainScreenUv.pickUpAddress = (self.uv as! UFXProUV).selectedAddress
            }
            
            mainScreenUv.vTitleFromUFX = item.get("vCategory")
            mainScreenUv.eShowOnlyMoto = true
            mainScreenUv.eShowOnlyRental = true
            mainScreenUv.isFromUFXhomeScreen = true
            self.uv.push(uv: mainScreenUv)
            return
        }else if(item.get("eCatType").uppercased() == "DELIVERALL"){
            
            GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: item.get("iServiceId") as AnyObject)
            let dataArray = DeliverAllLanguagesData.getInstance().languagesArrayDic
            var isDataExsists = false
            var dataDic = NSDictionary()
            for i in 0..<dataArray.count{

                let dic = dataArray[i]
                if(dic.get("iServiceId") == item.get("iServiceId")){
                    isDataExsists = true
                    dataDic = dic["dataDic"] as! NSDictionary
                    break
                }
            }

            self.changeLanguage(isDataExsists, storedData: dataDic)

            return
            
        }else if(item.get("eCatType").uppercased() == "RENTITEM") || (item.get("eCatType").uppercased() == "RENTCARS") || (item.get("eCatType").uppercased() == "RENTESTATE") {
          
            let rentItemHomeUV = GeneralFunctions.instantiateViewController(pageName: "RentItemHomeUV") as! RentItemHomeUV
            rentItemHomeUV.navItem = self.navItem
            rentItemHomeUV.rentCategoryId = item.get("iCategoryId")
            rentItemHomeUV.catID = item.get("iCategoryId")
            rentItemHomeUV.eType = item.get("eCatType")
            
            if(self.uv.isKind(of: UFXProUV.self)){
                rentItemHomeUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                rentItemHomeUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                rentItemHomeUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
                
            }else if(self.uv.isKind(of: UFXHomeUV.self)){
                rentItemHomeUV.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                rentItemHomeUV.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                rentItemHomeUV.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            self.uv.push(uv: rentItemHomeUV)
            

            return
            
        }else if(item.get("eCatType").uppercased() == "NEARBY"){
            
            let nearBySearvicesHomeUV = GeneralFunctions.instantiateViewController(pageName: "NearBySearvicesHomeUV") as! NearBySearvicesHomeUV
            nearBySearvicesHomeUV.navItem = self.navItem
            nearBySearvicesHomeUV.catID = item.get("iCategoryId")
            if(self.uv.isKind(of: UFXProUV.self)){
                nearBySearvicesHomeUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                nearBySearvicesHomeUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                nearBySearvicesHomeUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
                
            }else if(self.uv.isKind(of: UFXHomeUV.self)){
                nearBySearvicesHomeUV.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                nearBySearvicesHomeUV.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                nearBySearvicesHomeUV.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }
            self.uv.push(uv: nearBySearvicesHomeUV)
            return
            
        }else if(item.get("eCatType").uppercased() == "RIDESHAREPUBLISH") {
            let publishRideUV = GeneralFunctions.instantiateViewController(pageName: "PublishRideUV") as! PublishRideUV
            
            if(self.uv.isKind(of: UFXProUV.self)){
                publishRideUV.startLat = (self.uv as! UFXProUV).selectedLatitude
                publishRideUV.startLong = (self.uv as! UFXProUV).selectedLongitude
                
            }else{
                if(self.uv.isKind(of: UFXHomeUV.self)){
                    publishRideUV.startLat = (self.uv as! UFXHomeUV).selectedLatitude
                    publishRideUV.startLong = (self.uv as! UFXHomeUV).selectedLongitude
                }
            }
            
            self.uv.push(uv: publishRideUV)
        }else if (item.get("eCatType").uppercased() == "RIDESHAREBOOK"){
            let bookRideUV = GeneralFunctions.instantiateViewController(pageName: "BookRideUV") as! BookRideUV
            self.uv.push(uv: bookRideUV)
        }else if (item.get("eCatType").uppercased() == "RIDESHAREMYRIDES"){
            //let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideUV") as! MyRideUV
            //self.uv.push(uv: myRideUV)
            let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideTabUV") as! MyRideTabUV
            self.uv.push(uv: myRideUV)
            
        }else if (item.get("eCatType").uppercased() == "DELIVERY"){
            
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.vTitleFromUFX = self.generalFunc.getLanguageLabel(origValue: "", key: item.get("eDeliveryType").uppercased() == "SINGLE" ? item.get("vCategory") : "LBL_MULTI_OPTION_TITLE_TXT")
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") == true && (GeneralFunctions.getValue(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") as! String).uppercased() == "YES"){
                mainScreenUv.vTitleFromUFX = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_OPTION_TITLE_TXT")
                
                if(item.get("eDeliveryType").uppercased() == "SINGLE"){
                    GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: true as AnyObject)
                }else{
                    GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: false as AnyObject)
                }
            }else{
                GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: false as AnyObject)
            }
            
            mainScreenUv.APP_TYPE = "Delivery"
            mainScreenUv.isFromUFXhomeScreen = true
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }else if(self.uv.isKind(of: MoreDeliveriesUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! MoreDeliveriesUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! MoreDeliveriesUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! MoreDeliveriesUV).selectedAddress
            }else if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
            }
            if ServiceModule.deliveryProduct {
                if item.get("eDeliveryType").uppercased() == "SINGLE"{
                    mainScreenUv.isSingleDelivery =  true
                }else{
                    mainScreenUv.isSingleDelivery = false
                }
            }
            mainScreenUv.eShowOnlyMoto = false
            self.uv.push(uv: mainScreenUv)
            return
        }else if (item.get("eCatType").uppercased() == "MOTODELIVERY"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.vTitleFromUFX = self.generalFunc.getLanguageLabel(origValue: "", key: item.get("eDeliveryType").uppercased() == "SINGLE" ? item.get("vCategory") : "LBL_MULTI_OPTION_TITLE_TXT")
            mainScreenUv.APP_TYPE = "Delivery"
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") == true && (GeneralFunctions.getValue(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") as! String).uppercased() == "YES"){
                mainScreenUv.vTitleFromUFX = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_OPTION_TITLE_TXT")
                
                if(item.get("eDeliveryType").uppercased() == "SINGLE"){
                    GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: true as AnyObject)
                }else{
                    GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: false as AnyObject)
                }
                
            }else{
                GeneralFunctions.saveValue(key: "SINGLE_TO_MULTI", value: false as AnyObject)
            }
            
            
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }else if(self.uv.isKind(of: MoreDeliveriesUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! MoreDeliveriesUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! MoreDeliveriesUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! MoreDeliveriesUV).selectedAddress
            }else if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
            }
            
            mainScreenUv.isFromUFXhomeScreen = true
            mainScreenUv.eShowOnlyMoto = true
            self.uv.push(uv: mainScreenUv)
            return
        }else if(item.get("eCatType").uppercased() == "MOREDELIVERY") || (item.get("eCatType").uppercased() == "MultipleDelivery".uppercased()) || (item.get("eCatType").uppercased() == "SingleDelivery".uppercased()){
            let moreDeliveriesUv = GeneralFunctions.instantiateViewController(pageName: "MoreDeliveriesUV") as! MoreDeliveriesUV
            moreDeliveriesUv.navItem = self.navItem
            moreDeliveriesUv.isFromOpneCatType = true
        
            
            if(self.uv.isKind(of: UFXHomeUV.self)){
                moreDeliveriesUv.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                moreDeliveriesUv.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                moreDeliveriesUv.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }else if(self.uv.isKind(of: UFXProUV.self)){
                moreDeliveriesUv.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                moreDeliveriesUv.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                moreDeliveriesUv.selectedAddress = (self.uv as! UFXProUV).selectedAddress
            }
            
            moreDeliveriesUv.iVehicleCategoryId = item.get("iVehicleCategoryId")
            moreDeliveriesUv.vCategoryName = item.get("vCategory")
            self.uv.push(uv: moreDeliveriesUv)
            return
        }else if(item.get("eCatType").uppercased() == "DONATION"){
            let donationUV = GeneralFunctions.instantiateViewController(pageName: "DonationUV") as! DonationUV
            self.uv.push(uv: donationUV)
            return
        }else if(item.get("eCatType").uppercased() == "FLY"){
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "MainScreenUV") as! MainScreenUV
            mainScreenUv.APP_TYPE = "Ride"
            if(self.uv.isKind(of: UFXHomeUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }else if(self.uv.isKind(of: UFXProUV.self)){
                mainScreenUv.ufxSelectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                mainScreenUv.ufxSelectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                mainScreenUv.ufxSelectedAddress = (self.uv as! UFXProUV).selectedAddress
            }
            mainScreenUv.vTitleFromUFX = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_HEADER_RDU_FLY_RIDE")
            mainScreenUv.isFromUFXhomeScreen = true
            mainScreenUv.isFromFly = true
            self.uv.push(uv: mainScreenUv)
            return
        }else if(item.get("eCatType").uppercased() == "GENIE" || item.get("eCatType").uppercased() == "RUNNER" || item.get("eCatType").uppercased() == "ANYWHERE"){
            
//            if isDirectAdressOpen{
//                let addAddressUv = GeneralFunctions.instantiateViewController(pageName: "AddAddressUV") as! AddAddressUV
//                addAddressUv.ufxSelectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
//                addAddressUv.ufxSelectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
//                addAddressUv.ufxSelectedAddress = (self.uv as! UFXHomeUV).selectedAddress
//                addAddressUv.isForGenie = true
//                addAddressUv.isFromHome = true
//                addAddressUv.gennieTitle = item.get("vCategory")
//                if(item.get("eCatType").uppercased() != "ANYWHERE"){
//                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
//                    if(userProfileJson.get("PICK_DROP_GENIE").uppercased() == "YES"){
//                     addAddressUv.isFromPickDrop = true
//                    }
//                }else{
//                    addAddressUv.isFromPickDrop = false
//                }
//                if(self.uv == nil){
//                    let navController = UINavigationController(rootViewController: addAddressUv)
//                    navController.navigationBar.isTranslucent = false
//                    navController.present(navController, animated: false, completion: nil)
//                }else{
//                   // self.navigationController?.pushViewController(addAddressUv, animated: false)
//                    self.uv.push(uv: addAddressUv)
//                }
//
//            }else {
            let genieUV = GeneralFunctions.instantiateViewController(pageName: "GenieUV") as! GenieUV
            genieUV.vCategoryName = item.get("vCategory")
            
            if(self.uv.isKind(of: UFXHomeUV.self)){
                genieUV.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                genieUV.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                genieUV.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                genieUV.item = self.item
           // }
            
               self.uv.push(uv: genieUV)
               return
            }else if(self.uv.isKind(of: UFXProUV.self)){
                genieUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                genieUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                genieUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
                genieUV.item = self.item
           // }
            
               self.uv.push(uv: genieUV)
               return
            }
        }
    }
    
    
    private func checkTrackingProfileSetup(memberType:String, itemData:NSDictionary){
        
    
        let parameters = ["type":"checkTrackingProfileSetup", "MemberType": memberType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.uv.view, isOpenLoader: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let item = dataDict.dictOf("message")
                    if(item.get("eCatType").uppercased() == "TRACKSERVICE"){
                        
                        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackingListUV") as! TrackingListUV
                        mainScreenUv.typeDataDic = itemData
                        self.uv.push(uv: mainScreenUv)
                        return
                        
                    } else if(item.get("eCatType").uppercased() == "TRACKSERVICEADD"){
                        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "SetupProfileHomeUV") as! SetupProfileHomeUV
                        mainScreenUv.dataDic = itemData
                        self.uv.push(uv: mainScreenUv)
                        return
                        
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self.uv)
            }
        })
    }
    
    private func changeLanguage(_ isDataExsists:Bool = false, storedData:NSDictionary){
        
        if(isDataExsists){
            let dataDict = storedData
            _ = UIApplication.shared.delegate!.window!
        
            GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
        
            GeneralFunctions.languageLabels = nil
            Configurations.setAppLocal()
        
            let delAllUfxHomeUV = GeneralFunctions.instantiateViewController(pageName: "DelAllUFXHomeUV") as! DelAllUFXHomeUV
            delAllUfxHomeUV.navItem = self.navItem
            if(self.uv.isKind(of: UFXHomeUV.self)){
               delAllUfxHomeUV.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
               delAllUfxHomeUV.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
               delAllUfxHomeUV.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
            }else if(self.uv.isKind(of: MoreDeliveriesUV.self)){
                delAllUfxHomeUV.selectedLatitude = (self.uv as! MoreDeliveriesUV).selectedLatitude
                delAllUfxHomeUV.selectedLongitude = (self.uv as! MoreDeliveriesUV).selectedLongitude
                delAllUfxHomeUV.selectedAddress = (self.uv as! MoreDeliveriesUV).selectedAddress
            }else if(self.uv.isKind(of: UFXProUV.self)){
                delAllUfxHomeUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                delAllUfxHomeUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                delAllUfxHomeUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
            }
            self.uv.push(uv: delAllUfxHomeUV)
            return
        }
        
        let langCode = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        let parameters = ["type":"changelanguagelabel","vLang": langCode]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.uv.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    _ = UIApplication.shared.delegate!.window!
                    
                    GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
                    
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_CODE_KEY, value: dataDict.get("vCode") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_IS_RTL_KEY, value: dataDict.get("eType") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY, value: dataDict.get("vTitle") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: dataDict.get("vGMapLangCode") as AnyObject)
                    GeneralFunctions.languageLabels = nil
                    Configurations.setAppLocal()
                    
                    let delAllUfxHomeUV = GeneralFunctions.instantiateViewController(pageName: "DelAllUFXHomeUV") as! DelAllUFXHomeUV
                    delAllUfxHomeUV.navItem = self.navItem
                    if(self.uv.isKind(of: UFXHomeUV.self)){
                        delAllUfxHomeUV.selectedLatitude = (self.uv as! UFXHomeUV).selectedLatitude
                        delAllUfxHomeUV.selectedLongitude = (self.uv as! UFXHomeUV).selectedLongitude
                        delAllUfxHomeUV.selectedAddress = (self.uv as! UFXHomeUV).selectedAddress
                    }else if(self.uv.isKind(of: MoreDeliveriesUV.self)){
                        delAllUfxHomeUV.selectedLatitude = (self.uv as! MoreDeliveriesUV).selectedLatitude
                        delAllUfxHomeUV.selectedLongitude = (self.uv as! MoreDeliveriesUV).selectedLongitude
                        delAllUfxHomeUV.selectedAddress = (self.uv as! MoreDeliveriesUV).selectedAddress
                    }else if(self.uv.isKind(of: UFXProUV.self)){
                        delAllUfxHomeUV.selectedLatitude = (self.uv as! UFXProUV).selectedLatitude
                        delAllUfxHomeUV.selectedLongitude = (self.uv as! UFXProUV).selectedLongitude
                        delAllUfxHomeUV.selectedAddress = (self.uv as! UFXProUV).selectedAddress
                    }
                    self.uv.push(uv: delAllUfxHomeUV)
                    
                    
                    
                }else{
                    self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self.uv)
            }
        })
    }
    

    
}
