

import UIKit
import SysBaseLib
import WebKit

struct GenieStoreData {
    
    var itemName : String
    var itemCount : String
    var extraPyament: Bool
 
}

class GenieFindStoreUV: ParentViewUV, MyBtnClickDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MXParallaxHeaderDelegate, WKNavigationDelegate, ParentViewUVDelegate  {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: MyButton!
    @IBOutlet weak var bottomAddressView: UIView!
    @IBOutlet weak var bottomPlaceImgView: UIImageView!
    @IBOutlet weak var bottomAddressViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBgView: UIView!
    @IBOutlet weak var headerStoreView: UIView!
    @IBOutlet weak var headerStoreImgView: UIImageView!
    @IBOutlet weak var makeAListLbl: MyLabel!
    @IBOutlet weak var submitBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var noContactDelLbl: MyLabel!
    @IBOutlet weak var addressLbl: MyLabel!
    @IBOutlet weak var addressChangeLbl: MyLabel!
    @IBOutlet weak var findStoreLbl: UILabel!
    @IBOutlet weak var findStoreArraowImgView: UIImageView!
    
    @IBOutlet weak var howItWorksLbl: MyLabel!
    @IBOutlet weak var bottomInfoImgView: UIImageView!
    @IBOutlet weak var bottomFareLbl: MyLabel!
    @IBOutlet weak var bottomInitialView: UIView!
    
    @IBOutlet weak var hWorksBGView: UIView!
    @IBOutlet weak var hWorksView: UIView!
    @IBOutlet weak var proceedBtn: MyButton!
    @IBOutlet weak var hWorksTitleLbl: MyLabel!
    @IBOutlet weak var hWorksLbl1View: MyLabel!
    @IBOutlet weak var hWorksImg1View: UIImageView!
    @IBOutlet weak var hWorksViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var findStoreAlertTitleLbl1: MyLabel!
    @IBOutlet weak var findStoreAlertSubTitleLbl1: MyLabel!
    @IBOutlet weak var findStoreAlertTitleLbl2: MyLabel!
    @IBOutlet weak var findStoreAlertSubTitleLbl2: MyLabel!
    @IBOutlet weak var findStoreAlertCancelImgView: UIImageView!
    @IBOutlet weak var fildStoreAlertSubmitBtn: MyButton!
    @IBOutlet weak var findStoreAlertView: UIView!
    
    @IBOutlet weak var billDetailsChargesView: UIView!
    @IBOutlet weak var billDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var billDetailsView: UIView!
    @IBOutlet weak var billDetailsHLbl: MyLabel!
    @IBOutlet weak var billDetailsProccedBtn: MyButton!
    @IBOutlet weak var billDetailFareHLbl1: MyLabel!
    @IBOutlet weak var billDetailFareVLbl1: MyLabel!
    @IBOutlet weak var billDetailFareHLbl2: MyLabel!
    @IBOutlet weak var billDetailFareVLbl2: MyLabel!
    @IBOutlet weak var billDetailsFareImgView: UIImageView!
    
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var cartItemArrays = [GenieStoreData] ()
    
    var currentselectedLat = ""
    var currentselectedLong = ""
    var currentAddress = ""
    
    var contactName = ""
    var storeName = ""
    var storeAddress = ""
    var storeLat = ""
    var storeLong = ""
    var titleFromHome = ""
    var storeAddressAdded = false
    var userSelectedAddressDic:NSDictionary!
    
    var userProfileJson:NSDictionary!
    
    var paymentMethod = "Cash"
    var usewWalletBal = "No"
    
    var disableCashPayValue = ""
    var ordeIdForDirectLiveTrack = ""
    
