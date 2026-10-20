

import UIKit
import SysBaseLib

class CartUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, MyBtnClickDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate, ParentViewUVDelegate {

    @IBOutlet weak var addItemTypeViewWidth: NSLayoutConstraint!
    @IBOutlet weak var restProfileImgView: UIImageView!
    @IBOutlet weak var noItemSubHLbl: MyLabel!
    @IBOutlet weak var noItemHLBl: MyLabel!
    @IBOutlet weak var noItemImgView: UIImageView!
    @IBOutlet weak var noItemImgViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tablViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var finalTotalView: UIView!
    @IBOutlet weak var chargestxtLbl: UILabel!
    @IBOutlet weak var totalHeaderLbl: UILabel!
    @IBOutlet weak var totalvalueLbl: UILabel!
    @IBOutlet weak var submitBtn: MyButton!
    @IBOutlet weak var defaultHeaderView: UIView!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var companyNameSHLbl: UILabel!
    @IBOutlet weak var submitBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var defaultHeaderViewTop: NSLayoutConstraint!
    
    // Edit Item View
    @IBOutlet weak var editViewheight: NSLayoutConstraint!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editScrollBGView: UIView!
    @IBOutlet weak var editScrollView: UIScrollView!
    @IBOutlet weak var editCancelLbl: UILabel!
    @IBOutlet weak var editComapnyNameLbl: UILabel!
    @IBOutlet weak var editContentView: UIView!
    @IBOutlet weak var editContentViewHeight: NSLayoutConstraint!
    
    
    // New multiple addon & topping Related Change
    @IBOutlet weak var lblPrivious: MyLabel!
    @IBOutlet weak var lblNext: MyLabel!
    @IBOutlet weak var lblCategory: MyLabel!
    @IBOutlet weak var shadowViewHight: NSLayoutConstraint!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var horizontalScrollViewHight: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var editContentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var viewNextPrivious: UIView!
    @IBOutlet weak var imgViewNext: UIImageView!
    @IBOutlet weak var imgViewPrivious: UIImageView!
    @IBOutlet weak var editScrollHight: NSLayoutConstraint!
    @IBOutlet weak var viewNextPriviousHight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHight: NSLayoutConstraint!
    @IBOutlet weak var sepratorView: UIView!
    var toppingSelectionArray = [Bool] ()
    var optionSelctionIndex = -1
    var cartOptinViewsArray = [CartOptionViewForCart] ()
    var cartOptinViewsArrayNew = [CartOptionView]  ()
    var cartToppingViewsArray = [CartToppingViewForCart] ()
    var cartToppingViewsArrayNew = [CartToppingView] ()
    var selectedToppingArray = [NSDictionary] ()
    var selectedOptionsArray = [NSDictionary] ()
    var selcetedEidtViewIndex = -1
    var finalAmount = 0.0
    
    // Add Item View
    @IBOutlet weak var addItemViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addItemView: UIView!
    @IBOutlet weak var addItemHeaderLbl: MyLabel!
    @IBOutlet weak var addItemPriceLbl: MyLabel!
    @IBOutlet weak var addItemCuttxtLbl: MyLabel!
    @IBOutlet weak var addItemCutValLbl: MyLabel!
    @IBOutlet weak var addItemVegNonVegImgview: UIImageView!
    @IBOutlet weak var addItemChooseBtn: MyButton!
    @IBOutlet weak var addItemAplSameBtn: MyButton!
    var bgTapGesture = UITapGestureRecognizer()
    var addItemMode = false
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var foodItmData:NSMutableArray!
    var isFromMenu = false
    var isFromReorder = false
    var redirectToCheckOut = false
    var closeToSkipThisUV = false
    var isFirstLoad = false
    var minOrderPass = 0.0
    var heightForContainer = [CGFloat]()
    
    var isOpenRestaurantDetail = "No"
    
    var loaderView:UIView!
    // Multiple topiing related changes
    var optionsArrayGlobal = [NSDictionary] ()
    var toppingArrayGlobal = [NSDictionary] ()
    var selectionIndexOfOpetion = [Int] ()
    var selectionIndexToppings = [Int] ()
    var maxY = 0
    var categoryArray = [NSDictionary] ()
    var countOFTap = 0
    var positionYArray = [CGFloat]()
    var toppingArray = [NSDictionary] ()
    var optionsArray = [NSDictionary] ()
    var viewCurrenIndex = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
            
            isFirstLoad = true
            foodItmData = NSMutableArray.init()
            
