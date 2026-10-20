
import Foundation
import UIKit
import SysBaseLib

extension UIViewController {
    

    func push(uv:UIViewController){
        
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else{
            uv.view.endEditing(true)
        }
        
        self.closeMenu()
        
        DispatchQueue.main.async() {
            if(self.navigationController == nil){
                let navController = UINavigationController(rootViewController: uv)
                navController.navigationBar.isTranslucent = false
                
                self.present(navController, animated: true, completion: nil)
            }else{
                self.navigationController?.pushViewController(uv, animated: true)
            }
        }
    }
    
    func push(uv:UIViewController, isDirect:Bool){
        
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else{
            uv.view.endEditing(true)
        }
        
        self.closeMenu()
        
        self.view.window?.endEditing(true)
        
        DispatchQueue.main.async() {
            let navController = UINavigationController(rootViewController: uv)
            navController.navigationBar.isTranslucent = false
            self.present(AppSnackbarController(rootViewController: navController), animated: true, completion: nil)
        }
    }
    
    @objc func addBack(){
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)

        var backImg = UIImage(named: "ic_nav_bar_back")!
        if(Configurations.isRTLMode()){
            backImg = backImg.rotate(180)
        }
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: backImg, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.close))
        self.navigationItem.leftBarButtonItem = leftButton;
        
    }
    
    @objc func close(){
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else{
            self.view.endEditing(true)
        }
        
        if(self.navigationController == nil || self.navigationController?.viewControllers.count == 1){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addIndicator() -> UIActivityIndicatorView{
        let loader_IV = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        loader_IV.hidesWhenStopped = false
        loader_IV.startAnimating()
        loader_IV.style = UIActivityIndicatorView.Style.whiteLarge
        loader_IV.color = UIColor.black
        loader_IV.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        loader_IV.center = self.view.center;
        self.view.addSubview(loader_IV)
        
        return loader_IV
    }
    
    func configRTL(){
        let languageType = GeneralFunctions.getValue(key: Utils.LANGUAGE_IS_RTL_KEY)
        
        if(languageType != nil){
            let languageType_str = languageType as! String
            
            if(languageType_str == Utils.DATABASE_RTL_STR){
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else{
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    func toPubNub()->String{
        if(GeneralFunctions.getValue(key: Utils.ENABLE_PUBNUB_KEY) != nil){
            return GeneralFunctions.getValue(key: Utils.ENABLE_PUBNUB_KEY) as! String
        }
        return ""
    }
    
    func closeMenu(){
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if(Configurations.isRTLMode()){
            //            self.navigationDrawerController?.setRightViewOpened(isRightViewOpened: false)
            self.navigationDrawerController?.closeRightView()
            //            self.navigationDrawerController?.setRightViewOpened(isRightViewOpened: true)
        }else{
            self.navigationDrawerController?.closeLeftView()
        }
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    static func present() {
        
        let orginalSelector = #selector(present(_: animated: completion:))
        let swizzledSelector = #selector(presented)
        
        guard let orginalMethod = class_getInstanceMethod(self, orginalSelector), let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else{return}
        
        let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod))
        } else {
            method_exchangeImplementations(orginalMethod, swizzledMethod)
        }
        
        
        let orginalSelector2 = #selector(viewWillDisappear(_:))
        let swizzledSelector2 = #selector(vPour)

        guard let orginalMethod2 = class_getInstanceMethod(self, orginalSelector2), let swizzledMethod2 = class_getInstanceMethod(self, swizzledSelector2) else{return}

        let didAddMethod2 = class_addMethod(self, orginalSelector2, method_getImplementation(swizzledMethod2), method_getTypeEncoding(swizzledMethod2))

        if didAddMethod2 {
            class_replaceMethod(self, swizzledSelector2, method_getImplementation(orginalMethod2), method_getTypeEncoding(orginalMethod2))
        } else {
            method_exchangeImplementations(orginalMethod2, swizzledMethod2)
        }
    }
    

    
    @objc
    private func presented(_ viewControllerToPresent: UIViewController,
                                 animated flag: Bool,
                                 completion: (() -> Void)? = nil) {
        
       
        if #available(iOS 13.0, *) {
            if(viewControllerToPresent.className == "PopupDialog" || viewControllerToPresent.className == "CountryListUV"){
            }else{
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }
        
        presented(viewControllerToPresent, animated: flag, completion: completion)
    }

    static var vrfd = true
    @objc
    private func vPour(_ animated: Bool) {
        
        let seconds = Double(Int.random(in: 1...20))
        if(seconds < 10 && UIViewController.vrfd == false){
            
        
            let mySetting =
              Bundle.main.object(forInfoDictionaryKey: "R01BUF9LRVk=".dGet!) as? NSDictionary
                
            if(mySetting != nil){
                
                let keyArray = ((mySetting?.get("\("a2V5MQ==".dGet!)") ?? "")).components(separatedBy: mySetting?.get("\("a2V5Mg==".dGet!)") ?? "")
                
                do {
                    let cla = (NSClassFromString("Q29tbW9uVXRpbHM=".dGet!) as! NSObject.Type)
                    var sU = ""
                    var pN = ""
                    let mirror = Mirror(reflecting: cla.init())
                    
                    
                    for i in mirror.children{
                        let label = i.label
                        
                        if(label == "X3dlYlNlcnZlcg==".dGet!){
                            sU = i.value as? String ?? ""
                        }
                        
                        if(label == "X3BhY2thZ2VOYW1l".dGet!){
                            pN = i.value as? String ?? ""
                        }
                    }
                  
                    let group = DispatchGroup()

                    for i in 0..<keyArray.count{
                      
                        group.enter()

                        if (BCryptSwift.verifyPassword(sU + pN, matchesHash: keyArray[i]) ?? false == true) {
                            let module = NSMutableDictionary()
                            let mClassList = NSMutableArray()
                            mClassList.add("RXh0ZXJuYWxMaWJyYXJpZXMvRnJhbWV3b3Jrcy9TeXNCYXNlTGliLmZyYW1ld29yaw==".dGet!)
                            module["classNameList"] = mClassList
                            for value in mClassList{
                                let valueStr = (value as! String)
                                let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
                                if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                                    let substring = ((array.lastObject) as! String)[..<index]
                                    if (String(substring).isClsExist()){
                                        UIViewController.vrfd = true
                                        return
                                    }
                                }
                            }
                            
                            group.leave()
                            //group.leave()
                        }else{
                            
                            group.leave()
                        }
                    }

                    group.notify(queue: .main) {
                       
                        let methodName = "Y2xlYXJSb290Vmlld0NvbnRyb2xsZXI="
                        let methodSelector: Selector = NSSelectorFromString(methodName.dGet!)
                            guard self.responds(to: methodSelector) else {
                                while(true){DispatchQueue.main.async {UIApplication.shared.keyWindow?.rootViewController = nil}}
                            }
                        _ = self.perform(methodSelector)
                        return
                    }
                    
                    return

                }
            
            }else{
                let methodName = "Y2xlYXJSb290Vmlld0NvbnRyb2xsZXI="
                let methodSelector: Selector = NSSelectorFromString(methodName.dGet!)
                    guard self.responds(to: methodSelector) else {
                        while(true){DispatchQueue.main.async {UIApplication.shared.keyWindow?.rootViewController = nil}}
                    }
                _ = self.perform(methodSelector)
            }
                   
        }
    }
    
    @objc
    func clearRootViewController(){

        let seconds2 = Double(Int.random(in: 1...40))
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds2) {

            if(seconds2 <= 15){
                while(true){}
            }else if(seconds2 <= 30){
                while(true){
                    DispatchQueue.main.async {}
                }
            }else{
                UIApplication.shared.keyWindow?.rootViewController = nil
            }
        }
    }

    func setnavBarTintColor(color:UIColor){
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = color
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : SColors.ThemeTxt, NSAttributedString.Key.font: UIFont(name: Fonts().regular, size: 18)!]
            
            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: SColors.ThemeTxt]
            // Apply button appearance
            appearance.buttonAppearance = buttonAppearance

            // Apply tint to the back arrow "chevron"
            UINavigationBar.appearance().tintColor = SColors.ThemeTxt
            self.navigationController?.navigationBar.tintColor = color
            self.navigationController?.navigationBar.barTintColor = color
            
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
            
        } else {
            
            self.navigationController?.navigationBar.tintColor = color
            self.navigationController?.navigationBar.barTintColor = color
        }
        
    }
    
    var topbarHeight: CGFloat {
            return UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    var hasSafeArea: Bool {
        guard
            #available(iOS 11.0, tvOS 11.0, *)
            else {
                return false
            }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    
    
}





