

import UIKit
import SysBaseLib

class BiddingDetialsUV: ParentViewUV,ParentViewUVDelegate,MXParallaxHeaderDelegate,UITableViewDelegate, UITableViewDataSource,MyBtnClickDelegate, ExpandableLabelDelegate {

    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerStaticView: UIView!
    @IBOutlet weak var bidLbl: MyLabel!
    @IBOutlet weak var categoryLbl: MyLabel!
    @IBOutlet weak var bidAmountLbl: MyLabel!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var headerSubView: UIView!
    @IBOutlet weak var descriptionLbl: MyLabel!
    @IBOutlet weak var desCriptionDLbl: ExpandableLabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblHeaderView: UIView!
    @IBOutlet weak var descLblHight: NSLayoutConstraint!
    @IBOutlet weak var bidAmountSLbl: MyLabel!
    @IBOutlet weak var dateLblTop: NSLayoutConstraint!
    @IBOutlet weak var cancelLbl: MyLabel!
    
    @IBOutlet weak var parentPhView1: UIView!
    @IBOutlet weak var parentPhView2: UIView!
    @IBOutlet weak var parentPhView3: UIView!
    @IBOutlet weak var parentPhView4: UIView!
    @IBOutlet weak var parentPhView5: UIView!
    @IBOutlet weak var parentPhView6: UIView!
    
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var dictData:NSDictionary!
    var reOfferView:ReofferView!
    var generalFunc = GeneralFunctions()
    var dataArrList = [NSDictionary]()
    var biddingPostId = ""
    var driverId = ""
    var amount = ""
    var desTxt = ""
    var isDirect = false
    var cancelID = ""
    var cancelReason = ""
    var isLoadFirst = true
    var eWalletIgnore = "No"
    var isDataLoading = true
    var placeHolderView:UIView!
    var placeholderMarker:Placeholder!
    var isHederLoad = false
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }


    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "BiddingDetialsScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.addBack()
            
            //initializeSearchBar()
            placeHolderView = self.generalFunc.loadView(nibName: "BiddingDetailsPhView", uv: self, contentView: self.view)
            self.placeHolderView.clipsToBounds = true
            self.placeHolderView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height)
        
            Application.window!.addSubview(placeHolderView)
            if(self.isDataLoading == true){
                self.setPlaceHolderView()
            }
            self.setnavBarTintColor(color: SColors.Theme)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            self.setData()
        }else if(type == 1){
            
            self.configRTL()
           
            
        }else if(type == 2){
            
           
        }
        
    }
 
    func setData()  {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_DETAILS_OFFERS_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TASK_DETAILS_OFFERS_TXT")
        self.headerStaticView.backgroundColor = SColors.Theme
        
        self.getData()
        
    }
    func setHeaderData(){
        if !self.isHederLoad {
            if !isDirect {
                if  dictData.get("cancelReason") != "" || dictData.get("eStatus") == "Accepted" {
                    self.navigationItem.rightBarButtonItem = nil
                    
                }else{
                    let image = UIImage(named: "ic_header_refresh")!
                    let rightButton = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.getData))
                    self.navigationItem.rightBarButtonItem = rightButton
                    
                }
            }else{
                self.bidLbl.isHidden = true
            }
            if dictData != nil {
                self.categoryLbl.text = dictData.get("vServiceName")
                
                self.bidAmountLbl.text =  dictData.get("fBiddingAmount")
                self.bidAmountLbl.textColor = SColors.Theme
                self.bidAmountSLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BIDDING_TASK_BUDGET_TXT")
                self.dateLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: dictData.get("dBiddingDate"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateForateDateWithDayAndTime)
                if dictData.get("tDescription") != "" {
                    self.desCriptionDLbl.delegate = self
                    self.desCriptionDLbl.shouldCollapse = true
                    self.desCriptionDLbl.textReplacementType = .character
                    self.desCriptionDLbl.numberOfLines = 2
                    self.desCriptionDLbl.collapsed = true
                    
                    self.desCriptionDLbl.text = dictData.get("tDescription")
                    //self.descriptionLbl.text =   self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DESCRIPTION")
                    
                }else{
                    self.descLblHight.constant = 0
                    self.desCriptionDLbl.text = ""
                    self.descriptionLbl.text =   self.generalFunc.getLanguageLabel(origValue: "", key: "")
                }
                
                
            }
            if (Configurations.isRTLMode()){
                self.descriptionLbl.textAlignment = .natural
            }
            self.tblView.parallaxHeader.delegate = self
            self.tblView.parallaxHeader.view = self.tblHeaderView
            self.tblView.parallaxHeader.mode = .bottom
            if isLoadFirst {
                isLoadFirst = false
                
                if dictData.get("tDescription") != "" {
                    self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height + 20
                }else{
                    self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height
                }
            }
            if dictData.get("eStatus") == "Cancelled"{
                self.cancelLbl.text = dictData.get("cancelReason")
                self.cancelLbl.sizeToFit()
                self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height + 40
            }else{
                //self.
                //self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height - 20
                self.cancelLbl.text = ""
                //self.dateLblTop.constant = -25
            }
            self.bidLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BID_RECEIVED")
            
            self.tblView.parallaxHeader.minimumHeight = 0
            // self.headerSubView.layer.addShadow(opacity: , radius: )
            //self.headerSubView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
            // self.tblView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
            // self.headerSubView.layer.shadowOpacity = 0.0
            self.headerSubView.layer.shadowColor = UIColor.gray.cgColor
            self.headerSubView.layer.shadowOpacity = 0.3
            self.headerSubView.layer.shadowOffset = CGSize.zero
            self.headerSubView.layer.shadowRadius = 6
            self.tblView.dataSource = self
            self.tblView.delegate = self
            self.tblView.tableFooterView = UIView()
            self.tblView.separatorStyle = .none
            self.tblView.register(UINib(nibName: "BiddingDriverListTVC", bundle: nil), forCellReuseIdentifier: "BiddingDriverListTVC")
            self.isHederLoad = true
        }
    }
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        
       
    }
    
    @objc func getData()  {
        if(self.isDataLoading == true){
            self.setPlaceHolderView()
            self.cntView.alpha = 0
        }
            let parameters = ["type":"getBiddingPostInfo","iBiddingPostId" :biddingPostId,"page": "1"]
            
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
            exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
            exeWebServerUrl.currInstance = exeWebServerUrl
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
              
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.isDataLoading = false
                    self.cntView.alpha = 1
                    self.removePlaceHolderView()
                    
                }, completion:{ _ in})
                
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        let dataArr = dataDict.dictOf(Utils.message_str)
                        self.tblView.isHidden = false
                        self.dictData = dataArr
                        let temp = dataArr.arrOf("provider")
                        if temp.count == 0 {
                            self.bidLbl.isHidden = true
                        }else{
                            self.bidLbl.isHidden = false
                        }
                        if !self.isDirect {
                        self.dataArrList = temp as! [NSDictionary]
                        }
                        if self.dataArrList.count <= 0 {
                            self.tblView.isScrollEnabled = false
                        }else{
                            self.tblView.isScrollEnabled = true
                        }
                        self.tblView.bounces = false
                        self.setHeaderData()
                        self.tblView.reloadData()
