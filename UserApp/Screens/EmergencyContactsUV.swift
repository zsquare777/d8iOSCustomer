

import UIKit
import SysBaseLib

class EmergencyContactsUV: ParentViewUV, UITableViewDataSource, UITableViewDelegate, EPPickerDelegate, MyBtnClickDelegate, ParentViewUVDelegate ,MyTxtFieldClickDelegate, MyTxtFieldOnTextChangeDelegate {
    
    

    @IBOutlet weak var emeBannerImg: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addContactView: UIView!
    @IBOutlet weak var addContactViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addContactBtn: MyButton!
    @IBOutlet weak var noteLbl: MyLabel!
    @IBOutlet weak var headerLbl: MyLabel!
    @IBOutlet weak var subHeaderLbl: MyLabel!
    @IBOutlet weak var subTitleLbl: MyLabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var nameTxtFiled: MyTextField!
    @IBOutlet weak var cuntryTxtFiled: MyTextField!
    @IBOutlet weak var noTxtFiled: MyTextField!
    @IBOutlet weak var btnCancel: MyButton!
    @IBOutlet weak var btnOk: MyButton!
    
    @IBOutlet weak var popUpY: NSLayoutConstraint!
    var selectedCountryCode  = ""
    var selectedPhoneCode = ""
    var isFromCountrySelction = false
    var countryImageurl = ""
    var countryPrefixImgView:UIImageView!
    let generalFunc = GeneralFunctions()
    
    var dataArrList = [NSDictionary]()
    var countryListArr:NSArray!
    var loaderView:UIView!
    
    var userProfileJson:NSDictionary!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "EmergencyContactsScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
            setData()
            
