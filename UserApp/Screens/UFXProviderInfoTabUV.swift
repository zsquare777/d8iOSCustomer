

import UIKit
import GoogleMaps
import SysBaseLib

class UFXProviderInfoTabUV: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cartViewBottom: NSLayoutConstraint!
    @IBOutlet weak var totalVLbl: MyLabel!
    @IBOutlet weak var checkOutHLbl: MyLabel!
    @IBOutlet weak var cartitemCountLbl: MyLabel!
    @IBOutlet weak var cartImgView: UIImageView!
    @IBOutlet weak var providerImgView: UIImageView!
    @IBOutlet weak var providerNameLbl: MyLabel!
    @IBOutlet weak var providerRatingView: RatingView!
    @IBOutlet weak var viewProfileBtn: MyLabel!
    @IBOutlet weak var onlineIndicatorImgView: UIImageView!
    @IBOutlet weak var topProfileView: UIView!
    @IBOutlet weak var buttonBarContainerView: UIView!
    @IBOutlet weak var topProfileViewHeight: NSLayoutConstraint!
    @IBOutlet weak var providerNameLblTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var ratingImgView: UIImageView!
    
    @IBOutlet weak var sepratorStackView: UIStackView!
    
    @IBOutlet weak var ratingLbl: MyLabel!
    
    var currentLocation:CLLocation?
    let generalFunc = GeneralFunctions()
    
    var providerInfo:NSDictionary!
    var checkOutTapGue:UITapGestureRecognizer!
    var mainScreenUV:MainScreenUV!
    
    var ufxSelectedVehicleTypeId = ""
    var ufxSelectedVehicleTypeParentId = ""
    var ufxSelectedLatitude = ""
    var ufxSelectedLongitude = ""
    var ufxSelectedAddress = ""
    
    var viewControllersArr:[UIViewController]!
    var userProfileJson:NSDictionary!
    var eForVideoConsultation = ""
    var videoConsultantPriceTxt = ""
    
    var skipCheckout = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.configRTL()
        self.addBack()
        
        if(self.skipCheckout == false){
            self.setupCartView()
        }else{
            self.skipCheckout = false
        }
        
        
    }
    
    override func close() {
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            GeneralFunctions.saveValue(key: "UFXCartData", value: [[NSDictionary]]() as AnyObject)
        }
        super.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.settings.style.buttonBarItemBackgroundColor = UIColor(hex: 0xd9dadb)
        self.settings.style.buttonBarItemTitleColor = SColors.Theme
//        self.settings.style.selectedBarBackgroundColor = UIColor(hex: 0x878787)
        
        buttonBarView.selectedBar.backgroundColor = UIColor.clear
        
        buttonBarView.backgroundColor = UIColor.clear
        
        buttonBarView.layer.zPosition = 9999
        
        
