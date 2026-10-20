

import UIKit
import SysBaseLib

class AskForPay: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stemMainAppThemeView: UIView!
    @IBOutlet weak var stepMainView: UIView!
    @IBOutlet weak var stepStackView: UIStackView!
    @IBOutlet weak var firstStepView: UIView!
    @IBOutlet weak var firstStepLbl: UILabel!
    @IBOutlet weak var secondStepView: UIView!
    @IBOutlet weak var secondStepLbl: UILabel!
    @IBOutlet weak var thirdStepView: UIView!
    @IBOutlet weak var thirdStepLbl: UILabel!
    var stepAnchorView:TriangleView!
    var stepAnchorView2:TriangleView!
    
    @IBOutlet weak var bookLaterBtn: MyButton!
    @IBOutlet weak var nextBtn: MyButton!
    @IBOutlet weak var fairContainerStackView: UIStackView!
    @IBOutlet weak var fairHoldViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fairHoldView: UIView!
    @IBOutlet weak var fairContainerStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var responsibleForPaymentLbl: UILabel!
    @IBOutlet weak var senderview: UIView!
    @IBOutlet weak var recView: UIView!
    @IBOutlet weak var anyRecView: UIView!
    @IBOutlet weak var anyRecfareLbl: UILabel!
    @IBOutlet weak var anyRecHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var receiverSubView: UIView!
    @IBOutlet weak var recViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var applyPromoCodelbl: UILabel!
    @IBOutlet weak var removePromoCodeImgView: UIImageView!
    
    @IBOutlet weak var vehicleTypeImgView: UIImageView!
    @IBOutlet weak var vehicleTypeName: MyLabel!
    @IBOutlet weak var addressLbl: MyLabel!
    @IBOutlet weak var chargesHLbl: MyLabel!
    
    // Bottom Promo View
    @IBOutlet weak var promoViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var promoViewHeaderLbl: UILabel!
    @IBOutlet weak var promoViewImagView: UIImageView!
    @IBOutlet weak var enterPromolbl: UILabel!
    @IBOutlet weak var closePromoImgView: UIImageView!
    @IBOutlet weak var promoTextField: UITextField!
    @IBOutlet weak var applyPromoLblBtn: UILabel!
    @IBOutlet weak var addPromoTxtView: UIView!
    @IBOutlet weak var applyPromoBgView: UIView!
    @IBOutlet weak var promoCntView: UIView!
    
    @IBOutlet weak var bgViewPayemnetBottomSpace: NSLayoutConstraint!
    // OutStanding Amount related outlets
    @IBOutlet weak var payForBgView: UIView!
    @IBOutlet weak var outStandingAmtTopView: UIView!
    @IBOutlet weak var outStandingAmtLbl: MyLabel!
    @IBOutlet weak var outStandingAmtValueLbl: MyLabel!
    @IBOutlet weak var payNowView: UIView!
    @IBOutlet weak var payNowViewHeight: NSLayoutConstraint!
    @IBOutlet weak var adjustAmtView: UIView!
    @IBOutlet weak var cancelOutAmtBtn: MyButton!
    @IBOutlet weak var payNowLbl: MyLabel!
    @IBOutlet weak var adjustAmtLbl: MyLabel!
    @IBOutlet weak var payNowImgView: UIImageView!
    @IBOutlet weak var adjustAmtImgView: UIImageView!
    
    @IBOutlet weak var infoImgView: UIImageView!
    var outStandingAmtView:UIView!
    var outStandingAmtBGView:UIView!
    var checkCardMode = ""
    var isOutStandingAmtSkipped = false
    
    var confirmCardDialogView:UIView!
    var confirmCardBGDialogView:UIView!
    var isCardValidated = false
    
    //Confirm Card Outlets
    @IBOutlet weak var confirmCardHLbl: MyLabel!
    @IBOutlet weak var confirmCardVLbl: MyLabel!
    @IBOutlet weak var confirmCardLbl: MyLabel!
    @IBOutlet weak var changeCardLbl: MyLabel!
    @IBOutlet weak var cancelCardLbl: MyLabel!
    
    // Promocode Outlets
    @IBOutlet weak var bottomPromoView: UIView!
    @IBOutlet weak var promoLeadingImgView: UIImageView!
    @IBOutlet weak var promoViewHLbl: MyLabel!
    @IBOutlet weak var promoTxtField: MyTextField!
    @IBOutlet weak var confirmPromoLbl: MyLabel!
    @IBOutlet weak var promoCodeValueLbl: MyLabel!
    @IBOutlet weak var cancelPromoLbl: MyLabel!
    @IBOutlet weak var promoCodeValueSubHLbl: MyLabel!
    var promoCodeDialogView:UIView!
    var promoCodeBGDialogView:UIView!
    
    @IBOutlet weak var applyPromoCodeView: UIView!
    @IBOutlet weak var anyRecLbl: UILabel!
    @IBOutlet weak var anyRecCheckImgView: UIImageView!
    @IBOutlet weak var recLbl: UILabel!
    @IBOutlet weak var senderLbl: UILabel!
    @IBOutlet weak var recCheckImgView: UIImageView!
    @IBOutlet weak var fareDetailView: UIView!
    @IBOutlet weak var senderCheckImgView: UIImageView!
    var isPageLoaded = false
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()

    var PAGE_HEIGHT:CGFloat = 700
    
    var fairViewArray = [UIView]()
    var disTimeArray = [NSDictionary]()
    var disTimeArrayTemp = [NSDictionary]()
    var appliedPromoCode = ""
    var selectedCabTypeId = ""
    var isCashPay = true
    var totalDistance = 0.0
    var totalDuration = 0.0
    var userProfileJson:NSDictionary!
    var isDeliveryLater = false
    
    var resFroPaySelected = ""
    var finalArray:NSMutableArray!
    var selectedRecViewIndex = ""
    var finalReceiverViewHeightConstant = 50.0
    var scrollViewContetntSize:CGSize!
    
    var remvePromoGesture = UITapGestureRecognizer()
    var isPromoCodeAppliedManually = false
    var dataDictOutStanding:NSDictionary!
    
    var eWalletDebitAllow = false
    var addressTxt = ""
    var infoTxt = ""
    var carName = ""
    
    var deliveryDetailsListUV:DeliveryDetailsListUV!
    var isOnlyCashOtion = false
    
    var selectedDate = ""
    var selectedTimeZone = ""
    var newScheduleView = ListBottomSheetViewTimePicker()
    var datesAr = [String]()
    var dayAr = [String]()
    var datesDisplay = [String]()
    var datesPass = [String]()
    var selectedIndexCollection = 0
    var selectedIndexPriviousCollection = 0
    var ridelaterNew = false
    var selctedIndex = 0
    var selectedDateTimeNew = ""
    var selectedDateTimeNewPass = ""
    var strPassDate = ""
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "AskForPayScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
           
            self.contentView.isHidden = true
            self.finalArray = ((GeneralFunctions.getValue(key: Utils.DELIVERY_DETAIL_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
            
            self.addBack()
            self.setData()
            
        }else if(type == 1){
            
            self.configRTL()
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.userProfileJson = userProfileJson
            
            self.getOutStandingAmount()
            
        }else if(type == 2){
            if isPageLoaded == false{
                createTrianleViewforMultiDeliverySteps(stepNo:3)
                
                self.stepMainView.isHidden = false
                
                UIView.animate(withDuration: 0.4,
                               animations: {
                                
                                self.stepMainView.alpha = 1.0
                                
                },  completion: { finished in
                })
                self.createSelcetionView()
                self.recViewHeightConstant.constant = 50
                
                self.continueEstimateFare()
                self.isPageLoaded = true
                
                
            }
        }
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData()
    {
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_NEW_BOOKING_TXT")
        
        self.addressLbl.text = self.addressTxt
        self.promoCntView.layer.addShadow(opacity: 0.7, radius: 1.5, UIColor.lightGray)
        self.promoCntView.layer.roundCorners(radius: 8)
        
        self.fairHoldView.layer.addShadow(opacity: 0.7, radius: 1.5, UIColor.lightGray)
        self.fairHoldView.layer.roundCorners(radius: 8)
        
        self.payForBgView.layer.addShadow(opacity: 0.7, radius: 1.5, UIColor.lightGray)
        self.payForBgView.layer.roundCorners(radius: 8)
        
        self.nextBtn.clickDelegate = self
        self.nextBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_NOW"))
        
        self.bookLaterBtn.clickDelegate = self
        self.bookLaterBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_LATER"))
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        if(userProfileJson.get("DELIVERY_LATER_BOOKING_ENABLED").uppercased() == "NO"){
            self.bookLaterBtn.isHidden = true
        }
        self.fairHoldView.isHidden = true
        

        
        self.responsibleForPaymentLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_RESPONSIBLE_FOR_PAYMENT_TXT")
        
        if !userProfileJson.get("APP_PAYMENT_MODE").contains("Cash")
        {
            self.resFroPaySelected = "Sender"
            self.isCashPay = false
            self.responsibleForPaymentLbl.isHidden = true
            self.recView.isHidden = true
            self.anyRecView.isHidden = true
            self.senderview.isHidden = true
            self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - CGFloat(finalReceiverViewHeightConstant) - 100)
            self.payForBgView.isHidden = true
            
        }
        else if userProfileJson.get("APP_PAYMENT_MODE") != "Cash"
        {
        } else
        {
            self.isCashPay = true
        }
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") == true && (GeneralFunctions.getValue(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") as! String).uppercased() == "YES" && self.recView.isHidden != true && (GeneralFunctions.getValue(key: "SINGLE_TO_MULTI") as! Bool) == true){
            
            self.bgViewPayemnetBottomSpace.constant = -50
            self.anyRecView.isHidden = true
            self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - CGFloat(finalReceiverViewHeightConstant) - 50)
        }
        
        self.senderLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_SENDER_TXT").uppercased()
        self.recLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_ANY_RECIPIENT").uppercased()
        self.anyRecLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_EACH_RECIPIENT").uppercased()
        self.anyRecCheckImgView.image = UIImage.init(named: "ic_select_false")
        self.recCheckImgView.image = UIImage.init(named: "ic_select_false")
        self.senderCheckImgView.image = UIImage.init(named: "ic_select_false")
        GeneralFunctions.setImgTintColor(imgView: self.anyRecCheckImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.recCheckImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.senderCheckImgView, color: SColors.Theme)
        
        let senderTapGesture = UITapGestureRecognizer()
        senderTapGesture.addTarget(self, action: #selector(self.senderTapped))
        self.senderview.isUserInteractionEnabled = true
        self.senderview.addGestureRecognizer(senderTapGesture)
        
        let recTapGesture = UITapGestureRecognizer()
        recTapGesture.addTarget(self, action: #selector(self.recTapped))
        self.recView.isUserInteractionEnabled = true
        self.recView.addGestureRecognizer(recTapGesture)
        
        let anyRecGesture = UITapGestureRecognizer()
        anyRecGesture.addTarget(self, action: #selector(self.anyRecTapped))
        self.anyRecView.isUserInteractionEnabled = true
        self.anyRecView.addGestureRecognizer(anyRecGesture)
        
//        self.senderview.roundCorners([.topLeft, .topRight], radius: 8)
//        self.anyRecView.roundCorners([.bottomLeft, .bottomRight], radius: 8)
        
        self.applyPromoCodelbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_APPLY_COUPON").uppercased()
       // self.applyPromoCodelbl.textColor = UIColor(hex: 0x1e5b99)
        if Configurations.isRTLMode() == true{
            var arrowImg = UIImage(named: "ic_arrow_right")
            arrowImg = arrowImg?.rotate(180)
            self.removePromoCodeImgView.image = arrowImg?.tintTo(color: UIColor.lightGray)
        }
        GeneralFunctions.setImgTintColor(imgView: self.removePromoCodeImgView, color: UIColor.lightGray)
        
        GeneralFunctions.setImgTintColor(imgView: self.promoLeadingImgView, color: SColors.Theme)
        let addPromoGesture = UITapGestureRecognizer()
        addPromoGesture.addTarget(self, action: #selector(self.promoTapped))
        self.bottomPromoView.isUserInteractionEnabled = true
        self.bottomPromoView.addGestureRecognizer(addPromoGesture)
        
        remvePromoGesture = UITapGestureRecognizer()
        remvePromoGesture.addTarget(self, action: #selector(self.removeTapped))
        self.removePromoCodeImgView.isUserInteractionEnabled = true
        self.removePromoCodeImgView.addGestureRecognizer(remvePromoGesture)
        
        self.chargesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHARGES_TXT")
     
    }
    
    @objc func senderTapped()
    {
        isOnlyCashOtion = false
        if resFroPaySelected != "Sender"
        {
            if self.recViewHeightConstant.constant != 50
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - CGFloat(finalReceiverViewHeightConstant) + 50)
            }
            self.receiverSubView.isHidden = true
            view.layoutIfNeeded()
            self.recViewHeightConstant.constant = 50
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.senderCheckImgView.image = UIImage.init(named: "ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.senderCheckImgView, color: SColors.Theme)
            
            resFroPaySelected = "Sender"
           
            self.recCheckImgView.image = UIImage.init(named: "ic_select_false")
            self.anyRecCheckImgView.image = UIImage.init(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.recCheckImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: self.anyRecCheckImgView, color: SColors.Theme)
            
            if self.anyRecHeightConstant.constant == 80
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - 30)
            }
            
            self.anyRecfareLbl.isHidden = true
            view.layoutIfNeeded()
            self.anyRecHeightConstant.constant = 50
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
    @objc func recTapped()
    {
        
        isOnlyCashOtion = true
        isOutStandingAmtSkipped = false
        if resFroPaySelected != "Receiver"
        {
            if self.recViewHeightConstant.constant == 50
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height + CGFloat(finalReceiverViewHeightConstant) - 50)
            }
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") == true && (GeneralFunctions.getValue(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") as! String).uppercased() == "YES" && (GeneralFunctions.getValue(key: "SINGLE_TO_MULTI") as! Bool) == true){
                self.selectedRecViewIndex = "0"
            }else{
                self.receiverSubView.isHidden = false
                view.layoutIfNeeded()
                self.recViewHeightConstant.constant = CGFloat(finalReceiverViewHeightConstant)
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            
            
            self.recCheckImgView.image = UIImage.init(named: "ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.recCheckImgView, color: SColors.Theme)
            resFroPaySelected = "Receiver"
           
            
            self.senderCheckImgView.image = UIImage.init(named: "ic_select_false")
            self.anyRecCheckImgView.image = UIImage.init(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.senderCheckImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: self.anyRecCheckImgView, color: SColors.Theme)
            
            if self.anyRecHeightConstant.constant == 80
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - 30)
            }
            
            if(GeneralFunctions.isKeyExistInUserDefaults(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") == true && (GeneralFunctions.getValue(key: "ENABLE_MULTI_VIEW_IN_SINGLE_DELIVERY") as! String).uppercased() == "YES" && (GeneralFunctions.getValue(key: "SINGLE_TO_MULTI") as! Bool) == true){
            }else{
                self.anyRecfareLbl.isHidden = true
                view.layoutIfNeeded()
                self.anyRecHeightConstant.constant = 50
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            
        }
    }
    
    @objc func anyRecTapped()
    {
        isOnlyCashOtion = true
        isOutStandingAmtSkipped = false
        if resFroPaySelected != "Individual"
        {
            if self.recViewHeightConstant.constant != 50
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height - CGFloat(finalReceiverViewHeightConstant) + 50)
            }
            self.receiverSubView.isHidden = true
            view.layoutIfNeeded()
            self.recViewHeightConstant.constant = 50
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.anyRecCheckImgView.image = UIImage.init(named: "ic_select_true")
            GeneralFunctions.setImgTintColor(imgView: self.anyRecCheckImgView, color: SColors.Theme)
            resFroPaySelected = "Individual"
           
            self.senderCheckImgView.image = UIImage.init(named: "ic_select_false")
            self.recCheckImgView.image = UIImage.init(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: self.recCheckImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: self.senderCheckImgView, color: SColors.Theme)
            
            
            if self.anyRecHeightConstant.constant == 50
            {
                self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height + 30)
            }
            
            view.layoutIfNeeded()
            self.anyRecHeightConstant.constant = 80
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.anyRecfareLbl.isHidden = false
            })
            
        }
    }
    
    
    
    /**
     This function is used to show promo code view on screen.
     */
    @objc func promoTapped(){
        let selectPromoCodeUV = GeneralFunctions.instantiateViewController(pageName: "SelectPromoCodeUV") as! SelectPromoCodeUV
        selectPromoCodeUV.appliedPromoCode = appliedPromoCode
        selectPromoCodeUV.isFormAskForPayUV = true
        selectPromoCodeUV.isPromoCodeAppliedManually = isPromoCodeAppliedManually
        selectPromoCodeUV.currentCabgeneralType = "Delivery"
        selectPromoCodeUV.deliveryLocations = self.disTimeArrayTemp.convertToJson().condenseWhitespace()
        self.push(uv: selectPromoCodeUV)
    }
    
    @objc func removeTapped(){
       
        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_COUPON_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
            
            if(btnClickedIndex == 0){
                
                self.appliedPromoCode = ""
                self.continueEstimateFare()
            }
        })
        
    }
    
    /**
     This function is used to close or remove promo code view from screen.
     */
    @objc func closePromoView(){
        if(promoCodeBGDialogView != nil){
            promoCodeBGDialogView.removeFromSuperview()
            promoCodeBGDialogView = nil
        }
        
        if(promoCodeDialogView != nil){
            promoCodeDialogView.removeFromSuperview()
            promoCodeDialogView = nil
        }
        
    }
    
    /**
     This function is used to verify entered promo code - removed OR entered.
     */
    @objc func checkPromoCode(){
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        if(self.appliedPromoCode != "" && Utils.getText(textField: self.promoTxtField.getTextField()!) == ""){
            self.appliedPromoCode = ""
            closePromoView()
            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMO_REMOVED"))
           
            self.continueEstimateFare()
            return
        }
        
        let promoEntered = Utils.checkText(textField: self.promoTxtField.getTextField()!) ? (Utils.getText(textField: self.promoTxtField.getTextField()!).contains(" ") ? Utils.setErrorFields(textField: self.promoTxtField.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMO_INVALIED")) : true) : Utils.setErrorFields(textField: self.promoTxtField.getTextField()!, error: required_str)
        
        if(promoEntered){
            applyPromoCodeView(appliedPromoCode: Utils.getText(textField: self.promoTxtField.getTextField()!))
        }
    }
    
    
    func applyPromoCodeView(appliedPromoCode:String)
    {
        
        let parameters = ["type":"CheckPromoCode","PromoCode": appliedPromoCode, "iUserId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.closePromoView()
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                  
                    self.appliedPromoCode = appliedPromoCode
                  
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMO_APPLIED"))
                    self.continueEstimateFare()
              
                    
                }else if(dataDict.get("Action") == "01"){
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMO_USED"))
                    
                }else{
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROMO_INVALIED"))
                    //                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func createSelcetionView()
    {
        self.receiverSubView.isHidden = true
        var currentYposition:CGFloat = 0
        var currentPosition = 0
        for i in 0..<self.finalArray.count
        {
            let viewCus = self.generalFunc.loadView(nibName: "ASkForPaySelView", uv: self, isWithOutSize: true)
            let frame = CGRect(x: 0, y: currentYposition, width: self.recView.frame.width, height: 40)
            viewCus.frame = frame
            viewCus.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
            
            let lblValue = viewCus.subviews[0] as! UILabel
            let radioImagview = viewCus.subviews[1] as! UIImageView
            
            radioImagview.image = UIImage.init(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: radioImagview, color: SColors.Theme)
          
            var recName = ""
            let array = self.finalArray[i] as! NSArray
            for i in 0..<array.count{
                let item = array[i] as! NSDictionary
                if item.get("iDeliveryFieldId") == "2" && item.get("eInputType") == "Text"
                {
                    recName = item.get("text")
                }
            }
            
            lblValue.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_RECIPIENT")) \(Configurations.convertNumToAppLocal(numStr: "\(i + 1)")) (\(recName))"
            
            let selTapGesture = UITapGestureRecognizer()
            selTapGesture.addTarget(self, action: #selector(self.selectionTapped(sender:)))
            radioImagview.tag = i
            radioImagview.isUserInteractionEnabled = true
            radioImagview.addGestureRecognizer(selTapGesture)
            
            
            self.receiverSubView.addSubview(viewCus)
            
            self.finalReceiverViewHeightConstant = Double(self.finalReceiverViewHeightConstant + 40)
            
            currentYposition = currentYposition + 40
            currentPosition = currentPosition + 1
            
            if(Configurations.isRTLMode()){
                lblValue.textAlignment = .right
            }else{
                lblValue.textAlignment = .left
            }
        }
    }
    
    @objc func selectionTapped(sender:UITapGestureRecognizer)
    {
        let radioImgView = self.receiverSubView.subviews[(sender.view?.tag)!].subviews[1] as! UIImageView
        
        if self.selectedRecViewIndex != ""
        {
            let radioDeImgView = self.receiverSubView.subviews[Int(self.selectedRecViewIndex)!].subviews[1] as! UIImageView
            
            radioDeImgView.image = UIImage.init(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: radioDeImgView, color: SColors.Theme)
        }
        
        self.selectedRecViewIndex = String((sender.view?.tag)!)
        
        radioImgView.image = UIImage.init(named: "ic_select_true")
        GeneralFunctions.setImgTintColor(imgView: radioImgView, color: SColors.Theme)
    }
    
    func continueEstimateFare(){
       
        let parameters = ["type":"getEstimateFareDetailsArr","SelectedCar": self.selectedCabTypeId, "distance":String(self.totalDistance), "time": String(self.totalDuration), "iUserId": GeneralFunctions.getMemberd(), "PromoCode":self.appliedPromoCode,"details_arr": self.disTimeArray.convertToJson().condenseWhitespace(), "eType":"Multi-Delivery", "userType":Utils.appUserType,"totNoRecipient":String(self.finalArray.count),"tDeliveryLocations" : self.disTimeArrayTemp.convertToJson().condenseWhitespace()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { [self] (response) -> Void in
            
            //            print("Response:\(response)")
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                   
                    self.totalDistance = Double(dataDict.get("distance_multi"))!
                    self.totalDuration = Double(dataDict.get("time_multi"))!
                    if dataDict.get("tInfoText") != "" {
                        self.infoImgView.isHidden = false
                        self.infoImgView.image = UIImage(named: "ic_info")!.tintTo(color: SColors.Theme)!
                       var tempAry  =  dataDict.arrOf(Utils.message_str)
                        self.infoTxt = dataDict.get("tInfoText")
                        //var strTemp = tempAry[]
                        //strTemp.get
                        //var strTe = strTemp.get
                        self.infoImgView.handleClick { (instance) in
                            self.handleInfo()
                        }
                    }else{
                        self.infoImgView.isHidden = true
                    }
                    self.contentView.alpha = 0
                    self.contentView.isHidden = false
                    UIView.animate(withDuration: 0.5, animations: {
                        self.contentView.alpha = 1
                    }, completion: {
                        finished in
                        self.contentView.isHidden = false
                    })
                    
                    self.vehicleTypeImgView.sd_setImage(with: URL(string: dataDict.get("vehicleImage")), placeholderImage: UIImage(named: "ic_no_icon")!,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    })
                    
                    if self.appliedPromoCode != ""{
                        self.remvePromoGesture = UITapGestureRecognizer()
                        self.remvePromoGesture.addTarget(self, action: #selector(self.removeTapped))
                        self.removePromoCodeImgView.isUserInteractionEnabled = true
                        self.removePromoCodeImgView.addGestureRecognizer(self.remvePromoGesture)
                        
                        self.applyPromoCodelbl.isHidden = true
                        self.promoCodeValueLbl.isHidden = false
                        self.promoCodeValueSubHLbl.isHidden = false
                        self.removePromoCodeImgView.image = UIImage.init(named: "ic_remove")
                        GeneralFunctions.setImgTintColor(imgView: self.removePromoCodeImgView, color: UIColor.black)
                        
                        self.promoCodeValueLbl.textColor = SColors.Theme
                        self.promoCodeValueSubHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLIED_COUPON_CODE")
                        self.promoCodeValueLbl.text = self.appliedPromoCode
                    }else{
                        self.appliedPromoCode = ""
                        self.applyPromoCodelbl.isHidden = false
                        self.promoCodeValueLbl.isHidden = true
                        self.promoCodeValueSubHLbl.isHidden = true
                        self.removePromoCodeImgView.image = UIImage.init(named: "ic_arrow_right")
                        if Configurations.isRTLMode() == true{
                            var arrowImg = UIImage(named: "ic_arrow_right")
                            arrowImg = arrowImg?.rotate(180)
                            self.removePromoCodeImgView.image = arrowImg?.tintTo(color: UIColor.lightGray)
                        }
                        GeneralFunctions.setImgTintColor(imgView: self.removePromoCodeImgView, color: UIColor.lightGray)
                        
                        self.removePromoCodeImgView.removeGestureRecognizer(self.remvePromoGesture)
                    }
                 
//                    let fareInDigits = Double(dataDict.get("total_fare_amount"))! / Double(self.finalArray.count).roundTo(places: 2)
                    //self.anyRecfareLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_RECIPIENT_PAY_INST_TXT") + " " + dataDict.get("vSymbol") + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", fareInDigits)) + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_AMOUNT")
                    
                    //self.anyRecfareLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_RECIPIENT_PAY_INST_TXT") + " " + GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: dataDict.get("EachRecipeintAmount"), addCurrncy: true, currencySymbol: dataDict.get("vSymbol")) + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_AMOUNT")
                    
                    //self.anyRecfareLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_RECIPIENT_PAY_INST_TXT") + " " + dataDict.get("vSymbol") + dataDict.get("EachRecipeintAmount") + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_AMOUNT")
                    let finalAmount = Double(dataDict.get("EachRecipeintAmount"))?.roundTo(places: 2)
                    self.anyRecfareLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_MULTI_RECIPIENT_PAY_INST_TXT") + " " + dataDict.get("vSymbol") + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", finalAmount ?? 0)) + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_AMOUNT")
                    self.fairHoldView.isHidden = false
                    self.addFareDetails(msgArr: dataDict.arrOf(Utils.message_str))
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
        })
    }

    func addFareDetails(msgArr:NSArray){
        
        let _:CGFloat = 0
        _ = 0
        
        for i in 0..<fairViewArray.count
        {
            fairViewArray[i].removeFromSuperview()
            
        }
        self.fairContainerStackViewHeight.constant = 50
        
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        for i in 0..<msgArr.count {
            
            let dict_temp = msgArr[i] as! NSDictionary
            for (key, value) in dict_temp {
                
                let totalSubViewCounts = self.fareDetailView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 36

                    let viewCus = UIView(frame: CGRect(x: 10, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth - 20, height: 1))

                    viewCus.backgroundColor = UIColor(hex: 0xdedede)

                    //                    self.fareContainerView.addArrangedSubview(viewCus)
                    self.fareDetailView.addSubview(viewCus)
                    fairViewArray += [viewCus]

                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 36
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font = UIFont(name: Fonts().light, size: 14)!
                    
                    if i == msgArr.count - 1{
                        font = UIFont(name: Fonts().semibold, size: 18)!
                    }
                    
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 20
                    
                    if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                        widthOfvalue = ((viewWidth * 80) / 100)
                        widthOfTitle = ((viewWidth * 20) / 100)
                    }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }
                    
                    let widthOfParentView = viewWidth - widthOfvalue
                    
                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 40))
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 40))
                    
                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 40))
                        
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.textColor = UIColor(hex: 0x272727)
                    lblValue.textColor = UIColor(hex: 0x272727)
                    
                    lblTitle.font = font
                    lblValue.font = font
                    
                    lblTitle.fontFamilyWeight = "Regular"
                    lblValue.fontFamilyWeight = "Regular"
                    lblTitle.setFontFamily()
                    lblValue.setFontFamily()
                    
                    lblTitle.numberOfLines = 2
                    lblValue.numberOfLines = 2
                    
                    lblTitle.minimumScaleFactor = 0.5
                    lblValue.minimumScaleFactor = 0.5
                    
                    lblTitle.text = titleStr
                    lblValue.text = valueStr
                    
                    viewCus.addSubview(lblTitle)
                    viewCus.addSubview(lblValue)
                    
                    if i == 0
                    {
                        self.vehicleTypeName.text = Configurations.convertNumToAppLocal(numStr: value as! String)
                        self.carName = Configurations.convertNumToAppLocal(numStr: value as! String)
                    }else
                    {
                        fairViewArray += [viewCus]
                        self.fareDetailView.addSubview(viewCus)
                        
                        self.fairContainerStackViewHeight.constant = self.fairContainerStackViewHeight.constant + 40
                    }
                    
                    if i == msgArr.count - 1{
                        lblTitle.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblValue.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        lblTitle.textColor = UIColor.black
                        lblValue.textColor = SColors.Theme
                        
                    }
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                }
            }
        }
        
        self.fairContainerStackViewHeight.constant = self.fairContainerStackViewHeight.constant - 35
        
        //        chargesContainerView.frame.size = CGSize(width: chargesContainerView.frame.width, height: CGFloat((55 * HistoryFareDetailsNewArr.count)))
        
        //        self.chargesParentView.frame.size = CGSize(width: chargesParentView.frame.width, height: chargesParentView.frame.height + chargesContainerView.frame.height - 50)
        self.fairHoldViewHeight.constant = self.fairContainerStackViewHeight.constant - 5
        
        self.fairContainerStackView.layoutIfNeeded()
        
        if self.anyRecHeightConstant.constant == 50
        {
             self.scrollView.contentSize = CGSize(self.view.frame.size.width,  438 + 50 + self.fairContainerStackViewHeight.constant - 30)
        }else{
            self.scrollView.contentSize = CGSize(self.view.frame.size.width,  438 + 50 + self.fairContainerStackViewHeight.constant)
        }
        
        if self.recViewHeightConstant.constant != 50
        {
            self.scrollView.contentSize = CGSize(self.view.frame.size.width,  self.scrollView.contentSize.height + CGFloat(finalReceiverViewHeightConstant) - 50)
        }
    
    }
    
    func checkCardConfig(isRideLater:Bool, isAutoContinue:Bool){
        if(GeneralFunctions.isUserCardExist(userProfileJson: self.userProfileJson)){
            showPaymentBox(isRideLater:isRideLater, isAutoContinue: isAutoContinue)
        }else{
            let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(paymentUV, animated: true)
        }
    }

    
    func showPaymentBox(isRideLater:Bool, isAutoContinue:Bool){
        
        let openConfirmCardView = OpenConfirmCardView(uv: self, containerView: self.cntView)
        
        openConfirmCardView.iUserProfileId = ""
        openConfirmCardView.iOrganizationId = ""
        openConfirmCardView.vProfileEmail = ""
        openConfirmCardView.ePaymentBy = ""
        
        openConfirmCardView.show(checkCardMode: self.checkCardMode) { (isCheckCardSuccess, dataDict) in
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            if(self.checkCardMode == "OUT_STAND_AMT"){
                //                        if(self.userProfileJson.get("APP_PAYMENT_MODE").uppercased() == "CARD"){
                //                            self.setCardMode()
                //                        }
                self.getOutStandingAmount()
                if dataDict.get("message") == "LBL_OUTSTANDING_AMOUT_ALREADY_PAID_TXT"
                {
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.isCardValidated = true
                self.senderTapped()
            }
        }
    
    }
    

    func createTrianleViewforMultiDeliverySteps(stepNo:Int)
    {
        self.stepMainView.isHidden = false
        if stepAnchorView != nil{
            stepAnchorView.removeFromSuperview()
            stepAnchorView = nil
        }
        if stepAnchorView2 != nil{
            stepAnchorView2.removeFromSuperview()
            stepAnchorView2 = nil
        }
        
        self.stemMainAppThemeView.backgroundColor = SColors.Theme
        
        firstStepLbl.cornerRadius = 16
        secondStepLbl.cornerRadius = 16
        thirdStepLbl.cornerRadius = 16
        firstStepLbl.clipsToBounds = true
        secondStepLbl.clipsToBounds = true
        thirdStepLbl.clipsToBounds = true
        
        if(Configurations.isRTLMode()){
            firstStepView.roundTo(corners:[.topRight, .bottomRight], radius: 24)
            thirdStepView.roundTo(corners:[.topLeft, .bottomLeft], radius: 24)
        }else{
            firstStepView.roundTo(corners:[.topLeft, .bottomLeft], radius: 24)
            thirdStepView.roundTo(corners:[.topRight, .bottomRight], radius: 24)
        }
        
        firstStepView.backgroundColor = UIColor.white
        secondStepView.backgroundColor = UIColor.white
        thirdStepView.backgroundColor = UIColor.white
        
        firstStepLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_VEHICLE_TYPE")
        secondStepLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_ROUTE")
        thirdStepLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_PRICE")
        
        firstStepLbl.textColor = SColors.blackColor
        secondStepLbl.textColor = SColors.blackColor
        thirdStepLbl.textColor = SColors.blackColor
        
        if stepNo == 1
        {
            firstStepLbl.textColor = SColors.ThemeTxt
            firstStepLbl.backgroundColor = SColors.Theme
            secondStepLbl.backgroundColor = UIColor.white
            thirdStepLbl.backgroundColor = UIColor.white
            
            
        }else if stepNo == 2
        {
            
            secondStepLbl.textColor = SColors.ThemeTxt
            firstStepLbl.backgroundColor = UIColor.white
            secondStepLbl.backgroundColor = SColors.Theme
            thirdStepLbl.backgroundColor = UIColor.white
            
        }else
        {
            thirdStepLbl.textColor = SColors.ThemeTxt
            firstStepLbl.backgroundColor = UIColor.white
            secondStepLbl.backgroundColor = UIColor.white
            thirdStepLbl.backgroundColor = SColors.Theme
        }
        
    }
    
    func rideLaterTapped(){
        
//        var minDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
//        minDate = Calendar.current.date(byAdding: .minute, value: 1, to: minDate!)
//        let maxDate = Calendar.current.date(byAdding: .month, value: Utils.MAX_DATE_SELECTION_MONTH_FROM_CURRENT, to: Date())
        var min_hour = Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1
       var max_hour = Int(self.userProfileJson.get("MAXIMUM_HOURS_LATER_BOOKING")) ?? 60
       var minDate = Calendar.current.date(byAdding: .minute, value: min_hour, to: Date())
       minDate = Calendar.current.date(byAdding: .minute, value: min_hour , to: minDate!)
       let maxDate = Calendar.current.date(byAdding: .minute, value: max_hour, to: Date())
        DatePickerDialog().show(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOKING_DATE"), doneButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TXT"), cancelButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), minimumDate: minDate,maximumDate: maxDate, datePickerMode: .dateAndTime) {
            (date) -> Void in
            
            if(date != nil){
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateString = dateFormatter.string(from: date!)
                
                self.selectedDate = dateString
                self.selectedTimeZone = dateFormatter.timeZone.identifier
                
                
                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Multi-Delivery&isPayBySender=\(self.isOnlyCashOtion == true ? "No" : "Yes")", uv: self)
                
//                let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//                selectPaymentProfileUV.isFromMultiDelivery = true
//                selectPaymentProfileUV.isOnlyCashOption = self.isOnlyCashOtion
//                self.push(uv: selectPaymentProfileUV)
                

            }
        }
    }
    
    func checkSurgePrice(_ isRideLater:Bool = false, isOpenOutStandingView:Bool = true){

        let parameters = ["type":"checkSurgePrice","SelectedCarTypeID": self.selectedCabTypeId, "SelectedTime": "", "PickUpLatitude": "", "PickUpLongitude": "", "DestLatitude": "", "DestLongitude": "", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType , "iRentalPackageId" : "", "iUserProfileId": "", "iOrganizationId": "", "vProfileEmail": "", "ePaymentBy": "", "ePool":""]
        
        //        , "TimeZone": selectedTimeZone
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("ShowContactUsBtn").uppercased() == "YES"){
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("outstanding_restriction_label")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if(btnClickedIndex == 0){
                            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                            self.push(uv: contactUsUv)
                        }
                        
                    })
                    return
                }
                
                self.openOutStandingAmountBox(isFromRideNow: isRideLater == true ? false : true)
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func myBtnTapped(sender: MyButton) {
        
        
        self.isDeliveryLater = false
        if(self.outStandingAmtView != nil && sender == self.cancelOutAmtBtn){
            
            self.closeOutStandingAmtView()
            return
        }
        
//        if((self.userProfileJson.get("APP_PAYMENT_MODE") == "Card" && isCardValidated == false) || (isCashPay == false && isCardValidated == false)){
//
//            /* PAYMENT FLOW CHANGES */
//            if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
//                self.checkCardMode = ""
//                checkCardConfig(isRideLater: false, isAutoContinue: true)
//                return
//            }/*.........*/
//
//        }
        
        if self.resFroPaySelected == ""
        {
            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_CHOOSE_PAYMENT_METHOD"))
            return
        }
        
        if self.resFroPaySelected == "Receiver"
        {
            if self.selectedRecViewIndex == ""
            {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_SELECT_TXT") + " " + self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_RECIPIENT"))
                return
            }
        }
        
        
        
        if(sender == self.bookLaterBtn){
        
            if (self.userProfileJson.get("ENABLE_SAFETY_FEATURE_DELIVERY").uppercased() == "YES" && self.userProfileJson.get("ENABLE_SAFETY_CHECKLIST").uppercased() == "YES"){
                let helpNoteForRideUV = GeneralFunctions.instantiateViewController(pageName: "HelpNoteForRideUV") as! HelpNoteForRideUV
                helpNoteForRideUV.isRideLater = true
                helpNoteForRideUV.isFromMultiDelivery = true
                helpNoteForRideUV.passengerLimitText = ""
                self.push(uv: helpNoteForRideUV)
                return
            }
            
            self.isDeliveryLater = true
            self.schdeuleLater()
            //self.handleRideLater()
            //self.rideLaterTapped()
            return
        }else if self.newScheduleView.buttonNegative == sender {
            selectedIndexCollection = 0
            selectedIndexPriviousCollection = 0
            self.isDeliveryLater = false
            self.newScheduleView.removeFromSuperview()
            return
        }else if self.newScheduleView.buttonPositive == sender {
            
            
            
            let min_hour = Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1
          let max_hour = Int(self.userProfileJson.get("MAXIMUM_HOURS_LATER_BOOKING")) ?? 60
            let maxDate = Calendar.current.date(byAdding: .minute, value: max_hour, to: Date())
           let minDate = Calendar.current.date(byAdding: .minute, value: min_hour, to: Date())


           
            let date = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " + self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + ":00" , dateFormate: "yyyy-MM-dd hh:mm:ss")
            let dateCompare = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " +  self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + " " + self.newScheduleView.amPmLbl.text! , dateFormate: "yyyy-MM-dd hh:mm aa")
           
           
            var stringtTemp = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_PICKUP_MAX_NOTE_MSG")
            let strMin = stringtTemp.replace("#####", withString: self.userProfileJson.get("MAXIMUM_HOURS_LATER_BOOKING")  + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINUTES_TXT"))
            let strMax = strMin.replace("####", withString: self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINUTES_TXT"))
            
            if dateCompare.toLocalTime() < minDate!.toLocalTime() {
               // Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_BOOKING_TIME_MSG") , uv: self)
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_PICKUP_MAX_NOTE_MSG"))
                return
            }
            if dateCompare.toLocalTime() > maxDate!.toLocalTime() {
               // Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVALID_BOOKING_TIME_MSG") , uv: self)
                self.generalFunc.setError(uv: self, title: "", content: self.userProfileJson.get("LBL_INVALID_PICKUP_MAX_NOTE_MSG"))
                return
                    }
            
            
            let stringFinalDate = Utils.convertDateAppLocaleToGregorian(date: self.selectedDateTimeNewPass + " " + self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text! + ":00" + self.newScheduleView.amPmLbl.text! , dateFormate: "yyyy-MM-dd hh:mm:ssa")
           let tempDateFinal =  stringFinalDate.toLocalTime()
            print(tempDateFinal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            dateFormatter.locale = Locale(identifier: "en_US")
            strPassDate = dateFormatter.string(from: tempDateFinal)
            self.selectedDate = strPassDate
            self.selectedTimeZone = dateFormatter.timeZone.identifier//stringFinalDate
            selectedIndexCollection = 0
            
            selectedIndexPriviousCollection = 0
            self.newScheduleView.removeFromSuperview()
            self.isDeliveryLater = true
            
            
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Multi-Delivery&isPayBySender=\(self.isOnlyCashOtion == true ? "No" : "Yes")", uv: self)
            
        }
        else{
            if (self.userProfileJson.get("ENABLE_SAFETY_FEATURE_DELIVERY").uppercased() == "YES" && self.userProfileJson.get("ENABLE_SAFETY_CHECKLIST").uppercased() == "YES"){
                let helpNoteForRideUV = GeneralFunctions.instantiateViewController(pageName: "HelpNoteForRideUV") as! HelpNoteForRideUV
                helpNoteForRideUV.isRideLater = false
                helpNoteForRideUV.isFromMultiDelivery = true
                helpNoteForRideUV.passengerLimitText = ""
                self.push(uv: helpNoteForRideUV)
                return
            }
        }
        
        GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Multi-Delivery&isPayBySender=\(self.isOnlyCashOtion == true ? "No" : "Yes")", uv: self)
        
//        let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//        selectPaymentProfileUV.isFromMultiDelivery = true
//        selectPaymentProfileUV.isOnlyCashOption = self.isOnlyCashOtion
//        self.push(uv: selectPaymentProfileUV)
        return
           
        
//        if(self.deliveryDetailsListUV != nil){
//
//            self.deliveryDetailsListUV.releaseAllTask()
//        }
        
        
        //self.performSegue(withIdentifier: "unwindFromAskForPayUV", sender: self)
    }
    
    func openOutStandingAmountBox(isFromRideNow:Bool){
        
        let openOutStandingAmtView = OpenOutStandingView(uv: self, containerView: self.view)
        openOutStandingAmtView.show(userProfileJson: self.userProfileJson, currentCabGeneralType: Utils.cabGeneralType_Deliver, dataDict: dataDictOutStanding) { (isPayNow, isAdjustAmount) in
            
            if(isPayNow){
                

                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Multi-Delivery&ePaymentType=ChargeOutstandingAmount", uv: self)
                
//                /* PAYMENT FLOW CHANGES */
//                if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "1"){
//                    self.checkCardMode = "OUT_STAND_AMT"
//                    self.checkCardConfig(isRideLater: isFromRideNow == true ? false : true, isAutoContinue: true)
//
//                }else if(GeneralFunctions.getPaymentMethod(userProfileJson:self.userProfileJson) == "2"){
//
//                    self.checkCard(checkCardMode: "OUT_STAND_AMT", isFromRideNow:isFromRideNow)
//                }/*.........*/
                
            }else if(isAdjustAmount){
                if self.isCashPay == true && self.resFroPaySelected != "Sender"
                {
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MULTI_OUTSTANDING_DECILENED_MSG"))
                    return
                }
                
                self.isOutStandingAmtSkipped = true
                if(self.deliveryDetailsListUV != nil){
                    
                    if self.stepAnchorView != nil{
                        self.stepAnchorView.removeFromSuperview()
                        self.stepAnchorView = nil
                    }
                    if self.stepAnchorView2 != nil{
                        self.stepAnchorView2.removeFromSuperview()
                        self.stepAnchorView2 = nil
                    }
                    self.deliveryDetailsListUV.releaseAllTask()
                }
                self.performSegue(withIdentifier: "unwindFromAskForPayUV", sender: self)
                
            }
        }
        
    }
    
    /* PAYMENT FLOW CHANGES */
    func checkCard(checkCardMode:String, isFromRideNow:Bool){
        
        
        let parameters = ["type": "\(checkCardMode == "OUT_STAND_AMT" ? "ChargePassengerOutstandingAmount" : "CheckCard")","\(checkCardMode == "OUT_STAND_AMT" ? "iMemberId" : "iUserId")": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType]
       
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if(checkCardMode == "OUT_STAND_AMT"){
                        GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                        
                        self.userProfileJson =  (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                          
                            if(self.deliveryDetailsListUV != nil){
                                if self.stepAnchorView != nil{
                                    self.stepAnchorView.removeFromSuperview()
                                    self.stepAnchorView = nil
                                }
                                if self.stepAnchorView2 != nil{
                                    self.stepAnchorView2.removeFromSuperview()
                                    self.stepAnchorView2 = nil
                                }
                                self.deliveryDetailsListUV.releaseAllTask()
                            }
                            self.performSegue(withIdentifier: "unwindFromAskForPayUV", sender: self)
                        })
                    }
                    
                }else{
                    
                    /* PAYMENT FLOW CHANGES */
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        
                        var msgtxt = ""
                        if(dataDict.get("low_balance_content_msg") == ""){
                            msgtxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BAL")
                        }else{
                            msgtxt = dataDict.get("low_balance_content_msg")
                        }
                        
                        self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased(), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                            }
                        })
                        
                        return
                    }/* .............. */
                    
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }/*.........*/
    
    func getOutStandingAmount(){
        
        let parameters = ["type":"getOutstandingAmount","UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd()]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.dataDictOutStanding = dataDict.dictOf("message")
                    
                }else
                {
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "No Internet Connection", key: "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.getOutStandingAmount()
                    })
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "No Internet Connection", key: "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    self.getOutStandingAmount()
                })
            }
        })
    }
    
    
    @objc func adjustOutStndAmt(){
        
        
    }
    
    func closeOutStandingAmtView(){
        if(self.outStandingAmtView != nil){
            self.outStandingAmtView.removeFromSuperview()
            self.outStandingAmtBGView.removeFromSuperview()
            self.outStandingAmtView = nil
        }
    }
    
   
    
    @IBAction func unwindToAskForPayUV(_ segue:UIStoryboardSegue) {
        
        if(segue.source.isKind(of: SelectPromoCodeUV.self)){
            let selectPromoCodeUV = segue.source as! SelectPromoCodeUV
            
            self.appliedPromoCode = selectPromoCodeUV.appliedPromoCode
            self.isPromoCodeAppliedManually = selectPromoCodeUV.isPromoCodeAppliedManually
            self.continueEstimateFare()
            
        }else if(segue.source.isKind(of: AddPaymentUV.self)){
           
            if(GeneralFunctions.parseDouble(origValue: 0.0, data: dataDictOutStanding.get("fOutStandingAmount")) > 0 && isOutStandingAmtSkipped == false){

                self.checkSurgePrice(self.isDeliveryLater == true ? true : false, isOpenOutStandingView: true)
                return
            }
            self.performSegue(withIdentifier: "unwindFromAskForPayUV", sender: self)
            
        }else if(segue.source.isKind(of: SelectPaymentProfileUV.self)){
//            let selectPaymentProfileUV = segue.source as! SelectPaymentProfileUV
//            if(selectPaymentProfileUV.isCashPayment == true){
//                self.isCashPay = true
//
//            }else{
//                self.isCardValidated = true
//                self.isCashPay = false
//            }
//            self.eWalletDebitAllow = selectPaymentProfileUV.useWalletChkBox.on
//
//            if(GeneralFunctions.parseDouble(origValue: 0.0, data: dataDictOutStanding.get("fOutStandingAmount")) > 0 && isOutStandingAmtSkipped == false){
//
//                self.checkSurgePrice(self.isDeliveryLater == true ? true : false, isOpenOutStandingView: true)
//                return
//            }
            
            
            
       //     self.performSegue(withIdentifier: "unwindFromAskForPayUV", sender: self)
           
        }else if(segue.source.isKind(of: HelpNoteForRideUV.self)){ /* Help note changes for Ride*/
            
            let helpNoteForRideUV = segue.source as! HelpNoteForRideUV
            
            if(helpNoteForRideUV.isRideLater == false){
                
                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Multi-Delivery&isPayBySender=\(self.isOnlyCashOtion == true ? "No" : "Yes")", uv: self)
                
//                let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//                              selectPaymentProfileUV.isFromMultiDelivery = true
//                              selectPaymentProfileUV.isOnlyCashOption = self.isOnlyCashOtion
//                              self.push(uv: selectPaymentProfileUV)
            }else{

              self.isDeliveryLater = true
                self.schdeuleLater()
               // self.handleRideLater()
              //self.rideLaterTapped()
            }
        }
    }
    func handleInfo(){
        
        self.generalFunc.setError(uv: self, title: self.carName, content:self.infoTxt , isShowTitle: true)
    }
    func schdeuleLater()  {
        self.newScheduleView = ListBottomSheetViewTimePicker(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height:Application.screenSize.height - 70 - GeneralFunctions.getSafeAreaInsets().bottom))
        self.getCurentTime()
       
        let date = Date()
        
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
        
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
        self.datesAr = Date.getDates2(forLastNDays: 90, formate: "dd", startDate: modifiedDate)
        self.dayAr = Date.getDates2(forLastNDays: 90, formate: "E",startDate: modifiedDate)
        self.datesDisplay = Date.getDates2(forLastNDays: 90, formate: "E, MMM dd",startDate: modifiedDate)
        self.datesPass = Date.getDates2(forLastNDays: 90, formate: "dd MMM, yyyy",startDate: modifiedDate)
         
        let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd",startDate: modifiedDate)
