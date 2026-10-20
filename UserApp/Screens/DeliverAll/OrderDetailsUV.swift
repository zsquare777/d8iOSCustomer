

import UIKit
import WebKit
import SafariServices
import SysBaseLib

class OrderDetailsUV: ParentViewUV,UIScrollViewDelegate, MyBtnClickDelegate,MyLabelClickDelegate ,TextFieldDelegate,WKNavigationDelegate, RatingViewDelegate, ParentViewUVDelegate{

    //IBOutlet Create
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var restImgView: UIImageView!
    
    @IBOutlet weak var restNameHLbl: MyLabel!
    @IBOutlet weak var restAddVLbl: MyLabel!
    @IBOutlet weak var restRatingView: RatingView!
    @IBOutlet weak var orderDeliveredView: UIView!
    @IBOutlet weak var orderDeliveredLbl: MyLabel!
    @IBOutlet weak var orderNoLbl: MyLabel!
    @IBOutlet weak var orderDeliveredViewHeight: NSLayoutConstraint!

    @IBOutlet weak var orderDateVLbl: MyLabel!
    @IBOutlet weak var orderDateVLblTopMargin: NSLayoutConstraint!
    @IBOutlet weak var deliveryAddHLbl: MyLabel!
    @IBOutlet weak var deliveryAddView: UIView!
    @IBOutlet weak var deliveryAddViewHeight: NSLayoutConstraint!
    @IBOutlet weak var deliveryAddVLbl: MyLabel!
    var activityIndicatorWeb:UIActivityIndicatorView!
    @IBOutlet weak var billDetailsHLbl: MyLabel!
    @IBOutlet weak var billItemView: UIView!
    @IBOutlet weak var billItemViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var giveTipButton: MyButton!
    @IBOutlet weak var chargesHLbl: MyLabel!
    
    @IBOutlet weak var chargesParentView: UIView!
    @IBOutlet weak var chargesParentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesContainerView: UIStackView!
    @IBOutlet weak var chargesContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesDataContainerView: UIView!
    
    @IBOutlet weak var giveTipButtonHight: NSLayoutConstraint!
    @IBOutlet weak var refundView: UIView!
    @IBOutlet weak var refundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var refundHLbl: MyLabel!
    
    @IBOutlet weak var bottomDetailsView: UIView!
    @IBOutlet weak var bottomDetailsViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reOrderBtn: MyButton!
    @IBOutlet weak var reOrderBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var payImgView: UIImageView!
    @IBOutlet weak var paidViaLbl: MyLabel!
    
    @IBOutlet weak var helpImgView: UIImageView!
    
    @IBOutlet weak var prescriptionView: UIView!
    @IBOutlet weak var prescriptionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var prescriptionHLbl: MyLabel!
    @IBOutlet weak var takeAwayLbl: MyLabel!
    
    //preferences outles
    @IBOutlet weak var viewPreferencesView: UIView!
    @IBOutlet weak var viewPreferencesLabel: MyLabel!
    
    //preferences variables
    var deliveryPreferencesArray:NSArray!
    var deliveryPrefImg = ""
    
    //takeaway outlets
    @IBOutlet weak var takeAwayPickupView: UIView!
    @IBOutlet weak var takeAwayPickupViewHeight: NSLayoutConstraint!
    @IBOutlet weak var takeAwayPickupLabel: MyLabel!
    let webView = WKWebView()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //Tip View Outlets
    @IBOutlet weak var tipMainViewBottomSpace: NSLayoutConstraint!

    @IBOutlet weak var tipMainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipMainView: UIView!
    @IBOutlet weak var tipMainViewHLbl: MyLabel!
    @IBOutlet weak var tipHintImgView: UIImageView!
    @IBOutlet weak var tipSubView: UIView!
    @IBOutlet weak var tipSubViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipAmoVIew1: UIView!
    @IBOutlet weak var tipAmoView2: UIView!
    @IBOutlet weak var tipAmoView3: UIView!
    @IBOutlet weak var tipAmoLbl1: MyLabel!
    @IBOutlet weak var tipAmoLbl2: MyLabel!
    @IBOutlet weak var tipAmoLbl3: MyLabel!
    @IBOutlet weak var tipAmoOtherView: UIView!
    @IBOutlet weak var tipAmoOtherLbl: MyLabel!
    @IBOutlet weak var tipAmoOtherValueView: UIView!
    @IBOutlet weak var tipAmoTxtFiled: UITextField!
    @IBOutlet weak var tipAmoOtherConfImgView: UIImageView!
    @IBOutlet weak var tipAmoImgView1: UIImageView!
    @IBOutlet weak var tipAmoImgView2: UIImageView!
    @IBOutlet weak var tipAmoImgView3: UIImageView!
    @IBOutlet weak var tipAmoOtherImgView: UIImageView!
    @IBOutlet weak var tipRequiredLbl: MyLabel!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingHintLbl: MyLabel!
    @IBOutlet weak var ufxRatingBar: RatingView!
    @IBOutlet weak var ratingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTxtView: KMPlaceholderTextView!
    @IBOutlet weak var submitRatingBtn: MyButton!
    
    @IBOutlet weak var proofContainerView: UIView!
    @IBOutlet weak var proofContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var proofTitleLbl: MyLabel!
    @IBOutlet weak var proofImgView: UIImageView!
    
    var tipPosition = ""
    var detailDic:NSDictionary!
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var orderId = ""
    var isShowTip = false
    var isBillDetailClosed = true
    var bottomDetailViewHeight = 0
    var isFirstLoad = true
    var isGiveTip = false
    var isSeparate = ""
    var tipAmount = ""
    var userProfileJson:NSDictionary!
    
    var PAGE_HEIGHT:CGFloat = 540
    
    var isSafeAreaSet = false
    var loaderView:UIView!
    