            // Do any additional setup after loading the view.
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
                cntView = self.generalFunc.loadView(nibName: "CartScreenDesignNew", uv: self, contentView: contentView) //,
                self.contentView.addSubview(cntView)
               
            }else{
                cntView = self.generalFunc.loadView(nibName: "CartScreenDesign", uv: self, contentView: contentView) //,
                self.contentView.addSubview(cntView)
            }
            
            
            
            if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                
                foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
                
            }
            
           // GeneralFunctions.setImgTintColor(imgView:  self.noItemImgView, color: SColors.Theme)
            
            if foodItmData.count != 0
            {
                
                let item = self.foodItmData[0] as! NSDictionary
                
                self.companyNameLbl.text = item.get("vCompany")
                
                self.tableView.isHidden = false
                self.submitBtn.isHidden = false
                self.finalTotalView.isHidden = false
                self.defaultHeaderView.isHidden = false
                
                self.noItemImgView.isHidden = true
                self.noItemHLBl.isHidden = true
                self.noItemSubHLbl.isHidden = true
                
                let dic = GeneralFunctions.getValue(key: "GeneralCartInfo") as! NSDictionary
                
                self.restProfileImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: dic.get("vImage"), width: Utils.getValueInPixel(value: 65), height: Utils.getValueInPixel(value: 65))), placeholderImage:nil)
                self.restProfileImgView.backgroundColor = UIColor.clear
            
                self.companyNameSHLbl.text = dic.get("companyAddress")
                self.finalTotalView.backgroundColor = UIColor(hex: 0xE6E6E6)
                
                if Configurations.isRTLMode() == true{
                    self.companyNameLbl.textAlignment = .right
                    self.companyNameSHLbl.textAlignment = .right
                }else{
                    self.companyNameLbl.textAlignment = .left
                    self.companyNameSHLbl.textAlignment = .left
                }
                
            }
            
            
            self.updateFinalTotal()
            
            for i in 0..<self.foodItmData.count{
                heightForContainer.append(0)
            }
            self.tableView.register(UINib(nibName: "CartTVCell", bundle: nil), forCellReuseIdentifier: "CartTVCell")
            
            //self.tableView.bounces = false
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT_CART")
            
            self.noItemHLBl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMPTY_CART_H_LBL")
            self.noItemSubHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EMPTY_CART_SUB_H_LBL")
            
            self.totalHeaderLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TOTAL_TXT")
            self.chargestxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EXCLUDING_TAXES_TXT")
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHECKOUT"))
            self.submitBtn.clickDelegate = self
            
            self.addItemChooseBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE").uppercased())
            
            self.addItemChooseBtn.bgColor = UIColor.clear
            self.addItemChooseBtn.titleColor = SColors.Theme
            self.addItemChooseBtn.borderColor = SColors.Theme
            self.addItemChooseBtn.pulseColor = UIColor.lightGray
            self.addItemChooseBtn.clickDelegate = self
            self.addItemChooseBtn.enableCustomColor()
            
            self.addItemAplSameBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REPEAT").uppercased())
            self.addItemAplSameBtn.bgColor = SColors.Theme
            self.addItemAplSameBtn.titleColor = SColors.ThemeTxt
            self.addItemAplSameBtn.pulseColor = UIColor.darkGray
            self.addItemAplSameBtn.clickDelegate = self
            self.addItemAplSameBtn.enableCustomColor()
            
            let editCancelTapGesture = UITapGestureRecognizer()
            editCancelTapGesture.addTarget(self, action: #selector(self.editCancelTapped))
            self.editCancelLbl.isUserInteractionEnabled = true
            self.editCancelLbl.addGestureRecognizer(editCancelTapGesture)
            
        
            if GeneralFunctions.getSafeAreaInsets().bottom != 0
            {
    //            if isFromMenu == false{
    //                self.defaultHeaderViewTop.constant = 64
    //            }else
    //            {
    //                self.noItemImgViewCenterY.constant = -60
    //            }
                self.submitBtnHeight.constant = 30.0 + self.submitBtnHeight.constant
                
            }
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
            if(isFirstLoad == true){
                isFirstLoad = false
            }else{
                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                    
                    foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
                    
                }
                if self.foodItmData.count == 0
                {
                    self.tableView.isHidden = true
                    self.submitBtn.isHidden = true
                    self.finalTotalView.isHidden = true
                    self.defaultHeaderView.isHidden = true
                    
                    self.noItemImgView.isHidden = false
                    self.noItemHLBl.isHidden = false
                    self.noItemSubHLbl.isHidden = false
                }else{
                    self.tableView.isHidden = false
                    self.submitBtn.isHidden = false
                    self.finalTotalView.isHidden = false
                    self.defaultHeaderView.isHidden = false
                    
                    self.noItemImgView.isHidden = true
                    self.noItemHLBl.isHidden = true
                    self.noItemSubHLbl.isHidden = true
                }
                self.updateFinalTotal()
                self.tableView.reloadData()
            }
            
            
            if closeToSkipThisUV == true
            {
                closeToSkipThisUV = false
                self.navigationController?.popViewController(animated: false)
                return
            }
            
            if redirectToCheckOut == true{
                self.title = ""
                self.contentView.isHidden = true
                self.checkPrescription()
                return
    //            let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
    //            checkOutUV.redirectToCheckOut = redirectToCheckOut
    //            checkOutUV.cartUV = self
    //            (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(checkOutUV, animated: false)
    //            closeToSkipThisUV = redirectToCheckOut
    //            redirectToCheckOut = false
            }else{
                self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_EDIT_CART")
                self.contentView.isHidden = false
            }
            
        }else if(type == 3){
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
        }
    }
    
  
    
    /* Prescription Changes */
    func checkPrescription(){
        
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = false
        }
        
        var itemIDs = ""
        for i in 0..<foodItmData.count
        {
            let item = self.foodItmData[i] as! NSDictionary
            if(itemIDs == ""){
                itemIDs = item.dictOf("ItemData").get("iMenuItemId")
            }else{
                itemIDs = itemIDs + "," + item.dictOf("ItemData").get("iMenuItemId")
            }
        
        }
        let parameters = ["type":"CheckPrescriptionRequired","eSystem": "DeliverAll", "iMenuItemId":itemIDs]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.loaderView.isHidden = true
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    if(self.redirectToCheckOut == true){
                        let prescriptionUV = GeneralFunctions.instantiateViewController(pageName: "PrescriptionUV") as! PrescriptionUV
                        prescriptionUV.redirectToCheckOut = self.redirectToCheckOut
                        prescriptionUV.cartUV = self
                        (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(prescriptionUV, animated: false)
                        self.closeToSkipThisUV = self.redirectToCheckOut
                        self.redirectToCheckOut = false
                    }else{
                        let prescriptionUV = GeneralFunctions.instantiateViewController(pageName: "PrescriptionUV") as! PrescriptionUV
                        prescriptionUV.isFromMenu = self.isFromMenu
                        self.push(uv: prescriptionUV)
                    }
                   
                }else{
                    
                    if(self.redirectToCheckOut == true){
                        let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
                        checkOutUV.redirectToCheckOut = self.redirectToCheckOut
                        checkOutUV.cartUV = self
                        checkOutUV.minOrderPass =  self.minOrderPass
                        (self.navigationDrawerController?.rootViewController as! UINavigationController).pushViewController(checkOutUV, animated: false)
                        self.closeToSkipThisUV = self.redirectToCheckOut
                        self.redirectToCheckOut = false
                    }else{
                        let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
                        checkOutUV.isFromMenu = self.isFromMenu
                        checkOutUV.minOrderPass =  self.minOrderPass
                        self.push(uv: checkOutUV)
                    }
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
               
                
            }
        })
    }/* .............*/
    
    override func close(){
        
        if self.isFromReorder == true{
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if(ServiceModule.isDeliverAllOnly()) // For only DeliverAll app
            {
                let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
                if serviceCategoryArray.count > 1
                {
                    if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                    }
                    
                }else
                {
                    if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                    }
                  
                }
            }else
            {
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }
          
        }else
        {
            super.close()
        }
        
    }
 
    // Table View Height adjust according items
    func adjustHeight()
    {
        var defaultSpace:CGFloat = 280.0
        if GeneralFunctions.getSafeAreaInsets().bottom != 0
        {
            defaultSpace = 310.0
        }
        self.view.layoutIfNeeded()
        if CGFloat(110 * foodItmData.count) >= CGFloat(self.view.frame.size.height - defaultSpace)
        {
           // self.tablViewHeight.constant = CGFloat(self.view.frame.size.height) - defaultSpace
            self.tableView.bounces = true
        }else
        {
           // self.tablViewHeight.constant = CGFloat(110 * foodItmData.count)
            self.tableView.bounces = false
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
        })
    }
    
    // Final total update by this method calling
    func updateFinalTotal()
    {
        finalAmount = 0.0
        for i in 0..<foodItmData.count
        {
            let item = self.foodItmData[i] as! NSDictionary
            finalAmount = (finalAmount + Double(item.get("itemAmount"))!).roundTo(places: 2)
            
            let itemData = item.dictOf("ItemData")
            self.totalvalueLbl.text = itemData.get("currencySymbol") + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: String(finalAmount))))
            
            self.totalvalueLbl.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: String(finalAmount))), addCurrncy: true, currencySymbol: itemData.get("currencySymbol"))
            
            if Configurations.isRTLMode() == true{
                self.totalvalueLbl.textAlignment = .left
               
            }else{
                self.totalvalueLbl.textAlignment = .right
            }
            
        }
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Edit View Close lbl
    @objc func closeAddViewTapped()
    {
        if self.editView.isHidden == true
        {
            self.editScrollBGView.isHidden = true
            self.view.layoutIfNeeded()
            self.addItemViewHeight.constant = 0
            self.addItemView.isHidden = true
            self.editScrollBGView.removeGestureRecognizer(bgTapGesture)
        }
        
    }
    
    // When user press + singn view load
    func addViewSetUp(index:Int)
    {
        self.selectedToppingArray.removeAll() // topping name array
        self.selectedOptionsArray.removeAll() // options name array
        self.toppingSelectionArray.removeAll()  // True, false array for topping
        
        self.editScrollBGView.isHidden = false
        
        bgTapGesture.addTarget(self, action: #selector(self.closeAddViewTapped))
        self.editScrollBGView.isUserInteractionEnabled = true
        self.editScrollBGView.addGestureRecognizer(bgTapGesture)
        
        self.addItemView.isHidden = false
        self.addItemCuttxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PREVIOUS_CUST_TITLE")
        
        let item = self.foodItmData[index] as! NSDictionary
        let itemData = item.dictOf("ItemData")
        let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
        self.selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        self.selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
        
       
        if itemData.get("eFoodType") == "Veg"
        {
            self.addItemTypeViewWidth.constant = 15
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_veg")
        }else if itemData.get("eFoodType") == "NonVeg"
        {
            self.addItemTypeViewWidth.constant = 15
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_nonVeg")
        }else
        {
            self.addItemTypeViewWidth.constant = 0
             self.addItemVegNonVegImgview.isHidden = true
        }
        
        self.addItemCutValLbl.text = ""
        var valueExists = false
        for i in 0..<selectedOptionsArray.count
        {
            if Int(item.get("selectedOptionIndex")) == i
            {
                valueExists = true
                self.addItemCutValLbl.text = selectedOptionsArray[i].get("vOptionName")
            }
        }
        
        let toppingSelArray = item.arrOf("selectedToppingIndexes") as! [Bool]
        for i in 0..<toppingSelArray.count
        {
            if toppingSelArray[i] == true
            {
                if self.addItemCutValLbl.text == ""{
                    self.addItemCutValLbl.text = selectedToppingArray[i].get("vOptionName")
                }else
                {
                    self.addItemCutValLbl.text = self.addItemCutValLbl.text! + ", " + selectedToppingArray[i].get("vOptionName")
                }
                
                valueExists = true
            }
        }
        
        if valueExists == false
        {
            self.addItemCutValLbl.text = "--"
        }
        
        var itemAmount:Double!
        if GeneralFunctions.parseDouble(origValue: 0.0, data: itemData.get("fOfferAmt")) > 0.0
        {
            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fDiscountPrice"))
        }else{

            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fPrice"))
        }
        
       // itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fPrice"))
        
        self.addItemHeaderLbl.text = itemData.get("vItemType")
        self.addItemPriceLbl.text = itemData.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(itemAmount))
        
        if Configurations.isRTLMode() == true{
            self.addItemPriceLbl.textAlignment = .right
            self.addItemHeaderLbl.textAlignment = .right
        }else{
            self.addItemPriceLbl.textAlignment = .left
            self.addItemHeaderLbl.textAlignment = .left
        }
        
        self.view.layoutIfNeeded()
        self.addItemViewHeight.constant = 250
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            
        })
    }
    
    // When user press "Edit" view load
    @objc func editTapped(sender:UITapGestureRecognizer)
    {
        
        self.selectedToppingArray.removeAll() // topping name array
        self.selectedOptionsArray.removeAll() // options name array
        self.toppingSelectionArray.removeAll()  // True, false array for topping
        
        let index = sender.view!.tag
        self.selcetedEidtViewIndex = index
        
        self.editScrollBGView.isHidden = false
        self.editView.isHidden = false
        
        
        let item = self.foodItmData[index] as! NSDictionary
        let itemData = item.dictOf("ItemData")
        let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
        self.categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
        self.selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        self.selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
       
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
            
            createViewForEditNew(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
        }else{
            createViewForEdit(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
        }
       
        
        
        self.view.layoutIfNeeded()
        
        self.editViewheight.constant = 380
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            
        })
    }
    
    // Edit View Create according topping & options
    func createViewForEdit(optionsArray:[NSDictionary], toppingArray:[NSDictionary], finalData:NSDictionary)
    {
        self.cartOptinViewsArray.removeAll()
        self.cartToppingViewsArray.removeAll()
        
        for view in self.editContentView.subviews
        {
            view.removeFromSuperview()
        }
        
        let itemData = finalData.dictOf("ItemData")
        self.editComapnyNameLbl.text = itemData.get("vItemType")
        self.toppingSelectionArray = finalData.arrOf("selectedToppingIndexes") as! [Bool]
        var yPosition = 10
        for i in 0..<optionsArray.count
        {
            if i == 0
            {
                let optionTitleLbl = UILabel(frame: CGRect(x: 10, y: yPosition , width: Int(self.view.frame.size.width - 20), height: 30))
                optionTitleLbl.textColor = SColors.Theme
                optionTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 16)
                optionTitleLbl.autoresizingMask = [.flexibleWidth]
                optionTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_OPTIONS")
                self.editContentView.addSubview(optionTitleLbl)
                
                yPosition = yPosition + 30
            }
            
            
            let optionsView = CartOptionViewForCart(frame: CGRect(x:0, y: yPosition + (i * 50)  , width: Int(self.view.frame.size.width), height: 50))
            optionsView.tag = i
            optionsView.autoresizingMask = [.flexibleWidth]
            GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: UIColor.darkGray)
            
            if Int(finalData.get("selectedOptionIndex")) == i && self.addItemMode == false
            {
                self.optionSelctionIndex = i
                optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
            }
            
            if self.addItemMode == true{
                
                if (optionsArray[i] ).get("eDefault") == "Yes"
                {
                    if self.optionSelctionIndex != i
                    {
                        if self.optionSelctionIndex >= 0
                        {
                            (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView.image = UIImage(named: "ic_select_false")
                            GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: UIColor.darkGray)
                        }
                        
                        self.optionSelctionIndex = i
                        optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                        GeneralFunctions.setImgTintColor(imgView:optionsView.selctionImgView, color: SColors.Theme)
                    }
                }
            }
            
            optionsView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: (optionsArray[i] ).get("fUserPriceWithSymbol"))
            optionsView.titleLbl.text = (optionsArray[i] ).get("vOptionName")
            self.editContentView.addSubview(optionsView)
            self.cartOptinViewsArray.append(optionsView)
            
            let optionTapGesture = UITapGestureRecognizer()
            optionTapGesture.addTarget(self, action: #selector(self.optionTapped(sender:)))
            optionsView.isUserInteractionEnabled = true
            optionsView.addGestureRecognizer(optionTapGesture)
            
            if i == optionsArray.count - 1
            {
                yPosition = yPosition + (i * 50) + 50
            }
            
            if Configurations.isRTLMode() == true{
                optionsView.priceLbl.textAlignment = .left
            }else{
                optionsView.priceLbl.textAlignment = .right
            }
        }
        
        for i in 0..<toppingArray.count
        {
            if i == 0
            {
                
                let toppingTitleLbl = UILabel(frame: CGRect(x: 10, y: yPosition + 10 , width: Int(self.view.frame.size.width - 20), height: 30))
                toppingTitleLbl.textColor = SColors.Theme
                toppingTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 16)
                toppingTitleLbl.autoresizingMask = [.flexibleWidth]
                toppingTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TOPPING")
                self.editContentView.addSubview(toppingTitleLbl)
                
                yPosition = yPosition + 40
            }
            
           
            let toppingView = CartToppingViewForCart(frame: CGRect(x:0, y: yPosition + (i * 50) , width: Int(self.view.frame.size.width), height: 50))
            
            toppingView.tag = i
            toppingView.autoresizingMask = [.flexibleWidth]
            toppingView.selctionImgView.boxType = .square
            toppingView.selctionImgView.offAnimationType = .bounce
            toppingView.selctionImgView.onAnimationType = .bounce
            toppingView.selctionImgView.onCheckColor = SColors.ThemeTxt
            toppingView.selctionImgView.onFillColor = SColors.Theme
            toppingView.selctionImgView.onTintColor = SColors.Theme
            toppingView.selctionImgView.tintColor = SColors.Theme
            toppingView.selctionImgView.isUserInteractionEnabled = false
            
            toppingView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: (toppingArray[i]).get("fUserPriceWithSymbol"))
            toppingView.titleLbl.text = (toppingArray[i]).get("vOptionName")
            
            if toppingSelectionArray[i] == true && self.addItemMode == false
            {
                toppingView.selctionImgView.on = true
            }else{
                self.toppingSelectionArray[i] = false
            }
            
            self.editContentView.addSubview(toppingView)
            self.cartToppingViewsArray.append(toppingView)
            
            let toppingTapGesture = UITapGestureRecognizer()
            toppingTapGesture.addTarget(self, action: #selector(self.toppingTapped(sender:)))
            toppingView.isUserInteractionEnabled = true
            toppingView.addGestureRecognizer(toppingTapGesture)
            
            if i == toppingArray.count - 1
            {
                yPosition = yPosition + (i * 50) + 50
            }
            
            if Configurations.isRTLMode() == true{
                toppingView.priceLbl.textAlignment = .left
            }else{
                toppingView.priceLbl.textAlignment = .right
            }
        }
        
        self.editCancelLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased()
        self.editCancelLbl.textColor = UIColor(hex: 0x373737)
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART").uppercased())
        
        
        self.view.layoutIfNeeded()
        
        self.editContentViewHeight.constant = CGFloat(yPosition)
        self.editScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.editContentViewHeight.constant + 10)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            
        })
    }
    
    func finalEditedItemTotal(index:Int) -> String
    {
        let itemData = self.foodItmData[index] as! NSDictionary
        let dataDic = itemData.dictOf("ItemData")
       
        var itemCount = itemData.get("itemCount")
        if self.addItemMode == true{
            itemCount = "1"
        }
        
        var itemAmount = 0.0
        if GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fOfferAmt")) > 0.0
        {
            itemAmount = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fDiscountPrice"))

        }else{

            itemAmount = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fPrice"))

        }
        
        let sepPrice = GeneralFunctions.getValue(key: "ispriceshow")
        if(sepPrice?.uppercased == "SEPARATE"){
            if(self.optionSelctionIndex >= 0){
                itemAmount = 0
            }
        }
        
       // itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: dataDic.get("fPrice"))
       
        var totalAmount = Double(itemAmount) * Double(itemCount)!
        if self.optionSelctionIndex >= 0
        {
            totalAmount = totalAmount + (Double(self.selectedOptionsArray[self.optionSelctionIndex].get("fUserPrice"))! * Double(itemCount)!)
        }
        
        for i in 0..<self.toppingSelectionArray.count
        {
            if self.toppingSelectionArray[i] == true{
                totalAmount = totalAmount + (Double(self.selectedToppingArray[i].get("fUserPrice"))! * Double(itemCount)!)
            }
        }
        
        
        
        return String(totalAmount.roundTo(places: 2))
        
    }
    
    @objc func editCancelTapped()
    {
        self.addItemMode = false
        self.toppingSelectionArray.removeAll()
        self.optionSelctionIndex = -1
        
        self.editCancelLbl.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.25, animations: {
            self.editCancelLbl.layer.transform = CATransform3DMakeScale(1,1,1)
        })
       
        self.view.layoutIfNeeded()
        self.view.setNeedsDisplay()
        
        self.editViewheight.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            self.editScrollBGView.isHidden = true
            self.editView.isHidden = true
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHECKOUT"))
        })
    }
    
    @objc func toppingTapped(sender:UITapGestureRecognizer)
    {
        
          let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
          if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {

         let index = sender.view!.tag
//        (self.cartToppingViewsArrayNew[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
//        UIView.animate(withDuration: 0.25, animations: {
//            (self.cartToppingViewsArrayNew[index]).layer.transform = CATransform3DMakeScale(1,1,1)
//        })
            if self.selectionIndexToppings.contains(index){

                ((sender.view) as! CartToppingView).selctionImgView.on = false
                
                self.selectionIndexToppings.remove(object: index)
            }else{
                ((sender.view) as! CartToppingView).selctionImgView.on = true
                self.selectionIndexToppings.append(index)
            }
        
          }else{
            let index = sender.view!.tag
            
            (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
            UIView.animate(withDuration: 0.25, animations: {
                (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(1,1,1)
            })
            
            if self.toppingSelectionArray[index] == false
            {
                self.toppingSelectionArray[index] = true
                ((sender.view) as! CartToppingViewForCart).selctionImgView.on = true
                
            }else{
                
                self.toppingSelectionArray[index] = false
                ((sender.view) as! CartToppingViewForCart).selctionImgView.on = false
                
            }
        }
    }
    
    @objc func optionTapped(sender:UITapGestureRecognizer)
    {
          let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
                   if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        let index = sender.view!.tag
                
                self.optionSelctionIndex = index
              for view in editContentView.subviews{
                
                    
               if let view = view as? CartOptionView{
                // view changes only for particular selected category
                if view.selctionImgView.tag == self.countOFTap {
                    let tempAry = categoryArray[self.countOFTap].arrOf("options") as! [NSDictionary]
                    for i in 0..<tempAry.count {
                      var opetionTag =  Int(tempAry[i].get("iOptionId")) ?? 00
                        if self.selectionIndexOfOpetion.contains(opetionTag){
                            self.selectionIndexOfOpetion.remove(object: opetionTag)
                        }
                    }
                    // tapped all opetion unselected form here (Particular category)
                        view.selctionImgView.image = UIImage(named: "ic_select_false")
                        GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
                        GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
                    // tapped opetion id select here
                   if view.tag == index {
                    
                   view.selctionImgView.image = UIImage(named: "ic_select_true")
                     GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
                    GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
                    }
                }
                }
              }
              // tapped opetion id store here
              if !selectionIndexOfOpetion.contains(index){
              selectionIndexOfOpetion.append(index)
              }
                   }
                   
                   else{
                    let index = sender.view!.tag
                    
                    (self.cartOptinViewsArray[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
                    UIView.animate(withDuration: 0.2, animations: {
                        (self.cartOptinViewsArray[index]).layer.transform = CATransform3DMakeScale(1,1,1)
                    })
                    
                    if self.optionSelctionIndex != index
                    {
                        if self.optionSelctionIndex >= 0
                        {
                            (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView.image = UIImage(named: "ic_select_false")
                            GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionViewForCart).selctionImgView, color: UIColor.darkGray)
                        }
                        
                        self.optionSelctionIndex = index
                        ((sender.view) as! CartOptionViewForCart).selctionImgView.image = UIImage(named: "ic_select_true")
                        GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionViewForCart).selctionImgView, color: SColors.Theme)
                    }
        }
                
    }
    
    @objc func plusTapped(sender:UITapGestureRecognizer)
    {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let index = sender.view!.tag
        sender.view!.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.25, animations: {
            sender.view!.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        
        self.selcetedEidtViewIndex = index
        
        sender.view!.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.2, animations: {
            sender.view!.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        
        let item = self.foodItmData[index] as! NSDictionary
        let itemData = item.dictOf("ItemData")

        let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
        var categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
        let selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        let selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        if categoryArray.count == 0
        //if selectedOptionsArray.count == 0 && selectedToppingArray.count == 0
        {
            self.perform(#selector(repeatItem), with: self, with: 0.3)
            //self.repeatItem()
        }else{
            self.addViewSetUpNew(index: index)
        }
        }else{
            let selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
            let selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
            if selectedOptionsArray.count == 0 && selectedToppingArray.count == 0
            {
                self.perform(#selector(repeatItem), with: self, with: 0.3)
                //self.repeatItem()
            }else{
                self.addViewSetUp(index: index)
            }
        }
    }
    
    @objc func minusTapped(sender:UITapGestureRecognizer)
    {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let index = sender.view!.tag
        
        sender.view!.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.25, animations: {
            sender.view!.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        
        
        let item = (self.foodItmData[index] as! NSDictionary).mutableCopy() as! NSMutableDictionary
        let amount = Double(item.get("itemCount"))
        let newAmount:Double = Double(item.get("itemAmount"))! / amount!
        let finalAmount:Double = (Double(item.get("itemAmount"))! - newAmount).roundTo(places: 2)
        
        item["itemAmount"] = String(finalAmount)
        
        let newCount = String(Int(item.get("itemCount"))! - 1)
        item["itemCount"] = newCount
        
        
        if (newCount != "0")
        {
            self.foodItmData.replaceObject(at: index, with: item)
            self.updateFinalTotal()
            
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
            tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
            
            sender.view!.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
            UIView.animate(withDuration: 0.25, animations: {
                sender.view!.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        }else
        {
            self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_REMOVE_TEXT"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CART_ITEM"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                
                if btnClickedIndex == 0
                {
                    self.foodItmData.removeObject(at: index)
                    self.updateFinalTotal()
                    
                    GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
                    
                    if self.foodItmData.count == 0
                    {
                        self.tableView.isHidden = true
                        self.submitBtn.isHidden = true
                        self.finalTotalView.isHidden = true
                        self.defaultHeaderView.isHidden = true
                        
                        self.noItemImgView.isHidden = false
                        self.noItemHLBl.isHidden = false
                        self.noItemSubHLbl.isHidden = false
                    }
                    let currentOffset = self.tableView.contentOffset
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(currentOffset, animated: false)
                    //self.adjustHeight()
                }
            })
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.foodItmData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CartTVCell") as! CartTVCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.cntView.layer.addShadow(opacity: 0.6, radius: 2.5, UIColor.lightGray)
        cell.cntView.layer.roundCorners(radius: 8)
        
        let minusTapGesture = UITapGestureRecognizer()
        minusTapGesture.addTarget(self, action: #selector(self.minusTapped(sender:)))
        cell.minusImgView.isUserInteractionEnabled = true
        cell.minusImgView.tag = indexPath.row
        cell.minusImgView.addGestureRecognizer(minusTapGesture)
        
        let plusTapGesture = UITapGestureRecognizer()
        plusTapGesture.addTarget(self, action: #selector(self.plusTapped(sender:)))
        cell.plusImgView.isUserInteractionEnabled = true
        cell.plusImgView.tag = indexPath.row
        cell.plusImgView.addGestureRecognizer(plusTapGesture)
        
        GeneralFunctions.setImgTintColor(imgView: cell.plusImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: cell.minusImgView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: cell.editImgView, color: SColors.Theme)
        
        cell.editLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUSTOMIZE").uppercased()
       // cell.editLbl.textColor = SColors.Theme
        
        let editTapGesture = UITapGestureRecognizer()
        editTapGesture.addTarget(self, action: #selector(self.editTapped(sender:)))
        cell.editLbl.tag = indexPath.row
        cell.editLbl.isUserInteractionEnabled = true
        cell.editLbl.addGestureRecognizer(editTapGesture)
       
        let item = self.foodItmData[indexPath.row] as! NSDictionary
        let itemData = item.dictOf("ItemData")
        cell.foodItemName.text = itemData.get("vItemType")
        
        cell.foodItemPriceLbl.text = itemData.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: item.get("itemAmount"))))
        cell.itemCountLbl.text =  Configurations.convertNumToAppLocal(numStr: item.get("itemCount"))
        cell.foodItemPriceLbl.textColor = SColors.Theme
        
        let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
        //let selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        //let selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
        
         var categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
        var optionsArray = [NSDictionary]()
         var toppingArray = [NSDictionary]()
        var optionsArrayGlobal = [NSDictionary]()
        var toppingArrayGlobal = [NSDictionary]()
            if categoryArray.count != 0 {
        for j in 0...categoryArray.count - 1 {
        optionsArray = categoryArray[j].arrOf("options") as! [NSDictionary]
        toppingArray = categoryArray[j].arrOf("addon") as! [NSDictionary]
        optionsArrayGlobal += optionsArray
        toppingArrayGlobal += toppingArray
        }
            }
        if itemData.get("eFoodType") == "Veg"
        {
            self.addItemTypeViewWidth.constant = 15
            cell.itemTypeImgViewWidth.constant = 16
            cell.itemTypeImgView.isHidden = false
            self.addItemVegNonVegImgview.isHidden = false
            cell.itemTypeImgView.image = UIImage(named: "ic_veg")
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_veg")
        }else if itemData.get("eFoodType") == "NonVeg"
        {
            self.addItemTypeViewWidth.constant = 15
            cell.itemTypeImgViewWidth.constant = 16
            cell.itemTypeImgView.isHidden = false
            self.addItemVegNonVegImgview.isHidden = false
            cell.itemTypeImgView.image = UIImage(named: "ic_nonVeg")
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_nonVeg")
        }else{
            self.addItemTypeViewWidth.constant = 0
            cell.itemTypeImgViewWidth.constant = 0
            cell.itemTypeImgView.isHidden = true
            self.addItemVegNonVegImgview.isHidden = true
        }
        
        cell.optionsLbl.text = ""
        
        
        let tempSelectedOptions = item.arrOf("selectedOptionIndex") as! [Int]
        if tempSelectedOptions.count != 0 {
            for i in 0...optionsArrayGlobal.count - 1 {
                let tempID = Int(optionsArrayGlobal[i].get("iOptionId")) ?? 00
                if tempSelectedOptions.contains(tempID){
                    if cell.optionsLbl.text == ""{
                        cell.optionsLbl.text = optionsArrayGlobal[i].get("vOptionName")
                    }else
                    {
                        cell.optionsLbl.text =  cell.optionsLbl.text! + ", " + optionsArrayGlobal[i].get("vOptionName")
                    }
                }
                
            }
        }
//            if Int(item.get("selectedOptionIndex")) == i
//            {
//                cell.optionsLbl.text = selectedOptionsArray[i].get("vOptionName")
//            }
        
        
        let toppingSelArray = item.arrOf("selectedToppingIndexes") as! [Int]
        if toppingSelArray.count != 0 {
            for i in 0...toppingArrayGlobal.count - 1 {
                let tempID = Int(toppingArrayGlobal[i].get("iOptionId")) ?? 00
                if toppingSelArray.contains(tempID){
                    if cell.optionsLbl.text == ""{
                        cell.optionsLbl.text = toppingArrayGlobal[i].get("vOptionName")
                    }else
                    {
                        cell.optionsLbl.text =  cell.optionsLbl.text! + ", " + toppingArrayGlobal[i].get("vOptionName")
                    }
                }
                
            }
        }
        
        if tempSelectedOptions.count == 0 && toppingSelArray.count == 0
        {
            cell.editLbl.isHidden = true
            cell.editImgView.isHidden = true
            
        }else{
            
            cell.editImgView.isHidden = false
            cell.editLbl.isHidden = false
            
        }
        
        if(cell.optionsLbl.text != "" && cell.editLbl.isHidden == false){
            heightForContainer.remove(at: indexPath.row)
            heightForContainer.insert(120 + cell.optionsLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().light, size: 13)!), at: indexPath.row)
        }else if(cell.editLbl.isHidden == false){
            heightForContainer.remove(at: indexPath.row)
            heightForContainer.insert(120, at: indexPath.row)
        }else{
            heightForContainer.remove(at: indexPath.row)
            heightForContainer.insert(80, at: indexPath.row)
        }
        
        if Configurations.isRTLMode() == true{
            
            cell.foodItemName.textAlignment = .right
            cell.optionsLbl.textAlignment = .right
         
        }else{
            
            cell.foodItemName.textAlignment = .left
            cell.optionsLbl.textAlignment = .left
        }
        return cell
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "CartTVCell") as! CartTVCell
             cell.selectionStyle = UITableViewCell.SelectionStyle.none
             
             cell.cntView.layer.addShadow(opacity: 0.6, radius: 2.5, UIColor.lightGray)
             cell.cntView.layer.roundCorners(radius: 8)
             
             let minusTapGesture = UITapGestureRecognizer()
             minusTapGesture.addTarget(self, action: #selector(self.minusTapped(sender:)))
             cell.minusImgView.isUserInteractionEnabled = true
             cell.minusImgView.tag = indexPath.row
             cell.minusImgView.addGestureRecognizer(minusTapGesture)
             
             let plusTapGesture = UITapGestureRecognizer()
             plusTapGesture.addTarget(self, action: #selector(self.plusTapped(sender:)))
             cell.plusImgView.isUserInteractionEnabled = true
             cell.plusImgView.tag = indexPath.row
             cell.plusImgView.addGestureRecognizer(plusTapGesture)
             
             GeneralFunctions.setImgTintColor(imgView: cell.plusImgView, color: SColors.Theme)
             GeneralFunctions.setImgTintColor(imgView: cell.minusImgView, color: SColors.Theme)
             GeneralFunctions.setImgTintColor(imgView: cell.editImgView, color: SColors.Theme)
             
             cell.editLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CUSTOMIZE").uppercased()
            // cell.editLbl.textColor = SColors.Theme
             
             let editTapGesture = UITapGestureRecognizer()
             editTapGesture.addTarget(self, action: #selector(self.editTapped(sender:)))
             cell.editLbl.tag = indexPath.row
             cell.editLbl.isUserInteractionEnabled = true
             cell.editLbl.addGestureRecognizer(editTapGesture)
            
             let item = self.foodItmData[indexPath.row] as! NSDictionary
             let itemData = item.dictOf("ItemData")
             cell.foodItemName.text = itemData.get("vItemType")
             
             cell.foodItemPriceLbl.text = itemData.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: item.get("itemAmount"))))
             
             
             
             cell.itemCountLbl.text =  Configurations.convertNumToAppLocal(numStr: item.get("itemCount"))
             cell.foodItemPriceLbl.textColor = SColors.Theme
             
             let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
             let selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
             let selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
             
             
             if itemData.get("eFoodType") == "Veg"
             {
                 self.addItemTypeViewWidth.constant = 15
                 cell.itemTypeImgViewWidth.constant = 16
                 cell.itemTypeImgView.isHidden = false
                 self.addItemVegNonVegImgview.isHidden = false
                 cell.itemTypeImgView.image = UIImage(named: "ic_veg")
                 self.addItemVegNonVegImgview.image = UIImage(named: "ic_veg")
             }else if itemData.get("eFoodType") == "NonVeg"
             {
                 self.addItemTypeViewWidth.constant = 15
                 cell.itemTypeImgViewWidth.constant = 16
                 cell.itemTypeImgView.isHidden = false
                 self.addItemVegNonVegImgview.isHidden = false
                 cell.itemTypeImgView.image = UIImage(named: "ic_nonVeg")
                 self.addItemVegNonVegImgview.image = UIImage(named: "ic_nonVeg")
             }else{
                 self.addItemTypeViewWidth.constant = 0
                 cell.itemTypeImgViewWidth.constant = 0
                 cell.itemTypeImgView.isHidden = true
                 self.addItemVegNonVegImgview.isHidden = true
             }
             
             cell.optionsLbl.text = ""
             for i in 0..<selectedOptionsArray.count
             {
                 if Int(item.get("selectedOptionIndex")) == i
                 {
                     cell.optionsLbl.text = selectedOptionsArray[i].get("vOptionName")
                 }
             }
             
             let toppingSelArray = item.arrOf("selectedToppingIndexes") as! [Bool]
             for i in 0..<toppingSelArray.count
             {
                 if toppingSelArray[i] == true
                 {
                     if cell.optionsLbl.text == ""{
                         cell.optionsLbl.text = selectedToppingArray[i].get("vOptionName")
                     }else
                     {
                         cell.optionsLbl.text =  cell.optionsLbl.text! + ", " + selectedToppingArray[i].get("vOptionName")
                     }
                     
                 }
             }
             
             
             if selectedOptionsArray.count == 0 && selectedToppingArray.count == 0
             {
                 cell.editLbl.isHidden = true
                 cell.editImgView.isHidden = true
                 
             }else{
                 
                 cell.editImgView.isHidden = false
                 cell.editLbl.isHidden = false
                 
             }
             
             if(cell.optionsLbl.text != "" && cell.editLbl.isHidden == false){
                 heightForContainer.remove(at: indexPath.row)
                 heightForContainer.insert(120 + cell.optionsLbl.text!.height(withConstrainedWidth: Application.screenSize.width - 60, font: UIFont.init(name: Fonts().light, size: 13)!), at: indexPath.row)
             }else if(cell.editLbl.isHidden == false){
                 heightForContainer.remove(at: indexPath.row)
                 heightForContainer.insert(120, at: indexPath.row)
             }else{
                 heightForContainer.remove(at: indexPath.row)
                 heightForContainer.insert(80, at: indexPath.row)
             }
             
             if Configurations.isRTLMode() == true{
                 
                 cell.foodItemName.textAlignment = .right
                 cell.optionsLbl.textAlignment = .right
              
             }else{
                 
                 cell.foodItemName.textAlignment = .left
                 cell.optionsLbl.textAlignment = .left
             }
             return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if(indexPath.row < heightForContainer.count){
            return heightForContainer[indexPath.row]
        }else{
            
            heightForContainer.append(120)
            return 120
        }
        
    }
    
    func addItemLocally()
    {
        let item = self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary
        
        let finalAmount = self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)
        
        var sameObjFound = false
        
        
        let newItem = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
        for i in 0..<self.foodItmData.count
        {
            let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray] as [String : Any])
            let oldDic = (self.foodItmData[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
            
            let newCount:Int = 1
            var count:Int = Int(oldDic.get("itemCount"))!
            var amn:Double = Double(oldDic.get("itemAmount"))!
            oldDic.removeObject(forKey: "itemAmount")
            oldDic.removeObject(forKey: "itemCount")
            if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
            {
                sameObjFound = true
                count = count + newCount
                amn = (amn + Double(finalAmount)!).roundTo(places: 2)
                
                let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                self.foodItmData.replaceObject(at: i, with: newDic)
                
                break
            }
        }
        
        if sameObjFound == false
        {
            let dic = NSMutableDictionary.init(dictionary: ["iCompanyId":item.get("iCompanyId"), "vCompany": item.get("vCompany"), "ItemData":item.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":"1", "itemAmount": finalAmount] as [String : Any])
            self.foodItmData.add(dic)
            
        }
        GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
        
    }
    
    @objc func repeatItem()
    {
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes"{
        let item = self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary
        let tempSelectedOptions = item.arrOf("selectedOptionIndex") as! [Int]
        let toppingSelArray = item.arrOf("selectedToppingIndexes") as! [Int]
        let oldDic = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
        
        var count:Int = Int(oldDic.get("itemCount"))!
        var amn:Double = Double(oldDic.get("itemAmount"))!
        
        let newAmount = amn / Double(count)
        count = count + 1
        amn = (amn + newAmount).roundTo(places: 2)
        let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":item.get("iCompanyId"), "vCompany": item.get("vCompany"), "ItemData":item.dictOf("ItemData"),"selectedOptionIndex":tempSelectedOptions,"selectedToppingIndexes":toppingSelArray, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
        
        self.foodItmData.replaceObject(at: self.selcetedEidtViewIndex, with: newDic)
        GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
        
        self.editScrollBGView.isHidden = true
        self.addItemView.isHidden = true
        self.addItemViewHeight.constant = 0
        
        
        if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
            
            foodItmData.removeAllObjects()
            foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
            
        }
        
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: foodItmData.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
        self.updateFinalTotal()
        return
        }else{
            
                let item = self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary
                
                let oldDic = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                
                var count:Int = Int(oldDic.get("itemCount"))!
                var amn:Double = Double(oldDic.get("itemAmount"))!
                
                let newAmount = amn / Double(count)
                count = count + 1
                amn = (amn + newAmount).roundTo(places: 2)
                let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":item.get("iCompanyId"), "vCompany": item.get("vCompany"), "ItemData":item.dictOf("ItemData"),"selectedOptionIndex":item.get("selectedOptionIndex"),"selectedToppingIndexes":item.arrOf("selectedToppingIndexes"), "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                self.foodItmData.replaceObject(at: self.selcetedEidtViewIndex, with: newDic)
                GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
                
                self.editScrollBGView.isHidden = true
                self.addItemView.isHidden = true
                self.addItemViewHeight.constant = 0
                
                
                if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                    
                    foodItmData.removeAllObjects()
                    foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
                    
                }
                
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: foodItmData.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
                self.updateFinalTotal()
                return
        }
    }
    
    func compareDic <K, V>(left: [K:V?], right: [K:V?]) -> Bool {
        guard let left = left as? [K: V], let right = right as? [K: V] else { return false }
        return NSDictionary(dictionary: left).isEqual(to: right)
    }
    
