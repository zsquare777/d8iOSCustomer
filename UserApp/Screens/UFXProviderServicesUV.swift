

import UIKit
import SysBaseLib

class UFXProviderServicesUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noserviceLbl: MyLabel!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var providerInfo:NSDictionary!
    
    var dataArray = [NSDictionary]()
    
    var ufxSelectedVehicleTypeId = ""
    var ufxSelectedVehicleTypeParentId = ""
    
    var ufxSelectedLatitude = ""
    var ufxSelectedLongitude = ""
    var ufxSelectedAddress = ""
    
    var loaderView:UIView!
    
    var providerInfoTabUV:UFXProviderInfoTabUV!
    private var lastContentOffset: CGFloat = 0
    
    
    var eForVideoConsultation = ""
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES"))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "UFXProviderServicesScreenDesign", uv: self, contentView: contentView))
            self.contentView.backgroundColor =  SColors.ThemeTxt//UIColor(hex: 0xf1f1f1)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.bounces = false
            self.tableView.tableFooterView = UIView.init(frame: CGRect(x:0, y:0, width: self.view.frame.size.width, height: GeneralFunctions.getSafeAreaInsets().bottom))
           
            self.tableView.register(UINib(nibName: "UFXProviderServicesTVCell", bundle: nil), forCellReuseIdentifier: "UFXProviderServicesTVCell")
            
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 20, right: 0)
            
            self.contentView.alpha = 0
            
            self.loadProviderServices()
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView.alpha = 1
                
            }, completion:{ _ in})
            
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            
            if(self.tableView != nil){
                self.tableView.reloadData()
            }
        }else if(type == 3){
            self.providerInfoTabUV.view.layoutIfNeeded()
            self.providerInfoTabUV.topProfileViewHeight.constant = 100
            self.providerInfoTabUV.hideShowProfileView(isHide: false)
            UIView.animate(withDuration: 0.15, animations: {
                self.providerInfoTabUV.view.layoutIfNeeded()
            })
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            
            self.providerInfoTabUV.view.layoutIfNeeded() // force any pending operations to finish
            if(self.providerInfoTabUV.topProfileViewHeight.constant - scrollView.contentOffset.y <= 25){
                self.providerInfoTabUV.topProfileViewHeight.constant = 0
                self.providerInfoTabUV.hideShowProfileView(isHide: true)
               
            }else{
                self.providerInfoTabUV.topProfileViewHeight.constant = self.providerInfoTabUV.topProfileViewHeight.constant - (scrollView.contentOffset.y / 1.5)
               
            }
            
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                
                self.providerInfoTabUV.view.layoutIfNeeded()
            })
         
        }else if (self.lastContentOffset > scrollView.contentOffset.y && scrollView.contentOffset.y < 100) {
            
            self.providerInfoTabUV.view.layoutIfNeeded()
           
            if(self.providerInfoTabUV.topProfileViewHeight.constant + abs(scrollView.contentOffset.y) >= 100){
                self.providerInfoTabUV.topProfileViewHeight.constant = 100
               
            }else{
               
                self.providerInfoTabUV.topProfileViewHeight.constant = self.providerInfoTabUV.topProfileViewHeight.constant + abs((scrollView.contentOffset.y / 1.5))
                
            }
            self.providerInfoTabUV.hideShowProfileView(isHide: false)
            UIView.animate(withDuration: 0.2, animations: {
                self.providerInfoTabUV.view.layoutIfNeeded()
            })
           
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
        
        if(scrollView.contentOffset.y == 0){
            self.providerInfoTabUV.view.layoutIfNeeded()
            self.providerInfoTabUV.topProfileViewHeight.constant = 100
            UIView.animate(withDuration: 0.2, animations: {
                self.providerInfoTabUV.view.layoutIfNeeded()
            })
        }
    }
    
    
    func loadProviderServices(){
        
        if(self.loaderView != nil){
            self.loaderView.removeFromSuperview()
        }
        
        loaderView =  self.generalFunc.addMDloader(contentView: self.contentView)
        
        //loaderView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        loaderView.backgroundColor = UIColor.clear
        if self.eForVideoConsultation.uppercased() == "YES"{
            self.eForVideoConsultation = "Yes"
        }
        let parameters = ["type":"getDriverServiceCategories", "iDriverId": providerInfo.get("driver_id"), "SelectedCabType": Utils.cabGeneralType_UberX, "parentId": self.ufxSelectedVehicleTypeParentId, "SelectedVehicleTypeId": self.ufxSelectedVehicleTypeId, "iMemberId": GeneralFunctions.getMemberd(), "vSelectedLatitude":ufxSelectedLatitude, "vSelectedLongitude":ufxSelectedLongitude,"vSelectedAddress":ufxSelectedAddress, "eForVideoConsultation": self.eForVideoConsultation]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    self.dataArray = msgArr as! [NSDictionary]
                    
                    if(self.eForVideoConsultation.uppercased() == "YES" && self.dataArray.count > 0){
                        
                        self.providerInfoTabUV.videoConsultantPriceTxt = self.dataArray[0].get("eVideoConsultServiceCharge")
                        
                        self.providerInfoTabUV.viewProfileBtn.text = self.dataArray[0].get("eVideoConsultServiceCharge")
                        self.providerInfoTabUV.viewProfileBtn.borderColor = .clear
                        self.providerInfoTabUV.viewProfileBtn.isHidden = false
                        self.providerInfoTabUV.viewProfileBtn.layer.borderWidth = 0.5
                        self.providerInfoTabUV.viewProfileBtn.layer.borderColor = UIColor.white.cgColor
                        
                        self.providerInfoTabUV.setBottomViewForVideo()
                        self.providerInfoTabUV.cartView.handleClick(clickHandler: { (instance) in
                            
                            if(self.dataArray.count > 0){
                                let itemDict = self.dataArray[0].arrOf("SubCategories")[0] as! NSDictionary
                                self.continueCartScreen(true, itemDict)
                            }
                            
                            
                        })
                    }
                    self.tableView.reloadData()
                  
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
                if(self.loaderView != nil){
                    
                    self.loaderView.isHidden = true
                    self.loaderView.removeFromSuperview()
                }
                
            }else{
                
                if(self.loaderView != nil){
                    
                    self.loaderView.isHidden = true
                    self.loaderView.removeFromSuperview()
                }
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    self.loadProviderServices()
                })
                
            }
        
            if(self.dataArray.count == 0){
                self.noserviceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_DATA_AVAIL")
                self.noserviceLbl.isHidden = false
            }else{
                self.noserviceLbl.isHidden = true
            }
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].arrOf("SubCategories").count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 5, y:0, width: self.tableView.frame.width, height: 50))
        view.backgroundColor =  SColors.ThemeTxt//UIColor(hex: 0xF1F1F1)
        let label = UILabel.init(frame: CGRect(x: 15, y:5, width: view.frame.width - 40, height: 50))
        label.font = UIFont(name: Fonts().semibold, size: 16)!
        label.text = self.dataArray[section].get("vCategory")
        label.textColor = UIColor.black
        view.addSubview(label)
        return view
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProviderServicesTVCell", for: indexPath) as! UFXProviderServicesTVCell
        
        cell.selectionStyle = .none
        let itemDict = self.dataArray[indexPath.section].arrOf("SubCategories")[indexPath.row] as! NSDictionary
        cell.serviceTitle.text = itemDict.get("vVehicleType")

        if self.dataArray[indexPath.section].arrOf("SubCategories").count != 1 {
            if indexPath.row == 0 {
                cell.newContainerView.roundCorners(corners: [.topRight, .topLeft],amount: 10)
            }else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.newContainerView.roundCorners(corners: [.bottomRight, .bottomLeft],amount: 10)
            }else{
                cell.newContainerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 00)
            }
        }else{
            cell.newContainerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 10)
        }
        cell.containerView.clipsToBounds = true
        cell.containerView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        cell.containerView.layer.roundCorners(radius: 10)
        
        //cell.highLightView.backgroundColor = SColors.Theme
        

        if(GeneralFunctions.parseDouble(origValue: 0, data: itemDict.get("vRating")) <= 0){
            cell.ratingView.isHidden = true
            cell.ratingViewWidth.constant = 0
        }else{
            cell.ratingView.isHidden = false
            cell.ratingViewWidth.constant = 45
            cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: itemDict.get("vRating"))
        }
        
        cell.discriptionLbl.textColor = UIColor(hex: 0x000000)
        if eForVideoConsultation.uppercased() == "YES" {
            cell.discriptionLbl.setHTML(text: itemDict.get("vCategoryDesc"))
           
            cell.discriptionLbl.numberOfLines = 0
        }else{
              
           // cell.discriptionLbl.setHTML(text: itemDict.get("vCategoryShortDesc"))
            cell.discriptionLbl.text =  itemDict.get("vCategoryShortDesc")
            cell.discriptionLbl.numberOfLines = 2
        }
        
        let eFareType = itemDict.get("eFareType")
       // cell.servicePriceLbl.textColor = SColors.Theme

        if(eFareType == "Fixed"){
            
            cell.servicePriceLbl.text = "\(itemDict.get("fFixedFare"))    "
            
            cell.servicePriceLbl.text = "\(itemDict.get("vSymbol"))\(Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.0, data: itemDict.get("fFixedFare_value")))))    "
            
            cell.servicePriceLbl.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.0, data: itemDict.get("fFixedFare_value"))), addCurrncy: true, currencySymbol: itemDict.get("vSymbol"))
            
            let formattedString = NSMutableAttributedString()
            formattedString.bold(cell.servicePriceLbl.text!)
            cell.servicePriceLbl.attributedText = formattedString
            
        }else if(eFareType == "Hourly"){
            //            eAllowQty = "No"
            cell.servicePriceLbl.text = "\(itemDict.get("fPricePerHour"))/\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR"))    "
            
            cell.servicePriceLbl.text = "\(GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.0, data: itemDict.get("fPricePerHour_value"))), addCurrncy: true, currencySymbol: itemDict.get("vSymbol")))/\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR"))" + "\n" + "(" + "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINIMUM")) " + itemDict.get("fMinHour") + " " + "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOURS_TXT")))"
            
    
            let formattedString = NSMutableAttributedString()
            formattedString.bold("\(GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.0, data: itemDict.get("fPricePerHour_value"))), addCurrncy: true, currencySymbol: itemDict.get("vSymbol")))/", fontSize: 16, textColor: UIColor.black)
            formattedString.medium(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOUR"), fontSize: 14, textColor: UIColor.gray)
            formattedString.medium("\n" + "(" + "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINIMUM")) " + itemDict.get("fMinHour") + " " + "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOURS_TXT"))" + ")", fontSize: 12, textColor: UIColor.gray)
            cell.servicePriceLbl.attributedText = formattedString
            
            
        }else{
            cell.servicePriceLbl.text = ""
        }
        
        cell.bookBtnView.isHidden = false
    
        cell.bookBtnLbl.textColor = SColors.ThemeTxt
        cell.bookBtnLbl.backgroundColor = SColors.Theme
        
        cell.bookBtnLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BOOK_SERVICE")

        cell.bookBtnView.backgroundColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView:cell.bookBtnImgView, color: SColors.ThemeTxt)
        
        if(Configurations.isRTLMode() == true){
            cell.bookBtnImgView.image = UIImage(named: "ic_btn_rightarrow")?.rotate(180)
            GeneralFunctions.setImgTintColor(imgView: cell.bookBtnImgView, color: SColors.ThemeTxt)
        }else{
            cell.bookBtnImgView.image = UIImage(named: "ic_btn_rightarrow")
            GeneralFunctions.setImgTintColor(imgView: cell.bookBtnImgView, color: SColors.ThemeTxt)
        }
       
        let itemExist = isItemExist(itemDict)
        if(itemExist){
            cell.bookBtnLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_SERVICE")
            cell.bookBtnLbl.backgroundColor = SColors.Red
            cell.bookBtnView.backgroundColor = SColors.Red
        }else{
            cell.bookBtnView.backgroundColor = SColors.Theme
            cell.bookBtnLbl.backgroundColor = SColors.Theme
        }
        
