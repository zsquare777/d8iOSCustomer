

import UIKit
import AdvancedPageControl
import AVKit
import SysBaseLib

class AddToCartUV: ParentViewUV, MyBtnClickDelegate,UIScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ParentViewUVDelegate,iCarouselDataSource, iCarouselDelegate, ExpandableLabelDelegate{
    
    
    
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var topHViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topNavViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainHeaderViewTop: NSLayoutConstraint!
    @IBOutlet weak var mainHeaderView: UIView!
    @IBOutlet weak var headerItemNameLbl: MarqueeLabel!
    @IBOutlet weak var headerItemPriceLbl: UILabel!
    @IBOutlet weak var headerItemStrikeOutLbl: UILabel!
    @IBOutlet weak var headerStrikeOutLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var plusImgView: UIImageView!
    @IBOutlet weak var minusImgview: UIImageView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var submitBtn: MyButton!
    var cntView:UIView!
    
    @IBOutlet weak var optionAndToppingView: UIView!
    @IBOutlet weak var itemTypeLbl: ExpandableLabel!
    @IBOutlet weak var itemTypeImgView: UIImageView!
    @IBOutlet weak var bottomTotalLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var addQuanView: UIView!
    @IBOutlet weak var scrollVieTop: NSLayoutConstraint!
    @IBOutlet weak var quanityLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var topHView: UIView!
    @IBOutlet weak var topHImgView: UIImageView!
    @IBOutlet weak var submitBtnHeight: NSLayoutConstraint!
    // topping and opetion related outlets
    @IBOutlet weak var optionToppingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var optionToppingView: UIView!
    @IBOutlet weak var mainHeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shadowTopingView: UIView!
    @IBOutlet weak var shadowViewHight: NSLayoutConstraint!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var horizontalScrollHight: NSLayoutConstraint!
    @IBOutlet weak var viewNextPriviousHight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHight: NSLayoutConstraint!
    @IBOutlet weak var opetionTopingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var opetionTopingViewHight: NSLayoutConstraint!
    @IBOutlet weak var viewNxtPrivious: UIView!
    @IBOutlet weak var labelCategory: MyLabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var prevImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionParentView: View!
    @IBOutlet weak var collectionParentViewHight: NSLayoutConstraint!
    @IBOutlet weak var shadowViewTop: NSLayoutConstraint!
    @IBOutlet weak var scrollTop: NSLayoutConstraint!
    @IBOutlet weak var lblPrevious: MyLabel!
    @IBOutlet weak var lblNext: MyLabel!
    
    @IBOutlet weak var lblSeprator: UILabel!
    
    @IBOutlet weak var imgSlide: iCarousel!
    
    @IBOutlet weak var pageController: AdvancedPageControlView!
    @IBOutlet weak var collectionViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var advancedPageControllerWidth: NSLayoutConstraint!
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    
   
    var foodItemDetails:NSDictionary!
    var toppingArray = [NSDictionary] ()
    var optionsArray = [NSDictionary] ()
    var optionsArrayGlobal = [NSDictionary] ()
    var toppingArrayGlobal = [NSDictionary] ()
    var categoryArray = [NSDictionary] ()
    var positionYArray = [CGFloat]()
    var toppingSelectionArray = [Bool] ()
    var selectionIndexOfOpetion = [Int] ()
    var selectionIndexOfTopping = [Int] ()
    var defalutIndexCheck = [Int] ()
    var arrayIndexCheck = [Int] ()
    var optionSelctionIndex = -1
    var cartOptinViewsArray = [CartOptionView] ()
    var cartToppingViewsArray = [CartToppingView] ()
    var bannersItemList = [NSDictionary] ()
    
    var optCheck = 0
    var itemCount = 1
    var itemAmount = 0.0
    var finalAmount = 0.0

    var companyId = ""
    var eAvialble = ""
    var timeSlot = ""
    var comapnyName = ""
    var minOrder = ""
    var vImage = ""
    var companyAddress = ""
    var countOFTap = 0
    var maxY = 0
    var cartItemsArray:NSMutableArray!
    var isRestaurantClose = false
    var viewRightIndex = -1
    var viewCurrenIndex = 0
    var isFirstLoad = true
    var isFromCollection = true
    var slidingView: UIView!
    var isVideo = false
    var carouselview: iCarousel!
    var pagecontrol:UIPageControl!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cartItemsArray = NSMutableArray.init()
          
