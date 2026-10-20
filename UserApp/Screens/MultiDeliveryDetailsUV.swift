

import UIKit
import CoreLocation
import SysBaseLib

class MultiDeliveryDetailsUV: ParentViewUV, MyBtnClickDelegate, MyTxtFieldClickDelegate, MyTxtFieldOnTextChangeDelegate, UITextViewDelegate, ParentViewUVDelegate ,DataSendToDedliveryDelegate{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var submitBtn: MyButton!
   

    
    @IBOutlet weak var dataContainerMainView: UIView!
    var receiverNameTxtField: MyTextField!
    var receiverMobileTxtField: MyTextField!
    var pickUpInsTxtField: MyTextField!
    var deliveryInsTxtField: MyTextField!
    var packageTypeTxtField: MyTextField!
    var packageDetailsTxtField: MyTextField!
    var cuntryTxtFiled: MyTextField!
    @IBOutlet weak var resetBtn: MyButton!
    
    let generalFunc = GeneralFunctions()
    
    @IBOutlet weak var dataContainerViewHeight: NSLayoutConstraint!
    var PAGE_HEIGHT:CGFloat = 500
    
    var isFirstLaunch = true
    
    var cntView:UIView!
    
    var isDeliverLater = false
    var loaderView:UIView!
    
    var packageListDictArr = [NSDictionary]()
    
    var packageListArr = [String]()
    
    var required_str = ""
    var selectedPackageTypeId = -1
    var packageTypeId = ""
    
    var fieldObjArray = [[String : Any]]()
    var userProfileJson:NSDictionary!
    
    var pickUpLat = 0.0
    var pickUpLong = 0.0
    var pickUpAddress = ""
    
