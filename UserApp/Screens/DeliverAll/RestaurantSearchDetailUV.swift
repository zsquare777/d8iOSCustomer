
import UIKit
import CoreLocation
import WebKit
import SysBaseLib

class RestaurantSearchDetailUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate,WKNavigationDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var currentLocation:CLLocation!
    var titleForView = ""
    var cusineId = ""
    
    var cusineArray = [NSDictionary]()
    var userProfileJson:NSDictionary!
    var isRestaurantClose = false
    var whoDetailView:WhoDetailView!
    
    var type = ""
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "RestaSearchDetailScreenDesign", uv: self, contentView: contentView) //,
            self.contentView.addSubview(cntView)
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.title = titleForView
            self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            
            self.tableView.register(UINib(nibName: "RestaurantsListCell", bundle: nil), forCellReuseIdentifier: "RestaurantsListCell")
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            
            self.getCusineList()
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: GeneralFunctions.getSafeAreaInsets().bottom))
            customView.backgroundColor = UIColor.clear
            self.tableView.tableFooterView = customView
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //* Tableview Methods for Main Restaurants List View & FilterView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cusineArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        let item = self.cusineArray[indexPath.row]

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
            cell.pricePerPersonViewHight.constant = 0
        }

        
        return cell
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RestaurantsListCell") as! RestaurantsListCell
//
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//
//        cell.ratingView.backgroundColor = SColors.Theme
//        GeneralFunctions.setImgTintColor(imgView: cell.ratingImgView, color: .white)
//
//        GeneralFunctions.setImgTintColor(imgView: cell.timeImgView, color: SColors.Theme)
//
//        Utils.createRoundedView(view: cell.containerView, borderColor: .clear, borderWidth: 0, cornerRadius: 15)
//
//        cell.ratingView.roundTo(corners: [.bottomRight, .topLeft], radius: 12)
//        cell.detailsView.roundTo(corners: [.bottomRight, .bottomLeft], radius: 12)
//        cell.restImgView.roundTo(corners: [.bottomLeft], radius: 12)
//
//
//        cell.offerImgView.image = UIImage.init(named: "ic_offer_dis")
//        GeneralFunctions.setImgTintColor(imgView: cell.offerImgView, color: .white)
//
//        cell.closedLbl.textColor = SColors.maroon
//
//        let item = self.cusineArray[indexPath.row]
//
//        if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
//            if cell.whoViewHeight != nil {
//            cell.whoViewHeight.constant = 20
//            cell.whoView.isHidden = false
//            cell.whoImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("Restaurant_Safety_Icon"), width: Utils.getValueInPixel(value: 20), height: Utils.getValueInPixel(value: 20))), placeholderImage:UIImage(named:"ic_no_icon"))
//            cell.whoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SAFETY_NOTE_TITLE_LIST")
//
//            cell.whoView.handleClick { (instance) in
//                let whoDetailView = WhoDetailView(frame: CGRect(x:0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
//                whoDetailView.webView.load(URLRequest(url: URL(string: item.get("Restaurant_Safety_URL"))!))
//                Application.window!.addSubview(whoDetailView)
//            }
//        }
//        }else{
//              if cell.whoViewHeight != nil {
//            cell.whoViewHeight.constant = 0
//            cell.whoView.isHidden = true
//              }
//        }
//
//        /* FAV STORES CHANGES*/
//        if(userProfileJson.get("ENABLE_FAVORITE_STORE_MODULE").uppercased() == "YES" && GeneralFunctions.getMemberd() != ""){
//
//            if(item.get("eFavStore").uppercased() == "YES"){
//
//                cell.favIconImgView.isHidden = false
//            }else{
//                cell.favIconImgView.isHidden = true
//            }
//        }else{
//            cell.favIconImgView.isHidden = true
//        }
//
//        if item.get("restaurantstatus").uppercased() == "OPEN"
//        {
//            cell.closeLblHeight.constant = 0
//            cell.closedLbl.isHidden = true
//
//        }else{
//
//            cell.closeLblHeight.constant = 21
//            cell.closedLbl.isHidden = false
//
//            if item.get("Restaurant_Opentime") != ""
//            {
//                cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT") + " " + Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_Opentime"))
//            }else
//            {
//                cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSED_TXT")
//            }
//
//            if item.get("timeslotavailable") == "Yes"
//            {
//                cell.closedLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_ACCEPT_ORDERS_TXT")
//            }
//
//        }
//
//        //cell.perPersonPriceLbl.textColor = SColors.Theme
//        cell.timeInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIME")
//        cell.minOrderLbl.text = self.generalFunc.getLanguageLabel(origValue: "for two", key: "LBL_FOR_TWO")
//
//        let sizeValue = Utils.getValueInPixel(value: 150)
//        cell.restImgView.sd_setShowActivityIndicatorView(true)
//        cell.restImgView.sd_setIndicatorStyle(.gray)
//        cell.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: sizeValue, height: sizeValue)), placeholderImage:UIImage(named:"ic_no_icon"))
//        cell.headerLbl.text = item.get("vCompany")
//        cell.subHeaderLbl.text = item.get("Restaurant_Cuisine")
//
//        cell.perPersonPriceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig"))
//        cell.timeLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
//
//        //            cell.minOrderLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue"))
//        cell.discountLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OfferMessage"))
//        cell.discountView.backgroundColor = SColors.Theme
//        if cell.discountLbl.text == "" {
//            cell.discountView.isHidden = true
//        }else{
//            cell.discountView.isHidden = false
//
//        }
//
//        if GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("vAvgRating")) > 0.0
//        {
//            cell.ratingView.isHidden = false
//            cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("vAvgRating"))
//        }else{
//            cell.ratingView.isHidden = true
//        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.cusineArray[indexPath.row]
        let restDetailView = GeneralFunctions.instantiateViewController(pageName: "RestaurantDetailsUV") as! RestaurantDetailsUV
        if self.currentLocation == nil
        {
            self.currentLocation = CLLocation(latitude: Double(0), longitude: Double(0))
        }
        restDetailView.isRestaurantClose = item.get("restaurantstatus").uppercased() == "OPEN" ? false : true
        restDetailView.currentLocation = self.currentLocation
        restDetailView.restaurantName =  item.get("vCompany")
        restDetailView.companyId = item.get("iCompanyId")
        restDetailView.restaurantcoverImagePath = item.get("vCoverImage")
        restDetailView.restaurantAddress = item.get("vCaddress")
        restDetailView.restaurantRating = item.get("vAvgRating")
        restDetailView.favSelected = item.get("eFavStore").uppercased() == "YES" ? true : false
        restDetailView.restaurantCuisine = item.get("Restaurant_Cuisine")
        
        self.push(uv: restDetailView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.cusineArray[indexPath.row]
        
        
        var height:CGFloat = 240

        if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
            height = 270
        }
        if item.get("restaurantstatus").uppercased() == "OPEN"{
            height -= 21
        }
        if item.get("Restaurant_OfferMessage") == ""{
            height -= 40
        }
        return 135
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.8,0.8,1)
        UIView.animate(withDuration: 0.15, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! RestaurantsListCell
        UIView.animate(withDuration: 0.1, animations: {
            cell.containerView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion:{ _ in
            
        })
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! RestaurantsListCell
        UIView.animate(withDuration: 0.1, animations: {
            cell.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:{ _ in
        })
        
    }
    //*
    
    func getCusineList()
    {
        let parameters = ["type":"loadAvailableRestaurants","PassengerLon": "\(self.currentLocation.coordinate.longitude)", "PassengerLat": "\(self.currentLocation.coordinate.latitude)","cuisineId":self.cusineId, "vLang":(GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) == nil ? "" : (GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String)), "iUserId":GeneralFunctions.getMemberd(),"eSystem" : "DeliverAll"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.cusineArray = dataDict.arrOf("message") as! [NSDictionary]
                    
                    let range = NSMakeRange(0, self.tableView.numberOfSections)
                    let sections = NSIndexSet(indexesIn: range)
                    self.tableView.reloadSections(sections as IndexSet, with: .fade)
                    
                }else{
                    self.getCusineList()
                }
                
            }else{
                self.getCusineList()
            }
            
        })
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