            // Do any additional setup after loading the view.
            //,
           
            
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_TO_BASKET")
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes"{
                cntView = self.generalFunc.loadView(nibName: "AddToCartScreenDesignNew", uv: self, contentView: contentView)
              
            }else{
                cntView = self.generalFunc.loadView(nibName: "AddToCartScreenDesign", uv: self, contentView: contentView)
            }
            self.contentView.addSubview(cntView)
            self.setData()
            
            GeneralFunctions.saveValue(key: "CART_UPDATE", value: false as AnyObject)
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
            } else {
                automaticallyAdjustsScrollViewInsets = false
            }
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()

           
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.navigationBar.isTranslucent = true
            
        }else if(type == 2){
            self.mainHeaderView.layer.addShadow(opacity: 0.9, radius: 2.0, UIColor.lightGray)
            self.mainHeaderView.layer.roundCorners(radius: 10)
            if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
                
                    self.createToppingAndOptionsViewNew()
                
            
            }else{
            self.createToppingAndOptionsView()
            self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.opetionTopingViewHight.constant + self.mainHeaderViewHeight.constant + 150 + 270)
            }
            

            var frameBottom  = self.bottomView.frame.origin.y
            
            
        }else if(type == 3){
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.navigationBar.isTranslucent = false
            
            self.cartToppingViewsArray.removeAll()
            self.cartOptinViewsArray.removeAll()
//            for view in self.mainHeaderView.subviews
//            {
//                view.removeFromSuperview()
//            }
        }
    }
    
   
    func setData()
    {
        
            
       
        itemTypeLbl.font = UIFont.init(name: Fonts().regular, size: 14)
        if(foodItemDetails.get("vItemDesc") != ""){
            self.mainHeaderViewHeight.constant = self.mainHeaderViewHeight.constant + 30
        }else {
            self.mainHeaderViewHeight.constant = 50
        }
        self.itemTypeLbl.delegate = self
        self.itemTypeLbl.shouldCollapse = true
        self.itemTypeLbl.textReplacementType = .word
        self.itemTypeLbl.numberOfLines = 2
        self.itemTypeLbl.collapsed = true
        self.itemTypeLbl.text = foodItemDetails.get("vItemDesc")
        self.itemTypeLbl.textAlignment = .center
        self.backImgView.handleClick { (instance) in
            self.close()
        }
        
        self.backImgView.image = UIImage(named:"ic_cancel_forgotpass")?.addImagePadding(x: 10, y: 10)?.tintTo(color: UIColor.black)
        
        
        self.backImgView.masksToBounds = true
        self.backImgView.layer.addShadow(opacity: 0.9, radius: 3, UIColor.lightGray)
        self.backImgView.layer.roundCorners(radius: 20)
        
        self.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_TO_BASKET")
       
       
        //self.topHViewHeight.constant = self.topHViewHeight.constant + (GeneralFunctions.getSafeAreaInsets().top > 0 ? 20 : 0)
        //self.topNavViewHeight.constant = self.topNavViewHeight.constant + (GeneralFunctions.getSafeAreaInsets().top > 0 ? 20 : 0)
        self.topHViewHeight.constant = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9") //+ (GeneralFunctions.getSafeAreaInsets().top > 0 ? 20 : 0)
        print(self.topHViewHeight.constant)
        let url = URL(string: Utils.getResizeImgURL(imgUrl: foodItemDetails.get("vImage"), width: 0, height: Utils.getValueInPixel(value: self.topHViewHeight.constant), MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width)))
        self.topHImgView.sd_setImage(with: url , placeholderImage:nil)
        self.topHImgView.backgroundColor = UIColor.systemGray5
        
        
        
        let finalStr = NSMutableAttributedString.init(string: "")
        
        if GeneralFunctions.parseInt(origValue: 0, data: self.foodItemDetails.get("fOfferAmt")) > 0
        {
            
            let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: self.foodItemDetails.get("StrikeoutPrice")))
            attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
            finalStr.append(attributedString)
            self.headerItemStrikeOutLbl.attributedText = finalStr
            self.headerStrikeOutLblHeight.constant = 20

            let attributedStringFinalPrice = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: self.foodItemDetails.get("fDiscountPricewithsymbol")))
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            attributedStringFinalPrice.addAttributes(yourOtherAttributes, range: NSMakeRange(0, attributedStringFinalPrice.length))

            self.headerItemPriceLbl.attributedText = attributedStringFinalPrice
         
        
        }else{

            let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: self.foodItemDetails.get("StrikeoutPrice")))
            finalStr.append(attributedString)
            self.headerItemPriceLbl.attributedText = finalStr
            self.headerStrikeOutLblHeight.constant = 0
        }
        
        
        self.headerItemNameLbl.text = self.foodItemDetails.get("vItemType")
        
        if self.foodItemDetails.get("eFoodType") == "Veg"
        {
           // self.itemTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VEGETARIAN")
            self.itemTypeImgView.image = UIImage(named: "ic_veg")
        }else if self.foodItemDetails.get("eFoodType") == "NonVeg"
        {
            //self.itemTypeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NONVEGETARIAN")
            self.itemTypeImgView.image =  UIImage(named: "ic_nonVeg")
        }else
        {
           // self.itemTypeLbl.isHidden = true
           self.itemTypeImgView.isHidden = true
        }
        
        
        let sepPrice = GeneralFunctions.getValue(key: "ispriceshow")
        
        
        if (GeneralFunctions.parseDouble(origValue: 0.0, data: self.foodItemDetails.get("fOfferAmt")) > 0.0 && sepPrice?.uppercased != "SEPARATE")
        {
            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: self.foodItemDetails.get("fDiscountPrice"))
            
        }else{
            
            itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: self.foodItemDetails.get("fPrice"))
            
        }
        //itemAmount = GeneralFunctions.parseDouble(origValue: 0, data: self.foodItemDetails.get("fPrice"))
        //self.headerItemPriceLbl.text = self.foodItemDetails.get("StrikeoutPrice")
        finalAmount = itemAmount
        
        self.plusView.backgroundColor = SColors.Theme
        self.minusView.backgroundColor = SColors.Theme
        Utils.createRoundedView(view: self.plusView, borderColor: UIColor.clear, borderWidth: 0)
        Utils.createRoundedView(view: self.minusView, borderColor: UIColor.clear, borderWidth: 0)
        
        GeneralFunctions.setImgTintColor(imgView: self.plusImgView, color: SColors.ThemeTxt)
        GeneralFunctions.setImgTintColor(imgView: self.minusImgview, color: SColors.ThemeTxt)
        
        let menuToppOptionsArray = self.foodItemDetails.dictOf("MenuItemOptionToppingArr")
        self.categoryArray = menuToppOptionsArray.arrOf("Category") as! [NSDictionary]
        self.optionsArray = menuToppOptionsArray.arrOf("options") as! [NSDictionary]
        //self.optionsArray = self.categoryArray.arrOf("Category") as! [NSDictionary]
        self.toppingArray = menuToppOptionsArray.arrOf("addon") as! [NSDictionary]
        
        
        self.quanityLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUANTITY_TXT")
        self.totalLbl.text = self.foodItemDetails.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: "\(String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.0, data: String(itemAmount))))")
        self.totalLbl.textColor = SColors.ThemeTxt
        self.bottomView.backgroundColor = SColors.Theme
        self.submitBtn.titleColor =  SColors.ThemeTxt
        self.submitBtn.bgColor = UIColor.clear
        
        //self.totalAmountLbl.text =
        self.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(itemCount))
        
        let minusTapGesture = UITapGestureRecognizer()
        minusTapGesture.addTarget(self, action: #selector(self.minusTapped))
        self.minusView.isUserInteractionEnabled = true
        self.minusView.addGestureRecognizer(minusTapGesture)
        
        let plusTapGesture = UITapGestureRecognizer()
        plusTapGesture.addTarget(self, action: #selector(self.plusTapped))
        self.plusView.isUserInteractionEnabled = true
        self.plusView.addGestureRecognizer(plusTapGesture)
        
        if GeneralFunctions.getSafeAreaInsets().bottom == 0
        {
            self.bottomViewHeight.constant = 50
        }else
        {
            self.bottomViewHeight.constant = 50 + 30.0
        }
        
        if Configurations.isRTLMode() == true{
            
            self.totalLbl.textAlignment = .right
            self.headerItemPriceLbl.textAlignment = .left
            self.headerItemStrikeOutLbl.textAlignment = .left
            
        }else{
            
            self.totalLbl.textAlignment = .left
            self.headerItemPriceLbl.textAlignment = .right
            self.headerItemStrikeOutLbl.textAlignment = .right
        }
        
//        self.lblNext.setClickHandler { (label) in
////            var frame = self.viewNxtPrivious.frame.size.height + self.viewNxtPrivious.frame.origin.y
////            self.horizontalScrollView.isScrollEnabled = true
////            self.countOFTap = self.countOFTap + 1
////            print(self.countOFTap)
////            let tempX = Int(Application.screenSize.width) * self.countOFTap
////            print(tempX)
////
////
////
////            Utils.delayWithSeconds(0.2) {
////                self.lblPrevious.isHidden = false
////                self.prevImageView.isHidden = false
////                if self.countOFTap == self.categoryArray.count - 1 {
////                    self.lblNext.isHidden = true
////                    self.nextImageView.isHidden = true
////                }
////                self.horizontalScrollHight.constant = CGFloat(self.positionYArray[self.countOFTap] + 10)
////                self.opetionTopingViewHight.constant = CGFloat(self.positionYArray[self.countOFTap] + 10)
////                self.shadowViewHight.constant = self.opetionTopingViewHight.constant
////                self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.opetionTopingViewHight.constant +  150 + 270 + self.mainHeaderViewHeight.constant)
////                self.scrollViewHight.constant = 667 + self.shadowViewHight.constant
////                self.labelCategory.text =  self.categoryArray[self.countOFTap].get("vCategoryName")
////                self.horizontalScrollView.setContentOffset(CGPoint(x: CGFloat(tempX), y: 0), animated: true)
////            }
//            self.pressNext()
////
//        }
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
           
            self.horizontalScrollView.delegate = self
            self.horizontalScrollView.isScrollEnabled = false
            
            if categoryArray.count > 1 {
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NEXT").uppercased())
                submitBtn.btnType = "NEXT"
            }else{
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM").uppercased())
                submitBtn.btnType = "ITEM"
            }
           
        }else{
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM").uppercased())
            submitBtn.btnType = "ITEM"
        }
        self.submitBtn.clickDelegate = self
        print(self.foodItemDetails.arrOf("MenuItemMedia") as! [NSDictionary])
        self.bannersItemList = self.foodItemDetails.arrOf("MenuItemMedia") as! [NSDictionary]
        if  self.bannersItemList.count == 0 {
            let parameters = [["vImage": foodItemDetails.get("vImage"), "eFileType" : "Image"]] as! [NSDictionary]
            self.bannersItemList = parameters
        }
        self.setBannerData()
        
        pageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.bannersItemList.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor: SColors.Theme.dark(by: 0), dotsColor: .white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        //pageController.backgroundColor =  SColors.btBg.withAlphaComponent(0.7)//UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 1.0)
       // pageController.opacity = 0.8//SColors.Theme
        pageController.backgroundColor =  UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.5)
        pageController.layer.cornerRadius = 8
        pageController.layer.masksToBounds = true
        if self.bannersItemList.count <= 1 {
            self.pageController.isHidden = true
        }else{
            self.pageController.isHidden = false
        }
        if advancedPageControllerWidth != nil {
        advancedPageControllerWidth.constant = CGFloat((self.bannersItemList.count * 15) + 15)
        if advancedPageControllerWidth.constant > Application.screenSize.width {
            advancedPageControllerWidth.constant = Application.screenSize.width - 40
        }
        }
        pageController.tintColor = SColors.Theme
        self.imgSlide.reloadData()
    }
    
  
    func disaplyFinalTotal()
    {
        let sepPrice = GeneralFunctions.getValue(key: "ispriceshow")
        var totalAmount = Double(itemAmount) * Double(itemCount)
        if(sepPrice?.uppercased == "SEPARATE"){
            
            if(self.optionSelctionIndex >= 0){
                totalAmount = 0
            }
        }
        

        if self.optionSelctionIndex >= 0
        {
            totalAmount = totalAmount + (Double(self.optionsArray[self.optionSelctionIndex].get("fUserPrice"))! * Double(itemCount))
        }
        
        for i in 0..<self.toppingSelectionArray.count
        {
            if self.toppingSelectionArray[i] == true{
                totalAmount = totalAmount + (Double(self.toppingArray[i].get("fUserPrice"))! * Double(itemCount))
            }
        }
        
        finalAmount = totalAmount.roundTo(places: 2)
        
        self.totalLbl.text = self.foodItemDetails.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: String(finalAmount))))
        
        //self.totalLbl.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: String(finalAmount))), addCurrncy: true, currencySymbol: self.foodItemDetails.get("currencySymbol"))
        
        //self.totalAmountLbl.text =
    }
    
    
    @objc func plusTapped()
    {
        
        if(self.isRestaurantClose){
            if timeSlot.uppercased() == "YES"  &&  eAvialble.uppercased() == "NO" {
              Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_ACCEPT_ORDERS_TXT"), uv: self)
            }else{
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_CLOSE_NOTE"), uv: self)
            }
            return
        }
        
        self.plusView.layer.transform = CATransform3DMakeScale(0.85,0.85,1)
        UIView.animate(withDuration: 0.2, animations: {
            self.plusView.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        itemCount = itemCount + 1
        UIView.transition(with: self.itemCountLbl,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.itemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(describing: self!.itemCount))
            }, completion: nil)
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes"{
        self.disaplyFinalTotalNew()
        }else{
            self.disaplyFinalTotal()
        }
    }
    
    @objc func minusTapped()
    {
        if(self.isRestaurantClose){
            if timeSlot.uppercased() == "YES"  &&  eAvialble.uppercased() == "NO" {
              Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NOT_ACCEPT_ORDERS_TXT"), uv: self)
            }else{
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_CLOSE_NOTE"), uv: self)
            }
            return
        }
        
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
                                
                }, completion: nil)
            
            //self.disaplyFinalTotal()
            if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes"{
            self.disaplyFinalTotalNew()
            }else{
                self.disaplyFinalTotal()
            }
        }
    }
    
    @objc func toppingTapped(sender:UITapGestureRecognizer)
    {
         if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        let index = sender.view!.tag
        
//        (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
//        UIView.animate(withDuration: 0.25, animations: {
//            (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(1,1,1)
//        })
            
            if self.selectionIndexOfTopping.contains(index){

                ((sender.view) as! CartToppingView).selctionImgView.on = false
                
                self.selectionIndexOfTopping.remove(object: index)
            }else{
                ((sender.view) as! CartToppingView).selctionImgView.on = true
                self.selectionIndexOfTopping.append(index)
            }
        
            self.disaplyFinalTotalNew()
         }else{
            let index = sender.view!.tag
            
            (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
            UIView.animate(withDuration: 0.25, animations: {
                (self.cartToppingViewsArray[index]).layer.transform = CATransform3DMakeScale(1,1,1)
            })
            
            if self.toppingSelectionArray[index] == false
            {
                self.toppingSelectionArray[index] = true
                ((sender.view) as! CartToppingView).selctionImgView.on = true
                
            }else{
                
                self.toppingSelectionArray[index] = false
                ((sender.view) as! CartToppingView).selctionImgView.on = false
                
            }
            
             self.disaplyFinalTotal()
        }
         
    }
    
    @objc func optionTapped(sender:UITapGestureRecognizer)
    {
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        let index = sender.view!.tag
        var tag = 0
        self.optionSelctionIndex = index
            
      for view in optionToppingView.subviews{
        
            //print(view)
       if let view = view as? CartOptionView{
        // particular category view change on tapped
        if view.selctionImgView.tag == self.countOFTap {
            // set Unselected option view
            view.selctionImgView.image = UIImage(named: "ic_select_false")
            GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
            
            let tempAry = categoryArray[self.countOFTap].arrOf("options") as! [NSDictionary]
            for i in 0..<tempAry.count {
              var opetionTag =  Int(tempAry[i].get("iOptionId")) ?? 00
                if self.selectionIndexOfOpetion.contains(opetionTag){
                    self.selectionIndexOfOpetion.remove(object: opetionTag)

                    
                }
            }
            // set selected option view
            if view.tag == index {
                tag = view.titleLbl.tag
            view.selctionImgView.image = UIImage(named: "ic_select_true")
              GeneralFunctions.setImgTintColor(imgView: view.selctionImgView, color: SColors.Theme)
                
            
             }

           
        }
        }

        }
          // save selected opetion id
        if !selectionIndexOfOpetion.contains(index){
               selectionIndexOfOpetion.append(index)
                }
            self.defalutIndexCheck.append(self.countOFTap)
        self.disaplyFinalTotalNew()
        }else{
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
                    GeneralFunctions.setImgTintColor(imgView: (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView, color: SColors.Theme)
                    GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
                }
               
                self.optionSelctionIndex = index
                ((sender.view) as! CartOptionView).selctionImgView.image = UIImage(named: "ic_select_true")
                 GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
                GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
            }
            
            self.disaplyFinalTotal()
        }
    }
        
       
