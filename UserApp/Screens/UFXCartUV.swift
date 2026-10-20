
import UIKit
import SysBaseLib
import WebKit
class UFXCartUV: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate,WKNavigationDelegate ,WKUIDelegate,UIScrollViewDelegate{

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var ufxCatTitleLbl: MyLabel!
    @IBOutlet weak var ufxCatDescLbl: MyLabel!
    @IBOutlet weak var moreLbl: MyLabel!
    @IBOutlet weak var instrauctionHLbl: MyLabel!
    @IBOutlet weak var instructionTxtView: UITextView!
    @IBOutlet weak var instructionTxtViewContainer: UIView!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var quantityViewHeight: NSLayoutConstraint!
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var plusImgView: UIImageView!
    @IBOutlet weak var minusImgView: UIImageView!
    @IBOutlet weak var addToCartBtn: MyButton!
    @IBOutlet weak var addToCartBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesDataContainerView: UIView!
    @IBOutlet weak var chargesParentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var chargesParentView: UIView!
    
    @IBOutlet weak var chargesParentViewY: NSLayoutConstraint!
    @IBOutlet weak var removeFromCartLbl: MyLabel!
    @IBOutlet weak var instructionTxtViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var cntViewBottomSpace: NSLayoutConstraint!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webViewHight: NSLayoutConstraint!
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var dataDic:NSDictionary!
    
    var vehicleData:NSDictionary!
    var driverId = ""
    
    var tCategoryDesc = ""
    var finalTotal = ""
    
    let moreLblTapGue = UITapGestureRecognizer()
    var CURRENT_MODE = "LESS"
    var defaultDescriptionHeight:CGFloat = 0
    
    var isFromEdit = false
    var selectdIndex = -1
    
    var itemCount = 1
    var scrollViewY = 0.0
    
    var loaderView:UIView!
    var eForVideoConsultation = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "UFXCartScreenDesign", uv: self, contentView: scrollView)
            self.setnavBarTintColor(color: SColors.Theme)
            self.scrollView.addSubview(cntView)
            self.webView.backgroundColor = UIColor.clear
            self.scrollView.backgroundColor = .white
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UFX_CART")
            self.ufxCatTitleLbl.text = ""
            self.ufxCatDescLbl.text = ""
            self.moreLbl.text = ""
            
            self.contentView.isHidden = true
            self.addToCartBtn.clickDelegate = self
            
            if(self.isFromEdit == true){
                self.removeFromCartLbl.isHidden = false
                self.removeFromCartLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UFX_REMOVE_FROM_CART").uppercased()
                self.addToCartBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UFX_EDIT_CART"))
                self.removeFromCartLbl.textColor = SColors.Red
                
                let removeFromCartTapGue = UITapGestureRecognizer()
                removeFromCartTapGue.addTarget(self, action: #selector(self.removeFromCartTapped))
                self.removeFromCartLbl.isUserInteractionEnabled = true
                self.removeFromCartLbl.addGestureRecognizer(removeFromCartTapGue)
                
                var array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
                let cartData = array[selectdIndex]
                
                self.instructionTxtView.text = cartData.get("SpecialInstruction")
                self.itemCount = Int(cartData.get("itemCount")) ?? 1
                self.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(describing: self.itemCount))
                
                if(self.eForVideoConsultation.uppercased() == "YES"){
                    self.removeFromCartLbl.isHidden = true
                }
                
            }else{
                self.removeFromCartLbl.isHidden = true
//                self.addToCartBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM"))
                self.addToCartBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_SERVICE_TXT"))
            }
            
            self.scrollView.alpha = 0
            
            if(self.eForVideoConsultation.uppercased() == "YES"){
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SPECIAL_INSTRUCTION_TXT")
                self.addToCartBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NEXT"))
            }
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            self.scrollView.bounces = false
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.height)
            self.cntView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.view.frame.height)
            
            self.shadowOnview(view: instructionTxtViewContainer)
            self.shadowOnview(view: chargesDataContainerView)
