

import UIKit
import SysBaseLib

class BiddingHistoryUV: ParentViewUV, UITableViewDataSource, UITableViewDelegate, MyBtnClickDelegate, IndicatorInfoProvider, ParentViewUVDelegate  {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    //var tableView:UITableView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var filterHLbl: MyLabel!
    @IBOutlet weak var filterDownImgView: UIImageView!
    var newScheduleView:ListBottomSheetViewTimePicker!
    let generalFunc = GeneralFunctions()
    
    @IBOutlet weak var topFilterView: UIView!
    var navItem:UINavigationItem!
    
    var HISTORY_TYPE:String = "PAST"
    
    var loaderView:UIView!
    
    var dataArrList = [NSDictionary]()
    var nextPage_str = 1
    var tripDataPage_str = 1
    var isLoadingMore:Bool = false
    var isNextPageAvail:Bool = false
    
    var APP_TYPE:String = ""
    
    var cntView:UIView!
    
    var extraHeightContainer = [CGFloat]()
    var userProfileJson:NSDictionary!
    
    var isFirstCallFinished:Bool = false
    
    var isDataLoaded:Bool = false
    
    var isDirectPush:Bool = false
    var isSafeAreaSet:Bool = false
    
    var iCabBookingId:String = ""
    var dateStr:String = ""

    var isDataFetchBlocked = false
    
    var appTypeFilterArr:NSArray!
    var vFilterParam = ""
    var hFilterParam = ""
    var subFilterOptionArr:NSArray!
    var vSubFilterParam = ""

    var currentWebTask:ApiHandler!
    
    var isOpenFromMainScreen = false
    var isFromUFXCheckOut = false
    var viewLoadForDelivery = false
    
    var isFromViewProfile = false
    
    var homeTabBar:HomeScreenTabBarUV!
    
    var directToLiveTrack = false
    var ordeIdForDirectLiveTrack = ""
    var rideOrderhistorytabUV: RideOrderHistoryTabUV!
    
    let messageLbl = MyLabel()
    var viewWillDisAppear = false
    
    var additionChargesDataDic:NSDictionary!
    var datesAr = [String]()
    var dayAr = [String]()
    var datesDisplay = [String]()
    var datesPass = [String]()
    var selectedIndexCollection = 0
    var ridelaterNew = false
    var selctedIndex = 0
    var selectedDateTimeNew = ""
    var selectedDateTimeNewPass = ""
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
           
            cntView = self.generalFunc.loadView(nibName: "BiddingHistoryScreenDesign", uv: self, contentView: contentView)
            self.cntView.backgroundColor = SColors.ThemeTxt
            self.cntView.isHidden = true
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)//UIColor(hex: 0xF1F1F1)
            //self.contentView.addSubview(cntView)
            
            self.tableView.delegate = self
    //        self.tableView.bounces = false
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView()
            self.tableView.register(UINib(nibName: "BiddingHistoryTVcell", bundle: nil), forCellReuseIdentifier: "BiddingHistoryTVCell")
            
            self.tableView.contentInset = UIEdgeInsets.init(top: 6, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 6, right: 0)
            self.tableView.addSubview(self.refreshControl)

            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            APP_TYPE = userProfileJson.get("APP_TYPE")
            
            if(viewLoadForDelivery == true){
                let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_nav_bar_back")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.closeToMain))
                self.navigationItem.leftBarButtonItem = leftButton;
            }else{
                if(isDirectPush == true || self.homeTabBar == nil){
                    self.addBack()
                    
                    
                    if(ServiceModule.rideProduct){
                       // self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
                       // self.title = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
                    }else if(ServiceModule.deliveryProduct){
                       // self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: //"LBL_YOUR_DELIVERY")
                        self.title = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
                    }else{
                      //  self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
                      //  self.title = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
                    }
                }
            }
            
            self.filterHLbl.text = self.generalFunc.getLanguageLabel(origValue: "ALL", key: "LBL_ALL")
            self.filterHLbl.fit()
            
            self.filterDownImgView.image = UIImage(named: "ic_arrow_right")!.rotate(90)
            GeneralFunctions.setImgTintColor(imgView: self.filterDownImgView, color: UIColor(hex: 0x202020))