//    func myBtnTapped(sender: MyButton) {
//
//        var tempIndexOpetion = selectionIndexOfOpetion
//        self.selectionIndexOfOpetion.removeAll()
//        for i in 0..<tempIndexOpetion.count
//        {
//
//               var temp = tempIndexOpetion[i]
//               var tempString = String(temp)
//               tempString.removeLast()
//               temp = Int(tempString) ?? 00
//               selectionIndexOfOpetion.append(temp)
//
//        }
//       if sender.buttonTitle.uppercased() == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART").uppercased()
//       {
//             if self.addItemMode == false{
//
//                if self.selcetedEidtViewIndex >= 0
//                {
//                    let finalAmount = self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)
//
//                    // NOW, Check if cuurent object data match with other object data(toppings & options) or not. If match, merge two opbject.
//                    var sameObjFound = false
//
//
//                    let newItem = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
//                    for i in 0..<self.foodItmData.count
//                    {
//                        let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray] as [String : Any])
//                        let oldDic = (self.foodItmData[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
//
//                        let newCount:Int = Int(newItem.get("itemCount"))!
//                        var count:Int = Int(oldDic.get("itemCount"))!
//                        var amn:Double = Double(oldDic.get("itemAmount"))!
//                        oldDic.removeObject(forKey: "itemAmount")
//                        oldDic.removeObject(forKey: "itemCount")
//                        if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
//                        {
//                            sameObjFound = true
//                            if self.selcetedEidtViewIndex != i
//                            {
//                                count = count + newCount
//                                amn = (amn + Double(finalAmount)!).roundTo(places: 2)
//
//                                let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
//                                self.foodItmData.replaceObject(at: i, with: newDic)
//                                self.foodItmData.removeObject(at: self.selcetedEidtViewIndex)
//                            }
//
//                            break
//                        }
//                    }
//
//                    if sameObjFound == false
//                    {
//                        let item = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
//
//                        item["selectedOptionIndex"] = String(self.optionSelctionIndex)
//                        item["selectedToppingIndexes"] = self.toppingSelectionArray
//                        item["itemAmount"] = self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)
//
//                        // REPLASE CURRENT OBJECTDATA
//                        self.foodItmData.replaceObject(at: self.selcetedEidtViewIndex, with: item)
//                    }
//
//                    GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
//                    if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
//
//                        foodItmData.removeAllObjects()
//                        foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
//
//                    }
//                    self.editCancelTapped()
//                    let currentOffset = self.tableView.contentOffset
//                    self.tableView.reloadData()
//                    self.tableView.setContentOffset(currentOffset, animated: false)
//                    self.updateFinalTotal()
//                }
//            }else{
//
//                if self.optionSelctionIndex < 0 && self.selectedOptionsArray.count > 0
//                {
//                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONS_REQUIRED"))
//                    return
//                }else
//                {
//                    self.addItemLocally()
//                    self.editCancelTapped()
//
//                    if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
//
//                        foodItmData.removeAllObjects()
//                        foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
//
//                    }
//
//                   // self.adjustHeight()
//                    self.tableView.reloadData()
//                    self.tableView.scrollToRow(at: IndexPath(row: foodItmData.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
//                    self.updateFinalTotal()
//
//                    self.addItemMode = false
//                }
//            }
//
//       }else if sender == self.addItemChooseBtn
//       {
//
//            self.addItemMode = true
//            self.addItemView.isHidden = true
//            self.addItemViewHeight.constant = 0
//
//            self.editScrollBGView.isHidden = false
//            self.editView.isHidden = false
//
//            let item = self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary
//
//
//            createViewForEdit(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
//
//
//            self.view.layoutIfNeeded()
//
//            self.editViewheight.constant = 380
//
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//            }, completion:{ _ in
//
//            })
//
//       }else if sender == self.addItemAplSameBtn
//       {
//           self.repeatItem()
//       }else
//       {
//
//           let dic = GeneralFunctions.getValue(key: "GeneralCartInfo") as! NSDictionary
//           let minOrder = GeneralFunctions.parseDouble(origValue: 0, data: dic.get("min_order"))
//           minOrderPass = minOrder
//           if self.foodItmData.count > 0
//           {
//                if finalAmount >= minOrder
//                {
//                    self.checkPrescription()
////                    let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
////                    checkOutUV.isFromMenu = self.isFromMenu
////                    self.push(uv: checkOutUV)
//                    return
//                }else
//                {
//                    let item = self.foodItmData[0] as! NSDictionary
//                    let itemData = item.dictOf("ItemData")
//
//                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINIMUM_ORDER_NOTE") + " " + itemData.get("currencySymbol") + String(minOrder), uv: self)
//                }
//           }
//       }
//
//    }
    func myBtnTapped(sender: MyButton) {
        
//        var tempIndexOpetion = selectionIndexOfOpetion
//        self.selectionIndexOfOpetion.removeAll()
//        for i in 0..<tempIndexOpetion.count
//        {
//
//               var temp = tempIndexOpetion[i]
//               var tempString = String(temp)
//               tempString.removeLast()
//               temp = Int(tempString) ?? 00
//               selectionIndexOfOpetion.append(temp)
//
//        }
       if sender.buttonTitle.uppercased() == self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART").uppercased()
       {
           let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
           if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
             //if self.addItemMode == false{
               
                if self.selcetedEidtViewIndex >= 0
                {
                    let finalAmount = self.finalEditedItemTotalNew(index: self.selcetedEidtViewIndex)
                   
                    // NOW, Check if cuurent object data match with other object data(toppings & options) or not. If match, merge two opbject.
                    var sameObjFound = false
                    
                    
                    let newItem = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                    for i in 0..<self.foodItmData.count
                    {
                        let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":selectionIndexOfOpetion,"selectedToppingIndexes":selectionIndexToppings] as [String : Any])
                        let oldDic = (self.foodItmData[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                        
                        let newCount:Int = Int(newItem.get("itemCount"))!
                        var count:Int = Int(oldDic.get("itemCount"))!
                        var amn:Double = Double(oldDic.get("itemAmount"))!
                        oldDic.removeObject(forKey: "itemAmount")
                        oldDic.removeObject(forKey: "itemCount")
                        if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
                        {
                            sameObjFound = true
                            if self.selcetedEidtViewIndex != i
                            {
                                count = count + newCount
                                amn = (amn + Double(finalAmount)!).roundTo(places: 2)
                                
                                let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":selectionIndexOfOpetion,"selectedToppingIndexes":selectionIndexToppings, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                                self.foodItmData.replaceObject(at: i, with: newDic)
                                self.foodItmData.removeObject(at: self.selcetedEidtViewIndex)
                            }
                           
                            break
                        }
                    }
                   
                    if sameObjFound == false
                    {
                        let item = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                        
                        item["selectedOptionIndex"] = selectionIndexOfOpetion//String(self.optionSelctionIndex)
                        item["selectedToppingIndexes"] = selectionIndexToppings//self.toppingSelectionArray
                        item["itemAmount"] = self.finalEditedItemTotalNew(index: self.selcetedEidtViewIndex)
                        
                        // REPLASE CURRENT OBJECTDATA
                        self.foodItmData.replaceObject(at: self.selcetedEidtViewIndex, with: item)
                    }
                    
                    GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
                    if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                        
                        foodItmData.removeAllObjects()
                        foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
                        
                    }
                    self.editCancelTapped()
                    let currentOffset = self.tableView.contentOffset
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(currentOffset, animated: false)
                    self.updateFinalTotal()
                }

       }else {
        if self.selcetedEidtViewIndex >= 0
        {
            let finalAmount = self.finalEditedItemTotal(index: self.selcetedEidtViewIndex) //self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)
           
            // NOW, Check if cuurent object data match with other object data(toppings & options) or not. If match, merge two opbject.
            var sameObjFound = false
            
            
            let newItem = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
            for i in 0..<self.foodItmData.count
            {
                let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray] as [String : Any])
                let oldDic = (self.foodItmData[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                
                let newCount:Int = Int(newItem.get("itemCount"))!
                var count:Int = Int(oldDic.get("itemCount"))!
                var amn:Double = Double(oldDic.get("itemAmount"))!
                oldDic.removeObject(forKey: "itemAmount")
                oldDic.removeObject(forKey: "itemCount")
                if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
                {
                    sameObjFound = true
                    if self.selcetedEidtViewIndex != i
                    {
                        count = count + newCount
                        amn = (amn + Double(finalAmount)!).roundTo(places: 2)
                        
                        let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":newItem.get("iCompanyId"), "vCompany": newItem.get("vCompany"), "ItemData":newItem.dictOf("ItemData"),"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                        self.foodItmData.replaceObject(at: i, with: newDic)
                        self.foodItmData.removeObject(at: self.selcetedEidtViewIndex)
                    }
                   
                    break
                }
            }
           
            if sameObjFound == false
            {
                let item = (self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                
                item["selectedOptionIndex"] = String(self.optionSelctionIndex)
                item["selectedToppingIndexes"] = self.toppingSelectionArray
                item["itemAmount"] = self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)//self.finalEditedItemTotal(index: self.selcetedEidtViewIndex)
                
                // REPLASE CURRENT OBJECTDATA
                self.foodItmData.replaceObject(at: self.selcetedEidtViewIndex, with: item)
            }
            
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.foodItmData as AnyObject)
            if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
                
                foodItmData.removeAllObjects()
                foodItmData = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
                
            }
            self.editCancelTapped()
            let currentOffset = self.tableView.contentOffset
            self.tableView.reloadData()
            self.tableView.setContentOffset(currentOffset, animated: false)
            self.updateFinalTotal()
        }
        }
       }else if sender == self.addItemChooseBtn
       {
        
            self.addItemMode = true
            self.addItemView.isHidden = true
            self.addItemViewHeight.constant = 0
        
            self.editScrollBGView.isHidden = false
            self.editView.isHidden = false
        
            let item = self.foodItmData[self.selcetedEidtViewIndex] as! NSDictionary
           let itemData = item.dictOf("ItemData")
           let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
           self.categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
         let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
            createViewForEditNew(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
        }else{
            createViewForEdit(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
            //createViewForEditAdon(optionsArray: self.selectedOptionsArray, toppingArray: self.selectedToppingArray, finalData:item)
        }
        
            self.view.layoutIfNeeded()
        
            self.editViewheight.constant = 380
        
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion:{ _ in
                
            })
        
       }else if sender == self.addItemAplSameBtn
       {
           self.repeatItem()
       }else
       {
        let dic = GeneralFunctions.getValue(key: "GeneralCartInfo") as! NSDictionary
                   let minOrder = GeneralFunctions.parseDouble(origValue: 0, data: dic.get("min_order"))
                   minOrderPass = minOrder
                   if self.foodItmData.count > 0
                   {
                        if finalAmount >= minOrder
                        {
                            if(GeneralFunctions.getMemberd() != "") {
                                self.checkPrescription()
                            } else {
                                let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
                                checkOutUV.isFromMenu = self.isFromMenu
                                checkOutUV.minOrderPass =  self.minOrderPass
                                self.push(uv: checkOutUV)
                            }
                            ////                    let checkOutUV = GeneralFunctions.instantiateViewController(pageName: "CheckOutUV") as! CheckOutUV
        ////                    checkOutUV.isFromMenu = self.isFromMenu
        ////                    self.push(uv: checkOutUV)
                            return
                        }else
                        {
                            let item = self.foodItmData[0] as! NSDictionary
                           let itemData = item.dictOf("ItemData")
        
                            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MINIMUM_ORDER_NOTE") + " " + itemData.get("currencySymbol") + String(minOrder), uv: self)
                        }
                   }
          
       }
        
    }
    // multiple Topping and addon related changes new view
    func createViewForEditNew(optionsArray:[NSDictionary], toppingArray:[NSDictionary], finalData:NSDictionary)
    {
        
        self.cartOptinViewsArray.removeAll()
        self.cartToppingViewsArrayNew.removeAll()
        selectionIndexOfOpetion.removeAll()
        selectionIndexToppings.removeAll()
        positionYArray.removeAll()
        cartOptinViewsArrayNew.removeAll()
        countOFTap = 0
        maxY = 0
        self.optionsArrayGlobal.removeAll()
        self.toppingArray.removeAll()
        self.horizontalScrollView.setContentOffset(CGPoint(x: CGFloat(0), y: 0), animated: true)
       
        var temptagArray = [Int] ()
        for view in self.editContentView.subviews
        {
            view.removeFromSuperview()
        }
        
        let itemData = finalData.dictOf("ItemData")
        self.editComapnyNameLbl.text = itemData.get("vItemType")
        self.selectionIndexOfOpetion = finalData.arrOf("selectedOptionIndex") as! [Int]
        self.selectionIndexToppings  = finalData.arrOf("selectedToppingIndexes") as! [Int]
        
        
        var XPosition = 0
         var yPosition = 10
        for j in 0..<self.categoryArray.count {
       yPosition = 10
        if j == 0 {
            XPosition = 0
        }else{
            XPosition =  Int(Application.screenSize.width) * j
        }
        self.editContentViewWidth.constant = CGFloat(self.categoryArray.count) * Application.screenSize.width
        self.optionsArray = categoryArray[j].arrOf("options") as! [NSDictionary]
        self.toppingArray = categoryArray[j].arrOf("addon") as! [NSDictionary]
        self.lblCategory.textColor = SColors.Theme
        self.lblCategory.text = self.categoryArray[self.countOFTap].get("vCatName")
        self.optionsArrayGlobal += self.optionsArray
        self.toppingArrayGlobal += self.toppingArray
        
            for i in 0..<self.optionsArray.count
        {
            if i == 0
            {
              
                let optionTitleLbl = UILabel(frame: CGRect(x: XPosition + 10, y: yPosition + 10 , width: Int(self.view.frame.size.width - 20), height: 30))
                optionTitleLbl.textColor = SColors.blackColor
                optionTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 16)
                optionTitleLbl.numberOfLines = 2
                optionTitleLbl.text = categoryArray[j].get("tOptionTitle")
                var hightOfOpetion = optionTitleLbl.text?.height(withConstrainedWidth: (Application.screenSize.width - 20), font: UIFont.init(name: Fonts().semibold, size: 16)!)
                if optionTitleLbl.text == ""{
                optionTitleLbl.frame.size.height = 0
                yPosition = yPosition + 10
                }else{
                optionTitleLbl.frame.size.height = hightOfOpetion ?? 30
                    yPosition = yPosition + Int(hightOfOpetion ?? 30) + 10
                }
               // optionTitleLbl.autoresizingMask = [.flexibleWidth]
               // optionTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_OPTIONS")
                self.editContentView.addSubview(optionTitleLbl)
                
              //  yPosition = yPosition + 30
                
            }
            
            
            let optionsView = CartOptionView(frame: CGRect(x:XPosition, y: yPosition + (i * 50)  , width: Int(self.view.frame.size.width), height: 50))

            //optionsView.autoresizingMask = [.flexibleWidth]
            optionsView.tag =  Int(self.optionsArray[i].get("iOptionId")) ?? 00
            GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
                optionsView.bottomBorderLine.isHidden = true
           // selected opetion display if id contains
            if  self.selectionIndexOfOpetion.contains(optionsView.tag){
                
                    optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                    GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
                
                temptagArray.append(optionsView.tag)
                
            }
            

            
            optionsView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: (self.optionsArray[i] ).get("fUserPriceWithSymbol"))
            optionsView.titleLbl.text = (self.optionsArray[i] ).get("vOptionName")
            optionsView.selctionImgView.tag = j
            self.editContentView.addSubview(optionsView)
            self.cartOptinViewsArrayNew.append(optionsView)
            
            let optionTapGesture = UITapGestureRecognizer()
            optionTapGesture.addTarget(self, action: #selector(self.optionTapped(sender:)))
            optionsView.isUserInteractionEnabled = true
            optionsView.addGestureRecognizer(optionTapGesture)
            
            if i == self.optionsArray.count - 1
            {
                yPosition = yPosition + (i * 50) + 50
            }
            
            if Configurations.isRTLMode() == true{
                optionsView.priceLbl.textAlignment = .left
            }else{
                optionsView.priceLbl.textAlignment = .right
            }
        }
        
            for i in 0..<self.toppingArray.count
        {
            if i == 0
            {
                
                let toppingTitleLbl = UILabel(frame: CGRect(x: XPosition + 10, y: yPosition + 10 , width: Int(self.view.frame.size.width - 20), height: 30))
                toppingTitleLbl.textColor = SColors.blackColor
                toppingTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 16)
                //toppingTitleLbl.autoresizingMask = [.flexibleWidth]
                //toppingTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TOPPING")
                toppingTitleLbl.text = self.categoryArray[j].get("tAddonTitle")
                var hightOfTopping = toppingTitleLbl.text?.height(withConstrainedWidth: (Application.screenSize.width - 20), font: UIFont.init(name: Fonts().semibold, size: 16)!)
                
                if toppingTitleLbl.text == "" {
                    toppingTitleLbl.frame.size.height = 0
                    yPosition = yPosition + 10
                }else {
                    toppingTitleLbl.frame.size.height = hightOfTopping ?? 30
                    yPosition = yPosition + Int(hightOfTopping ?? 30) + 10
                }
                self.editContentView.addSubview(toppingTitleLbl)
                
                //yPosition = yPosition + 40
            }
            
           
            let toppingView = CartToppingView(frame: CGRect(x:XPosition, y: yPosition + (i * 50) , width: Int(self.view.frame.size.width), height: 50))
            
            //toppingView.tag = i
//            if j == 0 && i == 0 {
//                toppingTag = i
//            }else{
//                toppingTag =  toppingTag + 1
//            }
            toppingView.tag = Int(self.toppingArray[i].get("iOptionId")) ?? 00//toppingTag
           // toppingView.autoresizingMask = [.flexibleWidth]
            toppingView.selctionImgView.boxType = .square
            toppingView.selctionImgView.offAnimationType = .bounce
            toppingView.selctionImgView.onAnimationType = .bounce
            toppingView.selctionImgView.onCheckColor = SColors.ThemeTxt
            toppingView.selctionImgView.onFillColor = SColors.Theme
            toppingView.selctionImgView.onTintColor = SColors.Theme
            toppingView.selctionImgView.tintColor = SColors.Theme
            toppingView.selctionImgView.isUserInteractionEnabled = false
            toppingView.bottomBorderView.isHidden = true
            toppingView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: (self.toppingArray[i]).get("fUserPriceWithSymbol"))
            toppingView.titleLbl.text = (self.toppingArray[i]).get("vOptionName")
            

            if self.selectionIndexToppings.contains(toppingView.tag){
                toppingView.selctionImgView.on = true
            }else{
               
                toppingView.selctionImgView.on = false
            }
            
            self.editContentView.addSubview(toppingView)
            self.cartToppingViewsArrayNew.append(toppingView)
            
            let toppingTapGesture = UITapGestureRecognizer()
            toppingTapGesture.addTarget(self, action: #selector(self.toppingTapped(sender:)))
            toppingView.isUserInteractionEnabled = true
            toppingView.addGestureRecognizer(toppingTapGesture)
            
            if i == self.toppingArray.count - 1
            {
                yPosition = yPosition + (i * 50) + 50
            }
            
            if Configurations.isRTLMode() == true{
                toppingView.priceLbl.textAlignment = .left
            }else{
                toppingView.priceLbl.textAlignment = .right
            }
            if maxY < yPosition {
                maxY = yPosition
            }
        }
            positionYArray.append(CGFloat(yPosition))
        }
        selectionIndexOfOpetion = temptagArray
        self.editCancelLbl.text =  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT").uppercased()
        self.editCancelLbl.textColor = UIColor(hex: 0x373737)
        self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART").uppercased())
        
        
        self.view.layoutIfNeeded()
        self.horizontalScrollView.isScrollEnabled = false
        self.editContentViewHeight.constant = CGFloat(self.positionYArray[0])//CGFloat(maxY)
        self.horizontalScrollViewHight.constant = CGFloat(self.positionYArray[self.countOFTap]) //CGFloat(maxY)
        self.shadowViewHight.constant = CGFloat(self.positionYArray[self.countOFTap])//CGFloat(maxY)
        self.editScrollHight.constant = CGFloat(self.positionYArray[self.countOFTap])//CGFloat(maxY)
        let hight = self.positionYArray[self.countOFTap] * 1.7
        if hight <= 300 {
            self.editScrollView.isScrollEnabled = false
        }else{
            self.editScrollView.isScrollEnabled = true
        }
        self.editScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: hight)

        if self.categoryArray.count > 1 {
            self.viewNextPrivious.isHidden = false
            self.viewCurrenIndex = 0
            self.setCollectionView()
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.viewNextPriviousHight.constant = 90
        }else{
            
            self.viewCurrenIndex = 0
            self.viewNextPrivious.isHidden = false
            self.collectionView.isHidden = true
            self.viewNextPriviousHight.constant = 0
            if self.categoryArray.count == 1 {
                self.collectionView.isHidden = true
                self.sepratorView.isHidden = true
                self.viewNextPriviousHight.constant = 50
                self.collectionViewHight.constant = 0
            }
        }
        self.horizontalScrollView.setContentOffset(CGPoint(x: CGFloat(0), y: 0), animated: true)
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            
        })
        
    }
    func addViewSetUpNew(index:Int)
    {
        self.selectedToppingArray.removeAll() // topping name array
        self.selectedOptionsArray.removeAll() // options name array
        self.toppingSelectionArray.removeAll()  // True, false array for topping
        
        self.editScrollBGView.isHidden = false
        
        bgTapGesture.addTarget(self, action: #selector(self.closeAddViewTapped))
        self.editScrollBGView.isUserInteractionEnabled = true
        self.editScrollBGView.addGestureRecognizer(bgTapGesture)
        
        self.addItemView.isHidden = false
        self.addItemCuttxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PREVIOUS_CUST_TITLE")
        
        let item = self.foodItmData[index] as! NSDictionary
        let itemData = item.dictOf("ItemData")
        let menuToppOptionsArray = itemData.dictOf("MenuItemOptionToppingArr")
        var categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
       
        
        self.selectedOptionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        self.selectedToppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
        var optionsArray = [NSDictionary]()
         var toppingArray = [NSDictionary]()
        var optionsArrayGlobal = [NSDictionary]()
        var toppingArrayGlobal = [NSDictionary]()
        
        for j in 0...categoryArray.count - 1 {
        optionsArray = categoryArray[j].arrOf("options") as! [NSDictionary]
        toppingArray = categoryArray[j].arrOf("addon") as! [NSDictionary]
        optionsArrayGlobal += optionsArray
        toppingArrayGlobal += toppingArray
        }
       
        if itemData.get("eFoodType") == "Veg"
        {
            self.addItemTypeViewWidth.constant = 15
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_veg")
        }else if itemData.get("eFoodType") == "NonVeg"
        {
            self.addItemTypeViewWidth.constant = 15
            self.addItemVegNonVegImgview.image = UIImage(named: "ic_nonVeg")
        }else
        {
            self.addItemTypeViewWidth.constant = 0
             self.addItemVegNonVegImgview.isHidden = true
        }
        
        self.addItemCutValLbl.text = ""
        
        var valueExists = false
        let tempSelectedOptions = item.arrOf("selectedOptionIndex") as! [Int]
        if tempSelectedOptions.count != 0 {
            valueExists = true
            for i in 0...optionsArrayGlobal.count - 1 {
                let tempID = Int(optionsArrayGlobal[i].get("iOptionId")) ?? 00
                if tempSelectedOptions.contains(tempID){
                    if self.addItemCutValLbl.text == ""{
                        self.addItemCutValLbl.text = optionsArrayGlobal[i].get("vOptionName")
                    }else
                    {
                        self.addItemCutValLbl.text =  self.addItemCutValLbl.text! + ", " + optionsArrayGlobal[i].get("vOptionName")
                    }
                }
                
            }
        }
       
        let toppingSelArray = item.arrOf("selectedToppingIndexes") as! [Int]
                
        if toppingSelArray.count != 0 {
            valueExists = true
            for i in 0...toppingArrayGlobal.count - 1 {
                let tempID = Int(toppingArrayGlobal[i].get("iOptionId")) ?? 00
                if toppingSelArray.contains(tempID){
                    if self.addItemCutValLbl.text == ""{
                        self.addItemCutValLbl.text = toppingArrayGlobal[i].get("vOptionName")
                    }else
                    {
                        self.addItemCutValLbl.text =  self.addItemCutValLbl.text! + ", " + toppingArrayGlobal[i].get("vOptionName")
                    }
                }
                
            }
        }

        
        if valueExists == false
        {
            self.addItemCutValLbl.text = "--"
        }
        
        var itemAmount:Double!
        if GeneralFunctions.parseDouble(origValue: 0.0, data: itemData.get("fOfferAmt")) > 0.0
        {
            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fDiscountPrice"))
        }else{

            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fPrice"))
        }
        
       // itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: itemData.get("fPrice"))
        
        self.addItemHeaderLbl.text = itemData.get("vItemType")
        self.addItemPriceLbl.text = itemData.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(itemAmount))
        
        if Configurations.isRTLMode() == true{
            self.addItemPriceLbl.textAlignment = .right
            self.addItemHeaderLbl.textAlignment = .right
        }else{
            self.addItemPriceLbl.textAlignment = .left
            self.addItemHeaderLbl.textAlignment = .left
        }
        
        self.view.layoutIfNeeded()
        self.addItemViewHeight.constant = 250
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            
        })
    }
    func finalEditedItemTotalNew(index:Int) -> String
    {
        let itemData = self.foodItmData[index] as! NSDictionary
        let dataDic = itemData.dictOf("ItemData")
       
        var itemCountstr = itemData.get("itemCount")
        var itemCount = 1
        itemCount = Int(itemCountstr) ?? 00
        if self.addItemMode == true{
            //itemCount = "1"
            itemCount = 1
        }
        
        var itemAmount = 0.0
        if GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fOfferAmt")) > 0.0
        {
            itemAmount = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fDiscountPrice"))

        }else{

            itemAmount = GeneralFunctions.parseDouble(origValue: 0.0, data: dataDic.get("fPrice"))

        }
        
        let sepPrice = GeneralFunctions.getValue(key: "ispriceshow")
        if(sepPrice?.uppercased == "SEPARATE"){
            if(self.optionSelctionIndex >= 0){
                itemAmount = 0
            }
        }
        
        var optionsArrayGlobal = [NSDictionary] ()
        var toppingArrayGlobal = [NSDictionary] ()
        for v in 0..<self.categoryArray.count {
        
         
         let optionsArray = categoryArray[v].arrOf("options") as! [NSDictionary]
         let toppingArray = categoryArray[v].arrOf("addon") as! [NSDictionary]
         optionsArrayGlobal += optionsArray
         toppingArrayGlobal += toppingArray

        }
       // getting final amount of slected opetion
        var totalAmount = Double(itemAmount) * Double(itemCount)
        for i in 0..<optionsArrayGlobal.count
        {
           let tempID = Int(optionsArrayGlobal[i].get("iOptionId")) ?? 00
            // match opetion id and selection otetion id
           if self.selectionIndexOfOpetion.contains(tempID) {
               totalAmount = totalAmount + (Double(optionsArrayGlobal[i].get("fUserPrice"))! * Double(itemCount))
           }

        }
        // getting final amount of slected topping
        for i in 0..<toppingArrayGlobal.count
        {
           let tempID = Int(toppingArrayGlobal[i].get("iOptionId")) ?? 00
            
           if self.selectionIndexToppings.contains(tempID) {
            // match topping id and selection topping id
            
               totalAmount = totalAmount + (Double(toppingArrayGlobal[i].get("fUserPrice"))! * Double(itemCount))
           }

        }
        

        
        return String(totalAmount.roundTo(places: 2))
        
    }
    // steeper collectionview hande from here
    func setCollectionView(){

        if self.collectionView != nil {
            if self.categoryArray.count > 1 {
        self.horizontalScrollView.delegate = self
        self.collectionView.register(UINib(nibName: "SteeperCVCell", bundle: nil), forCellWithReuseIdentifier: "SteeperCVCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
                if self.categoryArray.count <= 4 {
                    self.collectionView.isScrollEnabled = false
                }else{
                    self.collectionView.isScrollEnabled = true
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SteeperCVCell", for: indexPath) as! SteeperCVCell
        if indexPath.item == self.categoryArray.count - 1 {
            cell.jointView.isHidden = true
        }else{
            cell.jointView.isHidden = false
        }
        //cell.countLbl.text = String(indexPath.item + 1)
        cell.countLbl.text = Configurations.convertNumToAppLocal(numStr: String(indexPath.item + 1))
        cell.countLbl.textColor = SColors.ThemeTxt
        cell.statusView.layer.masksToBounds = true
        cell.statusView.layer.cornerRadius =  cell.statusView.bounds.width / 2
        cell.statusView.layer.borderColor = SColors.Theme.cgColor
        cell.statusView.tag = indexPath.item
        
        if indexPath.item <=  self.viewCurrenIndex{
            cell.statusView.backgroundColor = SColors.Theme
        }else{
            cell.statusView.backgroundColor = UIColor.lightGray
        }
        if indexPath.item <  self.viewCurrenIndex{
            cell.jointView.backgroundColor = SColors.Theme
            cell.stepImageView.isHidden = false
            cell.countLbl.isHidden = true
        }else{
            cell.jointView.backgroundColor = UIColor.lightGray
            cell.stepImageView.isHidden = true
            cell.countLbl.isHidden = false
        }
        cell.statusView.handleClick { (view) in
            print(view.tag)
            self.viewCurrenIndex = view.tag
            self.countOFTap = view.tag
            
            self.pressStepper()

            self.collectionView.reloadData()
        }
            return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.categoryArray.count
        
        }
   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
            var count = self.categoryArray.count - 1
            var widht = Int(self.collectionView.frame.size.width) / count - 30
            if count == 1 {
                widht = Int(self.collectionView.frame.size.width) - 50
            }else if count == 3{
                widht = Int(self.collectionView.frame.size.width) / count - 25
            }
            if widht <= 70 {
                widht = 75
            }
            return CGSize(width: widht , height: 50)
            //self.categoryArray.count - 1
        }
        //self.categoryArray.count - 1
    
    // view next privous handel from here
    func pressStepper(){
        self.horizontalScrollView.isScrollEnabled = true
        
        let tempX = Application.screenSize.width * CGFloat(self.countOFTap)
      
       self.editContentViewHeight.constant = CGFloat(self.positionYArray[self.countOFTap])
       self.horizontalScrollViewHight.constant =  CGFloat(self.positionYArray[self.countOFTap])
        self.shadowViewHight.constant = CGFloat(self.positionYArray[self.countOFTap])
        self.editScrollHight.constant = CGFloat(self.positionYArray[self.countOFTap])

        self.lblCategory.textColor = SColors.Theme
        self.lblCategory.text = self.categoryArray[self.countOFTap].get("vCatName")
       // self.editScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.positionYArray[self.countOFTap] + 510)
        let hight = self.positionYArray[self.countOFTap] * 1.7
        if hight <= 300 {
            self.editScrollView.isScrollEnabled = false
        }else{
            self.editScrollView.isScrollEnabled = true
        }
       // self.editScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: hight )
        self.editScrollView.contentSize = CGSize(width: 0, height: hight )
        self.horizontalScrollView.setContentOffset(CGPoint(x: CGFloat(tempX), y: 0), animated: true)
        
        

    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == self.horizontalScrollView {
        self.horizontalScrollView.isScrollEnabled = false
        }
    }
}