//                        for i in 0 ..< dataArr.count{
//                            let dataTemp = dataArr[i] as! NSDictionary
//
//                            self.dataArrList += [dataTemp]
//
//                        }
 
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
                
            })
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        return self.dataArrList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiddingDriverListTVC", for: indexPath) as! BiddingDriverListTVC
        
        let item = self.dataArrList[indexPath.item]
//        cell.parentView.layer.shadowOpacity = 1.5
//        cell.parentView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        cell.parentView.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
//        cell.parentView.layer.masksToBounds = false
        cell.parentView.layer.shadowColor = UIColor.gray.cgColor
        cell.parentView.layer.shadowOpacity = 0.3
        cell.parentView.layer.shadowOffset = CGSize.zero
        cell.parentView.layer.shadowRadius = 6
        cell.parentView.layer.cornerRadius = 10
      // Utils.createRoundedView(view: cell.parentView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
        cell.btndecline.tag = indexPath.item
        cell.btnAccpet.tag = indexPath.item
        cell.btnReoffer.tag = indexPath.item
        print(cell.btnReoffer.tag)
        cell.driverNameLbl.text = item.get("vName")
        if item.get("eStatusMsg") != "" {
            cell.waitingLbl.text = item.get("eStatusMsg")
            cell.waitingLbl.textColor = .black
        }else{
            if item.get("biddingConfirmAmount") != "" {
            cell.waitingLbl.text = item.get("biddingfinalAmountTitle") + ": " + item.get("biddingConfirmAmount")
                cell.waitingLbl.textColor = .red
            }else{
                cell.waitingLbl.text = item.get("eStatusMsg")
                cell.waitingLbl.textColor = .black
            }
        }
        
        
        if  cell.waitingLbl.text == "" {
            //cell.waitingLblHight.constant = 0
        }else{
            //cell.waitingLblHight.constant = 20
        }
        
        cell.ratingView.rating = GeneralFunctions.parseFloat(origValue: 0, data: item.get("vAvgRating"))
        cell.btndecline.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        cell.btndecline.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Decline", key: "LBL_DECLINE_TXT").uppercased())
        cell.btndecline.btnType = "Decline"
        cell.btndecline.clickDelegate = self
        
        cell.btnAccpet.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 0, cornerRadius: 5)
        
        if (item.get("showConfirmBtn")).uppercased() == "YES" {
            cell.btnAccpet.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Accept", key: "LBL_CONFIRM_TXT").uppercased())
        }else{
            cell.btnAccpet.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Accept", key: "LBL_ACCEPT_TXT").uppercased())
        }
        cell.btnAccpet.btnType = "Accept"
        cell.btnAccpet.clickDelegate = self
        
        cell.btnReoffer.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        cell.btnReoffer.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "RE OFFER", key: "LBL_REOFFER_TXT").uppercased())
        cell.btnReoffer.btnType = "ReOffer"
        cell.btnReoffer.clickDelegate = self
        cell.imageChat.tag = indexPath.item
        
        cell.imageChat.handleClick { instance in
            self.openChat(tag: cell.imageChat.tag)
        }
        cell.driverImageView.sd_setImage(with: URL(string: item.get("vImage")), placeholderImage: UIImage(named: "ic_no_pic_user")!,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        Utils.createRoundedView(view: cell.driverImageView, borderColor: UIColor.clear, borderWidth: 0)
        
        
//        if item.get("showReofferBtn") == "No" {
//            cell.amountByMeHight.constant = 0
//            cell.amountByDriverHight.constant = 0
//            cell.waitingToplbl.constant = 5
//        }else{
//            cell.amountByMeHight.constant = 15
//            cell.amountByDriverHight.constant = 15
//            cell.amountByMeLbl.text = "Amount By me : " + item.get("biddingAmount")
//
//            cell.amountByMeLbl.textColor = SColors.Theme
//
//            cell.amountByDriverLbl.text = item.get("biddingReofferAmountTitle") + " : " + item.get("biddingReofferAmount")
//            cell.amountByDriverLbl.textColor = .red
//            cell.waitingToplbl.constant = 34
//        }
//        if item.get("eStatus") == "Accepted" {
//            cell.amountByMeLbl.text = item.get("biddingfinalAmountTitle") + ": " + item.get("biddingFinalAmount")
//            cell.amountByMeLbl.textColor = .red
//            cell.amountByMeHight.constant = 15
//            cell.driverDesTop.constant = 10
       // }else{
        if item.get("biddingAmount") != "" {
            cell.amountByMeLbl.text = item.get("biddingAmountTitle") + item.get("biddingAmount")
            cell.amountByMeLbl.textColor = SColors.Theme
            //cell.amountByMeHight.constant = 15
            cell.driverDesTop.constant = 10
        }else{
           // cell.amountByMeHight.constant = 0
            cell.amountByMeLbl.text = ""
            cell.driverDesTop.constant = -20
        }
        
        if item.get("biddingFinalAmount") != "" {
                   cell.amountByMeLbl.text = item.get("biddingfinalAmountTitle") + ": " + item.get("biddingFinalAmount")
                   cell.amountByMeLbl.textColor = .red
                  // cell.amountByMeHight.constant = 15
                   cell.driverDesTop.constant = 10
        
        }
        if item.get("biddingReofferAmount") != "" {
            
            
            cell.amountByDriverLbl.text = item.get("biddingReofferAmountTitle") + " : " + item.get("biddingReofferAmount")
            cell.amountByDriverLbl.textColor = .red
           
        }else{
           // cell.amountByDriverHight.constant = 0
            cell.amountByDriverLbl.text = ""
        }
         
        if  item.get("showAcceptBtn") != "Yes" &&  item.get("showDeclineBtn") != "Yes" {
            cell.stackViewHight.constant = 0
            cell.btnAccpet.isHidden = true
            cell.btndecline.isHidden = true
        }else{
            cell.stackViewHight.constant = 50
            cell.btnAccpet.isHidden = false
            cell.btndecline.isHidden = false
        }
        if item.get("description_user") != "" {
            //cell.userDisLbl.delegate = self
            //cell.userDisLbl.shouldCollapse = true
//            cell.userDisLbl.textReplacementType = .character
//            cell.userDisLbl.shouldCollapse = false
//            cell.userDisLbl.numberOfLines = 2
//            cell.userDisLbl.collapsed = true
            cell.userDisLbl.textColor = SColors.Theme
            cell.userDisLbl.text = "(" + item.get("description_user") + ")"
            //cell.userDisLbl.shouldExpand = true
            
            let rect = CGSize(width: cell.userDisLbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let labelSize =  cell.userDisLbl.text!.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:  cell.userDisLbl.font], context: nil)
             let linecount =  Int(ceil(CGFloat(labelSize.height) /  cell.userDisLbl.font.lineHeight))
            if linecount >= 2 {
                cell.userReadMoreLblHight.constant = 15
                cell.userReadMoreLbl.isHidden = false
                cell.userReadMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "Read More", key: "LBL_READ_MORE_TXT")
            }else{
                cell.userReadMoreLblHight.constant = 0
                cell.userReadMoreLbl.isHidden = true
                cell.userReadMoreLbl.text = ""
            }
            

            //item.get("description_user")
            
            
            cell.userReadMoreLbl.tag = indexPath.row
            cell.userReadMoreLbl.handleClick { instance in
                
                let item = self.dataArrList[indexPath.item]
                let temp = "(" + item.get("description_user") + ")"
                self.generalFunc.setError(uv: self, title: "", content: temp )
                
            }
            cell.userDisLbl.isHidden = false
            cell.userDesTop.constant = 6
        }else{
            cell.userDisLbl.isHidden = true
            cell.userReadMoreLblHight.constant = 0
            cell.userReadMoreLbl.isHidden = true
            cell.userDesTop.constant = -10
        }
        if item.get("description_driver") != "" {
            //cell.driverDis.delegate = self
            //cell.driverDis.shouldCollapse = true
            //cell.driverDis.textReplacementType = .character
            //cell.driverDis.numberOfLines = 2
            //cell.driverDis.collapsed = true
            //item.get("description_driver")
            cell.driverDisLbl.text = "(" + item.get("description_driver")  +  ")"
            cell.driverDisLbl.isHidden = false
            cell.driverDisLbl.textColor = UIColor.red
            let rect = CGSize(width: cell.driverDisLbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let labelSize = cell.driverDisLbl.text!.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:  cell.driverDisLbl.font], context: nil)
             var linecount =  Int(ceil(CGFloat(labelSize.height) /  cell.driverDisLbl.font.lineHeight))
            if linecount > 2 {
                cell.driverReadMoreLblHight.constant = 15
                cell.driverReadMoreLbl.isHidden = false
                cell.ratingViewTop.constant = 15
                cell.driverReadMoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "Read More", key: "LBL_READ_MORE_TXT")
            }else{
                cell.driverReadMoreLblHight.constant = 0
                cell.driverReadMoreLbl.isHidden = true
                cell.ratingViewTop.constant = 10
                cell.driverReadMoreLbl.text = ""
            }
            cell.driverReadMoreLbl.handleClick { instance in
                
                let item = self.dataArrList[indexPath.item]
                let temp = "(" + item.get("description_driver") + ")"
                self.generalFunc.setError(uv: self, title: "", content: temp )
                
            }
            
        }else{
            cell.driverDisLbl.isHidden = true
            cell.driverReadMoreLblHight.constant = 0
            cell.driverReadMoreLbl.isHidden = true
            cell.ratingViewTop.constant = 10
        }
        
        if item.get("showReofferBtn") == "No" || item.get("showReofferBtn") == ""{
            cell.btnReOfferHight.constant = 0
            cell.btnReoffer.isHidden = true
        }else{
            cell.btnReOfferHight.constant = 50
            cell.btnReoffer.isHidden = false
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
       
        return cell
    }
    func myBtnTapped(sender: MyButton) {
        if sender.btnType != "Ok" {
        let item = self.dataArrList[sender.tag]
        self.driverId = item.get("iDriverId")
        }
        if sender.btnType == "Accept" {
            //GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Bidding  ", uv: self)
            
        //self.biddingStatus(type: "Accepted")
            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_ACCEPT_BIDDING_TASK_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                           if btnClickedIndex == 0 {
                               //self.biddingStatus(type: "Accepted")
                               GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=Bidding  ", uv: self)
                           }
                       })
        }else if sender.btnType == "ReOffer" {
            self.openReofferView()
        }else if sender.btnType == "Decline" {
            self.cancelBooking(position: sender.tag)
        }
        else if sender.btnType == "Ok"{
//            if  self.reOfferView.amtTxtField.text == "" {
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please Enter Amount", key: "LBL_PLS_ENTER_AMT_TXT"), uv: self)
//                return
            var required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
            let fNameEntered = Utils.checkText(textField: self.reOfferView.amtTxtField.getTextField()!) ? true : Utils.setErrorFields(textField: self.reOfferView.amtTxtField.getTextField()!, error: required_str)
            if !fNameEntered {
                return
            
            }else{

                self.reOfferView.removeFromSuperview()
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_RE_OFFER_BIDDING_TASK_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                               if btnClickedIndex == 0 {
                                   self.amount = self.reOfferView.amtTxtField.text
                                   self.desTxt = self.reOfferView.commentTxtView.text
                                   self.biddingStatus(type: "Reoffer")
                                   
                               }
                           })
            }
        }else if sender.btnType == "Cancel" {
            self.reOfferView.removeFromSuperview()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableView.automaticDimension

       
        
       
//        let item = self.dataArrList[indexPath.item]
//
//        var defalutHight = 140
//        if  item.get("biddingAmount") != ""  ||  item.get("biddingFinalAmount") != ""{
//
//            defalutHight = defalutHight + 30
//        }
//        if item.get("description_user") != "" {
//
//            defalutHight = defalutHight + 30
//        }
//        if item.get("biddingReofferAmount") != ""{
//
//            defalutHight = defalutHight + 30
//        }
//        if item.get("description_driver") != "" {
//            defalutHight = defalutHight + 30
//        }
//        if  item.get("showDeclineBtn") != "Yes" &&  item.get("showAcceptBtn") != "Yes" {
//
//        }else{
//            defalutHight = defalutHight + 50
//        }
//        if item.get("showReofferBtn") == "Yes"{
//            defalutHight = defalutHight + 50
//        }
//        return CGFloat(defalutHight)
    }
    func biddingStatus(type : String ,_ isOutStandingAdjusted:String = "")  {
        
        var parameters = ["type":"updateBiddingStatus","iBiddingPostId" :biddingPostId,"eStatus" : type, "iDriverId": self.driverId,"UserType" : Utils.appUserType , "iUserId" : GeneralFunctions.getMemberd(),"eWalletIgnore" : eWalletIgnore]
        if type == "Reoffer" {
            parameters["amount"] = self.amount
            parameters["description"] = self.desTxt
        }
        if type == "Decline" {
            parameters["iCancelReasonId"] = self.amount
            parameters["vCancelReason"] = self.desTxt
        }
        if isOutStandingAdjusted != "" {
            parameters["isOutStandingAdjusted"] = isOutStandingAdjusted
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if (GeneralFunctions.parseDouble(origValue: 0.0, data: dataDict.get("fOutStandingAmount"))) > 0 {
                  
                        
                        self.openOutStandingAmountBox(isFromRideNow: true, dataDict: dataDict)
                        return
                    }
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        if type == "Decline" {
                            self.close()
                        }else {
                        self.setHeaderData()
                        self.getData()
                        }
                    })
                    
                    return
