

import UIKit
import SysBaseLib

class OrdersListUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, MyBtnClickDelegate, IndicatorInfoProvider, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var filterHLbl: MyLabel!
    @IBOutlet weak var filterDownImgView: UIImageView!
    @IBOutlet weak var topfilterView: UIView!
    var listArray = [NSDictionary] ()
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var directToLiveTrack = false
    var ordeIdForDirectLiveTrack = ""
    var isDataLoad = false
    var reDirectToUFXHome = false
    var loaderView:UIView!
    var nextPage_str = 1
    var isLoadingMore = false
    var isNextPageAvail = false
    var cellHeightArray = [CGFloat]()
    
    var type = ""
    
    var isPageLoad = false
    var isSafeAreaSet = false
    
    var homeTabBar:HomeScreenTabBarUV!
    
    let messageLbl = MyLabel()
    
    var navItem:UINavigationItem!
    
    var subFilterOptionArr:NSArray!
    var vSubFilterParam = ""
    
    var isDirectPush:Bool = false
    
    var userProfileJson:NSDictionary!
    var isMultipleTab = false
    
    var isOpenRestaurantDetail = "No"
    
    var feedBackQue = [NSDictionary]()
    var placeHolderView:UIView!
    var placeholderMarker:Placeholder!
    var isDataLoading = true
    
    @IBOutlet weak var phView1: UIView!
    @IBOutlet weak var phView2: UIView!
    @IBOutlet weak var phView3: UIView!
    @IBOutlet weak var phView4: UIView!
    @IBOutlet weak var parentMainPhView: UIView!
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "OrdersListScreenDesign", uv: self, contentView: contentView)
          
            self.cntView.backgroundColor = SColors.ThemeTxt
          
            cntView.isHidden = false
            self.contentView.isHidden = true

            self.contentView.addSubview(cntView)

            self.tableView.register(UINib(nibName: "OrderListTVCell", bundle: nil), forCellReuseIdentifier: "OrderListTVCell")
            self.tableView.contentInset = UIEdgeInsets.init(top: 6, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 6, right: 0)
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: GeneralFunctions.getSafeAreaInsets().bottom))
            customView.backgroundColor = UIColor.clear
            self.tableView.tableFooterView = customView
            self.tableView.addSubview(self.refreshControl)
            
            
            self.filterHLbl.text = self.generalFunc.getLanguageLabel(origValue: "ALL", key: "LBL_ALL")
            self.filterHLbl.fit()
            
            self.cntView.alpha = 1
        }else if(type == 1){
            
            self.configRTL()
            topfilterView.layer.borderWidth = 1
            topfilterView.layer.borderColor = SColors.blackColor.cgColor
            if(isDirectPush == true || ServiceModule.isDeliverAllOnly()){
                self.addBack()
            }
            
            if(GeneralFunctions.getMemberd() == ""){
                self.homeTabBar.selectedIndex = 1
            }
            
        }else if(type == 2){
            if(isPageLoad == false){
   
                isPageLoad = true
            }
            
            setData()
            Utils.delayWithSeconds(0.1) {
                self.refreshData()
            }
            
            
            self.cntView.isHidden = false
            self.contentView.isHidden = false
            
            if directToLiveTrack == true{
                reDirectToUFXHome = true
                self.directToLiveTrack = false
                let liveTrackUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                liveTrackUv.orderId = ordeIdForDirectLiveTrack
                liveTrackUv.isDirect = true
                self.navigationController?.pushViewController(liveTrackUv, animated: true)
            }
            
            if(self.homeTabBar != nil){
                let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
                label.font = UIFont(name: Fonts().regular, size: 18)!
                label.backgroundColor = UIColor.clear
                label.numberOfLines = 0
                label.textAlignment = NSTextAlignment.center
                
                var navigationHeaderTitle = ""
                
                if(ServiceModule.rideProduct){
                    navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
                }else if(ServiceModule.deliveryProduct){
                    navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
                }else{
                    if(ServiceModule.isDeliverAllOnly()){
                        navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_ORDERS_TXT")
                    }else{
                        navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
                    }
                    
                }
                
                label.text = navigationHeaderTitle
                label.textColor = SColors.ThemeTxt
                self.homeTabBar.navItem.titleView = label
            }
            
            self.messageLbl.frame.size = CGSize(width: self.contentView.frame.size.width - 25, height: 80)
            self.messageLbl.numberOfLines = 4
            self.messageLbl.font = UIFont(name: Fonts().regular, size: 17)!
            self.messageLbl.textAlignment = .center
            self.messageLbl.center = CGPoint(x: tableView.width/2, y: tableView.height/2)
            self.messageLbl.frame = self.tableView.bounds
            self.messageLbl.setPadding(paddingTop: 10, paddingBottom: 10, paddingLeft: 10, paddingRight: 10)
            self.messageLbl.isHidden = true
            self.tableView.addSubview(self.messageLbl)
        }else if (type == 3) {
          self.isDataLoading = true
        }
    }
   
    
    func setData(){
        if(self.homeTabBar != nil){
            self.homeTabBar.navItem.rightBarButtonItem = nil
            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
            label.font = UIFont(name: Fonts().regular, size: 18)!
            label.backgroundColor = UIColor.clear
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.center
            label.text = self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_MY_ORDERS")
            label.textColor = SColors.ThemeTxt
            if(ServiceModule.isDeliverAllOnly()){
               self.homeTabBar.navItem.titleView = label
            }
        }else{
            self.title = self.generalFunc.getLanguageLabel(origValue: "Orders", key: "LBL_MY_ORDERS")
        }
        
        self.navigationItem.rightBarButtonItem = nil
        if(self.navItem != nil){
            self.navItem.rightBarButtonItem = nil
        }
        
        self.filterDownImgView.image = UIImage(named: "ic_arrow_right")!.rotate(90)
        GeneralFunctions.setImgTintColor(imgView: self.filterDownImgView, color: UIColor(hex: 0x202020))
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDERS_TXT"))
    }
    
    
    override func viewDidLayoutSubviews() {
        //if(userProfileJson.get("ONLYDELIVERALL") == "Yes"){
            if(isSafeAreaSet == false){
                self.cntView.frame.size.height = self.view.frame.height + GeneralFunctions.getSafeAreaInsets().bottom
                if(cntView != nil){
                    if(GeneralFunctions.getSafeAreaInsets().bottom == 0){
                        if(self.homeTabBar != nil && isDirectPush == false){
                            self.cntView.frame.size.height = self.cntView.frame.size.height - self.homeTabBar.tabBar.height + 40
                        }
                    }else{
                        if(self.homeTabBar != nil && isDirectPush == false){
                            self.cntView.frame.size.height = self.cntView.frame.size.height - self.homeTabBar.tabBar.height + 75
                        }
                    }
                }
                isSafeAreaSet = true
            }
        //}
    }
    
    override func close(){
        if self.reDirectToUFXHome == true {
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if(ServiceModule.isDeliverAllOnly()) // For only DeliverAll app
            {
                let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
                if(serviceCategoryArray.count > 1){
                    if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                    }
                    
                }else{
                    if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                    }
                    
                }
            }else{
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }
        }else{
            super.close()
        }
    }
    
    func getOrdersList() {
        if(self.isDataLoading == true){
            self.setPlaceHolderView()
            self.cntView.alpha = 1
            self.parentMainPhView.alpha = 1
        }


        let parameters = ["type":"DisplayActiveOrder", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "eSystem":"DeliverAll", "page": self.nextPage_str.description, "vSubFilterParam": self.vSubFilterParam]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            UIView.animate(withDuration: 0.3, animations: {
                self.isDataLoading = false
                self.cntView.alpha = 1
                self.removePlaceHolderView()
                
            }, completion:{ _ in})
            if(response != ""){
                
                let dataDict = response.toDict()
                
                if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                    Utils.printLog(msgData: "SESSION_OUT_CALLED")
                    if(GeneralFunctions.isAlertViewPresentOnScreenWindow(viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG) == false){
                        
                        self.generalFunc.setAlertMessage(uv: nil , title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", viewTag: Utils.SESSION_OUT_VIEW_TAG, coverViewTag: Utils.SESSION_OUT_COVER_VIEW_TAG, completionHandler: { (btnClickedIndex) in
                            
                            GeneralFunctions.postNotificationSignal(key: Utils.releaseAllTaskObserverKey, obj: self)
                            GeneralFunctions.postNotificationSignal(key: EventService.removeInst_key, obj: self)
                            
                            
                            GeneralFunctions.logOutUser()
                            GeneralFunctions.restartApp(window: Application.window!)
                        })
                    }
                    
                    return
                }
                
                let subFilterOptionArr = dataDict.arrOf("subFilterOption")
                
                if(subFilterOptionArr.count > 0){
                    self.subFilterOptionArr = subFilterOptionArr
                    self.filterContainerView.handleClick(clickHandler: { (view) in
                        self.filterSubDataTapped()
                    })
                }
                
                if(dataDict.get("Action") == "1"){
                    
                    self.feedBackQue = dataDict.arrOf("DRIVER_FEEDBACK_QUESTIONS") as! [NSDictionary]
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    for i in 0 ..< dataArr.count {
                        let dataTemp = dataArr[i] as! NSDictionary
                        let addressHeight = dataTemp.get("vRestuarantLocation").height(withConstrainedWidth: Application.screenSize.width - 143, font: UIFont(name: Fonts().regular, size: 13)!)
                        
                        let fNetTotal = Configurations.convertNumToAppLocal(numStr: dataTemp.get("fNetTotal"))
                        let fNetTotalHeight = fNetTotal.height(withConstrainedWidth: Application.screenSize.width - 200, font: UIFont(name: Fonts().semibold, size: 15)!)

                        self.listArray += [dataTemp]
                        self.cellHeightArray.append(addressHeight + fNetTotalHeight)
                    }
                    
                    let NextPage = dataDict.get("NextPage")
                    
                    if(NextPage != "" && NextPage != "0"){
                        self.isNextPageAvail = true
                        self.nextPage_str = Int(NextPage)!
                        
                        self.addFooterView()
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
                    
                    self.tableView.reloadData()
                    
                    self.tableView.isScrollEnabled = true
                    self.messageLbl.isHidden = true

                }else{
                    if(self.isLoadingMore == false){
                        self.messageLbl.isHidden = false
                        self.tableView.isScrollEnabled = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        self.removeFooterView()
                        
                        self.messageLbl.isHidden = true
                        self.tableView.isScrollEnabled = true
                    }
                }
            }else{
                if(self.isLoadingMore == false){
                    _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if(btnClickedIndex == 0){
                            self.getOrdersList()
                        }
                    })
                }
            }
            self.filterContainerView.isHidden = false
            self.isLoadingMore = false
            //self.loaderView.isHidden = true
        })
    }
    
    func refreshData(){
        self.listArray.removeAll()
        self.cellHeightArray.removeAll()
        self.tableView.reloadData()
        self.nextPage_str = 1
        self.isLoadingMore = false
        self.isNextPageAvail = false
       self.isDataLoading = true
        self.getOrdersList()
    }
    
    @objc func filterSubDataTapped(){
        if(subFilterOptionArr == nil){
            return
        }
        
        var filterDataTitleList = [String]()
        
        for i in 0..<subFilterOptionArr.count{
            let data_tmp = subFilterOptionArr[i] as! NSDictionary
            filterDataTitleList.append(data_tmp.get("vTitle"))
        }
        
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.selectedItem = self.filterHLbl.text!
        openListView.show(listObjects: filterDataTitleList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TYPE"), currentInst: openListView, .bottom , handler: { (selectedItemId) in
            self.vSubFilterParam = (self.subFilterOptionArr[selectedItemId] as! NSDictionary).get("vSubFilterParam")
            
            self.filterHLbl.text = (self.subFilterOptionArr[selectedItemId] as! NSDictionary).get("vTitle")
            self.filterHLbl.fit()
            
            if(self.tableView != nil){
                self.removeFooterView()
                self.tableView.reloadData()
            }
            
            self.messageLbl.isHidden = true
            self.tableView.isScrollEnabled = true
            
            self.refreshData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OrderListTVCell") as! OrderListTVCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let dic = self.listArray[indexPath.row]
        GeneralFunctions.setImgTintColor(imgView: cell.addImageView, color: SColors.Theme)
        cell.resNameLbl.text = dic.get("vCompany")
        
        cell.restOrderNoLbl.text = "#" + dic.get("vOrderNo")
        
        cell.containerView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
        cell.containerView.layer.roundCorners(radius: 10)
        
        cell.resAddressLbl.text = dic.get("vRestuarantLocation")
        cell.resAddressLbl.fit()
    
        cell.dateLbl.text = "\(Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dic.get("tOrderRequestDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: "dd MMM, yyyy (EEE)"))"
        //cell.timeVLbl.text = "\(Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dic.get("tOrderRequestDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: "hh:mm a"))"
        cell.timeVLbl.text = "\(Utils.convertDateToFormate(date: Utils.convertDateGregorianToAppLocale(date: dic.get("tOrderRequestDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), formate: "hh:mm a"))"

        if(Configurations.isRTLMode() == true){
            cell.timeVLbl.textAlignment = .left
        }else{
            cell.timeVLbl.textAlignment = .right
        }
        
        cell.orderTypeView.backgroundColor = UIColor.init(hexString: dic.get("vService_BG_color"), alpha: 1)
        
        cell.orderTypeLbl.text = dic.get("vServiceCategoryName")

        
        
        cell.orderTypeLbl.textColor = UIColor.init(hexString: dic.get("vService_TEXT_color"), alpha: 1)
        
        let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
        if(serviceCategoryArray.count > 1){
            cell.orderTypeView.isHidden = false
            cell.orderTypeLbl.isHidden = false
            cell.orderTypeHight.constant = 22

        }else{
            cell.orderTypeView.isHidden = true
            cell.orderTypeLbl.isHidden = true
            cell.orderTypeHight.constant = 0

        }
        
        if(dic.get("vServiceCategoryName") == ""){
            cell.singleCatOrderNo.text = "#" + dic.get("vOrderNo")
            cell.restOrderNoLbl.isHidden = true
            cell.singleCatOrderNo.isHidden = false
        }else{
            cell.singleCatOrderNo.isHidden = true
            cell.restOrderNoLbl.isHidden = false
        }
        
   //     cell.totalHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TOTAL_TXT").uppercased()
        cell.totalVLbl.text = Configurations.convertNumToAppLocal(numStr: dic.get("fNetTotal"))
        cell.totalVLbl.textColor = SColors.Theme
        cell.totalVLbl.numberOfLines = 0
       
        let widthValue = Utils.getValueInPixel(value: 60)
        let heightValue = Utils.getValueInPixel(value: 60)
        cell.resImgView.sd_setShowActivityIndicatorView(true)
        cell.resImgView.sd_setIndicatorStyle(.gray)
        cell.resImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: dic.get("vImage"), width: widthValue, height: heightValue)), placeholderImage:nil)
        //Utils.createRoundedView(view: cell.resImgView, borderColor: UIColor.clear, borderWidth: 0)

        cell.helpLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HEADER_HELP_TXT").uppercased()
        cell.helpBtn.tag = indexPath.row
        cell.detailBtn.tag = indexPath.row

        if(dic.get("DisplayLiveTrack") == "Yes"){
            cell.detailLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_ORDER").uppercased()
        }else{
            cell.detailLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_DETAILS").uppercased()
        }
        
        cell.detailBtn.borderWidth = 1
        cell.detailBtn.cornerRadius = 5
        cell.detailBtn.borderColor = SColors.blackColor
        cell.helpBtn.borderColor = SColors.Theme
        cell.helpBtn.cornerRadius = 5
        cell.helpBtn.borderWidth = 1
        cell.helpBtn.backgroundColor = SColors.Theme
        cell.helpLbl.textColor = SColors.ThemeTxt
        cell.detailLbl.textColor = SColors.blackColor
        if(dic.get("isRatingButtonShow").uppercased() == "YES"){
            cell.helpLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE_ORDER").uppercased()
        }
        
        cell.helpBtn.handleClick { (view) in
            if(dic.get("isRatingButtonShow").uppercased() == "YES"){
                
                self.openRatingView(dataDic: dic)
                return
            }
            
            let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
            helpCategoryUv.iTripId =  dic.get("iOrderId")
            helpCategoryUv.eSystem = "DeliverAll"
            self.push(uv: helpCategoryUv)
        }
        
        cell.detailBtn.handleClick { (view) in
            if(dic.get("DisplayLiveTrack") == "Yes"){
                let liveTrackUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                if(self.reDirectToUFXHome == true){
                    liveTrackUv.isDirect = true
                }
                liveTrackUv.orderId = dic.get("iOrderId")
                self.navigationController?.pushViewController(liveTrackUv, animated: true)
            }else{
                let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
                orderDetailsUv.orderId =  dic.get("iOrderId")
                self.push(uv: orderDetailsUv)
            }
        }
        
        
        cell.statusView.backgroundColor = SColors.Theme
        
        if(Configurations.isRTLMode() == true){
            cell.statusView.roundTo(corners:[.bottomRight, .topRight], radius: 4)
        }else{
            cell.statusView.roundTo(corners:[.bottomLeft, .topLeft], radius: 4)
        }
        
        // Display Status
        if(dic.get("iStatusCode") == "6"){
            cell.statusLbl.text = dic.get("vOrderStatus")
            cell.statusLbl.textColor = SColors.ThemeTxt
            cell.statusView.isHidden = false
            cell.statusLbl.isHidden = false
            
            
        }else if(dic.get("iStatusCode") == "7"){
            cell.statusLbl.text = dic.get("vOrderStatus")
            cell.statusLbl.textColor = SColors.ThemeTxt
            cell.statusView.isHidden = false
            cell.statusLbl.isHidden = false
            
        }else if(dic.get("iStatusCode") == "8" || dic.get("iStatusCode") == "9"){
            cell.statusLbl.text = dic.get("vOrderStatus")
            cell.statusLbl.textColor = SColors.ThemeTxt
            cell.statusView.isHidden = false
            cell.statusLbl.isHidden = false
        }else{
            cell.statusLbl.text = dic.get("vOrderStatus")
            cell.statusLbl.textColor = SColors.ThemeTxt
            cell.statusView.isHidden = false
            cell.statusLbl.isHidden = false
        }
        
        if(Configurations.isRTLMode() == true){
            //cell.totalHLbl.textAlignment = .left
            cell.totalVLbl.textAlignment = .left
            
            cell.resAddressLbl.textAlignment = .right
            cell.dateLbl.textAlignment = .right
//            cell.typeLblTopSpace.constant = 4

        }else{
           // cell.totalHLbl.textAlignment = .right
            cell.totalVLbl.textAlignment = .right
            cell.resAddressLbl.textAlignment = .left
            cell.dateLbl.textAlignment = .left
        }
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 240 + self.cellHeightArray[indexPath.row]
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

        if (maximumOffset - currentOffset <= 15) {
            
            if(isNextPageAvail == true && isLoadingMore == false){
                
                isLoadingMore = true
                
                getOrdersList()
            }
        }
    }
    
    func openRatingView(dataDic:NSDictionary!){
        
        let foodRatingUv = GeneralFunctions.instantiateViewController(pageName: "FoodRatingUV") as! FoodRatingUV
        foodRatingUv.ratingData = ["LastOrderId":dataDic.get("iOrderId"), "LastOrderCompanyId":dataDic.get("iCompanyId"),"LastOrderCompanyName":dataDic.get("vCompany"), "LastOrderDriverId":dataDic.get("driverId"), "LastOrderDriverName":dataDic.get("driverName"), "LastOrderNo":dataDic.get("vOrderNo"), "isLastOrderTakeAway" : dataDic.get("eTakeaway")]
        foodRatingUv.isOpenFromOrderList = true
        foodRatingUv.queArray = self.feedBackQue
        if(dataDic.get("ENABLE_FOOD_RATING_DETAIL_FLOW").uppercased() == "YES"){
            foodRatingUv.isDetailFlow = true
        }
        self.push(uv: foodRatingUv)
        
    }
    
    func addFooterView(){
//        let loaderView =  self.generalFunc.addMDloader(contentView: self.tableView, isAddToParent: false)
//        loaderView.backgroundColor = UIColor.clear
//        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
//        self.tableView.tableFooterView  = loaderView
//        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func myBtnTapped(sender: MyButton) {
        
        let index = sender.tag
        let dic = self.listArray[index]
        let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! OrderListTVCell
        if(sender == cell.helpBtn){
            
            if(dic.get("isRatingButtonShow").uppercased() == "YES"){
                
                self.openRatingView(dataDic: dic)
                return
            }
            let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
            helpCategoryUv.iTripId =  dic.get("iOrderId")
            helpCategoryUv.eSystem = "DeliverAll"
            self.push(uv: helpCategoryUv)
            
        }else if(sender == cell.detailBtn){
            if(dic.get("DisplayLiveTrack") == "Yes"){
                let liveTrackUv = GeneralFunctions.instantiateViewController(pageName: "LiveTrackUV") as! LiveTrackUV
                if(self.reDirectToUFXHome == true){
                    liveTrackUv.isDirect = true
                }
                liveTrackUv.orderId = dic.get("iOrderId")
                self.navigationController?.pushViewController(liveTrackUv, animated: true)
            }else{
                let orderDetailsUv = GeneralFunctions.instantiateViewController(pageName: "OrderDetailsUV") as! OrderDetailsUV
                orderDetailsUv.orderId =  dic.get("iOrderId")
                self.push(uv: orderDetailsUv)
            }
        }
    }
    
    // For Pull To Refersh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = SColors.Theme
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        if(self.tableView != nil){
            self.removeFooterView()
            self.tableView.reloadData()
        }
        
        self.messageLbl.isHidden = true
        self.tableView.isScrollEnabled = true
        
        self.refreshData()
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setPlaceHolderView(){
        self.parentMainPhView.alpha = 1.0
        self.tableView.alpha = 0.0
        placeholderMarker = Placeholder()
       // ((parentGridView.subviews[5]).subviews[0])
        let viewElements: [UIView] = [phView1,phView2,phView3,phView4]
            
            placeholderMarker.register(viewElements)
            placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.placeholderMarker != nil){
            self.cntView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.parentMainPhView.alpha = 0.0},
                                            completion: {(value: Bool) in
                self.tableView.alpha = 1.0
                                                if(self.placeholderMarker != nil){
                                                    self.placeholderMarker.remove()
                                                }
                                                
                                                        })
        }
    }
}
