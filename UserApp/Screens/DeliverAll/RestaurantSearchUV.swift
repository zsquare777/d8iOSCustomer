

import UIKit
import CoreLocation
import WebKit
import SysBaseLib

class RestaurantSearchUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate, IndicatorInfoProvider, ParentViewUVDelegate {
    
    @IBOutlet weak var noSearchImgView: UIImageView!
    @IBOutlet weak var noRecordLbl: UILabel!

    @IBOutlet weak var contentView: UIView!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var searchBar:UISearchBar!
    var currentLocation:CLLocation!
    var selectedAddress = ""
    var cusineArray = [NSDictionary]()
    var restaurantsArray = [NSDictionary]()
    var itemsArray = [NSDictionary]()
    var sectionCount = 1
    var sectionTitleArray = [String]()
    var viewFirstLaunch = true
    var userProfileJson:NSDictionary!
    var isRestaurantClose = false
    var whoDetailView:WhoDetailView!
    
    var tableView:UITableView!
    var itemSearchTabBar:ItemSearchTabUV!
    var vTtype = ""
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        if(vTtype == "RestaurantSearchV"){
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_TXT"))
        }else if(vTtype == "CusineSearchUV"){
            let strCusines = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUISINES").capitalizingFirstLetter()
            return IndicatorInfo(title: strCusines)
        }else{
            
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MENU_TITLE"))
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            
            cntView = self.generalFunc.loadView(nibName: "RestaurantSearchScreenDesign", uv: self, contentView: contentView) //,
            self.contentView.addSubview(cntView)
            self.navigationItem.setHidesBackButton(true, animated:false)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.tableView = UITableView.init(frame: self.cntView.bounds)
            self.tableView.backgroundColor = UIColor.clear
            self.cntView.addSubview(tableView)
            self.tableView.separatorStyle = .none
            self.tableView.delegate = self
            self.tableView.bounces = false
            self.tableView.dataSource = self
            
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            if(vTtype == "RestaurantSearchV"){
                self.tableView.register(UINib(nibName: "RestaurantsListCell", bundle: nil), forCellReuseIdentifier: "RestaurantsListCell")
            }else if(vTtype == "CusineSearchUV"){
                
                self.tableView.register(UINib(nibName: "CusineTVCell", bundle: nil), forCellReuseIdentifier: "CusineTVCell")
            }else{
                self.tableView.register(UINib(nibName: "RestaurantDetailItemTVCell", bundle: nil), forCellReuseIdentifier: "RestaurantDetailItemTVCell")
            }
            
            tableView.separatorStyle = .none
            self.tableView.isHidden = true
            self.noRecordLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_RESULT")
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
            
            GeneralFunctions.setImgTintColor(imgView: noSearchImgView, color: SColors.Theme)
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            if(viewFirstLaunch){
                
                self.tableView.frame.size = CGSize(width: Application.screenSize.width, height: self.view.frame.height)
                self.tableView.layoutIfNeeded()
                
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
                let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: GeneralFunctions.getSafeAreaInsets().bottom))
                customView.backgroundColor = UIColor.clear
                self.tableView.tableFooterView = customView
                
