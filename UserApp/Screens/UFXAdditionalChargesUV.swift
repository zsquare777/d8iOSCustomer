

import UIKit
import SysBaseLib

class UFXAdditionalChargesUV: ParentViewUV, MyBtnClickDelegate, MyTxtFieldOnTextChangeDelegate, OnTaskRunCalledDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnAreaBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var btnAreaContainerView: UIView!
    @IBOutlet weak var skipBtn: MyButton!
    @IBOutlet weak var submitBtn: MyButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var currentChargesHLbl: MyLabel!
    @IBOutlet weak var currentChargesVLbl: MyLabel!
    @IBOutlet weak var materialFeeHLbl: MyLabel!
    @IBOutlet weak var materialFeeCurrencyLbl: MyLabel!
    @IBOutlet weak var materialFeeTxtField: MyTextField!
    
    @IBOutlet weak var miscFeeHLbl: MyLabel!
    @IBOutlet weak var miscFeeCurrencyLbl: MyLabel!
    @IBOutlet weak var miscFeeTxtField: MyTextField!
    
    @IBOutlet weak var providerDiscountHLbl: MyLabel!
    @IBOutlet weak var providerDiscountCurrencyLbl: MyLabel!
    @IBOutlet weak var providerDiscountTxtField: MyTextField!
    @IBOutlet weak var finalTotalHLbl: MyLabel!
    @IBOutlet weak var finalTotalVLbl: MyLabel!
    
    @IBOutlet weak var noteHLbl: MyLabel!
    @IBOutlet weak var noteVLbl: MyLabel!
    
    @IBOutlet weak var btnAreaCntViewHeight: NSLayoutConstraint!
    @IBOutlet weak var verificationView: UIView!
    @IBOutlet weak var verificationHLbl: MyLabel!
    @IBOutlet weak var verificationSHLbl: MyLabel!
    @IBOutlet weak var verificationCancelLbl: MyLabel!
    @IBOutlet weak var verificationLoaderView: UIView!
    @IBOutlet weak var verificationBgView: UIView!
    @IBOutlet weak var verificationCodeNLbl: MyLabel!
    
    @IBOutlet weak var disciuntViewHeight: NSLayoutConstraint!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var miscFeeView: UIView!
    @IBOutlet weak var miscFeeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMatirialFeeTraling: NSLayoutConstraint!
    @IBOutlet weak var lblMiscFeeTraling: NSLayoutConstraint!
    @IBOutlet weak var lblProviderDiscountTraling: NSLayoutConstraint!
    
    
    var PAGE_HEIGHT:CGFloat = 300
    
    var isSafeAreaSet = false
    var iphoneXBottomView:UIView!
    
    var generalFunc = GeneralFunctions()
    
    var cntView:UIView!
    
    var userProfileJson:NSDictionary!
    
    var fareValue:Double = 0
    var currentMaterialFee:Double = 0
    var currentMiscFee:Double = 0
    var currentProviderDiscount:Double = 0
    
    var isTextEditingBlock = false
    
    var currentFare = ""
    
    var currencySymbol = ""
    var navZposition:CGFloat = 0
    
    var tripData:NSDictionary!
    var animTask:TaskScheduler!
    
    var iTripId = ""
    var loaderView:UIView!
    var eApproveRequestSentByDriver = "No"
    var vConfirmationCode = ""
    
    var verifyChargesByNoti = false
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.setnavBarTintColor(color: SColors.Theme)
            
            /** Used for configDriverTripStatus Type */
            GeneralFunctions.saveValue(key: "iTripId", value: "" as AnyObject)
            /** Used for configDriverTripStatus Type */
            
            cntView = self.generalFunc.loadView(nibName: "UFXAdditionalChargesScreenDesign", uv: self, contentView: scrollView)
            self.scrollView.backgroundColor = UIColor(hex: 0xFFFFFF)
            self.scrollView.addSubview(cntView)
            self.scrollView.bounces = false
        
            self.setData()
            
        }else if(type == 1){
            
            self.configRTL()
            

            if(self.tripData.get("eType").uppercased() != Utils.cabGeneralType_Ride.uppercased()){
                self.addBack()
            }
            
        }
    }
    
 
    