    var isFromPickDrop = false
    var isFromNearBy = false
    var isFromHome = false
    var webView:WKWebView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "GenieFindStoreScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            
            if(self.isFromPickDrop == true){
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICKUP_PARCEL")
            }else{
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_DELIVERY")
            }
            if isFromHome {
                self.title = self.titleFromHome
            }
            self.setData()
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
            self.navigationController?.navigationBar.zPosition = 1
            
        }else if(type == 3){
            self.navigationController?.navigationBar.zPosition = -1
        }else if(type == 2){
            self.setWebView()
        }
    }
    
    override func close() {
        if(isFromHome){
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            }else{
                self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
            }
            
           
        }else{
            super.close()
        }
    }
    
    func setData(){
        
        self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_new_info")!.resize(toHeight: 24)!.resize(toHeight: 24)!.tintTo(color: SColors.ThemeTxt), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.manageHowItWorksViewOpen))
        self.navigationItem.rightBarButtonItem = rightButton
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_latitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_longitude") && GeneralFunctions.isKeyExistInUserDefaults(key: "user_current_Address")){
            currentselectedLat = GeneralFunctions.getValue(key: "user_current_latitude") as! String
            currentselectedLong = GeneralFunctions.getValue(key: "user_current_longitude") as! String
            currentAddress = GeneralFunctions.getValue(key: "user_current_Address") as! String
        }
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        self.cartItemArrays.append(GenieStoreData.init(itemName: "DEFAULT", itemCount: "", extraPyament: false))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "GenieCartItemTVCell", bundle: nil), forCellReuseIdentifier: "GenieCartItemTVCell")
        self.tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        } else {}
        
        self.headerBgView.backgroundColor = SColors.Theme
        self.tableView.parallaxHeader.view = self.headerView
        self.tableView.parallaxHeader.height = 150 //200
        self.tableView.parallaxHeader.minimumHeight = 45
        self.tableView.parallaxHeader.mode = .bottom
        self.tableView.parallaxHeader.delegate = self
        
        self.tableView.reloadData()
        
        self.howItWorksLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_IT_WORKS_N")
        self.howItWorksLbl.textColor = SColors.ThemeTxt
        self.howItWorksLbl.backgroundColor =  .clear//SColors.Theme.dark(by: 40)//SColors.Theme_Dark.darker(by: 40)
        self.hWorksView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.hWorksView.layer.roundCorners(radius: 12)
       
        self.howItWorksLbl.handleClick { (instance) in
            self.manageHowItWorksViewOpen()
        }
        
        self.setupHeaderStoreView()
        
        self.makeAListLbl.layer.borderColor = UIColor.clear.cgColor
        if(self.isFromPickDrop == true){
            self.makeAListLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MAKE_LIST")
        }else{
            self.makeAListLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MAKE_LIST_ITEMS")
        }
        
        self.submitBtnHeight.constant = self.submitBtnHeight.constant //+ (Configurations.isIponeXDevice() ? 25 : 0)
        
        self.submitBtn.clickDelegate = self
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_DELIVERY_ADDRESS"))
        self.submitBtn.btnType = "DEL_ADDRESS"
       // self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Continue", key: "LBL_CONTINUE_BTN"))
        self.submitBtn.clickDelegate = self
        
        self.bottomAddressView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.bottomAddressView.layer.roundCorners(radius: 12)
        
        self.bottomInitialView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.bottomInitialView.layer.roundCorners(radius: 12)
        
        self.noContactDelLbl.borderColor = SColors.Theme
        self.noContactDelLbl.text = self.generalFunc.getLanguageLabel(origValue: "To avail no contact delivery call our partner to leave your order t the door.", key: "")
        
        self.addressChangeLbl.textColor = SColors.Theme
        self.addressChangeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE").uppercased()
        
        self.bottomFareLbl.text = "Starting at $40 for 2kms" // Need To Change
        GeneralFunctions.setImgTintColor(imgView: self.bottomInfoImgView, color: SColors.Theme)
        
        self.billDetailsProccedBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"))
        self.billDetailsProccedBtn.clickDelegate = self
        
        self.bottomAddressViewHeight.constant = 0
        self.bottomAddressView.isHidden = true
        self.bottomAddressViewEnable(isEbaled: false)
        
        self.addressChangeLbl.handleClick { (instance) in
            self.changeAddressTapped()
        }
        
        self.hWorksBGView.handleClick { (instance) in
            
            self.hWorksBGView.isHidden = true
            if(self.findStoreAlertView.isHidden == false){
                return
            }
            if(self.billDetailsView.isHidden == false){
                self.billDetailsView.isHidden = true
                return
            }
            
            self.manageHowItWorksViewClose()
//            self.manageHowItWorksView(isOpen:false)
        }
        if isFromHome || isFromNearBy {
            self.manageAdressFromDirectHome()
        }
    }
    
  
    func setWebView(){
        
          self.webView = WKWebView.init(frame: CGRect(x: 10, y:50, width: self.hWorksView.frame.width - 20, height: self.hWorksView.frame.height - 130))
          self.webView.navigationDelegate = self
          
          self.webView.backgroundColor = UIColor.clear
          self.hWorksView.addSubview(self.webView)
          
          self.webView.scrollView.bounces = false
          
          var page_desc = ""
          if(self.isFromPickDrop == true){
             page_desc = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_WORKS_PICK_DROP")
          }else{
             page_desc = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_IT_WORKS_N_NOTE")
          }
          
          let content = page_desc.replace("\n", withString: "<br>")
                         
          let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        

           if(Configurations.isRTLMode()){
               self.webView.loadHTMLString(headerString + "<html dir=\"rtl\"><body><p style=color:#343434>\(content)</p></body></html>", baseURL: nil)
           }else{
               self.webView.loadHTMLString(headerString + "<html><body><p style=color:#343434>\(content)</p></body></html>", baseURL:nil)
           }


          self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
          
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print(webView.scrollView.contentSize.height)
            
            
            var height = webView.scrollView.contentSize.height + 130
            
            if(height > Application.screenSize.height - 50){
                height = Application.screenSize.height - 50
            }
            
            self.view.layoutIfNeeded()
            self.hWorksViewHeight.constant = height
            self.webView.frame = CGRect(x: 10, y:50, width: self.hWorksView.frame.width - 20, height: self.hWorksViewHeight.constant - 130)

            UIView.animate(withDuration: 0.3, animations: {
                 self.view.layoutIfNeeded()
            })
           
        }
    }
    
    
    @objc func manageHowItWorksViewClose(){
        self.hWorksBGView.isHidden = true
        self.hWorksView.isHidden = true
        self.hWorksTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_IT_WORKS_N")
        
        self.proceedBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"))
        self.proceedBtn.clickDelegate = self
        GeneralFunctions.setImgTintColor(imgView: self.hWorksImg1View, color: SColors.Theme)
    }
    
    @objc func manageHowItWorksViewOpen(){
        self.hWorksBGView.isHidden = false
        self.hWorksView.isHidden = false
        self.hWorksTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_IT_WORKS_N")
        
        self.proceedBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"))
        self.proceedBtn.clickDelegate = self
        GeneralFunctions.setImgTintColor(imgView: self.hWorksImg1View, color: SColors.Theme)
    }
    
    func manageFindStoreAlertView(isOpen:Bool){
        if(isOpen){
          
            self.hWorksBGView.isHidden = false
            self.findStoreAlertView.isHidden = false
            
        }else{
            
            self.hWorksBGView.isHidden = true
            self.findStoreAlertView.isHidden = true
        }
        
        self.findStoreAlertCancelImgView.handleClick { (instance) in
            self.manageFindStoreAlertView(isOpen:false)
        }
        
        self.findStoreAlertTitleLbl1.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_STORE_OPEN")
        self.findStoreAlertSubTitleLbl1.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_STORE_OPEN_NOTE")
        
        self.findStoreAlertTitleLbl2.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HERE_HOW_HELP")
        self.findStoreAlertSubTitleLbl2.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HERE_HOW_HELP_NOTE")
        
        self.fildStoreAlertSubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN"))
        self.fildStoreAlertSubmitBtn.clickDelegate = self
    }
    
    
    func bottomAddressViewEnable(isEbaled:Bool){
        
        if(isEbaled){
            self.bottomAddressView.isUserInteractionEnabled = true
            
            self.bottomAddressView.alpha = 1.0
            self.submitBtn.alpha = 1.0
            
            self.submitBtn.setButtonEnabled(isBtnEnabled:true)
            
            if(self.userSelectedAddressDic != nil){
                self.bottomAddressViewHeight.constant = 100
                self.bottomAddressView.isHidden = false
                
                
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN"))
                self.submitBtn.btnType = "CONTINUE"
            }
            
        }else{
            
            self.submitBtn.setButtonEnabled(isBtnEnabled:false)
            self.bottomAddressView.isUserInteractionEnabled = false
            self.bottomAddressView.alpha = 0.5
            self.submitBtn.alpha = 0.5
        }
    }
    
    func setupHeaderStoreView(){
        
        self.headerStoreView.layer.addShadow(opacity: 0.5, radius: 2.5, UIColor.lightGray)
        self.headerStoreView.layer.roundCorners(radius: 10)
        
        if Configurations.isRTLMode() == true{
            var arrowImg = UIImage(named: "ic_arrow_right")
            arrowImg = arrowImg?.rotate(180)
            self.findStoreArraowImgView.image = arrowImg?.tintTo(color: UIColor.black)
        }
        
        GeneralFunctions.setImgTintColor(imgView: self.findStoreArraowImgView, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.headerStoreImgView, color: SColors.Theme)
        
        if(self.isFromPickDrop == true){
            self.findStoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_PICKUP_ADD")
        }else{
            self.findStoreLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_STORE_FOR_ITEM")
        }
        
        
        self.headerStoreView.handleClick { (instance) in
            
            if(self.isFromPickDrop == true){
                self.openAddAddressView()
            }else{
                var currentTimeString = ""
                        
                var tempDate:Date!
                if(GeneralFunctions.isKeyExistInUserDefaults(key: "GENIE_FINDSTORE_ALERT_CHECK")){
        
                    tempDate = Utils.convertStringToDate(dateStr: GeneralFunctions.getValue(key: "GENIE_FINDSTORE_ALERT_CHECK") as! String, dateFormat: Utils.dateForateDateWithDayAndTime)
                    
                    let diffComponents = Calendar.current.dateComponents([.hour], from: tempDate, to: Date())
                    let hours = diffComponents.hour
                    
        
                    if(hours ?? 0 >= 24){
                        
                        self.manageFindStoreAlertView(isOpen: true)
                        currentTimeString = Utils.convertDateToFormate(date: Date(), formate: Utils.dateForateDateWithDayAndTime)
                        
                        GeneralFunctions.saveValue(key: "GENIE_FINDSTORE_ALERT_CHECK", value: currentTimeString as AnyObject)
                    }else{
                        self.openAddAddressView()
                    }
                    
                }else{
                    self.manageFindStoreAlertView(isOpen: true)
                    currentTimeString = Utils.convertDateToFormate(date: Date(), formate: Utils.dateForateDateWithDayAndTime)
                    
                    GeneralFunctions.saveValue(key: "GENIE_FINDSTORE_ALERT_CHECK", value: currentTimeString as AnyObject)
                }
                        
            }
            
        }
        
    }
    
    func getDeliveryInfo(){
        
        let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")
        
        var iStoreName = ""
        var iStoreAddress = ""
        if(self.isFromPickDrop){
            iStoreName = self.contactName
            iStoreAddress = self.storeName + ", " + self.storeAddress
        }else{
            iStoreName = self.storeName
            iStoreAddress = self.storeAddress
        }
        
        let parameters = ["type":"CheckOutOrderEstimateDetailsGenie", "iStoreName": iStoreName, "iStorelatitude":self.storeLat, "iStorelongitude":self.storeLong, "iStoreAddress":iStoreAddress, "iUserAddressId":userSelectedAddressDic == nil ? "" : self.userSelectedAddressDic.get("UserSelectedAddressId"), "PassengerLat":self.currentselectedLat, "PassengerLon":self.currentselectedLong, "vGeneralCurrency":vCurrencyPassenger, "IS_FOR_PICK_DROP_GENIE": self.isFromPickDrop == true ? "Yes" : "No", "eSystem":"DeliverAll", "isAddOutstandingAmt":self.isAdjustPress == true ? "Yes":"No"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    if dataDict.dictOf("message").get("DISABLE_CASH_PAYMENT_OPTION") == "Yes"
                    {
                        self.disableCashPayValue = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_COD_NOT_AVAILABLE_TXT") + " " + dataDict.dictOf("message").get("fOutStandingAmountWithSymbol")
                        
                    }
                    self.addBillDetails(dataDic:dataDict)
                  
                }else{
                    

                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.close()
                        
                    })
            
                }
                
            }else{
                
                self.generalFunc.setError(uv: self)
               
            }
        })
    }
    
    var isAdjustPress = false
    func openOutStandingAmountBox(_ isForRideLater:Bool = false, dataDict:NSDictionary){
        let openOutStandingAmtView = OpenOutStandingView(uv: self, containerView: self.view)
        openOutStandingAmtView.show(userProfileJson: self.userProfileJson, currentCabGeneralType: Utils.cabGeneralType_UberX, dataDict: dataDict) { (isPayNow, isAdjustAmount) in
            
            if(isPayNow){
                
                GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=DeliverAll&ePaymentType=ChargeOutstandingAmount", uv: self)
                

            }else if(isAdjustAmount){
               
                self.isAdjustPress = true
                self.getDeliveryInfo()

            }
        }
    }
    
    func getUserDetail(){
        let parameters = ["type":"getDetail","UserType": Utils.appUserType, "AppVersion": Utils.applicationVersion(), "vDeviceType": Utils.deviceType, "iUserId": GeneralFunctions.getMemberd(), "LiveTripId":""]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            //            print("Response:\(response)")
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get(Utils.message_str) == "SESSION_OUT"){
                    GeneralFunctions.logOutUser()
                    GeneralFunctions.removeObserver(obj: self)
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Your session is expired. Please login again.", key: "LBL_SESSION_TIME_OUT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        GeneralFunctions.restartApp(window: Application.window!)
                    })
                    
                    return
                }
                if(dataDict.get("Action") == "1"){
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: response as AnyObject)
                    let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    self.userProfileJson = userProfileJson
                    GeneralFunctions.saveValue(key: "user_available_balance_amount", value: self.userProfileJson.get("user_available_balance_amount") as AnyObject)
                    GeneralFunctions.saveValue(key: "user_available_balance", value: self.userProfileJson.get("user_available_balance") as AnyObject) // With Currency Symbole
                    
                   
                    let orderPlacedUV = GeneralFunctions.instantiateViewController(pageName: "OrderPlacedUV") as! OrderPlacedUV

                    orderPlacedUV.isForGenie = true
                    orderPlacedUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
                    
                    self.push(uv: orderPlacedUV)
                    
                }else{
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                        
                        self.getUserDetail()
                    })
                }
                
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    GeneralFunctions.restartApp(window: Application.window!)
                })
             
            }
        })
    }
    
    func checkOutOrderDetails(_ eWalletIgnor:Bool = false){
        
        var itemArray = [NSDictionary] ()
        for i in 0..<self.cartItemArrays.count{
            
            if(i != self.cartItemArrays.count - 1){
                let itemName = self.cartItemArrays[i].itemName
                let itemCount = self.cartItemArrays[i].itemCount
                let extraPyament = self.isFromPickDrop == true ? (self.cartItemArrays[i].extraPyament == true ? "Yes" : "No") : "Yes"
                
                itemArray.append(["iQty": itemCount, "itemName":itemName, "eExtraPayment":extraPyament])
            }
          
        }
        
        let vCurrencyPassenger = userProfileJson.get("vCurrencyPassenger")
        
        var iStoreName = ""
        var iStoreAddress = ""
        if(self.isFromPickDrop){
            iStoreName = self.contactName
            iStoreAddress = self.storeName + ", " + self.storeAddress
        }else{
            iStoreName = self.storeName
            iStoreAddress = self.storeAddress
        }
        
        var parameters = ["type":"CheckOutOrderDetails", "iUserId": GeneralFunctions.getMemberd(), "iStoreName": iStoreName, "iStorelatitude":self.storeLat, "iStorelongitude":self.storeLong, "iStoreAddress":iStoreAddress, "iUserAddressId":userSelectedAddressDic == nil ? "" : self.userSelectedAddressDic.get("UserSelectedAddressId"), "PassengerLat":self.currentselectedLat, "PassengerLon":self.currentselectedLong, "vGeneralCurrency":vCurrencyPassenger, "eCatType": "Genie", "OrderDetails":itemArray.convertToJson(), "eSystem":"DeliverAll", "IS_FOR_PICK_DROP_GENIE": self.isFromPickDrop == true ? "Yes" : "No", "isAddOutstandingAmt":self.isAdjustPress == true ? "Yes":"No"]
        
        // NEWPayment Changes
        let paymentData = GetPaymentProfileData.getInstance()
        if(paymentData.PAYMENT_OPTION != "Cash"){
            parameters["eWalletIgnore"] = eWalletIgnor == true ? "Yes" : "No"
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    if(dataDict.get("iOrderId") == ""){
                        self.ordeIdForDirectLiveTrack = dataDict.dictOf("message").get("iOrderId")
                    }else{
                        self.ordeIdForDirectLiveTrack = dataDict.get("iOrderId")
                    }
                    
                    if(dataDict.get("WebviewPayment").uppercased() == "YES"){
                        GeneralFunctions.addPayment(url: dataDict.get("message"), uv: self)
                        return
                    }
                    
                    self.getUserDetail()
                  
                }else{
                    
                    if(GeneralFunctions.parseDouble(origValue: 0.0, data: dataDict.get("fOutStandingAmount")) > 0 && self.isAdjustPress == false){
                        self.openOutStandingAmountBox(false, dataDict: dataDict)
                        return
                    }
                    
                    if(dataDict.get("ShowContactUsBtn").uppercased() == "YES"){
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTACT_US_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                let contactUsUv = GeneralFunctions.instantiateViewController(pageName: "ContactUsUV") as! ContactUsUV
                                self.push(uv: contactUsUv)
                            }
                            
                        })
                        return
                    }
                    
                    /* PAYMENT FLOW CHANGES */
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        
                        
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
                                        self.checkOutOrderDetails(true)
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
                                        self.checkOutOrderDetails(true)
                                    }
                                    
                                }
                                
                            })
                        }
                        
                        
                        return
                    }/* .............. */
                    
                    if (dataDict.get("message") == "LBL_DELIVERY_LOCATION_NOT_ALLOW"){
                                
                        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_LOCATION_NOT_ALLOW"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                         
                        })
                                  
                        return
                    }
                    
                    if dataDict.get("message") == "LBL_RESTAURANTS_CLOSE_NOTE" || dataDict.get("message") == "LBL_MENU_ITEM_NOT_AVAILABLE_TXT"
                    {
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), uv: self)
                        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                           
                        })
                    }else if(dataDict.get(Utils.message_str) == "DO_PHONE_VERIFY"){
                        
                        self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ACCOUNT_VERIFY_ALERT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            let accountVerificationUv = GeneralFunctions.instantiateViewController(pageName: "AccountVerificationUV") as! AccountVerificationUV
                            accountVerificationUv.isForMobile = true
                            accountVerificationUv.requestType = "DO_PHONE_VERIFY"
                            
                            self.push(uv: accountVerificationUv)
                            
                            
                        })
                        
                        return
                    }else{
                        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                self.checkOutOrderDetails()
                            }
                        })
                    }
            
                }
                
            }else{
                
                self.generalFunc.setError(uv: self)
               
            }
        })
    }
    
 
    func addBillDetails(dataDic:NSDictionary){
        
        
        self.hWorksBGView.isHidden = false
        self.billDetailsView.isHidden = false
        
        self.billDetailsHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVOICE_DETAILS")
        
        self.billDetailsFareImgView.handleClick { (instance) in
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            openUserPreferences.customImgName = "ic_bill_popup"
            if(self.isFromPickDrop == true){
               openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PICKUP_INVOICE_DETAILS"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVOICE_DETAILS"))
            }else{
                openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVOICE_DETAILS_NOTE"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_INVOICE_DETAILS"))
            }
        }
        self.billDetailsFareImgView.image = UIImage(named: "info_t")
        GeneralFunctions.setImgTintColor(imgView: self.billDetailsFareImgView, color: SColors.Theme)
        billDetailsChargesView.clipsToBounds = true
       
        
        for fareSubView in self.billDetailsChargesView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        
        let fareDetailsNewArr = dataDic.arrOf("FareDetailsArr")
        
        let totalSeperatorViews = 0
        let seperatorViewHeight = 1
        for i in 0..<fareDetailsNewArr.count{
            
            let dict_temp = fareDetailsNewArr[i] as! NSDictionary
           
            for (key, value) in dict_temp {
                _ = fareDetailsNewArr[i] as! NSDictionary
                
                let viewWidth = Application.screenSize.width - 30
                let totalSubViewCounts = self.billDetailsChargesView.subviews.count
                
                let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                
            
                let titleStr = key as? String ?? ""
                let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                
                var font:UIFont!
               // if(i == fareDetailsNewArr.count - 1){
                  //  font = UIFont(name: Fonts().semibold, size: 18)!
               // }else{
                    font = UIFont(name: Fonts().regular, size: 15)!
                //}
                var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 15
                
                if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                    widthOfvalue = ((viewWidth * 80) / 100)
                    widthOfTitle = ((viewWidth * 20) / 100)
                }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                    widthOfvalue = viewWidth - widthOfTitle
                }
                
                let widthOfParentView = viewWidth - widthOfvalue
                
                var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 40))
                var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfvalue, height: 40))
                
                if(Configurations.isRTLMode()){
                    lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                    lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue, height: 40))
                    
                    lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 0)
                    lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 0)
                }else{
                    lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 0)
                    lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 0)
                }
                
                lblTitle.textColor = UIColor(hex: 0x656565)
                lblValue.textColor = SColors.Theme
                
                lblValue.font = font
                lblTitle.font = font
                
                lblTitle.fontFamilyWeight = "Regular"
                lblValue.fontFamilyWeight = "Regular"
                lblTitle.setFontFamily()
                lblValue.setFontFamily()
                
                lblTitle.numberOfLines = 2
                lblValue.numberOfLines = 2
                
                lblTitle.minimumScaleFactor = 0.5
                lblValue.minimumScaleFactor = 0.5
                
                lblTitle.text = titleStr
                lblValue.text = valueStr
                
                viewCus.addSubview(lblTitle)
                viewCus.addSubview(lblValue)
                
                //                    self.chargesContainerView.addArrangedSubview(viewCus)
                
                self.billDetailsChargesView.addSubview(viewCus)
                
                if(Configurations.isRTLMode()){
                    lblValue.textAlignment = .left
                }else{
                    lblValue.textAlignment = .right
                }
                
