

import UIKit
import SysBaseLib

class AgeVerificationUV: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageHLbl: MyLabel!
    @IBOutlet weak var hintLbl: MyLabel!
    @IBOutlet weak var takePhotoImgView: UIImageView!
    @IBOutlet weak var continueBtn: MyButton!
    @IBOutlet weak var selectedImgBgView: UIView!
    @IBOutlet weak var selectedCheckImgView: UIImageView!
    @IBOutlet weak var proofNoteLbl: MyLabel!
    
    
    var isTripEnd = false
    
    // DeliverAll Settings
    var isFromDeliverAllCheckout = false
    var displayCardPayment = true
    var isPreferences = true
    var disableCashPayValue = ""
    
    let generalFunc = GeneralFunctions()

    let photoImgTapGue = UITapGestureRecognizer()
    let photoImgTapGueForPluseBtn = UITapGestureRecognizer()
    var isImageSelected = false
    
    var selectedFileData:Data!
    
    var noteText = ""
    var selectedFileName = ""
    var imgId = ""

    public var openImgSelection:OpenFileSelector!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.openImgSelection = OpenFileSelector(uv: self)
            
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "AgeVerificationScreenDesign", uv: self, contentView: contentView))
            
            self.addBack()
            
           // self.selectedImgBgView.isHidden = true
           // self.selectedCheckImgView.isHidden = true
            
            //GeneralFunctions.setImgTintColor(imgView: selectedCheckImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: selectedCheckImgView, color: SColors.ThemeTxt)
            self.selectedImgBgView.backgroundColor = SColors.Theme
            
            setData()
            
        }
    }
    

    override func close() {
      
        super.close()
    }
    
    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_IDENTIFICATION")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_IDENTIFICATION")
        
        self.pageHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ID_IMAGE")
        
        self.continueBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_NEXT_TXT"))
        
    
        self.hintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTE")
        self.proofNoteLbl.fit()
        self.proofNoteLbl.text = self.noteText
        
        photoImgTapGue.addTarget(self, action: #selector(self.photoImgTapped))
        takePhotoImgView.isUserInteractionEnabled = true
        takePhotoImgView.addGestureRecognizer(photoImgTapGue)
        
        photoImgTapGueForPluseBtn.addTarget(self, action: #selector(self.photoImgTapped))
        selectedCheckImgView.isUserInteractionEnabled = true
        selectedCheckImgView.addGestureRecognizer(photoImgTapGueForPluseBtn)
        
        self.continueBtn.clickDelegate = self
       
        
    }
    
    @objc func photoImgTapped(){
        
       
        self.openImgSelection.show(type: .ImageFileType) { (isImageUpload) in
            if(isImageUpload == true){
                
                self.openImgSelection.closeSlectionView()
                if(self.openImgSelection.selectedFileData != nil){
                    self.isImageSelected = true
                    self.selectedFileData = self.openImgSelection.selectedFileData
                    self.selectedImgBgView.isHidden = false
                    self.selectedFileName = self.openImgSelection.fileName as String
                    self.selectedCheckImgView.isHidden = false
                    self.takePhotoImgView.image = UIImage(data: self.selectedFileData) //self.selectedImage//UIImage(named: "ic_cam")
                    self.selectedCheckImgView.image = UIImage(named: "ic_edit")
                    self.selectedImgBgView.isHidden = true
                    self.selectedCheckImgView.isHidden = true
                }
            }
        }

    }
    
    func proofImageUpload(){
        
        if(self.selectedFileData != nil){
            let parameters = [
                "type"  : "UploadIdProof",
                "MemberType"    : Utils.appUserType,
                "iUserId"    : GeneralFunctions.getMemberd(),
                "vImage":self.selectedFileName,
                "eSystem" : "DeliverAll"
            
            ]
            
            print(parameters)
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
            exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
            exeWebServerUrl.currInstance = exeWebServerUrl
            
            exeWebServerUrl.uploadImage(fileData: self.selectedFileData, fileName: self.selectedFileName, completionHandler: { (response) -> Void in
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                       
                        self.processNext(iIdProofImageId:dataDict.get("iIdProofImageId"))
                        
                    }else if(dataDict.get(Utils.message_str) == "DO_RESTART"){
                        
                        let window = Application.window
                        
                        let getUserData = GetUserData(uv: self, window: window!)
                        getUserData.getdata()
                    }else if (dataDict.get(Utils.message_str) == ""){
                        self.generalFunc.setError(uv: self)
                    }
                    else{
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "OK", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClicked) in
                            if(dataDict.get("DO_RESTART").uppercased() == "YES"){
                                let window = Application.window
                                
                                let getUserData = GetUserData(uv: self, window: window!)
                                getUserData.getdata()
                            }
                        })
                        // self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                }else{
                    self.generalFunc.setError(uv: self)
                }
            })
            
        }else{

             self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_IMAGE_ERROR"))

        }
       
    }
    
  
    
    func processNext(iIdProofImageId:String){
//        let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//        selectPaymentProfileUV.isFromDeliverAllCheckout = true
//        selectPaymentProfileUV.displayCardPayment = self.displayCardPayment
//        selectPaymentProfileUV.isPreferences = isPreferences
//        selectPaymentProfileUV.disableCashPayValue = self.disableCashPayValue
//        selectPaymentProfileUV.iIdProofImageId = iIdProofImageId
//        self.push(uv: selectPaymentProfileUV)
        self.imgId = iIdProofImageId
        self.performSegue(withIdentifier: "unwindToCheckOut", sender: self)
    }
    
    func myBtnTapped(sender: MyButton) {
        if(sender == self.continueBtn){
            self.proofImageUpload()
            
        }
    }
    
}
