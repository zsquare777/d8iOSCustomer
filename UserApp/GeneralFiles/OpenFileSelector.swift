

import UIKit
import AVFoundation
import MobileCoreServices
import Photos
import CropViewController
import SysBaseLib
var videoURL: URL?
var thumb: UIImage?
var image: UIImage?

protocol FileUploadingDelegate {
    func totalFileSize(Uploaded:Float)
}

enum FileType: Int {
    case ImageFileType = 0
    case CroppedImageFileType = 1
    case VideoFileType = 2
    case DocumentFileType = 3
}

struct FilePickOption{
    
    var isCameraOption = true
    var isGalleryOption = true
    var isDocumentOption = true
}

class OpenFileSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate, MyBtnClickDelegate, FileUploadingDelegate, UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate {
    
    
    typealias FileSelectCompletionHandler = (_ isImageUpload:Bool) -> Void
    
    
    var uv:ParentViewUV!
    
    let generalFunc = GeneralFunctions()
    
    var overlayView:UIView!
    var selectionAreaView:UIView!
    
    var loadingDialog:NBMaterialLoadingDialog!
    
    var fileSelectCompletionHandler:FileSelectCompletionHandler!


    var cameraTapGue = UITapGestureRecognizer()
    var gallaryTapGue = UITapGestureRecognizer()
    var docPickerTapGue = UITapGestureRecognizer()
    var closeTapGue = UITapGestureRecognizer()
    
    var circlePrgressBar:CircleProgressView!
    var totalSizeUpladed:MyLabel!
    
    var dict_data: [String: String]!
    var selectedFileData:Data!
    
    var fileData:String!
    var fileName = NSString()
    var fileExtension:String!
    
    var fileType = FileType(rawValue: 0)
    var filePickOption:FilePickOption!
    var isFromStepPhotos = false
    var selectedVideoData:Data!
    var pickedImage: UIImage!
    var pickedImageUrl: URL!
    var isVideo = false
    var isDoc = false
    init(uv: ParentViewUV) {
        self.uv = uv
        super.init()
    }
    
    init(uv: ParentViewUV, dict_data: [String: String]) {
        self.uv = uv
        self.dict_data = dict_data
        super.init()
    }
    
    func setDataParams(dict_data: [String: String]){
        self.dict_data = dict_data
    }
    
    func setImageSelectionHandler(fileSelectCompletionHandler:@escaping FileSelectCompletionHandler){
        self.fileSelectCompletionHandler = fileSelectCompletionHandler
    }
    
    func show(type:FileType, _ filePickOption:FilePickOption = FilePickOption(), fileSelectCompletionHandler:@escaping FileSelectCompletionHandler){
        
        
        self.filePickOption = filePickOption
        self.fileType = type
        self.fileSelectCompletionHandler = fileSelectCompletionHandler
        
        self.execCode()
    }
    
    private func execCode(){
        let chooseDocumentOptionView = self.generalFunc.loadView(nibName: "ChooseDocumentOptionView")
        chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 220, width: Application.screenSize.width, height: 260)
        