//                if(i == fareDetailsNewArr.count - 1){
//                    lblTitle.font = UIFont(name: Fonts().semibold, size: 18)!
//                    lblValue.font = UIFont(name: Fonts().semibold, size: 18)!
//                    lblTitle.fontFamilyWeight = "Medium"
//                    lblValue.fontFamilyWeight = "Medium"
//                    lblTitle.setFontFamily()
//                    lblValue.setFontFamily()
//                    lblTitle.textColor = UIColor.black
//                    lblValue.textColor = SColors.Theme
//
//                }
               
            }
            
        }
        
        self.billDetailsViewHeight.constant = CGFloat((self.billDetailsChargesView.subviews.count ) * 40) + 140
        
    }
    
   
    // TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cartItemArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenieCartItemTVCell", for: indexPath) as! GenieCartItemTVCell
        cell.selectionStyle = .none
    
        if(self.isFromPickDrop == true && indexPath.row != self.cartItemArrays.count - 1){
            cell.extraPaymentLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_EXTRA_PAYMENT")
            cell.extraPaymentView.isHidden = false
            
            cell.extraPaymentChkBox.isUserInteractionEnabled = false
            cell.extraPaymentChkBox.boxType = .square
            cell.extraPaymentChkBox.offAnimationType = .bounce
            cell.extraPaymentChkBox.onAnimationType = .bounce
            cell.extraPaymentChkBox.onCheckColor = SColors.ThemeTxt
            cell.extraPaymentChkBox.onFillColor = SColors.Theme
            cell.extraPaymentChkBox.onTintColor = SColors.Theme
            cell.extraPaymentChkBox.tintColor = SColors.Theme
            
            cell.extraPaymentSLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_REQUIRE_SUB_NOTE")
            cell.extraPaymentViewHeight.constant = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_REQUIRE_SUB_NOTE").height(withConstrainedWidth: Application.screenSize.width - 133, font: UIFont.init(name: Fonts().regular, size: 12)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_EXTRA_PAYMENT").height(withConstrainedWidth: Application.screenSize.width - 133, font: UIFont.init(name: Fonts().semibold, size: 13)!) + 10 + 10
            
            cell.extraPaySeparaterView.backgroundColor = SColors.Theme
            cell.extraPaySeparaterView.layer.addShadow(opacity: 0.3, radius: 2.0, SColors.Theme)
            
            cell.extraPaymentView.tag = indexPath.row
            
            if(indexPath.row != self.cartItemArrays.count - 1){
                cell.extraPaymentChkBox.setOn(self.cartItemArrays[indexPath.row].extraPyament, animated: true)
                
                cell.extraPaymentView.handleClick { (instance) in
                    let cell = self.tableView.cellForRow(at: IndexPath(row: instance.tag, section: 0)) as! GenieCartItemTVCell
                   
                    if cell.extraPaymentChkBox.on{
                        cell.extraPaymentChkBox.setOn(false, animated: true)
                        self.cartItemArrays[instance.tag] = GenieStoreData.init(itemName: self.cartItemArrays[instance.tag].itemName, itemCount: String(Int(self.cartItemArrays[instance.tag].itemCount)!), extraPyament: false)
                    }else{
                        cell.extraPaymentChkBox.setOn(true, animated: true)
                        self.cartItemArrays[instance.tag] = GenieStoreData.init(itemName: self.cartItemArrays[instance.tag].itemName, itemCount: String(Int(self.cartItemArrays[instance.tag].itemCount)!), extraPyament: true)
                    }
                
                }
                
                
                
            }