//        (self.cartOptinViewsArray[index]).layer.transform = CATransform3DMakeScale(0.96,0.96,1)
//        UIView.animate(withDuration: 0.2, animations: {
//            (self.cartOptinViewsArray[index]).layer.transform = CATransform3DMakeScale(1,1,1)
//        })
//        print (((sender.view) as! CartOptionView).selctionImgView.tag)
//        if self.optionSelctionIndex != index
//        {
//
//            if ((sender.view) as! CartOptionView).selctionImgView.tag != countOFTap
//            {
//                (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView.image = UIImage(named: "ic_select_false")
//                GeneralFunctions.setImgTintColor(imgView: (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView, color: SColors.Theme)
//                GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
//            }
//
//            self.optionSelctionIndex = index
//            ((sender.view) as! CartOptionView).selctionImgView.image = UIImage(named: "ic_select_true")
//             GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
//            GeneralFunctions.setImgTintColor(imgView: ((sender.view) as! CartOptionView).selctionImgView, color: SColors.Theme)
//        }
        
        
   // }
    
    
    
    
    
    func storeDataLocally()
    {
        let dic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":self.itemCount, "itemAmount": String(finalAmount)] as [String : Any])
        
        if self.optionSelctionIndex < 0 && self.optionsArray.count > 0
        {
            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONS_REQUIRED"))
            return
        }
        
        let extraParaDic = ["min_order":self.minOrder, "vImage":self.vImage, "companyAddress":self.companyAddress, "iCompanyId":self.companyId, "vCompany": self.comapnyName,]
        GeneralFunctions.saveValue(key: "GeneralCartInfo", value: extraParaDic as AnyObject)
        
        if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
           
            self.cartItemsArray = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
            
            if self.cartItemsArray.count > 0
            {
                let item = self.cartItemsArray[0] as! NSDictionary
                
                // Check item added in cart & current item are with same restaurant or not.
                if item.get("iCompanyId") != self.companyId
                {
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_RESTAURANT_LBL"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0
                        {
                            GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                            self.cartItemsArray.removeAllObjects()
                            self.cartItemsArray.add(dic)
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                            self.close()
                            return
                            
                        }else{
                            return
                        }
                    })
                }else{
                    
                    GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                    // Check same toppings and otions item exsists in cart. If yes than only replase that item withcount & amount. Othervise add new item.
                    for i in 0..<self.cartItemsArray.count
                    {
                        let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray] as [String : Any])
                        let oldDic = (self.cartItemsArray[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                        
                        var count:Int = Int(oldDic.get("itemCount"))!
                        var amn:Double = Double(oldDic.get("itemAmount"))!
                        oldDic.removeObject(forKey: "itemAmount")
                        oldDic.removeObject(forKey: "itemCount")
                        
                        if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
                        {
                            count = count + self.itemCount
                            amn = (amn + finalAmount).roundTo(places: 2)
                            let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex":String(self.optionSelctionIndex),"selectedToppingIndexes":self.toppingSelectionArray, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                            self.cartItemsArray.replaceObject(at: i, with: newDic)
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                            self.close()
                            return
                        }
                    }
                    self.cartItemsArray.add(dic)
                    GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                    self.close()
                }
            }else // Add as new item due to no tem in cart
            {
                GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                self.cartItemsArray.add(dic)
                GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                self.close()
            }
            
        }else{ // Add as new item due to no tem in cart
            GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
            self.cartItemsArray.add(dic)
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
            self.close()
        }
      
    }
    func createToppingAndOptionsView()
    {
        var yPosition = 0
        for i in 0..<self.optionsArray.count
        {
            if i == 0
            {
                let optionTitleLbl = UILabel(frame: CGRect(x: 10, y: yPosition , width: Int(Application.screenSize.width - 20), height: 45))
                optionTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 19)
               // optionTitleLbl.autoresizingMask = [.flexibleWidth]
                optionTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_OPTIONS")
                self.optionToppingView.addSubview(optionTitleLbl)
                
                yPosition = yPosition + 45
            }
         
            let optionView = CartOptionView()
           
            let optionsView = CartOptionView(frame: CGRect(x:0, y: yPosition + (i * 40)  , width: Int(Application.screenSize.width), height: 40))
            optionsView.tag = i
            //optionsView.autoresizingMask = [.flexibleWidth]
            GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
           // optionsView.priceLbl.text =
            optionsView.bottomBorderLine.isHidden = true
            optionsView.titleLbl.text = self.optionsArray[i].get("vOptionName")
            optionsView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: self.optionsArray[i].get("fUserPriceWithSymbol"))
            
            if self.optionsArray[i].get("eDefault") == "Yes"
            {
                if self.optionSelctionIndex != i
                {
                    if self.optionSelctionIndex >= 0
                    {
                        (self.cartOptinViewsArray[self.optionSelctionIndex]).selctionImgView.image = UIImage(named: "ic_select_false")
                        GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
                    }
                    
                    self.optionSelctionIndex = i
                    optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                    GeneralFunctions.setImgTintColor(imgView:optionsView.selctionImgView, color: SColors.Theme)
                }
            }
            
            self.optionToppingView.addSubview(optionsView)
            self.cartOptinViewsArray.append(optionsView)
            
            let optionTapGesture = UITapGestureRecognizer()
            optionTapGesture.addTarget(self, action: #selector(self.optionTapped(sender:)))
            optionsView.isUserInteractionEnabled = true
            optionsView.addGestureRecognizer(optionTapGesture)
            
            if i == self.optionsArray.count - 1
            {
                yPosition = yPosition + (i * 40) + 40
            }
        }
    
        for i in 0..<self.toppingArray.count
        {
            if i == 0
            {
                
                let toppingTitleLbl = UILabel(frame: CGRect(x: 10, y: yPosition + 10 , width: Int(Application.screenSize.width - 20), height: 45))
                toppingTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 19)
                toppingTitleLbl.autoresizingMask = [.flexibleWidth]
                toppingTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TOPPING")
                self.optionToppingView.addSubview(toppingTitleLbl)
                
                yPosition = yPosition + 55
            }
            
            self.toppingSelectionArray.append(false)
            let toppingView = CartToppingView(frame: CGRect(x:0, y: yPosition + (i * 40) , width: Int(Application.screenSize.width), height: 40))
            
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
            
            //toppingView.priceLbl.text =
            toppingView.bottomBorderView.isHidden = true
            toppingView.titleLbl.text = self.toppingArray[i].get("vOptionName")
            toppingView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: self.toppingArray[i].get("fUserPriceWithSymbol"))
            
            self.optionToppingView.addSubview(toppingView)
            self.cartToppingViewsArray.append(toppingView)
            
            let toppingTapGesture = UITapGestureRecognizer()
            toppingTapGesture.addTarget(self, action: #selector(self.toppingTapped(sender:)))
            toppingView.isUserInteractionEnabled = true
            toppingView.addGestureRecognizer(toppingTapGesture)
            
            if i == self.toppingArray.count - 1
            {
                yPosition = yPosition + (i * 40) + 40
            }
        }
        
        self.view.layoutIfNeeded()
        self.opetionTopingViewHight.constant = CGFloat(yPosition)
       
        
       
        self.addQuanView.alpha = 0
        self.addQuanView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.addQuanView.alpha = 1
        }, completion:{ _ in
            
        })
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
            if sender.btnType == "NEXT" {
            if categoryArray.count > 1 {
                countOFTap = countOFTap + 1
                if countOFTap != categoryArray.count - 1 {
                   
                    self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NEXT").uppercased())
                    self.isFromCollection = false
                    self.pressPrivious()
                    self.submitBtn.btnType = "NEXT"
                    self.viewCurrenIndex = countOFTap
                    self.collectionView.reloadData()
                    return
                }else{
                    self.isFromCollection = false
                    self.pressPrivious()
                    self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM").uppercased())
                    self.submitBtn.btnType = "ITEM"
                    
                    self.viewCurrenIndex = countOFTap
                    self.collectionView.reloadData()
                    return
                }
                
            }
            }
        }
        
        
        if(self.isRestaurantClose){
            Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANTS_CLOSE_NOTE"), uv: self)
            return
        }
        
       
        if userProfileJson.get("ENABLE_MULTI_OPTIONS_ADDONS") == "Yes" {
        self.storeDataLocallyNew()
        }else{
            self.storeDataLocally()
        }
        
    }
    
     func compareDic <K, V>(left: [K:V?], right: [K:V?]) -> Bool {
        guard let left = left as? [K: V], let right = right as? [K: V] else { return false }
        return NSDictionary(dictionary: left).isEqual(to: right)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // multiple addon and option related changes from here
   // all next button and steeper button press and set scroll
    func pressPrivious()  {
       self.horizontalScrollView.isScrollEnabled = true
        if self.categoryArray.count > 4 {
            if self.isFromCollection == false {
        collectionView.scrollToItem(at:IndexPath(item: countOFTap , section: 0), at: .right, animated: false)
            }
        }
        self.createToppingAndOptionsViewNew()
         
    }
        
    
    // store multiple topping and addon here
    func storeDataLocallyNew()
    {
       
        let dic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex": selectionIndexOfOpetion,"selectedToppingIndexes": selectionIndexOfTopping, "itemCount":self.itemCount, "itemAmount": String(finalAmount)] as [String : Any])
        //check all opetion selected or not
//        if optCheck != self.selectionIndexOfOpetion.count
//        {
//            self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OPTIONS_REQUIRED"))
//            return
//        }
        
        let extraParaDic = ["min_order":self.minOrder, "vImage":self.vImage, "companyAddress":self.companyAddress, "iCompanyId":self.companyId, "vCompany": self.comapnyName,]
        GeneralFunctions.saveValue(key: "GeneralCartInfo", value: extraParaDic as AnyObject)
        
        if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.CART_INFO_DATA) == true) {
           
            self.cartItemsArray = ((GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray)
            
            if self.cartItemsArray.count > 0
            {
                let item = self.cartItemsArray[0] as! NSDictionary
                
                // Check item added in cart & current item are with same restaurant or not.
                if item.get("iCompanyId") != self.companyId
                {
                    self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE_CART"), content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHANGE_RESTAURANT_LBL"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_PROCEED"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                        
                        if btnClickedIndex == 0
                        {
                            GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                            self.cartItemsArray.removeAllObjects()
                            self.cartItemsArray.add(dic)
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                            self.close()
                            return
                            
                        }else{
                            return
                        }
                    })
                }else{
                    
                    GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                    // Check same toppings and otions item exsists in cart. If yes than only replase that item withcount & amount. Othervise add new item.
                    for i in 0..<self.cartItemsArray.count
                    {
                        let ndic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex": selectionIndexOfOpetion,"selectedToppingIndexes":selectionIndexOfTopping] as [String : Any])
                        let oldDic = (self.cartItemsArray[i] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                        
                        var count:Int = Int(oldDic.get("itemCount"))!
                        var amn:Double = Double(oldDic.get("itemAmount"))!
                        oldDic.removeObject(forKey: "itemAmount")
                        oldDic.removeObject(forKey: "itemCount")
                        
                        if compareDic(left: oldDic as! [String : Any?], right: ndic as! [String : Any?])
                        {
                            count = count + self.itemCount
                            amn = (amn + finalAmount).roundTo(places: 2)
                            let newDic = NSMutableDictionary.init(dictionary: ["iCompanyId":self.companyId, "vCompany": self.comapnyName, "ItemData":self.foodItemDetails!,"selectedOptionIndex": selectionIndexOfOpetion,"selectedToppingIndexes": selectionIndexOfTopping, "itemCount":count , "itemAmount": String(amn)] as [String : Any])
                            self.cartItemsArray.replaceObject(at: i, with: newDic)
                            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                            self.close()
                            return
                        }
                    }
                    self.cartItemsArray.add(dic)
                    GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                    self.close()
                }
            }else // Add as new item due to no tem in cart
            {
                GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
                self.cartItemsArray.add(dic)
                GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
                self.close()
            }
            
        }else{ // Add as new item due to no tem in cart
            GeneralFunctions.saveValue(key: "CART_UPDATE", value: true as AnyObject)
            self.cartItemsArray.add(dic)
            GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: self.cartItemsArray as AnyObject)
            self.close()
        }
      
    }
    // create multiple addon and toping view form here
    func createToppingAndOptionsViewNew()
    {
      var yPosition = 0
      var XPosition = 0
    
        
    optCheck = 0
        self.opetionTopingViewWidth.constant = CGFloat(self.categoryArray.count) * Application.screenSize.width
        for j in 0..<self.categoryArray.count {
            yPosition = 0
            if j == 0 {
                XPosition = 0
            }else{
                XPosition =  Int(Application.screenSize.width) * j
            }
            
            self.optionsArray = categoryArray[j].arrOf("options") as! [NSDictionary]
            self.toppingArray = categoryArray[j].arrOf("addon") as! [NSDictionary]
            self.optionsArrayGlobal += self.optionsArray
            self.toppingArrayGlobal += self.toppingArray
            self.labelCategory.textColor = SColors.Theme
            
            self.labelCategory.text =  categoryArray[countOFTap].get("vCatName")
            //optionsArrayGlobal.append(self.optionsArray)
           
        for i in 0..<self.optionsArray.count
        {
            if i == 0
            {
                //let optionTitleLbl = UILabel(frame: CGRect(x: XPosition + 10 , y: yPosition + 10, width: Int(Application.screenSize.width - 40), height: 45))
                let optionTitleLbl = UILabel(frame: CGRect(x: XPosition + 10 , y: yPosition + 10, width: Int(Application.screenSize.width - 50), height: 45))
                optionTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 18)
                //optionTitleLbl.textAlignment = .left
                //optionTitleLbl.autoresizingMask = [.flexibleWidth]
                optionTitleLbl.numberOfLines = 0
                optCheck = optCheck + 1
                optionTitleLbl.text = categoryArray[j].get("tOptionTitle")
                var hightOfOpetion = optionTitleLbl.text?.height(withConstrainedWidth: (Application.screenSize.width - 20), font: UIFont.init(name: Fonts().semibold, size: 18)!)
                optionTitleLbl.frame.size.height = hightOfOpetion!
               // optionTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_OPTIONS")
                self.optionToppingView.addSubview(optionTitleLbl)
                //optionTitleLbl.backgroundColor = UIColor.black
                //yPosition = yPosition + 45
                if optionTitleLbl.text == ""{
                optionTitleLbl.frame.size.height = 0
                yPosition = yPosition + 10
                }else{
                optionTitleLbl.frame.size.height = hightOfOpetion ?? 50
                    yPosition = yPosition + Int(hightOfOpetion!) + 20
                }
            }
         
           
            let optionsView = CartOptionView(frame: CGRect(x:XPosition, y: yPosition + (i * 40)  , width: Int(Application.screenSize.width - 40), height: 40))
       
            optionsView.tag =  Int(self.optionsArray[i].get("iOptionId")) ?? 00
          
            GeneralFunctions.setImgTintColor(imgView: optionsView.selctionImgView, color: SColors.Theme)
           
            optionsView.bottomBorderLine.isHidden = true
            optionsView.titleLbl.text = self.optionsArray[i].get("vOptionName")
            optionsView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: self.optionsArray[i].get("fUserPriceWithSymbol"))
            optionsView.selctionImgView.tag = j
            
                optionsView.titleLbl.tag = i
            // opetion selected unselected when view load
            if selectionIndexOfOpetion.contains(optionsView.tag){
                optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                GeneralFunctions.setImgTintColor(imgView:optionsView.selctionImgView, color: SColors.Theme)
                
            }
           
            if self.optionsArray[i].get("eDefault") == "Yes" && !self.defalutIndexCheck.contains(j)
            {

                    self.optionSelctionIndex = i
                    optionsView.selctionImgView.image = UIImage(named: "ic_select_true")
                    GeneralFunctions.setImgTintColor(imgView:optionsView.selctionImgView, color: SColors.Theme)
                if !selectionIndexOfOpetion.contains(optionsView.tag){
                self.selectionIndexOfOpetion.append(optionsView.tag)
                    self.disaplyFinalTotalNew()
                }
            }
            
            
           
            self.optionToppingView.addSubview(optionsView)
            self.cartOptinViewsArray.append(optionsView)
            
            let optionTapGesture = UITapGestureRecognizer()
            optionTapGesture.addTarget(self, action: #selector(self.optionTapped(sender:)))
            optionsView.isUserInteractionEnabled = true
            optionsView.addGestureRecognizer(optionTapGesture)
            
            
            if i == self.optionsArray.count - 1
            {
                yPosition = yPosition + (i * 40) + 40
            }
        }
        
        for i in 0..<self.toppingArray.count
        {
            if i == 0
            {
                
                let toppingTitleLbl = UILabel(frame: CGRect(x:XPosition + 10 , y: yPosition + 10 , width: Int(Application.screenSize.width - 50), height: 45))
                print (toppingTitleLbl.frame)
                toppingTitleLbl.font = UIFont.init(name: Fonts().semibold, size: 18)
                toppingTitleLbl.numberOfLines = 0
                toppingTitleLbl.text = self.categoryArray[j].get("tAddonTitle")
                var hightOfTopping = toppingTitleLbl.text?.height(withConstrainedWidth: (Application.screenSize.width - 20), font: UIFont.init(name: Fonts().semibold, size: 18)!)
                toppingTitleLbl.frame.size.height = hightOfTopping!
                //toppingTitleLbl.autoresizingMask = [.flexibleWidth]
                //toppingTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TOPPING")
                self.optionToppingView.addSubview(toppingTitleLbl)
                if toppingTitleLbl.text == "" {
                    toppingTitleLbl.frame.size.height = 0
                    yPosition = yPosition + 10
                }else {
                    toppingTitleLbl.frame.size.height = hightOfTopping!
                    yPosition = yPosition  + Int(hightOfTopping!) + 20//+ 55
                }
                //yPosition = yPosition + 55
            }
            
            self.toppingSelectionArray.append(false)
            let toppingView = CartToppingView(frame: CGRect(x:XPosition, y: yPosition + (i * 40) , width: Int(Application.screenSize.width - 40), height: 40))
            
            
  
            
            toppingView.tag = Int(self.toppingArray[i].get("iOptionId")) ?? 00
           // toppingView.autoresizingMask = [.flexibleWidth]
            toppingView.selctionImgView.boxType = .square
            toppingView.selctionImgView.offAnimationType = .bounce
            toppingView.selctionImgView.onAnimationType = .bounce
            toppingView.selctionImgView.onCheckColor = SColors.ThemeTxt
            toppingView.selctionImgView.onFillColor = SColors.Theme
            toppingView.selctionImgView.onTintColor = SColors.Theme
            toppingView.selctionImgView.tintColor = SColors.Theme
            toppingView.selctionImgView.isUserInteractionEnabled = false
            
            //toppingView.priceLbl.text =
            toppingView.bottomBorderView.isHidden = true
            toppingView.titleLbl.text = self.toppingArray[i].get("vOptionName")
            toppingView.priceLbl.text = Configurations.convertNumToAppLocal(numStr: self.toppingArray[i].get("fUserPriceWithSymbol"))
            // toping selected unselected when view load
            if selectionIndexOfTopping.contains(toppingView.tag){
                toppingView.selctionImgView.on = true
            }
            self.optionToppingView.addSubview(toppingView)
            self.cartToppingViewsArray.append(toppingView)
            
            let toppingTapGesture = UITapGestureRecognizer()
            toppingTapGesture.addTarget(self, action: #selector(self.toppingTapped(sender:)))
            toppingView.isUserInteractionEnabled = true
            toppingView.addGestureRecognizer(toppingTapGesture)
            
            if i == self.toppingArray.count - 1
            {
                yPosition = yPosition + (i * 40) + 40
            }
            
                if maxY < yPosition {
                    maxY = yPosition
                }
            
          
        }
            positionYArray.append(CGFloat(yPosition))
        }
        
        print(positionYArray)
        self.view.layoutIfNeeded()
        if positionYArray.count != 0{
            self.horizontalScrollHight.constant = CGFloat(self.positionYArray[self.countOFTap] + 50) //CGFloat(maxY + 10)
            self.opetionTopingViewHight.constant = CGFloat(self.positionYArray[self.countOFTap] + 50)
        
            self.shadowViewHight.constant = CGFloat(self.positionYArray[self.countOFTap] + 50)
        }else{
            self.horizontalScrollHight.constant = 0
            self.opetionTopingViewHight.constant = 0
           
        }
      
        if self.positionYArray.count != 0 {
       self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: CGFloat(self.positionYArray[self.countOFTap] + 50) +  150 + 270 + self.mainHeaderViewHeight.constant)
        
        
        XPosition = XPosition + Int(Application.screenSize.width)
        self.horizontalScrollView.contentSize =  CGSize(width: CGFloat(XPosition), height: CGFloat(yPosition) )
        }
        let tempX = Application.screenSize.width * CGFloat(self.countOFTap)
        self.horizontalScrollView.setContentOffset(CGPoint(x: CGFloat(tempX), y: 0), animated: true)
        self.horizontalScrollView.isScrollEnabled = false
        self.addQuanView.alpha = 0
        self.addQuanView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.addQuanView.alpha = 1
        }, completion:{ _ in
            
        })
        
        
        if categoryArray.count > 1 {
            self.shadowTopingView.roundTo(corners: [.bottomLeft, .bottomRight], radius: 10)
            self.collectionParentView.roundTo(corners: [.topLeft, .topRight], radius: 10)
                    self.shadowTopingView.isHidden = false
                    self.collectionParentView.isHidden = false
                    self.setCollectionView()
                    
                }else{
                    if categoryArray.count == 1 {
                        self.collectionParentView.isHidden = false
                        self.collectionView.isHidden = true
                       // self.contentView.isHidden = true
                        self.lblSeprator.isHidden = true
                        self.shadowTopingView.roundTo(corners: [.bottomLeft, .bottomRight], radius: 10)
                        self.collectionParentView.roundTo(corners: [.topLeft, .topRight], radius: 10)
                        self.collectionViewHight.constant = 0
                        var font:UIFont!
                            font = UIFont(name: Fonts().semibold, size: 20)!
                        self.labelCategory.font = font
                    }else{
                        self.shadowTopingView.roundTo(corners: [.allCorners], radius: 10)
                    }
                    
                    self.shadowTopingView.isHidden = false
                    //self.collectionParentView.isHidden = true
                    if categoryArray.count == 0 {
                        self.collectionParentViewHight.constant = 0
                        self.shadowViewTop.constant = 0
                        self.shadowTopingView.isHidden = true
                        self.collectionParentView.isHidden = true
                    }
                    
                }
        
        
        
        
        
