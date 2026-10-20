

import UIKit
import SysBaseLib

class NotificationsUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, ParentViewUVDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var msgLbl: UILabel!
    
    var cntView:UIView!
    
    var tableView:UITableView!
    
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    var loaderView:UIView!
    var dataArrList = [NSDictionary]()
    var nextPage_str = 1
    var isLoadingMore:Bool = false
    var isNextPageAvail:Bool = false
    var currentWebTask:ApiHandler!
    
    var type = ""
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        if(type.uppercased() == "ALL"){
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ALL"))
        }else if(type.uppercased() == "NEWS"){
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NEWS"))
        }else{
            return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOTIFICATIONS"))
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "NotificationsScreenDesign", uv: self, contentView: containerView)
            self.containerView.addSubview(cntView)
            
            self.cntView.backgroundColor = SColors.ThemeTxt
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
            self.tableView.register(UINib(nibName: "NotificationTVCell", bundle: nil), forCellReuseIdentifier: "NotificationTVCell")
            
            self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8 + GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            
            self.containerView.frame.size = CGSize(width: Application.screenSize.width, height: self.view.frame.height)
            self.tableView.frame.size = CGSize(width: Application.screenSize.width, height: self.view.frame.height)
            self.cntView.layoutIfNeeded()
            self.tableView.layoutIfNeeded()
            
            self.nextPage_str = 1
            self.isLoadingMore = false
            self.isNextPageAvail = false
            self.dataArrList.removeAll()
            self.tableView.reloadData()
            self.getDtata(isLoadingMore: self.isLoadingMore, true)
            
        }else if(type == 3){
            self.navigationController?.navigationBar.zPosition = -1
        }
    }
    
    func getDtata(isLoadingMore:Bool, _ isFromViewLoad:Bool = false){
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.cntView)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil && isLoadingMore == false){
            loaderView.isHidden = false
        }
        
        
        if(currentWebTask != nil){
            currentWebTask.cancel()
        }
        
        let parameters = ["type":"getNewsNotification", "UserType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd(), "page": self.nextPage_str.description, "eType": type]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        currentWebTask = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                
                if(dataDict.get("Action") == "1"){
                    
                    self.msgLbl.isHidden = true
                    let dataArr = dataDict.arrOf(Utils.message_str)
                
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList.append(dataTemp)
                       
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
                    
                    
                    
                }else{
                    if(isLoadingMore == false){
                        self.msgLbl.isHidden = false
                        self.msgLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message"))
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
                    
                }
            }else{
                if(isLoadingMore == false){
                    self.generalFunc.setError(uv: self)
                }
            }
            
            self.isLoadingMore = false
            self.loaderView.isHidden = true
        })
    }
    
    // TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell", for: indexPath) as! NotificationTVCell
        
        let itemDic = self.dataArrList[indexPath.row]
        
        cell.subTitleLbl.text = itemDic.get("tDescription")
        
        if (itemDic.get("vTitle") == ""){
            cell.titleLbl.text = ""
           
            cell.descTopSpace.constant = 0
        }else{
            cell.titleLbl.text = itemDic.get("vTitle")

            cell.descTopSpace.constant = 7.5
        }
        
        cell.titleLbl.sizeToFit()
        cell.containerView.layer.shadowOpacity = 0.4
        cell.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.containerView.layer.shadowOffset = CGSize.zero
        cell.containerView.clipsToBounds = true
        cell.containerView.masksToBounds = false
        cell.selectionStyle = .none
        
       // cell.dateLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: itemDic.get("dDateTime"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateInList)
        
        let tTripBookingDateOrig = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: itemDic.get("dDateTime"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime)
        
        let tTripBookingDateOrigNameStr = tTripBookingDateOrig.components(separatedBy: ",")[0]
        
        let tTripBookingDayMonthStr = tTripBookingDateOrig.components(separatedBy: ",")[1].components(separatedBy: " ")
        let tTripBookingMonthStr = tTripBookingDayMonthStr[1]
        let tTripBookingDayStr = tTripBookingDayMonthStr[2]
        
        let tTripBookingTimeYearStr = tTripBookingDateOrig.components(separatedBy: ",")[2].components(separatedBy: " ")
        
        let tTripBookingYearStr = tTripBookingTimeYearStr[1]
        
        cell.dateLbl.text = String(format: "%@ %@, %@ (%@)", tTripBookingDayStr, tTripBookingMonthStr, tTripBookingYearStr, tTripBookingDateOrigNameStr)
        
        cell.readMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_READ_MORE")
        
        cell.readMoreLbl.textColor = SColors.ThemeTxt
        
        if (Configurations.isRTLMode() == true){
            cell.dateLbl.textAlignment = .right
            cell.readMoreLbl.textAlignment = .center
        }else{
            cell.dateLbl.textAlignment = .left
            cell.readMoreLbl.textAlignment = .center
            
        }
        
        cell.readMoreLbl.backgroundColor = SColors.Theme
        cell.readMoreLbl.tag = indexPath.row
        cell.readMoreLbl.setClickHandler { (instance) in
            
            let notiDetailUv = GeneralFunctions.instantiateViewController(pageName: "NotificationDetailUV") as! NotificationDetailUV
            notiDetailUv.dataDic = self.dataArrList[instance.tag]
            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(notiDetailUv, animated: true)
           
        }
        cell.readMoreLbl.roundTo(corners: [.bottomRight, .topRight,.topLeft,.bottomLeft], radius: 4)
//        if(Configurations.isRTLMode() == true){
//            cell.readMoreLbl.roundTo(corners: [.bottomRight, .topRight], radius: 4)
//        }else{
//            cell.readMoreLbl.roundTo(corners: [.bottomLeft, .topLeft], radius: 4)
//        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        let itemDic = self.dataArrList[indexPath.row]
        if (itemDic.get("vTitle") == ""){
            return 120
        }else{
            return 140 + itemDic.get("vTitle").height(withConstrainedWidth: Application.screenSize.width - 70, font: UIFont.init(name: Fonts().semibold, size: 16)!)
        }
     
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
        loaderView.backgroundColor = UIColor(hex: 0xf1f1f1)
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.tableView.tableFooterView  = loaderView
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
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