//            cell.extraPaySeparaterView.isHidden = false
            cell.extraPaySeparaterView.isHidden = true

        }else{
            cell.extraPaymentView.isHidden = true
            cell.extraPaySeparaterView.isHidden = true
            cell.extraPaymentViewHeight.constant = 20
        }
        
        cell.addItemView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        cell.addItemView.layer.roundCorners(radius: 7)
        
        cell.editItemView.layer.roundCorners(radius: 7)
        cell.editItemView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)

//        cell.extraPaymentView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
//        cell.extraPaymentView.layer.roundCorners(radius: 7)
        
        cell.groupBGView.backgroundColor =  UIColor(hex: 0xf6f6f6)
        if indexPath.row == 0 {
            cell.groupBGView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
            cell.groupBGView.roundCorners(corners: [.topRight, .topLeft],amount: 7)
        }
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.groupBGView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
            cell.groupBGView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 7)
        }else{
            if indexPath.row != 0 {
                cell.groupBGView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
            }
            cell.groupBGView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        }

        
        cell.addItemLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM_NAME")
        
        if Configurations.isRTLMode() == true{
            cell.itemNameTxtFiled.textAlignment = .right
            cell.itemRightShapeImgView.transform = CGAffineTransform(scaleX: -1, y: 1)
            
            var arrowImg = UIImage(named: "ic_arrow_right")
            arrowImg = arrowImg?.rotate(180)
            cell.addItemArrowImgView.image = arrowImg?.tintTo(color: UIColor.black)
        }
        
        GeneralFunctions.setImgTintColor(imgView: cell.addItemArrowImgView, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: cell.itemRightShapeImgView, color: SColors.Theme)
        
        if(indexPath.row == self.cartItemArrays.count - 1){
            cell.addItemView.isHidden = false
            cell.editItemView.isHidden = true
            
        }else{
            cell.editItemView.isHidden = false
            cell.addItemView.isHidden = true
        }
        
        GeneralFunctions.setImgTintColor(imgView: cell.editItemDeleteImgView, color: SColors.ThemeTxt)
        cell.editItemDeleteImgViewBG.backgroundColor = SColors.Theme
        cell.editItemDeleteImgViewBG.cornerRadius = 15
        GeneralFunctions.setImgTintColor(imgView: cell.plusItemImgView, color: SColors.Theme)
        cell.plusItemView.backgroundColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: cell.minusItemImgView, color: SColors.Theme)
        cell.minusItemView.backgroundColor = SColors.Theme
  
        
        cell.itemNameTxtFiled.delegate = self
        cell.itemNameTxtFiled.tag = indexPath.row
        cell.itemNameTxtFiled.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_ITEM_DETAILS")
        
        cell.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: self.cartItemArrays[indexPath.row].itemCount)
        cell.itemNameTxtFiled.text = Configurations.convertNumToAppLocal(numStr: self.cartItemArrays[indexPath.row].itemName)
        cell.cellSerialNumLbl.text = "\(indexPath.row + 1)."
        
        cell.editItemDeleteImgView.tag = indexPath.row
        cell.editItemDeleteImgView.handleClick { (instance) in
            
           self.view.endEditing(true)
       
           self.cartItemArrays.remove(at: instance.tag)
            
            
           self.tableView.reloadData()

           self.checkBottomAddressView()
    
            
        }
        
        cell.plusItemImgView.tag = indexPath.row
        cell.plusItemImgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            var itemCount = 0
            for i in 0..<self.cartItemArrays.count{
                
                if(i != self.cartItemArrays.count - 1){
                    itemCount = itemCount + Int(self.cartItemArrays[i].itemCount)!
                
                }
            }

            if(itemCount >= GeneralFunctions.parseInt(origValue: 0, data: self.userProfileJson.get("DELIVERY_ITEM_LIMIT"))){
                
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_MAXIMUM_LIMIT") + " " + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("DELIVERY_ITEM_LIMIT")), uv: self)
                return
            }
            
            self.cartItemArrays[instance.tag] = GenieStoreData.init(itemName: self.cartItemArrays[instance.tag].itemName, itemCount: String(Int(self.cartItemArrays[instance.tag].itemCount)! + 1), extraPyament: self.cartItemArrays[instance.tag].extraPyament)
            self.tableView.reloadData()
            
        }
        
        cell.minusItemImgView.tag = indexPath.row
        cell.minusItemImgView.handleClick { (instance) in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            if(Int(self.cartItemArrays[instance.tag].itemCount)! != 1){
                self.cartItemArrays[instance.tag] = GenieStoreData.init(itemName: self.cartItemArrays[instance.tag].itemName, itemCount: String(Int(self.cartItemArrays[instance.tag].itemCount)! - 1), extraPyament: self.cartItemArrays[instance.tag].extraPyament)
                self.tableView.reloadData()
            }
            
        }
        
        cell.addItemView.tag = indexPath.row
        cell.addItemView.handleClick { (instance) in
             
            var isItemName = true
            var itemCount = 0
            for i in 0..<self.cartItemArrays.count{
                
                let itemName = self.cartItemArrays[i].itemName

                if(i != self.cartItemArrays.count - 1){
                    itemCount = itemCount + Int(self.cartItemArrays[i].itemCount)!
                    
                   // if (itemName == ""){
                    if itemName.trimmingCharacters(in: .whitespaces).isEmpty {
                        isItemName = false
                    }
                }
                
            }
            if(isItemName == false){
                return
            }
            
            if(itemCount >= GeneralFunctions.parseInt(origValue: 0, data: self.userProfileJson.get("DELIVERY_ITEM_LIMIT"))){
                
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_MAXIMUM_LIMIT") + " " + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("DELIVERY_ITEM_LIMIT")), uv: self)
                return
            }
            
            self.cartItemArrays.append(GenieStoreData.init(itemName: "", itemCount: "1", extraPyament: false))
            self.cartItemArrays.swapAt(self.cartItemArrays.count - 1, self.cartItemArrays.count - 2)
            
            self.tableView.reloadData()
            let cell = self.tableView.cellForRow(at: IndexPath(row: instance.tag, section: 0)) as! GenieCartItemTVCell
            cell.itemNameTxtFiled.becomeFirstResponder()
            
            self.checkBottomAddressView()
        
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.isFromPickDrop == true && indexPath.row != self.cartItemArrays.count - 1){
            return 70 + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_REQUIRE_SUB_NOTE").height(withConstrainedWidth: Application.screenSize.width - 133, font: UIFont.init(name: Fonts().regular, size: 12)!) + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GENIE_EXTRA_PAYMENT").height(withConstrainedWidth: Application.screenSize.width - 133, font: UIFont.init(name: Fonts().semibold, size: 13)!) + 40
        }else if (indexPath.row != self.cartItemArrays.count - 1) {
            return 75 + 35
        }else{
            return 75
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.cartItemArrays[textField.tag] = GenieStoreData.init(itemName: textField.text!, itemCount: self.cartItemArrays[textField.tag].itemCount, extraPyament: self.cartItemArrays[textField.tag].extraPyament)
        self.tableView.reloadData()
        
        self.checkBottomAddressView()
    }
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
       
        if(parallaxHeader.progress <= 0){
            //self.selectServiceLbl.layer.shadowOpacity = 1.0;
          //  self.selectServiceLbl.layer.masksToBounds = true
            //self.selectServiceLbl.layer.addShadow(opacity: 0.9, radius: 2, UIColor.gray)
            self.makeAListLbl.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            //self.selectServiceLbl.layer.shadowOpacity = 0.0;
            self.makeAListLbl.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func checkBottomAddressView(){
        
        var isItemName = true
        for i in 0..<self.cartItemArrays.count{
            
            let itemName = self.cartItemArrays[i].itemName
            if (itemName.trimmed.isEmpty){
                isItemName = false
                break
            }
        }
        
        if(self.cartItemArrays.count > 1 && self.storeAddressAdded == true && isItemName == true){
            self.bottomAddressViewEnable(isEbaled: true)
        }else{
            self.bottomAddressViewEnable(isEbaled: false)
        }
    }
    
    func openAddAddressView(){
//        self.manageHowItWorksView(isOpen: false)
        self.manageHowItWorksViewClose()
        let addAddressUv = GeneralFunctions.instantiateViewController(pageName: "AddAddressUV") as! AddAddressUV
        addAddressUv.ufxSelectedLatitude = self.currentselectedLat
        addAddressUv.ufxSelectedLongitude = self.currentselectedLong
        addAddressUv.ufxSelectedAddress = self.currentAddress
        addAddressUv.isForGenie = true
        addAddressUv.isFromPickDrop = self.isFromPickDrop
        if(self.navigationController == nil){
            let navController = UINavigationController(rootViewController: addAddressUv)
            navController.navigationBar.isTranslucent = false
            navController.present(navController, animated: false, completion: nil)
        }else{
            self.navigationController?.pushViewController(addAddressUv, animated: false)
        }
        
        
    }
    
    @objc func changeAddressTapped()
    {
        let chooseAddressUv = GeneralFunctions.instantiateViewController(pageName: "ChooseAddressUV") as! ChooseAddressUV
    
        chooseAddressUv.isFromGenie = true
        chooseAddressUv.ufxSelectedLatitude = self.currentselectedLat
        chooseAddressUv.ufxSelectedLongitude = self.currentselectedLong
        chooseAddressUv.ufxSelectedAddress = self.currentAddress
        chooseAddressUv.companyId = "0"
        //chooseAddressUv.selectedAddressID = userSelectedAddressDic == nil ? "" : self.userSelectedAddressDic.get("UserSelectedAddressId")
        self.push(uv: chooseAddressUv)
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == self.proceedBtn){
            
            self.openAddAddressView()
        }else if (sender.btnType == "DEL_ADDRESS"){
            self.changeAddressTapped()
        }else if (sender.btnType == "CONTINUE"){
            
            self.getDeliveryInfo()

        }else if (sender == self.fildStoreAlertSubmitBtn){
            
            self.manageFindStoreAlertView(isOpen:false)
            self.openAddAddressView()
        }else if(sender == self.billDetailsProccedBtn){
            
          
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=DeliverAll", uv: self)
            
//            let selectPaymentProfileUV = GeneralFunctions.instantiateViewController(pageName: "SelectPaymentProfileUV") as! SelectPaymentProfileUV
//
//            selectPaymentProfileUV.isForGenie = true
//            selectPaymentProfileUV.disableCashPayValue = self.disableCashPayValue
//            self.push(uv: selectPaymentProfileUV)
        }
    }

    @IBAction func unwindToGenieFindStore(_ segue:UIStoryboardSegue) {
        
        if(segue.source.isKind(of:AddAddressUV.self)){
        
            self.storeAddressAdded = true
            let addAddressUV = segue.source as! AddAddressUV
            
            self.storeLat = "\(addAddressUV.currentSelectedLocation.coordinate.latitude)"
            self.storeLong = "\(addAddressUV.currentSelectedLocation.coordinate.longitude)"
            
            
            self.contactName = Utils.getText(textField: addAddressUV.landMarkTxtField.getTextField()!)
            self.storeName = Utils.getText(textField: addAddressUV.buildingTxtField.getTextField()!)
            self.storeAddress = addAddressUV.serviceAreaVLbl.text!
            
            var finalString = ""
            if(self.isFromPickDrop){
                 finalString = self.contactName + "\n" + self.storeName + ", " + self.storeAddress
                let attrStri = NSMutableAttributedString.init(string: finalString)
                let nsRange = NSString(string: finalString).range(of: self.storeName + ", " + self.storeAddress)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().light, size: 15.0) as Any], range: nsRange)
                self.findStoreLbl.attributedText = attrStri
            }else{
                 finalString = self.storeName + "\n" + self.storeAddress
                let attrStri = NSMutableAttributedString.init(string: finalString)
                let nsRange = NSString(string: finalString).range(of: self.storeAddress)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().light, size: 15.0) as Any], range: nsRange)
                self.findStoreLbl.attributedText = attrStri
            }
            
            self.checkBottomAddressView()
            
        }else if(segue.source.isKind(of:ChooseAddressUV.self)){
            
            let uv = segue.source as! ChooseAddressUV
            
            let data = uv.dataArrList[uv.selectedAddressPosition]
            
            let address = data.get("vBuildingNo") + ", " + data.get("vLandmark") + "\n" + data.get("vServiceAddress")
            self.userSelectedAddressDic = ["UserSelectedAddress":address, "UserSelectedLatitude":data.get("vLatitude"), "UserSelectedLongitude":data.get("vLongitude"), "UserSelectedAddressId":data.get("iUserAddressId")]
            self.addressLbl.text = self.userSelectedAddressDic.get("UserSelectedAddress")
            
            self.checkBottomAddressView()
            
        }else if(segue.source.isKind(of:SelectPaymentProfileUV.self)){
            
            let selectPaymentProfileUV = segue.source as! SelectPaymentProfileUV
            
            if(selectPaymentProfileUV.isCashPayment == true){
                self.paymentMethod = "Cash"
            }else{
                self.paymentMethod = "Card"
            }
            
            self.usewWalletBal = selectPaymentProfileUV.useWalletChkBox.on ? "Yes" : "No"
            
            self.checkOutOrderDetails()
            
        
        }else if(segue.source.isKind(of:AddPaymentUV.self)){
            
            let addPaymentUV = segue.source as! AddPaymentUV
            
            if(addPaymentUV.isGenieOrderPlaced == true){
               
                self.getUserDetail()
                
            }else{
                self.checkOutOrderDetails()
                
            }
            
        }
        
        
    }
    func manageAdressFromDirectHome()  {
        self.storeAddressAdded = true
        var finalString = ""
        if(self.isFromPickDrop){
             finalString = self.contactName + "\n" + self.storeName + ", " + self.storeAddress
            let attrStri = NSMutableAttributedString.init(string: finalString)
            let nsRange = NSString(string: finalString).range(of: self.storeName + ", " + self.storeAddress)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().light, size: 15.0) as Any], range: nsRange)
            self.findStoreLbl.attributedText = attrStri
        }else{
             finalString = self.storeName + "\n" + self.storeAddress
            let attrStri = NSMutableAttributedString.init(string: finalString)
            let nsRange = NSString(string: finalString).range(of: self.storeAddress)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.init(name: Fonts().light, size: 15.0) as Any], range: nsRange)
            self.findStoreLbl.attributedText = attrStri
        }
    }
    
}
