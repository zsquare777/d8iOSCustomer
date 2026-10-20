

import UIKit
import SysBaseLib

class UFXProviderReviewsUV: ParentViewUV, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate  {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var avgratingHLbl: MyLabel!
    @IBOutlet weak var avgratingview: RatingView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noServiceLbl: MyLabel!
    
    let generalFunc = GeneralFunctions()
    var providerInfo:NSDictionary!
    
    var cntView:UIView!
    
    var loaderView:UIView!
    
    var dataArrList = [NSDictionary]()
    var textSizeArr = [CGFloat]()
    
    var nextPage_str = 1
    var isLoadingMore = false
    var isNextPageAvail = false
    var providerInfoTabUV:UFXProviderInfoTabUV!
    private var lastContentOffset: CGFloat = 0
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title: self.generalFunc.getLanguageLabel(origValue: "Reviews", key: "LBL_REVIEWS"))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            self.contentView.addSubview(self.generalFunc.loadView(nibName: "UFXProviderReviewsScreenDesign", uv: self, contentView: contentView))
            self.contentView.backgroundColor =  SColors.ThemeTxt//UIColor(hex: 0xf1f1f1)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.bounces = false
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.register(UINib(nibName: "UFXProviderReviewsTVCell", bundle: nil), forCellReuseIdentifier: "UFXProviderReviewsTVCell")
            
            self.tableView.contentInset = UIEdgeInsets.init(top: 6, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 10, right: 0)
            
            self.avgratingHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AVERAGE_RATING_TXT")
            self.perform(#selector(self.loadProviderReviews), with: self, afterDelay: 0.5)
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 3){
            self.providerInfoTabUV.view.layoutIfNeeded()
            self.providerInfoTabUV.topProfileViewHeight.constant = 100
            self.providerInfoTabUV.hideShowProfileView(isHide: false)
            UIView.animate(withDuration: 0.15, animations: {
                self.providerInfoTabUV.view.layoutIfNeeded()
            })
        }
    }
    

    
    @objc func loadProviderReviews(){
        
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.contentView)
            loaderView.backgroundColor = Color.clear
        }else if(loaderView != nil && isLoadingMore == false){
            loaderView.isHidden = false
        }
        
        let parameters = ["type":"loadDriverFeedBack", "iDriverId": providerInfo.get("driver_id"), "SelectedCabType": Utils.cabGeneralType_UberX, "UserType": "Driver", "page": self.nextPage_str.description]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
               
                    self.avgratingview.rating = dataDict.dictOf(Utils.message_str).get("vAvgRating") == "" ? 0 : Float(dataDict.dictOf(Utils.message_str).get("vAvgRating"))!
                   
                    for i in 0 ..< dataArr.count{
                        let dataTemp = dataArr[i] as! NSDictionary
                        
                        self.dataArrList += [dataTemp]
                        
                        var msgHeight = dataTemp.get("vMessage").height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont(name: Fonts().light, size: 15)!)
                        if(dataTemp.get("vMessage") == ""){
                            msgHeight = 0
                        }
                        
                        self.textSizeArr += [msgHeight]
                        
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
                    if(self.isLoadingMore == false){
                        if(self.cntView != nil){
                            _ = GeneralFunctions.addMsgLbl(contentView: self.cntView, msg: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                        }
                        
                    }else{
                        self.isNextPageAvail = false
                        self.nextPage_str = 0
                        
                        self.removeFooterView()
                    }
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
                
                if(self.isLoadingMore == false){
                    self.generalFunc.setError(uv: self)
                }
            }
            
            self.isLoadingMore = false
            if(self.dataArrList.count == 0){
                self.noServiceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_DATA_AVAIL")
                self.noServiceLbl.isHidden = false
            }else{
                self.noServiceLbl.isHidden = true
            }
            
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.dataArrList[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProviderReviewsTVCell", for: indexPath) as! UFXProviderReviewsTVCell
        cell.ratingBar.fullStarColor = SColors.selected_rate_color
        cell.ratingBar.emptyStarColor = SColors.unSelected_rate_color
        self.shadowOnview(view: cell.containerView)
        cell.nameLbl.text = item.get("vName")
        if(Configurations.isRTLMode()){
            cell.nameLbl.textAlignment = .right
        }else{
            cell.nameLbl.textAlignment = .left
        }
        cell.selectionStyle = .none
        cell.ratingBar.rating = item.get("vRating1") == "" ? 0 : Float(item.get("vRating1"))!
        cell.commentLbl.text = item.get("vMessage") == "" ? "" : item.get("vMessage")
        cell.commentLbl.fit()
        
//        cell.containerView.layer.shadowOpacity = 0.4
//        cell.containerView.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.containerView.layer.shadowOffset = CGSize.zero
//        cell.containerView.clipsToBounds = true
        
        cell.profilePicImgView.sd_setImage(with: URL(string: item.get("vImage")), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        
        Utils.createRoundedView(view: cell.profilePicImgView, borderColor: UIColor.lightGray, borderWidth: 1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 + self.textSizeArr[indexPath.item]
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       
        let currentOffset = scrollView.contentOffset.y;
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

        if (maximumOffset - currentOffset <= 15) {

            if(isNextPageAvail==true && isLoadingMore==false){

                isLoadingMore=true

                loadProviderReviews()
            }
        }
        
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
            
        }else if (scrollView.contentOffset.y <= 0) {
            
            self.providerInfoTabUV.view.layoutIfNeeded()
            
            self.providerInfoTabUV.topProfileViewHeight.constant = 100
            
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
    
    func addFooterView(){
        let loaderView =  self.generalFunc.addMDloader(contentView: self.tableView, isAddToParent: false)
        loaderView.backgroundColor = UIColor.clear
        loaderView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: 80)
        self.tableView.tableFooterView  = loaderView
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func removeFooterView(){
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        self.tableView.tableFooterView?.isHidden = true
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }

}