//            self.instructionTxtViewContainer.layer.addShadow(opacity: 0.8, radius: 2.5, UIColor.lightGray)
//            self.instructionTxtViewContainer.layer.roundCorners(radius: 10)
            if(self.eForVideoConsultation.uppercased() == "YES"){
                self.chargesParentView.clipsToBounds = true
                self.chargesParentView.backgroundColor = .clear//UIColor(hex: 0xf6f6f6)
//                self.shadowOnview(view: chargesParentView)
//                self.chargesParentView.layer.roundCorners(radius: 10)
            }else{
                self.chargesParentView.clipsToBounds = true
                self.chargesParentView.backgroundColor = UIColor(hex: 0xf6f6f6)
                self.shadowOnview(view: chargesParentView)
                self.chargesParentView.layer.roundCorners(radius: 10)
            }

            self.loadProviderServiceDetails()
        }
    }
    
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
    }
    
    func setData(){
        
        self.contentView.isHidden = false
        
//        self.instructionTxtViewContainer.roundTo(corners:[.topRight, .topLeft], radius: 18)
        
        self.instrauctionHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Add Special Instruction for provider below.", key: "LBL_INS_PROVIDER_BELOW")
        
        GeneralFunctions.setImgTintColor(imgView: self.plusImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: self.minusImgView, color: SColors.Theme)
        
        let vCategoryTitle = self.vehicleData.get("vVehicleType")
        let tCategoryDesc = self.vehicleData.get("vCategoryDesc")
      
        if(vCategoryTitle == ""){
            self.ufxCatTitleLbl.isHidden = true
        }else{
            self.ufxCatTitleLbl.isHidden = false
            self.ufxCatTitleLbl.setHTML(text: vCategoryTitle)
            //                            self.ufxCatTitleLbl.numberOfLines = 5
            self.ufxCatTitleLbl.fit()
            
        }
       
        if(tCategoryDesc == ""){
            self.ufxCatDescLbl.isHidden = true
            //self.moreLbl.isHidden = true
        }else{
            
            
            //self.moreLbl.isHidden = true
            self.ufxCatDescLbl.isHidden = true
            self.ufxCatDescLbl.numberOfLines = 2
            
            self.ufxCatDescLbl.setHTML(text: tCategoryDesc)
            self.tCategoryDesc = tCategoryDesc
            
            self.moreLbl.text = "+ \(self.generalFunc.getLanguageLabel(origValue: "View More", key: "LBL_VIEW_MORE_TXT"))"
            
            self.moreLbl.textColor = SColors.Theme
            
            self.moreLblTapGue.addTarget(self, action: #selector(self.moreTapped))
            
            self.moreLbl.isUserInteractionEnabled = true
            self.moreLbl.addGestureRecognizer(self.moreLblTapGue)
            
//            if self.ufxCatDescLbl.isTruncated {
//                print("trueRaviraj")
//            }else{
//                print("falseRaviraj")
//            }
            
        }
        let myText = self.ufxCatDescLbl.text! as NSString

        let rect = CGSize(width: self.ufxCatDescLbl.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.ufxCatDescLbl.font], context: nil)
         var linecount =  Int(ceil(CGFloat(labelSize.height) / self.ufxCatDescLbl.font.lineHeight))
        print(linecount)
        if(vCategoryTitle == "" && tCategoryDesc == ""){
            //self.moreLbl.isHidden = true
        }
      
        if linecount > 2 {
           // self.moreLbl.isHidden = false
        }else{
           // self.moreLbl.isHidden = true
        }
        if(self.vehicleData.get("eAllowQty").uppercased() != "YES"){
            
            self.quantityView.isHidden = true
            self.quantityViewHeight.constant = 0
           
        }else{
            self.plusView.backgroundColor = UIColor.clear
            self.minusView.backgroundColor = UIColor.clear
            
            let minusTapGesture = UITapGestureRecognizer()
            minusTapGesture.addTarget(self, action: #selector(self.minusTapped))
            self.minusView.isUserInteractionEnabled = true
            self.minusView.addGestureRecognizer(minusTapGesture)
            
            let plusTapGesture = UITapGestureRecognizer()
            plusTapGesture.addTarget(self, action: #selector(self.plusTapped))
            self.plusView.isUserInteractionEnabled = true
            self.plusView.addGestureRecognizer(plusTapGesture)
            
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.alpha = 1
           
        }, completion:{ _ in})
        
        if(Configurations.isRTLMode()){
            self.ufxCatTitleLbl.textAlignment = .right
        }else{
            self.ufxCatTitleLbl.textAlignment = .left
        }
    }
    
    func loadProviderServiceDetails(){
        
        if(self.loaderView != nil){
            self.loaderView.removeFromSuperview()
        }
        
        loaderView =  self.generalFunc.addMDloader(contentView: self.view)
        
        //loaderView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        loaderView.backgroundColor = UIColor.clear
        
        let parameters = ["type":"getVehicleTypeDetails", "iDriverId": driverId, "SelectedCabType": Utils.cabGeneralType_UberX, "iVehicleTypeId":dataDic.get("iVehicleTypeId"), "iMemberId": GeneralFunctions.getMemberd(), "eForVideoConsultation": self.eForVideoConsultation]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(self.loaderView != nil){
                
                self.loaderView.isHidden = true
                self.loaderView.removeFromSuperview()
            }
            
            if(response != ""){
                let dataDic = response.toDict()
                
                if(dataDic.get("Action") == "1"){
                    
                    self.vehicleData = dataDic.dictOf("message")
                    self.addFareDetails()
                    if self.vehicleData.get("vCategoryDesc") != "" {
                    self.webView.configuration.preferences.javaScriptEnabled = true
                    self.webView.isHidden = true
                    self.webView.scrollView.bounces = false
                    self.webView.navigationDelegate = self
                        self.webView.backgroundColor = UIColor.clear
                        self.webView.cornerRadius = 10
                        self.shadowOnview(view: self.webView)
                        if self.eForVideoConsultation.uppercased() == "YES" {
                           // self.webView.loadHTMLString(self.vehicleData.get("vCategoryDesc"), baseURL: nil)
                            self.webView.load(URLRequest(url: URL(string: self.vehicleData.get("vCategoryDesc"))!))
                            self.webView.scrollView.contentInset = UIEdgeInsets(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5)
                        }else{
                            self.webView.load(URLRequest(url: URL(string: self.vehicleData.get("vCategoryDesc"))!))
                        }
                    self.webView.scrollView.contentInsetAdjustmentBehavior = .never
                    self.webView.scrollView.delegate = self
                    self.webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
                    //self.webViewHight.constant = 0
                    self.webView?.uiDelegate = self
                    self.chargesParentViewY.constant = 15
                    }else{
                        self.webView.isHidden = true
                        self.webViewHight.constant = 0
                        self.chargesParentViewY.constant = -20
                    }
                    self.setData()
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDic.get("message")))
                }
              
            }else{
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "Please try again.", key: "LBL_TRY_AGAIN_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                    
                    self.loadProviderServiceDetails()
                })
                
            }
        
        })
    }
    
    @objc func moreTapped(){
        
        let descriptionHeight = tCategoryDesc.height(withConstrainedWidth: self.ufxCatDescLbl.frame.width, font: UIFont.init(name: Fonts().regular, size: 16)!) //tCategoryDesc.toHTML(fontName: Fonts().regular, fontSize: "15", textColor: "#4f4f4f", text: tCategoryDesc.description).height(withConstrainedWidth: self.ufxCatDescLbl.frame.width)

        if(CURRENT_MODE == "LESS"){
            defaultDescriptionHeight = descriptionHeight

            self.CURRENT_MODE = "MORE"
            self.webViewHight.constant = webView.scrollView.contentSize.height + 15
            self.moreLbl.text = "- \(self.generalFunc.getLanguageLabel(origValue: "Less", key: "LBL_LESS_TXT"))"

            self.ufxCatDescLbl.setHTML(text: tCategoryDesc)

            self.ufxCatDescLbl.fit()

            self.moreLbl.alpha = 1.0
            UIView.animate(withDuration: 0.3, animations: {

                self.scrollView.scrollToTop()
                self.view.layoutIfNeeded()
                self.moreLbl.alpha = 1.0
            })
            
            self.perform(#selector(self.addFareDetails), with: self, afterDelay: 0.5)

        }else{
            self.CURRENT_MODE = "LESS"
            self.ufxCatDescLbl.numberOfLines = 2
            self.webViewHight.constant = 35
            self.moreLbl.text = "+ \(self.generalFunc.getLanguageLabel(origValue: "View More", key: "LBL_VIEW_MORE_TXT"))"

//            UIView.animate(withDuration: 0.3, animations: {
//
//
//                self.scrollView.scrollToTop()
//                self.view.layoutIfNeeded()
//            })
            self.view.layoutIfNeeded()
            self.addFareDetails()
            //self.perform(#selector(self.addFareDetails), with: self, afterDelay: 0.5)
        }
    }
    
    
    @objc func plusTapped(){
       
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.plusView.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.2, animations: {
            self.plusView.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        var maxQuantity = 0
        maxQuantity = Int(self.vehicleData.get("iMaxQty")) ?? 0
        if(itemCount + 1 <= maxQuantity){
            itemCount = itemCount + 1
            UIView.transition(with: self.itemCountLbl,
                              duration: 0.1,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                
                                self?.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(describing: self!.itemCount))
                }, completion: { (bool) in
                    
            })
        }else{
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUANTITY_CLOSED_TXT"), uv: self)
        }
        self.addFareDetails()
        
    }
    
    @objc func minusTapped()
    {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.minusView.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.25, animations: {
            self.minusView.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        
        if itemCount != 1
        {
            itemCount = itemCount - 1
            UIView.transition(with: self.itemCountLbl,
                              duration: 0.1,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                
                                self?.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(describing: self!.itemCount))
                                
                }, completion: { (bool) in
                    
            })
            
            self.addFareDetails()
        }
    }
    
    @objc func addFareDetails(){
        
        for fareSubView in self.chargesDataContainerView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        
        let fareDetailsNewArr = self.vehicleData.arrOf("fareDetails")
        
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        var maxRtlValueWidhth: CGFloat = 0
        var maxRtlParentValue: CGFloat = 0

          if(Configurations.isRTLMode()){
            for i in 0..<fareDetailsNewArr.count {
                       let dict_temp = fareDetailsNewArr[i] as! NSDictionary
                       let totalSubViewCounts = self.chargesDataContainerView.subviews.count
                       for (key, value) in dict_temp {
                        if((key as! String) == "eDisplaySeperator"){
                            let viewWidth = Application.screenSize.width - 60
                            let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))
                            
                            viewCus.backgroundColor = UIColor(hex: 0xdedede)
                            
                            //                    self.fareContainerView.addArrangedSubview(viewCus)
                            self.chargesDataContainerView.addSubview(viewCus)
                            
                            totalSeperatorViews = totalSeperatorViews + 1
                        }else{
                            let viewWidth = Application.screenSize.width - 60
                            
                            let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 50))
                            
                            
                            let containsDigits = "0123456789."
                            let valueArray = Array(value as! String)
                            var newString = ""
                            for i in 0..<valueArray.count{
                                
                                if(containsDigits.contains(find: String(valueArray[i]))){
                                    newString = newString + String(valueArray[i])
                                }
                            }
                            if(newString == ""){
                                newString = value as! String
                            }
                            
                            var titleStr = ""
                            var valueStr = ""
                            if dict_temp.count == 2 {
                                if dict_temp.get("eReverseformattingEnable") == "Yes" {
                                     titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                                    valueStr = value as! String
                                }else{
                                    let quantityPrice = (Double(self.itemCount) * Double(newString)!)
                                    self.finalTotal = String(format: "%.02f", quantityPrice)
                                    
                                     titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                                     valueStr = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.finalTotal, addCurrncy: false, currencySymbol: self.vehicleData.get("vSymbol"))
                                }
                            }
                            else{
                                let quantityPrice = (Double(self.itemCount) * Double(newString)!)
                                self.finalTotal = String(format: "%.02f", quantityPrice)
                                
                                 titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                                 valueStr = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.finalTotal, addCurrncy: false, currencySymbol: self.vehicleData.get("vSymbol")) //Configurations.convertNumToAppLocal(numStr:self.vehicleData.get("vSymbol") + " " + self.finalTotal)
                            }
                            if(self.vehicleData.get("eAllowQty").uppercased() != "YES"){
                                //valueStr = value as! String
                            }
                            
                            var font:UIFont!
                            if(i == fareDetailsNewArr.count - 1){
                                 font = UIFont(name: Fonts().semibold, size: 14)!
                            }else{
                                font = UIFont(name: Fonts().regular, size: 14)!
                            }
                            var widthOfTitle = titleStr.width(withConstrainedHeight: 50, font: font) + 15
                            var widthOfvalue = valueStr.width(withConstrainedHeight: 50, font: font) + 15
                            
                            if(widthOfTitle > ((viewWidth * 40) / 100) && widthOfvalue > ((viewWidth * 60) / 100)){
                                widthOfvalue = ((viewWidth * 60) / 100)
                                widthOfTitle = ((viewWidth * 40) / 100)
                            }else if(widthOfTitle < ((viewWidth * 40) / 100) && widthOfvalue > ((viewWidth * 60) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                                widthOfvalue = viewWidth - widthOfTitle
                            }
                             let widthOfParentView = viewWidth - (viewWidth / 2)
                            
                            if widthOfvalue >= maxRtlValueWidhth {
                                maxRtlValueWidhth = widthOfvalue
                            }
                            if widthOfParentView >= maxRtlParentValue{
                                maxRtlParentValue = widthOfParentView
                            }
                           
                        }
                }
            }
        }
        for i in 0..<fareDetailsNewArr.count {
            let dict_temp = fareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
                
                let totalSubViewCounts = self.chargesDataContainerView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 60
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)
                    
                    //                    self.fareContainerView.addArrangedSubview(viewCus)
                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                    
                    
                }else{
                    let viewWidth = Application.screenSize.width - 60
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 50))
                    
                    
                    let containsDigits = "0123456789."
                    let valueArray = Array(value as! String)
                    var newString = ""
                    
                    for i in 0..<valueArray.count{
                        
                        if(containsDigits.contains(find: String(valueArray[i]))){
                            newString = newString + String(valueArray[i])
                        }else{
                            
                        }
                    }
                    if(newString == ""){
                        newString = value as! String
                    }
                    var titleStr = ""
                    var valueStr = ""
                    if dict_temp.count == 2 {
                        if dict_temp.get("eReverseformattingEnable") == "Yes" {
                             titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                            valueStr = value as! String
                        }else{
                            let quantityPrice = (Double(self.itemCount) * Double(newString)!)
                            self.finalTotal = String(format: "%.02f", quantityPrice)
                            
                             titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                             valueStr = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.finalTotal, addCurrncy: false, currencySymbol: self.vehicleData.get("vSymbol"))
                        }
                    }else{
                        let quantityPrice = (Double(self.itemCount) * Double(newString)!)
                        self.finalTotal = String(format: "%.02f", quantityPrice)
                        
                         titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                         valueStr = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.finalTotal, addCurrncy: false, currencySymbol: self.vehicleData.get("vSymbol"))
                    }
                    
                     //Configurations.convertNumToAppLocal(numStr:self.vehicleData.get("vSymbol") + " " + self.finalTotal)
                    
                    if(self.vehicleData.get("eAllowQty").uppercased() != "YES"){
                        //valueStr = value as! String
                    }
                    //if dict_temp.get("eReverseformattingEnable") == "Yes" {
                   
                    if((key as! String) != "eReverseformattingEnable") {
                    var font:UIFont!
                    if(i == fareDetailsNewArr.count - 1){
                         font = UIFont(name: Fonts().semibold, size: 14)!
                    }else{
                        font = UIFont(name: Fonts().regular, size: 14)!
                    }
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 50, font: font) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 50, font: font) + 15
                    
                    if(widthOfTitle > ((viewWidth * 40) / 100) && widthOfvalue > ((viewWidth * 60) / 100)){
                        widthOfvalue = ((viewWidth * 60) / 100)
                        widthOfTitle = ((viewWidth * 40) / 100)
                    }else if(widthOfTitle < ((viewWidth * 40) / 100) && widthOfvalue > ((viewWidth * 60) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }
                    
                    let widthOfParentView = viewWidth - (viewWidth / 2)
//
//                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView + 10, height: 60))
//
//                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfParentView - 10, height: 60))
                        var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView + 10, height: 50))
                        
                        var lblValue = MyLabel(frame: CGRect(x: widthOfParentView, y: 0, width: widthOfParentView - 10, height: 50))
                        
                        
                    if(Configurations.isRTLMode()){
                       // lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 40))
                        lblTitle = MyLabel(frame: CGRect(x: maxRtlValueWidhth + 15, y: 0, width: maxRtlParentValue, height: 50))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: maxRtlValueWidhth + 20, height: 50))
                        
                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.numberOfLines = 2
                        
                    lblTitle.textColor = UIColor(hex: 0x656565)
                    lblValue.textColor = UIColor(hex: 0x272727)
                    
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
                        
                        let myText = lblTitle.text! as NSString

                        let rect = CGSize(width: lblTitle.bounds.width, height: CGFloat.greatestFiniteMagnitude)
                        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: lblTitle.font], context: nil)
                         var linecount =  Int(ceil(CGFloat(labelSize.height) / lblTitle.font.lineHeight))
                        print(linecount)
                       
                        
                    var strFinalAmount = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: self.finalTotal, addCurrncy: true, currencySymbol: self.vehicleData.get("vSymbol"))
                    let dict = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                    let containsSymbol = "0123456789.,-"
                    let digitArray = Array(value as! String)
                  
                    var isContainSymbol = false
                    for i in 0..<valueArray.count{
                        
                        if(containsSymbol.contains(find: String(digitArray[i]))){
                            
                             
                        }else{
                            isContainSymbol = true
                        }
                    }
                    if isContainSymbol == false{
                        if  dict.get("eReverseSymbolEnable") == "Yes"{
                             strFinalAmount.removeLast()
                            
                        }else{
                               
                             strFinalAmount.remove(at: strFinalAmount.startIndex)
                            
                        }
                   
                    }
                        if dict_temp.count == 1{
                    lblValue.text = strFinalAmount
                        }
                    
                    viewCus.addSubview(lblTitle)
                    viewCus.addSubview(lblValue)
                
                    
                    self.chargesDataContainerView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .right
                        lblTitle.textAlignment = .right
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    if(i == fareDetailsNewArr.count - 1){
                        lblTitle.font = UIFont(name: Fonts().semibold, size: 14)!
                        lblValue.font = UIFont(name: Fonts().semibold, size: 14)!
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
                        lblTitle.setFontFamily()
                        lblValue.setFontFamily()
                        lblTitle.textColor = UIColor.black
                        lblValue.textColor = SColors.Theme
                        
                    }
                }
            }
            }
        }
        self.chargesParentViewHeight.constant = CGFloat((self.chargesDataContainerView.subviews.count - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight) + 30)
        
        self.chargesParentView.layoutIfNeeded()
        
        let size = CGSize(width: view.frame.width - 30, height: 50000)
        let boundingBox = tCategoryDesc.toHTML(fontName: Fonts().regular, fontSize: "16", textColor: "#4f4f4f", text: tCategoryDesc.description).boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics],
            context: nil
        )
        print(boundingBox.height)
        
         let descriptionHeight = boundingBox.height
        var extraHeight:CGFloat = 0
        if(self.CURRENT_MODE == "MORE"){
            extraHeight = extraHeight  + webViewHight.constant
        }
        
        if(self.vehicleData.get("eAllowQty").uppercased() == "YES"){
            extraHeight = extraHeight + 50
        }
        self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height:  self.chargesParentViewHeight.constant + 300 + extraHeight)
        
        self.cntView.frame = CGRect(x: 0, y: 0, width: Application.screenSize.width, height: self.chargesParentViewHeight.constant + 300 + extraHeight)
        
       // self.cntView.layoutIfNeeded()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
