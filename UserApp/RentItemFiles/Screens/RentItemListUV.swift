//
//  RentItemListUV.swift
//  
//
//  Created by # Admin on 22/10/22.
//

import UIKit
import SysBaseLib
class RentItemListUV: ParentViewUV,ParentViewUVDelegate,UITableViewDelegate, UITableViewDataSource, iCarouselDataSource, iCarouselDelegate,MyBtnClickDelegate{
    
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var msgLbl: MyLabel!
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    let generalFunc = GeneralFunctions()
    var bannersItemList = [String]()
    var listData = [NSDictionary]()
    var loaderView:UIView!
    var isFromNewPost = false
    var eType = ""
    var isFromMyList = false
    var indexPathArray = [Int]()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
    if(type == 0){
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        cntView = self.generalFunc.loadView(nibName: "RentItemListScreenDesignUV", uv: self, contentView: containerView)
        self.tblView.register(UINib(nibName: "RentItemListTVC", bundle: nil), forCellReuseIdentifier: "RentItemListTVC")
        self.tblView.register(UINib(nibName: "RentItemListTVC2", bundle: nil), forCellReuseIdentifier: "RentItemListTVC2")
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.isHidden = true
        
    }else if(type == 1){
        self.configRTL()
        self.addBack()
        if eType == "RentEstate"{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your Posted Properties", key: "LBL_RENT_POST_REALESTATE_BY_USER")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Your Posted Properties", key: "LBL_RENT_POST_REALESTATE_BY_USER")
        }else if eType == "RentCars" {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your Posted Cars", key: "LBL_RENT_POST_CARS_BY_USER")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Your Posted Cars", key: "LBL_RENT_POST_CARS_BY_USER")
        }else if eType == "RentItem" {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Posted items by user", key: "LBL_RENT_POST_ITEM_BY_USER")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Posted items by user", key: "LBL_RENT_POST_ITEM_BY_USER")
        }
        
        self.addView.backgroundColor = SColors.Theme
        self.tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
        Utils.createRoundedView(view: self.addView, borderColor: .clear, borderWidth: 0)
        self.addView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        GeneralFunctions.setImgTintColor(imgView: addImageView, color: SColors.ThemeTxt)
        self.addView.handleClick { instance in
            let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
            rentItemNewPostUV.rentCatId = ""
            rentItemNewPostUV.eType = self.eType
            self.push(uv: rentItemNewPostUV)
        }
        self.msgLbl.isHidden = true
        self.getPost()
    }else if (type == 2) {
            //self.getPost()
        }
        
    
                
    
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  !self.indexPathArray.contains(indexPath.row) {
            let item = self.listData[indexPath.row]
            if item.get("eStatusOrg").uppercased() == "REJECT" {
                return  225
            }else{
                return  175
            }
        }
        return UITableView.automaticDimension
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  !self.indexPathArray.contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RentItemListTVC2", for: indexPath) as! RentItemListTVC2
            let item = self.listData[indexPath.row] as! NSDictionary
            cell.containerView.layer.addShadow(opacity: 1.0, radius: 3, UIColor.gray)
            cell.containerView.cornerRadius = 15.0
            cell.bookingNoLbl.text = item.get("vRentItemPostNo")
            cell.itemNameLbl.text = item.get("vItemName")
            cell.itemStatusLbl.text = item.get("eRentItemDurationDateTxt")
            cell.lblOriStatus.text = self.generalFunc.getLanguageLabel(origValue: item.get("eStatus"), key: item.get("eStatus")).uppercased()
           
            let heightValue = Utils.getValueInPixel(value: 150)
            let widthValue = Utils.getValueInPixel(value:  100)
            let itemData = item.arrOf("Images") as! [NSDictionary]
            cell.itemImageView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:itemData[0].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            Utils.delayWithSeconds(0.1) {
                cell.itemImageView.roundTo(corners: [.bottomLeft,.topLeft], radius: 15)
                
            }
            cell.btnDelete.tag = indexPath.item
            cell.btnDelete.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.red, pulseColor: SColors.red, borderColor: SColors.red, borderWidth: 1, cornerRadius: 5)
            if item.get("eStatusOrg").uppercased() == "DELETED" {
                cell.btnDelete.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "View Reason", key: "LBL_RENT_REJECT_REASON"))
                cell.btnDelete.btnType = "Deleted Admin"
            }else {
            cell.btnDelete.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Delete", key: "LBL_RENT_DELETE_TXT"))
            cell.btnDelete.btnType = "Delete"
            }
            cell.btnDelete.clickDelegate = self
            cell.btnEdit.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 0, cornerRadius: 5)

            if item.get("eStatusOrg").uppercased() == "APPROVED" {
                cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Review Post", key: "LBL_REVIEW_POST"))
                cell.btnEdit.btnType = "Review"
            }else if item.get("eStatusOrg").uppercased() == "DELETED" {
                cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Contact Us", key: "LBL_RENT_CONTACT_US"))
                cell.btnEdit.btnType = "Contact Us"
            }
            else {
                if item.get("eStatusOrg").uppercased() == "EXPIRED" {
                    cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Renew", key: "LBL_RENT_RENEW_TXT"))
                }else{
                cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Edit Information", key: "LBL_RENT_EDIT_INFORMATION"))
                }
                cell.btnEdit.btnType = "Edit"
            }
            cell.bntRejectReason.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.red, pulseColor: SColors.red, borderColor: SColors.red, borderWidth: 1, cornerRadius: 5)
            cell.bntRejectReason.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "View Reason", key: "LBL_RENT_REJECT_REASON"))
            cell.bntRejectReason.btnType = "Reject"
            cell.bntRejectReason.clickDelegate = self
            cell.bntRejectReason.tag = indexPath.item
            if item.get("eStatusOrg").uppercased() == "REJECT" {
            cell.bntRejectReason.isHidden = false
                cell.btnRejectListHight.constant = 40
            }else {
            cell.bntRejectReason.isHidden = true
            cell.btnRejectListHight.constant = 0
                }
            if(Configurations.isRTLMode()){
                cell.imageHintView.transform  = CGAffineTransform(rotationAngle: 180 * CGFloat(CGFloat.pi/180)).concatenating(CGAffineTransform(scaleX: 1, y: -1))
            }
            cell.btnEdit.centerButtonText()
            cell.btnDelete.centerButtonText()
            cell.bntRejectReason.centerButtonText()
            cell.btnEdit.clickDelegate = self
            cell.btnEdit.tag = indexPath.item
            cell.itemImageView.tag = indexPath.row
            cell.btnEdit.setFont(fontSize: 12)
            cell.btnDelete.setFont(fontSize: 12)
            cell.bntRejectReason.setFont(fontSize: 12)
            cell.itemImageView.handleClick { instance in
               
                    self.indexPathArray.append(indexPath.row)
                    let indexPath = [IndexPath(item: indexPath.row, section: 0)]
                    self.tblView.reloadRows(at: indexPath ,
                                              with: .fade)
               
            }
            
            
            
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentItemListTVC", for: indexPath) as! RentItemListTVC
        let item = self.listData[indexPath.row]
        cell.containerView.layer.addShadow(opacity: 1.0, radius: 3, UIColor.gray)
        cell.containerView.cornerRadius = 15.0
            Utils.delayWithSeconds(0.1) {
                cell.itemImageView.roundTo(corners: [.topRight,.topLeft], radius: 15)
                
            }
        cell.imgSlider.round(corners: [.topLeft,.topRight], cornerRadius: 15)
        cell.imgSlider.isHidden = true
        cell.detailsView.round(corners: [.bottomLeft,.bottomRight], cornerRadius: 15)

        cell.bookingNoLbl.text = item.get("vRentItemPostNo")
        cell.itemNameLbl.text = item.get("vItemName")
        cell.itemStatusLbl.text = item.get("eRentItemDurationDateTxt")
        cell.lblOriStatus.text = self.generalFunc.getLanguageLabel(origValue: item.get("eStatus"), key: item.get("eStatus")).uppercased()
        
        cell.imageViewHight.constant = 170
        cell.imgSliderHight.constant = 170
            
        let height = 170
        let heightValue = Utils.getValueInPixel(value: CGFloat(height))
        let widthValue = Utils.getValueInPixel(value:  Application.screenSize.width - 20)
        let itemData = item.arrOf("Images") as! [NSDictionary]
        cell.itemImageView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:itemData[0].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)

        cell.btnDelete.tag = indexPath.item
        cell.btnDelete.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.red, pulseColor: SColors.red, borderColor: SColors.red, borderWidth: 1, cornerRadius: 5)
        if item.get("eStatusOrg").uppercased() == "DELETED" {
            cell.btnDelete.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "View Reason", key: "LBL_RENT_REJECT_REASON"))
            cell.btnDelete.btnType = "Deleted Admin"
        }else {
        cell.btnDelete.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Delete", key: "LBL_RENT_DELETE_TXT"))
        cell.btnDelete.btnType = "Delete"
        }
        cell.btnDelete.clickDelegate = self
        cell.btnEdit.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 0, cornerRadius: 5)
        cell.bntRejectReason.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.red, pulseColor: SColors.red, borderColor: SColors.red, borderWidth: 1, cornerRadius: 5)
        cell.bntRejectReason.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "View Reason", key: "LBL_RENT_REJECT_REASON"))
        cell.bntRejectReason.btnType = "Reject"
        cell.bntRejectReason.clickDelegate = self
        cell.bntRejectReason.tag = indexPath.item
        if item.get("eStatusOrg").uppercased() == "APPROVED" {
            cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Review Post", key: "LBL_REVIEW_POST"))
            cell.btnEdit.btnType = "Review"
        }else if item.get("eStatusOrg").uppercased() == "DELETED" {
            cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Contact Us", key: "LBL_RENT_CONTACT_US"))
            cell.btnEdit.btnType = "Contact Us"
        }
        else {
            if item.get("eStatusOrg").uppercased() == "EXPIRED" {
                cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Renew", key: "LBL_RENT_RENEW_TXT"))
            }else{
            cell.btnEdit.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Edit Information", key: "LBL_RENT_EDIT_INFORMATION"))
            }
            cell.btnEdit.btnType = "Edit"
        }
        
        if item.get("eStatusOrg").uppercased() == "REJECT" {
           cell.bntRejectReason.isHidden = false
            cell.btnRejectReasonHight.constant = 50
        }else {
        cell.bntRejectReason.isHidden = true
            cell.btnRejectReasonHight.constant = 0
            }
        if(Configurations.isRTLMode()){
            cell.imageHintView.transform  = CGAffineTransform(rotationAngle: 180 * CGFloat(CGFloat.pi/180)).concatenating(CGAffineTransform(scaleX: 1, y: -1))
        }
        cell.btnEdit.centerButtonText()
        cell.btnDelete.centerButtonText()
        cell.bntRejectReason.centerButtonText()
        cell.btnEdit.setFont(fontSize: 14)
        cell.btnDelete.setFont(fontSize: 14)
        cell.bntRejectReason.setFont(fontSize: 14)
        cell.btnEdit.clickDelegate = self
        cell.btnEdit.tag = indexPath.item
        cell.itemImageView.tag = indexPath.item
        cell.itemImageView.handleClick { instance in
            for val in self.indexPathArray{
                if val == indexPath.item {
                    self.indexPathArray.remove(object: val)
                    let indexPath = [IndexPath(item: indexPath.row, section: 0)]
                
                    self.tblView.reloadRows(at: indexPath,
                                              with: .fade)
                    break
                }
            }
            }
        return cell
        }
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return 1
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        
        let itemData = self.listData[carousel.tag].arrOf("Images") as! [NSDictionary]
        
        var imgView:UIImageView!

        if (view == nil){
            
            let height = Utils.getHeightOfBanner(widthOffset: 20, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: Application.screenSize.width - 10, height: height))
          //  imgView.frame = carousel.frame
            imgView.backgroundColor = UIColor.clear
            
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:itemData[0].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            
            
        }else{
            imgView = view as? UIImageView
            imgView.backgroundColor = UIColor.systemGray5
            
            let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
            let heightValue = Utils.getValueInPixel(value: height)
            let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: itemData[0].get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 0
            imgView.clipsToBounds = true
            //
        }
        
        return imgView
    }
    func myBtnTapped(sender: MyButton) {
        if sender.btnType == "Delete"  {
            let item = self.listData[sender.tag]
            self.generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: self.generalFunc.getLanguageLabel(origValue: "Are you sure you want to delete this post", key: "LBL_RENT_DELETE_POST") , positiveBtn:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: {(btnClickedId) in
                
                if(btnClickedId == 0){
                    
                    self.DeletePost(postId: item.get("iRentItemPostId"))
                    
                }
                if(btnClickedId == 1)
                {
                    
                }
            })
            
            
            
        }else if sender.btnType == "Edit" {
            let item = self.listData[sender.tag]
            let rentItemNewPostUV = GeneralFunctions.instantiateViewController(pageName: "RentItemNewPostUV") as! RentItemNewPostUV
            rentItemNewPostUV.rentCatId = item.get("iItemCategoryId")
            rentItemNewPostUV.rentsubCatId = item.get("iItemSubCategoryId")
            rentItemNewPostUV.editData = item
            rentItemNewPostUV.postID = item.get("iRentItemPostId")
            rentItemNewPostUV.selectdPaymentId = item.get("iPaymentPlanId")
            rentItemNewPostUV.timeSlot = item.arrOf("timeslot") as! [NSDictionary]
            rentItemNewPostUV.eType = self.eType
            if item.get("isBuySell") == "Yes" {
                rentItemNewPostUV.isRent = false
            }
            
            self.push(uv: rentItemNewPostUV)
        }else if sender.btnType == "Review" {
            let item = self.listData[sender.tag]
            let rentDetailView = GeneralFunctions.instantiateViewController(pageName: "RentItemDetailsUV") as! RentItemDetailsUV
            rentDetailView.data = item
            rentDetailView.isBottomViewHide = true
            rentDetailView.isfromMYlist = true
            self.push(uv: rentDetailView)
        }else if sender.btnType == "Reject" || sender.btnType == "Deleted Admin" {
            let item = self.listData[sender.tag]
            self.generalFunc.setError(uv: self, title: "", content: item.get("vRejectReason"))
        }else if sender.btnType == "Contact Us" {
            let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
            self.push(uv: contactUsUv)
        }
    }
    
    
    func getPost()  {
        self.tblView.isHidden = true
        setLoader(ishidden: false)
        let parameters = ["type":"GetAllPost", "iMemberId":GeneralFunctions.getMemberd(),"eType" : self.eType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.listData = dataDict.arrOf("message") as! [NSDictionary]
                    self.tblView.isHidden = false
                    self.msgLbl.isHidden = true
                   
                    self.tblView.reloadData()
                    Utils.delayWithSeconds(0.1) {
                      
                        self.tblView.reloadData()
                        self.tblView.layoutIfNeeded()
                    }


                }else if dataDict.get("Action") == "0"{
                    if dataDict.get("message") == "LBL_NO_DATA_AVAIL" {
                        self.msgLbl.isHidden = false
                        self.msgLbl.text =  self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                    }
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func DeletePost(postId : String)  {
        setLoader(ishidden: false)
        
        let parameters = ["type":"DeletePost", "iMemberId":GeneralFunctions.getMemberd(),"iRentItemPostId" : postId , "eDeletedBy" : "User"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.listData = dataDict.arrOf("message") as! [NSDictionary]
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message2"), key: dataDict.get("message2")), uv: self)
                    self.msgLbl.isHidden = true
                    self.tblView.reloadData()
                    
                   
                }else if dataDict.get("Action") == "0"{
                    if dataDict.get("message") == "LBL_NO_DATA_AVAIL" {
                        self.msgLbl.isHidden = false
                        self.msgLbl.text =  self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                    }
                }
                
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
    override func close(){
       
        if isFromMyList {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    }

