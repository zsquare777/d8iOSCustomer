

import Foundation


class DeliverAllLanguagesData: NSObject{
    
    var languagesArrayDic = [NSDictionary]()
    
    static var instance:DeliverAllLanguagesData!
    
    let serviceCategoryArray =  GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
    
    static func getInstance() -> DeliverAllLanguagesData{
        if(DeliverAllLanguagesData.instance == nil){
            DeliverAllLanguagesData.instance = DeliverAllLanguagesData()
        }
        return DeliverAllLanguagesData.instance
    }
    
    func changeLanguage(){
        
        var serviceIDKey = [String]()
        for i in 0..<serviceCategoryArray.count{
            let item = serviceCategoryArray[i] as! NSDictionary
            serviceIDKey.append(item.get("iServiceId"))
            
        }
        //let item = serviceCategoryArray[i] as! NSDictionary
        let langCode = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        let parameters = ["type":"changelanguagelabel","vLang": langCode, "iServiceId": serviceIDKey.convertToJson(), "iServicesIDS":(serviceIDKey.map{String($0)}).joined(separator: ",")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.languagesArrayDic = dataDict.arrOf("message") as! [NSDictionary]
                    
                }
                
            }
        })
        
        
    }
    
}
