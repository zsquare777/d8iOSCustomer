
import UIKit
import SysBaseLib

protocol DataSendToDedliveryDelegate {
    
    func sendData()
   
  
}
class CountryListUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ParentViewUVDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var serachTitleLbl: MyLabel!
    
    @IBOutlet weak var titleLblTrailingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeIMGView: UIImageView!
    var dataSendToDedliveryDelegate:DataSendToDedliveryDelegate?
    var multidelDetials : MultiDeliveryDetailsUV!
    var rentSendInquiryUv : RentSendInquiryUv!
    var publsihRideUV : PublishRideUV!
    var emergencyContactUv : EmergencyContactsUV!
    var fromLogIn:Bool = false
    var fromRegister:Bool = false
    var fromVerifyProfile:Bool = false
    var fromEditProfile = false
    var fromAccountInfo = false
    var fromEmergenContact = false
    var fromAccountVerification = false
    var fromForgetPassword = false
    var fromTrackAny = false
    var fromdeliveryDetails:Bool = false
    var fromSendGift:Bool = false
    var fromSendQury = false
    
     var loader_IV:UIActivityIndicatorView?
    var selectedCountryHolder:countryHolder?
    
    var countryHolder_arr = [countryHolder()]
    
    var myCountryDict: [Int: [countryHolder]] = [Int: [countryHolder]]()
    
    let generalFunc = GeneralFunctions()
    
    var isSafeAreaSet = false
    
    var cntView:UIView!
    var sectionTitleIndexes = NSMutableArray()
    
    var countryListArr:NSArray!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "CountryListScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)

            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.allowsSelection = true
    //        self.tableView.register(CountryListTVCell.self, forCellReuseIdentifier: "CountryListTVCell")
            self.tableView.register(UINib(nibName: "CountryListTVCell", bundle: nil), forCellReuseIdentifier: "CountryListTVCell")
            self.tableView.register(UINib(nibName: "CountryListHeaderTVCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "CountryListHeaderTVCell")
            self.tableView.bounces = false
            
            self.setDefaultNavBar()
            
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
            
            loader_IV = self.addIndicator()
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            setData()
            
            if(self.countryListArr == nil){
                loadCountry()
            }else{
                if(countryListArr.count == 0){
                    _ = GeneralFunctions.addMsgLbl(contentView: self.view, msg: self.generalFunc.getLanguageLabel(origValue: "", key: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_COUNTRY_AVAIL")))
                    loader_IV?.removeFromSuperview()
                    return
                }

                setAllCountries()
                setCountryData()
            }
            
            self.closeIMGView.handleClick { (instance) in
                self.close()
            }
            
            
            view.isOpaque = false
            
    //        self.view.handleClick { (instance) in
    //            self.close()
    //        }
            
        }else if(type == 1){
            
            UIView.animate(withDuration: 0.75, delay: 0.0, options:[], animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            }, completion: nil)
            
            self.configRTL()
            
        }else if(type == 3){
            UIView.animate(withDuration: 0.1, delay: 0.0, options:[], animations: {
                self.view.backgroundColor = UIColor.clear
            }, completion: nil)
            self.hideKeyboard()
        }
    }
    
   
    
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            
            cntView.frame.size.height = cntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
            isSafeAreaSet = true
        }
    }
    
    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CONTRY")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CONTRY")
        
        self.serachTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_CONTRY")
         if #available(iOS 13, *) {
            //searchBar.searchTextField.backgroundColor = UIColor.gray
            
         }else{
            if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
                searchField.backgroundColor = UIColor(hex: 0xF1F1F1)
                
            }
         }
        self.searchBar.returnKeyType = .done
        self.searchBar.sizeToFit()
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.delegate = self
        self.searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "Search Country", key: "LBL_SEARCH_COUNTRY")
        self.navigationItem.titleView = self.searchBar
    
        closeIMGView.image = UIImage(named:"cm_close_white")!.addImagePadding(x: 12, y: 12)
        closeView.isUserInteractionEnabled = true
       // closeView.addGestureRecognizer(closeImgTapGue)
        
        GeneralFunctions.setImgTintColor(imgView: closeIMGView, color: UIColor.black)
        
