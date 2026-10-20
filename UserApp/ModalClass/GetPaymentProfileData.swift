

import Foundation


class GetPaymentProfileData: NSObject{
    
    
    var PAYMENT_OPTION = ""
    var PAYMENT_OPTION_DISPLAY = ""
    var PROFILE_OPTION_DISPLAY = ""
    var PaymentModeImgURL = ""
   
    
    typealias CompletionHandler = (_ isSuccess:Bool) -> Void
    static var instance:GetPaymentProfileData!
    
    static func getInstance() -> GetPaymentProfileData{
        if(GetPaymentProfileData.instance == nil){
            GetPaymentProfileData.instance = GetPaymentProfileData()
        }
        return GetPaymentProfileData.instance
    }
    
    func getPaymentDetails(view:UIView, type:String, _ contactLess:Bool = false, completionHandler: @escaping CompletionHandler){
        
        var parameters = ["type":"GetProfilePaymentDetails", "eType":type]
        if contactLess{
            parameters["isContactlessDelivery"] = "Yes"
            parameters["eSystem"] = type
        }
    
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let dic = dataDict.dictOf(Utils.message_str)
                    self.PAYMENT_OPTION = dic.get("PaymentMode")
                    self.PAYMENT_OPTION_DISPLAY = dic.get("PAYMENT_DISPLAY_LBL")
                    self.PROFILE_OPTION_DISPLAY = dic.get("PROFILE_DISPLAY_LBL")
                    self.PaymentModeImgURL = dic.get("PaymentModeImg")
                    completionHandler(true)
                }else{
                     print("Payment Profile Data:\(response)")
                }
          
            }else{
                self.getPaymentDetails(view: view, type:type, completionHandler:completionHandler)
                completionHandler(false)
            }
        })
    }
    
 
}
