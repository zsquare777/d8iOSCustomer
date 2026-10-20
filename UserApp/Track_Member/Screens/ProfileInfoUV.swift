//
//  ProfileInfoUV.swift
//  UserApp
//
//  Created by Apple on 28/11/22.
//

import UIKit
import SysBaseLib

class ProfileInfoUV: ParentViewUV, ParentViewUVDelegate {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profilePicAreaViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profilePicViewArea: UIView!
    @IBOutlet weak var editPicAreaView: UIView!
    
    @IBOutlet weak var editIconImgView: UIImageView!
    @IBOutlet weak var userProfilePicBgView: UIView!
    @IBOutlet weak var userProfilePicBgImgView: UIImageView!
    @IBOutlet weak var usrProfileImgView: UIImageView!
   
    @IBOutlet weak var inviteCodeVLbl: MyLabel!
    @IBOutlet weak var invitecodeHLbl: MyLabel!
    @IBOutlet weak var phoneNumberVLbl: MyLabel!
    @IBOutlet weak var phoneNumberHLbl: MyLabel!
    @IBOutlet weak var nameVLbl: MyLabel!
    @IBOutlet weak var nameHLbl: MyLabel!
    @IBOutlet weak var userLocationHLbl: MyLabel!
    @IBOutlet weak var userLocationVLbl: MyLabel!
    @IBOutlet weak var vehicleModelHLbl: MyLabel!
    @IBOutlet weak var vehicleModelVLbl: MyLabel!
    @IBOutlet weak var vehicleLicNumberHbl: MyLabel!
    @IBOutlet weak var vehicleLicNumberVLbl: MyLabel!
    @IBOutlet weak var driverNameHLbl: MyLabel!
    @IBOutlet weak var driverNameVLbl: MyLabel!
    @IBOutlet weak var driverPhoneHLbl: MyLabel!
    @IBOutlet weak var driverPhoneVLbl: MyLabel!
    @IBOutlet weak var orgNameHLbl: MyLabel!
    @IBOutlet weak var orgNameVLbl: MyLabel!
    @IBOutlet weak var orgPhoneHLbl: MyLabel!
    @IBOutlet weak var driverPhoneImgView: UIImageView!
    @IBOutlet weak var orgPhoneVLbl: MyLabel!
    @IBOutlet weak var orgPhoneImgView: UIImageView!
    @IBOutlet weak var orgAddressHLbl: MyLabel!
    @IBOutlet weak var orgAddressVLbl: MyLabel!
    @IBOutlet weak var vehicleInfoView: UIView!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    public var openImgSelection:OpenFileSelector!
    
    var dataDic = NSDictionary()
    var trackingListUV:TrackingListUV!
    var index:Int!
    