//        if(Configurations.isRTLMode() == true){
//            cell.bookBtnView.roundTo(corners: [.bottomRight, .topRight], radius: 4)
//        }else{
//            cell.bookBtnView.roundTo(corners: [.bottomLeft, .topLeft], radius: 4)
//        }
        
        cell.bookBtnView.handleClick { (instance) in
            if(itemExist){
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_SERVICE_NOTE"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedId) in
                    if(btnClickedId == 0){
                        self.removeItemFromCart(itemDict)
                    }
                })
                return
            }
            self.continueCartScreen(true, itemDict)
        }
        cell.servicePriceLbl.textColor = SColors.Theme
        if(self.eForVideoConsultation.uppercased() == "YES"){
            
            //cell.serviceTitle.text = ""
            cell.serviceTitle.isHidden = false
            cell.servicePriceLbl.isHidden = true
            //cell.highLightView.isHidden = true
            cell.bookBtnView.isHidden = true
            cell.desLblTop.constant = -2
            //cell.servicePriceHight.constant = 0
        }else{
            
            cell.serviceTitle.isHidden = false
            cell.servicePriceLbl.isHidden = false
            //cell.highLightView.isHidden = false
            cell.bookBtnView.isHidden = false
            cell.desLblTop.constant = 10
            //cell.servicePriceHight.constant = 55
        }
        //cell.highLightView.isHidden = true
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.eForVideoConsultation.uppercased() != "YES"){
            let selectedIndexDic = self.dataArray[indexPath.section].arrOf("SubCategories")[indexPath.row] as! NSDictionary
            
            continueCartScreen(false, selectedIndexDic)
        }
        
        
        //self.present(navController, animated: true, completion: nil)
    }
    
    func removeItemFromCart(_ dataDict:NSDictionary){
        var selectedItemIdIndex = -1
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
                
                for i in 0..<array.count{
                    let dataDicArray_tmp = array[i] as NSDictionary
                    
                    if(dataDicArray_tmp.dictOf("vehicleData").get("iVehicleTypeId") == dataDict.get("iVehicleTypeId")){
                        selectedItemIdIndex = i
                    }
                }
            }
        }
        
        if(selectedItemIdIndex != -1){
            var array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            array.remove(at: selectedItemIdIndex)
            GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
        }
        
        self.tableView.reloadData()
        
        if(self.parent != nil && (self.parent as? UFXProviderInfoTabUV) != nil){
            (self.parent as? UFXProviderInfoTabUV)!.setupCartView()
        }
    }
    
    func isItemExist(_ dataDict:NSDictionary) -> Bool{
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
                
                for i in 0..<array.count{
                    let dataDicArray_tmp = array[i] as NSDictionary
                    
                    if(dataDicArray_tmp.dictOf("vehicleData").get("iVehicleTypeId") == dataDict.get("iVehicleTypeId")){
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func continueCartScreen(_ isFromBookBtn:Bool, _ dataDict:NSDictionary){
        if(self.checkCartValidation(newCartData: dataDict) == false){
            return
        }
        
        let ufxcartUV = GeneralFunctions.instantiateViewController(pageName: "UFXCartUV") as! UFXCartUV
        ufxcartUV.dataDic = dataDict
        ufxcartUV.eForVideoConsultation = self.eForVideoConsultation
        ufxcartUV.driverId = providerInfo.get("driver_id")
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
                
                for i in 0..<array.count{
                    let dataDicArray_tmp = array[i] as NSDictionary
                    
                    if(dataDicArray_tmp.dictOf("vehicleData").get("iVehicleTypeId") == dataDict.get("iVehicleTypeId")){
                        ufxcartUV.isFromEdit = true
                        ufxcartUV.dataDic = dataDict
                        ufxcartUV.selectdIndex = i
                    }
                }
                
            }
        }
        Application.window!.rootViewController?.push(uv: ufxcartUV, isDirect: true)
        //self.push(uv: ufxcartUV)
    }
    
    func checkCartValidation(newCartData:NSDictionary) -> Bool{
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
                
                let dataDicArray = array[0] as NSDictionary
                let vehicleData = dataDicArray.dictOf("vehicleData")
                
                if(newCartData.dictOf("vehicleData").get("iVehicleTypeId") == vehicleData.get("iVehicleTypeId")){
                    return true
                }
                
                if (vehicleData.get("eFareType") == "Hourly" || (vehicleData.get("eFareType") == "Regular")){
                    
                    if(vehicleData.get("eFareType") == "Hourly"){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTRICT_HOURLY_SERVICE"), uv: self)
                    }
                    
                    if (vehicleData.get("eFareType") == "Regular"){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTRICT_REGULAR_SERVICE"), uv: self)
                    }
                    
                    return false
                    
                }else if(vehicleData.get("eFareType") == "Fixed" && newCartData.dictOf("vehicleData").get("eFareType") != "Fixed"){
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTRICT_FIXED_SERVICE"), uv: self)
                    
                    return false
                }
            }
        }
        return true
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let itemDict = self.dataArray[indexPath.section].arrOf("SubCategories")[indexPath.row] as! NSDictionary
//        if(self.eForVideoConsultation.uppercased() == "YES"){
//            if(itemDict.get("vCategoryDesc") == ""){
//                return itemDict.get("vCategoryDesc").height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont.init(name: Fonts().regular, size: 14)!) + 50
//            }else{
//                return itemDict.get("vCategoryDesc").height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont.init(name: Fonts().regular, size: 14)!) + 50
//            }
//        }
//
//        if(itemDict.get("vCategoryDesc") == ""){
//            return 140
//        }else{
//            return 180
//        }
//
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
        let itemDict = self.dataArray[indexPath.section].arrOf("SubCategories")[indexPath.row] as! NSDictionary
        if(self.eForVideoConsultation.uppercased() == "YES"){
            if(itemDict.get("vCategoryDesc") == ""){
                
                return  50
            }else{
                return itemDict.get("vCategoryDesc").height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont.init(name: Fonts().regular, size: 14)!) + 70
            }
        }
        
        if(itemDict.get("vCategoryShortDesc") == ""){
            return 120
        }else{
            return 180
        }
        
                
                
            }
   
   

}