//        if categoryArray.count > 1 {
//            self.shadowTopingView.roundTo([.bottomLeft, .bottomRight], radius: 10)
//            self.collectionParentView.roundTo([.topLeft, .topRight], radius: 10)
//            self.shadowTopingView.isHidden = false
//            self.collectionParentView.isHidden = false
//            self.setCollectionView()
//
//        }else{
//            self.shadowTopingView.roundTo([.allCorners], radius: 10)
//            self.shadowTopingView.isHidden = false
//            self.collectionParentView.isHidden = true
//            if categoryArray.count == 0 {
//                self.collectionParentViewHight.constant = 0
//                self.shadowViewTop.constant = 0
//                self.shadowTopingView.isHidden = true
//                self.collectionParentView.isHidden = true
//            }
//
//        }
        //if(Configurations.isRTLMode()){
            if  isFirstLoad{
                isFirstLoad = false
                self.createToppingAndOptionsViewNew()
            }
       // }
        
        
       

        
    }
    
    func disaplyFinalTotalNew()
    {
        let sepPrice = GeneralFunctions.getValue(key: "ispriceshow")
        var totalAmount = Double(itemAmount) * Double(itemCount)
        if(sepPrice?.uppercased == "SEPARATE"){

            if(self.optionSelctionIndex >= 0){
                totalAmount = 0
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
           // getting price of selected opetion
         for i in 0..<optionsArrayGlobal.count
         {
            var tempID = Int(optionsArrayGlobal[i].get("iOptionId")) ?? 00
            if self.selectionIndexOfOpetion.contains(tempID) {
                totalAmount = totalAmount + (Double(self.optionsArrayGlobal[i].get("fUserPrice"))! * Double(itemCount))
            }

         }
        // getting price of selected topping
        for i in 0..<toppingArrayGlobal.count
        {
           var tempID = Int(toppingArrayGlobal[i].get("iOptionId")) ?? 00
           if self.selectionIndexOfTopping.contains(tempID) {
               totalAmount = totalAmount + (Double(self.toppingArrayGlobal[i].get("fUserPrice"))! * Double(itemCount))
           }

        }
//        if self.selectionIndexOfTopping.count > 0 {
//        for i in 0..<self.selectionIndexOfTopping.count
//        {
//            //if self.toppingSelectionArray[i] == true{
//            var temp = self.selectionIndexOfTopping[i]
//                totalAmount = totalAmount + (Double(self.toppingArrayGlobal[temp].get("fUserPrice"))! * Double(itemCount))
//            //}
//        }
//        }
        finalAmount = totalAmount.roundTo(places: 2)

        self.totalLbl.text = self.foodItemDetails.get("currencySymbol") + " " + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", GeneralFunctions.parseDouble(origValue: 0.00, data: String(finalAmount))))
        //self.totalAmountLbl.text =
    }
    // stepper collection view handle from here
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.horizontalScrollView.isScrollEnabled = false
    }
    func setCollectionView(){

        if self.collectionView != nil {
            if self.categoryArray.count > 1 {
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
       // cell.countLbl.text = String(indexPath.item + 1)
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
            self.isFromCollection = true
            self.pressPrivious()
            if self.countOFTap != self.categoryArray.count - 1 {
                self.submitBtn.btnType = "NEXT"
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NEXT").uppercased())
            }else{
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_ITEM").uppercased())
                self.submitBtn.btnType = "ITEM"
            }
            self.collectionView.reloadData()
        }
            return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return  self.categoryArray.count
        
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        var count = self.categoryArray.count - 1
        //var minusWidthCellSpace = self.categoryArray.count * 1
        var widht = Int(self.collectionView.frame.size.width) / count - 20
        if count == 1 {
            widht = Int(self.collectionView.frame.size.width) - 40
        }else if count == 3{
            widht = Int(self.collectionView.frame.size.width) / count - 15
        }
        
        if widht <= 70 {
            widht = 75
        }
        return CGSize(width: widht , height: 50)
        //self.categoryArray.count - 1
    }
    func setBannerData(){

        
        self.imgSlide.backgroundColor = UIColor.clear

        
        self.imgSlide.type = .linear
        self.imgSlide.scrollSpeed = 0.8
        self.imgSlide.decelerationRate = 0.8
       
        self.imgSlide.delegate = self
        self.imgSlide.dataSource = self
        self.imgSlide.reloadData()
        self.imgSlide.bounces = false
        
        

        
        

    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        if pagecontrol != nil {
        pagecontrol.numberOfPages = self.bannersItemList.count
        }
        return self.bannersItemList.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var mainView:UIView!
        let item = self.bannersItemList[index]
        var imgView:UIImageView!
        let height = Utils.getHeightOfBanner(widthOffset: 0, ratio: "16:9")
        
        var playBackImageView:UIImageView!
        if (view == nil){
            mainView = UIView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))
            mainView.backgroundColor = UIColor.white
            
           
                imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))

                imgView.backgroundColor = UIColor.systemGray5
        //        let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 0)
                
           
            if item.get("eFileType") != "Image" {
                playBackImageView = UIImageView.init(frame: CGRect(x:0, y:0, width: 50, height: 50))
                playBackImageView.center = imgView.center
                let url = URL(string: Utils.getResizeImgURL(imgUrl: item.get("ThumbImage"), width: 0, height: Utils.getValueInPixel(value: height), MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width)))
                    imgView.sd_setImage(with: url , placeholderImage:nil)
                playBackImageView.image = UIImage.init(named: "ic_play_new")
                imgView.addSubview(playBackImageView)
                
            }else{
                let url = URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: 0, height: Utils.getValueInPixel(value: height), MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width)))
                    imgView.sd_setImage(with: url , placeholderImage:nil)
            }
                imgView.contentMode = .scaleAspectFit
                mainView.addSubview(imgView)
            
        }else{
            mainView = view
            for i in 0..<mainView.subviews.count{
                let view = mainView.subviews[i]
                view.removeFromSuperview()
            }

            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))
                imgView.backgroundColor = UIColor.systemGray5
           
            if item.get("eFileType") != "Image" {
                playBackImageView = UIImageView.init(frame: CGRect(x:0, y:0, width: 50, height: 50))
                playBackImageView.center = imgView.center
                let url = URL(string: Utils.getResizeImgURL(imgUrl: item.get("ThumbImage"), width: 0, height: Utils.getValueInPixel(value: height), MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width)))
                    imgView.sd_setImage(with: url , placeholderImage:nil)
                playBackImageView.image = UIImage.init(named: "ic_play_new")
                imgView.addSubview(playBackImageView)
            }else{
                let url = URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: 0, height: Utils.getValueInPixel(value: height), MAX_WIDTH: Utils.getValueInPixel(value: Application.screenSize.width)))
                    imgView.sd_setImage(with: url , placeholderImage:nil)
            }
            
                imgView.contentMode = .scaleAspectFit
                mainView.addSubview(imgView)
            }
        return mainView
        }
        
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        if carousel == self.imgSlide {
            if(self.pageController != nil){
                self.pageController.setPage(carousel.currentItemIndex)
            }
        }else {
            if(pagecontrol != nil){
                pagecontrol.currentPage = carousel.currentItemIndex
            }
        }
    }
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if self.imgSlide == carousel {
            self.removeSlidingView()
            self.addSlidingView()
            
            self.slidingView.alpha = 0.0
            self.slidingView.isHidden = false
            self.carouselview.scrollToItem(at: index, animated: false)
            UIView.animate(withDuration: 0.3, animations: {
                self.slidingView.alpha = 1.0
            })
        }else {
            let item = self.bannersItemList[index]
            if item.get("eFileType") != "Image" {
            
                self.removeSlidingView()
                self.playVideo(str: item.get("vImage"))
            }
        }
       
    }
    func addSlidingView(){
        
        slidingView = UIView.init(frame: CGRect(x:0, y:0, width: Application.screenSize.width, height:Application.screenSize.height))
        slidingView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        Application.window?.addSubview(slidingView)
        
        let closeLbl = UILabel.init(frame: CGRect(x:20, y:50, width: Application.screenSize.width - 40, height:21))
        closeLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CLOSE_TXT")
        closeLbl.font = UIFont.init(name: Fonts().semibold, size: 17)
        closeLbl.textColor = UIColor.white
        if(Configurations.isRTLMode() == true){
            closeLbl.textAlignment = .left
        }else{
            closeLbl.textAlignment = .right
        }
        slidingView.addSubview(closeLbl)
        
        pagecontrol = UIPageControl.init(frame: CGRect(x:10, y:Application.screenSize.height - 45, width: Application.screenSize.width - 20, height:20))
        pagecontrol.tintColor = UIColor.yellow
        pagecontrol.currentPage = 2
        pagecontrol.isUserInteractionEnabled = false
        slidingView.addSubview(pagecontrol)
        if bannersItemList.count <= 1 {
            pagecontrol.isHidden = true
        }
        carouselview = iCarousel.init(frame: CGRect(x:0, y:(Application.screenSize.height / 2) - ((Application.screenSize.height - 150)/2) + 15, width: Application.screenSize.width, height:Application.screenSize.height - 150))
        slidingView.addSubview(carouselview)
        
      
        self.slidingView.handleClick { (instance) in
            self.removeSlidingView()
        }
        
        closeLbl.handleClick { (instance) in
            self.removeSlidingView()
        }
        
        carouselview.type = .linear
        carouselview.scrollSpeed = 0.8
        carouselview.decelerationRate = 0.8
        self.carouselview.delegate = self
        self.carouselview.dataSource = self
        
        self.carouselview.reloadData()
        self.slidingView.isHidden = true
    }
    func removeSlidingView(){
        if(slidingView != nil){
            slidingView.isHidden = true
            slidingView.removeFromSuperview()
        }
        
        if(carouselview != nil){
            carouselview.delegate = nil
            carouselview.dataSource = nil
        }
        
    }
    func playVideo(str : String) {
        let videoURL = URL(string: str)
        if videoURL != nil {
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        }
    }
    
    func willExpandLabel(_ label: ExpandableLabel) {
       
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        itemTypeLbl.setNeedsLayout()
        itemTypeLbl.layoutIfNeeded()
        if(itemTypeLbl.text != ""){
            let extraHeight = (foodItemDetails.get("vItemDesc").height(withConstrainedWidth: Application.screenSize.width - 50, font: UIFont.init(name: Fonts().regular, size: 14)!) - 50)
            self.mainHeaderViewHeight.constant = self.mainHeaderViewHeight.constant + extraHeight + 30
            self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.opetionTopingViewHight.constant +  150 + 270 + self.mainHeaderViewHeight.constant)
            //self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.optionToppingViewHeight.constant + self.mainHeaderViewHeight.constant + 150 + 270)
            //self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.horizontalScrollHight.constant + 50 + 100)
            //self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.scrollViewHight.constant + 110 + self.mainHeaderViewHeight.constant)
            //self.scrollViewHight.constant + 110
        }
        
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
       
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        itemTypeLbl.setNeedsLayout()
        itemTypeLbl.layoutIfNeeded()
        self.mainHeaderViewHeight.constant = 55 + 60
         //self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.optionToppingViewHeight.constant + 110)
        self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.opetionTopingViewHight.constant +  150 + 270 + self.mainHeaderViewHeight.constant)
       // self.scrollView.contentSize = CGSize(width: Application.screenSize.width, height: self.optionToppingViewHeight.constant + self.mainHeaderViewHeight.constant + 150 + 270)
        
    }
}


extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
