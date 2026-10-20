

import UIKit
import CoreLocation
import WebKit

class CategoryListTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WKNavigationDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    var pageControl:UIPageControl = UIPageControl()
    
    var dataArray = [NSDictionary]()
    var isListAll = false
    let generalFunc = GeneralFunctions()
    var currentLocation:CLLocation!
    var uv:UIViewController!
    var whoDetailView:WhoDetailView! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "RestaurantsList23CVCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantsList23CVCell")
        self.collectionView.register(UINib.init(nibName: "RestaurantsListCVCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantsListCVCell")
        //self.collectionView.reloadData()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    } 
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = (dataArray.count % 2) == 0 ? dataArray.count / 2 : (dataArray.count / 2) + 1
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isListAll){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsListCVCell", for: indexPath as IndexPath) as! RestaurantsListCVCell
            
            cell.containerView.cornerRadius = 10.0
            cell.containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.containerView.layer.shadowRadius = 4.0
            cell.containerView.layer.shadowOpacity = 1
            cell.containerView.layer.masksToBounds = false
            Utils.delayWithSeconds(0.1) {
                cell.restImgView.round(corners: [.topLeft,.bottomLeft, .topRight, .bottomRight], cornerRadius: 10)
            }
            
            
            if(Configurations.isRTLMode()){
                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            
            if(Configurations.isRTLMode()){
                cell.contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
           
            GeneralFunctions.setImgTintColor(imgView: cell.ratingImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: cell.priceHImgView, color: SColors.Theme)
            
            cell.offerImgView.image = UIImage.init(named: "ic_offer_dis")
            GeneralFunctions.setImgTintColor(imgView: cell.offerImgView, color: UIColor(hex: 0xD90000))
            
            
          //  cell.closedLbl.textColor = SColors.maroon
            
            let item = self.dataArray[indexPath.item]

            if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
            
                //cell.whoViewHeight.constant = 20
                //cell.whoView.isHidden = false
                cell.whoImgView.isHidden = false
               // cell.shapeImageView.isHidden = false
                cell.whoImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("Restaurant_Safety_Icon"), width: Utils.getValueInPixel(value: 15), height: Utils.getValueInPixel(value: 15))), placeholderImage:UIImage(named:"ic_no_icon"))
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
               // cell.shapeImageView.isHidden = true
                //cell.whoViewHeight.constant = 0
                //cell.whoView.isHidden = true
            }
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
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
                
                cell.closedLbl.isHidden = true
               
            
            }else{
               
                cell.closedLbl.isHidden = false
            
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
            

            //cell.timeInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIME")
           // cell.minOrderLbl.text = self.generalFunc.getLanguageLabel(origValue: "Min order", key: "LBL_MIN_ORDER_TXT")
            
            let sizeValue = Utils.getValueInPixel(value: 100)
            cell.restImgView.sd_setShowActivityIndicatorView(true)
            cell.restImgView.sd_setIndicatorStyle(.gray)
          //  if(item.get("vImage") != ""){
            cell.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: sizeValue, height: sizeValue)), placeholderImage:nil)
         //   }
            
            cell.headerLbl.text = item.get("vCompany")
            cell.subHeaderLbl.text = item.get("Restaurant_Cuisine")
            cell.pricePerPersonLbl.text = Configurations.convertNumToAppLocal(numStr:item.get("Restaurant_PricePerPerson"))
            
            if(cell.pricePerPersonLbl.text == "" || GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  != "1"){
                cell.pricePerPersonLbl.isHidden = true
                cell.priceHImgView.isHidden = true
                cell.pricePerPersonView.isHidden = true
              //  cell.pricePerPersonViewHight.constant = 0
            }else{
                cell.pricePerPersonLbl.isHidden = false
                cell.priceHImgView.isHidden = false
                cell.pricePerPersonView.isHidden = false
               // cell.pricePerPersonViewHight.constant = 20
            }
            
            //cell.perPersonPriceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig"))
            cell.timeInfoLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
            
    //            cell.minOrderLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue"))
            cell.discountLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OfferMessage"))
            cell.discountLbl.textColor = UIColor(hex: 0xD90000)
            
            if cell.discountLbl.text == "" {
               
                cell.offerViewheight.constant = 0
                cell.discountView.isHidden = true
            }else{
                cell.offerViewheight.constant = 17
                cell.discountView.isHidden = false
            }
            
    //        if(Configurations.isRTLMode()){
    //            cell.discountLbl.marqueeType = .MLContinuousReverse
    //        }else{
    //            cell.discountLbl.marqueeType = .MLContinuous
    //        }
            
            if GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("vAvgRating")) > 0.0
            {
                cell.ratingView.isHidden = false
                cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("vAvgRating"))
                cell.ratingSeprView.isHidden = false
                cell.ratingViewWidth.constant = 45
            
                cell.ratingSeprViewLeadingSpace.constant = 3
                cell.timeInfoLeadingSpace.constant = 7
            }else{
                cell.ratingSeprView.isHidden = true
                cell.ratingView.isHidden = true
                cell.ratingViewWidth.constant = 0
             
                cell.ratingSeprViewLeadingSpace.constant = 0
                cell.timeInfoLeadingSpace.constant = 0
            }
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantsList23CVCell", for: indexPath as IndexPath) as! RestaurantsList23CVCell
            
            cell.containerView.cornerRadius = 10.0
            cell.containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.containerView.layer.shadowRadius = 4.0
            cell.containerView.layer.shadowOpacity = 1
            cell.containerView.layer.masksToBounds = false
            Utils.delayWithSeconds(0.1) {
                cell.restImgView.round(corners: [.topLeft,.bottomLeft, .topRight, .bottomRight], cornerRadius: 10)
            }
            
            
            if(Configurations.isRTLMode()){
                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            
            if(Configurations.isRTLMode()){
                cell.contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                //cell.shapeImageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
           
            GeneralFunctions.setImgTintColor(imgView: cell.ratingImgView, color: SColors.Theme)
            GeneralFunctions.setImgTintColor(imgView: cell.priceHImgView, color: SColors.Theme)
            
            cell.offerImgView.image = UIImage.init(named: "ic_offer_dis")
            GeneralFunctions.setImgTintColor(imgView: cell.offerImgView, color: UIColor(hex: 0xD90000))
            
            
          //  cell.closedLbl.textColor = SColors.maroon
            
            let item = self.dataArray[indexPath.item]

            if(item.get("Restaurant_Safety_Status").uppercased() == "YES"){
            
                //cell.whoViewHeight.constant = 20
                //cell.whoView.isHidden = false
                cell.whoImgView.isHidden = false
               // cell.shapeImageView.isHidden = false
                cell.whoImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("Restaurant_Safety_Icon"), width: Utils.getValueInPixel(value: 15), height: Utils.getValueInPixel(value: 15))), placeholderImage:UIImage(named:"ic_no_icon"))
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
               // cell.shapeImageView.isHidden = true
                //cell.whoViewHeight.constant = 0
                //cell.whoView.isHidden = true
            }
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
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
                
                cell.closedLbl.isHidden = true
               
            
            }else{
               
                cell.closedLbl.isHidden = false
            
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
            

            //cell.timeInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIME")
           // cell.minOrderLbl.text = self.generalFunc.getLanguageLabel(origValue: "Min order", key: "LBL_MIN_ORDER_TXT")
            
            let sizeValue = Utils.getValueInPixel(value: self.getCellSize().width - 35)
            cell.restImgView.sd_setShowActivityIndicatorView(true)
            cell.restImgView.sd_setIndicatorStyle(.gray)
          //  if(item.get("vImage") != ""){
            cell.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: sizeValue, height: Int(Utils.getHeightOfBanner(widthOffset: CGFloat(Application.screenSize.width - CGFloat(sizeValue)), ratio: "1.88")))), placeholderImage:nil)
         //   }
            
            cell.headerLbl.text = item.get("vCompany")
            cell.subHeaderLbl.text = item.get("Restaurant_Cuisine")
            cell.pricePerPersonLbl.text = Configurations.convertNumToAppLocal(numStr:item.get("Restaurant_PricePerPerson"))
            
            if(cell.pricePerPersonLbl.text == "" || GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String  != "1"){
                cell.pricePerPersonLbl.isHidden = true
                cell.priceHImgView.isHidden = true
                cell.pricePerPersonView.isHidden = true
              //  cell.pricePerPersonViewHight.constant = 0
            }else{
                cell.pricePerPersonLbl.isHidden = false
                cell.priceHImgView.isHidden = false
                cell.pricePerPersonView.isHidden = false
               // cell.pricePerPersonViewHight.constant = 20
            }
            
            //cell.perPersonPriceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue_Orig"))
            cell.timeInfoLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OrderPrepareTime"))
            
    //            cell.minOrderLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_MinOrderValue"))
            cell.discountLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("Restaurant_OfferMessage"))
            cell.discountLbl.textColor = UIColor(hex: 0xD90000)
            
            if cell.discountLbl.text == "" {
               
                cell.offerViewheight.constant = 0
                cell.discountView.isHidden = true
            }else{
                cell.offerViewheight.constant = 17
                cell.discountView.isHidden = false
            }
            
    //        if(Configurations.isRTLMode()){
    //            cell.discountLbl.marqueeType = .MLContinuousReverse
    //        }else{
    //            cell.discountLbl.marqueeType = .MLContinuous
    //        }
            
            if GeneralFunctions.parseDouble(origValue: 0.0, data: item.get("vAvgRating")) > 0.0
            {
                cell.ratingView.isHidden = false
                cell.ratingLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("vAvgRating"))
                cell.ratingSeprView.isHidden = false
                cell.ratingViewWidth.constant = 45
            
                cell.ratingSeprViewLeadingSpace.constant = 3
                cell.timeInfoLeadingSpace.constant = 7
            }else{
                cell.ratingSeprView.isHidden = true
                cell.ratingView.isHidden = true
                cell.ratingViewWidth.constant = 0
             
                cell.ratingSeprViewLeadingSpace.constant = 0
                cell.timeInfoLeadingSpace.constant = 0
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if(isListAll){
            return CGSize(width: Application.screenSize.width, height: 160)
        }else{
            
//            if(self.dataArray.count > 2){
//                return CGSize(width: Application.screenSize.width - 80, height: 140)
//            }else{
//                return CGSize(width: Application.screenSize.width, height: 140)
//            }
            
            return getCellSize()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.dataArray[indexPath.row]
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
        restDetailView.favSelected = item.get("eFavStore").uppercased() == "YES" ? true : false
        restDetailView.restaurantRating = item.get("vAvgRating")
        restDetailView.restaurantCuisine = item.get("Restaurant_Cuisine")
        restDetailView.safetyEnable = item.get("Restaurant_Safety_Status")
        restDetailView.safetyEnaImgURL = item.get("Restaurant_Safety_Icon")
        restDetailView.safetyDetailURL = item.get("Restaurant_Safety_URL")
        //let navController = AppSnackbarController(rootViewController: UINavigationController(rootViewController: restDetailView))
        
        self.uv.push(uv: restDetailView)
    }
    
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(self.getCellSize().width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth) - 10, y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    
    
    func getCellSize() -> CGSize{
        
        let width = (Application.screenSize.width * 223) / 375
        let height = ((width * 110) / 240) + 130
        
        return CGSize(width: width, height: height)
    }
}