//        let menuBtn = UIButton(type: .custom)
//        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        menuBtn.setImage(UIImage(named:"ic_fare_detail")?.addImagePadding(x: 0, y: 35)?.tintTo(color: UIColor.white), for: .normal)
//        menuBtn.imageView?.contentMode = .scaleAspectFit
//        menuBtn.addTarget(self, action: #selector(self.openProviderDetail), for: UIControl.Event.touchUpInside)
//        let menuBarItem = UIBarButtonItem(customView: menuBtn)
//        self.navigationItem.rightBarButtonItem = menuBarItem
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SERVICE_DETAIL")
        
        self.providerNameLbl.text = self.providerInfo.get("Name") + " " + self.providerInfo.get("LastName")
        self.providerNameLbl.textColor = SColors.blackColor
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            if self.eForVideoConsultation.uppercased() != "YES" {
            if self.userProfileJson.get("ENABLE_SEARCH_UFX_SERVICES").uppercased() == "YES"{
            if newCell?.label.text == self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES") || newCell?.label.text == nil {
                let rightButton: UIBarButtonItem = UIBarButtonItem(image:UIImage(named: "ic_search") , style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.searchTapped))
                self.navigationItem.rightBarButtonItem = rightButton
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
            }
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = SColors.Theme
            
            newCell?.label.font = UIFont.init(name: Fonts().regular, size: 16)
            oldCell?.label.font = UIFont.init(name: Fonts().regular, size: 16)
            
            oldCell?.label.backgroundColor = UIColor.clear
            newCell?.label.backgroundColor = UIColor.clear
            
            newCell?.backgroundColor = UIColor.clear
            oldCell?.backgroundColor = UIColor.clear
         
            self.setSepratorView(index: newCell?.label.tag ?? 0)
        }
        
        providerImgView.sd_setImage(with: URL(string: "\(CommonUtils.driver_image_url)\(self.providerInfo.get("driver_id"))/\(self.providerInfo.get("driver_img"))"), placeholderImage: UIImage(named: "ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        
        providerImgView.borderColor = SColors.ThemeTxt
        providerImgView.borderWidth = 2.0
       
        self.setSepratorView(index: 0)
        
        providerRatingView.rating = GeneralFunctions.parseFloat(origValue: 0, data: self.providerInfo.get("average_rating"))
        self.ratingLbl.text = self.providerInfo.get("average_rating")
        GeneralFunctions.setImgTintColor(imgView: self.ratingImgView, color: UIColor(hex: 0xEFCE4A))
        viewProfileBtn.backgroundColor = SColors.Theme
        viewProfileBtn.textColor = SColors.ThemeTxt
        
        
        
        if(self.eForVideoConsultation.uppercased() != "YES"){
            
            if(self.providerInfo.get("tProfileDescription") == ""){
                viewProfileBtn.isHidden = true
                self.providerNameLblTopSpace.constant = 00
            }
            
            viewProfileBtn.text = generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIEW_PROFILE_DESCRIPTION")
            viewProfileBtn.handleClick { (instance) in
                self.openProviderDetail()
            }
        }
        
        self.topProfileView.backgroundColor = SColors.ThemeTxt
        self.buttonBarContainerView.alpha = 0
        self.topProfileView.alpha = 0
        self.buttonBarView.alpha = 0
        self.view.backgroundColor = UIColor.white
        
        
        if(self.eForVideoConsultation.uppercased() == "YES") {
        self.viewProfileBtn.isHidden = true
            self.viewProfileBtn.text = ""
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor =  SColors.ThemeTxt//UIColor(hex: 0xf1f1f1)
            self.buttonBarContainerView.alpha = 1
            self.topProfileView.alpha = 1
            self.buttonBarView.alpha = 1
            self.shadowOnview(view: self.topProfileView)
            
        }, completion:{ _ in})
        
        if(buttonBarView.selectedIndex == 0 && viewControllersArr != nil && viewControllersArr.count > 0){
            (viewControllersArr[0] as! UFXProviderServicesUV).viewDidAppear(true)
        }
        
        /* Online-Offline Imgview*/
        if(self.providerInfo.get("IS_PROVIDER_ONLINE").uppercased() == "YES"){
            GeneralFunctions.setImgTintColor(imgView: self.onlineIndicatorImgView, color: UIColor(hex: 0x009900))
        }else{
            GeneralFunctions.setImgTintColor(imgView: self.onlineIndicatorImgView, color: UIColor(hex: 0xcc0000))
        }
        
    }
    
    func hideShowProfileView(isHide:Bool){
        
        if(isHide){
            self.providerImgView.isHidden = true
            self.providerNameLbl.isHidden = true
            self.providerRatingView.isHidden = true
            self.viewProfileBtn.isHidden = true
            self.onlineIndicatorImgView.isHidden = true
            self.ratingLbl.isHidden = true
            self.ratingImgView.isHidden = true
        }else{
            self.providerImgView.isHidden = false
            self.providerNameLbl.isHidden = false
            self.providerRatingView.isHidden = true
            self.viewProfileBtn.isHidden = false
            self.onlineIndicatorImgView.isHidden = false
            self.ratingLbl.isHidden = false
            self.ratingImgView.isHidden = false
            if(self.providerInfo.get("tProfileDescription") == "" && self.eForVideoConsultation.uppercased() != "YES"){
                viewProfileBtn.isHidden = true
                self.providerNameLblTopSpace.constant = 00
            }
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let providerServicesUV = GeneralFunctions.instantiateViewController(pageName: "UFXProviderServicesUV") as! UFXProviderServicesUV
        providerServicesUV.providerInfoTabUV = self
        let providerGalleryUv = GeneralFunctions.instantiateViewController(pageName: "UFXProviderGalleryUV") as! UFXProviderGalleryUV
        providerGalleryUv.providerInfoTabUV = self
        let providerReviewsUv = GeneralFunctions.instantiateViewController(pageName: "UFXProviderReviewsUV") as! UFXProviderReviewsUV
        providerReviewsUv.providerInfoTabUV = self
        providerServicesUV.eForVideoConsultation = self.eForVideoConsultation
        providerServicesUV.ufxSelectedVehicleTypeId = self.ufxSelectedVehicleTypeId
        providerServicesUV.ufxSelectedVehicleTypeParentId = self.ufxSelectedVehicleTypeParentId
        
        providerServicesUV.providerInfo = self.providerInfo
        providerGalleryUv.providerInfo = self.providerInfo
        providerReviewsUv.providerInfo = self.providerInfo
        
        providerServicesUV.ufxSelectedLatitude = self.ufxSelectedLatitude
        providerServicesUV.ufxSelectedLongitude = self.ufxSelectedLongitude
        providerServicesUV.ufxSelectedAddress = self.ufxSelectedAddress
        
        var uvArr = [UIViewController]()
        
       // if(Configurations.isRTLMode() == true){
           // uvArr += [providerReviewsUv]
          //  uvArr += [providerGalleryUv]
          //  uvArr += [providerServicesUV]
       // }else{
            uvArr += [providerServicesUV]
            uvArr += [providerGalleryUv]
            uvArr += [providerReviewsUv]
       // }
        
        viewControllersArr = uvArr
        
        return uvArr
    }
    
    @objc func openProviderDetail(){
    
        let ufxProviderInfoUV = GeneralFunctions.instantiateViewController(pageName: "UFXProviderInfoUV") as! UFXProviderInfoUV
        ufxProviderInfoUV.driverData = providerInfo
        self.push(uv: ufxProviderInfoUV)
    
    }
    
    @objc func checkOutTapped(){
        
        let ufxcheckOut = GeneralFunctions.instantiateViewController(pageName: "UFXCheckOutUV") as! UFXCheckOutUV
        ufxcheckOut.providerInfo = self.providerInfo
        ufxcheckOut.eForVideoConsultation = self.eForVideoConsultation
        ufxcheckOut.currentLocation = self.currentLocation
        ufxcheckOut.providerInfoTabUV = self
        ufxcheckOut.mainScreenUV = self.mainScreenUV
        ufxcheckOut.ufxSelectedLatitude = self.ufxSelectedLatitude
        ufxcheckOut.ufxSelectedLongitude = self.ufxSelectedLongitude
        ufxcheckOut.ufxSelectedAddress = self.ufxSelectedAddress
        ufxcheckOut.ufxSelectedVehicleTypeId = self.ufxSelectedVehicleTypeId
       
        self.push(uv: ufxcheckOut)
    }
    
    func setBottomViewForVideo(){

        
        self.cartitemCountLbl.textColor = UIColor.black
        self.cartitemCountLbl.backgroundColor = UIColor.white
        
        self.cartView.isHidden = false
        view.layoutIfNeeded()
       // self.cartViewHeight.constant = Configurations.isIponeXDevice() == true ? 65 : 55
        self.cartViewBottom.constant = 0
        self.cartViewHeight.constant = 65
        if UIDevice().typeApp == .iPhone12Pro || UIDevice().typeApp == .iPhone12ProMax ||  UIDevice().typeApp == .iPhone12 ||  UIDevice().typeApp == .iPhone12Mini || UIDevice().typeApp == .iPhone11 || UIDevice().typeApp == .iPhone11Pro || UIDevice().typeApp == .iPhone11ProMax || Configurations.isIponeXDevice() == true {
            self.cartViewBottom.constant = 0
            self.cartViewHeight.constant = 65
        }else{
            self.cartViewBottom.constant = 0
            self.cartViewHeight.constant = 55
       }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.cartView.backgroundColor = SColors.Theme
        
        cartImgView.isHidden = true
        self.cartitemCountLbl.isHidden = true
        self.totalVLbl.isHidden = true
        self.checkOutHLbl.isHidden = true
        
        let lbl = UILabel.init(frame: self.cartView.bounds)
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lbl.textAlignment = .center
        lbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN")
        lbl.textColor = SColors.ThemeTxt
        
        self.cartView.addSubview(lbl)
        
        
    }
    
    
    func setupCartView(){
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "UFXCartData") == true){
            
            let array = GeneralFunctions.getValue(key: "UFXCartData") as! [NSDictionary]
            if(array.count > 0){
               
            
                if(checkOutTapGue == nil && self.eForVideoConsultation.uppercased() != "YES"){
                    checkOutTapGue = UITapGestureRecognizer()
                    checkOutTapGue.addTarget(self, action: #selector(self.checkOutTapped))
                    self.cartView.isUserInteractionEnabled = true
                    self.cartView.addGestureRecognizer(checkOutTapGue)
                }
                
                self.cartitemCountLbl.textColor = UIColor.black
                self.cartitemCountLbl.backgroundColor = UIColor.white
                
                self.cartView.isHidden = false
                view.layoutIfNeeded()
               // self.cartViewHeight.constant = Configurations.isIponeXDevice() == true ? 65 : 55
                self.cartViewBottom.constant = 0
                self.cartViewHeight.constant = 65
                if UIDevice().typeApp == .iPhone12Pro || UIDevice().typeApp == .iPhone12ProMax ||  UIDevice().typeApp == .iPhone12 ||  UIDevice().typeApp == .iPhone12Mini || UIDevice().typeApp == .iPhone11 || UIDevice().typeApp == .iPhone11Pro || UIDevice().typeApp == .iPhone11ProMax || Configurations.isIponeXDevice() == true {
                    self.cartViewBottom.constant = 0
                    self.cartViewHeight.constant = 65
                }else{
                    self.cartViewBottom.constant = 0
                    self.cartViewHeight.constant = 55
               }
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
                
                self.cartView.backgroundColor = SColors.Theme
                
                GeneralFunctions.setImgTintColor(imgView: cartImgView, color: UIColor.white)
                
                var totalFare = 0.0
                var totalItemcount = 0
                var currencySymbole = ""
                
                for i in 0..<array.count{
                    
                    let dataDicArray = array[i] as NSDictionary
                    let itemCount = dataDicArray.get("itemCount")
                    let finalTotal = dataDicArray.get("finalTotal")
                    currencySymbole = dataDicArray.dictOf("vehicleData").get("vSymbol")
                    
                    totalFare = totalFare + GeneralFunctions.parseDouble(origValue: 0.0, data: finalTotal)
                    totalItemcount = totalItemcount + GeneralFunctions.parseInt(origValue: 0, data: itemCount)
                }
                
                if totalFare > 0 {
                    self.totalVLbl.text = currencySymbole + " " + Configurations.convertNumToAppLocal(numStr: String(format: "%.02f", totalFare))
                    self.totalVLbl.text = GeneralFunctions().formateNoAsPerCurrency(dict: (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str), value: String(format: "%.02f", totalFare), addCurrncy: true, currencySymbol: currencySymbole)
                }else{
                    self.totalVLbl.text = "" 
                }
               
                
                self.cartitemCountLbl.text = Configurations.convertNumToAppLocal(numStr: String(totalItemcount)) 
                self.checkOutHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHECKOUT")
                
                if(self.eForVideoConsultation.uppercased() == "YES"){
                    self.checkOutTapped()
                }
            }else{
                
                if(self.eForVideoConsultation.uppercased() != "YES"){
                    self.cartViewHeight.constant = 0
                    self.cartView.isHidden = true
                }
                
            }
           
        }else{
            
            if(self.eForVideoConsultation.uppercased() != "YES"){
                self.cartViewHeight.constant = 0
                self.cartView.isHidden = true
            }
            
        }
    }
    
    @objc func searchTapped(){
        let ufxSearch = GeneralFunctions.instantiateViewController(pageName: "UFXServiceSearchUV") as! UFXServiceSearchUV
        ufxSearch.ufxSelectedLatitude = self.ufxSelectedLatitude
        ufxSearch.ufxSelectedLongitude = self.ufxSelectedLongitude
        ufxSearch.ufxSelectedAddress = self.ufxSelectedAddress
        ufxSearch.providerInfo = self.providerInfo
        ufxSearch.ufxSelectedVehicleTypeId = self.ufxSelectedVehicleTypeId
        ufxSearch.ufxSelectedVehicleTypeParentId = self.ufxSelectedVehicleTypeParentId
        self.push(uv: ufxSearch)
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    func setSepratorView(index : Int)   {
        
        for tempView in sepratorStackView.subviews{
            if tempView.tag == index {
                tempView.backgroundColor = SColors.Theme
            }else{
                tempView.backgroundColor = UIColor(hex: 0xf6f6f6)
            }
        }
    }
}
