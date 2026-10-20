

import UIKit
import SysBaseLib

class UFXFilterServicesUV: ParentViewUV, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var noServiceAvailLbl: MyLabel!
    @IBOutlet weak var ufxDataVerticalStackView: UIStackView!
    @IBOutlet weak var nextBtn: MyButton!
    @IBOutlet weak var nextBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var selectServiceLbl: MyLabel!
    @IBOutlet weak var nextBtnBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var ufxDataVerticalStackViewHeight: NSLayoutConstraint!
    
    var userProfileJson:NSDictionary!
    var cntView:UIView!

    let generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    var  viewArray = [UIView]()
    var currentItems = [NSDictionary]()
    var subCategoryItems = [NSDictionary]()
    var selectedCategoryIds = [NSMutableDictionary]()
    
    var ufxSelectedVehicleTypeId = ""
    var ufxSelectedVehicleTypeParentId = ""
    var ufxSelectedVehicleTypeName = ""
    var ufxSelectedLatitude = ""
    var ufxSelectedLongitude = ""
    
    var isMapSelectedTab = false
    var mainScreenUV:MainScreenUV!
    
    var currentCategoryName = ""
    var biddingID = ""
    var eForVideoConsultation = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.setnavBarTintColor(color: SColors.Theme)
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "UFXFilterServicesScreenDesign", uv: self, contentView: contentView) //, isStatusBarAvail: true
            //        cntView.frame.size = CGSize(width: cntView.frame.width, height: cntView.frame.height - 100)
            self.contentView.addSubview(cntView)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
          
            scrollView.parallaxHeader.view = self.selectServiceLbl
            scrollView.parallaxHeader.height = 50
            scrollView.parallaxHeader.mode = .bottom
            scrollView.parallaxHeader.minimumHeight = 50
            scrollView.bounces = false
            
    //        if(Configurations.isIponeXDevice() == true){
    //            if #available(iOS 11.0, *) {
    //                self.nextBtnHeight.constant = 25 + self.nextBtnHeight.constant
    //            } else {
    //                // Fallback on earlier versions
    //            }
    //        }
            
            self.nextBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FILTER_TXT"))
            
            
            self.nextBtn.setClickHandler { (instance) in
               
                var selectedServiceIds = ""
                
                for i in 0..<self.selectedCategoryIds.count{
                    let tempDataDict = self.selectedCategoryIds[i]
                    if(tempDataDict.get("IS_SELECTED") == "Yes"){
                        selectedServiceIds = (selectedServiceIds == "") ? tempDataDict.get("iVehicleCategoryId") : "\(selectedServiceIds),\(tempDataDict.get("iVehicleCategoryId"))"
                        
                    }
                }
                if (selectedServiceIds == ""){
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE_TXT"))
                    //Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE_TXT"), uv: self)
                    return
                }
               
                self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
            }
            
            self.selectServiceLbl.text = ufxSelectedVehicleTypeName
            
            
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE")
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
           
            self.loadServiceCategory(parentCategoryId:ufxSelectedVehicleTypeParentId)
            
        }
    }
    
 
    
    override func close() {
       
       // if( mainScreenUV.isMapSelectedTab == true){
       //     self.mainScreenUV.ufxSelectMapPage()
       // }else{
            self.mainScreenUV.ufxSelectListPage(false)
       // }
        super.close()
    }
    
    func loadServiceCategory(parentCategoryId:String){
        scrollView.isHidden = true
        scrollView.scrollToTop()
        loaderView =  self.generalFunc.addMDloader(contentView: self.view)
        loaderView.backgroundColor = UIColor.clear
        
        let parameters = ["type":"getServiceCategories", "userId": GeneralFunctions.getMemberd(), "parentId": parentCategoryId, "SelectedVehicleTypeId": self.ufxSelectedVehicleTypeId,"eForVideoConsultation":eForVideoConsultation]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
           
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    self.currentItems.removeAll()
                    self.subCategoryItems.removeAll()
                    
                    var categoryItems = [NSDictionary] ()
                    
                    for i in 0..<msgArr.count{
                        categoryItems += [msgArr[i] as! NSDictionary]
                    }
                    
                    self.currentItems.append(contentsOf: categoryItems)
                    
                    self.subCategoryItems.append(contentsOf: categoryItems)
                    self.setSubCategoryMode(vParentCategoryName: dataDict.get("vParentCategoryName"))
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    self.loadServiceCategory(parentCategoryId:parentCategoryId)
                })
                
            }
            
            self.loaderView.isHidden = true
            self.scrollView.isHidden = false
            
        })
    }
    
    func setSubCategoryMode(vParentCategoryName:String){
        
        if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
            self.nextBtn.isHidden = false
        }
        
        SDImageCache.shared().clearMemory()
       
        self.noServiceAvailLbl.isHidden = true
       
        self.scrollView.isHidden = false
        
        
        for subview in self.ufxDataVerticalStackView.subviews {
            subview.removeFromSuperview()
        }
        
        
        self.scrollView.scrollToTop()
        
        //        self.ufxDataVerticalStackView.hidden = true
        
        if(self.currentItems.count == 0 && userProfileJson.get("UBERX_PARENT_CAT_ID") == "0"){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available in selected category.", key: "LBL_NO_SUB_SERVICE_AVAIL")
            self.noServiceAvailLbl.isHidden = false
        }else if(self.currentItems.count == 0){
            self.noServiceAvailLbl.text = self.generalFunc.getLanguageLabel(origValue: "No services available.", key: "LBL_NO_SERVICE_AVAIL")
            self.noServiceAvailLbl.isHidden = false
        }
        
        self.selectedCategoryIds.removeAll()
        
        let currentSelectedIDsArray = self.ufxSelectedVehicleTypeId.components(separatedBy: ",")
        for i in 0..<self.currentItems.count{
            
            let horizontalStackView = (generalFunc.loadView(nibName: "UfxCategoryHorizontalStackViewDesign", uv: self).subviews[0]) as! UIStackView
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution  = UIStackView.Distribution.fillEqually
            horizontalStackView.spacing = 5
            
            
            let parentGridView = self.generalFunc.loadView(nibName: "UfxSubCategoryDesignItem", uv: self)
            parentGridView.tag = i
            parentGridView.backgroundColor = SColors.ThemeTxt
//            parentGridView.layer.shadowRadius = 0.9
//            parentGridView.layer.shadowOpacity = 0.9
//            parentGridView.layer.shadowOffset = CGSize.zero
//            parentGridView.layer.shadowColor = UIColor.darkGray.cgColor
            self.shadowOnview(view: parentGridView)
            parentGridView.layer.cornerRadius = 8
            //parentGridView.clipsToBounds = true
            //            parentGridView.frame.size = CGSize(width: self.view.frame.width, height: 100)
            
            //            (parentGridView.subviews[2] as! UIImageView).image = arrowImg!.imageRotatedByDegrees(270,flip: false)
            
            parentGridView.isUserInteractionEnabled = true
            //            let parentTapGue = UITapGestureRecognizer()
            //            parentTapGue.addTarget(self, action: #selector(self.itemTapped(sender:)))
            //            parentGridView.addGestureRecognizer(parentTapGue)
            viewArray.append(parentGridView)
            let item = self.currentItems[i]
            
            //            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[0] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            //            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[2] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            
            
            let selectedDataDict = NSMutableDictionary()
            selectedDataDict["iVehicleCategoryId"] = item.get("iVehicleCategoryId")
            selectedDataDict["vParentCategoryName"] = vParentCategoryName
            
            
            if(currentSelectedIDsArray.contains(item.get("iVehicleCategoryId"))){
                selectedDataDict["IS_SELECTED"] = "Yes"
            }else{
                selectedDataDict["IS_SELECTED"] = "No"
            }
            selectedCategoryIds += [selectedDataDict]
            
            (parentGridView.subviews[1] as! UILabel).textColor = UIColor.black
            
            if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                
                let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                
                if(IS_SELECTED == "Yes"){
                    (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_liveTrackTrue")
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: UIColor.white)
                    (parentGridView.subviews[5]).backgroundColor = SColors.Theme
                    (parentGridView.subviews[1] as! UILabel).textColor = SColors.Theme
                    
                }else{
                    (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_add_plus")
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.Theme)
                    (parentGridView.subviews[5]).backgroundColor = UIColor.white
                    (parentGridView.subviews[1] as! UILabel).textColor = UIColor.black
                    
                }
            }
            
            (parentGridView.subviews[1] as! UILabel).text = item.get("vCategory")
            
            print(item.get("vLogo_image"))
            (parentGridView.subviews[0] as! UIImageView).sd_setImage(with: URL(string: item.get("vLogo_image")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                (parentGridView.subviews[2]).isHidden = true
                //(parentGridView.subviews[4]).isHidden = false
                (parentGridView.subviews[4]).isHidden = true
                
                (parentGridView.subviews[4] as! BEMCheckBox).createSysBox()
                
                (parentGridView.subviews[4] as! BEMCheckBox).isUserInteractionEnabled = false
                
                (parentGridView.subviews[5]).borderColor = SColors.Theme
                   
                if  (item.get("eCatType").uppercased() == "BIDDING") {
                    (parentGridView.subviews[5]).isHidden = true
                    (parentGridView.subviews[4]).isHidden = true
                    (parentGridView.subviews[6]).isHidden = false
                    GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[6])) as! UIImageView), color: SColors.Theme)
                    
                    let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                    
                    if(IS_SELECTED == "Yes"){
                        self.biddingID = item.get("iBiddingId")
                        self.handleBiddingCategory()
                        
                    }
                    
                    parentGridView.handleClick { (instance) in
                        self.currentCategoryName = item.get("vCategory")
                        
                        if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                            self.biddingID = item.get("iBiddingId")
                            self.handleBiddingCategory()
                        }else{
                            self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                        }
                    }
                    
                    
                }else{
                    if(self.eForVideoConsultation.uppercased() == "YES"){
                        (parentGridView.subviews[5]).isHidden = true
                        (parentGridView.subviews[4]).isHidden = true
                        (parentGridView.subviews[6]).isHidden = false
                        GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[6])) as! UIImageView), color: SColors.Theme)
                        
                        let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                        
                        if(IS_SELECTED == "Yes"){
                            let viewTemp = self.viewArray[parentGridView.tag]
                            ((viewTemp.subviews[6]) as! UIImageView).image = UIImage(named:"ic_select_true")
                            GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)
                            (viewTemp.subviews[5]).backgroundColor = SColors.Theme
                            //self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                            (viewTemp.subviews[1] as! UILabel).textColor = SColors.Theme
                            
                        }
                    }
                   parentGridView.handleClick { (instance) in
                   
                    
                    if(self.userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
                        let IS_SELECTED = self.getValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED")
                        
                        if(self.eForVideoConsultation.uppercased() == "YES"){
                            
                            let item = self.currentItems[parentGridView.tag]
                            let viewTemp = self.viewArray[parentGridView.tag]
                            ((viewTemp.subviews[6]) as! UIImageView).image = UIImage(named:"ic_select_true")
                            GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)
                            (viewTemp.subviews[5]).backgroundColor = SColors.Theme
                            //self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                            (viewTemp.subviews[1] as! UILabel).textColor = SColors.Theme
                            
                            self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                            
                            for i in 0..<self.currentItems.count{
                                let item = self.currentItems[i]
                                let viewTemp = self.viewArray[i]
                                
                                if i != parentGridView.tag{
                                    ((viewTemp.subviews[6])as! UIImageView).image = UIImage(named:"ic_select_false")
                                    GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)

                                    (viewTemp.subviews[5]).backgroundColor = UIColor.white
                                    (viewTemp.subviews[1] as! UILabel).textColor = UIColor.black
                                    
                                    self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "No")
                                    
                                }
                            }
                        }else{
                            if(IS_SELECTED == "No"){
                                (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_liveTrackTrue")
                                GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: UIColor.white)
                                (parentGridView.subviews[5]).backgroundColor = SColors.Theme
                                self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                                (parentGridView.subviews[1] as! UILabel).textColor = SColors.Theme
                                
                            }else{
                                (((parentGridView.subviews[5]).subviews[0]) as! UIImageView).image = UIImage(named:"ic_add_plus")
                                GeneralFunctions.setImgTintColor(imgView: (((parentGridView.subviews[5]).subviews[0]) as! UIImageView), color: SColors.Theme)
                                (parentGridView.subviews[5]).backgroundColor = UIColor.white
                                self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "No")
                                (parentGridView.subviews[1] as! UILabel).textColor = UIColor.black
                            }
                        }
                        
                    }else{
                        self.itemTapped(catView: parentGridView, position: parentGridView.tag)
                    }
                }
                }
            }else{
                self.itemTapped(catView: parentGridView, position: parentGridView.tag)
            }
            

            if(Configurations.isRTLMode()){
                (parentGridView.subviews[2] as! UIImageView).transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            GeneralFunctions.setImgTintColor(imgView: (parentGridView.subviews[2] as! UIImageView), color: UIColor(hex: 0x4B5B5C))
            
            horizontalStackView.addArrangedSubview(parentGridView)
            
            if(i == (self.currentItems.count - 1)){
                (parentGridView.subviews[3]).isHidden = true
            }
            
            self.ufxDataVerticalStackView.addArrangedSubview(horizontalStackView)
        }
        self.scrollView.scrollToTop()
        
        self.ufxDataVerticalStackViewHeight.constant = CGFloat(self.ufxDataVerticalStackView.subviews.count * 110)
        
        if(userProfileJson.get("SERVICE_PROVIDER_FLOW").uppercased() == "PROVIDER"){
            if(Configurations.isIponeXDevice()){
                nextBtnBottomSpace.constant = 35
            }else{
                nextBtnBottomSpace.constant = 10
            }
        }else{
            self.nextBtn.isHidden = true
            nextBtnBottomSpace.constant = -75
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.ufxDataVerticalStackViewHeight.constant + 10)
    }
    
    func handleBiddingCategory()   {

        for i in 0..<self.currentItems.count{
            let item = currentItems[i]
            let viewTemp = viewArray[i]
            if self.biddingID == item.get("iBiddingId"){
                ((viewTemp.subviews[6]) as! UIImageView).image = UIImage(named:"ic_select_true")
                GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)
                (viewTemp.subviews[5]).backgroundColor = SColors.Theme
                //self.setValueOfSelectedTypes(item.get("iVehicleCategoryId"), "IS_SELECTED", "Yes")
                (viewTemp.subviews[1] as! UILabel).textColor = SColors.Theme
            }else{
                ((viewTemp.subviews[6])as! UIImageView).image = UIImage(named:"ic_select_false")
                GeneralFunctions.setImgTintColor(imgView: (((viewTemp.subviews[6])) as! UIImageView), color: SColors.Theme)

                (viewTemp.subviews[5]).backgroundColor = UIColor.white
                (viewTemp.subviews[1] as! UILabel).textColor = UIColor.black
            }
            
        }
    }
    
    func checkBiddingData() {
        
        if self.biddingID == "" {
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE_TXT"), uv: self)
            return
        }else{
            let bidInfromationUV = GeneralFunctions.instantiateViewController(pageName: "BidInfromationUV") as! BidInfromationUV
            bidInfromationUV.bidCategory = self.currentCategoryName
            bidInfromationUV.bidID = self.biddingID
            self.push(uv: bidInfromationUV)
        }
    }
    
    func getValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String) -> String{
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                return tempDataDict.get(keyOfValue)
            }
        }
        
        return ""
    }
    
    func setValueOfSelectedTypes(_ iVehicleCategoryId:String, _ keyOfValue:String, _ value:String){
        for i in 0..<self.selectedCategoryIds.count{
            let tempDataDict = self.selectedCategoryIds[i]
            if(tempDataDict.get("iVehicleCategoryId") == iVehicleCategoryId){
                self.selectedCategoryIds[i][keyOfValue] = value
                break
            }
        }
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    
    @objc func itemTapped(catView:UIView, position:Int){
//        if(position >=  self.currentItems.count){
//            return
//        }
//        if(loaderView != nil && loaderView.isHidden == false){
//            return
//        }
//
//        if(userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.currentMode == "PARENT_MODE"){
//            self.selectServiceLbl.text = self.currentItems[position].get("vCategory")
//
//            UIView.animate(withDuration: 0.1, animations: {
//                catView.transform = .init(scaleX: 0.85, y: 0.85)
//            }) { (_) in
//
//                UIView.animate(withDuration: 0.1, animations: {
//                    catView.transform = .identity
//                }) { (_) in
//                    self.loadServiceCategory(parentCategoryId: self.currentItems[position].get("iVehicleCategoryId"))
//                }
//                //                self.loadServiceCategory(parentCategoryId: self.currentItems[sender.view!.tag].get("iVehicleCategoryId"))
//            }
//
//        }else if(self.currentMode == "SUB_MODE" || userProfileJson.get("UBERX_PARENT_CAT_ID") != "0"){
//
//            if(self.selectedLatitude == "" || self.selectedLongitude == ""){
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SET_LOCATION"), uv: self)
//                return
//            }
//
//            checkSelectedCategory(iVehicleCategoryId: self.currentItems[position].get("iVehicleCategoryId"), position: position , categoryName: self.currentItems[position].get("vCategory"))
//
//            return
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
