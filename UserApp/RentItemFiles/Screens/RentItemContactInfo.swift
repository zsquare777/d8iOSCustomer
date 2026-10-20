//
//  RentItemContactInfo.swift
//  UserApp
//
//  Created by # Admin on 31/10/22.
//

import UIKit
import SysBaseLib

class RentItemContactInfo: ParentViewUV,ParentViewUVDelegate,UITableViewDelegate, UITableViewDataSource,MXParallaxHeaderDelegate {
   
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblHeaderView: UIView!
    @IBOutlet weak var tblHeaderTopview: UIView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLbl: MyLabel!
    @IBOutlet weak var ownerNoLbl: MyLabel!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var otherItemsLbl: MyLabel!
    @IBOutlet weak var noDataLbl: MyLabel!
    @IBOutlet weak var viewCall: UIView!
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var data = NSDictionary()
    var loaderView:UIView!
    let generalFunc = GeneralFunctions()
    var listData = [NSDictionary]()
    var isDataLoad = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
    if(type == 0){
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        cntView = self.generalFunc.loadView(nibName: "RentItemContactInfo", uv: self, contentView: containerView)
        self.tblView.register(UINib(nibName: "RentItemOwnerItemTVC", bundle: nil), forCellReuseIdentifier: "RentItemOwnerItemTVC")
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.reloadData()
        self.contactOwnerMailSend()
    }else if(type == 1){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Owner information", key: "LBL_RENT_OWNER_INFO")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Owner information", key: "LBL_RENT_OWNER_INFO")
        self.configRTL()
        self.addBack()
        self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.anchorSubView.backgroundColor = SColors.Theme
        
        self.otherItemsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Other Items", key: "LBL_RENT_OTHER_ITEM")
        if(Configurations.isRTLMode()){
            self.otherItemsLbl.textAlignment = .right
            
        }
        self.tblHeaderView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.tblHeaderTopview.backgroundColor = SColors.Theme
        Utils.createRoundedView(view: self.viewCall, borderColor: .clear, borderWidth: 0)
        self.viewCall.backgroundColor = SColors.Theme
        self.viewCall.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        if !isDataLoad {
        self.tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
        self.tblView.bounces = false
        self.tblView.parallaxHeader.delegate = self
        self.tblView.parallaxHeader.view = self.tblHeaderView
        self.tblView.parallaxHeader.mode = .bottom
        self.tblView.parallaxHeader.height = tblHeaderView.frame.size.height
        self.tblView.parallaxHeader.minimumHeight = 75
        self.getPost()
        }
        ownerImageView.sd_setImage(with: URL(string: self.data.get("vUserImage")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        if self.data.get("eIsUserNumberDisplay") == "Yes" {
            self.ownerNoLbl.text = self.data.get("vUserPhone")
            self.viewCall.isHidden = false
        }else{
            self.ownerNoLbl.text = ""
            self.viewCall.isHidden = true
        }
        
        self.ownerNameLbl.text = self.data.get("vUserName")
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        self.viewCall.handleClick { instance in
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
            }
        }
        Utils.createRoundedView(view: ownerImageView, borderColor: SColors.Theme.dark(by: 10) ?? UIColor.black, borderWidth: 2)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = Utils.getHeightOfBanner(widthOffset: 20, ratio: "16:9")
        
        return CGFloat(height) + 145
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentItemOwnerItemTVC", for: indexPath) as! RentItemOwnerItemTVC
        let item = self.listData[indexPath.row]
        cell.contentView.backgroundColor = UIColor(hex: 0xf1f1f1)
        
        
        cell.contanierView.cornerRadius = 15.0
        GeneralFunctions.setImgTintColor(imgView: cell.secureUserImageView, color: SColors.Theme)
        cell.contanierView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contanierView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.contanierView.layer.shadowRadius = 3.0
        cell.contanierView.layer.shadowOpacity = 1
        cell.contanierView.layer.masksToBounds = false
        cell.cotactBgView.layer.cornerRadius = cell.cotactBgView.frame.size.width / 2
        cell.cotactBgView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.cotactBgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cotactBgView.layer.shadowRadius = 3.0
        cell.cotactBgView.layer.shadowOpacity = 1
        if item.get("eIsFavourite").uppercased() == "YES" {
            cell.favIconImage.image = UIImage.init(named: "ic_sel_favStore")
        }else{
            cell.favIconImage.image = UIImage.init(named: "ic_dis_favStore")
        }
        cell.itemImageView.round(corners: [.topLeft,.topRight], cornerRadius: 15)
        Utils.createRoundedView(view: cell.contanierView, borderColor: .clear, borderWidth: 0, cornerRadius: 15)
       
        let height = Utils.getHeightOfBanner(widthOffset: 20, ratio: "16:9")
        let heightValue = Utils.getValueInPixel(value: height)
       
            cell.itemImageHight.constant = CGFloat(height)
            cell.cotactBgView.layoutIfNeeded()
            cell.cotactBgView.setNeedsLayout()
        
        
        let widthValue = Utils.getValueInPixel(value:  Application.screenSize.width - 20)
        let imageUrl = item.arrOf("Images") as! [NSDictionary]
        cell.itemImageView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:imageUrl[0].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
        
        cell.priceLbl.text = item.get("fAmount")
        cell.nameLbl.text = item.get("vItemName")
        cell.kmLbl.text = ""
        cell.adressLbl.text = item.get("vLocation")
        cell.featuredLbl.text = "Featured"
        cell.adressLbl.isHidden = false
        cell.contanierView.handleClick { instance in
            let item = self.listData[indexPath.row]
            let rentDetailView = GeneralFunctions.instantiateViewController(pageName: "RentItemDetailsUV") as! RentItemDetailsUV
            rentDetailView.data = item
            rentDetailView.isBottomViewHide = true
            self.push(uv: rentDetailView)
        }
        return cell
        
    }
    func getPost()  {
        
        setLoader(ishidden: false)
        self.tblView.isHidden = true
        let parameters = ["type":"getAllPostOwner", "iMemberId":self.data.get("iUserId"), "iRentItemPostId" : self.data.get("iRentItemPostId")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            self.tblView.isHidden = false
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.listData = dataDict.arrOf("message") as! [NSDictionary]
                    self.noDataLbl.isHidden = true
                    self.tblView.reloadData()
                    if dataDict.get("message") == "LBL_NO_DATA_AVAIL" {
                    self.noDataLbl.isHidden = false
                    self.noDataLbl.text =  self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                    }
                }else{
                    if dataDict.get("message") == "LBL_NO_DATA_AVAIL" {
                    self.noDataLbl.isHidden = false
                    self.noDataLbl.text =  self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                    }
                }
                self.isDataLoad = true
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
    }
    func audioCall(){
        ownerImageView.sd_setImage(with: URL(string: self.data.get("vUserImage")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        self.ownerNoLbl.text = self.data.get("vUserPhone")
        self.ownerNameLbl.text = self.data.get("vUserName")
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
       
        let parameters = ["type": "sendContactQueryForRent", "iMemberId": GeneralFunctions.getMemberd(), "iRentItemOwnerId": self.data.get("iUserId"), "iRentItemPostId": self.data.get("iRentItemPostId")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Your inquiry has been sent successfully. Owner will get in touch with you shortly.", key: dataDict.get("message")), uv: self)
                }
               
            }else{
            }
        })
    }
}