//            placeHolderView = self.generalFunc.loadView(nibName: "BookingHistoryPHView", uv: self, contentView: self.view)
//            self.placeHolderView.clipsToBounds = true
//            if self.homeTabBar != nil {
//                self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height -  self.homeTabBar.kBarHeight)
//            }else{
//                self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height )
//            }
//
           
//            Application.window!.addSubview(placeHolderView)
//            if(self.isDataLoading == true){
//                self.setPlaceHolderView()
//            }
            self.cntView.alpha = 1
            
        }else if(type == 1){
            
            self.configRTL()
           // pageTabBarController?.selectedIndex = 2
           // if(loaderView != nil && self.isFirstCallFinished == true){
                //if(isDataFetchBlocked == false){
            topFilterView.layer.borderWidth = 1
            topFilterView.layer.borderColor = SColors.blackColor.cgColor
                    self.extraHeightContainer.removeAll()
                    self.dataArrList.removeAll()
                    self.isLoadingMore = false
                    self.nextPage_str = 1
                    self.isNextPageAvail = false
                    
                    if(self.tableView != nil){
                        self.removeFooterView()
                        self.tableView.reloadData()
                    }
                    
                    Utils.delayWithSeconds(0.2) {
                        self.getDtata(isLoadingMore: false)
                    }
                    
//                }else{
//                    isDataFetchBlocked = false
//                }
         //   }
            
            viewWillDisAppear = false
            
        }else if(type == 2){
            
            if(isDataLoaded == false){
                
                if(ServiceModule.rideDeliveryUbexProduct){
                    if(cntView != nil){
                        self.cntView.frame = self.view.frame
                        cntView.frame.size.height = cntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
                        
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
                }
                self.extraHeightContainer.removeAll()
                self.dataArrList.removeAll()
                self.tableView.reloadData()
                isDataLoaded = true
                self.getDtata(isLoadingMore: self.isLoadingMore)
            }
           //
            setData()
            
            if(directToLiveTrack && ServiceModule.isDeliverAllOnly() == false){
                self.rideOrderhistorytabUV.moveToViewController(at: 1)
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
            
        }else if(type == 3){
            directToLiveTrack = false
            viewWillDisAppear = true
            self.isDataLoading = true
        }else if(type == 4){
            self.additionChargesDataDic = nil
        }
    }
  
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_TXT"))
        
    }
    
    func setData(){
       
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
        label.font = UIFont(name: Fonts().regular, size: 18)!
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        
        var navigationHeaderTitle = ""
        
        if(ServiceModule.isRideOnly()){
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your trips", key: "LBL_YOUR_TRIPS")
        }else if(ServiceModule.isDeliveryOnly()){
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your deliveries", key: "LBL_YOUR_DELIVERY")
        }else{
            navigationHeaderTitle = self.generalFunc.getLanguageLabel(origValue: "Your bookings", key: "LBL_YOUR_BOOKING")
        }
        
        label.text = navigationHeaderTitle
        label.textColor = SColors.ThemeTxt
        if(self.homeTabBar != nil){
            self.homeTabBar.navItem.titleView = label
        }else {
             self.navigationItem.titleView = label
        }
        if(self.navItem != nil){
            self.navItem.rightBarButtonItem = nil
        }else{
            self.navigationController?.navigationItem.rightBarButtonItem = nil
        }
         if(self.homeTabBar != nil){
            self.homeTabBar.navItem.rightBarButtonItem = nil
        }else {
             self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func close() {
        if(isOpenFromMainScreen || isFromUFXCheckOut == true){
            GeneralFunctions.saveValue(key: "FROMCHECKOUT", value: true as AnyObject)
            
            if(ServiceModule.rideDeliveryProduct){
                self.performSegue(withIdentifier: "unwindToMoreDeliveriesScreen", sender: self)
            }else{
                let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
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
    
    @objc func closeToMain() {
        let window = Application.window
        let getUserData = GetUserData(uv: self, window: window!)
        getUserData.getdata()
        
    }
   
    
    func getDtata(isLoadingMore:Bool){
        self.filterContainerView.isHidden = true
        if(self.isDataLoading == true){
            self.setPlaceHolderView()
            self.cntView.alpha = 1
        }
//        if(loaderView == nil){
//            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
//            loaderView.backgroundColor = UIColor.clear
//        }else if(loaderView != nil && isLoadingMore == false){
//            loaderView.isHidden = false
//        }
        
        if(currentWebTask != nil){
            currentWebTask.cancel()
        }

        let parameters = ["type": "getBiddingPosts", "UserType": Utils.appUserType, "memberId": GeneralFunctions.getMemberd(), "page": self.nextPage_str.description,  "vSubFilterParam": self.vSubFilterParam]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        currentWebTask = exeWebServerUrl
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
                
                let appTypeFilterArr = dataDict.arrOf("AppTypeFilterArr")
                if(self.navItem != nil){
                    self.navItem.rightBarButtonItem = nil
                }else{
                    self.navigationController?.navigationItem.rightBarButtonItem = nil
                }
//
//                if(appTypeFilterArr.count > 2){
//                    self.appTypeFilterArr = appTypeFilterArr
//                    let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_filter")!.resize(toWidth: 30)!.resize(toHeight: 30)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.filterDataTapped))
//
//                    if(self.viewWillDisAppear == false){
//                        if(self.homeTabBar == nil){
//                            if(self.navItem != nil){
//                                //self.navItem.rightBarButtonItem = rightButton
//                            }else{
//                               // self.navigationController?.navigationItem.rightBarButtonItem = rightButton
//                            }
//
//                        }else{
//                            if(self.isFromViewProfile && self.navItem != nil){
//                                self.navItem.rightBarButtonItem = rightButton
//                            }else{
//                                self.homeTabBar.navItem.rightBarButtonItem = rightButton
//                            }
//                        }
//                    }
//
//                }
                
                let subFilterOptionArr = dataDict.arrOf("subFilterOption")
               
                if(subFilterOptionArr.count > 0){
                    self.subFilterOptionArr = subFilterOptionArr
                    
                    let filterTapGue = UITapGestureRecognizer()
                    filterTapGue.addTarget(self, action: #selector(self.filterSubDataTapped))
                    self.filterContainerView.isUserInteractionEnabled = true
                    self.filterContainerView.addGestureRecognizer(filterTapGue)
                    for dict  in subFilterOptionArr {
                        let valu = dict as! NSDictionary
                        if valu.get("vSubFilterParam") == dataDict.get("eFilterSel") {
                            self.filterHLbl.text = valu.get("vTitle")
                        }
                    }
                }
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    
                    if(self.isFirstCallFinished == false){
                        self.isFirstCallFinished = true
                    }
                    
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList.append(dataTemp)
                    
                     
                        var sourceAddHeight : CGFloat = 0.0
                        var destAddHeight : CGFloat = 0.0
                        
                       
                    sourceAddHeight = dataTemp.get("vServiceAddress").height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont(name: Fonts().regular, size: 15)!) - 18
//                            destAddHeight = dataTemp.get("tDaddress").height(withConstrainedWidth: Application.screenSize.width - 134, font: UIFont(name: Fonts().regular, size: 15)!) - 18
                       
                     
                            destAddHeight = 0
                      

                        self.extraHeightContainer.append(sourceAddHeight + destAddHeight)
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
                    self.tableView.isHidden = false
                    self.tableView.isScrollEnabled = true
                    self.messageLbl.isHidden = true
                    
                    if(self.additionChargesDataDic != nil){
                        let myOnGoingTripDetailsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                        
                        for i in 0 ..< self.dataArrList.count{
                            
                            let item = self.dataArrList[i]
                            if(item.get("iTripId") == self.additionChargesDataDic.get("iTripId")){
                                myOnGoingTripDetailsUV.dataDict = item
                                myOnGoingTripDetailsUV.iTripId = item.get("iTripId")
                                myOnGoingTripDetailsUV.additionChargesDataDic = self.additionChargesDataDic
                                self.push(uv: myOnGoingTripDetailsUV)
                            }
                        }
                    }

                }else{
                    if(isLoadingMore == false &&  self.dataArrList.count == 0){
                        self.messageLbl.isHidden = false
                        self.tableView.isScrollEnabled = false
                        self.messageLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.messageLbl.isHidden = true
                        self.tableView.isScrollEnabled = true
                        
                        self.removeFooterView()
                    }
                }
            }else{
                if(isLoadingMore == false){
                    self.messageLbl.isHidden = true
                    self.tableView.isScrollEnabled = true
                    
                    self.generalFunc.setError(uv: self)
                }
            }

            self.filterContainerView.isHidden = false
            self.isLoadingMore = false
            //self.loaderView.isHidden = true
        })
    }
    
    @objc func filterDataTapped(){
        if(appTypeFilterArr == nil){
            return
        }
        
        var filterDataTitleList = [String]()
        
        for i in 0..<appTypeFilterArr.count{
            let data_tmp = appTypeFilterArr[i] as! NSDictionary
            filterDataTitleList.append(data_tmp.get("vTitle"))
        }
        
        let openListView = OpenListView(uv: self, containerView: self.view)
        let allStr = appTypeFilterArr[0] as! NSDictionary
        
        if(allStr.count != 0){
            openListView.selectedItem = self.hFilterParam == "" ? allStr.get("vTitle") == "" ? self.generalFunc.getLanguageLabel(origValue: "ALL", key: "LBL_ALL") : allStr.get("vTitle") : self.hFilterParam
        }else{
            openListView.selectedItem = self.generalFunc.getLanguageLabel(origValue: "ALL", key: "LBL_ALL")
        }
        
        openListView.show(listObjects: filterDataTitleList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TYPE"), currentInst: openListView, .bottom , handler: { (selectedItemId) in
            self.vFilterParam = (self.appTypeFilterArr[selectedItemId] as! NSDictionary).get("vFilterParam")
            self.hFilterParam = (self.appTypeFilterArr[selectedItemId] as! NSDictionary).get("vTitle")
            self.extraHeightContainer.removeAll()
            self.dataArrList.removeAll()
            self.isLoadingMore = false
            self.nextPage_str = 1
            self.isNextPageAvail = false
            
            if(self.tableView != nil){
                self.removeFooterView()
                self.tableView.reloadData()
            }
            
            self.messageLbl.isHidden = true
            self.tableView.isScrollEnabled = true
            
            self.getDtata(isLoadingMore: false)
        })
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
        openListView.show(listObjects: filterDataTitleList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TYPE"), currentInst: openListView, .bottom, handler: { (selectedItemId) in
            self.vSubFilterParam = (self.subFilterOptionArr[selectedItemId] as! NSDictionary).get("vSubFilterParam")
            
            self.filterHLbl.text = (self.subFilterOptionArr[selectedItemId] as! NSDictionary).get("vTitle")
            self.filterHLbl.fit()
            
            self.extraHeightContainer.removeAll()
            self.dataArrList.removeAll()
            self.isLoadingMore = false
            self.nextPage_str = 1
            self.isNextPageAvail = false
            
            if(self.tableView != nil){
                self.removeFooterView()
                self.tableView.reloadData()
            }
            
            self.messageLbl.isHidden = true
            self.tableView.isScrollEnabled = true
            
            self.getDtata(isLoadingMore: false)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.dataArrList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiddingHistoryTVCell", for: indexPath) as! BiddingHistoryTVCell
        
//        cell.dataView.layer.shadowOpacity = 1.5
//        cell.dataView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cell.dataView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
        Utils.delayWithSeconds(0.1) {
            cell.dataView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
        }
        
        Utils.createRoundedView(view: cell.dataView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        
        cell.statusView.isHidden = false
        if item.get("vStatus_BG_color") == "" {
            cell.statusView.backgroundColor = SColors.Theme
        }else{
        cell.statusView.backgroundColor = UIColor.init(hexString: item.get("vStatus_BG_color"))//SColors.Theme
        }
      
        
        if(Configurations.isRTLMode() == true){
            cell.statusView.roundTo(corners: [.bottomRight, .topRight], radius: 4)
        }else{
            cell.statusView.roundTo(corners: [.bottomLeft, .topLeft], radius: 4)
        }

        cell.btnContainerView.isHidden = true
        cell.rideDateLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: item.get("dBiddingDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateForateDateWithDay)
        let mainDateStr = Utils.convertDateToFormate(date: Utils.convertDateGregorianToAppLocale(date: item.get("dBiddingDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), formate: Utils.dateFormateTimeOnly)
        cell.timeVLbl.text = mainDateStr
        //cell.timeVLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: item.get("dBiddingDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateTimeOnly)
        
        if(Configurations.isRTLMode() == true){
            cell.timeVLbl.textAlignment = .left
        }else{
            cell.timeVLbl.textAlignment = .right
        }

        cell.pickUpLocVLbl.text = item.get("vServiceAddress")
        var vBookingNo = ""
        vBookingNo = Configurations.convertNumToAppLocal(numStr: item.get("vBiddingPostNo"))
        
        cell.providerNameLbl.text = ""//self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_SERVICE_ADDRESS_TXT").uppercased()//item.get("vName")
        
        cell.providerImgView.image = UIImage.init(named: "ic_new_mapPin")
        GeneralFunctions.setImgTintColor(imgView: cell.providerImgView, color: SColors.Theme)
        cell.providerNameNewLbl.text = item.get("vContactName")
        cell.amountLbl.text = item.get("fBiddingAmount")
       // Utils.createRoundedView(view: cell.providerImgView, borderColor: UIColor.clear, borderWidth: 0)
        
        let vTypeNameTxt = item.get("vTitle")
        
        cell.vTypeNameLbl.text = vTypeNameTxt.trim()
        cell.vTypeNameLbl.textColor  = UIColor.init(hexString: item.get("vService_TEXT_color"))
        cell.vTypeNameLbl.textAlignment = .center
        
        cell.serviceTypeView.backgroundColor = UIColor.init(hexString: item.get("vService_BG_color")) //UIColor(hex: 0xffa524)
        
        if(vTypeNameTxt == ""){
            cell.vTypeNameLbl.isHidden = true
            cell.serviceTypeView.isHidden = true
        }

        cell.pickUpLocVLbl.fit()
        cell.statusVLbl.text = item.get("bidding_status")
        
        cell.statusVLbl.textAlignment = .center
        cell.statusVLbl.text =  "\(cell.statusVLbl.text!)".capitalized
        cell.statusVLbl.textColor = SColors.ThemeTxt
        cell.bookingNoLbl.text = "\(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_TXT")) #\(vBookingNo)"

        if(ServiceModule.biddingM){
            cell.rideDateLbl.isHidden = false
        }else{
            cell.rideDateLbl.isHidden = true
        }
        
        cell.cancelBookingBtn.tag = indexPath.item
        cell.cancelBookingBtn.clickDelegate = self
        cell.reScheduleBookingBtn.tag = indexPath.item
        cell.reScheduleBookingBtn.clickDelegate = self

       // cell.btnContainerView.isHidden = false
        //cell.btnContainerViewHeight.constant = 35
        cell.cancelBookingBtnHight.constant = 35
        //cell.btnConatainerViewTop.constant = 17.5
        cell.reScheduleBookingBtn.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 0, cornerRadius:10)
        cell.reScheduleBookingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "View Details", key: "LBL_VIEW_TASK_BIDDING"))
        cell.reScheduleBookingBtn.btnType = "VIEW_DETAIL_BIDDING"
        if item.get("showBiddingTaskBtn").uppercased() == "YES" {
            cell.reScheduleBookingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_TASK_BIDDING"))
        }else if item.get("showDetailBtn").uppercased() == "YES"{
            cell.reScheduleBookingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_DETAILS"))
        }else{
            cell.reScheduleBookingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_TASK_BIDDING"))
        }
        cell.reScheduleBookingBtn.isHidden = false
        cell.cancelBookingBtn.setCustomColor(textColor: SColors.blackColor, bgColor: SColors.ThemeTxt, pulseColor: SColors.blackColor, borderColor: SColors.blackColor, borderWidth: 1, cornerRadius: 10)
        cell.cancelBookingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_BIDDING"))
        cell.cancelBookingBtn.btnType = "CANCEL_BOOKING"
        if item.get("showCancelBtn").uppercased() == "YES" {
            
            cell.cancelBookingBtn.isHidden = false
            cell.btnContainerView.isHidden = false
            cell.btnContainerViewHeight.constant = 35
        }else{
           // cell.cancelBookingBtnHight.constant = 0
            cell.cancelBookingBtn.isHidden = true
            cell.btnContainerView.isHidden = true
            cell.btnContainerViewHeight.constant = 0
        }
        if item.get("showDetailBtn") == "" && item.get("showBiddingTaskBtn") == "" {
            cell.reScheduleBookingBtn.isHidden = true
            cell.cancelBookingBtnHight.constant = 0
        }else {
        if item.get("showDetailBtn").uppercased() == "NO" && item.get("showBiddingTaskBtn").uppercased() == "NO"{
            cell.reScheduleBookingBtn.isHidden = true
            cell.cancelBookingBtnHight.constant = 0
        }else{
            cell.reScheduleBookingBtn.isHidden = false
            cell.cancelBookingBtnHight.constant = 34
        }
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear

        return cell
            
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
//        let item = self.dataArrList[indexPath.item]
//
//        if item.get("showCancelBtn").uppercased() == "YES" {
//            return self.extraHeightContainer[indexPath.item] + 320
//        }else{
//            return self.extraHeightContainer[indexPath.item] + 273
//        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if (maximumOffset - currentOffset <= 15) {
            if(isNextPageAvail==true && isLoadingMore==false){
                
                isLoadingMore=true
                
                getDtata(isLoadingMore: isLoadingMore)
            }
        }
    }
    
    func addFooterView(){
        let loaderView =  self.generalFunc.addMDloader(contentView: self.tableView, isAddToParent: false)
        loaderView.backgroundColor = UIColor.clear
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.tableView.tableFooterView  = loaderView
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
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
        self.extraHeightContainer.removeAll()
        self.dataArrList.removeAll()
        self.isLoadingMore = false
        self.nextPage_str = 1
        self.isNextPageAvail = false
        
        if(self.tableView != nil){
            self.removeFooterView()
            self.tableView.reloadData()
        }
        
        self.messageLbl.isHidden = true
        self.tableView.isScrollEnabled = true
        self.isDataLoading = true
        self.getDtata(isLoadingMore: false)
    }
    
    func myBtnTapped(sender: MyButton) {
        if (sender.btnType == "VIEW_DETAIL_BIDDING"){
            let item = self.dataArrList[sender.tag]
            if item.get("bidding_statusOrg") == "Completed" {
                let rideDetailUV = GeneralFunctions.instantiateViewController(pageName: "RideDetailUV") as! RideDetailUV
                rideDetailUV.iTripId = self.dataArrList[sender.tag].get("iBiddingPostId")
                isDataFetchBlocked = true
                rideDetailUV.isBidding = true
                self.push(uv: rideDetailUV)
               
            }
            else if item.get("bidding_statusOrg") == "In process"{
                let myOnGoingTripDetailsUV = GeneralFunctions.instantiateViewController(pageName: "MyOnGoingTripDetailsUV") as! MyOnGoingTripDetailsUV
                myOnGoingTripDetailsUV.dataDict = self.dataArrList[sender.tag]
                myOnGoingTripDetailsUV.isBidding = true
                myOnGoingTripDetailsUV.directToLiveTrack = true
                self.push(uv: myOnGoingTripDetailsUV)
            }
                else{
            let biddingDetailsUV = GeneralFunctions.instantiateViewController(pageName: "BiddingDetialsUV") as! BiddingDetialsUV
            biddingDetailsUV.biddingPostId =  self.dataArrList[sender.tag].get("iBiddingPostId")
            biddingDetailsUV.dictData = self.dataArrList[sender.tag]
            self.push(uv: biddingDetailsUV)
            }
        }else if(sender.btnType == "CANCEL_BOOKING"){
            cancelBooking(position: sender.tag)
        }
        
    }
    
    func cancelBooking(position:Int){
        let openCancelBooking = OpenCancelBooking(uv: self)
        openCancelBooking.isFromBiddig = true
        openCancelBooking.cancelTrip(eTripType: "Bidding", iTripId: "", iCabBookingId: self.dataArrList[position].get("iBiddingPostId")) { (iCancelReasonId, reason) in
            self.continueCancelBooking(iCabBookingId: self.dataArrList[position].get("iBiddingPostId"), reason: reason, iCancelReasonId: iCancelReasonId)
        }
    }
    
    
    
    
    func continueCancelBooking(iCabBookingId: String, reason:String, iCancelReasonId: String){
        let parameters = ["type":"cancelBidding", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iBiddingPostId": iCabBookingId, "Reason": reason, "iCancelReasonId": iCancelReasonId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.isLoadingMore = false
                        self.extraHeightContainer.removeAll()
                        self.dataArrList.removeAll()
                        self.tableView.reloadData()
                        self.nextPage_str = 1
                        self.getDtata(isLoadingMore: false)
                    })
                }else{
                    if(dataDict.get(Utils.message_str) == "DO_RESTART"){
                        let window = Application.window
                        
                        let getUserData = GetUserData(uv: self, window: window!)
                        getUserData.getdata()
                        
                        return
                    }
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }

   
        

    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
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
            self.cntView.isHidden = true
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