    var destLatitude = ""
    var destLongitude = ""
    var address = ""
    var centerLoc:CLLocation!
    var selectedCountryCode  = ""
    var selectedPhoneCode = ""
    var isFromCountrySelction = false
    var countryImageurl = ""
    var isFromEditForMulti = false
    var selectedMultiIndex:Int!
    var countryPrefixImgView:UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "MultiDeliveryDetailsScreenDesign", uv: self, contentView: contentView)
            
            self.scrollView.addSubview(cntView)
            
            
            self.addBack()
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.userProfileJson = userProfileJson
          
            //setData()
            scrollView.isHidden = true
            
        }else if(type == 1){
            
            self.configRTL()
            dataContainerMainView.shadowColor = UIColor.lightGray
            dataContainerMainView.shadowOffset = CGSize(width: 0, height: 0.0)
            dataContainerMainView.shadowRadius = 2.0
            dataContainerMainView.shadowOpacity = 1.0
            dataContainerMainView.masksToBounds = false
            
            
        }else if(type == 2){
            if(isFirstLaunch == true){
               // packageTypeTxtField.addImageView(color: UIColor(hex: 0xbfbfbf), transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)))
                
                //cntView.frame.size = CGSize(width: cntView.frame.width, height: PAGE_HEIGHT)
                
                self.scrollView.bounces = false

               // self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT)
                
                isFirstLaunch = false
                
                
                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.MULTI_DELIVERY_DETAIL_STORED) == true && ((GeneralFunctions.getValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED) as! Bool) == true && isFromEditForMulti == true))
                {
                    let storedArray = (GeneralFunctions.getValue(key: Utils.DELIVERY_DETAIL_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                    self.loadAndSetData(array: storedArray[self.selectedMultiIndex] as! NSArray)
                    self.resetBtn.setButtonEnabled(isBtnEnabled: true)
                    
                }else
                {
                    getFormDetails()
                }
               
                //getData()
            }
            
        }
    }
    
    
    func getFormDetails(){
        
        let parameters = ["type":"getDeliveryFormFields","iMemberId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            //print("Response:\(response)")
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.loadAndSetData(array: dataDict.arrOf("message"))
                    
                }else{
                    if(dataDict.get(Utils.message_str) == ""){
                        self.generalFunc.setError(uv: self)
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                    }
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func loadAndSetData(array:NSArray)
    {
        var txtAreaCount = 0
        
        var arrayCount = array.count
        
        if (isFromEditForMulti == false)
        {
            arrayCount = arrayCount + 1
        }
        
        
        for i in 0..<arrayCount{
            
            var item = NSDictionary.init()
            if i == arrayCount - 1 && isFromEditForMulti == false
            {
                item = [:]
            }else{
                item = array[i] as! NSDictionary
            }
            
//            let y = i * 60 + ((txtAreaCount * 28) + (txtAreaCount * 28))
//            let y1 = i * 15
            let y = i * 65 + ((txtAreaCount * 28) + (txtAreaCount * 28))
            let y1 = i * 30
            
            if item.get("eInputType") == "Select"
            {
                let arrObj = item["Options"] as! NSArray
                
                let headerLbl = UILabel.init(frame: CGRect(x: 10, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                headerLbl.textColor = UIColor.black
                headerLbl.text = item.get("vFieldName")
                headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = MyTextField.init(frame: CGRect(x: 10, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 20), height: 60))
                obj.isCardView = true
                //obj.addImageView(color: UIColor(hex: 0xbfbfbf), transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)))
                obj.addImageView(color: SColors.Theme, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 30, 30, nil)
                obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                obj.disableMenu()
                obj.getTextField()!.clearButtonMode = .never
                obj.setEnable(isEnabled: false)
                obj.myTxtFieldDelegate = self
                obj.onTextChangedDelegate = self
                self.dataContainerView.addSubview(headerLbl)
                self.dataContainerView.addSubview(obj)
                self.dataContainerViewHeight.constant = self.dataContainerViewHeight.constant + 80
                
                var selectedId = "-1"
                if item["selectedId"] != nil
                {
                    
                    for i in 0..<arrObj.count
                    {
                        let item2 = arrObj[i] as! NSDictionary
                        if item.get("selectedId") == item2.get("iPackageTypeId")
                        {
                            selectedId = item.get("selectedId")
                            obj.setText(text: item2.get("vName"))
                        }
                    }
                }
                
                let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Select","selectedId":selectedId, "Options":arrObj , "iDeliveryFieldId":item.get("iDeliveryFieldId"), "eRequired":item.get("eRequired")] as [String : Any]
                 self.fieldObjArray.append(dic2)
                
            }else if item.get("eInputType") == "Textarea"{
                
                let headerLbl = UILabel.init(frame: CGRect(x: 10, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 20), height: 20))
                headerLbl.textColor = SColors.blackColor
                headerLbl.text = item.get("vFieldName")
                headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = KMPlaceholderTextView.init(frame: CGRect(x: 10, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 20), height: 90))
                obj.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_SUBJECT_HINT_CONTACT_TXT")
                obj.placeholderColor = .lightGray
                obj.delegate = self
                obj.borderColor = UIColor.lightGray
                obj.borderWidth = 1
                obj.layer.cornerRadius = 6
                let bottomView = UIView.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.dataContainerView.frame.size.width - 20), height: 0))
                bottomView.backgroundColor = UIColor.lightGray
                
                let requiredLbl = UILabel.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.dataContainerView.frame.size.width - 20), height: 20))
                requiredLbl.font = UIFont.systemFont(ofSize: 12, weight:UIFont.Weight.thin)
                requiredLbl.textColor = UIColor.red
                requiredLbl.isHidden = true
                requiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                
                
                
                self.dataContainerView.addSubview(bottomView)
                self.dataContainerView.addSubview(headerLbl)
                self.dataContainerView.addSubview(requiredLbl)
                
                // obj.placeholder = item.get("vFieldName")
                txtAreaCount = txtAreaCount + 1
                self.dataContainerView.addSubview(obj)
                
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.text = text
                }
                let dic2 = ["Object":obj,"bottomView":bottomView, "headerLbl":headerLbl,"requiredLbl":requiredLbl, "vFieldName":item.get("vFieldName"), "eInputType":"Textarea", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "text":text, "eRequired":item.get("eRequired")] as [String : Any]
                self.fieldObjArray.append(dic2)
                
            }else if (i == arrayCount - 1) {
                
               print("Calleddddddddd")
                let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 25 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                headerLbl.textColor = UIColor.black
                headerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DEST_ADD_TXT")
                headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = MyTextField.init(frame: CGRect(x: 10, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 20), height: 60))
                obj.isCardView = true
                obj.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DEST_ADD_TXT"))
                obj.setEnable(isEnabled: false)
                obj.myTxtFieldDelegate = self
                self.dataContainerView.addSubview(headerLbl)
                self.dataContainerView.addSubview(obj)
                
                if (item["lat"] != nil && item["long"] != nil && item["addr"] != nil)
                {
                    self.destLatitude = item.get("lat")
                    self.destLongitude = item.get("long")
                    self.address = item.get("addr")
                    obj.setText(text: self.address)
                }
                let dic2 = ["Object":obj, "vFieldName": "Address", "eInputType":"Address", "lat":self.destLatitude, "long":self.destLongitude, "addr":self.address, "eRequired":item.get("eRequired")] as [String : Any]
                self.fieldObjArray.append(dic2)
    
                
            }else{
                //1.
                 
//                //if  item.get("eInputType") == "Number" {
//                    let objCuntryCode = MyTextField.init(frame: CGRect(x: 10, y: 15 + y1 + y, width: Int(50), height: 60))
//
//                    objCuntryCode.setPlaceHolder(placeHolder: item.get("vFieldName"))
//                    objCuntryCode.onTextChangedDelegate = self
//                    self.dataContainerView.addSubview(objCuntryCode)
//                //}
                if  item.get("eInputType") != "Number"  && item.get("tempInput") != "Number"{
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = UIColor.black
                    headerLbl.text = item.get("vFieldName")
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                let obj = MyTextField.init(frame: CGRect(x: 10, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 20), height: 60))
                obj.isCardView = true
                obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                obj.onTextChangedDelegate = self
                self.dataContainerView.addSubview(obj)
                self.dataContainerView.addSubview(headerLbl)
               
                
                
                
                if item.get("eInputType") == "Number"
                {
                    if item.get("eAllowFloat") == "No"
                    {
                        (obj ).getTextField()!.keyboardType = .numberPad
                    }else
                    {
                        (obj ).getTextField()!.keyboardType = .decimalPad
                    }
                    if item.get("tDesc") != "" {
                        let objTxt = MyLabel.init(frame: CGRect(x: 10, y: 15 + y1 + y + 30, width: Int(self.dataContainerView.frame.size.width - 20), height: 60))
                       
                        objTxt.text = item.get("tDesc")
                        objTxt.numberOfLines = 2
    //                    y1 =  y1 + 60
    //                    y =   y + 60
                        objTxt.font = UIFont(name: Fonts().regular, size: 12)!
                        objTxt.textColor = UIColor.lightGray
                        objTxt.tag = 2800
                        self.dataContainerView.addSubview(objTxt)
                    }
                }
                var text = ""
                if item["text"] != nil
                {
                    text = item.get("text")
                    obj.setText(text: text)
                }
                    var tempPut = ""
                    if item.get("tempInput") == ""{
                        tempPut = item.get("eInputType")
                    }else{
                        tempPut = item.get("tempInput")
                    }
                let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "text":text, "eRequired":item.get("eRequired"),"tempInput" : tempPut ] as [String : Any]
                self.fieldObjArray.append(dic2)
                }else{
                  
                    let objCuntryCode = MyTextField.init(frame: CGRect(x: 10, y: 60 + y1 + y, width: Int(100), height: 60))
                    objCuntryCode.isCardView = true
                    cuntryTxtFiled = objCuntryCode
                    objCuntryCode.onTextChangedDelegate = self
                    objCuntryCode.tag = 2025
                    objCuntryCode.setEnable(isEnabled: false)
                    objCuntryCode.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COUNTRY_TXT"))
                    
                    if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SHOW_COUNTRY_LIST) == true && GeneralFunctions.getValue(key: Utils.SHOW_COUNTRY_LIST)?.uppercased == "YES"){
                        objCuntryCode.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
                        objCuntryCode.myTxtFieldDelegate = self
                        
                        objCuntryCode.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)), isCustomImage:true, "ic_arrow_right", 20, 20, nil)
                        objCuntryCode.myTxtFieldDelegate = self
                    }
                    if(GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String) != "" && GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) != nil && (GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String) != ""){
                         if item.get("countryCode") == "" {
                             self.selectedCountryCode = (GeneralFunctions.getValue(key: Utils.DEFAULT_COUNTRY_CODE_KEY) as! String)
                             self.selectedPhoneCode = userProfileJson.get("vPhoneCode")//(GeneralFunctions.getValue(key: Utils.DEFAULT_PHONE_CODE_KEY) as! String)
                            objCuntryCode.setText(text: "+\(self.selectedPhoneCode)")
                         }else{
                             self.selectedCountryCode = item.get("countryCode")
                            self.selectedPhoneCode = item.get("countryCode")
                            objCuntryCode.setText(text: "+\(self.selectedPhoneCode)")
                         }
                                      
                    }
                    objCuntryCode.addImgeViewToLeft(color:nil,transform: .identity, isCustomImage: true, "ic_invite_detail", 20,25) { (imageView) in
                        
                        if(self.countryPrefixImgView == nil){
                            self.countryPrefixImgView = imageView
                            if item.get("countryCode") == "" {
                                self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.userProfileJson.get("vSCountryImage"), width: Utils.getValueInPixel(value: 25), height: Utils.getValueInPixel(value: 25))), placeholderImage:nil)
                            }else{
                                self.countryImageurl = item.get("countryImgurl")
                                self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:  item.get("countryImgurl"), width: Utils.getValueInPixel(value: 25), height: Utils.getValueInPixel(value: 25))), placeholderImage:nil)
                            }
                        }
                      
                    }
                   
                    self.dataContainerView.addSubview(objCuntryCode)
                                    
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = UIColor.black
                     headerLbl.text = item.get("vFieldName")
                     headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.regular)
                    let obj = MyTextField.init(frame: CGRect(x: 120, y: 60 + y1 + y, width: Int(self.dataContainerView.frame.size.width - 120), height: 60))
                    obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                    obj.isCardView = true
                    obj.onTextChangedDelegate = self
                    self.dataContainerView.addSubview(obj)
                    self.dataContainerView.addSubview(headerLbl)
                                    
                                   
                                    
                                    
                                    
                                    if item.get("eInputType") == "Number"
                                    {
                                        if item.get("eAllowFloat") == "No"
                                        {
                                            (obj ).getTextField()!.keyboardType = .numberPad
                                        }else
                                        {
                                            (obj ).getTextField()!.keyboardType = .decimalPad
                                        }
                                        if item.get("tDesc") != "" {
                                            let objTxt = MyLabel.init(frame: CGRect(x: 10, y: 15 + y1 + y + 30, width: Int(self.dataContainerView.frame.size.width - 20), height: 60))
                                           
                                            objTxt.text = item.get("tDesc")
                                            objTxt.numberOfLines = 2
                        //                    y1 =  y1 + 60
                        //                    y =   y + 60
                                            objTxt.font = UIFont(name: Fonts().regular, size: 12)!
                                            objTxt.textColor = UIColor.lightGray
                                            objTxt.tag = 2800
                                            self.dataContainerView.addSubview(objTxt)
                                        }
                                    }
                                    var text = ""
                                    if item["text"] != nil
                                    {
                                        if item.get("textInputTemp") == ""{
                                        text = item.get("text")
                                        obj.setText(text: text)
                                        }else{
                                            text = item.get("textInputTemp")
                                            obj.setText(text: text)
                                        }
                                    }
                    
                    var tempPut = ""
                    if item.get("tempInput") == ""{
                        tempPut = item.get("eInputType")
                    }else{
                        tempPut = item.get("tempInput")
                    }
                                    let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "text":text, "eRequired":item.get("eRequired"),"tempInput" : tempPut] as [String : Any]
                                    self.fieldObjArray.append(dic2)
                
            }
            }
            
            self.PAGE_HEIGHT = CGFloat(15 + y1 + y + 175)
            self.dataContainerViewHeight.constant = CGFloat(15 + y1 + y + 100)
            self.cntView.frame.size = CGSize(width: self.cntView.frame.width, height: self.PAGE_HEIGHT)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT)
            self.scrollView.isHidden = false
            
            self.setData()
            
        
        
    }
    }
    func setData(){
        required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_DETAILS")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_DETAILS")
        //        LBL_EDIT_PROFILE_TXT
    
        self.resetBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESET"))

        
        self.resetBtn.clickDelegate = self
        self.submitBtn.clickDelegate = self
        self.resetBtn.setButtonEnabled(isBtnEnabled: false)
        self.submitBtn.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 10)
        self.resetBtn.setCustomColor(textColor: SColors.blackColor, bgColor: .clear, pulseColor: .clear, borderColor: SColors.blackColor, borderWidth: 1, cornerRadius:10 )
        if(isDeliverLater == false){
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_TXT"))
        }else{
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_TXT"))
        }
    }
    
    func onTextChanged(sender: MyTextField, text: String) {
        
        self.resetBtn.setButtonEnabled(isBtnEnabled: false)
        for i in 0..<self.fieldObjArray.count{
            
            let item = self.fieldObjArray[i]
            if item["eInputType"] as! String == "Select" || item["eInputType"] as! String == "Text"
            {
                if (item["Object"] as! MyTextField).text != ""
                {
                    self.resetBtn.setButtonEnabled(isBtnEnabled: true)
                }
                if sender.getTextField()?.keyboardType == .numberPad || sender.getTextField()?.keyboardType == .decimalPad {
                    if let viewWithTag = self.dataContainerView.viewWithTag(2800) {
                        viewWithTag.isHidden = false
                    }else{
                        
                    }
                }
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text != ""
        {
            
            self.resetBtn.setButtonEnabled(isBtnEnabled: true)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        for i in 0..<self.fieldObjArray.count{
            
            let item = self.fieldObjArray[i]
            
            if item["eInputType"] as! String == "Textarea"
            {
                if textView == (item["Object"] as! KMPlaceholderTextView)
                {
                    (item["bottomView"] as! UIView).backgroundColor = SColors.Theme
                    (item["headerLbl"] as! UILabel).textColor = SColors.Theme
                    (item["requiredLbl"] as! UILabel).isHidden = true
                }
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        for i in 0..<self.fieldObjArray.count{
            
            let item = self.fieldObjArray[i]
            
            if item["eInputType"] as! String == "Textarea"
            {
                if textView == (item["Object"] as! KMPlaceholderTextView)
                {
                    (item["bottomView"] as! UIView).backgroundColor = UIColor.lightGray
                    (item["headerLbl"] as! UILabel).textColor = UIColor.lightGray
                }
            }
        }
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
        
        if sender.tag == 2025 {
            let countryListUv = GeneralFunctions.instantiateViewController(pageName: "CountryListUV") as! CountryListUV
            countryListUv.fromdeliveryDetails = true
            countryListUv.multidelDetials = self
            countryListUv.dataSendToDedliveryDelegate = self
//            if(countryListArr != nil){
//                countryListUv.countryListArr = countryListArr
//            }
            
            countryListUv.modalPresentationStyle = .overCurrentContext
            self.present(countryListUv, animated: true) {
            }
        }else{
        for i in 0..<self.fieldObjArray.count{
            
            let item = self.fieldObjArray[i] as NSDictionary
            if item["eInputType"] as! String == "Select"
            {
                if(sender == item["Object"] as! MyTextField){
                    
                    self.hideKeyboard()
                    
                    let listArray = self.getOptionsName(array: item["Options"] as! NSArray)
                    let openListView = OpenListView(uv: self, containerView: self.view)
                    openListView.selectedItem = (item["Object"] as! MyTextField).text
                    openListView.show(listObjects: listArray, title: item["vFieldName"] as! String, currentInst: openListView, handler: { (selectedItemId) in
                        
                        (item["Object"] as! MyTextField).getTextField()!.isErrorRevealed = false
                        let iPackageTypeIdDic = (item["Options"] as! NSArray)[Int(selectedItemId)] as! NSDictionary
                        let dic2 = ["Object": item["Object"] as! MyTextField, "vFieldName": item.get("vFieldName"), "eInputType":"Select","selectedId": iPackageTypeIdDic.get("iPackageTypeId"), "iDeliveryFieldId":item.get("iDeliveryFieldId"), "eRequired":item.get("eRequired"), "Options": item["Options"] as! NSArray] as [String : Any]
                        self.fieldObjArray.remove(at: i)
                        self.fieldObjArray.insert(dic2, at: i)
                        
                        (item["Object"] as! MyTextField).setText(text: listArray[selectedItemId])
                        (item["Object"] as! MyTextField).getTextField()!.sendActions(for: .editingChanged)
                        print(self.fieldObjArray)
                    })
                }
            }else if (item["eInputType"] as! String == "Address")
            {
                if(sender == item["Object"] as! MyTextField)
                {
                    let launchPlaceFinder = LaunchPlaceFinder(viewControllerUV: self)
                    launchPlaceFinder.currInst = launchPlaceFinder
                    
                    launchPlaceFinder.setBiasLocation(sourceLocationPlaceLatitude: centerLoc.coordinate.latitude, sourceLocationPlaceLongitude: centerLoc.coordinate.longitude)
                    
                    
                    launchPlaceFinder.initializeFinder { (address, latitude, longitude) in
                       
                        
                    let parameters = ["type":"Checkpickupdropoffrestriction", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "PickUpLatitude": "\(self.pickUpLat)", "PickUpLongitude": "\(self.pickUpLong)", "DestLatitude": "\(latitude)", "DestLongitude": "\(longitude)"]
                    
                    let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
                    exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                        
                            if(response != ""){
                                let dataDict = response.toDict()
                                
                                if(dataDict.get("Action") == "1"){
                                   
                                    self.destLatitude = String(latitude)
                                    self.destLongitude = String(longitude)
                                    self.address = address
                                    (item["Object"] as! MyTextField).setText(text: address)
                                    
                                }else{
                                    
                                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                                }
                                
                            }else{
                                self.generalFunc.setError(uv: self)
                            }
                        })
                    
                        //            if(self.mainScreenUv != nil){
                        //                self.mainScreenUv.setTripLocation(selectedAddress: address, selectedLocation: CLLocation(latitude: latitude, longitude: longitude))
                        //}
                    }
                }
                
            }
            
        }
        }
    }
    
    func getOptionsName(array:NSArray) -> [String]
    {
        var returnArray = [String]()
        for i in 0..<array.count{
            let item = array[i] as! NSDictionary
            returnArray.append(item.get("vName"))
        }
        return returnArray
    }
   
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.submitBtn){
            
            
            var verified = ""
            for i in 0..<self.fieldObjArray.count{
                
                let item = self.fieldObjArray[i] as NSDictionary
                
                if item["eInputType"] as! String == "Select"
                {
                    if item["selectedId"] as! String == "-1" && item["eRequired"] as! String == "Yes"
                    {
                        let valueAdded = (Utils.checkText(textField: (item["Object"] as! MyTextField).getTextField()!)) ? true : Utils.setErrorFields(textField: (item["Object"] as! MyTextField).getTextField()!, error: required_str)
                        if valueAdded == false
                        {
                            verified = "-1"
                        }
                    }
     
                }else if item["eInputType"] as! String == "Textarea"{
                    
                    if (item["Object"] as! KMPlaceholderTextView).text == "" && item["eRequired"] as! String == "Yes"
                    {
                        (item["requiredLbl"] as! UILabel).isHidden = false
                        verified = "-1"
                    }
                   
                }else{
                    
                    if item["eInputType"] as! String == "Address"
                    {
                        let valueAdded = (Utils.checkText(textField: (item["Object"] as! MyTextField).getTextField()!)) ? true : Utils.setErrorFields(textField: (item["Object"] as! MyTextField).getTextField()!, error: required_str)
                        if valueAdded == false
                        {
                            verified = "-1"
                        }
                    }else
                    {
                        if item["eRequired"] as! String == "Yes"
                        {
                            
                            if item.get("tempInput") == "Number"
                            {
                                if (item["Object"] as! MyTextField).text == "" {
                                if let viewWithTag = self.dataContainerView.viewWithTag(2800) {
                                    viewWithTag.isHidden = true
                                }else{
                                    
                                }
                                }
                            }
                            
                            let valueAdded = (Utils.checkText(textField: (item["Object"] as! MyTextField).getTextField()!)) ? true : Utils.setErrorFields(textField: (item["Object"] as! MyTextField).getTextField()!, error: required_str)
                            if valueAdded == false
                            {
                                verified = "-1"
                            }
                        }
                    }
                    
                }
            }
            
            if verified == "-1"
            {
                return
            }
            print(self.fieldObjArray)
            for i in 0..<self.fieldObjArray.count{
                
                let item = self.fieldObjArray[i] as NSDictionary
                
                if item["eInputType"] as! String == "Select"
                {
                    var selectedId = item.get("selectedId")
                    if item.get("selectedId") == "-1"
                    {
                        selectedId = ""
                    }
                    let dic2 = ["Object":"", "vFieldName":item.get("vFieldName"), "eInputType":"Select","selectedId":selectedId, "Options":item["Options"] as! NSArray, "eRequired":item.get("eRequired"), "iDeliveryFieldId":item.get("iDeliveryFieldId")] as [String : Any]
                    self.fieldObjArray.remove(at: i)
                    self.fieldObjArray.insert(dic2, at: i)
                    
                }else if item["eInputType"] as! String == "Textarea"{
                    
                    if verified == ""{
                        let dic2 = ["Object":"","bottomView":"", "headerLbl":"","requiredLbl":item.get("requiredLbl"), "vFieldName":item.get("vFieldName"), "eInputType":"Textarea", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "eRequired":item.get("eRequired"), "text":(item["Object"] as! KMPlaceholderTextView).text] as [String : Any]
                        self.fieldObjArray.remove(at: i)
                        self.fieldObjArray.insert(dic2, at: i)
                    }
                    
                }else if item["eInputType"] as! String == "Address"{
                   
                    if verified == ""{
                        let dic2 = ["Object":"", "vFieldName": "Address", "eInputType":"Address", "lat":self.destLatitude, "long":self.destLongitude, "addr":self.address, "eRequired":item.get("eRequired")] as [String : Any]
                        self.fieldObjArray.remove(at: i)
                        self.fieldObjArray.insert(dic2, at: i)
                    }
                    
                }else{
                    if verified == ""{
                        if item["tempInput"] as! String == "Number" {
                            var dic2 = ["Object":"", "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "eRequired":item.get("eRequired"), "text": selectedPhoneCode + (item["Object"] as! MyTextField).text, "tempInput" : "Number" ,"textInputTemp" : (item["Object"] as! MyTextField).text] as [String : Any]
                            dic2["countryCode"] = self.selectedPhoneCode
                            dic2["countryImgurl"] = self.countryImageurl
                            print(dic2)
                            self.fieldObjArray.remove(at: i)
                            self.fieldObjArray.insert(dic2, at: i)
                        }else{
                        let dic2 = ["Object":"", "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iDeliveryFieldId":item.get("iDeliveryFieldId"), "eRequired":item.get("eRequired"), "text":(item["Object"] as! MyTextField).text] as [String : Any]
                        self.fieldObjArray.remove(at: i)
                        self.fieldObjArray.insert(dic2, at: i)
                        }
                    }
                }
                
            }
          
            
            if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.MULTI_DELIVERY_DETAIL_STORED) == true && ((GeneralFunctions.getValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED) as! Bool) == true && isFromEditForMulti == true))
            {
                let storedArray = (GeneralFunctions.getValue(key: Utils.DELIVERY_DETAIL_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                storedArray.replaceObject(at: self.selectedMultiIndex, with: self.fieldObjArray as AnyObject)
                GeneralFunctions.saveValue(key: Utils.DELIVERY_DETAIL_DATA, value: storedArray as AnyObject)
                
            }else if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.MULTI_DELIVERY_DETAIL_STORED) == true && ((GeneralFunctions.getValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED) as! Bool) == true && isFromEditForMulti == false))
            {
                let storedArray = (GeneralFunctions.getValue(key: Utils.DELIVERY_DETAIL_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                
                storedArray.add(self.fieldObjArray as AnyObject)
                GeneralFunctions.saveValue(key: Utils.DELIVERY_DETAIL_DATA, value: storedArray as AnyObject)
            }else
            {
                let storedArray = ([self.fieldObjArray as AnyObject] as NSArray).mutableCopy() as! NSMutableArray
                GeneralFunctions.saveValue(key: Utils.DELIVERY_DETAIL_DATA, value: storedArray as AnyObject)
            }
            
            GeneralFunctions.saveValue(key: Utils.MULTI_DELIVERY_DETAIL_STORED, value: true as AnyObject)
           
            performSegue(withIdentifier: "unwindDeliveryDetailsListScreen", sender: self)
            
            
        }else if(sender == self.resetBtn){
            
            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALL_DATA_CLEAR"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLEAR"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                
                if(btnClickedIndex == 0){
                    
                    for i in 0..<self.fieldObjArray.count{
                        
                        let item = self.fieldObjArray[i]
                        
                        if item["eInputType"] as! String == "Textarea"{
                            (item["Object"] as! KMPlaceholderTextView).text = ""
                        }else if item["eInputType"] as! String == "Address"{
                           
                            self.destLongitude = ""
                            self.destLatitude = ""
                            self.address = ""
                            let dic2 = ["Object": item["Object"] as Any, "vFieldName": "Address", "eInputType": "Address", "lat": "", "long": "", "addr": "", "eRequired": item["eRequired"] as Any] as [String : Any]
                            self.fieldObjArray.remove(at: i)
                            self.fieldObjArray.insert(dic2, at: i)
                            
                            (item["Object"] as! MyTextField).setText(text: "")
                            
                        }else{
                            if item["eInputType"] as! String == "Select"
                            {
                                let dic2 = ["Object": item["Object"] as Any, "vFieldName": item["vFieldName"] as Any, "eInputType":"Select","selectedId": "-1", "iDeliveryFieldId": item["iDeliveryFieldId"] as Any, "Options": item["Options"] as Any, "eRequired": item["eRequired"] as Any] as [String : Any]
                                self.fieldObjArray.remove(at: i)
                                self.fieldObjArray.insert(dic2, at: i)
                            }
                            (item["Object"] as! MyTextField).setText(text: "")
                        }
                        
                    }
                }
            })
            
        }
    }
    
    
    @IBAction func unwindToMultiDeliveryDetailsUV(_ segue:UIStoryboardSegue) {
           
           if(segue.source .isKind(of: CountryListUV.self)){
              
               
           }
       
       }
    
    func sendData() {
      
        self.countryPrefixImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: countryImageurl, width: Utils.getValueInPixel(value: 27), height: Utils.getValueInPixel(value: 27))), placeholderImage:nil)
        self.cuntryTxtFiled.setText(text: "+\(selectedPhoneCode)")
        self.cuntryTxtFiled.setText(text: "+\(selectedPhoneCode)")
        }
    
}