                self.viewFirstLaunch = false
            }else{
                if(vTtype == "RestaurantSearchV"){
                   if(self.restaurantsArray.count == 0){
                       self.noRecordLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_RESULT")
                   }
                }else if(vTtype == "CusineSearchUV"){
                    if(self.cusineArray.count == 0){
                        self.noRecordLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_RESULT")
                    }
                    
                }else{
                   if(self.itemsArray.count == 0){
                       self.noRecordLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_RESULT")
                   }
                  
                }
            }
            
            if(vTtype == "RestaurantSearchV"){
                self.restaurantsArray = itemSearchTabBar.restaurantsArray
            }else if(vTtype == "CusineSearchUV"){
                self.cusineArray = itemSearchTabBar.cusineArray
            }else{
                self.itemsArray = itemSearchTabBar.itemsArray
            }
            
            self.tableView.reloadData()
        }
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //* Tableview Methods for Main Restaurants List View & FilterView
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if(vTtype == "RestaurantSearchV"){
            return 1
        }else if(vTtype == "CusineSearchUV"){
           
            return 1
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if(vTtype == "RestaurantSearchV"){
            return ""
        }else if(vTtype == "CusineSearchUV"){
            return ""
        }else{
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(vTtype == "RestaurantSearchV"){
            if(self.restaurantsArray.count == 0){
                
                if(itemSearchTabBar.serachStarted == true){
                    self.noRecordLbl.isHidden = false
                }else{
                    self.noRecordLbl.isHidden = true
                }
                
                self.noSearchImgView.isHidden = false
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false
                self.noRecordLbl.isHidden = true
                self.noSearchImgView.isHidden = true
            }
            return self.restaurantsArray.count
        }else if(vTtype == "CusineSearchUV"){
            if(self.cusineArray.count == 0){
                if(itemSearchTabBar.serachStarted == true){
                    self.noRecordLbl.isHidden = false
                }else{
                    self.noRecordLbl.isHidden = true
                }
                self.noSearchImgView.isHidden = false
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false
                self.noRecordLbl.isHidden = true
                self.noSearchImgView.isHidden = true
            }
            return self.cusineArray.count
        }else{
           if(self.itemsArray.count == 0){
               if(itemSearchTabBar.serachStarted == true){
                   self.noRecordLbl.isHidden = false
               }else{
                   self.noRecordLbl.isHidden = true
               }
               self.noSearchImgView.isHidden = false
               self.tableView.isHidden = true
           }else{
               self.tableView.isHidden = false
               self.noRecordLbl.isHidden = true
               self.noSearchImgView.isHidden = true
           }
            return self.itemsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(vTtype == "RestaurantSearchV"){
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantsListCell") as! RestaurantsListCell
//
//             cell.selectionStyle = UITableViewCell.SelectionStyle.none
//
//             cell.ratingView.backgroundColor = SColors.Theme
//             GeneralFunctions.setImgTintColor(imgView: cell.ratingImgView, color: .white)
//
//             GeneralFunctions.setImgTintColor(imgView: cell.timeImgView, color: SColors.Theme)
//
//             Utils.createRoundedView(view: cell.containerView, borderColor: .clear, borderWidth: 0, cornerRadius: 15)
//            cell.ratingView.roundTo(corners: [.bottomRight, .topLeft], radius: 12)
//            cell.detailsView.roundTo(corners: [.bottomRight, .bottomLeft], radius: 12)
//            cell.restImgView.roundTo(corners: [.bottomLeft], radius: 12)
//
//             cell.offerImgView.image = UIImage.init(named: "ic_offer_dis")
//             GeneralFunctions.setImgTintColor(imgView: cell.offerImgView, color: .white)
//
//             cell.closedLbl.textColor = SColors.maroon
//
//
//             let item = self.restaurantsArray[indexPath.row]
//
//             if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
//
//                 cell.whoViewHeight.constant = 20
//                 cell.whoView.isHidden = false
//                 cell.whoImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("Restaurant_Safety_Icon"), width: Utils.getValueInPixel(value: 20), height: Utils.getValueInPixel(value: 20))), placeholderImage:UIImage(named:"ic_no_icon"))
//                 cell.whoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAFETY_NOTE_TITLE_LIST")
//
//                 cell.whoView.handleClick { (instance) in
//                    //self.view.resignFirstResponder()
//                    self.itemSearchTabBar.searchBar.endEditing(true)
//
//                    self.whoDetailView = WhoDetailView(frame: CGRect(x:0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
//                     self.whoDetailView.webView.navigationDelegate = self
//                     self.whoDetailView.webView.load(URLRequest(url: URL(string: item.get("Restaurant_Safety_URL") + "&fromapp=yes")!))
//                     Application.window!.addSubview(self.whoDetailView)
//
//                     DispatchQueue.main.async {
//                         self.whoDetailView.activityIndicator.startAnimating()
//                     }
//                 }
//
//             }else{
//                 //cell.whoViewHeight.constant = 0
//                 //cell.whoView.isHidden = true
//             }
//
//             /* FAV STORES CHANGES*/
//             if(userProfileJson.get("ENABLE_FAVORITE_STORE_MODULE").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
//
//                 if(item.get("eFavStore").uppercased() == "YES"){
//
//                     cell.favIconImgView.isHidden = false
//                 }else{
//                     cell.favIconImgView.isHidden = true
//                 }
//             }else{
//                 cell.favIconImgView.isHidden = true
//             }
//
//             if item.get("restaurantstatus").uppercased() == "OPEN"
//             {
//                 cell.closeLblHeight.constant = 0
//                 cell.closedLbl.isHidden = true
//
//             }else{
//
//                 cell.closeLblHeight.constant = 21
//                 cell.closedLbl.isHidden = false
//
//                 if item.get("Restaurant_Opentime") != ""
//                 {
//                     cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT") + " " + Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_Opentime"))
//                 }else
//                 {
//                     cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
//                 }
//
//                 if item.get("timeslotavailable") == "Yes"
//                 {
//                     cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_ACCEPT_ORDERS_TXT")
//                 }
//
//             }
//
//             //cell.perPersonPriceLbl.textColor = SColors.Theme
//             cell.timeInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIME")
//             cell.minOrderLbl.text = self.generalFunc.getLanguageLabel(origValue: "Min order", key: "LBL_MIN_ORDER_TXT")
//
//             let sizeValue = Utils.getValueInPixel(value: 150)
//             cell.restImgView.sd_setShowActivityIndicatorView(true)
//             cell.restImgView.sd_setIndicatorStyle(.gray)
//             cell.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: sizeValue, height: sizeValue)), placeholderImage:UIImage(named:"ic_no_icon"))
//             cell.headerLbl.text = item.get("vCompany")
//             cell.subHeaderLbl.text = item.get("Restaurant_Cuisine")
//             cell.pricePerPersonLbl.text = item.get("Restaurant_PricePerPerson")
//
//             print(Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig")))
//            // cell.perPersonPriceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig"))
//             cell.timeLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
//
//             //            cell.minOrderLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue"))
//             cell.discountLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OfferMessage"))
//             cell.discountView.backgroundColor = SColors.Theme
//             if (cell.discountLbl.text == "" && item.get("Restaurant_Safety_Status").uppercased() == "NO") {
//                 cell.discountView.isHidden = true
//             }else{
//
//                 if(cell.discountLbl.text == ""){
//                    cell.offerImgView.isHidden = true
//                    cell.discountLblHeight.constant = 10
//                    cell.discountLblTopSpace.constant = 0
//                 }else{
//                    cell.offerImgView.isHidden = false
//                    cell.discountLblHeight.constant = 20
//                    cell.discountLblTopSpace.constant = 20
//                }
//                 cell.discountView.isHidden = false
//
//             }
//
//             if GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("vAvgRating")) > 0.0
//             {
//                 cell.ratingView.isHidden = false
//                 cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("vAvgRating"))
//             }else{
//                 cell.ratingView.isHidden = true
//             }
//
//             return cell
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantsListCell") as! RestaurantsListCell
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            //cell.ratingView.backgroundColor = SColors.Theme
            
            GeneralFunctions.setImgTintColor(imgView: cell.ratingImgView, color: SColors.Theme)
            
            GeneralFunctions.setImgTintColor(imgView: cell.timeImgView, color: SColors.Theme)
            
            Utils.createRoundedView(view: cell.containerView, borderColor: .clear, borderWidth: 0, cornerRadius: 15)
            
           // cell.ratingView.roundTo(corners: [.bottomRight, .topLeft], radius: 12)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                cell.detailsView.roundTo(corners: [.bottomRight, .bottomLeft], radius: 12)
            })
            cell.restImgView.roundTo(corners: [.bottomLeft], radius: 12)

            cell.offerImgView.image = UIImage.init(named: "ic_offer_dis")
            GeneralFunctions.setImgTintColor(imgView: cell.offerImgView, color: UIColor(hex: 0xED2939))
            
            cell.closedLbl.textColor = SColors.maroon
            
            let item = self.restaurantsArray[indexPath.row]

            if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
                
                //cell.whoViewHeight.constant = 20
                //cell.whoView.isHidden = false
                cell.whoImgView.isHidden = false
                cell.whoImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("Restaurant_Safety_Icon"), width: Utils.getValueInPixel(value: 20), height: Utils.getValueInPixel(value: 20))), placeholderImage:UIImage(named:"ic_no_icon"))
                //cell.whoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAFETY_NOTE_TITLE_LIST")
               
                cell.whoImgView.handleClick { (instance) in
                    self.whoDetailView = WhoDetailView(frame: CGRect(x:0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
                    self.whoDetailView.webView.navigationDelegate = self
                    self.whoDetailView.webView.load(URLRequest(url: URL(string: item.get("Restaurant_Safety_URL") + "&fromapp=yes")!))
                    Application.window!.addSubview(self.whoDetailView)
                    
                    DispatchQueue.main.async {
                        self.whoDetailView.activityIndicator.startAnimating()
                    }
                }
                
            }else{
                cell.whoImgView.isHidden = true
               // cell.whoViewHeight.constant = 0
               // cell.whoView.isHidden = true
            }
            /* FAV STORES CHANGES*/
            if(userProfileJson.get("ENABLE_FAVORITE_STORE_MODULE").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
                
                if(item.get("eFavStore").uppercased() == "YES"){
                    
                    cell.favIconImgView.isHidden = false
                }else{
                    cell.favIconImgView.isHidden = true
                }
            }else{
                cell.favIconImgView.isHidden = true
            }
            
            if item.get("restaurantstatus").uppercased() == "OPEN"
            {
                cell.closeLblHeight.constant = 0
                cell.closedLbl.isHidden = true
                
                cell.headerLbl.textColor = UIColor.black
                //cell.timeLbl.textColor = UIColor.black
                cell.subHeaderLbl.textColor = SColors.Grey
                cell.pricePerPersonLbl.textColor = SColors.Grey
                //cell.perPersonPriceLbl.textColor = SColors.Theme
                GeneralFunctions.setImgTintColor(imgView: cell.timeImgView, color: SColors.Theme)
            }else{
                
                cell.closeLblHeight.constant = 21
                cell.closedLbl.isHidden = false
                
                cell.headerLbl.textColor = UIColor.lightGray
                //cell.timeLbl.textColor = UIColor.lightGray
                cell.subHeaderLbl.textColor = UIColor.lightGray
               cell.pricePerPersonLbl.textColor = UIColor.lightGray
                //cell.perPersonPriceLbl.textColor = UIColor.lightGray
                GeneralFunctions.setImgTintColor(imgView: cell.timeImgView, color: UIColor.lightGray)
                
                if item.get("Restaurant_Opentime") != ""
                {
                    cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT") + " " + Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_Opentime"))
                }else
                {
                    cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
                }
                
                if item.get("timeslotavailable") == "Yes"
                {
                    cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_ACCEPT_ORDERS_TXT")
                }
                
            }
            
            //cell.perPersonPriceLbl.textColor = SColors.Theme
            //cell.timeInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIME")
            cell.timeInfoLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
            //cell.minOrderLbl.text = self.generalFunc.getLanguageLabel(origValue: "Min order", key: "LBL_MIN_ORDER_TXT")
            
            let sizeValue = Utils.getValueInPixel(value: 110)
            cell.restImgView.sd_setShowActivityIndicatorView(true)
            cell.restImgView.sd_setIndicatorStyle(.gray)
            cell.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: sizeValue, height: Utils.getValueInPixel(value: 137))), placeholderImage:nil)
            cell.headerLbl.text = item.get("vCompany")
            cell.subHeaderLbl.text = item.get("Restaurant_Cuisine")
            cell.pricePerPersonLbl.text = Configurations.convertNumToAppLocal(numStr:item.get("Restaurant_PricePerPerson"))
            