//
//
//
//        })
       
    }
    
    func myBtnTapped(sender: MyButton) {
        
        self.storeCartData()
        
        self.close()
    }

   
    @objc func removeFromCartTapped(){
       
        self.storeCartData(true)
        
        self.close()
    }
    
    func storeCartData(_ isForRemove:Bool = false){
        
        var cartArray = [NSDictionary] ()
      
       // let cmntStr = self.instructionTxtView.text! == "" ? "" : String(describing: self.instructionTxtView.text!.cString(using: String.Encoding.utf8))
        if dataDic.get("eFareType").uppercased() == "REGULAR" {
            self.finalTotal = ""
        }
        let dataDic = ["vehicleData":self.vehicleData!, "driverId":driverId,"itemCount":itemCount, "SpecialInstruction":self.instructionTxtView.text!, "finalTotal": self.finalTotal] as NSDictionary
        cartArray.append(dataDic)

        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == false){
            
            var array = [NSDictionary]()
            array.append(dataDic)
            GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
            
        }else{
            var array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            
            if(isForRemove == true){
                array.remove(at: selectdIndex)
                GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
                return
            }
            
            if(isFromEdit == true){
                // Replase exsisiting Object
                array.remove(at: selectdIndex)
                array.insert(dataDic, at: selectdIndex)
                GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
                return
            }
            
            array.append(dataDic)
            GeneralFunctions.saveValue(key: "UFXCartData", value: array as AnyObject)
            
        }
    }
    
    @objc func keyboardWillDisappear(sender: NSNotification){
        let info = sender.userInfo!
        _ = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        if(self.instructionTxtViewContainer != nil){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.cntViewBottomSpace.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
    }
    
    @objc func keyboardWillAppear(sender: NSNotification){
        
        let info = sender.userInfo!
        _  = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        if(self.instructionTxtViewContainer != nil){
           
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                self.cntViewBottomSpace.constant = 150
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
            })
        }
   
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("errorororoor:\(error)")
       
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
        webView.scrollView.isScrollEnabled = false
        webView.scalesLargeContentImage = true
        self.webView.isHidden = true
        self.moreLbl.isHidden = true
        print(webView.scrollView.contentSize.height)
        
        //self.webView.isHidden = false
       // self.moreLbl.isHidden = true
       
        Utils.delayWithSeconds(0.1) {
            self.webView.isHidden = false
            if webView.scrollView.contentSize.height > 35 {
                self.moreLbl.isHidden = false
            }else{
                self.moreLbl.isHidden = true
            }
        }
        //self.moreTapped
        //webViewHight.constant = webView.scrollView.contentSize.height + 100
       
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
             scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