//
//        self.searchBar.becomeFirstResponder()
    }
    
    func setDefaultNavBar(){
        self.addBack()
        //let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.searchTapped))
       // self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.titleView = nil
        
        setData()
        
        self.hideKeyboard()
    }

//    @objc func searchTapped(){
//        if(countryListArr == nil || (countryListArr != nil && countryListArr.count == 0)){
//            return
//        }
//        UIView.animate(withDuration: 0.5, animations: {
//
//
//
//        })
//    }
    
    
  
    @objc func keyboardWillDisappear(sender: NSNotification){
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
    }
    
    @objc func keyboardWillAppear(sender: NSNotification){
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardSize, right: 0)
    }
    
    
    func loadCountry(){
//        countryList
        
        let parameters = ["type":"countryList"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let countryListArr = dataDict.arrOf("CountryList")
                    self.countryListArr = countryListArr
                    
                    
                    if(self.countryListArr.count == 0){
                        _ = GeneralFunctions.addMsgLbl(contentView: self.view, msg: self.generalFunc.getLanguageLabel(origValue: "", key: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_COUNTRY_AVAIL")))
                        self.loader_IV?.removeFromSuperview()
                        return
                    }
                    
                    self.setAllCountries()
                    
                    self.setCountryData()
                   
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        self.close()
                    })
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    self.close()
                })
            }
        })
    }
    
    func setAllCountries(){
        self.countryHolder_arr.removeAll()
        for i in 0  ..< countryListArr.count {
            let dict = countryListArr[i] as! NSDictionary
            _ = dict.get("key")
            let totCount = dict.get("TotalCount")
            
            let subListArr = dict.arrOf("List")
            
            for j in 0  ..< subListArr.count {
                let subDict = subListArr[j] as! NSDictionary
                let vCountry = subDict.get("vCountry")
                let vPhoneCode = subDict.get("vPhoneCode")
                _ = subDict.get("iCountryId")
                let vCountryCode = subDict.get("vCountryCode")
                let vSImage = subDict.get("vSImage")
                let vRImage = subDict.get("vRImage")
                
                let countryHolderObj:countryHolder = countryHolder()
                countryHolderObj.vPhoneCode = vPhoneCode
                countryHolderObj.countryName = vCountry
                countryHolderObj.vCountryCode = vCountryCode
                countryHolderObj.totalItems = totCount
                countryHolderObj.vSImage = vSImage
                countryHolderObj.vRImage = vRImage
                
                //                            self.countryHolder_arr += [countryHolderObj]
                self.countryHolder_arr.append(countryHolderObj)
            }
        }
    }
    
    func setCountryData(){
        
        self.countryHolder_arr.sort { $0.countryName.lowercased()  < $1.countryName.lowercased() }
        
        var i = 0, j = 0;
        for val in UnicodeScalar("A").value...UnicodeScalar("Z").value
        {
            let x = String(describing: UnicodeScalar(val));
            
            var cList = [countryHolder]() as Array
            
            for i in 0 ..< self.countryHolder_arr.count {
                
                let countryTitle:NSString = self.countryHolder_arr[i].countryName as NSString
                let first = String(describing: UnicodeScalar(countryTitle.character(at: 0)))
                
                if(x.lowercased() == first.lowercased()){
                    cList.append(self.countryHolder_arr[i])
                }
            }
            
            if cList.count != 0
            {
                self.myCountryDict[i] = cList
                i += 1
                self.sectionTitleIndexes.add(j)
            }
            j += 1
            
        }
        
        self.tableView.allowsSelection = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        self.loader_IV?.removeFromSuperview()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myCountryDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCountryDict[section]!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTVCell", for: indexPath) as! CountryListTVCell
        
        let country_holderObj = myCountryDict[indexPath.section]![indexPath.row]
        
        cell.countryLabelTxt.text = country_holderObj.countryName
        cell.countryCodeLbl.text = "+" + Configurations.convertNumToAppLocal(numStr: country_holderObj.vPhoneCode)
        cell.countryCodeLbl.textColor = UIColor.black.light(by: 10)
        cell.countryLabelTxt.removeGestureRecognizer(cell.countryLabelTxt.tapGue)
        
        cell.countryImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:country_holderObj.vSImage, width: Utils.getValueInPixel(value: 20), height: Utils.getValueInPixel(value: 13))), placeholderImage:nil)
        
        if(Configurations.isRTLMode()){
            cell.countryCodeLbl.textAlignment = .left
        }else{
            cell.countryCodeLbl.textAlignment = .right
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCountryHolder = myCountryDict[indexPath.section]![indexPath.row]
        
        self.setDefaultNavBar()
        
        if(fromRegister == true){
            performSegue(withIdentifier: "unwindToSignUp", sender: self)
        }else if(fromVerifyProfile == true){
            performSegue(withIdentifier: "setCountryToVFbUnWind", sender: self)
        }else if(fromEditProfile == true){
            performSegue(withIdentifier: "unwindToEditProfile", sender: self)
        }else if(fromAccountInfo == true){
            performSegue(withIdentifier: "unwindToAccountInfo", sender: self)
        }else if(fromAccountVerification == true){
            performSegue(withIdentifier: "unwindToAccountVerification", sender: self)
        }else if(fromLogIn){
            performSegue(withIdentifier: "unwindToSignIn", sender: self)
        }else if(fromForgetPassword){
            performSegue(withIdentifier: "unwindToForgetPassword", sender: self)
        }else if(fromTrackAny){
            performSegue(withIdentifier: "unwindTrackAnySignUp", sender: self)
        }else if(fromSendGift){
            performSegue(withIdentifier: "unwindToSendGift", sender: self)
        }else if (fromSendQury){
            rentSendInquiryUv.selectedCountryCode = self.selectedCountryHolder!.vCountryCode
            rentSendInquiryUv.selectedPhoneCode = self.selectedCountryHolder!.vPhoneCode
            rentSendInquiryUv.cuntryUrl = self.selectedCountryHolder!.vSImage
            rentSendInquiryUv.setCountry()
            self.close()
        }
        else if (publsihRideUV != nil){
            publsihRideUV.selectedCountryCode = self.selectedCountryHolder!.vCountryCode
            publsihRideUV.selectedPhoneCode = self.selectedCountryHolder!.vPhoneCode
            publsihRideUV.cuntryUrl = self.selectedCountryHolder!.vSImage
            publsihRideUV.setCountry()
            self.close()
        }
        
        else if fromdeliveryDetails{
           
            
            multidelDetials.selectedCountryCode = self.selectedCountryHolder!.vCountryCode
            multidelDetials.selectedPhoneCode = self.selectedCountryHolder!.vPhoneCode
            multidelDetials.countryImageurl = self.selectedCountryHolder!.vSImage
            multidelDetials.isFromCountrySelction = true
            self.dataSendToDedliveryDelegate?.sendData()
           
            
          
            self.close()
        }else if fromEmergenContact {
            emergencyContactUv.selectedCountryCode = self.selectedCountryHolder!.vCountryCode
            emergencyContactUv.selectedPhoneCode = self.selectedCountryHolder!.vPhoneCode
            emergencyContactUv.countryImageurl = self.selectedCountryHolder!.vRImage
            emergencyContactUv.isFromCountrySelction = true
            self.emergencyContactUv.sendData()
           
            
          
            self.close()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Here, we use NSFetchedResultsController
        // And we simply use the section name as title
      
        var indexTitle = ""
        var i = 0;
        for val in UnicodeScalar("A").value...UnicodeScalar("Z").value
        {
            if self.sectionTitleIndexes[section] as! Int == i
            {
                indexTitle = String(describing: UnicodeScalar(val)!)
            }
            i += 1
        }

        
        // Dequeue with the reuse identifier
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "CountryListHeaderTVCell") as! CountryListHeaderTVCell
        
        cell.titleLbl.text = indexTitle
        
       // cell.backgroundColor = UIColor(hex: 0xf1f1f1)//SColors.Theme
        cell.titleLbl.backgroundColor = UIColor.white//UIColor(hex: 0xf1f1f1)
        cell.titleLbl.textColor = UIColor.black
        
 //       cell.subTitleLbl.backgroundColor = SColors.Theme
//        cell.subTitleLbl.textColor = SColors.ThemeTxt
//        cell.subTitleLbl.text = "\(myCountryDict[section]!.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return String(describing: UnicodeScalar(65 + section)!)
        var indexTitle = ""
        var i = 0;
        for val in UnicodeScalar("A").value...UnicodeScalar("Z").value
        {
             if self.sectionTitleIndexes[section] as! Int == i
            {
                indexTitle = String(describing: UnicodeScalar(val)!)
            }
            i += 1
        }
        
        return indexTitle
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String,
                            at index: Int) -> Int{
        return index
    }
    
    /* section index titles displayed to the right of the `UITableView` */
     func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var indexTitle = [String()]
        indexTitle.removeAll()
        var i = 0;
        for val in UnicodeScalar("A").value...UnicodeScalar("Z").value
        {
            if self.sectionTitleIndexes.contains(i)
            {
                let x = String(describing: UnicodeScalar(val)!)
                indexTitle.append(x)
            }
            
            i += 1
        }