//                    let data = dataDict.dictOf("message") as! NSDictionary
//                    self.setData(data: data)
                }else if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                    
                    var msgtxt = ""
                    if(dataDict.get("low_balance_content_msg") == ""){
                        msgtxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BAL")
                    }else{
                        msgtxt = dataDict.get("low_balance_content_msg")
                    }
                    
                    var nagativeBtnTxt = ""
                    if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() == "YES"){
                        nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
                    }else{
                        nagativeBtnTxt = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")
                    }
                    
                    if(nagativeBtnTxt == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT")){
                        self.generalFunc.setAlertMsg(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtnLBL: nagativeBtnTxt, naturalBtnLBL: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                            if(btnClickedIndex == 0){
                                
                                
                                
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                            }else if(btnClickedIndex == 1){
                                
                                if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                    //self.continueRideLaterSchedule(isFromWalletChk, true)
                                    //self.bidd
                                    self.eWalletIgnore = "Yes"
                                    self.biddingStatus(type: type)
                                }else{
                                  
                                }
                                
                            }else{
                                
                            }
                        })
                    }else{
                        self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LOW_WALLET_BALANCE"), content: msgtxt, positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: nagativeBtnTxt, completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                
                               
                                
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(manageWalletUV, animated: true)
                            }else{
                                
                                if(dataDict.get("IS_RESTRICT_TO_WALLET_AMOUNT").uppercased() != "YES"){
                                   // self.continueRideLaterSchedule(isFromWalletChk, true)
                                    self.eWalletIgnore = "Yes"
                                    self.biddingStatus(type: type)
                                }else{
                                    
                                }
                                
                            }
                            
                        })
                    }
                   
                    return
                }
                else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
            
        })
    }
    @IBAction func unwindToBiddingDetials(_ segue:UIStoryboardSegue) {
        
        if(segue.source.isKind(of: AddPaymentUV.self))
        {
            self.biddingStatus(type: "Accepted")
        }
    }

