

import Foundation
import AuthenticationServices
import Lottie

class SignInWithApple: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    static var signInWithApple:SignInWithApple!
    
    var uv:UIViewController!
    var isForSignup = "No"
    
    let generalFunc = GeneralFunctions()
    var animationView:AnimationView!
    
    
    static func getInstance(uv:UIViewController, isSignUp:String) -> SignInWithApple{
        if(signInWithApple == nil){
            
            signInWithApple = SignInWithApple()
    
        }
    
        signInWithApple.uv = uv
        signInWithApple.isForSignup = isSignUp
        
        return signInWithApple!
    }
    
    @objc func appleSignInTapped() {
        
        if #available(iOS 13.2, *) {
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            // request full name and email from the user's Apple ID
            request.requestedScopes = [.fullName, .email]

            // pass the request to the initializer of the controller
            let authController = ASAuthorizationController(authorizationRequests: [request])
          
            // similar to delegate, this will ask the view controller
            // which window to present the ASAuthorizationController
            authController.presentationContextProvider = self
          
              // delegate functions will be called when user data is
            // successfully retrieved or error occured
            authController.delegate = self
            
            // show the Sign-in with Apple dialog
            authController.performRequests()
        }
        
    }
    
    
  @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if(Application.window != nil){
            return Application.window!
        }else{
            return self.uv.view.window!
        }
        
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("authorization error")
            guard let error = error as? ASAuthorizationError else {
                return
            }

            switch error.code {
            case .canceled:
                // user press "cancel" during the login prompt
                print("Canceled")
            case .unknown:
                // user didn't login their Apple ID on the device
                print("Unknown")
            case .invalidResponse:
                // invalid response received from the login
                print("Invalid Respone")
            case .notHandled:
                // authorization request not handled, maybe internet failure during login
                print("Not handled")
            case .failed:
                // authorization failed
                print("Failed")
            @unknown default:
                print("Default")
            }
    }
    
    
  
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // unique ID for each user, this uniqueID will always be returned
            
            print(appleIDCredential)
            let userID = appleIDCredential.user

            // optional, might be nil
            let email = appleIDCredential.email

            // optional, might be nil
            let givenName = appleIDCredential.fullName?.givenName

            // optional, might be nil
            let familyName = appleIDCredential.fullName?.familyName

            // optional, might be nil
//            let nickName = appleIDCredential.fullName?.nickname
//
//            /*
//                useful for server side, the app can send identityToken and authorizationCode
//                to the server for verification purpose
//            */
//            var identityToken : String?
//            if let token = appleIDCredential.identityToken {
//                identityToken = String(bytes: token, encoding: .utf8)
//            }
            
//            print(identityToken)
//
//            var authorizationCode : String?
//            if let code = appleIDCredential.authorizationCode {
//                authorizationCode = String(bytes: code, encoding: .utf8)
//            }
            
          
            self.executeProcess(vEmail: email == nil ? "" : email!, vFirstName: givenName == nil ? "" : givenName!, vLastName: familyName == nil ? "" : familyName!, vAppleId: userID, vImageURL: "")
            

          // do what you want with the data here
        }
    }
    
    func executeProcess(vEmail:String, vFirstName:String, vLastName:String, vAppleId:String, vImageURL:String){
    
        
        animationView = GeneralFunctions.perofrmLoginAnimation()
        
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        let parameters = ["type":"LoginWithAppleID","vEmail": vEmail, "vFirstName": vFirstName,"vLastName": vLastName, "vAppleId": vAppleId, "vDeviceType": Utils.deviceType, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage, "vImageURL": vImageURL]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.uv.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    

                    _ = SetUserData(uv: self.uv, userProfileJson: dataDict, isStoreUserId: true)
                    
                    let userProfileJsonDict = (response.toDict().dictOf(Utils.message_str))
                    
                    
                    GeneralFunctions.saveValue(key: "APPLE_USER_ID", value: userProfileJsonDict.dictOf(Utils.message_str).get("vAppleId") as AnyObject)
                    
                    if(ServiceModule.isDeliverAllOnly())
                    {
                        if self.uv.className == "SignInUV"
                        {
                            _ = OpenMainProfile(uv: self.uv, userProfileJson: response, checkOutUV: (self.uv as! SignInUV).chackOutUV)
                        }else if self.uv.className == "SignUpUV"{
                            _ = OpenMainProfile(uv: self.uv, userProfileJson: response, checkOutUV: (self.uv as! SignUpUV).chackOutUV)
                        }

                        GeneralFunctions.restartApp(window: Application.window!)

                    }else
                    {
                        let window = UIApplication.shared.delegate!.window!
                        _ = OpenMainProfile(uv: self.uv, userProfileJson: response, window: window!)
                    }
                    if(self.animationView != nil){
                        self.animationView.superview?.removeFromSuperview()
                    }
                    
                    
                }else{
                    if(dataDict.get(Utils.message_str) == "DO_REGISTER"){
                        
                        self.registerUser(vEmail: vEmail, vFirstName: vFirstName, vLastName: vLastName, vAppleId: vAppleId, vImageURL: vImageURL)
                        
                    }else{
                        if(self.animationView != nil){
                            self.animationView.superview?.removeFromSuperview()
                        }
                        
                        self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                }
                
            }else{
                if(self.animationView != nil){
                    self.animationView.superview?.removeFromSuperview()
                }
                
                self.generalFunc.setError(uv: self.uv)
            }
        })
        
    }
    
    func registerUser(vEmail:String, vFirstName:String, vLastName:String, vAppleId:String, vImageURL:String){
        
        var view:UIView!
        if(Application.window != nil){
            view = Application.window!
        }else{
            view = self.uv.view.window!
        }
        
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        let userSelectedLanguage = GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String
        
        let parameters = ["type":"signup","vFirstName": vFirstName, "vLastName": vLastName, "vEmail": vEmail, "vAppleId": vAppleId, "vDeviceType": Utils.deviceType, "vCurrency": userSelectedCurrency, "vLang": userSelectedLanguage, "eSignUpType": "Apple", "vImageURL": vImageURL]
        
//        , "vPhone": "", "vPassword": "", "PhoneCode": "", "CountryCode": "", "vInviteCode": ""
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(self.animationView != nil){
                self.animationView.superview?.removeFromSuperview()
            }
            
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    _ = SetUserData(uv: self.uv, userProfileJson: dataDict, isStoreUserId: true)
                    
                    let userProfileJsonDict = (response.toDict().dictOf(Utils.message_str))
                    
                    
                    GeneralFunctions.saveValue(key: "APPLE_USER_ID", value: userProfileJsonDict.dictOf(Utils.message_str).get("vAppleId") as AnyObject)
                    
                    if(ServiceModule.isDeliverAllOnly())
                    {
                        if self.uv.className == "SignInUV"
                        {
                            _ = OpenMainProfile(uv: self.uv, userProfileJson: response, checkOutUV: (self.uv as! SignInUV).chackOutUV)
                        }else if self.uv.className == "SignUpUV"{
                            _ = OpenMainProfile(uv: self.uv, userProfileJson: response, checkOutUV: (self.uv as! SignUpUV).chackOutUV)
                        }

                        GeneralFunctions.restartApp(window: Application.window!)

                    }else
                    {
                        let window = UIApplication.shared.delegate!.window!
                        _ = OpenMainProfile(uv: self.uv, userProfileJson: response, window: window!)
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self.uv)
            }
        })
    }
    
}
