

import UIKit
import SysBaseLib

class SelectPromoCodeUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource , MyBtnClickDelegate , MyTxtFieldOnTextChangeDelegate , UITextFieldDelegate, MXParallaxHeaderDelegate, ParentViewUVDelegate{
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var promoTxtField: MyTextField!
    @IBOutlet weak var applyBtn: MyButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSelectPromoCodeHeader: MyLabel!
    @IBOutlet weak var topHView: UIView!
    @IBOutlet weak var spView2: UIView!
    @IBOutlet weak var spView1: UIView!
    @IBOutlet weak var noDataLbl: MyLabel!
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    
    var generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    
    var couponCodeList = [NSDictionary]()
    
    var isSafeAreaSet = false
    
    
    @IBOutlet weak var applyTopView: UIView!
    @IBOutlet weak var discountImgView: UIImageView!
    var appliedPromoCode = ""
    var isPromoCodeAppliedManually = false ////        isPromoCodeAppliedManually - YES if applied promocode from text field
    var isFromConfirmBookingScreen = false
    var currentSelectedPosition = -1
    var ufxConfirmBookingDetailUV : UFXConfirmBookingDetailsUV!
    var promoDescHeightContainer = [CGFloat]()
    var isFormAskForPayUV = false
    var isFromCheckOut = false
    var isFromUFXCheckOut = false
    var isFromPromoCode = false
    var mainScreenUV : MainScreenUV!
    
    var eSystem = ""
    var currentCabgeneralType = ""
    var isFromFly = false
    var companyId = ""
    var currentLat = ""
    var currentLong = ""
    var selectedLat = ""
    var selectedLong = ""
    var istakeAway = "No"
    var deliveryLocations = ""
    var addressId = ""
    var eForVideoConsultation = ""
    
    var isRemovePromoCode = "Yes"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.setnavBarTintColor(color: SColors.Theme)
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            cntView = self.generalFunc.loadView(nibName: "SelectPromoCodeScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            Configurations.setStatusBarStyle(style: .lightContent)
            self.addBack()
            
            self.tableView.delegate = self
            self.tableView.bounces = false
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.register(UINib(nibName: "SelectPromoCodeTVC", bundle: nil), forCellReuseIdentifier: "SelectPromoCodeTVC")
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 6, right: 0)
            
            
            