    var isGenie = false
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "OrderDetailsScreenDesign", uv: self, contentView: contentView)
            self.scrollView.addSubview(cntView)
            scrollView.bounces = false
            scrollView.backgroundColor = UIColor(hex: 0xF1F1F1)
            
            self.scrollView.isHidden = true
            self.cntView.isHidden = true
            
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.PAGE_HEIGHT + 250)
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 250)
            
            self.reOrderBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REORDER"))
            self.reOrderBtn.clickDelegate = self
            self.giveTipButton.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIVE_TIP"))
            giveTipButton.isHidden = true
            self.giveTipButton.clickDelegate = self
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            self.navigationController?.navigationBar.layer.zPosition = 1
            //if(self.isFirstLoad == true){

                self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: PAGE_HEIGHT + 250)
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: PAGE_HEIGHT + 250)
               
                
                self.getOrdersDetails()
                
                self.isFirstLoad = false
           // }
        }
    }
    
   
    func setTipView()
    {
        
        //self.tipMainViewBottomSpace.constant = 20
        self.giveTipButtonHight.constant = 55
        self.tipMainViewHeight.constant = 130
        self.tipMainView.isHidden = false
        self.giveTipButton.isHidden = false
        self.tipSubView.clipsToBounds = true
        self.tipSubView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.tipSubView.layer.roundCorners(radius: 10)
        
        self.tipAmoTxtFiled.delegate = self
        self.tipAmoTxtFiled.keyboardType = .decimalPad
        
        GeneralFunctions.setImgTintColor(imgView: self.tipHintImgView, color: SColors.Theme)
        
        self.tipAmoOtherConfImgView.backgroundColor = SColors.Theme
        self.tipAmoOtherConfImgView.image = UIImage(named:"ic_btn_rightarrow")?.addImagePadding(x: 150, y: 150)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoOtherConfImgView, color: SColors.ThemeTxt)
        
        self.tipMainViewHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_TIP_TITLE_TXT")
        
        self.tipAmoTxtFiled.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_AMOUNT")
        
        if(self.userProfileJson.get("DELIVERY_TIP_AMOUNT_TYPE_DELIVERALL").uppercased() == "PERCENTAGE"){
            self.tipAmoLbl1.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_1"))
            self.tipAmoLbl2.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_2"))
            self.tipAmoLbl3.text = Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_3"))
        }else{
            self.tipAmoLbl1.text =  GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_1"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))
                //userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_1"))
            self.tipAmoLbl2.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_2"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))//userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_2"))
            self.tipAmoLbl3.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.userProfileJson.get("TIP_AMOUNT_3"), addCurrncy: true, currencySymbol: userProfileJson.get("CurrencySymbol"))//userProfileJson.get("CurrencySymbol") + Configurations.convertNumToAppLocal(numStr: self.userProfileJson.get("TIP_AMOUNT_3"))
        }
        
        
        
        self.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
        self.tipRequiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REQUIRED")
        
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView1, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView2, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoImgView3, color: UIColor.black)
        GeneralFunctions.setImgTintColor(imgView: self.tipAmoOtherImgView, color: UIColor.black)
        
        self.tipHintImgView.handleClick { (instance) in
            let openUserPreferences = OpenUserPreferences(uv: self, containerView: Application.window!)
            
            openUserPreferences.isTip = true
            openUserPreferences.show(preferenceDescription: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_TIP_DESC"), title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TIP_DIALOG_TITLE"))
        }
        
        self.tipAmoOtherConfImgView.handleClick { (instance) in
            
            if(self.tipAmoTxtFiled.text != "" && GeneralFunctions.parseDouble(origValue: 0, data: self.tipAmoTxtFiled.text!) > 0){
                self.tipAmount = self.tipAmoTxtFiled.text!
                self.tipAmoOtherLbl.text = self.userProfileJson.get("CurrencySymbol") + self.tipAmount
                self.tipAmoOtherImgView.isHidden = false
                
                self.tipPosition = "4"
               // self.getCheckOutPrice()
                
                self.tipAmoTxtFiled.text = ""
            }else{
                
                self.tipRequiredLbl.isHidden = false
                self.tipAmoOtherValueView.borderColor = SColors.red
                
            }
        }
        
        self.tipAmoImgView1.handleClick { (instance) in
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmount = ""
            self.tipPosition = ""
           // self.getCheckOutPrice()
            
        }
        
        self.tipAmoImgView2.handleClick { (instance) in
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            self.tipAmount = ""
            
            self.tipPosition = ""
           // self.getCheckOutPrice()
            
            
        }
        
        self.tipAmoImgView3.handleClick { (instance) in
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
           self.tipAmount = ""
            
           self.tipPosition = ""
          //  self.getCheckOutPrice()
        }
        
        self.tipAmoOtherImgView.handleClick { (instance) in
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            self.tipAmount = ""
            //self.tipPosition = ""
            
            self.tipAmoOtherLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")
            self.tipAmoTxtFiled.text = ""
            self.tipMainViewHeight.constant = 190
            
           // self.getCheckOutPrice()
        }
        
        self.tipAmoVIew1.handleClick { (instance) in
            
            self.tipAmoVIew1.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoVIew1.borderColor = SColors.Theme
            self.tipAmoImgView1.isHidden = false
            self.tipAmoLbl1.paddingLeft = 20
            self.tipAmoLbl1.paddingRight = 20
            
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 130
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_1")
            self.tipPosition = "1"
           // self.getCheckOutPrice()
        }
        
        self.tipAmoView2.handleClick { (instance) in
            self.tipAmoView2.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoView2.borderColor = SColors.Theme
            
            self.tipAmoImgView2.isHidden = false
            self.tipAmoLbl2.paddingLeft = 20
            self.tipAmoLbl2.paddingRight = 20
            
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 130
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_2")
            self.tipPosition = "2"
           // self.getCheckOutPrice()
        }
        
        self.tipAmoView3.handleClick { (instance) in
            self.tipAmoView3.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoView3.borderColor = SColors.Theme
            self.tipAmoImgView3.isHidden = false
            self.tipAmoLbl3.paddingLeft = 20
            self.tipAmoLbl3.paddingRight = 20
            
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            
            self.tipAmoOtherView.borderColor = UIColor.lightGray
            self.tipAmoOtherView.backgroundColor = UIColor.clear
            self.tipAmoOtherImgView.isHidden = true
            
            self.tipMainViewHeight.constant = 130
            
            self.tipAmount = self.userProfileJson.get("TIP_AMOUNT_3")
            self.tipPosition = "3"
//            self.getCheckOutPrice()
        }
        
        self.tipAmoOtherView.handleClick { (instance) in
            self.tipAmoOtherView.backgroundColor = SColors.Theme.withAlphaComponent(0.5)
            self.tipAmoOtherView.borderColor = SColors.Theme
           
            if(self.tipAmoOtherLbl.text == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OTHER_TXT")){
                self.tipAmoOtherImgView.isHidden = true
            }else{
                self.tipAmoOtherImgView.isHidden = false
            }
            
            self.tipAmoVIew1.borderColor = UIColor.lightGray
            self.tipAmoVIew1.backgroundColor = UIColor.clear
            self.tipAmoImgView1.isHidden = true
            
            self.tipAmoView2.borderColor = UIColor.lightGray
            self.tipAmoView2.backgroundColor = UIColor.clear
            self.tipAmoImgView2.isHidden = true
            
            self.tipAmoView3.borderColor = UIColor.lightGray
            self.tipAmoView3.backgroundColor = UIColor.clear
            self.tipAmoImgView3.isHidden = true
            
            self.tipMainViewHeight.constant = 190
            
            
        }
        
    }
    @objc func helpTapped(){
        let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
        helpCategoryUv.iTripId =  orderId
        helpCategoryUv.eSystem = "DeliverAll"
        self.push(uv: helpCategoryUv)
    }
    
    func setGenieRatingView(){
        
        self.ratingView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.ratingView.layer.roundCorners(radius: 10)
        
        self.commentTxtView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Provide your feedback.", key: "LBL_WRITE_COMMENT_HINT_TXT")
        self.commentTxtView.layer.borderColor = UIColor(hex: 0xdedede).cgColor
        self.commentTxtView.layer.borderWidth = 1.5
        self.commentTxtView.layer.cornerRadius = 5
        self.commentTxtView.clipsToBounds = true
        
        self.ufxRatingBar.delegate = self
        self.ufxRatingBar.fullStarColor = SColors.selected_rate_color
        self.ufxRatingBar.emptyStarColor = SColors.unSelected_rate_color
        
        if(self.detailDic.get("iActive").uppercased() == "YES" && self.detailDic.get("is_rating").uppercased() == "NO") {
       
            self.ratingView.isHidden = false
            
            self.ratingViewHeight.constant = 200 /*RatinvViewHeight Set when ENABLE_FAVORITE_DRIVER_MODULE - Yes/No */
           
            self.ratingHintLbl.isHidden = false
            self.ratingHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HOW_WAS_YOUR_DELIVERY")

            self.submitRatingBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE"))
            self.submitRatingBtn.clickDelegate = self
            
            self.PAGE_HEIGHT = self.PAGE_HEIGHT + 250
            }else{
            self.ratingHintLbl.isHidden = true
            self.ratingViewHeight.constant = 0
            self.ratingView.isHidden = true
           
        }
    }
    

    /* FAV DRIVERS CHANGES */
    func ratingView(_ ratingView: RatingView, didChangeRating newRating: Float) {
        /*if(userProfileJson.get("ENABLE_FAVORITE_DRIVER_MODULE").uppercased() == "YES"){
         
         }*/
    }
    
    func getOrdersDetails(){
        scrollView.isHidden = true
        cntView.isHidden = true
        PAGE_HEIGHT = 540
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = false
        }
        
        let parameters = ["type":"GetOrderDetailsRestaurant", "iOrderId": orderId, "UserType": Utils.appUserType, "eSystem":"DeliverAll", "iUserId":GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                self.contentView.alpha = 0.0
                self.contentView.isHidden = false
                UIView.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.contentView.alpha = 1.0
                }, completion: nil)

                let dataDict = response.toDict()
                print (dataDict)
                if(dataDict.get("Action") == "1"){
                    
                    //delivery preferences changes
                    self.isGenie = dataDict.dictOf(Utils.message_str).get("eBuyAnyService").uppercased() == "YES" ? true : false
                    let deliveryPreferncesDict = dataDict.dictOf("DeliveryPreferences")
                    if deliveryPreferncesDict.get("Enable") == "Yes"{
                        let dataArray = deliveryPreferncesDict.arrOf("Data")
                        self.deliveryPreferencesArray = dataArray
                        self.deliveryPrefImg = deliveryPreferncesDict.get("vImageDeliveryPref")
                        if dataArray.count > 0{
                            self.viewPreferencesView.isHidden = false
                            //self.PAGE_HEIGHT = self.PAGE_HEIGHT //+ 70
                        }
                    }
                    
                    self.isSeparate = dataDict.get("ispriceshow")
                    self.detailDic = dataDict.dictOf("message") 
                    
                    if(self.detailDic.get("eBuyAnyService").uppercased() == "YES"){
                        self.setGenieRatingView()
                    }
                
                    self.setData()
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
            }else{
                _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.getOrdersDetails()
                    }
                })
            }
            
            self.scrollView.isHidden = false
            self.cntView.isHidden = false
            self.loaderView.isHidden = true
        })
    }
    
    func setData(){
        
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIPT_HEADER_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RECEIPT_HEADER_TXT")
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_receipt")!.resize(toWidth: 25)!.resize(toHeight: 25)!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.getReceiptTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.headerView.backgroundColor = SColors.Theme
        
        self.orderDeliveredView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.orderDeliveredView.layer.roundCorners(radius: 10)

        self.deliveryAddView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.deliveryAddView.layer.roundCorners(radius: 10)

        self.chargesParentView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.chargesParentView.layer.roundCorners(radius: 10)
        
        self.prescriptionView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.prescriptionView.layer.roundCorners(radius: 10)
        
        self.bottomDetailsView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
        self.bottomDetailsView.layer.roundCorners(radius: 18)
        
        self.viewPreferencesView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.viewPreferencesView.layer.roundCorners(radius: 10)
        self.takeAwayPickupView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
        self.takeAwayPickupView.layer.roundCorners(radius: 10)
        self.viewPreferencesLabel.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_PREFERENCES").uppercased()
        self.viewPreferencesLabel.setClickDelegate(clickDelegate: self)
        self.viewPreferencesLabel.textColor = SColors.Theme
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if(Configurations.isIponeXDevice()){
                self.refundView.roundTo(corners: [.bottomLeft, .bottomRight], radius: 15.0)
                self.refundView.clipsToBounds = true
            }else{
                self.refundView.roundTo(corners: [.topLeft, .topRight], radius: 15.0)
                self.refundView.clipsToBounds = true
            }
        }
        
        self.refundView.backgroundColor = SColors.Theme
        
        let widthValue = Utils.getValueInPixel(value: 75)
        let heightValue = Utils.getValueInPixel(value: 75)
        
        self.restImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.detailDic.get("companyImage"), width: widthValue, height: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))

        Utils.createRoundedView(view: self.restImgView, borderColor: UIColor.white, borderWidth: 1.5)
        
        self.orderDateVLbl.text = Utils.convertDateFormateInAppLocal(date: Utils.convertDateGregorianToAppLocale(date: self.detailDic.get("tOrderRequestDate_Org"), dateFormate: "yyyy-MM-dd HH:mm:ss"), toDateFormate: Utils.dateFormateWithTime).uppercased()
        
        self.restNameHLbl.text = self.detailDic.get("vCompany")
        
        
        self.restRatingView.rating = GeneralFunctions.parseFloat(origValue: 0.0, data: self.detailDic.get("vAvgRating"))

        self.restAddVLbl.text = self.detailDic.get("vRestuarantLocation")
        
        self.deliveryAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_ADDRESS")
        var deliveryAddress = ""
        deliveryAddress = self.detailDic.get("DeliveryAddress")
        self.deliveryAddVLbl.text = deliveryAddress == "" ? "----" :  deliveryAddress
        self.deliveryAddVLbl.fit()
        
        

        
        self.orderDeliveredLbl.text = self.detailDic.get("vStatusNew")
        self.orderNoLbl.text = self.generalFunc.getLanguageLabel(origValue: "Order No", key: "LBL_MYTRIP_RIDE_NO_TXT_DL") + " " + "#" + Configurations.convertNumToAppLocal(numStr: self.detailDic.get("vOrderNo"))

        if(self.detailDic.get("eTakeAway").uppercased() == "YES"){
            if(self.detailDic.get("eTakeAwayPickedUpNote") != ""){
                self.takeAwayPickupView.isHidden = false
                self.takeAwayPickupLabel.text = self.detailDic.get("eTakeAwayPickedUpNote")
                self.takeAwayPickupViewHeight.constant = 80
                self.PAGE_HEIGHT = self.PAGE_HEIGHT + 100
            }
            self.takeAwayLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TAKE_WAY_ORDER")
            
            self.takeAwayLbl.isHidden = false
            self.deliveryAddHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANT_ADDRESS")
            deliveryAddress = self.detailDic.get("vRestuarantLocation")
            self.deliveryAddVLbl.text = deliveryAddress == "" ? "----" :  deliveryAddress
            self.deliveryAddVLbl.fit()
        }
        else{
            self.orderDeliveredViewHeight.constant = 84
        }
        
        if(self.isGenie){
            self.restRatingView.isHidden = true
            self.orderDeliveredViewHeight.constant = 104
        }else{
            self.restRatingView.isHidden = false
        }
        self.deliveryAddViewHeight.constant = 30
        let deliveryAddHeight = deliveryAddress.height(withConstrainedWidth: Application.screenSize.width - 100, font: UIFont(name: Fonts().regular, size: 14)!) - 20
        self.deliveryAddViewHeight.constant = self.deliveryAddViewHeight.constant + deliveryAddHeight

        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.deliveryAddViewHeight.constant
        if (self.detailDic.get("iStatusCode") == "6" && self.detailDic.get("ePaid").uppercased() == "YES") { /*Status = 6 COMPLETED */
            
            self.bottomDetailsView.isHidden = false
            self.bottomDetailsViewHeight.constant = 67
            
            self.refundView.isHidden = true
            self.refundViewHeight.constant = 0
            
            if(self.detailDic.get("ePaymentOption") == "Card"){
                
                    self.paidViaLbl.text = (self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CARD")).uppercased()
                    self.payImgView.image = UIImage(named: "ic_card_new")!
                
            }else if (self.detailDic.get("ePaymentOption") == "Wallet") {
                self.paidViaLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA_WALLET").uppercased()
                self.payImgView.image = UIImage(named: "ic_wallet_pay")!
            }
            else{
                self.paidViaLbl.text = (self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAID_VIA") + " " + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CASH_TXT")).uppercased()
                self.payImgView.image = UIImage(named: "ic_cash_new")!
            }
            self.paidViaLbl.textColor = SColors.Theme
        } else if(self.detailDic.get("iStatusCode") == "7" || self.detailDic.get("iStatusCode") == "8") { /*Status = 7 REFUND - DECLINE BY STORE */
            self.ratingHintLbl.isHidden = false
            self.ratingHintLbl.font = UIFont(name: Fonts().regular, size: 15)!
            
            self.ratingHintLbl.cornerRadius = 4
            self.ratingHintLbl.paddingTop = 10
            self.ratingHintLbl.paddingLeft = 5
            self.ratingHintLbl.paddingRight = 5
            self.ratingHintLbl.paddingBottom = 10
            self.ratingHintLbl.fontFamilyWeight = "Regular"
            self.ratingHintLbl.setFontFamily()
            
            if(self.detailDic.get("CancelOrderReason") != ""){
                self.ratingHintLbl.borderColor = UIColor.gray
                self.ratingHintLbl.borderWidth = 1.0
                
            }
            
            self.ratingHintLbl.text = self.detailDic.get("CancelOrderReason")
            self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.ratingHintLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 40, font: UIFont(name: Fonts().regular, size: 15)!) + 20 - 25
            
        
            self.refundView.isHidden = false
            self.refundHLbl.isHidden = false
            
            self.bottomDetailsView.isHidden = true
            self.bottomDetailsViewHeight.constant = 0
            
            self.refundHLbl.text = Configurations.convertNumToAppLocal(numStr: self.detailDic.get("CancelOrderMessage")).uppercased()
            self.refundHLbl.numberOfLines = 0
            
            let refundStrHeight = self.refundHLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 30, font: UIFont(name: Fonts().regular, size: 14)!) //- 17
            
            self.refundViewHeight.constant = 40 + refundStrHeight + GeneralFunctions.getSafeAreaInsets().bottom
            
        } else{ /*Status - Completed & ePaid - No */
            self.bottomDetailsView.isHidden = true
            self.refundView.isHidden = true
            
            self.bottomDetailsViewHeight.constant = 0
            self.refundViewHeight.constant = 0
            
//            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 30
        }
        
        GeneralFunctions.setImgTintColor(imgView: self.payImgView, color: SColors.Theme)
        
        let helpTapGue = UITapGestureRecognizer()
        helpTapGue.addTarget(self, action: #selector(self.helpTapped))
        self.helpImgView.addGestureRecognizer(helpTapGue)
        self.helpImgView.isUserInteractionEnabled = true
        GeneralFunctions.setImgTintColor(imgView: self.helpImgView, color: SColors.Theme)
        
        if(self.detailDic.get("DisplayReorder") == "Yes" && self.detailDic.get("eBuyAnyService") != "Yes"){
            self.reOrderBtn.isHidden = false
            self.reOrderBtnHeight.constant = 60
            self.helpImgView.isHidden = false
        }else{
            self.reOrderBtn.isHidden = true
            self.reOrderBtnHeight.constant = 0
            self.helpImgView.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
        }

        self.billDetailsHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BILL_DETAILS")
        
        let itemListArray = self.detailDic.arrOf("itemlist")
        
        if(itemListArray.count > 0){
            var yPosition = 0
            var textHeight = 0
            
            for i in 0..<itemListArray.count {

              
                yPosition =  textHeight
              
                
//                yPosition = yPosition + (i * 110)
                
                let item = itemListArray[i] as! NSDictionary
                
                let itemTextHeight = (item.get("MenuItem") + item.get("SubTitle")).height(withConstrainedWidth: Application.screenSize.width - 130, font: UIFont(name: Fonts().semibold, size: 14)!)
                
                let itemView = OrderDetailsItemView(frame: CGRect(x:0, y: yPosition, width: Int(self.billItemView.frame.size.width), height: Int(itemTextHeight) + 100))
                
                //textHeight = Int(textHeight) + Int(itemTextHeight)
                
                textHeight = Int(itemTextHeight) + 100 + textHeight
                
                itemView.tag = i
                itemView.autoresizingMask = [.flexibleWidth]
                
                itemView.itemLbl.numberOfLines = 0
                
                let finalStr = NSMutableAttributedString.init(string: "")
                finalStr.append(self.getAttributedString(str:item.get("MenuItem"),color:UIColor.black))
                finalStr.append(self.getAttributedString(str: " " + item.get("SubTitle"),color:UIColor.lightGray))
                
                itemView.itemLbl.attributedText = finalStr
                
                itemView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("fTotPrice"))
                
                let widthValue = Utils.getValueInPixel(value: 60)
                let heightValue = Utils.getValueInPixel(value: 60)
                
                if(item.get("vImage") != ""){
                    itemView.itemImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: widthValue, height: heightValue)), placeholderImage:UIImage(named:"ic_no_icon"))
                }else{
                    itemView.itemImgView.isHidden = true
                    itemView.imgViewWidth.constant = 0
                    
                }
                
                
                if(item.get("TotalDiscountPrice") != ""){
                    let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                    
                    let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: item.get("fTotPrice")))
                    
                    attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                    attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
                    attributedString.addAttributes(yourAttributes, range: NSMakeRange(0, attributedString.length))
                    itemView.strikeOutLbl.attributedText = attributedString
                    itemView.strikeOutLblTrailMargin.constant = 10
                    
                    itemView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: item.get("TotalDiscountPrice"))
                }
                
                if(self.isGenie){
                    if(item.get("eExtraPayment").uppercased() != "YES"){
                        itemView.priceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PAYMENT_NOT_REQUIRED")
                        itemView.priceLbl.setCustomTextColor(color: UIColor.gray)
                        itemView.priceLbl.font = UIFont(name: Fonts().semibold, size: 14)!
                        itemView.priceLbl.fontFamilyWeight = "Regular"
                        itemView.priceLbl.setFontFamily()
                    }
                    
                    if(item.get("eItemAvailable").uppercased() != "YES"){
                     
                     
                         itemView.priceLbl.isHidden = false
                         itemView.priceLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ITEM_NOT_AVAILABLE")
                         itemView.priceLbl.setCustomTextColor(color: UIColor.red)
                         itemView.priceLbl.font = UIFont(name: Fonts().semibold, size: 14)!
                         itemView.priceLbl.fontFamilyWeight = "Regular"
                         itemView.priceLbl.setFontFamily()
                        
                     
                         let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                         
                         let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: item.get("MenuItem").capitalized))
                         
                         attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                         attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
                         attributedString.addAttributes(yourAttributes, range: NSMakeRange(0, attributedString.length))
                         itemView.itemLbl.attributedText = attributedString
                     
                        
                    }else{
                     

                        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                        
                        let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: item.get("MenuItem").capitalized))
                        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.clear, range: NSMakeRange(0, attributedString.length))
                        attributedString.addAttributes(yourAttributes, range: NSMakeRange(0, attributedString.length))
                        itemView.itemLbl.attributedText = attributedString
                     
                    }
                }
                
                
                let iQtyStr = NSMutableAttributedString.init(string: "")
                iQtyStr.append(self.getAttributedString(str:"✕   ", color: UIColor(hex: 0x464646)))
                iQtyStr.append(self.getAttributedString(str: Configurations.convertNumToAppLocal(numStr: item.get("iQty")),color:UIColor.black))
                
                itemView.itemCountLbl.attributedText = iQtyStr
                
                self.billItemView.addSubview(itemView)
                
                itemView.containerView.clipsToBounds = true
                itemView.containerView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
                itemView.containerView.layer.roundCorners(radius: 10)
            }
            
           // self.view.layoutIfNeeded()
            self.billItemViewHeight.constant = CGFloat(textHeight) //CGFloat(yPosition + 110 + textHeight)
        }
        
        /* Prescription Changes */
        if(self.detailDic.arrOf("PrescriptionImages").count > 0){
            
            self.prescriptionView.isHidden = false
            self.prescriptionViewHeight.constant = 45
            
            self.prescriptionHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_PRESCRIPTION")
            self.prescriptionHLbl.textColor = SColors.Theme
           
            self.prescriptionView.handleClick(clickHandler: { (Instance) in
                
                let prescriptionUV = GeneralFunctions.instantiateViewController(pageName: "PrescriptionUV") as! PrescriptionUV
                prescriptionUV.historyDataArrList = self.detailDic.arrOf("PrescriptionImages") as! [String]
                prescriptionUV.isFromViewPrescription = true
                self.push(uv: prescriptionUV)
                
            })
        } else{
            self.prescriptionView.isHidden = true
            self.prescriptionViewHeight.constant = 0
            
            self.PAGE_HEIGHT = self.PAGE_HEIGHT - 45
        }/* ............. */

        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.billItemViewHeight.constant
        
        self.chargesHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHARGES_TXT")
       
        self.addFareDetails()
        if(self.userProfileJson.get("ENABLE_TIP_MODULE_DELIVERALL").uppercased() == "YES" && GeneralFunctions.getMemberd() != "" && self.detailDic.get("giveTip").uppercased() == "YES") {
            self.setTipView()
        }else{
            //self.closeTipView()
            self.tipMainView.isHidden = true
        }
       
    
        if(self.detailDic.get("vIdProofImageUploaded").uppercased() == "YES"){
            
            self.proofContainerViewHeight.constant = 130
            self.proofContainerView.isHidden = false
            
            self.proofTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_IDENTIFICATION")
            
            self.proofImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: self.detailDic.get("vIdProofImage"), width: 0, height: Utils.getValueInPixel(value: 100))), placeholderImage:UIImage(named:"ic_no_icon"))
            
            self.proofImgView.handleClick { (instance) in
                self.openProofImage()
            }
            
            
            self.proofContainerView.layer.addShadow(opacity: 0.3, radius: 2.5, UIColor.lightGray)
            self.proofContainerView.layer.roundCorners(radius: 10)
            
            self.PAGE_HEIGHT = self.PAGE_HEIGHT + 130
        }
        
        
        if tipMainView.isHidden == true {
            if isGiveTip == true {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                    self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT - 350)
                    self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT - 350)
                })
            }else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                    self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT + 80)
                    self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 80)
                })
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT + 250)
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 250)
            })
        }
        
    }
    
    @objc func openProofImage(){
        let url = URL(string: self.detailDic.get("vIdProofImage"))!
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    
    @objc func getReceiptTapped(){
        let parameters = ["type": "getReceiptOrder", "UserType": Utils.appUserType, "eSystem":"DeliverAll", "iOrderId": orderId]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str), key: dataDict.get(Utils.message_str)))
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func addFareDetails(){
       
        let HistoryFareDetailsNewArr = self.detailDic.arrOf("FareDetailsArr")
        
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        for view in chargesDataContainerView.subviews {
            view.removeFromSuperview()
        }
        for i in 0..<HistoryFareDetailsNewArr.count {
            
            let dict_temp = HistoryFareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
                
                let totalSubViewCounts = self.chargesDataContainerView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 36
                    
                    let viewCus = UIView(frame: CGRect(x: 10, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth - 20, height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)
                    
                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 36
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    var font:UIFont!
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
                        font = UIFont(name: Fonts().semibold, size: 18)!
                    }else{
                        font = UIFont(name: Fonts().regular, size: 14)!
                    }
                    
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
                        
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.textColor = UIColor(hex: 0x646464)
                    lblValue.textColor = UIColor(hex: 0x090909)
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
                        lblTitle.textColor = SColors.Theme_1
                        lblValue.textColor = SColors.Theme
                    }
                    
                    lblTitle.font = font
                    lblValue.font = font
                    
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
                    
                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    if(i == HistoryFareDetailsNewArr.count - 1){
                        lblTitle.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblValue.font = UIFont(name: Fonts().semibold, size: 18)!
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        lblTitle.textColor = UIColor(hex: 0x141414)
                        lblValue.textColor = SColors.Theme
                    }
                }
            }
            self.chargesContainerViewHeight.constant = CGFloat((self.chargesDataContainerView.subviews.count - totalSeperatorViews) * 40 + (totalSeperatorViews * seperatorViewHeight))
        }
        
        self.chargesParentViewHeight.constant = self.chargesContainerViewHeight.constant + 20
        
        self.chargesDataContainerView.layoutIfNeeded()
        self.chargesContainerView.layoutIfNeeded()
        
        self.PAGE_HEIGHT = self.PAGE_HEIGHT + self.chargesParentViewHeight.constant
       if tipMainView.isHidden == true {
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
           self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT + 50)
           self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 50)
       })
           
       }else{
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
               self.cntView.frame.size = CGSize(width: self.contentView.frame.width, height: self.PAGE_HEIGHT + 250)
               self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.PAGE_HEIGHT + 250)
           })
       }
       
    }
    
    func reOrderSetUp()
    {
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
            GeneralFunctions.saveValue(key: "ispriceshow", value: self.isSeparate as AnyObject)
            
            let reOrderItemsArray = self.detailDic.arrOf("DataReorder") as! [NSDictionary]
          
            let extraParaDic = ["min_order":self.detailDic.get("fMinOrderValue"), "vImage":self.detailDic.get("companyImage"), "companyAddress":self.detailDic.get("vRestuarantLocation"), "iCompanyId":self.detailDic.get("iCompanyId"), "vCompany": self.detailDic.get("vCompany")]
            GeneralFunctions.saveValue(key: "GeneralCartInfo", value: extraParaDic as AnyObject)
            
            
            var previousCartArray:NSMutableArray = NSMutableArray()
            if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA)){
                previousCartArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                previousCartArray.removeAllObjects()
            }
            
            for i in 0..<reOrderItemsArray.count
            {
                let menuItems = reOrderItemsArray[i].dictOf("menu_items").dictOf("MenuItemOptionToppingArr")
                var categoryArray = menuItems.arrOf("Category") as! [NSDictionary]
                let qty:Double = Double(String(reOrderItemsArray[i].get("iQty")))!
                let price:Double = Double(String(reOrderItemsArray[i].dictOf("menu_items").get("fPrice")))!
                var finalAmount = qty * price
                var selectedOpetionindex = [Int]()
                var selectedAddonIndex = [Int] ()
                let selcctOprtionArray = reOrderItemsArray[i].arrOf("OptionsArr") as! [NSDictionary]
                let selctedToppingArray = reOrderItemsArray[i].arrOf("AddOnItemArr") as! [NSDictionary]
                var selectedOptID = [Int] ()
                var selectedtopingID = [Int] ()
                // get Selected optID
                if selcctOprtionArray.count != 0 {
                for r in 0...selcctOprtionArray.count - 1{
                    let temp = selcctOprtionArray[r].get("vOptionId")
                    selectedOptID.append(Int(temp)!)
                }
                }
                // get Selected ToppingID
                if selctedToppingArray.count != 0 {
                for q in 0...selctedToppingArray.count - 1{
                    let temp = selctedToppingArray[q].get("vAddonId")
                    selectedtopingID.append(Int(temp)!)
                }
                }
                var optionsArrayGlobal = [NSDictionary]()
                var toppingArrayGlobal = [NSDictionary]()
                if categoryArray.count != 0 {
                for v in 0...categoryArray.count - 1 {
                 var optionArray = categoryArray[v].arrOf("options") as! [NSDictionary]
                var addonArray = categoryArray[v].arrOf("addon") as! [NSDictionary]
                optionsArrayGlobal += optionArray
                toppingArrayGlobal += addonArray
                }
                }
                let tampAmount = finalAmount
                //var selectedOptionIndex = ""
                for j in 0..<optionsArrayGlobal.count
                {
                    let tempID = Int(optionsArrayGlobal[j].get("iOptionId"))
                    if selectedOptID.contains(tempID!) {
                       // selectedOpetionindex.append(j)
                        finalAmount = finalAmount + (qty * Double(String(optionsArrayGlobal[j].get("fPrice")))!)
                    }
    
                }
                
                if(selectedOptID.count != 0 && (self.isSeparate.uppercased() == "SEPARATE")){
                    finalAmount = finalAmount - tampAmount
                }
                
                
                //var toppingSelectionArray = [Bool] ()
                for j in 0..<toppingArrayGlobal.count
                {
                    let tempID = Int(toppingArrayGlobal[j].get("iOptionId"))
                    if selectedtopingID.contains(tempID!) {
                       // selectedAddonIndex.append(j)
                        finalAmount = finalAmount + (qty * Double(String(toppingArrayGlobal[j].get("fPrice")))!)
                    }
    //                var checkAddonContains = false
    //                for k in 0..<selctedToppingArray.count{
    //                    if selctedToppingArray[k].get("vAddonId") == toppingArrayGlobal[j].get("iOptionId")
    //                    {
    //                        checkAddonContains = true
    //                        toppingSelectionArray.append(true)
    //                        finalAmount = finalAmount + (qty * Double(String(toppingArrayGlobal[j].get("fPrice")))!)
    //                    }
    //                }
    //                if checkAddonContains == false{
    //                    toppingSelectionArray.append(false)
    //                }
                }
                
                let dic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.detailDic.get("iCompanyId"), "vCompany": self.detailDic.get("vCompany"), "ItemData":reOrderItemsArray[i].dictOf("menu_items"),"selectedOptionIndex":selectedOptID,"selectedToppingIndexes":selectedtopingID, "itemCount":reOrderItemsArray[i].get("iQty"), "itemAmount": String(finalAmount)] as [String : Any])
                previousCartArray.add(dic)
            }
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: previousCartArray as AnyObject)
            
            let cartUV = GeneralFunctions.instantiateViewController(pageName: "CartUV") as! CartUV
            cartUV.isFromMenu = true
            cartUV.isFromReorder = true
            self.push(uv: cartUV)
        
        }else{
        
        GeneralFunctions.saveValue(key: "ispriceshow", value: self.isSeparate as AnyObject)
        
        let reOrderItemsArray = self.detailDic.arrOf("DataReorder") as! [NSDictionary]
      
        let extraParaDic = ["min_order":self.detailDic.get("fMinOrderValue"), "vImage":self.detailDic.get("companyImage"), "companyAddress":self.detailDic.get("vRestuarantLocation"), "iCompanyId":self.detailDic.get("iCompanyId"), "vCompany": self.detailDic.get("vCompany")]
        GeneralFunctions.saveValue(key: "GeneralCartInfo", value: extraParaDic as AnyObject)
        
        
        var previousCartArray:NSMutableArray = NSMutableArray()
        if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA)){
            previousCartArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
            previousCartArray.removeAllObjects()
        }
        
        for i in 0..<reOrderItemsArray.count
        {
            let menuItems = reOrderItemsArray[i].dictOf("menu_items").dictOf("MenuItemOptionToppingArr")
            let qty:Double = Double(String(reOrderItemsArray[i].get("iQty")))!
            let price:Double = Double(String(reOrderItemsArray[i].dictOf("menu_items").get("fPrice")))!
            var finalAmount = qty * price
            
            let optionArray = menuItems.arrOf("options") as! [NSDictionary]
            let addonArray = menuItems.arrOf("addon") as! [NSDictionary]
            //let addonArray = menuItems.arrOf("AddOnItemArr") as! [NSDictionary]
            
            let tampAmount = finalAmount
            var selectedOptionIndex = ""
            for j in 0..<optionArray.count
            {
                if reOrderItemsArray[i].get("vOptionId") == optionArray[j].get("iOptionId")
                {
                    selectedOptionIndex = String(j)
                    
                    finalAmount = finalAmount + (qty * Double(String(optionArray[j].get("fPrice")))!)
                    
                }
            }
            
            if(selectedOptionIndex != "" && (self.isSeparate.uppercased() == "SEPARATE")){
                finalAmount = finalAmount - tampAmount
            }
            
            let selctedToppingArray = reOrderItemsArray[i].arrOf("AddOnItemArr") as! [NSDictionary]
            var toppingSelectionArray = [Bool] ()
            for j in 0..<addonArray.count
            {
                var checkAddonContains = false
                for k in 0..<selctedToppingArray.count{
                    if selctedToppingArray[k].get("vAddonId") == addonArray[j].get("iOptionId")
                    {
                        checkAddonContains = true
                        toppingSelectionArray.append(true)
                        finalAmount = finalAmount + (qty * Double(String(addonArray[j].get("fPrice")))!)
                    }
                }
                if checkAddonContains == false{
                    toppingSelectionArray.append(false)
                }
            }
            
            let dic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.detailDic.get("iCompanyId"), "vCompany": self.detailDic.get("vCompany"), "ItemData":reOrderItemsArray[i].dictOf("menu_items"),"selectedOptionIndex":selectedOptionIndex,"selectedToppingIndexes":toppingSelectionArray, "itemCount":reOrderItemsArray[i].get("iQty"), "itemAmount": String(finalAmount)] as [String : Any])
            previousCartArray.add(dic)
        }
        GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: previousCartArray as AnyObject)
        
        let cartUV = GeneralFunctions.instantiateViewController(pageName: "CartUV") as! CartUV
        cartUV.isFromMenu = true
        cartUV.isFromReorder = true
        self.push(uv: cartUV)
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == self.submitRatingBtn){
            
            
            
            if(self.ufxRatingBar.rating > 0.0){
                let parameters = ["type":"submitRating","iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "iOrderId": orderId, "rating": "\(self.ufxRatingBar.rating)", "message": "\(commentTxtView.text!)", "iGeneralUserId":GeneralFunctions.getMemberd(), "eSystem": "DeliverAll", "eFromUserType":"Passenger", "eToUserType":"Driver"] /* FAV DRIVERS CHANGES */
                
                let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
                exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
                exeWebServerUrl.currInstance = exeWebServerUrl
                exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                    
                    if(response != ""){
                        let dataDict = response.toDict()
                        
                        if(dataDict.get("Action") == "1"){
                            self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRIP_RATING_FINISHED_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                                
                                self.close()
                            })
                        }else{
                            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                        }
                    }else{
                        self.generalFunc.setError(uv: self)
                    }
                })
            }else{
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ERROR_RATING_DIALOG_TXT"), uv: self)
            }
            
            return
        }
        
        if (sender == self.reOrderBtn){
           if(GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true){
                let previousCartArray:NSMutableArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
                if(previousCartArray.count > 0){
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_RESTAURANT_LBL"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0 {
                            self.reOrderSetUp()
                        }
                    })
                }else{
                    self.reOrderSetUp()
                }
            }else{
                self.reOrderSetUp()
            }
        }
        
        if (sender == self.giveTipButton){
            self.updateTipValue()
        }
        
        
    }
    
    //delivery preferences changes
       
       func myLableTapped(sender: MyLabel) {
           if(sender == self.viewPreferencesLabel){
               let viewPreferencesUV = GeneralFunctions.instantiateViewController(pageName: "ViewDeliveryPreferencesUV") as! ViewDeliveryPreferencesUV
               viewPreferencesUV.deliveryPreferencesArray = self.deliveryPreferencesArray
               viewPreferencesUV.deliveryPrefImg = self.deliveryPrefImg
               self.push(uv: viewPreferencesUV)
           }
       }
    
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTipValue(){
          
            var parameters = ["type": "OrderCollectTip", "UserType": Utils.appUserType, "eSystem":"DeliverAll", "iOrderId": self.orderId, "iMemberId": GeneralFunctions.getMemberd()]

        
            if(self.userProfileJson.get("DELIVERY_TIP_AMOUNT_TYPE_DELIVERALL").uppercased() == "PERCENTAGE"){
                
                if(self.tipPosition == "4"){
                    parameters["fTipAmount"] = self.tipAmount
                }else{
                    parameters["selectedTipPos"] = self.tipPosition
                }
            }else{
                if self.tipAmount != "" {
                   parameters["fTipAmount"] = self.tipAmount
                }else{
                parameters["fTipAmount"] = self.tipAmoTxtFiled.text!
                }
            }
            
            let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
            exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
            exeWebServerUrl.currInstance = exeWebServerUrl
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in

                if(response != ""){
                    let dataDict = response.toDict()

                    
                    if(dataDict.get("Action") == "1"){
                        
                        if(dataDict.get("paymentUrl") != ""){
//                            self.webView.isHidden = false
//                            self.webView.frame = Application.screenSize
//                            self.webView.backgroundColor = UIColor.white
//                            self.webView.navigationDelegate = self
//                            Application.window?.addSubview(self.webView)
//
//
//
//                            self.activityIndicatorWeb = UIActivityIndicatorView.init(frame: CGRect(x:(self.webView. / 2) - 10, y:(self.webView.frame.height / 2) - 10, width: 20, height:20))
//                            self.activityIndicatorWeb.style = .grayframe.width
//                            self.activityIndicatorWeb.hidesWhenStopped = true
//                            self.webView.addSubview(self.activityIndicatorWeb)
//
//                            let urlString = dataDict.get("paymentUrl").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                            let url = URL.init(string: urlString!)
//                            self.webView.load(URLRequest(url: url!))
                            
                            GeneralFunctions.addPayment(url: dataDict.get("paymentUrl") , uv: self)
                        }else{
                            self.closeTipView()
                            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                            self.getOrdersDetails()
                           // self.getData()
                        }
                        
                    }else{
                        
                        if(dataDict.get(Utils.message_str) == "LBL_SELECT_ENTER_TIP_AMOUNT_TXT"){
                            self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                        }else if (dataDict.get(Utils.message_str) == "LBL_REQUIRED_MINIMUM_AMOUT") {
                            self.generalFunc.setError(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message1")))
                            
                        }
                        else{
                            self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Add Card", key: "LBL_ADD_CARD"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "Cancel", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                                
                                if(btnClickedIndex == 0){
                                    
                                    self.closeTipView()
                                    
                                    let paymentUV = GeneralFunctions.instantiateViewController(pageName: "PaymentUV") as! PaymentUV
                                    self.push(uv: paymentUV)
                                }
                                
                            })
                        }
                        
                    }
                  
                }else{
                    self.generalFunc.setError(uv: self)
                }
            })
        }
    func closeTipView(){
           isShowTip = false
           isGiveTip = true
           self.tipMainViewHeight.constant = 00
           self.tipMainView.isHidden = true
           self.giveTipButtonHight.constant = 00
           self.giveTipButton.isHidden = true
       }
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
    
            
      
            if (urlString.contains(find: "success=1") || urlString.contains(find: "payfast_success.php?success=1") || urlString.contains(find: "payfast_thanks.php?success=1")){
                
                self.closeWebView()
                self.closeTipView()
                
                self.getOrdersDetails()
                
                
            }else if (urlString.contains(find: "success=0") || urlString.contains(find: "result.php?success=0")){
                
                self.closeWebView()

            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicatorWeb.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if(activityIndicator != nil){
            self.activityIndicatorWeb.stopAnimating()
        }
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    func closeWebView(){


       
        self.webView.isHidden = true
        self.webView.navigationDelegate = nil
        self.webView.removeFromSuperview()
        
        
       
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(self.tipAmoTxtFiled == textField){
            
            self.tipAmoOtherValueView.borderColor = SColors.Theme
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(self.tipAmoTxtFiled == textField){
            self.tipAmoOtherValueView.borderColor = UIColor.lightGray
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(self.tipAmoTxtFiled == textField){
            let newStr = textField.text! + string
            if(newStr != "" && GeneralFunctions.parseDouble(origValue: 0, data: newStr) <= 0){
                self.tipRequiredLbl.isHidden = false
                self.tipAmoOtherValueView.borderColor = UIColor.red
                
                self.tipRequiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_GRATER_ZERO_VALUE_TXT")
            }else{
                self.tipAmoOtherValueView.borderColor = SColors.Theme
                self.tipRequiredLbl.isHidden = true
            }
            let maxLength = 10
                let currentString: NSString = (textField.text ?? "") as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
        }
        return true
    }
}