//    override func viewDidLayoutSubviews() {
//        if(isSafeAreaSet == false){
//            if(Configurations.isIponeXDevice()){
//                if(iphoneXBottomView == nil){
//                    iphoneXBottomView = UIView()
//                    self.view.addSubview(iphoneXBottomView)
//                }
//                iphoneXBottomView.backgroundColor = SColors.Theme_1
//                iphoneXBottomView.frame = CGRect(x: 0, y: self.contentView.frame.maxY - GeneralFunctions.getSafeAreaInsets().bottom, width: Application.screenSize.width, height: GeneralFunctions.getSafeAreaInsets().bottom)
//                
//                btnAreaBottomMargin.constant = GeneralFunctions.getSafeAreaInsets().bottom
//            }
//            isSafeAreaSet = true
//        }
//    }

    func setData(){
           
           self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADDITIONAL_CHARGES")
           self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADDITIONAL_CHARGES")
           
           self.noteHLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTE")):-"
           self.noteVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADDITIONAL_CHARGE_NOTE")
           
           let noteValueHeight = noteVLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont(name: Fonts().light, size: 14)!)
           
           PAGE_HEIGHT = PAGE_HEIGHT + noteValueHeight
           
           currentFare = userProfileJson.get("TotalFareUberX")
           fareValue = GeneralFunctions.parseDouble(origValue: 0.0, data: userProfileJson.get("TotalFareUberXValue"))
           currencySymbol = userProfileJson.get("UberXFareCurrencySymbol")
           
           materialFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MATERIAL_FEE")
           currentChargesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICE_COST")
           miscFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MISC_FEE")
           providerDiscountHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROVIDER_DISCOUNT")
           
           skipBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SKIP_TXT"))
           submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_SUBMIT_TXT"))
           
           finalTotalHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Final total", key: "LBL_FINAL_TOTAL").uppercased()
           finalTotalVLbl.text = currentFare
           currentChargesVLbl.text = currentFare
           
           materialFeeCurrencyLbl.text = self.currencySymbol
           miscFeeCurrencyLbl.text = self.currencySymbol
           providerDiscountCurrencyLbl.text = "- \(self.currencySymbol)"
           
           skipBtn.clickDelegate = self
           submitBtn.clickDelegate = self
           
           materialFeeTxtField.getTextField()!.keyboardType = .decimalPad
           miscFeeTxtField.getTextField()!.keyboardType = .decimalPad
           providerDiscountTxtField.getTextField()!.keyboardType = .decimalPad
           
           
           if(Configurations.isRTLMode()){
               currentChargesVLbl.textAlignment = .left
               finalTotalVLbl.textAlignment = .left
           }
           materialFeeTxtField.maxCharacterLimit = 10
           miscFeeTxtField.maxCharacterLimit = 10
           providerDiscountTxtField.maxCharacterLimit = 10
           
           materialFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: "0.00"))
           miscFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: "0.00"))
           providerDiscountTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: "0.00"))
           materialFeeTxtField.getTextField()!.placeholderAnimation = .hidden
           miscFeeTxtField.getTextField()!.placeholderAnimation = .hidden
           providerDiscountTxtField.getTextField()!.placeholderAnimation = .hidden
           
           self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: PAGE_HEIGHT)
           
           materialFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: tripData.get("fMaterialFee")))
           miscFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: tripData.get("fMiscFee")))
           providerDiscountTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: tripData.get("fDriverDiscount")))
           finalTotalVLbl.text = Configurations.convertNumToAppLocal(numStr: tripData.get("totalAmount"))
           
           currentChargesVLbl.text = Configurations.convertNumToAppLocal(numStr: tripData.get("serviceCost"))
           
           materialFeeTxtField.setEnable(isEnabled: false)
           miscFeeTxtField.setEnable(isEnabled: false)
           providerDiscountTxtField.setEnable(isEnabled: false)
           
           if(Configurations.isIponeXDevice()){
               self.btnAreaCntViewHeight.constant = self.btnAreaCntViewHeight.constant + 30
           }
           
           var chargesData = NSDictionary()
           if(self.tripData.get("vChargesDetailData") != ""){
               chargesData = self.tripData.get("vChargesDetailData").toDict()
           }else{
               chargesData = self.tripData
           }
           
        
           let code = chargesData.get("vConfirmationCode") == "" ? self.vConfirmationCode : chargesData.get("vConfirmationCode")
           
           if((tripData.get("eApproveRequestSentByDriver").uppercased() == "YES" || self.eApproveRequestSentByDriver.uppercased() == "YES") && code == ""){
               self.noteVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPROVE_DECLINE_CHARGES_BY_USER_TXT")
               
               skipBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TXT"))
               submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPROVE_TXT"))
               
           }else{
               self.btnAreaContainerView.isHidden = true
               self.verificationCodeNLbl.isHidden = false
               self.verificationCodeNLbl.backgroundColor = SColors.Theme
               self.verificationCodeNLbl.layer.masksToBounds = true

               //self.verificationCodeNLbl.roundTo([.topRight, .topLeft], radius: 10)
            
               //self.verificationCodeNLbl.text =  "\n" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRMATION_CODE") + " " + "\n" + code
            
            //self.verificationCodeNLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRMATION_CODE") + " " + "\n" + code
            if UIDevice().typeApp == .iPhone12Pro || UIDevice().typeApp == .iPhone12ProMax ||  UIDevice().typeApp == .iPhone12 ||  UIDevice().typeApp == .iPhone12Mini || UIDevice().typeApp == .iPhone11 || UIDevice().typeApp == .iPhone11Pro || UIDevice().typeApp == .iPhone11ProMax || Configurations.isIponeXDevice() == true {
                self.verificationCodeNLbl.text =   self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRMATION_CODE") + " " + "\n" + code
            }else{
                self.verificationCodeNLbl.text =  "\n" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRMATION_CODE") + " " + "\n" + code
                
            }
               self.noteVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIVE_CHARGES_CONFIRMATION_CODE_MSG")
               self.verificationCodeNLbl.textColor = UIColor.white
           }
           
           if(self.tripData.get("eType").uppercased() == Utils.cabGeneralType_Ride.uppercased()){
               
               materialFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: chargesData.get("fTollPrice")))
               miscFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: chargesData.get("fOtherCharges")))
               
               finalTotalVLbl.text = Configurations.convertNumToAppLocal(numStr: chargesData.get("totalAmount"))
               
              // self.skipBtn.isHidden = false
               self.headerViewHeight.constant = 10
               self.headerView.backgroundColor = UIColor.white
               
               self.currentChargesHLbl.isHidden = true
               self.currentChargesVLbl.isHidden = true
               
               self.discountView.isHidden = true
               self.disciuntViewHeight.constant = 0
               
               materialFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TOLL_CHARGES")
               miscFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_CHARGES")
           }
               
           if(self.tripData.get("eType").uppercased() == Utils.cabGeneralType_Ride.uppercased()){
               
               if(self.userProfileJson.get("ENABLE_MANUAL_TOLL_FEATURE").uppercased() == "NO" && self.userProfileJson.get("ENABLE_OTHER_CHARGES_FEATURE").uppercased() == "YES"){
                   
                   self.miscFeeView.isHidden = true
                   self.miscFeeViewHeight.constant = 0
                   
                   materialFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: chargesData.get("fOtherCharges")))
                   
                   materialFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_CHARGES")
                   
                   
               }else if(self.userProfileJson.get("ENABLE_MANUAL_TOLL_FEATURE").uppercased() == "YES" && self.userProfileJson.get("ENABLE_OTHER_CHARGES_FEATURE").uppercased() == "NO"){
                   
                   self.miscFeeView.isHidden = true
                   self.miscFeeViewHeight.constant = 0
                   
                   materialFeeTxtField.setPlaceHolder(placeHolder: Configurations.convertNumToAppLocal(numStr: chargesData.get("fTollPrice")))
                   materialFeeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TOLL_CHARGES")
                   
               }
           }
        if userProfileJson.get("eReverseSymbolEnable").uppercased() == "YES" {
            if !(Configurations.isRTLMode()){
                self.lblMatirialFeeTraling.constant = 80
                self.lblMiscFeeTraling.constant = 80//self.viewMaterial.frame.size.width - 10
                //self.lblProviderDiscountTraling.constant = 80
            }//self.viewMaterial.frame.size.width - 15
        }
        if self.tripData.get("eType").uppercased() == Utils.cabGeneralType_UberX.uppercased() {
            finalTotalHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Final total", key: "LBL_FINAL_TOTAL").uppercased()
        }else{
            finalTotalHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Charges", key: "LBL_TOTAL_EXTRA_CHARGES_TXT").uppercased()
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        if(sender == materialFeeTxtField){
            let currentMaterialFee = GeneralFunctions.parseDouble(origValue: 0.00, data: Utils.getText(textField: sender.getTextField()!))
            if(self.currentMaterialFee > 0){
                self.fareValue = self.fareValue - self.currentMaterialFee
            }
            self.fareValue = self.fareValue + currentMaterialFee
            
            self.currentMaterialFee = currentMaterialFee
        }
        if(sender == miscFeeTxtField){
            let currentMiscFee = GeneralFunctions.parseDouble(origValue: 0.00, data: Utils.getText(textField: sender.getTextField()!))
            if(self.currentMiscFee > 0){
                self.fareValue = self.fareValue - self.currentMiscFee
            }
            self.fareValue = self.fareValue + currentMiscFee
            
            self.currentMiscFee = currentMiscFee
        }
        if(sender == providerDiscountTxtField){
            if(isTextEditingBlock){
                isTextEditingBlock = false
                return
            }
            var currentProviderDiscount = GeneralFunctions.parseDouble(origValue: 0.00, data: Utils.getText(textField: sender.getTextField()!))
            if(self.currentProviderDiscount > 0){
                self.fareValue = self.fareValue + self.currentProviderDiscount
            }
            if((self.fareValue - currentProviderDiscount) < 0){
                currentProviderDiscount = self.fareValue
                isTextEditingBlock = true
                providerDiscountTxtField.setText(text: "\(String(format: "%.02f", self.fareValue))")
            }
            self.fareValue = self.fareValue - currentProviderDiscount
            
            self.currentProviderDiscount = currentProviderDiscount
        }
        
        finalTotalVLbl.text = "\(self.currencySymbol)\(String(format: "%.02f", fareValue))"
    }
    
    func myBtnTapped(sender: MyButton) {
        
        
        if(sender == skipBtn){
            self.startVerification(eApproveByUser: "No")
        }else{
            self.startVerification(eApproveByUser: "Yes")
        }
    }
    
    func startVerification(eApproveByUser:String){
        
        let parameters = ["type":"sendChargeVerificationCode", "TripId": tripData!.get("TripId") == "" ? self.iTripId : tripData!.get("TripId"),"iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "eApproveByUser":eApproveByUser]
        

          let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
          exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
          exeWebServerUrl.currInstance = exeWebServerUrl
          
              exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                  
                  if(response != ""){
                      let dataDict = response.toDict()
                      
                      if(dataDict.get("Action") == "1"){
                        
                          if(dataDict.get(Utils.message_str) == "DO_RESTART"){
                              let window = Application.window
                              
                              let getUserData = GetUserData(uv: self, window: window!)
                              getUserData.getdata()
                              
                              return
                          }
                          
                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: dataDict.get("message"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            if eApproveByUser == "No"{
                                
                                super.close()
                            }else{
                            
                                // user gets notification for end trip and rating screen will open
                            }
                        })
                        
                        
                      }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                      }
                      
                  }else{
                      self.generalFunc.setError(uv: self)
                  }
        })
    }
    
    func openVerificationView(){
        self.verificationView.isHidden = false
        self.loaderView =  self.generalFunc.addMDloader(contentView: self.verificationLoaderView)
        self.verificationBgView.isHidden = false
    }
    
    func stopVerificationProcess(){
        self.verificationView.isHidden = true
        if(self.loaderView != nil){
            self.loaderView.isHidden = true
        }
        
        self.verificationBgView.isHidden = true
            
        if (self.animTask != nil) {
            self.animTask.stopRepeatingTask()
            self.animTask = nil
        }
    }
    
    func onTaskRun(currInst: TaskScheduler) {
        let parameters = ["type":"getApprovalStatus", "TripId": tripData!.get("TripId"), "PassengerId": tripData!.get("PassengerId"),"DriverId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        let eApproved = dataDict.get("eApproved")
                        
                        if (self.animTask != nil) {
                            self.animTask.stopRepeatingTask()
                            self.animTask = nil
                          
                        }
                        
                        if(self.loaderView != nil){
                            self.loaderView.isHidden = true
                        }
                        if(eApproved.uppercased() == "YES"){
                            
                            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                            
                            self.processEndTrip(isSkip: false)
                        }else{
                            self.generalFunc.setAlertMessage(uv: nil, title: "", content: dataDict.get("message"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                
                                self.stopVerificationProcess()
                            })
                        }

                        
                    }
                    
                }else{
                    ///self.generalFunc.setError(uv: self)
                }
            })
    }
    
    
    func processEndTrip(isSkip:Bool){
        let parameters = ["type":"ProcessEndTrip", "TripId": tripData!.get("TripId"), "PassengerId": tripData!.get("PassengerId"),"DriverId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "fMaterialFee": isSkip == false ? "\(currentMaterialFee > 0 ? "\(currentMaterialFee)" : "")" : "", "fMiscFee": isSkip == false ? "\(currentMiscFee > 0 ? "\(currentMiscFee)" : "")" : "", "fDriverDiscount": isSkip == false ? "\(currentProviderDiscount > 0 ? "\(currentProviderDiscount)" : "")" : ""]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        //let window = Application.window
                        
                       // let getUserData = GetUserData(uv: self, window: window!)
                        //getUserData.getdata()
                        
                    }else if(dataDict.get(Utils.message_str) == "DO_RESTART"){
                        
                        let window = Application.window
                        
                        let getUserData = GetUserData(uv: self, window: window!)
                        getUserData.getdata()
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
            })
        
    }
}