            setLabels()
            self.getCouponCodeList()
            
        }else if(type == 1){
            
            self.configRTL()
            self.navigationController?.navigationBar.zPosition = 1
            //self.applyTopView.roundTo(corners: [.bottomLeft,.topLeft], radius: 10)
            
            
        }else if(type == 2){
            self.tableView.flashScrollIndicators()
            
            self.tableView.parallaxHeader.delegate = self
            self.tableView.parallaxHeader.view = self.topHView
            self.tableView.parallaxHeader.mode = .bottom
            self.tableView.parallaxHeader.height = 120
            self.tableView.parallaxHeader.minimumHeight = 45
            GeneralFunctions.setImgTintColor(imgView: self.discountImgView, color: SColors.Theme)
        }
    }
    
    
    func setLabels(){
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY_COUPON")
        
        self.promoTxtField.onTextChangedDelegate = self
        self.promoTxtField.getTextField()!.delegate = self
        self.promoTxtField.isDividerEnabled = false
        self.promoTxtField.getTextField()!.placeholderAnimation = .NoFloat
        self.promoTxtField.backgroundColor = .white
        
        
        self.applyBtn.clickDelegate = self
        self.applyBtn.setButtonEnabled(isBtnEnabled: false)
        //self.applyBtn.setButtonTitleColor(color: UIColor(hex: 0xb2b2b2))
        self.applyBtn.setButtonTitleColor(color: SColors.ThemeTxt)
        self.applyBtn.fontSize = 18
        
        self.applyTopView.layer.shadowColor = UIColor(hex: 0xD9D9D9).cgColor
        self.applyTopView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.applyTopView.layer.shadowRadius = 1.5
        self.applyTopView.layer.shadowOpacity = 1
        self.applyTopView.layer.masksToBounds = false
        
        
        //        Set default Apply for promocode textfield
        self.promoTxtField.getTextField()!.attributedPlaceholder = NSAttributedString(
                    string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_COUPON_CODE"),
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)])
        self.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY"))
        self.applyBtn.btnType = "APPLY_PROMOCODE_FROM_TXT_FIELD"
        
        self.lblSelectPromoCodeHeader.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_COUPON_FROM_LIST")
        
        self.spView1.isHidden = true
        self.spView2.isHidden = true
        self.lblSelectPromoCodeHeader.isHidden = true
        
        if self.ufxConfirmBookingDetailUV != nil{
            self.appliedPromoCode = self.ufxConfirmBookingDetailUV.appliedPromoCode
            self.isPromoCodeAppliedManually = self.ufxConfirmBookingDetailUV.isPromoCodeAppliedManually
        }
        if currentLat == "" {
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_latitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_longitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_Address")){
                currentLat = GeneralFunctions.getValue(key: "user_current_latitude") as! String
                currentLong = GeneralFunctions.getValue(key: "user_current_longitude") as! String
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            if(cntView != nil){
                self.cntView.frame = self.view.frame
                cntView.frame.size.height = cntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
            }
            isSafeAreaSet = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        Method is used to show placeholder text again when textfield is empty
        if textField == (self.promoTxtField.getTextField())!{
            if (textField.text?.isEmpty)!{
                self.promoTxtField.getTextField()!.attributedPlaceholder = NSAttributedString(
                            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_COUPON_CODE"),
                            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)])
            }
        }
    }
    
     func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
           
           if(parallaxHeader.progress <= 0){
              
               self.lblSelectPromoCodeHeader.font = UIFont.init(name: Fonts().semibold, size: 15)
               //self.lblSelectPromoCodeHeader.textColor = UIColor.black
               self.lblSelectPromoCodeHeader.text = self.generalFunc.getLanguageLabel(origValue: "Choose Coupons", key: "LBL_CHOOSE_COUPONS")
               self.topHView.layer.borderColor = UIColor.lightGray.cgColor
           }else{
              
               self.lblSelectPromoCodeHeader.font = UIFont.init(name: Fonts().regular, size: 15)
               //self.lblSelectPromoCodeHeader.textColor = UIColor(hex: 0x676767)
               self.lblSelectPromoCodeHeader.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_COUPON_FROM_LIST")
               self.topHView.layer.borderColor = UIColor.clear.cgColor
           }
           
           if(parallaxHeader.progress > 1){
               self.tableView.scrollToTop()
           }
           
       }
    
    func onTextChanged(sender: MyTextField, text: String) {
        //        Method is used to enable/disable apply button on text change
        if (sender.getTextField()?.text == self.appliedPromoCode && self.appliedPromoCode != ""){
            self.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_TEXT"))
            self.applyBtn.btnType = "REMOVE_PROMOCODE_FROM_TXT_FIELD"
        }else{
            self.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY"))
            self.applyBtn.btnType = "APPLY_PROMOCODE_FROM_TXT_FIELD"
        }
        
        let promo_code = sender.text
        if(promo_code == ""){
            self.applyBtn.setButtonEnabled(isBtnEnabled: false)
            //self.applyBtn.setButtonTitleColor(color: UIColor(hex: 0xb2b2b2))
            self.applyBtn.setButtonTitleColor(color: SColors.ThemeTxt)
        }else{
            self.applyBtn.setButtonEnabled(isBtnEnabled: true)
           // self.applyBtn.setButtonTitleColor(color: SColors.ThemeTxt_1)
            self.applyBtn.setButtonTitleColor(color: SColors.ThemeTxt)
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        //        Added button type to identify remove/apply from txtfield/listing
        if (sender.btnType == "APPLY_PROMOCODE_FROM_TXT_FIELD") {
            if !(Utils.getText(textField: self.promoTxtField.getTextField()!).contains(" ")){
                applyPromoCodeView(appliedPromoCode: Utils.getText(textField: self.promoTxtField.getTextField()!), isFromTxtField : true)
            }else{
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_COUPON_CODE"), uv: self)
            }
        }else if(sender.btnType == "APPLY_PROMOCODE_FROM_LIST"){
            applyPromoCodeView(appliedPromoCode: self.couponCodeList[sender.tag].get("vCouponCode"), isFromTxtField : false)
        }else if(sender.btnType == "REMOVE_PROMOCODE_FROM_LIST" || sender.btnType == "REMOVE_PROMOCODE_FROM_TXT_FIELD"){
            if sender.btnType == "REMOVE_PROMOCODE_FROM_TXT_FIELD"{
                isPromoCodeAppliedManually = false
            }
            
            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_COUPON_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                if btnClickedIndex == 0{
                    self.appliedPromoCode = ""
                    self.applyPromoCodeView(appliedPromoCode: self.appliedPromoCode, isFromTxtField: false, "Yes")
                    
//                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUPON_REMOVE_SUCCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
//                        if self.ufxConfirmBookingDetailUV != nil{
//                            self.ufxConfirmBookingDetailUV.appliedPromoCode = self.appliedPromoCode
//                            self.ufxConfirmBookingDetailUV.isPromoCodeAppliedManually = self.isPromoCodeAppliedManually
//                            self.close()
//                        }else{
//                            if (self.isFormAskForPayUV == true){
//                                self.performSegue(withIdentifier: "unwindToAskForPayUV", sender: self)
//                            }else if (self.isFromCheckOut == true){
//                                self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
//                            }else if (self.isFromUFXCheckOut == true){
//                                self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
//                            }else if (self.isFromPromoCode == true){
//                                self.performSegue(withIdentifier: "unwindToAddPaymentUV", sender: self)
//                            }else{
//                                self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
//                            }
//
//                        }
//                    })
                }
            })
        }
    }
    
    /**
     This function is used to check entered promo code is valid or not.
     - parameters:
     - appliedPromoCode: Entered promo code to be checked
     - isFromTxtField: Identify promocode is from listing or from textfield
     */
    func applyPromoCodeView(appliedPromoCode:String , isFromTxtField : Bool, _ remove:String = "No"){
        
        var eType = ""
        if(self.eSystem == "DeliverAll"){
            eType = "DeliverAll"
        }else{
            if(self.currentCabgeneralType != ""){
                eType = self.currentCabgeneralType
            }else{
                eType = Utils.cabGeneralType_UberX
            }
        }
        
        
       
        let parameters = ["type":"CheckPromoCode","PromoCode": appliedPromoCode, "iUserId": GeneralFunctions.getMemberd(), "eType": eType , "eSystem" : self.eSystem, "eFly":isFromFly ? "Yes" : "No", "iCompanyId" : self.companyId,"vSourceLatitude" : self.currentLat,"vSourceLongitude":self.currentLong, "vDestLatitude": selectedLat, "vDestLongitude" : selectedLong, "eTakeAway" : istakeAway,"tDeliveryLocations" : deliveryLocations,"iUserAddressId" : addressId, "eForVideoConsultation": self.eForVideoConsultation, "isRemovePromocode":remove]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if isFromTxtField{
                        self.isPromoCodeAppliedManually = true
                    }else{
                        self.isPromoCodeAppliedManually = false
                    }
                    self.appliedPromoCode = appliedPromoCode
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        if self.ufxConfirmBookingDetailUV != nil{
                            self.ufxConfirmBookingDetailUV.appliedPromoCode = self.appliedPromoCode
                            self.ufxConfirmBookingDetailUV.isPromoCodeAppliedManually = self.isPromoCodeAppliedManually
                            self.close()
                        }else{
                            if (self.isFormAskForPayUV == true){
                                self.performSegue(withIdentifier: "unwindToAskForPayUV", sender: self)
                            }else if (self.isFromCheckOut == true){
                                self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
                            }else if (self.isFromUFXCheckOut == true){
                                self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
                            }else if (self.isFromPromoCode == true){
                                self.performSegue(withIdentifier: "unwindToAddPaymentUV", sender: self)
                            }else{
                                self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
                            }
                        }
                    })
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func getCouponCodeList(){
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else{
            loaderView.isHidden = false
        }
        
        var eType = ""
        if(self.eSystem == "DeliverAll"){
            eType = "DeliverAll"
        }else{
            if(self.currentCabgeneralType != ""){
                eType = self.currentCabgeneralType
            }else{
                eType = Utils.cabGeneralType_UberX
            }
            if isFromFly {
                eType = "Fly"
            }
        }
        

        let parameters = ["type":"DisplayCouponList", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "eType": eType , "eSystem" : self.eSystem, "eForVideoConsultation": self.eForVideoConsultation,"vSourceLatitude" : self.currentLat,"vSourceLongitude":self.currentLong, "vDestLatitude": selectedLat, "vDestLongitude" : selectedLong]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                self.noDataLbl.isHidden = true
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    if dataArr.count == 0 {
                        _ = self.promoTxtField.getTextField()?.becomeFirstResponder()
                    }else{
                        
                        self.spView1.isHidden = false
                        self.spView2.isHidden = false
                        self.lblSelectPromoCodeHeader.isHidden = false
                        for i in 0 ..< dataArr.count{
                            let dataTemp = dataArr[i] as! NSDictionary
                            self.couponCodeList.append(dataTemp)
                        }
                        
                        if self.couponCodeList.count == 1{
                            self.currentSelectedPosition = 0
                        }
                        
                        for i in 0 ..< self.couponCodeList.count{
                            let item = self.couponCodeList[i]
                            
                            let desHeight = item.get("tDescription").height(withConstrainedWidth: Application.screenSize.width - 80, font: UIFont(name: Fonts().regular, size: 12)!)
                            
                            var subDesHeight : CGFloat = 0
                            var paddingHeight : CGFloat = 0
                            
                            if item.get("eValidityType").uppercased() != "PERMANENT"{
                                var multipleAttributes = [NSAttributedString.Key : Any]()
                                multipleAttributes[NSAttributedString.Key.font] = UIFont(name: Fonts().regular, size: 12)
                                
                                let attrString1 = NSMutableAttributedString(string: "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VALID_TILL_TXT")) ")
                                let attrString2 = NSMutableAttributedString(string: item.get("dExpiryDate"))
                                
                                attrString2.addAttributes(multipleAttributes, range: NSMakeRange(0, attrString2.length))
                                attrString1.append(attrString2)
                                
                                subDesHeight = attrString1.height(withConstrainedWidth: Application.screenSize.width - 80)
                                paddingHeight = 44
                            }else{
                                paddingHeight = 10
                            }
                            
                            var totalHeight = desHeight + subDesHeight + paddingHeight
                            if totalHeight < 50{
                                totalHeight = 50
                            }
                            
                            self.promoDescHeightContainer += [totalHeight]
                        }
                        
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                        
                        for i in 0 ..< self.couponCodeList.count{
                            let item = self.couponCodeList[i]
                            let promoCode = item.get("vCouponCode")
                            if promoCode == self.appliedPromoCode{
                                self.isPromoCodeAppliedManually = false
                                let indexPath : IndexPath = IndexPath(item: i, section: 0)
                                self.currentSelectedPosition = indexPath.row
                                self.tableView.reloadRows(at: [indexPath], with: .none)
                                self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
                            }
                        }
                        
                        //                        if applied promocode is not from list than
                        if self.isPromoCodeAppliedManually{
                            self.promoTxtField.isDividerEnabled = false
                            self.promoTxtField.getTextField()!.placeholderAnimation = .hidden
                            self.promoTxtField.setPlaceHolder(placeHolder: "")
                            self.applyBtn.btnType = "REMOVE_PROMOCODE_FROM_TXT_FIELD"
                            self.promoTxtField.setText(text: self.appliedPromoCode)
                            self.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_TEXT"))
                        }
                    }
                }else if (dataDict.get("Action") == "0") {
                    self.noDataLbl.isHidden = false
                    self.noDataLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                }
                else{
                    //                    if applied promocode is not from list than
                    if self.isPromoCodeAppliedManually{
                        self.promoTxtField.isDividerEnabled = false
                        self.promoTxtField.getTextField()!.placeholderAnimation = .hidden
                        self.promoTxtField.setPlaceHolder(placeHolder: "")
                        self.applyBtn.btnType = "REMOVE_PROMOCODE_FROM_TXT_FIELD"
                        self.promoTxtField.setText(text: self.appliedPromoCode)
                        self.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_TEXT"))
                    }else{
                        //                        If not any promocode applied than get control over textfield
                        _ = self.promoTxtField.getTextField()?.becomeFirstResponder()
                    }
                }
            }else{
                self.generalFunc.setError(uv: self, isCloseScreen: true)
            }
            
            if(self.loaderView != nil){
                self.loaderView.isHidden = true
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.couponCodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPromoCodeTVC", for: indexPath) as! SelectPromoCodeTVC
        
        let objPromo = self.couponCodeList[indexPath.row]
        
//        cell.promoCodeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_CODE_TXT").uppercased()
        
        let promoCode = objPromo.get("vCouponCode")
        cell.promoCodeVLbl.text = promoCode
        //cell.promoCodeVInAppliedLbl.text = promoCode
        cell.viewDetailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_DETAILS")
        
        cell.discountTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_DISCOUNT_TYPE_TXT") + ": "
        
        GeneralFunctions.setImgTintColor(imgView: cell.arrowImg, color: SColors.Theme)
       // GeneralFunctions.setImgTintColor(imgView: cell.promoCodeBgImgView, color: SColors.Theme)
        
        cell.promoCodeDetailDesLbl.text = objPromo.get("tDescription")
        
        cell.promoCodeVLbl.layer.sublayers?.removeLast()
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = cell.promoCodeVLbl.frame.size
        let shapeRect = CGRect(x:0, y:0, width: 120, height:21)
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width/2, y:frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor(hex: 0x1B2A3B).cgColor
        borderLayer.lineWidth = 1
        borderLayer.lineJoin=CAShapeLayerLineJoin.round
        borderLayer.lineDashPattern = [NSNumber(value: 6),NSNumber(value:2)]
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 2)
        borderLayer.path = path.cgPath
        cell.promoCodeVLbl.layer.addSublayer(borderLayer)
        
        cell.desSpDottedView.layer.sublayers?.removeLast()
        cell.desSpDottedView.createDashedBorder()
        
        
        //GeneralFunctions.setImgTintColor(imgView: cell.appliedPromoImgVw, color: SColors.ThemeTxt)
        