            self.tableView.delegate = self
            
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.register(UINib(nibName: "EmergencyContactsTVCell", bundle: nil), forCellReuseIdentifier: "EmergencyContactsTVCell")
            self.tableView.bounces = false
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            getData()
            
        }else if(type == 1){
            CountryListData.getInstance().getCountryListData { (dataArray, isSuccess) in
                if(isSuccess){
                    self.countryListArr = dataArray
                }
            }
            self.configRTL()
            
        }
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(){
        
        self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT")
        
        if ServiceModule.rideDeliveryUbexProduct || ServiceModule.isUFXOnly(){
            self.headerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FOR_SAFETY")
        }else{
            self.headerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT_TITLE")
        }
        self.headerLbl.textColor = SColors.Theme
        self.subHeaderLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT_SUB_TITLE1")
        self.subHeaderLbl.fit()
        self.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMERGENCY_CONTACT_SUB_TITLE2")
        self.subTitleLbl.fit()
        self.noteLbl.text = Configurations.convertNumToAppLocal(numStr: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_EMERGENCY_UP_TO_COUNT"))
        self.addContactBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_CONTACTS"))
        
        self.addContactBtn.clickDelegate = self
        
        
    }
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.addContactBtn){
            
            self.handelPopUp(isHiden: false)
            return
            let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:false, subtitleCellType: SubtitleCellValue.phoneNumber)
            
            self.push(uv: contactPickerScene)

        }
        else if (sender == self.btnOk) {
            let mobileInvalid = generalFunc.getLanguageLabel(origValue: "Invalid mobile no.", key: "LBL_INVALID_MOBILE_NO")
            let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            let fNameEntered = Utils.checkText(textField: self.nameTxtFiled.getTextField()!) ? true : Utils.setErrorFields(textField: self.nameTxtFiled.getTextField()!, error: required_str)
            let mobileEntered = Utils.checkText(textField: self.noTxtFiled.getTextField()!) ? (Utils.getText(textField: self.noTxtFiled.getTextField()!).count >= Utils.minMobileLength ? true : Utils.setErrorFields(textField: self.noTxtFiled.getTextField()!, error: mobileInvalid)) : Utils.setErrorFields(textField: self.noTxtFiled.getTextField()!, error: required_str)
            if (fNameEntered == false  ||  mobileEntered == false) {
                return;
            }
            
            self.addContact(contactName: self.nameTxtFiled.text, contactPhone: "+" + selectedPhoneCode + " " + self.noTxtFiled.text)
            self.handelPopUp(isHiden: true)
        }else if (sender == self.btnCancel){
            self.handelPopUp(isHiden: true)
        }
    }

    func getData(){
        self.contentView.isHidden = true
        loaderView =  self.generalFunc.addMDloader(contentView: self.view)
        loaderView.backgroundColor = UIColor.clear
        
        self.dataArrList.removeAll()
        
        let parameters = ["type": "loadEmergencyContacts", "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList += [dataTemp]
                        
                    }
                    
                    if(dataArr.count >= 5){
                        self.addContactViewHeight.constant = 0
                        self.addContactView.isHidden = true
                    }else{
                        self.addContactViewHeight.constant = 133
                        self.addContactView.isHidden = false
                    }
                    self.tableView.isHidden = false
                    self.generalView.isHidden = true

                    self.tableView.reloadData()
                    
                }else{
//                    _ = GeneralFunctions.addMsgLbl(contentView: self.view, msg: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    self.generalView.isHidden = false
                    self.tableView.isHidden = true
                }
                
            }else{
                self.generalFunc.setError(uv: self)

            }
            
            self.loaderView.isHidden = true
            
            self.contentView.isHidden = false
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyContactsTVCell", for: indexPath) as! EmergencyContactsTVCell
        
        let item = self.dataArrList[indexPath.item]
        
        cell.contactNameLbl.text = item.get("vName")
        cell.myNumLbl.text = item.get("vPhone")
        
        let removeTapGue = UITapGestureRecognizer()
        removeTapGue.addTarget(self, action: #selector(self.removeContact(sender:)))
        cell.removeImgView.isUserInteractionEnabled = true
        cell.removeImgView.addGestureRecognizer(removeTapGue)
        cell.removeImgView.tag = indexPath.item
        GeneralFunctions.setImgTintColor(imgView: cell.removeImgView, color: UIColor.white)
        GeneralFunctions.setImgTintColor(imgView: cell.imgRightShape, color: SColors.Theme)
//        if(Configurations.isRTLMode() == true){
//            cell.imgRightShape.transform = CGAffineTransform(scaleX: -1, y: 1)
//        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        if(Configurations.isRTLMode() == true){
            cell.imgRightShape.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 1500
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
//    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error: NSError) {
////        _.close()
//    }
//    
//    func epContactPicker(_: EPContactsPicker, didSelectContact contact: EPContact) {
////        _.close()
//        Utils.printLog(msgData: "ContactName:\(contact.displayName())")
//        Utils.printLog(msgData: "PhoneNum:\(contact.getPhoneNumber())")
//        addContact(contactName: contact.displayName(), contactPhone: contact.getPhoneNumber())
//    }
//    
//    func epContactPicker(_: EPContactsPicker, didCancel error: NSError) {
////         _.close()
//    }
    
    func epContactPicker(_ epEontactsPicker: EPContactsPicker, didContactFetchFailed error : NSError)
    {
//        print("Failed with error \(error.description)")
        epEontactsPicker.close()
    }
    
    func epContactPicker(_ epEontactsPicker: EPContactsPicker, didSelectContact contact : EPContact)
    {
//        print("Contact \(contact.displayName()) has been selected")
//        print("Contact \(contact.phoneNumbers) has been selected")
//        print("Contact \(contact.phoneNumber_Value) has been selected")
        epEontactsPicker.navigationController?.popViewController(animated: true)
        
        addContact(contactName: contact.displayName(), contactPhone: contact.getPhoneNumber())
    }
    
    func epContactPicker(_ epEontactsPicker: EPContactsPicker, didCancel error : NSError)
    {
//        print("User canceled the selection");
        epEontactsPicker.close()
    }
    
    @objc func removeContact(sender:UITapGestureRecognizer){
        
        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_MSG_DELETE_EME_CONTACT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
            
            if(btnClickedIndex == 0){
                self.continueRemoveContactProcess(sender: sender)
            }
            
        })
    }
    
    func continueRemoveContactProcess(sender:UITapGestureRecognizer){
        
        let parameters = ["type":"deleteEmergencyContacts", "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd(),"iEmergencyId": self.dataArrList[sender.view!.tag].get("iEmergencyId")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.getData()
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
        })
        
    }
    
    func addContact(contactName:String, contactPhone:String){
        
        let parameters = ["type":"addEmergencyContacts", "UserType": Utils.appUserType, "iUserId": GeneralFunctions.getMemberd(),"vName": contactName, "Phone": contactPhone]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.getData()
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EME_CONTACT_LIST_UPDATE"), uv: self)

                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
        })
    }
    func myTxtFieldTapped(sender: MyTextField) {
        if sender == cuntryTxtFiled {
        let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
        countryListUv.fromEmergenContact = true
        countryListUv.emergencyContactUv = self
            if countryListArr != nil {
                countryListUv.countryListArr = self.countryListArr
            }

        
        countryListUv.modalPresentationStyle = .overCurrentContext
        self.present(countryListUv, animated: true)
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        
    }
    func handelPopUp(isHiden : Bool)   {
      
        self.bgView.isHidden = isHiden
        self.popUpView.isHidden = isHiden
        if isHiden {
           
            self.cuntryTxtFiled.setText(text: "")
            self.noTxtFiled.setText(text: "")
            self.nameTxtFiled.setText(text: "")
            self.nameTxtFiled.getTextField()!.isErrorRevealed = false
            self.cuntryTxtFiled.getTextField()!.isErrorRevealed = false
            self.noTxtFiled.getTextField()!.isErrorRevealed = false
            if countryPrefixImgView != nil {
            self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.userProfileJson.get("vSCountryImage"), width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 27))), placeholderImage:nil)
            }
        }
        self.cuntryTxtFiled.onTextChangedDelegate = self
        self.cuntryTxtFiled.setEnable(isEnabled: false)