//        if(Configurations.isRTLMode()){
//            self.selectedDateTimeNewPass = tempAr[tempAr.count - 1]
//            self.selectedIndexCollection = self.datesAr.count - 1
//            self.selectedDateTimeNew = self.datesPass[self.datesPass.count - 1]
//        }else{
            self.selectedDateTimeNewPass = tempAr[0]
            self.selectedDateTimeNew = self.datesPass[0]
       // }
       
        self.newScheduleView.collectionView.register(UINib(nibName: "dateTimeCVC", bundle: nil), forCellWithReuseIdentifier: "dateTimeCVC")
        self.newScheduleView.collectionView.dataSource = self
        self.newScheduleView.collectionView.delegate = self
        Utils.delayWithSeconds(0.2) {
            self.newScheduleView.collectionView.reloadData()
        }
      
        

        self.newScheduleView.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Schedule", key: "LBL_SCHEDULE")
        self.newScheduleView.viewHour.cornerRadius = 5
        self.newScheduleView.viewMinuts.cornerRadius = 5
        self.newScheduleView.viewAmPm.cornerRadius = 5
        self.newScheduleView.viewHour.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.viewMinuts.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.viewAmPm.backgroundColor = UIColor(hex: 0xe9eef2)
        self.newScheduleView.buttonPositive.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.newScheduleView.buttonNegative.setCustomColor(textColor: SColors.ThemeTxt, bgColor: UIColor.lightGray, pulseColor: UIColor.lightGray, borderColor: UIColor.lightGray, borderWidth: 1, cornerRadius: 5)
        self.newScheduleView.buttonPositive.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Set", key: "LBL_SET"))
        self.newScheduleView.buttonNegative.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"))
        self.newScheduleView.buttonNegative.clickDelegate = self
        self.newScheduleView.buttonPositive.clickDelegate = self
        self.newScheduleView.viewHour.handleClick { (view) in
            self.handleRideLater()
        }
        self.newScheduleView.viewMinuts.handleClick { (view) in
            self.handleRideLater()
        }
        self.newScheduleView.viewAmPm.handleClick { (view) in
            self.handleRideLater()
        }
        cntView.addSubview(self.newScheduleView)
        //self.contentView.addSubview(self.newScheduleView)
        //let window = Application.window
       // window?.addSubview(self.newScheduleView)
    }
    func handleRideLater(){
        let timeSelector = TimeSelector()
        timeSelector.timeSelected = {
            (timeSelector) in
            print(timeSelector.date)
            if timeSelector.hours.digitCount == 1 {
            self.newScheduleView.hourLbl.text = "0" + String(timeSelector.hours)
            }else{
                self.newScheduleView.hourLbl.text =  String(timeSelector.hours)
           // self.newScheduleView.minutsLbl.text = String(timeSelector.minutes
            }
            if timeSelector.minutes.digitCount == 1 {
                self.newScheduleView.minutsLbl.text = "0" + String(timeSelector.minutes)
            }else{
                self.newScheduleView.minutsLbl.text =  String(timeSelector.minutes)
                }
            if timeSelector.isAm {
                self.newScheduleView.amPmLbl.text = "AM"//self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AM_TXT")
            }else{
                self.newScheduleView.amPmLbl.text = "PM" //self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PM_TXT")
            }
            
            self.newScheduleView.timeLbl.text = self.newScheduleView.hourLbl.text! + ":" + self.newScheduleView.minutsLbl.text!  + " " + self.newScheduleView.amPmLbl.text!
            //self.newScheduleView.hourLbl.text ?? "" + ":" +  self.newScheduleView.minutsLbl.text ?? "" + " " + self.newScheduleView.amPmLbl.text ?? ""
               //self.setLabelFromDate(timeSelector.date)
        }
        timeSelector.overlayAlpha = 0.4
        
        timeSelector.clockTint = SColors.Theme
        timeSelector.minutes = Int(self.newScheduleView.minutsLbl.text ?? "0") ?? 00
        timeSelector.hours = Int(self.newScheduleView.hourLbl.text ?? "12") ?? 12
        if  self.newScheduleView.amPmLbl.text?.uppercased() == "AM" {
        timeSelector.isAm = true
        }else{
            timeSelector.isAm = false
        }
        timeSelector.presentOnView(view: self.view)
    }
    func getCurentTime(){
       
        let date = Date()
        
        let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
        
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh"
        let result = dateFormatter.string(from: modifiedDate)
        self.newScheduleView.hourLbl.text = result
        dateFormatter.dateFormat = "mm"
        let result2 = dateFormatter.string(from: modifiedDate)
        self.newScheduleView.minutsLbl.text = result2
        dateFormatter.dateFormat = "a"
        let result3 =  dateFormatter.string(from: modifiedDate)
        self.newScheduleView.amPmLbl.text = result3
        dateFormatter.dateFormat = "hh:mm a"
        self.newScheduleView.timeLbl.text = dateFormatter.string(from: modifiedDate)
        dateFormatter.dateFormat = "E, MMM dd"
        self.newScheduleView.dayDateLbl.text =  dateFormatter.string(from: modifiedDate)
        print(result)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return self.datesAr.count
         
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateTimeCVC", for: indexPath) as! dateTimeCVC
            cell.parentView.layer.shadowOpacity = 1.0
            cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.parentView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            cell.parentView.layer.shadowRadius = 4.0
            cell.parentView.layer.cornerRadius = 10
            cell.parentView.layer.borderColor = UIColor.black.cgColor
            cell.parentView.layer.borderWidth = 0
            cell.dateLbl.text = self.datesAr[indexPath.item]
            cell.dayLbl.text = self.dayAr[indexPath.item]
                if selectedIndexCollection == indexPath.row {
                    cell.parentView.backgroundColor = UIColor(hex: 0xdffdff)
                    cell.dateLbl.textColor = UIColor(hex: 0x00a9b8)
                    cell.dayLbl.textColor = UIColor(hex: 0x1ECCDC)
                }else{
                    cell.parentView.backgroundColor = UIColor(hex: 0xFFFFFF)
                    cell.dateLbl.textColor = UIColor(hex: 0x030303)
                    cell.dayLbl.textColor = UIColor.lightGray
                }
            return cell
    }
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                selectedIndexCollection = indexPath.row
                self.newScheduleView.dayDateLbl.text = self.datesDisplay[indexPath.row]
                self.selectedDateTimeNew = self.datesPass[indexPath.row]
                let date = Date()
        
                let minDate =  (Int(self.userProfileJson.get("MINIMUM_HOURS_LATER_BOOKING")) ?? 1)
        
                let modifiedDate = Calendar.current.date(byAdding: .minute, value: minDate + 1, to: date)!
                let tempAr = Date.getDates2(forLastNDays: 90, formate: "yyyy-MM-dd", startDate: modifiedDate )
                self.selectedDateTimeNewPass = tempAr[indexPath.row]
                //self.newScheduleView.collectionView.reloadData()
                let indexPath = IndexPath(item: indexPath.row, section: 0)
                let indexpathPrivious = IndexPath(item: selectedIndexPriviousCollection, section: 0)
                let reloadsIdexpath = [indexPath,indexpathPrivious]
                selectedIndexPriviousCollection = indexPath.row
               self.newScheduleView.collectionView.reloadItems(at: reloadsIdexpath)
        
    }


}