//        let widthPromoCodeTxt = promoCode.width(withConstrainedHeight: 20, font: UIFont(name: Fonts().bold, size: 16)!)
//        if widthPromoCodeTxt > 73{
//            cell.widthAppliedPromoCodeLbl.constant = 73
//        }else{
//            cell.widthAppliedPromoCodeLbl.constant = widthPromoCodeTxt
//        }
        
        //        self.lblSelectPromoCodeHeader.addDashedBorderForWholeView()
        
        if promoCode == self.appliedPromoCode{
            cell.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_TEXT"))
            cell.applyBtn.btnType = "REMOVE_PROMOCODE_FROM_LIST"
            //cell.promoCodeHLbl.isHidden = true
            cell.promoCodeVLbl.isHidden = true
         //   cell.vwAppliedPromoCode.isHidden = false
        }else{
            cell.applyBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_TAP_TO_APPLY_TXT"))
            cell.applyBtn.btnType = "APPLY_PROMOCODE_FROM_LIST"
            //cell.promoCodeHLbl.isHidden = true
            cell.promoCodeVLbl.isHidden = false
            cell.promoCodeVLbl.textAlignment = .center
           // cell.vwAppliedPromoCode.isHidden = true
        }
        
        cell.applyBtn.clickDelegate = self
        cell.applyBtn.fontSize = 14
        cell.applyBtn.tag = indexPath.item
        cell.applyBtn.cornerRadius = 0
        cell.applyBtn.layer.cornerRadius = 0
        cell.applyBtn.backgroundColor = UIColor(hex: 0xECF7F7).withAlphaComponent(30)
        cell.applyBtn.setButtonTitleColor(color: UIColor(hex: 0x45AEAC))
        
        //cell.promoCodeVw.backgroundColor = SColors.Theme
        
        var discountType = ""
        if objPromo.get("eType").uppercased() == "CASH"{
            discountType = self.couponCodeList[indexPath.row].get("vSymbol")
        }else{
            discountType = "%"
        }
        
        
        
     
        if(discountType == "%"){
            cell.promoCodeDesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_AND_SAVE_LBL") + " " + "\(Configurations.convertNumToAppLocal(numStr: objPromo.get("fDiscount")) + discountType)"
            
            if(Configurations.isRTLMode()){
                cell.discountTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_PERCENTAGE_TXT") + ": " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_DISCOUNT_TYPE_TXT")
            }else{
                cell.discountTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_DISCOUNT_TYPE_TXT") + ": " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_PERCENTAGE_TXT")
            }
            
            
        }else{
            cell.promoCodeDesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_AND_SAVE_LBL") + " " + "\(discountType + Configurations.convertNumToAppLocal(numStr: objPromo.get("fDiscount")))"
            
            if(Configurations.isRTLMode()){
                cell.discountTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_PERCENTAGE_TXT") + ": " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_FLAT_TXT")
            }else{
                cell.discountTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_DISCOUNT_TYPE_TXT") + ": " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMOCODE_FLAT_TXT")
            }
           
        }
        
        if objPromo.get("eFreeDelivery").uppercased() == "YES"{
           
            cell.promoCodeDesLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_SAVE_DELIVERY_CHARGES")
        }
       
        if (objPromo.get("eValidityType").uppercased() != "PERMANENT"){
            cell.promoCodeExpDateLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VALID_TILL_TXT")) \(Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: objPromo.get("dExpiryDate"), dateFormate: "yyyy-MM-dd"), toDateFormate: "EE, dd MMM yy"))"
            cell.promoCodeExpDateLbl.isHidden = false
        }else{
            cell.promoCodeExpDateLbl.isHidden = true
        }
        
        cell.containerVw.layer.shadowOpacity = 0.5
        cell.containerVw.layer.shadowOffset = CGSize(width: 0, height:1)
        cell.containerVw.layer.shadowColor = UIColor.gray.cgColor
        
        if(currentSelectedPosition == -1 || currentSelectedPosition != indexPath.item){
            cell.arrowImg.transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
        }else{
            cell.arrowImg.transform = CGAffineTransform(rotationAngle: -90 * CGFloat(CGFloat.pi/180))
        }
        
        if(currentSelectedPosition == indexPath.item){
            cell.promoCodeDetailDesContainerVw.isHidden = false
        }else{
            cell.promoCodeDetailDesContainerVw.isHidden = true
        }
        
        cell.selectionStyle = .none
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
//            cell.promoCodeDesContainerVw.createDashedBorderForWholeView()
//        })
        
        var bottomPointImg = UIImage(named: "ic_promo_zigzag", in: Bundle(for: SelectPromoCodeUV.self), compatibleWith: self.traitCollection)
        
        if(Configurations.isRTLMode()){
            bottomPointImg = bottomPointImg!.rotate(180)
        }
        
       // cell.zigZagVw.backgroundColor = UIColor(patternImage: bottomPointImg!)
        
        //        cell.promoCodeVw.addZigZagBorder()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(currentSelectedPosition != indexPath.row){
            currentSelectedPosition = indexPath.row
        }else{
            currentSelectedPosition = -1
        }
        self.view.endEditing(true)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(currentSelectedPosition == -1 || currentSelectedPosition != indexPath.item){
            return 165;
        }else{
            return self.promoDescHeightContainer[indexPath.item] + 165
        }
    }
}
