//
//  RentSendInquiryUv.swift
//  UserApp
//
//  Created by # Admin on 07/01/23.
//

import UIKit
import SysBaseLib
class RentSendInquiryUv: ParentViewUV,ParentViewUVDelegate ,MyTxtFieldClickDelegate, MyBtnClickDelegate,MyTxtFieldOnTextChangeDelegate {
    
    
    
    @IBOutlet weak var containerView: UIView!
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    let generalFunc = GeneralFunctions()
    
    @IBOutlet weak var nameLbl: MyLabel!
    @IBOutlet weak var nameTxtFiled: MyTextField!
    @IBOutlet weak var emailLbl: MyLabel!
    @IBOutlet weak var emailTxtFiled: MyTextField!
    @IBOutlet weak var phoneNoLbl: MyLabel!
    @IBOutlet weak var phoneNoTxtFiled: MyTextField!
    @IBOutlet weak var phoneCodeTxtFiled: MyTextField!
    @IBOutlet weak var btnSubmit: MyButton!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var btnCall: MyButton!
    @IBOutlet weak var btnOk: MyButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomTittleLbl: MyLabel!
    @IBOutlet weak var bottomTittleHLbl: MyLabel!
    var rentItemDetialsUV : RentItemDetailsUV!
    
    var countryListArr:NSArray!
    var selectedCountryCode = ""
    var selectedPhoneCode = ""
    var countryPrefixImgView:UIImageView!
    var isCountrySelected = false
    var cuntryUrl = ""
    var data = NSDictionary()
    var isContactOwner = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if(type == 0){
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            cntView = self.generalFunc.loadView(nibName: "RentSendInqiuryScreenDesign", uv: self, contentView: containerView)
            self.containerView.addSubview(cntView)
            self.setData()
            
        }else if(type == 1){
            self.configRTL()
        }
        else if (type == 2) {
            self.phoneCodeTxtFiled.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 19,27) { (imageView) in

                if(self.countryPrefixImgView == nil){
                    self.countryPrefixImgView = imageView
                    self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_IMAGE_KEY) as! String, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
                }
              
            }
        }
    }
    func setData(){
        self.shadowOnview(view: self.mainView)
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_SEND_INQUIRY_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_SEND_INQUIRY_TXT")
        self.addBack()
        
//        self.nameLbl.attributedText = getRequiredText(str: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NAME_TXT"))
        self.nameLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NAME_TXT")
        self.nameTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_YOUR_NAME_TXT"))

//        self.emailLbl.attributedText = getRequiredText(str: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_TEXT"))
        self.emailLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMAIL_TEXT")
        self.emailTxtFiled.setPlaceHolder(placeHolder:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_YOUR_EMAIL_TXT"))
        

//        self.phoneNoLbl.attributedText = getRequiredText(str: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USER_PHONE_TXT"))
        self.phoneNoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_USER_PHONE_TXT")
        self.phoneNoTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_MOBILE_HINT"))
        
        self.btnSubmit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Submit", key: "LBL_SUBMIT_BUTTON_TXT") )
        self.btnSubmit.clickDelegate = self
        
        self.phoneCodeTxtFiled.addImageView(color: UIColor.init(hex: 0x8FA1B4), transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
        self.phoneCodeTxtFiled.myTxtFieldDelegate = self
        
         let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        nameTxtFiled.setText(text: userProfileJson.get("vName") + " " + userProfileJson.get("vLastName"))
        emailTxtFiled.setText(text: userProfileJson.get("vEmail"))
        phoneCodeTxtFiled.setText(text: "+" + userProfileJson.get("vPhoneCode"))
        phoneNoTxtFiled.setText(text: userProfileJson.get("vPhone"))
        
        if(self.selectedPhoneCode == ""){
            //self.countryTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
                   self.phoneCodeTxtFiled.setEnable(isEnabled: false)
                   self.phoneCodeTxtFiled.onTextChangedDelegate = self
                   if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                       self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                       self.selectedPhoneCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                       
                       self.phoneCodeTxtFiled.setText(text: "+\(self.selectedPhoneCode)")
                       
                       self.isCountrySelected = true
                       self.phoneCodeTxtFiled.getTextField()!.sendActions(for: .editingChanged)
            }
        }
        
        CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
            if(isSuccess){
                self.countryListArr = dataArray
            }
        }
       
       
    }
    
    private func getRequiredText(str : String) -> NSMutableAttributedString {
        var finalStrTerms : NSMutableAttributedString  = NSMutableAttributedString.init(string: "")
        finalStrTerms.append(self.getAttributedString(str: str ,color:UIColor.black))
        finalStrTerms.append(self.getAttributedString(str: " " + "*",color:SColors.red))
        return finalStrTerms
    }
    
    private func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    func myTxtFieldTapped(sender: MyTextField) {
     
        if(sender == self.phoneCodeTxtFiled){

             let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
             countryListUv.fromSendQury = true
            countryListUv.rentSendInquiryUv = self
             
             if(countryListArr != nil){
                 countryListUv.countryListArr = countryListArr
             }
             
             countryListUv.modalPresentationStyle = .overCurrentContext
             self.present(countryListUv, animated: true) {
             }
        }
       
    }
     func setCountry() {
         
           self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: cuntryUrl, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 19))), placeholderImage:nil)
           self.phoneCodeTxtFiled.setText(text: "+\(selectedPhoneCode)")
           self.phoneCodeTxtFiled.setText(text: "+\(selectedPhoneCode)")
           self.isCountrySelected = true
           self.phoneCodeTxtFiled.getTextField()!.sendActions(for: .editingChanged)
         
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnSubmit{
            let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            let mobileInvalid = self.generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
            let mobileEntered = Utils.checkText(textField: self.phoneNoTxtFiled.getTextField()!) ? (Utils.getText(textField: self.phoneNoTxtFiled.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.phoneNoTxtFiled.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.phoneNoTxtFiled.getTextField()!, error: required_str)
           
            var emailValidEntered = false
            emailValidEntered = Utils.checkText(textField: self.emailTxtFiled.getTextField()!) ? (GeneralFunctions.isValidEmail(testStr: Utils.getText(textField: self.emailTxtFiled.getTextField()!)) ? true : Utils.setErrorFields(textField: self.emailTxtFiled.getTextField()!, error: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_EMAIL_ERROR"))) : Utils.setErrorFields(textField: self.emailTxtFiled.getTextField()!, error: required_str)
        
            let nameEnterd = Utils.checkText(textField: self.nameTxtFiled.getTextField()!) ? true : Utils.setErrorFields(textField: self.nameTxtFiled.getTextField()!, error: required_str)
            
            if (mobileEntered == false || nameEnterd == false || emailValidEntered == false) {
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                return;
            }
            self.contactOwnerMailSend()
            
        }else if sender == self.btnCall{
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
                if self.userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == "VOIP"{
                    self.audioCall()
                    return
                }else if(userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == Utils.VIDEOCALL){
                    self.videoCall()
                    return
                }else if (userProfileJson.get("CALLING_METHOD_BUY_SELL_RENT").uppercased() == Utils.VOIP_VIDEOCALL) {
                    let openListView = OpenListView(uv: self, containerView: self.view)
                    openListView.openNewList = true
                    openListView.isFromDate = true
                    openListView.showVideoAudioPopUp(currentInst: openListView, handler: { (selectedItemId) in
                                   // 0 for video 1 for camera
                    if selectedItemId == 0 {
                        self.videoCall()
                    }else {
                        self.audioCall()
                    }
                    })
                    return
                }else{
                   
                    guard let url = URL(string: "telprompt://\(self.data.get("vUserPhone"))"),
                            UIApplication.shared.canOpenURL(url) else {
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            
        }else if sender == self.btnOk {
            rentItemDetialsUV.getDataFromQury()
            self.close()
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        
    }
    func setBottomView(){
        self.backGroundView.isHidden = false
        self.bottomView.isHidden = false
        
        self.bottomView.addShadowWithCornerRadius_new()
        self.btnOk.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK"))
        self.btnCall.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_TXT"))
        self.btnCall.setCustomColor(textColor: UIColor.black, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: UIColor.black, borderWidth: 1, cornerRadius: 10)
        self.bottomTittleLbl.textColor = UIColor.init(hex: 0x817E7E)
        self.bottomTittleHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_INQUIRY_SENT_TXT")

        
//        Utils.delayWithSeconds(1) {
//            self.bottomView.roundTo(corners: [.topLeft,.topRight], radius: 10)
//        }
        self.btnOk.clickDelegate = self
        self.btnCall.clickDelegate = self
    }
    func audioCall(){
       
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType]
        let assignedDic = ["Id":self.data.get("iUserId"), "Name": self.data.get("vUserName"), "PImage": self.data.get("vUserImage"), "type": "Passenger"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.data.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"")
        return
    }
    func videoCall(){
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        let selfDic = ["Id":userProfileJson.get("iUserId"), "Name": userProfileJson.get("vName"), "PImage": userProfileJson.get("vImgName"), "type": Utils.appUserType, "isVideoCall":"Yes"]
        let assignedDic = ["Id":self.data.get("iUserId"), "Name": self.data.get("vUserName"), "PImage": self.data.get("vUserImage"), "type": "Passenger", "isVideoCall":"Yes"]
    
    
        SinchCalling.getInstance().makeACall(IDString:"Passenger" + "_" + self.data.get("iUserId"), assignedData: assignedDic as NSDictionary, selfData: selfDic, withRealNumber:"", true)
        return
    }
    func contactOwnerMailSend(){
       
        let parameters = ["type": "sendContactQueryForRent", "iMemberId": GeneralFunctions.getMemberd(), "iRentItemOwnerId": self.data.get("iUserId"), "iRentItemPostId": self.data.get("iRentItemPostId"),"iName" : self.nameTxtFiled.text , "iEmail" : self.emailTxtFiled.text ,"iMobileNo" : self.phoneNoTxtFiled.text, "iPhoneCode" : self.selectedPhoneCode ]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    self.bottomTittleLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                    self.isContactOwner = true
                    Utils.isOwnerPostSendInquiry = "TRUE"
                    self.setBottomView()
//                    self.loadTripFinishView(title: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message_title"), key: dataDict.get("message_title")) , des: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")))
                }
               
            }else{
            }
        })
    }
    func loadTripFinishView(title : String, des: String){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        opnTripFinishView.isNewDialouge = true
        opnTripFinishView.isFromMyRide = true
//        if self.data.get("eIsUserNumberDisplay") == "Yes" {
//            opnTripFinishView.newbtnPostiveTitle.isHidden = false
//        }else{
//            opnTripFinishView.newbtnPostiveTitle.isHidden = true
//        }
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK")
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CALL_TXT")
        opnTripFinishView.show(title: title, desc:des ) {
            
        }
    }
    override func close(){
        
        if rentItemDetialsUV != nil {
            if self.isContactOwner{
                rentItemDetialsUV.getDataFromQury()
                self.navigationController?.popViewController(animated: true)
                return
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