//        indexTitle
        return []
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        Utils.printLog(msgData: "EndEditing")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchQuery = searchText.trim()
        let tempString = searchQuery.replacingOccurrences(of: "+", with: "")
        searchQuery = tempString
        
        self.countryHolder_arr.removeAll()
        self.myCountryDict.removeAll()
        self.sectionTitleIndexes.removeAllObjects()
        
        if(searchQuery == ""){
            self.setAllCountries()
        }else{
            if countryListArr != nil {
            for i in 0..<countryListArr.count{
                let dict = countryListArr[i] as! NSDictionary
                _ = dict.get("key")
                let totCount = dict.get("TotalCount")
                
                let subListArr = dict.arrOf("List")
                
                for j in 0  ..< subListArr.count {
                    let subDict = subListArr[j] as! NSDictionary
                    let vCountry = subDict.get("vCountry")
                    let vPhoneCode = subDict.get("vPhoneCode")
                    _ = subDict.get("iCountryId")
                    let vCountryCode = subDict.get("vCountryCode")
                    let vSImage = subDict.get("vSImage")
                    let vRImage = subDict.get("vRImage")
                    
                    if(vCountry.uppercased().starts(with: searchQuery.uppercased()) || vPhoneCode.uppercased().starts(with: searchQuery.uppercased())){
                        let countryHolderObj:countryHolder = countryHolder()
                        countryHolderObj.vPhoneCode = vPhoneCode
                        countryHolderObj.countryName = vCountry
                        countryHolderObj.vCountryCode = vCountryCode
                        countryHolderObj.totalItems = totCount
                        countryHolderObj.vSImage = vSImage
                        countryHolderObj.vRImage = vRImage
                        
                        //                            self.countryHolder_arr += [countryHolderObj]
                        self.countryHolder_arr.append(countryHolderObj)
                    }
                    
                }
            }
            }
        }
        
        self.setCountryData()
    }
}

class countryHolder  {
    var countryName: String = String()
    var vPhoneCode: String = String()
    var vCountryCode: String = String()
    var totalItems: String = String()
    var vSImage: String = String()
    var vRImage: String = String()
}