        let titleView:MyLabel  = chooseDocumentOptionView.viewWithTag(10) as! MyLabel
        titleView.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_CATEGORY")
        titleView.isHidden = true
        chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 295, width: Application.screenSize.width, height: 360)
        
        chooseDocumentOptionView.cornerRadius = 0
        chooseDocumentOptionView.masksToBounds = true
        
        let overlayView = UIView()
        overlayView.frame = CGRect(x:0, y: 0, width: self.uv.view.frame.width, height: Application.screenSize.height)
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.4
        self.overlayView = overlayView
        
        chooseDocumentOptionView.layer.shadowOpacity = 0.5
        chooseDocumentOptionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        chooseDocumentOptionView.layer.shadowColor = UIColor.black.cgColor
        
        self.selectionAreaView = chooseDocumentOptionView
        let currentWindow = Application.window
        if(self.uv == nil){
            currentWindow?.addSubview(overlayView)
            currentWindow?.addSubview(chooseDocumentOptionView)
        }else if(self.uv.navigationController != nil){
            self.uv.navigationController?.view.addSubview(overlayView)
            self.uv.navigationController?.view.addSubview(chooseDocumentOptionView)
        }else{
            self.uv.view.addSubview(overlayView)
            self.uv.view.addSubview(chooseDocumentOptionView)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            overlayView.alpha = 0.4
            chooseDocumentOptionView.alpha = 1
        })
        
        let topView = chooseDocumentOptionView.viewWithTag(1000)!
        topView.isHidden = false
        
        Utils.delayWithSeconds(0.1) {
            topView.roundTo(corners: [.topRight ,.topLeft], radius: 10)
        }
        
        topView.masksToBounds = true
        let cancelImageView = chooseDocumentOptionView.viewWithTag(368) as! UIImageView
        cancelImageView.image = cancelImageView.image?.addImagePadding(x: 15, y: 15)
        cancelImageView.handleClick { instance in
            self.closeSlectionView()
        }
        cancelImageView.isHidden = true
        let stackView = chooseDocumentOptionView.viewWithTag(16) as! UIStackView
        
        let lCamera = chooseDocumentOptionView.viewWithTag(111) as! MyLabel
        lCamera.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CAMERA")
        
        let lGallery = chooseDocumentOptionView.viewWithTag(222) as! MyLabel
        lGallery.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GALLERY")
        
        let lDocument = chooseDocumentOptionView.viewWithTag(333) as! MyLabel
        lDocument.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DOCUMET")
        
        cameraTapGue.addTarget(self, action: #selector(self.cameraTapped))
        let CameraView:UIView = chooseDocumentOptionView.viewWithTag(100)!
        CameraView.isUserInteractionEnabled = true
        CameraView.addGestureRecognizer(cameraTapGue)
        
        gallaryTapGue.addTarget(self, action: #selector(self.gallaryTapped))
        
        let galleryView:UIView = chooseDocumentOptionView.viewWithTag(200)!
        galleryView.isUserInteractionEnabled = true
        galleryView.addGestureRecognizer(gallaryTapGue)
        
        docPickerTapGue.addTarget(self, action: #selector(self.docPickerTapped))
        let docView:UIView = chooseDocumentOptionView.viewWithTag(300)!
        docView.isUserInteractionEnabled = true
        docView.addGestureRecognizer(docPickerTapGue)
        
        if(fileType != .DocumentFileType){
            docView.isHidden = true
        }
        
        if(self.filePickOption.isCameraOption != true){
            CameraView.isHidden = true
        }
        
        if(self.filePickOption.isGalleryOption != true){
            galleryView.isHidden = true
        }
        
        if(self.filePickOption.isDocumentOption != true){
            docView.isHidden = true
        }
        
        
        //if self.uv.isKind(of: EditProfileUV.self){
        //chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 220, width: Application.screenSize.width, height: 260)
        if let myConstraint = stackView.constraintWith(identifier: "StackHeight"){
            myConstraint.constant = 120
            chooseDocumentOptionView.setNeedsLayout()
            chooseDocumentOptionView.layoutSubviews()
        }
        //}
        
        if  Application.screenSize.width <= 320 {
            chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 220, width: Application.screenSize.width, height: 260)
            if let myConstraint = stackView.constraintWith(identifier: "StackHeight"){
                myConstraint.constant = 80
                if self.uv.isKind(of: EditProfileUV.self){
                    chooseDocumentOptionView.frame = CGRect(x:0, y: Application.screenSize.height - 220, width: Application.screenSize.width, height: 260)
                    myConstraint.constant = 100
                }
                chooseDocumentOptionView.setNeedsLayout()
                chooseDocumentOptionView.layoutSubviews()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            CameraView.addShadowWithCornerRadius(cornerRadius: 10, .lightGray, fillColor: .white)
            galleryView.addShadowWithCornerRadius(cornerRadius: 10, .lightGray, fillColor: .white)
            docView.addShadowWithCornerRadius(cornerRadius: 10, .lightGray, fillColor: .white)
        }
        let cancelBtn:MyButton = chooseDocumentOptionView.viewWithTag(400) as! MyButton
        cancelBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"))
        cancelBtn.isUserInteractionEnabled = true
        let cameraImgView = chooseDocumentOptionView.viewWithTag(678) as! UIImageView
        let GalleyImgView = chooseDocumentOptionView.viewWithTag(679) as! UIImageView
        let docImgView = chooseDocumentOptionView.viewWithTag(680) as! UIImageView
        GeneralFunctions.setImgTintColor(imgView: cameraImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: GalleyImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: docImgView, color: SColors.Theme)
        cancelBtn.clickDelegate = self
        cancelBtn.handleClick { (btn) in
            self.closeSlectionView()
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        if(self.overlayView == nil || self.selectionAreaView == nil){
            return
        }
        self.overlayView!.removeFromSuperview()
        self.selectionAreaView!.removeFromSuperview()
    }
    
    @objc func closeSlectionView(){
        if(self.overlayView == nil || self.selectionAreaView == nil){
            return
        }
        
       
        self.overlayView!.removeFromSuperview()
        self.selectionAreaView!.removeFromSuperview()
    }
    
    @objc func cameraTapped(){
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized, .notDetermined: callCamera() // Do your stuff here i.e. callCameraMethod()
        case .denied: alertToEncourageCameraAccessInitially(message: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CAMERA_REQUIRE_TXT"))
        default: alertToEncourageCameraAccessInitially(message: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CAMERA_REQUIRE_TXT"))
        }
    }
    
    func alertToEncourageCameraAccessInitially(message:String) {
        let alert = UIAlertController(
            title: self.generalFunc.getLanguageLabel(origValue: "", key: "IMPORTANT"),
            message: message , //"Camera access required for capturing photos!",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALLOW_CAMERA_TXT"), style: .cancel, handler: { (alert) -> Void in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
        }))
        
        self.uv.present(alert, animated: true, completion: nil)
    }
    
    func callCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            if self.isFromStepPhotos {
                imagePickerController.mediaTypes = ["public.movie","public.image"]
            }else{
            if(fileType == .VideoFileType){
                imagePickerController.mediaTypes = ["public.movie"]
            }else{
                imagePickerController.mediaTypes = [ "public.image"]
            }
            }
           
            Configurations.setDefaultNavBar()
            self.uv.present(imagePickerController, animated: true, completion: nil)
        }else{
            generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_SUPPORT_CAMERA_TXT"))
        }
    }
    
    @objc func gallaryTapped(){
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            if self.isFromStepPhotos {
                imagePickerController.mediaTypes = ["public.movie","public.image"]
            }
            Configurations.setDefaultNavBar()
           
            self.uv.present(imagePickerController, animated: true, completion: nil)
        }else{
            generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_SUPPORT_GALLARY_TXT"))
        }
    }
    
    
    @objc func docPickerTapped(){
        //        let types: [String] = [(kUTTypeCompositeContent as String), (kUTTypeImage as String), (kUTTypeJPEG as String), (kUTTypePNG as String), (kUTTypePDF as String)]
        //        let documentMenuVC = UIDocumentMenuViewController(documentTypes: types, in: .import)
        let documentMenuVC = UIDocumentPickerViewController(documentTypes: [(kUTTypeCompositeContent as String), (kUTTypeImage as String), (kUTTypeText as String), (kUTTypePlainText as String), (kUTTypeRTF as String)], in: .import)
        documentMenuVC.delegate = self
        documentMenuVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        documentMenuVC.setnavBarTintColor(color: SColors.Theme)
        Configurations.setDefaultNavBar()
        
        self.uv.present(documentMenuVC, animated: true, completion: nil)
    }
    
    //MARK - DocumentPickerView Delegate & Datasource Methods
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.uv
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
    }
    
    func requestUploadDocument(data:Data){
        self.selectedFileData = data
        closeSlectionView()
    }
    
    func documentInteractionController(_ controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        Utils.printLog(msgData: "WillBeginSendingToApplication")
    }
    
    func documentInteractionController(_ controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        Utils.printLog(msgData: "We're done sending the document.")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        Configurations.setAppThemeNavBar()
        self.isDoc = true
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            DispatchQueue.main.async {
                
                print(urls)
                self.fileName = ""
                self.fileName = (urls[0].lastPathComponent as NSString)
                
                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                
                let tsite_upload_docs_file_extensions = userProfileJson.get("tsite_upload_docs_file_extensions").trim().components(separatedBy: ",")
                
                print(tsite_upload_docs_file_extensions)
                
                let fileExtension = self.fileName.pathExtension
                
                if(!tsite_upload_docs_file_extensions.contains(fileExtension)){
                    self.closeSlectionView()
                    self.fileName = ""
                    self.generalFunc.setAlertMessage(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_WRONG_FILE_SELECTED_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    })
                }else{
                    let dataTake = NSData(contentsOf: urls[0]) as Data?
                    
                    Utils.printLog(msgData: "DataTake::\(String(describing: dataTake))")
                    self.selectedFileData = dataTake
                    if(self.fileSelectCompletionHandler != nil){
                        self.fileSelectCompletionHandler(true)
                    }
                    self.requestUploadDocument(data: dataTake!)
                }
            }
        }
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        Configurations.setAppThemeNavBar()
        controller.dismiss(animated: true, completion: nil)
    }
    
    func totalFileSize(Uploaded: Float) {
        if  circlePrgressBar != nil && totalSizeUpladed != nil {
            circlePrgressBar.progress = Double(Uploaded)
            totalSizeUpladed.text = "\(Int(Uploaded * 100))%"
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        Configurations.setAppThemeNavBar()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        Configurations.setAppThemeNavBar()
        // The info dictionary contains multiple representations of the image, and this uses the original.
        self.isDoc = false
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        if isFromStepPhotos {
            if mediaType == "public.movie" {
                if(self.fileSelectCompletionHandler != nil){
                    videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                    if let videoData = NSData(contentsOf: (videoURL ??  URL(string: "google.com"))!) {
                        print(videoData.length)
                        self.selectedVideoData = videoData as Data
                        self.selectedFileData = videoData as Data
                        self.isVideo = true
                        
                        self.fileSelectCompletionHandler(true)
                    }
                }
                picker.dismiss(animated: true, completion: {
                    self.closeSlectionView()
                    return
                })
            }else{
                
            }
        }
        
        if mediaType != "public.movie" {
            
            var selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            selectedImage = selectedImage.getNormalizeImage()
            
            
            if picker.sourceType == UIImagePickerController.SourceType.camera {
                self.fileName = String(format:"doc_img.png") as NSString
            }else {
                
                var selectedFileName = ""
                if #available(iOS 11.0, *) {
                    if let imageUrl = info[.imageURL] as? URL {
                        pickedImageUrl = imageUrl
                        selectedFileName = imageUrl.lastPathComponent
                    }
                } else {
                    if let imageURL = info[.referenceURL] as? URL {
                        pickedImageUrl = imageURL
                        let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                        if let firstObject = result.firstObject {
                            let assetResources = PHAssetResource.assetResources(for: firstObject)
                            selectedFileName = assetResources.first?.originalFilename ?? ""
                        }
                    }
                }
                
                self.fileName = selectedFileName as NSString
            }
            
            print("imgExtension: \(self.fileName)")
            pickedImage = selectedImage
             
//            if(selectedImage.size.width < Utils.ImageUpload_MINIMUM_WIDTH || selectedImage.size.height < Utils.ImageUpload_MINIMUM_HEIGHT){
//                self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MIN_RES_IMAGE"))
//                return
//            }
            
            
            picker.dismiss(animated: true, completion: {
                
                
                if(self.fileType == .ImageFileType){
                    self.isVideo = false
                    self.selectedFileData = selectedImage.jpegData(compressionQuality: 1.0)!
                    self.fileSelectCompletionHandler(true)
                }else if(self.fileType == .CroppedImageFileType){
                    
                    if(selectedImage.size.width < Utils.ImageUpload_MINIMUM_WIDTH || selectedImage.size.height < Utils.ImageUpload_MINIMUM_HEIGHT){
                        self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MIN_RES_IMAGE"))
                        return
                    }
                   
                    
                    DispatchQueue.main.async() {
                        let cropViewController = CropViewController(image: selectedImage)
                        cropViewController.delegate = self
                        cropViewController.customAspectRatio = CGSize(width: 1024, height: 1024)
                        
                        cropViewController.aspectRatioLockEnabled = true
                        cropViewController.aspectRatioPickerButtonHidden = true
                        cropViewController.resetAspectRatioEnabled = false
                        cropViewController.showActivitySheetOnDone = false
                        
                        cropViewController.cancelButtonTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                        cropViewController.doneButtonTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DONE")
                        self.uv.present(cropViewController, animated: true, completion: nil)
                    }
                }else if(self.fileType == .DocumentFileType){
                    if(self.fileSelectCompletionHandler != nil){
                        self.selectedFileData = selectedImage.jpegData(compressionQuality: 1.0)!
                        self.fileSelectCompletionHandler(true)
                    }
                    
                    DispatchQueue.main.async() {
                        self.requestUploadDocument(data: selectedImage.jpegData(compressionQuality: 1.0)!)
                    }
                }
                
            })
        }else{
            if(fileType == .VideoFileType){
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                if(self.fileSelectCompletionHandler != nil){
                    
                    if let videoData = NSData(contentsOf: (videoURL ??  URL(string: "google.com"))!) {
                        print(videoData.length)
                        self.selectedVideoData = videoData as Data
                        self.isVideo = true
                        
                        self.fileSelectCompletionHandler(true)
                    }
                }
                picker.dismiss(animated: true, completion: {
                    self.closeSlectionView()
                    return
                })
            }
            
        }
        
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        cropViewController.dismiss(animated: true, completion: {
            DispatchQueue.main.async() {
                if(image.size.width < Utils.ImageUpload_MINIMUM_WIDTH || image.size.height < Utils.ImageUpload_MINIMUM_HEIGHT){
                    self.generalFunc.setError(uv: self.uv, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MIN_RES_IMAGE"))
                    return
                }else{
                    
                    self.selectedFileData = image.getNormalizeImage().cropTo(size: CGSize(width: Utils.ImageUpload_DESIREDWIDTH, height: Utils.ImageUpload_DESIREDHEIGHT)).jpegData(compressionQuality: 1.0)!
                    self.fileSelectCompletionHandler(true)
                    //self.requestUploadImage(image: )
                }
            }
        })
    }
    
    func requestUploadImage(image:UIImage){
        
        //  myImageUploadRequest(image: image)
    }
    
}

extension Data {
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xff:
            ext = ".jpeg"
            break
        case 0x25:
            ext = ".pdf"
            break
        case 0x46:
            ext = ".txt"
            break
        case 0x47:
            ext = ".gif"
            break
        case 0x89:
            ext = ".png"
            break
        case 0x49, 0x4d:
            ext = ".tiff"
            break
        default:
            ext = ".doc"
        }
        return ext
    }
}