    var isForVehicleInfo = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if type == 0 {
            
            self.openImgSelection = OpenFileSelector(uv: self)
            cntView = self.generalFunc.loadView(nibName: "ProfileInfoScreenDesign", uv: self, contentView: contentView)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
           
            self.contentView.addSubview(cntView)
            
            self.setData()
                        
        }else if type == 1 {
            self.configRTL()
 
            self.addBack()
         
        }else if type == 3 {
           
        }
    }
    
    func setData(){
        
        if(isForVehicleInfo ==  true){
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VEHICLE_DETAILS_TXT")
            self.setVehicleInfo()
        }else{
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PROFILE_TXT")
        }
        
        self.userProfilePicBgView.backgroundColor = SColors.Theme
        
        usrProfileImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: dataDic.get("vImage"), width: Utils.getValueInPixel(value: 100), height: Utils.getValueInPixel(value: 100))), placeholderImage:UIImage(named:"ic_no_pic_user"))
        
        Utils.createRoundedView(view: usrProfileImgView, borderColor: SColors.ThemeTxt, borderWidth: 2)

        editPicAreaView.backgroundColor = UIColor.white
        editPicAreaView.layer.addShadow(opacity: 0.8, radius: 3, UIColor.lightGray)
        editPicAreaView.layer.roundCorners(radius: 15)
        
        editIconImgView.image = UIImage(named: "ic_edit")?.resize(toWidth: 15)!.resize(toHeight: 15)
        
        self.editIconImgView.image = self.editIconImgView.image?.addImagePadding(x: 5, y: 5)
        GeneralFunctions.setImgTintColor(imgView: editIconImgView, color: SColors.Theme)
        
        let userProfileImgTapGue = UITapGestureRecognizer()
        userProfileImgTapGue.addTarget(self, action: #selector(self.profilePicTapped))
        
        self.profilePicViewArea.isUserInteractionEnabled = true
        self.profilePicViewArea.addGestureRecognizer(userProfileImgTapGue)
        
        self.nameHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_COMPANY_USER_NAME_TXT")
        self.phoneNumberHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PHONE_NO_TXT")
        self.invitecodeHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INVITE_CODE_TXT")
        self.userLocationHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_USER_LOC_TXT")
        
        
        self.nameVLbl.text = dataDic.get("userName")
        self.phoneNumberVLbl.text = dataDic.get("userPhone")
        self.inviteCodeVLbl.text = dataDic.get("vInviteCode")
        self.userLocationVLbl.text = dataDic.get("userAddress")
     
    }
    
    func setVehicleInfo(){
        
        self.vehicleInfoView.isHidden = false
        
      
        self.vehicleModelHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CAR_MAKE_ADMIN")
        self.vehicleLicNumberHbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VEHICLE_LICENSE_NO_TXT")
        self.driverNameHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_COMPANY_DRIVER_NAME_TXT")
        self.driverPhoneHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_DRIVER_PHONE_NO_TXT")
        self.orgNameHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ORG_NAME_TXT")
        self.orgPhoneHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ORG_PHONE_NO_TXT")
        self.orgAddressHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ORG_ADDRESS_TXT")
        
        self.vehicleModelVLbl.text = dataDic.get("vMake")
        self.vehicleLicNumberVLbl.text = dataDic.get("vLicencePlateNo")
        self.driverNameVLbl.text = dataDic.get("driverName")
        self.driverPhoneVLbl.text = dataDic.get("driverPhone")
        self.orgNameVLbl.text = dataDic.get("orgName")
        self.orgPhoneVLbl.text = dataDic.get("orgPhone")
        self.orgAddressVLbl.text = dataDic.get("orgAddress")
        
        GeneralFunctions.setImgTintColor(imgView: self.driverPhoneImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.orgPhoneImgView, color: SColors.Theme)
        
        self.driverPhoneImgView.handleClick { instance in
            UIApplication.shared.openURL(NSURL(string: ("telprompt:\(self.dataDic.get("driverPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
        }
        
        self.orgPhoneImgView.handleClick { instance in
            UIApplication.shared.openURL(NSURL(string: ("telprompt:\(self.dataDic.get("orgPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
        }
   
    }
    
    @objc func profilePicTapped(){
        
        
        self.openImgSelection.show(type: .CroppedImageFileType) { (isImageUpload) in
            if(isImageUpload == true){
                
                self.openImgSelection.closeSlectionView()
                
               
                if(self.openImgSelection.selectedFileData != nil){
                    self.myImageUploadRequest(image: UIImage.init(data: self.openImgSelection.selectedFileData)!)
                }
            }
        }
        
    }
    
    func myImageUploadRequest(image:UIImage){
        
        
        let myUrl = URL(string: CommonUtils.webservice_path)
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST"
        
        let parameters = [
            "type"  : "uploadImageForTrackingUser",
            "iTrackServiceUserId"    : dataDic.get("iTrackServiceUserId")
        ]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.uploadImage(image:image, completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.trackingListUV.dataArrList.remove(at: self.index)
                    self.dataDic = dataDict.dictOf("message")
                    self.trackingListUV.dataArrList.insert(self.dataDic, at: self.index)
                    self.trackingListUV.tableView.reloadData()
                    self.setData()
                    
                } else if dataDict.get("message") == "" {
                    self.generalFunc.setError(uv: self)
                }
                else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
        
        
    }
    
}