//            if(cell.pricePerPersonLbl.text == ""){
//                cell.pricePerPersonLbl.isHidden = true
//            }else{
//                cell.pricePerPersonLbl.isHidden = false
//            }
            
            //cell.perPersonPriceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig"))
           // cell.timeLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
            
//            cell.minOrderLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue"))
            cell.discountLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OfferMessage"))
            cell.discountLbl.textColor = UIColor(hex: 0xED2939)
           
           // cell.discountView.backgroundColor = SColors.Theme
            if (cell.discountLbl.text == "" && item.get("Restaurant_Safety_Status").uppercased() == "NO") {
                cell.discountView.isHidden = true
                cell.discountLblHeight.constant = 0
            }else{
               
                if(cell.discountLbl.text == ""){
                   cell.offerImgView.isHidden = true
                   cell.discountLblHeight.constant = 0
                    cell.discountView.isHidden = true
                   //cell.discountLblTopSpace.constant = 0
                }else{
                    cell.offerImgView.isHidden = false
                    cell.discountLblHeight.constant = 20
                    cell.discountView.isHidden = false
                    //cell.discountLblTopSpace.constant = 20
                }
                
                
            }
            
            if GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("vAvgRating")) > 0.0
            {
                cell.ratingView.isHidden = false
                cell.ratingViewWidth.constant = 42
                cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("vAvgRating"))
            }else{
                cell.ratingView.isHidden = true
                cell.ratingViewWidth.constant = 0
            }

            if GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  != "1"{
               cell.pricePerPersonLbl.isHidden = true
                cell.pricePerPersonView.isHidden = true
                //cell.pricePerPersonViewHight.constant = 0
            }

            
            return cell
        }else if(vTtype == "CusineSearchUV"){
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CusineTVCell") as! CusineTVCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let item = self.cusineArray[indexPath.row]
            cell.headerLbl.text = item.get("cuisineName")
            cell.subTitleLbl.text = item.get("TotalRestaurantWithLabel")
            
            return cell
            
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailItemTVCell") as! RestaurantDetailItemTVCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            let item = self.itemsArray[indexPath.item] as NSDictionary
           
            if item.get("eFoodType") == "Veg"
            {
                cell.foodTypeImgViewWidth.constant = 20
                cell.foodTypeImgView.isHidden = false
                cell.foodTypeImgView.image = UIImage(named: "ic_veg")
            }else if item.get("eFoodType") == "NonVeg"
            {
                cell.foodTypeImgViewWidth.constant = 20
                cell.foodTypeImgView.isHidden = false
                cell.foodTypeImgView.image = UIImage(named: "ic_nonVeg")
                
            }else if (item.get("prescription_required").uppercased() == "YES"){
                cell.foodTypeImgViewWidth.constant = 20
                cell.foodTypeImgView.isHidden = false
                cell.foodTypeImgView.image = UIImage(named: "ic_drugs")?.addImagePadding(x: 5, y: 5)
            }else
            {
                cell.foodTypeImgViewWidth.constant = 0
                cell.foodTypeImgView.isHidden = true
            }
            
            if GeneralFunctions.parseDouble(origValue: 0, data: item.get("fOfferAmt")) > 0
            {
                let attributedString = NSMutableAttributedString(string:Configurations.convertNumToAppLocal(numStr: item.get("StrikeoutPrice")))
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
                
                cell.strkeOutLbl.attributedText = attributedString
                cell.priceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("fDiscountPricewithsymbol"))
                cell.priceLbl.textColor = SColors.blackColor
                cell.priceLblLeadingSpace.constant = 10
            }else
            {

                cell.strkeOutLbl.text = ""
                cell.priceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("StrikeoutPrice"))
                
            }
            
            
            cell.titleLbl.text = item.get("vItemType")
            cell.discriptionLbl.text = item.get("vItemDesc")
            
            if Configurations.isRTLMode() == true{
                cell.titleLbl.textAlignment = .right
                cell.discriptionLbl.textAlignment = .right
            }else{
                cell.titleLbl.textAlignment = .left
                cell.discriptionLbl.textAlignment = .left
            }
            cell.bannerImgViewWidth.constant = 80
            cell.bannerImgViewWidth.constant = 80
