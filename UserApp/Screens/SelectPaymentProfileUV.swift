

import UIKit
import SysBaseLib

class SelectPaymentProfileUV: ParentViewUV, MyBtnClickDelegate, BEMCheckBoxDelegate, ParentViewUVDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var doneBtn: MyButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectProfileView: UIView!
    @IBOutlet weak var selectProfileArrowImgView: UIImageView!
    @IBOutlet weak var profileLbl: MyLabel!
    @IBOutlet weak var profileIconImgView: UIImageView!
    @IBOutlet weak var hLbl: MyLabel!
    @IBOutlet weak var reasonsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reasonLbl: MyLabel!
    @IBOutlet weak var reasonHLbl: MyLabel!
    @IBOutlet weak var reasonArrowImgView: UIImageView!
    @IBOutlet weak var reasonParentView: UIView!
    @IBOutlet weak var reaosnSelectView: UIView!
    @IBOutlet weak var writeReasonHLbl: MyLabel!
    @IBOutlet weak var writeReasonTxtView: UITextView!
    @IBOutlet weak var writeReasonView: UIView!
    @IBOutlet weak var writeReasonViewHeight: NSLayoutConstraint!

    @IBOutlet weak var paymentOptionView: UIView!
    @IBOutlet weak var paymentOptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentHLbl: MyLabel!
    @IBOutlet weak var useWalletChkBox: BEMCheckBox!
    @IBOutlet weak var useWalletLbl: MyLabel!
    @IBOutlet weak var addWalletBalLbl: MyLabel!
    
    @IBOutlet weak var useWalletView: UIView!
    @IBOutlet weak var cashPayModeView: UIView!
    @IBOutlet weak var cardPayModeView: UIView!
    @IBOutlet weak var cashPayLbl: MyLabel!
    @IBOutlet weak var cardPayLbl: MyLabel!
    @IBOutlet weak var topWalletBgView: UIView!
    @IBOutlet weak var walletAmoLbl: MyLabel!
    @IBOutlet weak var cashImgView: UIImageView!
    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var paymentStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bottomProfileView: UIView!
    @IBOutlet weak var cardDetailLbl: MyLabel!
    @IBOutlet weak var changeCardLbl: MyLabel!
    @IBOutlet weak var cardDetailView: UIView!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var cardCheckImgView: UIImageView!
    @IBOutlet weak var profileViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomProfileViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileUpDownView: UIView!
    @IBOutlet weak var walletViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentDisableView: UIView!
    @IBOutlet weak var paymentDisableLbl: MyLabel!
    @IBOutlet weak var hLblTopSpace: NSLayoutConstraint!
    @IBOutlet weak var cardDetailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cashPayDisableLbl: MyLabel!
    @IBOutlet weak var profileUpDownImgView: UIView!
    
    var isSafeAreaSet = false
    var iphoneXBottomView:UIView!
    
    var isCashPayment = true
    var isCardValidated = false
    var isPayByOrganization = false
    
    let generalFunc = GeneralFunctions()
    
    var cntView:UIView!
    
    var PAGE_HEIGHT:CGFloat = 505
    

    var organizationDataArr = [NSDictionary]()
    
    var isPersonalProfileSelected = true
    
    var selectedProfileId = ""
    var selectedReasonId = ""
    
    var userProfileJson:NSDictionary!
    
    var selectedProfileDataDict:NSDictionary!
    
    var isAutoContinue_payBox = false
    
    var isOtherReasonSelected = false
    
    // variables for retrival process
    var retrival_eWalletDebitAllow = false
    var retrival_isCashPayment = false
    var retrival_isCardValidated = false
    var retrival_iUserProfileId = ""
    var retrival_iOrganizationId = ""
    var retrival_isPayByOrganization = false
    var retrival_vProfileEmail = ""
    var retrival_vProfileName = ""
    var retrival_ePaymentBy = ""
    var retrival_iTripReasonId = ""
    var retrival_reasonTitleOfId = ""
    var retrival_vReasonTitle = ""
    var retrival_selectedProfileDataDict:NSDictionary!
    
    var isFromRide = false
    var isFromDelivery = false
    var isFromDeliverAllCheckout = false
    var disableCashPayValue = ""
    var isFromMultiDelivery = false
    var isFromUFXCheckout = false
    var isFromRideLater = false
    var isFirstLoad = true
    var displayCardPayment = true
    
    var isOnlyCashOption = false
    
    var isPreferences = true//delivery preferences
    
    var isForGenie = false
    var hideCashForGenie = false
    var liveTrackUV:LiveTrackUV!
    
    var iIdProofImageId = ""
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.addBack()
            
            cntView = self.generalFunc.loadView(nibName: "SelectPaymentProfileScreenDesign", uv: self, contentView: scrollView)
            
            self.scrollView.addSubview(cntView)

            self.scrollView.bounces = false
            
            self.userProfileJson =  (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.cntView.frame.size = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.frame.height)
            
            selectProfileArrowImgView.transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
            GeneralFunctions.setImgTintColor(imgView: selectProfileArrowImgView, color: UIColor(hex: 0x272727))
            
            reasonArrowImgView.transform = CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180))
            GeneralFunctions.setImgTintColor(imgView: reasonArrowImgView, color: UIColor(hex: 0x272727))
            
            doneBtn.clickDelegate = self
            
            selectProfileView.layer.shadowOpacity = 0.5
            selectProfileView.layer.shadowOffset = CGSize(width: 0, height: 3)
            selectProfileView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            reaosnSelectView.layer.shadowOpacity = 0.5
            reaosnSelectView.layer.shadowOffset = CGSize(width: 0, height: 3)
            reaosnSelectView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            selectProfileView.handleClick { (instance) in
                self.findOrganizationList()
            }
            
            reaosnSelectView.handleClick { (instance) in
                self.openReasonList()
            }
            
            self.cntView.isHidden = true
            
            self.updateWalletAmount()
            
        }else if(type == 1){
            
            self.configRTL()
            
            self.userProfileJson =  (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if(self.useWalletLbl != nil){
                self.useWalletLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_WALLET_BALANCE"))"
                self.walletAmoLbl.text = Configurations.convertNumToAppLocal(numStr: userProfileJson.get("user_available_balance"))
                self.walletAmoLbl.textColor = SColors.Theme
            }
            if Configurations.isRTLMode() {
                walletAmoLbl.textAlignment = .right
            }else {
                walletAmoLbl.textAlignment = .left
            }
            
        }else if(type == 2){
            if(isFirstLoad == true){
                self.cntView.frame.size = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.frame.height)
                
                self.bottomProfileView.roundTo(corners:[.topLeft, .topRight], radius: 16)
                self.bottomProfileView.layer.addShadow(opacity: 0.9, radius: 2.0, UIColor.darkGray)
                self.bottomProfileView.isHidden = false
                self.bottomProfileView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.bottomProfileView.alpha = 1
                })
                
                if(userProfileJson.get("ENABLE_CORPORATE_PROFILE").uppercased() == "YES" && isFromRide && isFirstLoad){
                    self.bottomProfileViewHeight.constant = 80
                    
                    self.profileUpDownView.handleClick { (instance) in
                        
                        if(self.bottomProfileViewHeight.constant == 320){
                            self.view.layoutIfNeeded()
                            self.bottomProfileViewHeight.constant = 90
                            UIView.animate(withDuration: 0.3, animations: {
                                self.profileUpDownImgView.transform = CGAffineTransform(rotationAngle: .pi)
                                self.view.layoutIfNeeded()
                            })
                        }else{
                            self.view.layoutIfNeeded()
                            self.bottomProfileViewHeight.constant = 320
                            UIView.animate(withDuration: 0.3, animations: {
                                self.profileUpDownImgView.transform = .identity
                                self.view.layoutIfNeeded()
                            })
                        }
                    }
                }else{
                    self.bottomProfileViewHeight.constant = 15
                }
                
                isFirstLoad = false
                setData()
            }
            
            self.cntView.isHidden = false
        }
    }
  
    
    func setRetrivalData(){
        if(self.retrival_iUserProfileId != "" && self.retrival_selectedProfileDataDict != nil){
            isPersonalProfileSelected = false
            profileLbl.text = self.retrival_vProfileName
            self.selectedProfileId = self.retrival_iUserProfileId
            
            self.selectedProfileDataDict = self.retrival_selectedProfileDataDict
            
            self.reasonParentView.isHidden = false
            self.setBusinessProfileSelectedView(isShow:true)
            //self.reasonsViewHeight.constant = 85
            
            self.profileIconImgView.showImgLoader(.gray)
            self.profileIconImgView.sd_setImage(with: URL(string: self.retrival_selectedProfileDataDict.get("vImage")), placeholderImage: UIImage(named:"ic_no_icon"), options: SDWebImageOptions(rawValue: 0), completed: nil)
        }
        
        if(self.retrival_iTripReasonId != ""){
            self.selectedReasonId = self.retrival_iTripReasonId
            self.writeReasonView.isHidden = true
            //self.writeReasonViewHeight.constant = 0
            self.bottomProfileViewHeight.constant = 140
            self.isOtherReasonSelected = false
        }else if(self.retrival_vReasonTitle != ""){
            self.selectedReasonId = ""
            writeReasonTxtView.text = self.retrival_vReasonTitle
            self.isOtherReasonSelected = true
            self.profileUpDownView.isHidden = false
            self.bottomProfileViewHeight.constant = 140
            self.profileViewTopSpace.constant = 15
            
            UIView.animate(withDuration: 0.3) {
                self.profileUpDownImgView.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
        
        if(self.retrival_reasonTitleOfId != ""){
            self.reasonLbl.text = self.retrival_reasonTitleOfId
        }
        
        self.isPayByOrganization = self.retrival_isPayByOrganization
        
        if(self.isPayByOrganization == true){
            self.configPaymentOptionView(true)
        }else{
            self.configPaymentOptionView(false)
        }
        
        if(self.retrival_eWalletDebitAllow == true){
            self.useWalletChkBox.on = true
        }else{
            self.useWalletChkBox.on = false
        }
        
        if(self.retrival_isCashPayment == true){
            self.cashViewTapped()
        }else{
            self.selectCard()
            self.isCardValidated = self.retrival_isCardValidated
        }
    }
    
    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROFILE_PAYMENT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROFILE_PAYMENT")
        
        self.topWalletBgView.backgroundColor = SColors.Theme
        
        self.topWalletBgView.shadowColor = UIColor.black
        self.topWalletBgView.shadowOffset = CGSize.zero
        self.topWalletBgView.shadowRadius = 1.5
        self.topWalletBgView.shadowOpacity = 1
        self.topWalletBgView.shadowPath = UIBezierPath(roundedRect:self.topWalletBgView.bounds, cornerRadius:self.topWalletBgView.layer.cornerRadius).cgPath
        
        
        self.reasonHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REASON")
        self.hLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_PROFILE")
        self.writeReasonHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WRITE_REASON_BELOW")
        doneBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONE"))
        self.paymentHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_PAYMENT_METHOD_TXT")
        self.paymentDisableLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORGANIZATION_NOTE")
        
        self.useWalletLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USE_WALLET_BALANCE"))"
        self.cashPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_TXT").uppercased()
        self.cardPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pay online", key: "LBL_PAY_ONLINE_TXT").uppercased()
        
        self.addWalletBalLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACTION_ADD").uppercased()
        
        self.useWalletChkBox.createSysBox()
        
        self.useWalletView.layer.addShadow(opacity: 0.3, radius: 0.9, UIColor.darkGray)
        self.useWalletView.layer.roundCorners(radius: 12)
//        ic_card_payment
        self.cashPayModeView.layer.addShadow(opacity: 0.3, radius: 2, UIColor.darkGray)
        self.cashPayModeView.layer.roundCorners(radius: 14)
        
        self.cardPayModeView.layer.addShadow(opacity: 0.3, radius: 2, UIColor.darkGray)
        self.cardPayModeView.layer.roundCorners(radius: 14)
        
        if(Application.screenSize.height <= 568){
            self.paymentStackViewWidth.constant = 290
        }
        
        self.changeCardLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_ANOTEHR_CARD")
        self.changeCardLbl.handleClick { (instance) in
            let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
            paymentUV.isFromUFXPayMode = false
            self.push(uv: paymentUV)
        }
        
        if(self.userProfileJson.get("APP_PAYMENT_MODE") == "Card" || hideCashForGenie == true){
            self.addWalletBalLbl.isHidden = false
            isCashPayment = false
            self.cashPayModeView.isHidden = true
            self.cardPayModeView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: self.cashImgView, color: UIColor.black)
            GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: SColors.ThemeTxt)
            self.cardPayLbl.textColor = SColors.ThemeTxt
            self.cashPayModeView.backgroundColor = SColors.ThemeTxt
            
            let view = UIView.init(frame: self.cashPayModeView.bounds)
            view.backgroundColor = UIColor.clear
            self.paymentStackView.addArrangedSubview(view)
            
        }else if(self.userProfileJson.get("APP_PAYMENT_MODE") == "Cash"){
            self.addWalletBalLbl.isHidden = true
            isCashPayment = true
            self.cardPayModeView.isHidden = true
            self.cashPayModeView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: self.cashImgView, color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: UIColor.black)
            self.cashPayLbl.textColor = SColors.ThemeTxt
            self.cardPayModeView.backgroundColor = SColors.ThemeTxt
            
            let view = UIView.init(frame: self.cashPayModeView.bounds)
            view.backgroundColor = UIColor.clear
            self.paymentStackView.addArrangedSubview(view)
            
        }else{
            isCashPayment = true
            self.cashPayModeView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: self.cashImgView, color: SColors.ThemeTxt)
            GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: UIColor.black)
            self.cashPayLbl.textColor = SColors.ThemeTxt
            self.cardPayModeView.backgroundColor = SColors.ThemeTxt
        }
        
        let APPSTORE_MODE_IOS = GeneralFunctions.getValue(key: Utils.APPSTORE_MODE_IOS_KEY)
        
        if(userProfileJson.get("WALLET_ENABLE").uppercased() == "YES"){
            self.hideWalletView(isHide: false)
        }else{
            self.hideWalletView(isHide: true)
        }
        
        self.addWalletBalLbl.setClickHandler { (instance) in
             let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
            self.push(uv: manageWalletUV)
        }
        
        self.cashPayModeView.handleClick { (instance) in
            self.cashViewTapped()
        }
        
        self.cardPayModeView.handleClick { (instance) in
            self.cardViewTapped()
        }
        
        if(isFromRide || isFromDelivery){
            self.setRetrivalData()
        }
        
        
        if(isPersonalProfileSelected){
            setPersonalProfileSelection()
        }
        
        /* PAYMENT FLOW CHANGES */
        if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
            self.cardPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pay online", key: "LBL_PAY_ONLINE_TXT").uppercased()
            
        }else if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
            self.hideWalletView(isHide: true)
            let walletBal = Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)
            
            self.cardPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAY_BY_WALLET_TXT").uppercased() + " (\(walletBal))"
            self.cardImgView.image = UIImage.init(named: "ic_wallet")
            GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: SColors.blackColor)
        }/*.........*/
        
        if(self.disableCashPayValue != "" && isPreferences == true){
            
            //self.cardViewTapped()
            self.selectCard()
            self.cashPayModeView.isUserInteractionEnabled = false
            self.cashPayModeView.backgroundColor = UIColor.lightGray
            self.cashPayDisableLbl.isHidden = false
            self.cashPayDisableLbl.text = self.disableCashPayValue
            self.cashPayDisableLbl.textColor = UIColor.gray
        }
        if disableCashPayValue != "" {
            self.selectCard()
            self.cashPayModeView.isUserInteractionEnabled = false
            self.cashPayModeView.backgroundColor = UIColor.lightGray
            self.cashPayDisableLbl.isHidden = false
            self.cashPayDisableLbl.text = self.disableCashPayValue
            self.cashPayDisableLbl.textColor = UIColor.gray
        }
        
         
        if(isFromDeliverAllCheckout == true && displayCardPayment == false){
            self.cardPayModeView.isHidden = true
            let view = UIView.init(frame: self.cashPayModeView.bounds)
            view.backgroundColor = UIColor.clear
            self.paymentStackView.addArrangedSubview(view)
            self.cashPayDisableLbl.isHidden = true
            self.cashViewTapped()
        }
        
        if(isOnlyCashOption && self.isFromMultiDelivery){
            self.hideWalletView(isHide: true)
            self.cardPayModeView.isHidden = true
            let view = UIView.init(frame: self.cashPayModeView.bounds)
            view.backgroundColor = UIColor.clear
            self.paymentStackView.addArrangedSubview(view)
            self.cashPayDisableLbl.isHidden = true
            self.cashViewTapped()
        }
    }
    
    func setPersonalProfileSelection(){
        self.selectedProfileDataDict = nil
        profileIconImgView.image = UIImage(named: "ic_home_profile")
        profileLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PERSONAL")
        isPersonalProfileSelected = true
        selectedProfileId = ""
       // GeneralFunctions.setImgTintColor(imgView: profileIconImgView, color: SColors.Theme)
        
        self.reasonParentView.isHidden = true
       // self.reasonsViewHeight.constant = 0
        
        self.writeReasonView.isHidden = true
       // self.writeReasonViewHeight.constant = 0
        
        isCardValidated = false
        self.isPayByOrganization = false
    }
    
    func resetReason(){
        self.reasonLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_REASON")
        selectedReasonId = ""
        
        self.writeReasonTxtView.text = ""
        
        var reasonNameList = [String]()
        
        reasonNameList = self.selectedProfileDataDict.arrOf("tripreasons").compactMap({ (reason) -> String in
            return (reason as! NSDictionary).get("vReasonTitle")
        })
        
        reasonNameList.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT"))
        
        if(reasonNameList.count == 1){
            self.reasonLbl.text = reasonNameList[0]
            self.selectedReasonId = ""
            self.writeReasonView.isHidden = false
            self.setReasonTextView(isShow: true)
            self.isOtherReasonSelected = true
            
        }else{
            self.writeReasonView.isHidden = true
            self.setReasonTextView(isShow: false)
            self.isOtherReasonSelected = false
            self.hideKeyboard()
        }
        
    }
    
    func openReasonList(){
        if(self.selectedProfileId == ""){
            return
        }
        
        var reasonNameList = [String]()
        
        let arr_reasons = self.selectedProfileDataDict.arrOf("tripreasons")
        
        for i in 0..<arr_reasons.count{
            let tmp_dataDict = arr_reasons[i] as! NSDictionary
            reasonNameList.append(tmp_dataDict.get("vReasonTitle"))
        }
        
        reasonNameList.append(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT"))
        
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.selectedItem = self.reasonLbl.text!
        openListView.show(listObjects: reasonNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_REASON"), currentInst: openListView, handler: { (selectedItemId) in
            
            self.reasonLbl.text = reasonNameList[selectedItemId]
            
            if(selectedItemId == (reasonNameList.count - 1)){
                self.selectedReasonId = ""
                self.writeReasonView.isHidden = false
                self.setReasonTextView(isShow: true)
                self.isOtherReasonSelected = true
            }else{
                self.selectedReasonId = (arr_reasons[selectedItemId] as! NSDictionary).get("iTripReasonId")
                self.writeReasonView.isHidden = true
                self.isOtherReasonSelected = false
                self.setReasonTextView(isShow: false)
                self.hideKeyboard()
            }
            
        })
    }
    
    func findOrganizationList(){
        if(organizationDataArr.count == 0){
            let parameters = ["type":"DisplayUserOrganizationProfile", "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd()]
            
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        
                        let dataArr = dataDict.arrOf(Utils.message_str)
                        self.organizationDataArr.removeAll()
                        
                        self.addPersonalProfile()
                        
                        for i in 0 ..< dataArr.count{
                            let dataTemp = dataArr[i] as! NSDictionary
                            self.organizationDataArr.append(dataTemp)
                        }
                        
                        self.openOrganizationList()
                    }else{
                        self.addPersonalProfile()
                        self.openOrganizationList()
                        //                    self.generalFunc.setError(uv: self, isCloseScreen: true)
                        //                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message") == "" ? "LBL_TRY_AGAIN_TXT" : dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btn_id) in
                        ////                            self.close()
                        //                        })
                    }
                }else{
                    self.generalFunc.setError(uv: self, isCloseScreen: true)
                }
            })
        }else{
            self.openOrganizationList()
        }
    }
    
    func addPersonalProfile(){
        let personalProfileDataDict = NSMutableDictionary()
        personalProfileDataDict["vImage"] = "ic_personal"
        personalProfileDataDict["vProfileName"] = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PERSONAL")
        personalProfileDataDict["ePaymentBy"] = ""
        
        self.organizationDataArr.append(personalProfileDataDict)
    }
    
    func configPaymentOptionView(_ isHide:Bool){
        if(isHide){
            self.paymentDisableLbl.isHidden = false
            self.paymentDisableView.isHidden = false
            
            self.hideWalletView(isHide: true)
            
        }else{
            
            self.hideWalletView(isHide: false)
            self.paymentDisableLbl.isHidden = true
            self.paymentDisableView.isHidden = true
            self.paymentOptionView.isHidden = false
            self.paymentOptionViewHeight.constant = 175
        }
    }
    
    func hideWalletView(isHide:Bool = false){
        
        if(isHide){
            self.useWalletView.isHidden = true
            self.topWalletBgView.isHidden = true
        
            view.layoutIfNeeded() // force any pending operations to finish
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.walletViewHeight.constant = 0
                self.hLblTopSpace.constant = 5
                self.view.layoutIfNeeded()
            })
            
        }else{
            if(userProfileJson.get("WALLET_ENABLE").uppercased() == "YES" && GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
                self.useWalletView.isHidden = false
                self.topWalletBgView.isHidden = false
            
                view.layoutIfNeeded() // force any pending operations to finish
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.hLblTopSpace.constant = 20
                    self.walletViewHeight.constant = 80
                    self.view.layoutIfNeeded()
                })
                
            }else{
                self.useWalletView.isHidden = true
                self.topWalletBgView.isHidden = true
                view.layoutIfNeeded() // force any pending operations to finish
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.walletViewHeight.constant = 0
                    self.hLblTopSpace.constant = 5
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func openOrganizationList(){
        var orgNameList = [String]()
        
        for i in 0..<organizationDataArr.count{
            let tmp_dataDict = organizationDataArr[i]
            
            orgNameList.append(tmp_dataDict.get("vProfileName"))
        }
         
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.selectedItem = self.profileLbl.text!
        openListView.show(listObjects: orgNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_PROFILE"), currentInst: openListView, handler: { (selectedItemId) in
            
            if(selectedItemId == 0){
                self.setPersonalProfileSelection()
                self.configPaymentOptionView(false)
                self.setBusinessProfileSelectedView(isShow:false)
            }else{
                self.isPersonalProfileSelected = false
                let item = self.organizationDataArr[selectedItemId]
                
                self.selectedProfileDataDict = item
                
                self.selectedProfileId = item.get("iUserProfileId")
                self.profileIconImgView.showImgLoader(.gray)
                self.profileLbl.text = item.get("vProfileName")
                self.profileIconImgView.sd_setImage(with: URL(string: item.get("vImage")), placeholderImage: UIImage(named:"ic_no_icon"), options: SDWebImageOptions(rawValue: 0), completed: nil)
                
                self.reasonParentView.isHidden = false
                
                self.resetReason()
                
                if(item.get("ePaymentBy").uppercased() == "ORGANIZATION"){
                    self.isPayByOrganization = true
                    self.configPaymentOptionView(true)
                }else{
                    self.isPayByOrganization = false
                    self.configPaymentOptionView(false)
                }
                self.setBusinessProfileSelectedView(isShow:true)
            }
        })
    }
    
    func setBusinessProfileSelectedView(isShow:Bool){
        
        self.view.layoutIfNeeded()
        
        if(isShow){
            if self.writeReasonView.isHidden == true {
                self.bottomProfileViewHeight.constant = 130
            }else{
            self.bottomProfileViewHeight.constant = 320
            }
            
        }else{
            
            self.setReasonTextView(isShow:false)
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
        })
       
    }
    
    func setReasonTextView(isShow:Bool){
        
        if(isShow){
            UIView.animate(withDuration: 0.3) {
                self.profileUpDownImgView.transform = .identity
            }
            
            self.profileUpDownView.isHidden = false
            self.profileViewTopSpace.constant = 15
            
            self.view.layoutIfNeeded()
            self.bottomProfileViewHeight.constant = 320
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view.layoutIfNeeded()
            })
        }else{
            
            
            self.profileUpDownView.isHidden = true
            self.profileViewTopSpace.constant = 0
            
            self.view.layoutIfNeeded()
            if(self.reasonParentView.isHidden == false){
                self.bottomProfileViewHeight.constant = 125
            }else{
                self.bottomProfileViewHeight.constant = 80
            }
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view.layoutIfNeeded()
            })
        }
        
        
    }
    
    func cashViewTapped(){
        
        view.layoutIfNeeded() // force any pending operations to finish
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.cardDetailViewHeight.constant = 0
            self.view.layoutIfNeeded()
        })
        
        self.isCashPayment = true
        
        self.cardPayModeView.backgroundColor = SColors.ThemeTxt
        self.cashPayModeView.backgroundColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: self.cashImgView, color: SColors.ThemeTxt)
        GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: UIColor.black)
        self.cashPayLbl.textColor = SColors.ThemeTxt
        self.cardPayLbl.textColor = UIColor.black
        
        self.cardDetailView.isHidden = true

    }
    
    func cardViewTapped(){
        /* PAYMENT FLOW CHANGES */
        if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
            if(GeneralFunctions.isUserCardExist(userProfileJson: self.userProfileJson)){
                showPaymentBox()
            }else{
                let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
                paymentUV.isFromUFXPayMode = false
                self.push(uv: paymentUV)
            }
        }else if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
            self.selectCard()
        }/*.........*/
    }
    
    func showPaymentBox(){
        self.selectCard()
//        let openConfirmCardView = OpenConfirmCardView(uv: self, containerView: self.navigationController != nil ? self.navigationController!.view : self.view)
//        openConfirmCardView.show(checkCardMode: "") { (isCheckCardSuccess, dataDict) in
//            self.selectCard()
//
//            if(self.isAutoContinue_payBox == true){
//                self.doneBtn.btnTapped()
//            }
//        }
    }
    
    func selectCard(){
        
        view.layoutIfNeeded() // force any pending operations to finish
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.cardDetailViewHeight.constant = 55
            self.cardDetailView.isHidden = true
            self.view.layoutIfNeeded()
        })
        self.isCardValidated = true
        self.isCashPayment = false
        
        self.cardPayModeView.backgroundColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: self.cashImgView, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.cardImgView, color: SColors.ThemeTxt)
        self.cardPayLbl.textColor = SColors.ThemeTxt
        self.cashPayLbl.textColor = UIColor.black
        if(self.disableCashPayValue != ""){
            if self.cashPayModeView.isUserInteractionEnabled == false {
            self.cashPayModeView.backgroundColor = UIColor.lightGray
            }else{
                self.cashPayModeView.backgroundColor = SColors.ThemeTxt
            }
        }else{
            self.cashPayModeView.backgroundColor = SColors.ThemeTxt
        }
        
        
        if(GeneralFunctions.isUserCardExist(userProfileJson: self.userProfileJson) && self.userProfileJson.get("APP_PAYMENT_MODE") != "Cash"){
            self.cardDetailView.isHidden = false
            self.cardDetailLbl.text = userProfileJson.get("vCreditCard")
        }
        
        if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) != "1"){
            view.layoutIfNeeded() // force any pending operations to finish
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.cardDetailViewHeight.constant = 0
                self.cardDetailView.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
     
    }
    
    func updateWalletAmount(){
       
        let parameters = ["type":"GetMemberWalletBalance", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                //                Utils.printLog(msgData: "dataDict:Balance:\(dataDict)")
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: dataDict.get("user_available_balance_amount") as AnyObject)   // Without Currency Symbole
                    
                    GeneralFunctions.saveValue(key: "user_available_balance", value: dataDict.get("user_available_balance") as AnyObject) // With Currency Symbole
                    
                    
                    if(self.userProfileJson.get("user_available_balance") != dataDict.get("MemberBalance")){
                        GeneralFunctions.saveValue(key: Utils.IS_WALLET_AMOUNT_UPDATE_KEY, value: "true" as AnyObject)
                    }
                    
                    
                    
                    let walletBal = Configurations.convertNumToAppLocal(numStr: GeneralFunctions.getValue(key: "user_available_balance") as! String)
                    
                    self.walletAmoLbl.text = walletBal
                    
                    if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
                        
                        self.cardPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAY_BY_WALLET_TXT").uppercased() + " (\(walletBal))"
                        
                    }
                    
                }
                
            }else{
               
               self.updateWalletAmount()
            }
        })
    }
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.doneBtn){
            
            if(self.userProfileJson.get("APP_PAYMENT_MODE") == "Cash"){
                isCashPayment = true
            }
            
            if(self.selectedProfileId != "" && (self.selectedReasonId == "" && self.isOtherReasonSelected == false)){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTRICT_SEL_REASON"), uv: self)
                return
            }
            
            if(self.selectedProfileId != "" && (self.isOtherReasonSelected == true  && writeReasonTxtView.text! == "")){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTRICT_ADD_REASON"), uv: self)
                return
            }
            
            
            if(isCashPayment == false && isCardValidated == false && isPayByOrganization == false){
                isAutoContinue_payBox = true
                self.cardViewTapped()
                return
            }
            
            if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
                if(GeneralFunctions.isUserCardExist(userProfileJson: self.userProfileJson) == false && isCashPayment == false){
                    let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
                    paymentUV.isFromUFXPayMode = false
                    self.push(uv: paymentUV)
                    return
                }
            }
            
            if(self.liveTrackUV != nil){
                self.liveTrackUV.genieFinalCardPayment = true
                self.liveTrackUV.isWalletDebitAllow = self.useWalletChkBox.on ? "Yes" : "No"
                self.close()
                return
            }
            
            if(isForGenie == true){
                self.performSegue(withIdentifier: "unwindToGenieFindStore", sender: self)
            }
            
            if(isFromDeliverAllCheckout == true){
                self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
            }
            
            if(isFromRide == true || isFromDelivery == true){
                self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
            }
            
            if(isFromMultiDelivery == true){
                self.performSegue(withIdentifier: "unwindToAskForPayUV", sender: self)
            }
            
            if(isFromUFXCheckout == true){
                self.performSegue(withIdentifier: "unwindToUFXCheckOut", sender: self)
            }
            
        }
    }
}