//        self.cuntryTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
            cuntryTxtFiled.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
            self.cuntryTxtFiled.myTxtFieldDelegate = self
            
            
        }
        if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
             
                 self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                 self.selectedPhoneCode = userProfileJson.get("vPhoneCode")//(GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
            cuntryTxtFiled.setText(text: "+\(self.selectedPhoneCode)")
             
                          
        }
        cuntryTxtFiled.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 20,25) { (imageView) in
            
           
                self.countryPrefixImgView = imageView
               
                    self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.userProfileJson.get("vSCountryImage"), width: Utils.getValueInPixel(value: 25), height: Utils.getValueInPixel(value: 25))), placeholderImage:nil)
                
            
          
        }
        self.nameTxtFiled.setEnable(isEnabled: true)
        self.nameTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FULL_NAME"))
        self.noTxtFiled.setEnable(isEnabled: true)
        self.noTxtFiled.getTextField()!.keyboardType = .numberPad
        self.noTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MOBILE_NUMBER_HEADER_TXT"))
        self.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_DETAILS_TXT")
        self.btnOk.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_BUTTON_TXT"))
        self.btnOk.clickDelegate = self
        self.btnCancel.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
        self.btnCancel.clickDelegate = self
        self.cancelImageView.handleClick { instance in
            self.handelPopUp(isHiden: true)
        }
        self.btnOk.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.btnCancel.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
    }
    func sendData() {
      
        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: countryImageurl, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 27))), placeholderImage:nil)
        self.cuntryTxtFiled.setText(text: "+\(selectedPhoneCode)")
        
        }
    @objc func keyboardWillDisappear(sender: NSNotification){
       // self.popUpY.constant = -15
    }
    @objc func keyboardWillAppear(sender: NSNotification){
        //self.popUpY.constant = 45
    }
}
