

import UIKit
import SafariServices
import SysBaseLib

class UploadDocUV: ParentViewUV, MyBtnClickDelegate, MyLabelClickDelegate, ParentViewUVDelegate, FileUploadingDelegate,DTCalendarActionDelegate,MyTxtFieldClickDelegate {
    

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var docHLbl: MyLabel!
    @IBOutlet weak var lblExpTitle: MyLabel!
    @IBOutlet weak var lblExpDate: MyLabel!
    
    @IBOutlet weak var newMainVIew: UIView!
    @IBOutlet weak var viewExpirydateSelectionWidth: NSLayoutConstraint!
    @IBOutlet weak var viewExpirydateSelection: UIView!
    @IBOutlet weak var txtViewdisableUpdateDoc: UITextView!
    @IBOutlet weak var CalenderImgView: UIImageView!
    @IBOutlet weak var downImgView: UIImageView!
    @IBOutlet weak var expDateTxtField: MyLabel!
    @IBOutlet weak var takePhotoImgView: UIImageView!
    @IBOutlet weak var continueBtn: MyButton!
    @IBOutlet weak var docSelectedImgBgView: UIView!
    @IBOutlet weak var docSelectedCheckImgView: UIImageView!
    @IBOutlet weak var ExpiryView: UIView!
    
    @IBOutlet weak var expiryDateTxtHight: NSLayoutConstraint!
    @IBOutlet weak var editImgView: UIImageView!
    @IBOutlet weak var expiryTitleY: NSLayoutConstraint!
    @IBOutlet weak var ExpiryViewHeight: NSLayoutConstraint!  // Default 85  when Hide ExpiryDate = 00
    @IBOutlet weak var EditViewImage: UIView!
    @IBOutlet weak var editLbl: MyLabel!
    @IBOutlet weak var viewLbl: MyLabel!
    @IBOutlet weak var seprator: UIView!
    
    // new Outlets
    @IBOutlet weak var closeImgView: UIImageView!
    @IBOutlet weak var selectDocNewLbl: MyLabel!
    @IBOutlet weak var selectDocNoteLbl: MyLabel!
    @IBOutlet weak var docName: MyLabel!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var dottedImgView: UIImageView!
    @IBOutlet weak var expiryDateLbl: MyLabel!
    @IBOutlet weak var expiryDateTxtFiled: MyTextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var btnSubmitNew: MyButton!
    
    
    @IBOutlet weak var dottedImgHight: NSLayoutConstraint!
    var docUrl = ""
    let generalFunc = GeneralFunctions()
    
    let photoImgTapGue = UITapGestureRecognizer()
    
    var dataDict:NSDictionary!
    
   
    var publishRideUV:PublishRideUV!
    
    var DOC_TYPE = "driver"
    var iDriverVehicleId = ""
    
