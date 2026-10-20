

import UIKit
import SysBaseLib
import WebKit

struct GenieData {
    
    var title : String
    var subTitle : String
    var buttonTitle : String
 
}

class GenieUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, iCarouselDataSource, iCarouselDelegate, MyBtnClickDelegate, WKNavigationDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var hViewTopLbl: MyLabel!
    @IBOutlet weak var imgeSlideView: iCarousel!
    @IBOutlet weak var imgSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tblTop: NSLayoutConstraint!
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var bannersItemList = [String]()
    var tableData = [GenieData]()
    
    var rowHeight = [CGFloat]()
    
    var vCategoryName = ""
    
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var item:NSDictionary!
    
    var loaderView:UIView!
    
    var webView:WKWebView!
    var customView: UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "GenieScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            
            self.title = self.vCategoryName
            
            self.contentView.backgroundColor = SColors.ThemeTxt
            
            self.setData()
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            self.navigationController?.navigationBar.zPosition = 1
            
        }else if(type == 3){
            self.navigationController?.navigationBar.zPosition = -1
        }
    }
    
    
    func setData(){
        
        self.hViewTopLbl.textColor = SColors.blackColor
        self.hViewTopLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ANY_DELIVER_RUNNER_ANYWHERE")
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_new_info")!.resize(toHeight: 24)!.resize(toHeight: 24)!.tintTo(color: SColors.ThemeTxt), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openInfo))
        self.navigationItem.rightBarButtonItem = rightButton
        
        if(item.get("eCatType").uppercased() == "RUNNER"){
            
            let data1 = GenieData.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_ITEM_RUNNER_ANYWHERE"), subTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_SUB_TITLE_RUNNER_ANYWHERE"), buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_DETAIL_RUNNER_ANYWHERE"))
            self.tableData.append(data1)
            self.rowHeight.append(160.0 + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_ITEM_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().semibold, size: 15)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_SUB_TITLE_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().regular, size: 14)!) - 40.0)
            
        }else if(item.get("eCatType").uppercased() == "ANYWHERE"){
            
            let data2 = GenieData.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BUY_ANY_FROM_STORE_RUNNER_ANYWHERE"), subTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_FROM_STORE_SUB_TITLE_RUNNER"), buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIND_A_STORE_RUNNER_ANYWHERE"))
            self.tableData.append(data2)
            
            self.rowHeight.append(160.0 + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BUY_ANY_FROM_STORE_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().semibold, size: 15)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_FROM_STORE_SUB_TITLE_RUNNER").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().regular, size: 14)!) - 40.0)
            
        }else{
            
            let data1 = GenieData.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_ITEM_RUNNER_ANYWHERE"), subTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_SUB_TITLE_RUNNER_ANYWHERE"), buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_DETAIL_RUNNER_ANYWHERE"))
            self.tableData.append(data1)
            self.rowHeight.append(160.0 + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_ITEM_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().semibold, size: 15)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICK_DROP_SUB_TITLE_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().regular, size: 14)!) - 40.0)
            
            let data2 = GenieData.init(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BUY_ANY_FROM_STORE_RUNNER_ANYWHERE"), subTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_FROM_STORE_SUB_TITLE_RUNNER"), buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FIND_A_STORE_RUNNER_ANYWHERE"))
            self.tableData.append(data2)
            
            self.rowHeight.append(160.0 + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BUY_ANY_FROM_STORE_RUNNER_ANYWHERE").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().semibold, size: 15)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_FROM_STORE_SUB_TITLE_RUNNER").height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().regular, size: 14)!) - 40.0)
            
        }
        
        self.loadBanners()
        
       
    }
    
   
    
    @objc func openInfo(){
        
        if(item.get("eCatType").uppercased() == "RUNNER"){
            
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.customImgName = "ic_genie_info"
            openUserPreferences.htmlString = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_PICK_ANY_NOTE_RUNNER")
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_PICK_ANY_NOTE_RUNNER_ANYWHERE"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_ANYTHING_RUNNER"))
            
        }else if(item.get("eCatType").uppercased() == "ANYWHERE"){
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.customImgName = "ic_genie_info"
            openUserPreferences.htmlString = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_PICK_ANY_NOTE_ANYWHERE")
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_PICK_ANY_NOTE_RUNNER_ANYWHERE"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_ANYTHING_ANYWHERE"))
        }else{
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.customImgName = "ic_genie_info"
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_PICK_ANY_NOTE_RUNNER_ANYWHERE"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVER_ANYTHING_RUNNER_ANYWHERE"))
        }
        
    }
    
    func loadBanners(){
        
        self.setLoader(ishidden: false)
        let parameters = ["type":"getBanners","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "eCatType": item.get("eCatType").uppercased() == "RUNNER" ? "Runner" : "Genie"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let msgArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0..<msgArr.count{
                        let tempItem = msgArr[i] as! NSDictionary
                       
                        self.bannersItemList.append(tempItem.get("vImage"))
                    }
                    
                    if(self.bannersItemList.count == 0){
                        self.imgSlideShowHeight.constant = 0
                        self.tblTop.constant = 10
                    }else{
                        self.imgSlideShowHeight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "", 2.33)
                        self.tblTop.constant = 00
                    }
                    
                    self.imgeSlideView.type = .linear
                    //self.imgeSlideView.isPagingEnabled = true
                    self.imgeSlideView.scrollSpeed = 0.8
                    self.imgeSlideView.decelerationRate = 0.8
                    self.imgeSlideView.delegate = self
                    self.imgeSlideView.dataSource = self
                    if self.bannersItemList.count <= 1 {
                        self.imgeSlideView.contentOffset = CGSize(width: 0, height: 0)
                    }else{
                        self.imgeSlideView.contentOffset = CGSize(width: -15, height: 0)
                    }
                    
                    self.imgeSlideView.reloadData()
                    
                    self.tableView.parallaxHeader.height = self.imgSlideShowHeight.constant
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.register(UINib(nibName: "GenieTVCell", bundle: nil), forCellReuseIdentifier: "GenieTVCell")
                    //self.tableView.tableFooterView = UIView()
                    
                    self.tableView.parallaxHeader.view = self.headerView
                    self.tableView.parallaxHeader.mode = .bottom
                    
                    self.addFooterView()
                    
                }else{
                    //                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                    self.generalFunc.setError(uv: self)
                
                    self.loadBanners()
            }
           self.loaderView.isHidden = true
        })
    }
    
    func addFooterView(){
        var height = 0
        
         if(item.get("eCatType").uppercased() == "RUNNER"){
             
             height = Int(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RUNNER_NOTE").height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont.init(name: Fonts().regular, size: 15)!))
             
         }else if(item.get("eCatType").uppercased() == "ANYWHERE"){
             
             height = Int(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ANYWHERE_NOTE").height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont.init(name: Fonts().regular, size: 15)!))
         }else{
             
             height = Int(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_NOTE").height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont.init(name: Fonts().regular, size: 15)!))
         }
         
         customView = UIView(frame: CGRect(x: 10, y: 0, width: Int(Application.screenSize.width - 20), height: height + 20))
        customView.backgroundColor = SColors.ThemeTxt
         let footerLbl = MyLabel(frame: CGRect(x: 15, y: 10, width: Int(Application.screenSize.width - 30), height: height))
         footerLbl.textColor = SColors.ThemeTxt
         footerLbl.font = UIFont(name: Fonts().regular, size: 15)!
         footerLbl.fontFamilyWeight = "Regular"
         footerLbl.setFontFamily()
         footerLbl.numberOfLines = 0
         footerLbl.textAlignment = .natural
        // footerLbl.sizeToFit()
        
        var page_desc = ""
         if(item.get("eCatType").uppercased() == "RUNNER"){
            
           // footerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RUNNER_NOTE")
            page_desc = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RUNNER_NOTE")
         }else if(item.get("eCatType").uppercased() == "ANYWHERE"){
            
            //footerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ANYWHERE_NOTE")
            page_desc = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ANYWHERE_NOTE")
            
         }else{
            
            //footerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_NOTE")
            page_desc = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_NOTE")

         }
         
      
         self.webView = WKWebView.init(frame: CGRect(x: 0, y:0, width: customView.frame.width , height: customView.frame.height))
         self.webView.navigationDelegate = self
          
         self.webView.isOpaque = false
        self.webView.backgroundColor = SColors.ThemeTxt
         // customView.addSubview(self.webView)
          
          self.webView.scrollView.bounces = false
          
          let content = page_desc.replace("\n", withString: "<br>")
                         
          let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        
           if(Configurations.isRTLMode()){
             self.webView.loadHTMLString(headerString + "<html dir=\"rtl\"><body><p style=background:\(SColors.ThemeTxt);color:\(SColors.blackColor)>\(content)</p></body></html>", baseURL: nil)
           }else{
             self.webView.loadHTMLString(headerString + "<html><body><p style=background:\(SColors.ThemeTxt);color:\(SColors.blackColor)>\(content)</p></body></html>", baseURL:nil)
           }


          self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
         
    }
    
 
       
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           print(webView.scrollView.contentSize.height)

           let width = Application.screenSize.width - 20
           var height = webView.scrollView.contentSize.height

           if(height > Application.screenSize.height - 50){
               height = Application.screenSize.height - 50
           }

           self.customView.frame = CGRect(x:10, y:0, width: width, height: height)
           self.webView.frame = CGRect(x:0, y:0, width: width, height: height)
           self.customView.addSubview(self.webView)
           self.tableView.tableFooterView = self.customView
           
       }
    }
    
    // TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenieTVCell", for: indexPath) as! GenieTVCell
        cell.selectionStyle = .none
        
        cell.titleLbl.text = self.tableData[indexPath.row].title
        cell.sTitleLbl.text = self.tableData[indexPath.row].subTitle
        cell.nextBtn.setButtonTitle(buttonTitle: self.tableData[indexPath.row].buttonTitle)
        
        cell.nextBtn.tag = indexPath.row
        cell.nextBtn.clickDelegate = self
        self.shadowOnview(view: cell.mainView)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight[indexPath.row]
    }
    
    private var finishedLoadingInitialTableCells = false
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        var lastInitialDisplayableCell = false

        //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
        if self.tableData.count > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }

        if !finishedLoadingInitialTableCells {

            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }

            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: (self.rowHeight[indexPath.row])/2)
            cell.alpha = 0

            UIView.animate(withDuration: 0.4, delay: 0.04*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(item.get("eCatType").uppercased() == "RUNNER"){
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            if(userProfileJson.get("PICK_DROP_GENIE").uppercased() == "YES"){
                
                let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
                genieFindStoreUV.isFromPickDrop = true
                self.push(uv: genieFindStoreUV)
                
            }else{
                let moreDeliveriesUv = GeneralFunctions.instantiateViewController(pageName: "MoreDeliveriesUV") as! MoreDeliveriesUV
                moreDeliveriesUv.navItem = self.navigationItem
                
                moreDeliveriesUv.selectedLatitude = self.selectedLatitude
                moreDeliveriesUv.selectedLongitude = self.selectedLongitude
                moreDeliveriesUv.selectedAddress = self.selectedAddress
                    
                moreDeliveriesUv.iVehicleCategoryId = item.get("iVehicleCategoryId")
                
                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                moreDeliveriesUv.vCategoryName = userProfileJson.get("DELIVERY_CATEGORY_NAME")
                self.push(uv: moreDeliveriesUv)
            }
            
        }else if(item.get("eCatType").uppercased() == "ANYWHERE"){
            
            let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
            self.push(uv: genieFindStoreUV)
        }else{
            if(sender.tag == 0){
                
                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                
                if(userProfileJson.get("PICK_DROP_GENIE").uppercased() == "YES"){
                    
                    let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
                    genieFindStoreUV.isFromPickDrop = true
                    self.push(uv: genieFindStoreUV)
                    
                }else{
                    let moreDeliveriesUv = GeneralFunctions.instantiateViewController(pageName: "MoreDeliveriesUV") as! MoreDeliveriesUV
                    moreDeliveriesUv.navItem = self.navigationItem
                    
                    moreDeliveriesUv.selectedLatitude = self.selectedLatitude
                    moreDeliveriesUv.selectedLongitude = self.selectedLongitude
                    moreDeliveriesUv.selectedAddress = self.selectedAddress
                        
                    moreDeliveriesUv.iVehicleCategoryId = item.get("iVehicleCategoryId")
                    
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    moreDeliveriesUv.vCategoryName = userProfileJson.get("DELIVERY_CATEGORY_NAME")
                    self.push(uv: moreDeliveriesUv)
                }
                
            }else if(sender.tag == 1){
                
                let genieFindStoreUV = GeneralFunctions.instantiateViewController(pageName: "GenieFindStoreUV") as! GenieFindStoreUV
                self.push(uv: genieFindStoreUV)
            }
        }
        
        
    }
    
    //carouselview methods
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.bannersItemList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
     
        var imgView:UIImageView!
        var widhthMinus = 60.0
        if bannersItemList.count == 1 {
            widhthMinus = 30.0
        }
        if (view == nil){
            
            let height = Utils.getHeightOfBanner(widthOffset: widhthMinus, ratio: "",2.33)
            let heightValue = Utils.getValueInPixel(value: height)
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - widhthMinus, height: height))
            imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
            
            let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - widhthMinus)
            
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
           
            
        }else{
            imgView = view as? UIImageView
            imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
            let height = Utils.getHeightOfBanner(widthOffset: 60, ratio: "",2.33)
            let heightValue = Utils.getValueInPixel(value: height)
            let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - widhthMinus)
            imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.bannersItemList[index], width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            
            imgView.contentMode = .scaleAspectFit
            imgView.layer.cornerRadius = 16
            imgView.clipsToBounds = true
          
        }
        
        return imgView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if(carousel.currentItemIndex == 0 || self.bannersItemList.count - 1 == carousel.currentItemIndex) {
            if(self.bannersItemList.count - 1 == carousel.currentItemIndex){
                self.imgeSlideView.contentOffset = CGSize(width: 15, height: 0)
            }else{
                self.imgeSlideView.contentOffset = CGSize(width: -15, height: 0)
            }

        }else{
            self.imgeSlideView.contentOffset = CGSize(width: 0, height: 0)
        }
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if(option == .spacing){
            if UIDevice.current.userInterfaceIdiom == .pad {
               return value * 1.02
            }else{
                return value * 1.04
            }
        }
        return value
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        self.view.isUserInteractionEnabled = true
        
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