//            Utils.delayWithSeconds(1) {
//                //cell.itemImgView.roundTo(corners: [.bottomRight, .topLeft, .bottomLeft, .topRight], radius: 5)
//                cell.itemImgView.clipsToBounds = true
//                cell.itemImgView.layer.cornerRadius = 15.0
//            }
            
            cell.titleLbl.textColor = SColors.Theme
            cell.addBtnLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD").uppercased()
            cell.addBtnLbl.textColor = SColors.ThemeTxt
            cell.addBtnLbl.backgroundColor = SColors.Theme
            //cell.foodItemImgView.sd_setImage(with: URL(string: foodItemArray[indexPath.row].get("vImage")), placeholderImage:nil)
            
            let addTapGesture = UITapGestureRecognizer()
            addTapGesture.addTarget(self, action: #selector(self.menuAddTapped(sender:)))
            cell.addBtnLbl.tag = indexPath.row
            cell.addBtnLbl.isUserInteractionEnabled = true
            cell.addBtnLbl.addGestureRecognizer(addTapGesture)
            
            cell.mainView.tag = indexPath.item
            
            cell.mainView.layer.addShadow(opacity: 0.7, radius: 1.5, UIColor.lightGray)
            cell.mainView.layer.roundCorners(radius: 8)
            
            if(Configurations.isRTLMode()){
                cell.addBtnLbl.paddingLeft = 28
            }else{
                cell.addBtnLbl.paddingRight = 28
            }
            
            GeneralFunctions.setImgTintColor(imgView: cell.cartImgView, color: SColors.ThemeTxt)
        
            cell.itemImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 80), height: Utils.getValueInPixel(value: 80))), placeholderImage:nil)
            
          
            let fullString = NSMutableAttributedString(string: item.get("vCompany") + "(")

            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "ic_filled_rating")?.tintTo(color: SColors.Theme)?.resize(toHeight: 12)?.resize(toWidth: 12)

            let image1String = NSAttributedString(attachment: image1Attachment)

            
            fullString.append(image1String)
            fullString.append(NSAttributedString(string: " " +  item.get("vAvgRating") + ")"))

            // draw the result in a label
            cell.storeNameLbl.attributedText = fullString
            
            
            return cell
        }
    }
    
    @objc func menuAddTapped(sender:UITapGestureRecognizer)
    {
        let parentIndex = (sender.view!).superview!.tag
        let index = sender.view!.tag
        
        sender.view!.layer.transform = CATransform3DMakeScale(0.95,0.95,1)
        UIView.animate(withDuration: 0.15, animations: {
            
            sender.view!.layer.transform = CATransform3DMakeScale(1,1,1)
            
        }, completion:{ _ in
            let item = self.itemsArray[index] as NSDictionary

            let addToCartUV = GeneralFunctions.instantiateViewController(pageName: "AddToCartUV") as! AddToCartUV
            //addToCartUV.isRestaurantClose = self.isRestaurantClose
            addToCartUV.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
            addToCartUV.transitioningDelegate = self
            addToCartUV.modalPresentationStyle = .custom
            addToCartUV.foodItemDetails = self.itemsArray[index]
            addToCartUV.companyId = item.get("iCompanyId")
            addToCartUV.comapnyName = item.get("vCompany")
            addToCartUV.minOrder = item.get("fMinOrderValue")
            addToCartUV.vImage = item.get("vImage")
            addToCartUV.eAvialble = item.get("eAvailable")
            addToCartUV.timeSlot = item.get("timeslotavailable")
            //addToCartUV.companyAddress = self.mainDic.get("vCaddress")

            self.push(uv: addToCartUV)
            
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(vTtype == "RestaurantSearchV"){
            let item = self.restaurantsArray[indexPath.row]
            let restDetailView = GeneralFunctions.instantiateViewController(pageName: "RestaurantDetailsUV") as! RestaurantDetailsUV
            restDetailView.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
            restDetailView.restaurantName =  item.get("vCompany")
            restDetailView.companyId = item.get("iCompanyId")
            restDetailView.restaurantcoverImagePath = item.get("vCoverImage")
            restDetailView.restaurantAddress = item.get("vCaddress")
            restDetailView.restaurantRating = item.get("vAvgRating")
            restDetailView.favSelected = item.get("eFavStore").uppercased() == "YES" ? true : false
            restDetailView.restaurantCuisine = item.get("Restaurant_Cuisine")
            restDetailView.safetyEnable = item.get("Restaurant_Safety_Status")
            restDetailView.safetyEnaImgURL = item.get("Restaurant_Safety_Icon")
            restDetailView.safetyDetailURL = item.get("Restaurant_Safety_URL")
            
            self.push(uv: restDetailView)
            
        }else if(vTtype == "CusineSearchUV"){
            let restaurantSearchDetailUV = GeneralFunctions.instantiateViewController(pageName: "RestaurantSearchDetailUV") as! RestaurantSearchDetailUV
            restaurantSearchDetailUV.currentLocation = self.currentLocation
            if self.currentLocation == nil
            {
                self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
            }
            restaurantSearchDetailUV.currentLocation = self.currentLocation
            let item = self.cusineArray[indexPath.row]
            restaurantSearchDetailUV.titleForView = item.get("cuisineName")
            restaurantSearchDetailUV.cusineId = item.get("cuisineId")
            
            self.push(uv: restaurantSearchDetailUV)
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(vTtype == "RestaurantSearchV"){
            return 0
        }else if(vTtype == "CusineSearchUV"){
            return 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(vTtype == "RestaurantSearchV"){
            let item = self.restaurantsArray[indexPath.row]
            
            var height:CGFloat = 240
            if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
                height = 280
            }
            
            if item.get("restaurantstatus").uppercased() == "OPEN"{
                height -= 21
            }
            if item.get("Restaurant_OfferMessage") == ""{
                height -= 40
            }
            return 135
            //return height
        }else if(vTtype == "CusineSearchUV"){
             return 50
        }else{
            return 160
        }
        
    }
    
    
    //*
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
            DispatchQueue.main.async {
                self.whoDetailView.activityIndicator.startAnimating()
            }
           
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.whoDetailView.activityIndicator.stopAnimating()
        }
    }
    
    

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