    var circlePrgressBar:CircleProgressView!
    var totalSizeUpladed:MyLabel!
    var overlayView:UIView!
    var selectionAreaView:UIView!
    var exeWebServerUrl:ApiHandler!
    var cencelUploadation = false
    var isOnlyView = false
    var passedDate = ""
    var documentName = ""
    var curentSelectedDate = Date()
    public var openImgSelection:OpenFileSelector!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
    }()
    
    fileprivate lazy var dateFormatterForAPI: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.openImgSelection = OpenFileSelector(uv: self)
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "UploadDocScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationItem.setHidesBackButton(true, animated: false)
            Configurations.setAppThemeNavBar()
            
        }else if(type == 2){
            self.editImgView.backgroundColor = SColors.Theme
            self.editImgView.image = UIImage(named: "ic_new_edit")?.addImagePadding(x: 11, y: 11)
            GeneralFunctions.setImgTintColor(imgView: self.editImgView, color: SColors.ThemeTxt)
            //headView.addShadowWithCornerRadius(cornerRadius: 5, .lightGray, 0.3, fillColor: .white)
            self.ExpiryView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
            self.expiryDateTxtFiled.addImageView(color: UIColor(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_new_calender",  22,22) { (imageView) in
            }
            self.expiryDateTxtFiled.setEnable(isEnabled: false)
            self.expiryDateTxtFiled.myTxtFieldDelegate = self
            self.editImgView.handleClick { instance in
                self.photoImgTapped()
            }
        }else if (type == 3) {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationItem.setHidesBackButton(false, animated: false)
        }
    }
    
    func setData(){
        if isOnlyView {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "View Document", key: "LBL_RIDE_SHARE_VIEW_DOCUMENT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "View Document", key: "LBL_RIDE_SHARE_VIEW_DOCUMENT")
            self.docHLbl.text = self.generalFunc.getLanguageLabel(origValue: "View Document", key: "LBL_RIDE_SHARE_VIEW_DOCUMENT")
            self.lblExpDate.textAlignment = .center
            self.lblExpTitle.textAlignment = .center
            self.selectDocNewLbl.text = self.generalFunc.getLanguageLabel(origValue: "View Document", key: "LBL_RIDE_SHARE_VIEW_DOCUMENT")
        }else if self.dataDict.get("doc_file") != "" {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Edit Document", key: "LBL_RIDE_SHARE_EDIT_DOCUMENT")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Edit Document", key: "LBL_RIDE_SHARE_EDIT_DOCUMENT")
            self.docHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select Document", key: "LBL_SELECT_DOC")
            self.selectDocNewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_EDIT_DOCUMENT")
        }
        else{
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Upload Document", key: "LBL_UPLOAD_DOC")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Upload Document", key: "LBL_UPLOAD_DOC")
        self.docHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select Document", key: "LBL_SELECT_DOC")
            self.selectDocNewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPLOAD_DOC")
        }
        self.selectDocNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "Please select the below document to continue.", key: "LBL_RIDE_SHARE_PLEASE_SELECT_THE_BELOW_DOCUMENT_TO_CONTINUE")
        self.lblExpTitle.text = self.generalFunc.getLanguageLabel(origValue: "Expiry Date", key: "LBL_EXPIRY_DATE")
        self.expiryDateLbl.text = self.generalFunc.getLanguageLabel(origValue: "Expiry Date", key: "LBL_EXPIRY_DATE")
        self.docName.text = self.documentName
        self.closeImgView.handleClick { instance in
            self.close()
        }
        self.expiryDateTxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "Select Date", key: "LBL_RIDE_SHARE_SELECT_DATE"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.dottedView.createDashedBorderForWholeView()
        })
        
        self.bottomView.layer.addShadow(opacity: 1, radius: 3.0, UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
        GeneralFunctions.setImgTintColor(imgView: CalenderImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: downImgView, color: SColors.grey_image_tint_color)
        self.dottedView.handleClick { instance in
            self.photoImgTapped()
        }
        if Configurations.isRTLMode() {
            self.txtViewdisableUpdateDoc.textAlignment = .right
        }else{
            self.txtViewdisableUpdateDoc.textAlignment = .left
        }
        if(self.dataDict.get("ex_status") == "yes"){
            if(self.dataDict.get("allow_date_change").uppercased() == "NO") {
                self.continueBtn.isBtnEnabled = false
                self.btnSubmitNew.isBtnEnabled = false
                self.btnSubmitNew.alpha = 0.5
                self.continueBtn.alpha = 0.5
                self.txtViewdisableUpdateDoc.isHidden = false
                self.txtViewdisableUpdateDoc.text = self.dataDict.get("doc_update_disable")
            }
            expDateTxtField.isHidden = false
            self.expDateTxtField.text = self.generalFunc.getLanguageLabel(origValue: "Select", key: "LBL_SELECT_TXT")
            if(self.dataDict.get("ex_date") != ""){
                //self.expiryTitleY.constant = -10
                self.passedDate = self.dataDict.get("ex_date")
                self.lblExpDate.text = Utils.convertDateToFormate(date: Utils.convertStringToDate(dateStr: self.dataDict.get("ex_date"), dateFormat: "yyyy-MM-dd"), formate: "dd MMM, yyyy")
                self.expiryDateTxtFiled.setText(text: Utils.convertDateToFormate(date: Utils.convertStringToDate(dateStr: self.dataDict.get("ex_date"), dateFormat: "yyyy-MM-dd"), formate: "dd MMM, yyyy"))
            }else {
                self.lblExpDate.text  = ""
            }
        }else{
            
            self.txtViewdisableUpdateDoc.isHidden = true
            ExpiryView.isHidden = true
            expiryDateTxtHight.constant = 0
            self.expiryDateLbl.text = ""
            self.expiryDateLbl.isHidden = true
            self.expiryDateTxtFiled.isHidden = true
            //ExpiryViewHeight.constant = 0
            
        }
        
        self.continueBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_SUBMIT_TXT"))
        self.continueBtn.clickDelegate = self
        self.btnSubmitNew.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_BUTTON_TXT"))
        self.btnSubmitNew.clickDelegate = self
        if isOnlyView {
            self.continueBtn.isHidden = true
            self.btnSubmitNew.isHidden = true
            self.viewExpirydateSelection.isHidden = true
            //self.viewExpirydateSelectionWidth.constant = 0
        }
        self.docHLbl.setClickDelegate(clickDelegate: self)
        docSelectedImgBgView.backgroundColor = SColors.ThemeTxt
        GeneralFunctions.setImgTintColor(imgView: docSelectedCheckImgView, color: SColors.Theme)
        
        docSelectedImgBgView.isHidden = true
        docSelectedCheckImgView.isHidden = true
         self.EditViewImage.backgroundColor = SColors.Theme
        
        viewLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW")
        editLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT")
        takePhotoImgView.handleClick { (Lbl) in
            self.photoImgTapped()
        }
        
        editLbl.handleClick { (Lbl) in
            self.photoImgTapped()
        }
        
        viewLbl.handleClick { (viewImg) in
            if let url = URL(string: self.dataDict.get("doc_file")) {
                    let svc = SFSafariViewController(url: url)
                    self.present(svc, animated: true, completion: nil)
            }
        }
        
        if(self.dataDict.get("doc_file") != ""){
            EditViewImage.isHidden = false
            self.dottedView.isHidden = true
            self.dottedImgView.contentMode = .scaleAspectFill
            self.dottedImgHight.constant = 195
            viewLbl.isHidden = false
            if isOnlyView {
                editLbl.isHidden = true
                seprator.isHidden = true
               
            }else{
                editLbl.isHidden = false
                seprator.isHidden = false
                //self.editImgView.isHidden = false
            }
            self.dottedImgView.handleClick { instance in
                if let url = URL(string: self.dataDict.get("doc_file")) {
                        let svc = SFSafariViewController(url: url)
                        self.present(svc, animated: true, completion: nil)
                }
            }
            if self.dataDict.get("is_doc") == "Yes"{
                self.dottedImgView.image = UIImage.init(named:"ic_doc_new")
                if isOnlyView {
                    self.editImgView.isHidden = true
                }else{
                    self.editImgView.isHidden = false
                }
            }else{
               
                self.dottedImgView.sd_setShowActivityIndicatorView(true)
                self.dottedImgView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)

                self.dottedImgView.sd_setImage(with: URL(string: self.dataDict.get("doc_file") ), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in

                   
                    if self.isOnlyView {
                        self.editImgView.isHidden = true
                    }else{
                        self.editImgView.isHidden = false
                    }
                    
                    
                })
            }
            self.docSelectedImgBgView.isHidden = false
            self.docSelectedCheckImgView.isHidden = false
            self.takePhotoImgView.image = UIImage(named: "ic_card")
            self.takePhotoImgView.alpha = 0.5
        }
        
        ExpiryView.handleClick { (view) in
            let minDate = Calendar(identifier: Configurations.getCalendarIdentifire()).date(byAdding: .hour, value: 1, to: Date())
                DatePickerDialog().show(self.generalFunc.getLanguageLabel(origValue: "Expiry Date", key: "LBL_EXPIRY_DATE"), doneButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TXT"), cancelButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), minimumDate: minDate, datePickerMode: .date) {
                    (date) -> Void in
                    if(date != nil){
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_GB")
                        
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        self.passedDate = dateFormatter.string(from: date!)
                        dateFormatter.dateFormat = "dd MMM, yyyy"
                        let dateString = dateFormatter.string(from: date!)
                        //self.expiryTitleY.constant = -10
                        self.lblExpDate.text = dateString
                        //self.expiryDateTxtFiled.setText(text: <#T##String#>)
                    }
            }
        }
    }
    
    func myLableTapped(sender: MyLabel) {
        if(sender == self.docHLbl){
            photoImgTapped()
        }
    }
    
    @objc func photoImgTapped(){
        

        if !isOnlyView {
        self.openImgSelection.show(type: .DocumentFileType) { (isImageUpload) in
            if(isImageUpload == true){
                
                self.openImgSelection.closeSlectionView()
               
                if(self.openImgSelection.selectedFileData != nil){
                    self.docSelectedImgBgView.isHidden = false
                    self.docSelectedCheckImgView.isHidden = false
                    self.takePhotoImgView.alpha = 0.5
                    self.editImgView.isHidden = false
                    self.editLbl.isHidden = false
                    if self.openImgSelection.isDoc {
                        self.dottedImgView.image = UIImage.init(named: "ic_doc_new")
                    }else{
                        self.dottedImgView.image = self.openImgSelection.pickedImage
                    }
                    self.dottedImgView.contentMode = .scaleAspectFill
                    self.dottedImgHight.constant = 195
                    self.dottedView.isHidden = true
                    self.dottedImgView.handleClick { instance in
                        //if let url = URL(self.openImgSelection.pickedImageUrl) {
                            //UIApplication.shared.open(self.openImgSelection.pickedImageUrl)
                        //}
                    }
                    
                }
            }
        }
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.btnSubmitNew){
            
            if(self.dataDict.get("ex_status") == "yes"){
                
                if(expiryDateTxtFiled.text.trimmingCharacters(in: .whitespaces) == ""){
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Expiry date is required.", key: "LBL_EXP_DATE_REQUIRED"), uv: self)
                    return
                }
            }
            
            if(self.dataDict.get("doc_file") == "" && (self.openImgSelection == nil || self.openImgSelection.selectedFileData == nil)){
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please attach your document.", key: "LBL_SELECT_DOC_ERROR"), uv: self)
                return
            }

            let parameters = [
                "type"  : "PublishRideUploadDocuments",
                "MemberType"    : Utils.appUserType,
                "iMemberId"    : GeneralFunctions.getMemberd(),
                "doc_masterid": "\(self.dataDict.get("doc_masterid"))",
                "doc_id": "\(self.dataDict.get("doc_id"))",
                "ex_date": self.dataDict.get("ex_status") == "yes" ? self.passedDate : ""
                
            ]
            print(parameters)
            if(self.openImgSelection == nil){
                
                self.openImgSelection.selectedFileData = (UIImage(named: "ic_trans")!).jpegData(compressionQuality: 1.0)
                
            }
          
            
        
            
            self.myDocUploadRequest(fileData: (self.openImgSelection.selectedFileData == nil ? self.dataDict.get("doc_file").data(using: .utf8) : self.openImgSelection.selectedFileData)!, fileName: self.openImgSelection.fileName as String == "" ? self.dataDict.get("doc_file") as String : self.openImgSelection.fileName as String, dict_data: parameters as NSDictionary)
            
        }
    }
    
    func myDocUploadRequest(fileData:Data, fileName:String, dict_data:NSDictionary){
        let myUrl = URL(string: CommonUtils.webservice_path)
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST"
        
        Utils.printLog(msgData: "SelectedFileName::\(fileName)")
        
        let exeWebServerUrl = ApiHandler(dict_data: dict_data as! [String : String], currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.fileUploadingSize = self
        self.exeWebServerUrl = exeWebServerUrl
        showProgressView()
        exeWebServerUrl.uploadImage(fileData: fileData, fileName: fileName) { (response) -> Void in
            
            if(self.overlayView != nil && self.selectionAreaView != nil){
                self.overlayView!.removeFromSuperview()
                self.selectionAreaView.removeFromSuperview()
            }
       
            if(response != ""){
                Utils.printLog(msgData: "responseUploadDOc:\(response)")
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your document is uploaded successfully", key: "LBL_UPLOAD_DOC_SUCCESS"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                       
                        if self.publishRideUV != nil {
                            self.publishRideUV.getDoc()
                            self.close()
                        }
                        
                    })
                    
                    
                }else if dataDict.get("message") == "" {
                    
                    self.generalFunc.setError(uv: self)
                }
                else{
                   
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                
            }
        }
    }
    
    func totalFileSize(Uploaded: Float) {
        if  circlePrgressBar != nil && totalSizeUpladed != nil {
            circlePrgressBar.progress = Double(Uploaded)
            totalSizeUpladed.text = "\(Int(Uploaded * 100))%"
        }
    }

    func showProgressView(){
       // if(isChooseCategory == true){
            let chooseDocumentOptionView = self.generalFunc.loadView(nibName: "ChooseDocumentOptionView")
            let titleView:MyLabel  = chooseDocumentOptionView.viewWithTag(10) as! MyLabel
            titleView.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_CATEGORY")
            
            chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 170 - GeneralFunctions.getSafeAreaInsets().bottom, width: Application.screenSize.width, height: 200 + GeneralFunctions.getSafeAreaInsets().bottom)
            chooseDocumentOptionView.cornerRadius = 10
            chooseDocumentOptionView.masksToBounds = true
            
            let overlayView = UIView()
            overlayView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
            
            overlayView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
            overlayView.backgroundColor = UIColor.black
            overlayView.alpha = 0.4
            self.overlayView = overlayView
            self.selectionAreaView = chooseDocumentOptionView
            chooseDocumentOptionView.layer.shadowOpacity = 0.5
            chooseDocumentOptionView.layer.shadowOffset = CGSize(width: 0, height: 3)
            chooseDocumentOptionView.layer.shadowColor = UIColor.black.cgColor
       
            if(self.navigationController != nil){
                UIView.transition(with: self.navigationController?.view ?? self.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.navigationController?.view.addSubview(overlayView)
                    self.navigationController?.view.addSubview(chooseDocumentOptionView)
                    self.navigationController?.navigationBar.layer.zPosition = -1
                }, completion: nil)
                
            }else{
                
                UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.view.addSubview(overlayView)
                    self.view.addSubview(chooseDocumentOptionView)
                }, completion: nil)
                
            }
            
            let topView:UIView = chooseDocumentOptionView.viewWithTag(500) as! UIView
            topView.isHidden = false
            circlePrgressBar = chooseDocumentOptionView.viewWithTag(501) as! CircleProgressView
            circlePrgressBar.trackFillColor = SColors.Theme
            
            totalSizeUpladed = chooseDocumentOptionView.viewWithTag(502) as? MyLabel
            self.totalSizeUpladed.text = ""
            
            let titleLabel = chooseDocumentOptionView.viewWithTag(503) as! MyLabel
            titleLabel.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PLEASE_WAIT")
            let SubTitleLabel = chooseDocumentOptionView.viewWithTag(504) as! MyLabel
        
             SubTitleLabel.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DOCUMET_UPLOADING")
            
            let closeImg = chooseDocumentOptionView.viewWithTag(15) as! UIImageView
            
            closeImg.isHidden = true
            closeImg.handleClick { (close) in
                
                if(self.circlePrgressBar.progress < 1){
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SURE_CANCEL_UPLOAD"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_OK"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0 {
                            
                            if (self.exeWebServerUrl != nil && self.circlePrgressBar.progress < 1) {
                                self.cencelUploadation = true
                                self.exeWebServerUrl.cancel()
                            }
                        }
                        
                    })
                }
                
            }
        //}
    }
    
    func openCalender()  {
        
      
        
        let cView = OpenCalendarView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
        cView.cLocale = "en"
        cView.dtCalendarActionDelegate = self
        cView.startDate = Date()
        var dayComponent    = DateComponents()
        dayComponent.year    = 25
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
       
        cView.endDate = nextDate
        cView.allowsMultipleSelection = false
        cView.selDate = self.curentSelectedDate
        cView.themeColor = SColors.Theme
        cView.dotColor = SColors.Theme
        cView.setUpView()
        
        Application.window!.addSubview(cView)
    }
    func cancelTapped() {
        
    }
    
    func okTapped(selectedDate: Date?, selectedDates: [Date]?) {
        
        
        self.passedDate = self.dateFormatterForAPI.string(from: selectedDate!)
        self.curentSelectedDate = selectedDate!
      
        self.expiryDateTxtFiled.setText(text: self.dateFormatter.string(from: selectedDate!))
        
    }
    func myTxtFieldTapped(sender: MyTextField) {
        
        
        if sender == expiryDateTxtFiled{
            if !isOnlyView {
                self.openCalender()
            }
        }
       
    }
}
