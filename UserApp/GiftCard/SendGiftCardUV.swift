//
//  SendGiftCardUV.swift
//  UserApp
//
//  Created by Apple on 30/11/22.
//

import UIKit
import SysBaseLib

class SendGiftCardUV: ParentViewUV, ParentViewUVDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyTxtFieldClickDelegate, MyBtnClickDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectThemeTitleLbl: MyLabel!
    @IBOutlet weak var topHTitleLbl: MyLabel!
    @IBOutlet weak var topThemeView: UIView!
    @IBOutlet weak var enterAmountTitleLbl: MyLabel!
   
    @IBOutlet weak var previewLbl: MyLabel!
    @IBOutlet weak var maxAmountLbl: MyLabel!
    @IBOutlet weak var enterAmountTxtFiled: UITextField!
    
    @IBOutlet weak var enterRecieverDetailLbl: MyLabel!
    @IBOutlet weak var personalMsgTxtView: UITextView!
    @IBOutlet weak var personalMsgTitleLbl: MyLabel!
    
    @IBOutlet weak var recieverEmailTxtFiled: MyTextField!
    @IBOutlet weak var recNameTxtFiled: MyTextField!
    @IBOutlet weak var recPhoneTxtFiled: MyTextField!
  
    @IBOutlet weak var userPhoneLbl: MyLabel!
    @IBOutlet weak var phoneCntViewHeight: NSLayoutConstraint!
    @IBOutlet weak var phoneCntView: UIView!
    @IBOutlet weak var countryTxtField: MyTextField!
    @IBOutlet weak var proceedToPayLbl: MyLabel!
    @IBOutlet weak var termsLbl: MyLabel!
    @IBOutlet weak var paybleAmountLbl: MyLabel!
    @IBOutlet weak var payBtn: MyButton!
    @IBOutlet weak var topGiftImgView: UIImageView!
    
    
    var userProfileJson:NSDictionary!
    var cntView:UIView!
   
    let generalFunc = GeneralFunctions()
    
    
    var cardImagesArray = [NSDictionary]()
    var currentSelectedCardIndex = -1
    
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var countryListArr:NSArray!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            cntView = self.generalFunc.loadView(nibName: "SendGiftCardScreenDesign", uv: self, contentView: scrollView)
            
            self.scrollView.addSubview(cntView)
            
            self.view.backgroundColor = UIColor.white
            self.contentView.backgroundColor = UIColor.white
            self.scrollView.backgroundColor = UIColor.white
           
            self.scrollView.bounces = false
            self.scrollView.delegate = self
           
            
            cntView.frame.size = CGSize(width: cntView.frame.width, height: 1000)
           
            self.setData()
            
        }else if type == 1 {
            self.addBack()
            self.configRTL()
            
            
            self.topGiftImgView.backgroundColor = SColors.Theme
            self.topGiftImgView.image = self.topGiftImgView.image?.addImagePadding(x: 90, y: 90)
            GeneralFunctions.setImgTintColor(imgView: self.topGiftImgView, color: .white)
            
            
        }else if type == 2{
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.payBtn.frame.origin.y + 100)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.payBtn.frame.origin.y + 100)
            
            self.countryTxtField.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in
                
                if(self.countryPrefixImgView == nil){
                    self.countryPrefixImgView = imageView
                    self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                }
            }
            
        }else if type == 3 {
            
        }
    }
    
    func setData(){
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        self.userProfileJson = userProfileJson
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_SEND_TXT")
        
        CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
            if(isSuccess){
                self.countryListArr = dataArray
            }
        }
        
        self.topThemeView.backgroundColor = SColors.Theme
        self.topHTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_SEND_TXT")
        self.topHTitleLbl.textColor = SColors.ThemeTxt
        
        self.selectThemeTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_SELECT_IMAGE_THEME_TXT")
        
        self.enterAmountTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_ENTER_AMOUNT_TXT") + " (" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_IN") + " "  + userProfileJson.get("vCurrencyPassenger") + ")"
        self.enterAmountTxtFiled.placeholder = "0.0"//Configurations.convertNumToAppLocal(numStr: "0.0")
        self.enterAmountTxtFiled.keyboardType = .decimalPad
        self.maxAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_MAX_AMOUNT_TXT") + " " + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("GIFT_CARD_MAX_AMOUNT_WITH_SYMBOL"))
        self.enterAmountTxtFiled.delegate = self
        
        self.personalMsgTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_ENTER_MESSAGE_TXT")
        self.personalMsgTxtView.delegate = self
        
        self.enterRecieverDetailLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_ENTER_RECEIVER_DETAILS_TXT")
        
        self.previewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_PREVIEW_BTN_TXT")
        
        
        self.recNameTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_RECEIVER_NAME_TXT"))
        self.recieverEmailTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_RECEIVER_EMAIL_TXT"))
 
        self.recPhoneTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_RECEIVER_PHONE_TXT"))
        self.recPhoneTxtFiled.getTextField()!.keyboardType = .numberPad
        
        
        self.proceedToPayLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYMENT_TITLE")
        
        self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ": --"
        
        //self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
        
        self.payBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYMENT_BTN_TXT"))
        self.payBtn.clickDelegate = self
        
        let finalStrTerms = NSMutableAttributedString.init(string: "")
        finalStrTerms.append(self.getAttributedString(str:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION_PREFIX_TXT"),color:SColors.tfPlaceholderInActive))
        finalStrTerms.append(self.getAttributedString(str: " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TERMS_CONDITION_PRIVACY"),color:SColors.Theme))
        self.termsLbl.attributedText = finalStrTerms
        self.termsLbl.isUserInteractionEnabled = true
        self.termsLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabelTerms(gesture:))))
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "GIFT_CARD_IMAGES")){
            self.cardImagesArray = GeneralFunctions.getValue(key: "GIFT_CARD_IMAGES") as! [NSDictionary]
           
        }
        
        self.collectionView.register(UINib(nibName: "GiftCardThemeCVCell", bundle: nil), forCellWithReuseIdentifier: "GiftCardThemeCVCell")
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.collectionView.reloadData()
        
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
            countryTxtField.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
            self.countryTxtField.myTxtFieldDelegate = self
            
        }
        
        if(self.selectedPhoneCode == ""){
            //self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
                   self.countryTxtField.setEnable(isEnabled: false)
                  // self.countryTxtField.onTextChangedDelegate = self
                   if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                       self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                       self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                       
                       self.countryTxtField.setText(text: "+\(self.selectedPhoneCode)")
                       
                       self.isCountrySelected = true
                       self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
                }
        }
        
        self.previewLbl.handleClick { instance in
            if(self.checkValidation()){
                
                let urlTemp = self.userProfileJson.get("PREVIEW_GIFT_CARD_URL") + "&ReceiverName=\(self.recNameTxtFiled.getTextField()!.text!)&Amount=\(self.enterAmountTxtFiled.text!)&GiftCardImageId=\(self.cardImagesArray[self.currentSelectedCardIndex].get("iGiftCardImageId"))&SenderMsg=\(self.personalMsgTxtView.text!)&GeneralMemberId=\(GeneralFunctions.getMemberd())&GeneralUserType=\(Utils.appUserType)"
                
                UIApplication.shared.open(urlTemp.getURL())
            }
        }
        
        
        self.phoneCntView.layer.cornerRadius = 8
        self.phoneCntView.borderColor = UIColor.lightGray
        self.phoneCntView.borderWidth = 0.5
        
        self.userPhoneLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PHONE_NO_TXT")
    
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
           
        if(sender == self.countryTxtField){

             let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
             countryListUv.fromSendGift = true
             
             if(countryListArr != nil){
                 countryListUv.countryListArr = countryListArr
             }
             
             countryListUv.modalPresentationStyle = .overCurrentContext
             self.present(countryListUv, animated: true) {
             }
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cardImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftCardThemeCVCell", for: indexPath) as! GiftCardThemeCVCell
        
        if(Utils.giftCardImgData.count > indexPath.row){
            cell.imgView.image = Utils.giftCardImgData[indexPath.row]
        }else{
            cell.imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.cardImagesArray[indexPath.item].get("vImage"), width: Utils.getValueInPixel(value: 266), height: Utils.getValueInPixel(value: 150))), placeholderImage:nil)
        }
      
        if(currentSelectedCardIndex != -1 && currentSelectedCardIndex == indexPath.item){
            cell.cntView.borderColor = SColors.Theme
            cell.cntView.borderWidth = 2
        }else{
            cell.cntView.borderColor = .clear
            cell.cntView.borderWidth = 0
        }
        
        if(Configurations.isRTLMode()){
            cell.cntView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
            cell.imgView.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 296.0, height: 180.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedCardIndex = indexPath.row
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        self.selectThemeTitleLbl.textColor = UIColor.black
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        if(scrollView.contentOffset.y > 90){
//            self.topHTitleLbl.text = ""
//            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_SEND_TXT")
//        }else{
//            self.topHTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARDT_SEND_TXT")
//            self.title = ""
//        }
        
    }
    
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    @objc func tapLabelTerms(gesture: UITapGestureRecognizer) {
        if let url = URL(string: userProfileJson.get("TERMS_&_CONDITIONS_GIFT_CARD_URL")) {
            UIApplication.shared.open(url)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(self.personalMsgTxtView.text + text != ""){
            self.personalMsgTxtView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(GeneralFunctions.parseDouble(origValue: 0, data: self.enterAmountTxtFiled.text! + string) > GeneralFunctions.parseDouble(origValue: 0, data: self.userProfileJson.get("GIFT_CARD_MAX_AMOUNT"))){
            self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ": " +  userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.enterAmountTxtFiled.text!)
            return false
        }else{
            if(GeneralFunctions.parseDouble(origValue: 0, data: self.enterAmountTxtFiled.text! + string) < 0){
                self.enterAmountTxtFiled.layer.borderColor = UIColor.red.cgColor
                self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ": " + userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.enterAmountTxtFiled.text!)
                return false
            }else{
                self.enterAmountTxtFiled.layer.borderColor = UIColor.lightGray.cgColor
                self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ": " + userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.enterAmountTxtFiled.text! + string)
                return true
            }

        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if(self.enterAmountTxtFiled.text! == ""){
            self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ":  --"
        }else{
            self.paybleAmountLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_PAYABLE_AMOUNT_TXT") + ": " +  userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.enterAmountTxtFiled.text!)
        }
        
        return true
    }
    

    func checkValidation() -> Bool{
        
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")

        var isThemeDetailsFilled = true
        if(currentSelectedCardIndex == -1){
            self.selectThemeTitleLbl.textColor = UIColor.red
            self.scrollView.scrollToTop()
            isThemeDetailsFilled = false
        }
        
        if(GeneralFunctions.parseDouble(origValue: 0, data: self.enterAmountTxtFiled.text!) <= 0.0){
            self.enterAmountTxtFiled.layer.borderColor = UIColor.red.cgColor
            self.scrollView.scrollToTop()
            isThemeDetailsFilled = false
        }
        
        if(self.personalMsgTxtView.text == ""){
            self.personalMsgTxtView.layer.borderColor = UIColor.red.cgColor
            isThemeDetailsFilled = false
        }
        
        let fNameEntered = Utils.checkText(textField: self.recNameTxtFiled.getTextField()!) ? true : Utils.setErrorFields(textField: self.recNameTxtFiled.getTextField()!, error: required_str)
        
        
        let emailValidEntered = Utils.checkText(textField: self.recieverEmailTxtFiled.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.recieverEmailTxtFiled.getTextField()!)) ? true : Utils.setErrorFields(textField: self.recieverEmailTxtFiled.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : Utils.setErrorFields(textField: self.recieverEmailTxtFiled.getTextField()!, error: required_str)
        
        let mobileEntered = Utils.checkText(textField: self.recPhoneTxtFiled.getTextField()!) ? (Utils.getText(textField: self.recPhoneTxtFiled.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.recPhoneTxtFiled.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.recPhoneTxtFiled.getTextField()!, error: required_str)
        
        if (fNameEntered == false || emailValidEntered == false ||  mobileEntered == false || isThemeDetailsFilled == false) {
            
//            if(mobileEntered == false){
//                self.phoneCntViewHeight.constant = self.phoneCntViewHeight.constant + 30.0
//            }
            return false;
        }
        
        return true
        
        
    }
    
    func checkoutGiftCard(){
        
        let parameters = ["type":"SendGiftCard", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "tReceiverName":self.recNameTxtFiled.getTextField()!.text!, "tReceiverEmail":self.recieverEmailTxtFiled.getTextField()!.text!, "tReceiverMessage":self.personalMsgTxtView.text!, "vReceiverPhone":self.recPhoneTxtFiled.getTextField()!.text!, "vReceiverPhoneCode":self.selectedPhoneCode, "iGiftCardImageId":self.cardImagesArray[self.currentSelectedCardIndex].get("iGiftCardImageId"), "fAmount":self.enterAmountTxtFiled.text!]
    
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.addPayment(url: dataDict.get("GIFT_CARD_PAYMENT_URL"), uv: self)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }

            }else{
                
                self.generalFunc.setError(uv: self)
        
            }
        })
    }
   
    func myBtnTapped(sender: MyButton) {
        
        if(self.checkValidation()){
            self.checkoutGiftCard()
        }
    }
    
    @IBAction func unwindToSendGift(_ segue:UIStoryboardSegue) {
        if(segue.source .isKind(of: CountryListUV.self)){
            let sourceViewController = segue.source as? CountryListUV
            let selectedPhoneCode:String = sourceViewController!.selectedCountryHolder!.vPhoneCode
            let selectedCountryCode = sourceViewController!.selectedCountryHolder!.vCountryCode
            
            self.selectedCountryCode = selectedCountryCode
            self.selectedPhoneCode = selectedPhoneCode
            self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:sourceViewController!.selectedCountryHolder!.vSImage, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
            
            self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
         
            self.countryTxtField.setText(text: "+\(selectedPhoneCode)")
            
            self.isCountrySelected = true
            self.countryTxtField.getTextField()!.sendActions(for: .editingChanged)
            
        }
    }
    
}
