

import Foundation


class GetServicesData: NSObject{
   
    var servicesResponseUFX = [NSDictionary]()
    var servicesResponseVideoCall = [NSDictionary]()
    var servicesResponsecBidding = [NSDictionary]()
    
    var deliverAllServicesResponse = [NSDictionary]()
    
    static var instance:GetServicesData!

    static func getInstance() -> GetServicesData{
        if(GetServicesData.instance == nil){
            GetServicesData.instance = GetServicesData()
        }
        return GetServicesData.instance
    }
    
    func getCategoriesData(lat:String, long:String, servicesArrayDic:[NSDictionary]){
        
        var serviceIDKey = [String]()
        for i in 0..<servicesArrayDic.count{
            let item = servicesArrayDic[i]
            serviceIDKey.append(item.get("iVehicleCategoryId"))
            
        }
        let parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId":(serviceIDKey.map{String($0)}).joined(separator: ","),"vLatitude": lat, "vLongitude": long, "eForVideoConsultation":"No"]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArray = dataDict.arrOf("message")
                    self.servicesResponseUFX.removeAll()
                    
                    for i in 0..<dataArray.count{
                        
                        let item = dataArray[i] as! NSDictionary
                        let responseStr = ["Action" : "1", "vParentCategoryName" : item.get("vParentCategoryName"), "message":item.arrOf("message"), "BANNER_DATA":dataDict.arrOf("BANNER_DATA")] as! NSDictionary
                        let dic = ["id":item.get("iVehicleCategoryId"), "response":responseStr.toJsonStr()]  as! NSDictionary
                        self.servicesResponseUFX.append(dic)
                    }
                    
                }
            }
        })
        
    }
    
    func getCategoriesDataForVideo(lat:String, long:String, servicesArrayDic:[NSDictionary]){
        
        var serviceIDKey = [String]()
        for i in 0..<servicesArrayDic.count{
            let item = servicesArrayDic[i]
            serviceIDKey.append(item.get("iVehicleCategoryId"))
            
        }
        let parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId":(serviceIDKey.map{String($0)}).joined(separator: ","),"vLatitude": lat, "vLongitude": long, "eForVideoConsultation":"Yes"]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArray = dataDict.arrOf("message")
                    self.servicesResponseVideoCall.removeAll()
                    
                    for i in 0..<dataArray.count{
                        
                        let item = dataArray[i] as! NSDictionary
                        let responseStr = ["Action" : "1", "vParentCategoryName" : item.get("vParentCategoryName"), "message":item.arrOf("message"), "BANNER_DATA":dataDict.arrOf("BANNER_DATA")] as! NSDictionary
                        let dic = ["id":item.get("iVehicleCategoryId"), "response":responseStr.toJsonStr()]  as! NSDictionary
                        self.servicesResponseVideoCall.append(dic)
                    }
                    
                }
            }
        })
        
    }
    
    
    func getCategoriesDataForBidding(lat:String, long:String, servicesArrayDic:[NSDictionary]){
        
        var serviceIDKey = [String]()
        for i in 0..<servicesArrayDic.count{
            let item = servicesArrayDic[i]
            serviceIDKey.append(item.get("iBiddingId"))
            
        }
        let parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId":(serviceIDKey.map{String($0)}).joined(separator: ","),"vLatitude": lat, "vLongitude": long, "eForVideoConsultation":"No", "eCatType":"Bidding"]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArray = dataDict.arrOf("message")
                    self.servicesResponsecBidding.removeAll()
                    
                    for i in 0..<dataArray.count{
                        
                        let item = dataArray[i] as! NSDictionary
                        let responseStr = ["Action" : "1", "vParentCategoryName" : item.get("vParentCategoryName"), "message":item.arrOf("message"), "BANNER_DATA":dataDict.arrOf("BANNER_DATA")] as! NSDictionary
                        let dic = ["id":item.get("iVehicleCategoryId"), "response":responseStr.toJsonStr()]  as! NSDictionary
                        self.servicesResponsecBidding.append(dic)
                    }
                    
                }
            }
        })
        
    }
    
    func getCategoriesDataForDeliverAll(lat:String, long:String, address:String){
        
        let parameters = ["type":"loadAvailableRestaurantsAll","PassengerLon": long, "PassengerLat": lat ,"fOfferType":"No", "cuisineId":"", "sortby":"","vAddress": address, "vLang":(GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) == nil ? "" : (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String)), "iUserId":GeneralFunctions.getMemberd(), "eFavStore":"No", "iCategoryId":"","eSystem" : "DeliverAll"]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArray = dataDict.arrOf("message")
                    self.deliverAllServicesResponse.removeAll()
                    
                    for i in 0..<dataArray.count{
                        
                        self.deliverAllServicesResponse.append(dataArray[i] as! NSDictionary)
                    }
                    
                }
            }
        })
        
    }
    
}