func openReofferView()  {
    self.reOfferView = ReofferView(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height:Application.screenSize.height))
    self.reOfferView.commentTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Description", key: "LBL_DESCRIPTION_TXT")
    self.reOfferView.commentTxtView.layer.borderColor = SColors.Theme.cgColor
    self.reOfferView.commentTxtView.layer.borderWidth = 1.0
    self.reOfferView.commentTxtView.layer.cornerRadius = 5.0
    self.reOfferView.amtTxtField.layer.borderColor = SColors.Theme.cgColor
    self.reOfferView.amtTxtField.layer.borderWidth = 1.0
    self.reOfferView.amtTxtField.layer.cornerRadius = 5.0
    self.reOfferView.amtTxtField.configDivider(isDividerEnabled: false)
    self.reOfferView.amtTxtField.getTextField()!.keyboardType = .numberPad
    self.reOfferView.amtTxtField.textPadding = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
   
    self.reOfferView.amtTxtField.placeHolder = "  "   + self.generalFunc.getLanguageLabel(origValue: "Enter amount", key: "LBL_ENTER_AMOUNT_TXT")
    
    self.reOfferView.btnCancel.setCustomColor(textColor: SColors.Theme, bgColor: SColors.ThemeTxt, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
    self.reOfferView.btnCancel.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT").uppercased())
    self.reOfferView.btnCancel.btnType = "Cancel"
    self.reOfferView.btnCancel.clickDelegate = self
    self.reOfferView.btnOk.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
    self.reOfferView.btnOk.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_OK_TXT").uppercased())
    self.reOfferView.btnOk.btnType = "Ok"
    self.reOfferView.btnOk.clickDelegate = self
    self.reOfferView.reofferLbl.text = self.generalFunc.getLanguageLabel(origValue: "RE OFFER", key: "LBL_RE_OFFER_TXT").uppercased()
    let window = Application.window
   window?.addSubview(self.reOfferView)
}
    func declineView()  {
        let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
        openUserPreferences.isShowCancel = true
        openUserPreferences.isFromEmailVerify = true
        openUserPreferences.isFromBidding = true
        openUserPreferences.show(preferenceDescription:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TASK_CONFIRM_MSG") , title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TASK"))
       // openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TASK_CONFIRM_MSG"), self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DECLINE_TASK"))
    }
    func cancelBooking(position:Int){
        let openCancelBooking = OpenCancelBooking(uv: self)
        openCancelBooking.isFromBiddig = true
        openCancelBooking.cancelTrip(eTripType: "Bidding", iTripId: "", iCabBookingId: biddingPostId) { (iCancelReasonId, reason) in
            //self.continueCancelBooking(iCabBookingId: self.biddingPostId, reason: reason, iCancelReasonId: iCancelReasonId)
            self.cancelID = iCancelReasonId
            self.cancelReason = reason
            self.declinePopUp()
            //self.biddingStatus(type: "Decline")
        }
    }
    func declinePopUp(){
        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_DECLINE_BIDDING_TASK_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                       if btnClickedIndex == 0 {
                           self.biddingStatus(type: "Decline")
                       }
                   })
    }
    func continueCancelBooking(iCabBookingId: String, reason:String, iCancelReasonId: String){
        let parameters = ["type":"cancelBidding", "iUserId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iBiddingPostId": biddingPostId, "Reason": reason, "iCancelReasonId": iCancelReasonId,"iDriverId": self.driverId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.getData()
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

    
    func openChat(tag : Int){
         let item = self.dataArrList[tag]
        print(item)
        let chatUV = GeneralFunctions.instantiateViewController(pageName: "MessagesViewController") as! MessagesViewController
        chatUV.receiverId = item.get("iDriverId")
        chatUV.receiverDisplayName = item.get("vName")
        chatUV.assignedtripId = item.get("iBiddingPostId")
        chatUV.pPicName = item.get("vImage")
        chatUV.bookingNo = item.get("vBiddingPostNo")
        chatUV.isBidding = true
        chatUV.driverId = item.get("iDriverId")
        self.push(uv:chatUV, isDirect: true)
    }
    // placehoder View Changes
    func setPlaceHolderView(){
            self.placeHolderView.alpha = 1.0
            placeholderMarker = Placeholder()
        let viewElements: [UIView] = [parentPhView1,parentPhView2,parentPhView3,parentPhView4 ,parentPhView5,parentPhView6]
            
            placeholderMarker.register(viewElements)
            placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.placeHolderView != nil){
            self.cntView.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {self.placeHolderView.alpha = 0.0},
                                            completion: {(value: Bool) in
                                                if(self.placeholderMarker != nil){
                                                    self.placeholderMarker.remove()
                                                }
                                                
                                                        })
        }
    }
    
    
    func willExpandLabel(_ label: ExpandableLabel) {
       
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        if label == desCriptionDLbl {
            desCriptionDLbl.setNeedsLayout()
            desCriptionDLbl.layoutIfNeeded()
        }
        
        self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height + 20
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
       
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        if label == desCriptionDLbl {
            desCriptionDLbl.setNeedsLayout()
            desCriptionDLbl.layoutIfNeeded()
        }
        self.tblView.parallaxHeader.height = self.tblHeaderView.frame.size.height - 20
    }
    func openOutStandingAmountBox(isFromRideNow:Bool, dataDict:NSDictionary){
        
        let openOutStandingAmtView = OpenOutStandingView(uv: self, containerView: self.view)
        openOutStandingAmtView.show(userProfileJson: self.userProfileJson, currentCabGeneralType: "Bidding", dataDict: dataDict) { (isPayNow, isAdjustAmount) in
            
            if(isPayNow){
                
                let type = "Bidding"
                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=\(type)&ePaymentType=ChargeOutstandingAmount", uv: self)
  
                
            }else if(isAdjustAmount){
                //self.biddingStatus(type: "Accepted")
                self.biddingStatus(type: "Accepted" , "Yes")
            }
        }
    }
    
    
    @objc func keyboardWillDisappear(sender: NSNotification){
        let info = sender.userInfo!
       let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    
        
        if(self.reOfferView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.reOfferView.frame.origin.y = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
       
    }
    @objc func keyboardWillAppear(sender: NSNotification){
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        if(self.reOfferView != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.reOfferView.frame.origin.y = -150
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
        
       
        
    }
    
}

