

import Foundation


class CountryListData: NSObject{
    
    private var countryListArr:NSArray!
    
    typealias CompletionHandler = (_ response:NSArray, _ isSuccess:Bool) -> Void
    
    static var instance:CountryListData!
    
    static func getInstance() -> CountryListData{
        if(CountryListData.instance == nil){
            CountryListData.instance = CountryListData()
        }
        return CountryListData.instance
    }
    
    func getCountryListData(completionHandler: @escaping CompletionHandler){
        
        if(CountryListData.getInstance().countryListArr != nil){
            completionHandler(self.countryListArr, true)
            return
        }
        CountryListData.getInstance().loadCountriesData(completionHandler: completionHandler)
    }
    
    private func loadCountriesData(completionHandler: @escaping CompletionHandler){

        let parameters = ["type":"countryList"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: UIView(), isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let countryListArr = dataDict.arrOf("CountryList")
                    self.countryListArr = countryListArr
                    completionHandler(self.countryListArr, true)
                }else{
                    completionHandler(NSArray(), false)
                }
            }else{
                completionHandler(NSArray(), false)
            }
        })
    }
    
}
