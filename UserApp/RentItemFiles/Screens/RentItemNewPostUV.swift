
//
//  RentItemNewPostUV.swift
//  UserApp
//
//  Created by # Admin on 17/10/22.
//

import UIKit
import SysBaseLib
import GoogleMaps
import AdvancedPageControl

class RentItemNewPostUV: ParentViewUV,ParentViewUVDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MyTxtFieldOnTextChangeDelegate , MyTxtFieldClickDelegate ,UITableViewDelegate, UITableViewDataSource,UITextViewDelegate,DTCalendarActionDelegate,iCarouselDataSource, iCarouselDelegate {
    
    
    
    
    
    
    // general Outlet
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var categoryTitleView: UIView!
    @IBOutlet weak var stepperCollectionView: UICollectionView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var categoryTitleLbl: MyLabel!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewPrivious: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var priviousImageView: UIImageView!
    @IBOutlet weak var stepCounterLbl: MyLabel!
    
    
    @IBOutlet weak var viewNextWidth: NSLayoutConstraint!
    @IBOutlet weak var lblPublish: MyLabel!
    @IBOutlet weak var bottomViewHight: NSLayoutConstraint!
    
    
    // All STEP1 Outlet
    @IBOutlet weak var step1MainView: UIView!
    @IBOutlet weak var step1CategoryCollectionView: UICollectionView!
    // All STEP2 OutLet
    @IBOutlet weak var step2SubCategoryMainView: UIView!
    @IBOutlet weak var step2SubvategoryTblView: UITableView!
    //  All STEP3 OutLet
    @IBOutlet weak var step3ItemDescriptionMainView: UIView!
    @IBOutlet weak var step3ItemDescriptionScrollView: UIScrollView!
    @IBOutlet weak var step3ItemDescriptionContentView: UIView!
    @IBOutlet weak var step3TtileLbl: MyLabel!
    @IBOutlet weak var step3IteemDescriptionTextView: KMPlaceholderTextView!
    @IBOutlet weak var step3DataContainerView: UIView!
    
    @IBOutlet weak var step3DataHight: NSLayoutConstraint!
    // All STEP4 OutLet
    @IBOutlet weak var step4PhotosMainView: UIView!
    @IBOutlet weak var step4PhotosCollectionView: UICollectionView!
    // All STEP5 OutLet
    
    @IBOutlet weak var step5LocationCheckBox: BEMCheckBox!
    @IBOutlet weak var stepp5LocationSecureLbl: MyLabel!
    @IBOutlet weak var step5LocationDetailsMainView: UIView!
    @IBOutlet weak var step5SelectLocationView: UIView!
    @IBOutlet weak var step5SelectLocationTitleLbl: MyLabel!
    @IBOutlet weak var step5SelectLocationTxtFiled: MyTextField!
    @IBOutlet weak var step5HouseNoView: UIView!
    @IBOutlet weak var step5HouseNoTtitleLbl: MyLabel!
    @IBOutlet weak var step5HouseNoTxtFiled: MyTextField!
    @IBOutlet weak var step5AdressView: UIView!
    @IBOutlet weak var step5AdressTtileLbl: MyLabel!
    @IBOutlet weak var step5AdressTextView: KMPlaceholderTextView!
    
    @IBOutlet weak var step5MainContainerView: UIView!
    // All STEP6 OutLet
    
    @IBOutlet weak var step6PerLbl: MyLabel!
    @IBOutlet weak var step6PricingStructureMainView: UIView!
    @IBOutlet weak var step6priceViewWidht: NSLayoutConstraint!
    @IBOutlet weak var step6AmountView: UIView!
    @IBOutlet weak var step6AmountTitleLbl: MyLabel!
    @IBOutlet weak var step6AmountTxtFiled: MyTextField!
    @IBOutlet weak var step6DurationView: UIView!
    @IBOutlet weak var step6DurationTitleLbl: MyLabel!
    @IBOutlet weak var step6DurationTextFiled: MyTextField!
    @IBOutlet weak var step6DurationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var step6AmountNoteLbl: MyLabel!
    @IBOutlet weak var step6MainContentView: UIView!
    @IBOutlet weak var step6AmuntLbl: MyLabel!
    
    @IBOutlet weak var step6PriceRequiredSymbolLbl: MyLabel!
    @IBOutlet weak var step6BgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var step6CurrencyView: UIView!
    // All STEP7 OutLet
    @IBOutlet weak var step7PickUPAvalibilityMainView: UIView!
    @IBOutlet weak var step7DateView: UIView!
    @IBOutlet weak var step7DateTxtFiled: MyTextField!
    @IBOutlet weak var step7DateTitleLbl: MyLabel!
    @IBOutlet weak var step7TimeView: UIView!
    @IBOutlet weak var step7TimeTxtFiled: MyTextField!
    @IBOutlet weak var step7TimeTitleLbl: MyLabel!
    @IBOutlet weak var step7CheckBox: BEMCheckBox!
    @IBOutlet weak var step7SecureNoLbl: MyLabel!
    @IBOutlet weak var step7ScrollView: UIScrollView!
    @IBOutlet weak var monSlot1Vw: UIView!
    @IBOutlet weak var monTitleLbl: MyLabel!
    @IBOutlet weak var monRequiredLbl: MyLabel!
    @IBOutlet weak var monSlot1ToLbl: MyLabel!
    @IBOutlet weak var monSlot1FromVw: UIView!
    @IBOutlet weak var monSlot1ToVw: UIView!
    @IBOutlet weak var monSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var monSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var tueSlot1Vw: UIView!
    @IBOutlet weak var tueTitleLbl: MyLabel!
    @IBOutlet weak var tueRequiredLbl: MyLabel!
    @IBOutlet weak var tueSlot1ToLbl: MyLabel!
    @IBOutlet weak var tueSlot1FromVw: UIView!
    @IBOutlet weak var tueSlot1ToVw: UIView!
    @IBOutlet weak var tueSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var tueSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var wedSlot1Vw: UIView!
    @IBOutlet weak var wedTitleLbl: MyLabel!
    @IBOutlet weak var wedRequiredLbl: MyLabel!
    @IBOutlet weak var wedSlot1ToLbl: MyLabel!
    @IBOutlet weak var wedSlot1FromVw: UIView!
    @IBOutlet weak var wedSlot1ToVw: UIView!
    @IBOutlet weak var wedSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var wedSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var thuSlot1Vw: UIView!
    @IBOutlet weak var thuTitleLbl: MyLabel!
    @IBOutlet weak var thuRequiredLbl: MyLabel!
    @IBOutlet weak var thuSlot1ToLbl: MyLabel!
    @IBOutlet weak var thuSlot1FromVw: UIView!
    @IBOutlet weak var thuSlot1ToVw: UIView!
    @IBOutlet weak var thuSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var thuSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var friSlot1Vw: UIView!
    @IBOutlet weak var friTitleLbl: MyLabel!
    @IBOutlet weak var friRequiredLbl: MyLabel!
    @IBOutlet weak var friSlot1ToLbl: MyLabel!
    @IBOutlet weak var friSlot1FromVw: UIView!
    @IBOutlet weak var friSlot1ToVw: UIView!
    @IBOutlet weak var friSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var friSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var satSlot1Vw: UIView!
    @IBOutlet weak var satSlot1TitleLbl: MyLabel!
    @IBOutlet weak var satSlot1RequiredLbl: MyLabel!
    @IBOutlet weak var satSlot1ToLbl: MyLabel!
    @IBOutlet weak var satSlot1FromVw: UIView!
    @IBOutlet weak var satSlot1ToVw: UIView!
    @IBOutlet weak var satSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var satSlot1ToTimeLbl: MyLabel!
    
    @IBOutlet weak var step7ViewHight: NSLayoutConstraint!
    @IBOutlet weak var sunSlot1Vw: UIView!
    @IBOutlet weak var sunSlot1TitleLbl: MyLabel!
    @IBOutlet weak var sunSlot1RequiredLbl: MyLabel!
    @IBOutlet weak var sunSlot1ToLbl: MyLabel!
    @IBOutlet weak var sunSlot1FromVw: UIView!
    @IBOutlet weak var sunSlot1ToVw: UIView!
    @IBOutlet weak var sunSlot1fromTimeLbl: MyLabel!
    @IBOutlet weak var sunSlot1ToTimeLbl: MyLabel!
    @IBOutlet weak var lblNote: MyLabel!
    @IBOutlet weak var t1ImgView: UIImageView!
    @IBOutlet weak var t1ImgView1: UIImageView!
    @IBOutlet weak var t2ImgView: UIImageView!
    @IBOutlet weak var t2ImgView1: UIImageView!
    @IBOutlet weak var t3ImgView: UIImageView!
    @IBOutlet weak var t3ImgView1: UIImageView!
    @IBOutlet weak var t4ImgView: UIImageView!
    @IBOutlet weak var t4ImgView1: UIImageView!
    @IBOutlet weak var t5ImgView: UIImageView!
    @IBOutlet weak var t5ImgView1: UIImageView!
    @IBOutlet weak var t6ImgView: UIImageView!
    @IBOutlet weak var t6ImgView1: UIImageView!
    @IBOutlet weak var t7ImgView: UIImageView!
    @IBOutlet weak var t7ImgView1: UIImageView!
    @IBOutlet weak var step7TimeContainerView: UIView!
    
    
    
    
    // All STEP8 OutLet
    
    
    @IBOutlet weak var step8ReviewMainView: UIView!
    @IBOutlet weak var step8Scrollview: UIScrollView!
    @IBOutlet weak var step8nameLbl: MyLabel!
    @IBOutlet weak var step8conditionLbl: MyLabel!
    @IBOutlet weak var step8priceLbl: MyLabel!
    @IBOutlet weak var step8addLbl: MyLabel!
    @IBOutlet weak var step8updatedByLbl: MyLabel!
    @IBOutlet weak var step8descriptionLbl: MyLabel!
    @IBOutlet weak var step8anchorView: UIView!
    @IBOutlet weak var step8detailsView: UIView!
    
    @IBOutlet weak var step8SelctedCategoryLblContainerView: UIView!
    @IBOutlet weak var step8CatSubLbl: MyLabel!
    @IBOutlet weak var step8SelectedCategoryAnchorSubView: UIView!
    @IBOutlet weak var step8SelectedCategoryAnchorView: UIView!
    @IBOutlet weak var step8SelectedCategoryLbl: MyLabel!
    @IBOutlet weak var step8SelectedCategoryView: UIView!
    @IBOutlet weak var step8GmapContainerView: UIView!
    @IBOutlet weak var step8PhotosTop: NSLayoutConstraint!
    @IBOutlet weak var step8DurationLbl: MyLabel!
    @IBOutlet weak var step8MainDetialsViewHight: NSLayoutConstraint!
    @IBOutlet weak var step8anchorSubView: UIView!
    @IBOutlet weak var step8detailsLbl: MyLabel!
    @IBOutlet weak var step8detailsMainView: UIView!
    @IBOutlet weak var step8locationView: UIView!
    @IBOutlet weak var step8locationAnchorView: UIView!
    @IBOutlet weak var step8locationHLbl: MyLabel!
    @IBOutlet weak var step8locationLbl: MyLabel!
    @IBOutlet weak var step8locationAnchorSubView: UIView!
    @IBOutlet weak var step8gMap: GMSMapView!
    @IBOutlet weak var step8PhotosView: UIView!
    @IBOutlet weak var step8PhotosAnchorView: UIView!
    @IBOutlet weak var step8PhotosSubAnchorView: UIView!
    @IBOutlet weak var step8PhotosLbl: MyLabel!
    @IBOutlet weak var step8ImgSlider: iCarousel!
    @IBOutlet weak var step8ImageSliderHight: NSLayoutConstraint!
    @IBOutlet weak var step8PickUpView: UIView!
    @IBOutlet weak var step8PickUpAnchorView: UIView!
    @IBOutlet weak var step8ScrContentViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var step8GmapImgView: UIImageView!
    @IBOutlet weak var step8DirectionImgView: UIImageView!
    @IBOutlet weak var step8DirectionView: UIView!
    @IBOutlet weak var step8PickUpAvalibiltyHight: NSLayoutConstraint!
    @IBOutlet weak var step8PickUpAnchorSubView: UIView!
    
    @IBOutlet weak var step8PickUpLbl: MyLabel!
    @IBOutlet weak var step8DateViewHight: NSLayoutConstraint!
    @IBOutlet weak var step8PickUpSubViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var step8PageControllerWidth: NSLayoutConstraint!
    @IBOutlet weak var step8PageController: AdvancedPageControlView!
    @IBOutlet weak var step8PickUpSubView: UIView!
    @IBOutlet weak var step8PickUpviewHight: NSLayoutConstraint!
    @IBOutlet weak var step8PaymentAnchorView: UIView!
    @IBOutlet weak var step8PaymentPlanView: UIView!
    @IBOutlet weak var step8PaymentAnchorSubView: UIView!
    @IBOutlet weak var step8PaymentLbl: MyLabel!
    @IBOutlet weak var step8PaymentView: UIView!
    @IBOutlet weak var step8CategoryViewTop: NSLayoutConstraint!
    @IBOutlet weak var step8CategoryView: UIView!
    @IBOutlet weak var step8PaymentDisTop: NSLayoutConstraint!
    @IBOutlet weak var step8PaymenTitileLblHight: NSLayoutConstraint!
    @IBOutlet weak var step8PayMentViewHight: NSLayoutConstraint!
    @IBOutlet weak var step8PayMentDisLbl: MyLabel!
    @IBOutlet weak var step8PaymentTitleLbl: MyLabel!
    @IBOutlet weak var step8descriptioHLbl: MyLabel!
    @IBOutlet weak var step8descriptionDLbl: MyLabel!
    @IBOutlet weak var step8descriptionView: UIView!
    @IBOutlet weak var step8DescView: UIView!

    @IBOutlet weak var step8DetailsViewTop: NSLayoutConstraint!
    @IBOutlet weak var step8MediaCollectionView: UICollectionView!

    
    
    
    // All STEP9 OutLet
    @IBOutlet weak var step9PaymentPlanMainView: UIView!
   
    @IBOutlet weak var step9PayemntView: UIView!
    @IBOutlet weak var step9TblHight: NSLayoutConstraint!
    // @IBOutlet weak var step9MainViewHight: NSLayoutConstraint!
    @IBOutlet weak var step9ScrollView: UIScrollView!
    
    @IBOutlet weak var step9TblView: UITableView!
    
    var pickUpPinMarker:GMSMarker!
    var userProfileJson:NSDictionary!
    var cntView:UIView!
    var selectedCategoryIndex = -1
    var selectedSubCategoryIndex = -1
    var viewCurrenIndex = 0
    var mainRentCatData = [NSDictionary] ()
    var subCatData = [NSDictionary] ()
    var photosArray = [NSDictionary] ()
    var paymentPlanArray = [NSDictionary] ()
    var currentStep = 0
    var steeperArray = ["Step 1" ,"Step 2", "Step 3", "Step 4" , "Step 5" , "Step 6" , "Step 7" , "Step 8"]
    let generalFunc = GeneralFunctions()
    var isVideo = false
    var rentCatId = ""
    var rentsubCatId = ""
    var selectdPaymentId = "."
    var selectdPaymentIndex = -1
    var rightButton: UIBarButtonItem!
    var loaderView:UIView!
    var selectedDuration = ""
    var isLoadFirstTime = false
    var isLoadFirstTimeStep3 = false
    var fieldObjArray = [[String : Any]]()
    var curentSelectedDate = Date()
    var selectedToDate = ""
    var tempIdentifier = "en"
    var bannersItemList = [String]()
    var selectedLat = ""
    var selectedLong = ""
    var postID = ""
    var TempID = ""
    var itemInfoArray = [NSMutableDictionary]()
    var reviewData:NSDictionary!
    var photosReview = [NSDictionary] ()
    var isFree = ""
    var eType = ""
    var isFromMYList = false
    var editData:NSDictionary!
    var timeSlot = [NSDictionary] ()
    var finalStrTerms:NSMutableAttributedString!
    var vFromMonTimeSlot1 = "00:00"
    var vToMonTimeSlot1 = "00:00"
    var vFromTueTimeSlot1 = "00:00"
    var vToTueTimeSlot1 = "00:00"
    var vFromWedTimeSlot1 = "00:00"
    var vToWedTimeSlot1 = "00:00"
    var vFromThuTimeSlot1 = "00:00"
    var vToThuTimeSlot1 = "00:00"
    var vFromFriTimeSlot1 = "00:00"
    var vToFriTimeSlot1 = "00:00"
    var vFromSatTimeSlot1 = "00:00"
    var vToSatTimeSlot1 = "00:00"
    var vFromSunTimeSlot1 = "00:00"
    var vToSunTimeSlot1 = "00:00"
    var isTimeSlotValidate = false
    var isTimeLoad = false
    var itemDic = [NSDictionary] ()
    var isLoadStep8 = false
    var isSubCatHide = false
    var tempStep3Id = ""
    var isFromHome = false
    var isRent = true
    var locationSwitch = true
    var secureNoSwitch = true
    var isBackStep = false
    var firstTwoStepsHide = false
    var isPickUpAvalibiltyHide = false
    var pickUpConfiguration = ""
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: self.tempIdentifier)
        formatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
    }()
    
    fileprivate lazy var dateFormatterForAPI: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    public var openImgSelection:OpenFileSelector!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        if(type == 0){
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            cntView = self.generalFunc.loadView(nibName: "RentItemNewPostScreenDesign", uv: self, contentView: contentView)
            self.openImgSelection = OpenFileSelector(uv: self)
            self.contentView.addSubview(cntView)
            self.stepperCollectionView.register(UINib(nibName: "RentSteeperCVCell", bundle: nil), forCellWithReuseIdentifier: "RentSteeperCVCell")
           
            
            if GeneralFunctions.getSafeAreaInsets().bottom != 0 {
                self.bottomViewHight.constant = 70
            }else{
                self.bottomViewHight.constant = 60
            }
            
            
            if self.eType == "RentEstate" || self.eType == "RentCars" {
               
                if editData != nil  {
                    self.firstTwoStepsHide = true
                    if self.editData.get("eStatusOrg") != "Expired" {
                        self.steeperArray.remove(at: 0)
                        self.steeperArray.remove(at: 1)
                        self.steeperArray.remove(at: 2)
                    }else{
                        self.steeperArray.remove(at: 0)
                        self.steeperArray.remove(at: 1)
                        
                    }
                    
                }else{
                self.isSubCatHide = true
                self.steeperArray = ["Step 1" ,"Step 2", "Step 3", "Step 4" , "Step 5" ,"Step 7" , "Step 8" ]
                }
            }else{
                if editData != nil  {
                    self.firstTwoStepsHide = true
                    if self.editData.get("eStatusOrg") != "Expired" {
                        self.steeperArray.remove(at: 0)
                        self.steeperArray.remove(at: 1)
                        self.steeperArray.remove(at: 2)
                    }else{
                        self.steeperArray.remove(at: 0)
                        self.steeperArray.remove(at: 1)
                        
                    }
                    
                   
                }
            }
            self.stepperCollectionView.delegate = self
            self.stepperCollectionView.dataSource = self
            stepperCollectionView!.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
            self.stepperCollectionView.isScrollEnabled = false
            self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
            self.anchorSubView.backgroundColor = SColors.Theme
            
            if editData != nil {
                isTimeSlotValidate = true
            }
            self.setBottomButton()
            self.deleteImages()
            self.setSteps()
            self.step9TblView.delegate = self
            self.step9TblView.dataSource = self
            self.step9TblView.allowsSelection = true
        }else if (type == 1) {
            if(Configurations.isRTLMode()){
                self.categoryTitleLbl.textAlignment = .right
            }
            self.configRTL()
//            self.categoryTitleView.shadowOffset = CGSize(width: 0.5, height: 0.5)
//            self.categoryTitleView.shadowColor = UIColor.lightGray
//            self.categoryTitleView.shadowRadius = 2
//            self.categoryTitleView.shadowOpacity = 1.0
            //self.shadowOnview(view: self.categoryTitleView)
            self.addBack()
        }else if(type == 4){
            
        }
    }
    // Set navigation bar and title
    func setNavigationBar(title : String) {
        if editData != nil {
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Edit Post", key: "LBL_RENT_EDIT_POST")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "Edit Post", key: "LBL_RENT_EDIT_POST")
        }else{
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "New Post", key: "LBL_RENT_NEW_POST")//title
            self.title = self.generalFunc.getLanguageLabel(origValue: "New Post", key: "LBL_RENT_NEW_POST")
        }
        
        let rightButtonItem = UIBarButtonItem.init(
            title: self.generalFunc.getLanguageLabel(origValue: "Step", key: "LBL_STEP_TXT") + " " + String(self.currentStep + 1) + "/" + String(self.steeperArray.count),
            style: .done,
            target: self,
            action: nil
        )
        self.stepCounterLbl.text = self.generalFunc.getLanguageLabel(origValue: "Step", key: "LBL_STEP_TXT") + " " + String(self.currentStep + 1) + "/" + String(self.steeperArray.count)
        self.stepCounterLbl.textColor = SColors.ThemeTxt
        self.navigationItem.rightBarButtonItem = nil
    }
    
    // set Bottom buttons next/Priviuos and handle clicks
    func setBottomButton() {
        
       // Utils.createRoundedView(view: viewPrivious, borderColor: .clear, borderWidth: 0)
        
        
        viewPrivious.backgroundColor = SColors.ThemeTxt
        viewNext.backgroundColor = SColors.ThemeTxt
        viewBottom.backgroundColor = SColors.Theme
        
        self.viewPrivious.handleClick { (view) in
            self.isBackStep = true
            self.currentStep -= 1
            self.setSteps()
            self.viewNextWidth.constant = 40
            self.nextImageView.isHidden = false
            self.lblPublish.isHidden = true
            self.nextImageView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 0, y: 0)
            GeneralFunctions.setImgTintColor(imgView: self.nextImageView, color: UIColor(hex: 0x1B2A3B))
        }
        
       
        self.viewNext.handleClick { (view) in
            self.isBackStep = false
            if  !self.validateData() {return}
            if self.steeperArray.count - 1 == self.currentStep {
                if self.editData == nil  {
                    self.finalPayment()
                }
                else if self.editData != nil &&  self.editData.get("eStatusOrg") == "Expired" {
                    self.finalPayment()
                }
                else if  self.editData != nil && self.editData.get("eStatusOrg") == "Pending"{
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.currentStep += 1
            if self.steeperArray.count - 1 == self.currentStep {
                self.nextImageView.isHidden = true
                self.lblPublish.isHidden = false
                self.lblPublish.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PUBLISH_POST_TXT")
                self.viewNextWidth.constant = 100
                self.nextImageView.image = UIImage(named: "ic_new_correct")?.addImagePadding(x: 0, y: 0)
                GeneralFunctions.setImgTintColor(imgView: self.nextImageView, color: UIColor(hex: 0x1B2A3B))
                
            }
            self.setSteps()
        }
        
        self.viewNextWidth.constant = 40
        self.nextImageView.isHidden = false
        self.lblPublish.isHidden = true
        self.nextImageView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 0, y: 0)
        self.priviousImageView.image = UIImage(named: "ic_new_right_arrow")?.addImagePadding(x: 0, y: 0)
        GeneralFunctions.setImgTintColor(imgView: self.nextImageView, color: UIColor(hex: 0x1B2A3B))
        self.viewPrivious.cornerRadius = 5
        self.viewNext.cornerRadius = 5
        if(Configurations.isRTLMode()){
            self.nextImageView.image = nextImageView.image?.rotate(180)
            GeneralFunctions.setImgTintColor(imgView: self.nextImageView, color: UIColor(hex: 0x1B2A3B))
            
        }else{
            self.priviousImageView.image = priviousImageView.image?.rotate(180)
            GeneralFunctions.setImgTintColor(imgView: self.priviousImageView, color: UIColor(hex: 0x1B2A3B))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.stepperCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentSteeperCVCell", for: indexPath) as! RentSteeperCVCell
            if indexPath.item == self.steeperArray.count - 1 {
                cell.jointView.isHidden = true
                
            }else{
                cell.jointView.isHidden = false
                
            }
            
            cell.countLbl.text = Configurations.convertNumToAppLocal(numStr: String(indexPath.item + 1))
            
            cell.stepLbl.text =  self.generalFunc.getLanguageLabel(origValue: "Step", key: "LBL_STEP_TXT") + " " + Configurations.convertNumToAppLocal(numStr: String(indexPath.item + 1))
            cell.statusView.layer.masksToBounds = true
            cell.statusView.layer.cornerRadius =  cell.statusView.bounds.width / 2
            cell.statusView.layer.borderColor = SColors.Theme.cgColor
            cell.statusView.tag = indexPath.item
            
            if indexPath.item <=  self.currentStep{
                cell.statusView.backgroundColor = SColors.Theme
                cell.stepLbl.textColor = SColors.Theme
                cell.countLbl.textColor = SColors.ThemeTxt
            }else{
                cell.countLbl.textColor = UIColor(hex: 0xA7A7A7)
                cell.statusView.backgroundColor = UIColor(hex: 0xD4D2D3)
                cell.stepLbl.textColor = UIColor.lightGray
            }
            if indexPath.item <  self.currentStep{
                cell.jointView.backgroundColor = SColors.Theme
                cell.stepImageView.isHidden = false
                cell.countLbl.isHidden = true
            }else{
                cell.jointView.backgroundColor = UIColor.lightGray
                cell.stepImageView.isHidden = true
                cell.countLbl.isHidden = false
            }
            cell.statusView.handleClick { (view) in
                
                
                
            }
            return cell
        }else if collectionView == step4PhotosCollectionView {
           
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCVC", for: indexPath) as! UploadImageCVC
//                cell.galleryImgView.image = UIImage(named:"ic_upload")
//                cell.deleteViewArea.isHidden = true
//                cell.checkImgView.isHidden = true
                self.shadowOnview(view: cell.mainView)
                cell.selectImageLbl.text = self.generalFunc.getLanguageLabel(origValue: "choose file", key: "LBL_CHOOSE_FILE")
               
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                        cell.mainSubView.createDashedBorderForWholeView()
                    })
                
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepPhotosCVCell", for: indexPath) as! StepPhotosCVCell
                let item = self.photosArray[indexPath.item]
                
                let width = (self.step4PhotosCollectionView.frame.size.width / 2) - 25
                GeneralFunctions.setImgTintColor(imgView: cell.deleteImgBGView, color: SColors.Theme)
                GeneralFunctions.setImgTintColor(imgView: cell.deleteImgView, color: SColors.ThemeTxt)
                var imageKey = "vImage"
                var title = self.generalFunc.getLanguageLabel(origValue: "Are you sure you want to delete this image?", key: "LBL_DELETE_IMG_CONFIRM_MSG")
                if item.get("eFileType") == "Image" {
                    cell.checkImgView.isHidden = true
                    imageKey = "vImage"
                    title = self.generalFunc.getLanguageLabel(origValue: "Are you sure you want to delete this image?", key: "LBL_DELETE_IMG_CONFIRM_MSG")
                }else{
                    cell.checkImgView.isHidden = false
                    imageKey = "ThumbImage"
                    title = self.generalFunc.getLanguageLabel(origValue: "Are you sure you want to delete this video?", key: "LBL_DELETE_VIDEO_CONFIRM_MSG")
                }
                
                
                cell.galleryImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get(imageKey), width: Int(width), height:Int(width))), placeholderImage: UIImage(named: "ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                    cell.deleteViewArea.isHidden = false
                    cell.deleteViewArea.tag = indexPath.item
                    cell.deleteViewArea.handleClick(clickHandler: { (instance) in
                        
                        self.deleteImage(strTitle:title , index: instance.tag)
                        
                        
                    })
                })
                if(Configurations.isRTLMode()){
                    cell.deleteViewArea.transform = CGAffineTransform(scaleX: -1, y: 1)
                }
                cell.contentView.layer.cornerRadius = 10
                cell.contentView.layer.masksToBounds = true
                self.shadowOnview(view: cell.galleryImgView)
                return cell
            }
            
        
            
        }else if collectionView == step1CategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentIconCVC", for: indexPath) as! RentIconCVC
            var item:NSDictionary!
            item = mainRentCatData[indexPath.row]
            
            cell.imageCenter.constant = -20
            cell.bgViewHight.constant = 50
            cell.bgViewWidhth.constant = 50
            var key = ""
            if(selectedCategoryIndex == indexPath.item){
                cell.viewContent.layer.borderWidth = 1
                cell.viewContent.layer.borderColor =  SColors.Theme.cgColor
                cell.categoryLbl.textColor = SColors.ThemeTxt
                cell.viewContent.backgroundColor =  SColors.Theme
                
                key = "vImage1"
            }else{
                cell.viewContent.layer.borderWidth = 00
                cell.viewContent.layer.borderColor =  UIColor.clear.cgColor
                cell.categoryLbl.textColor = SColors.blackColor
                cell.viewContent.backgroundColor = UIColor.white
                key = "vImage"
            }
            
            self.shadowOnview(view: cell.viewContent)
            
            let vImage = Utils.getResizeImgURL(imgUrl: item.get(key), width: Utils.getValueInPixel(value: 50), height: Utils.getValueInPixel(value: 50))
            cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
               
            })
            
            
            
            cell.bgView.backgroundColor = UIColor.clear
            cell.categoryLbl.text = item.get("vTitle")
            if(item.get("vTitle").contains(find: " ")){
                cell.categoryLbl.numberOfLines = 2
            }else{
                cell.categoryLbl.numberOfLines = 1
            }
            
            cell.backgroundColor = UIColor.clear
            return cell
        } else if collectionView == step8MediaCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentMediaIconCell", for: indexPath) as! RentMediaIconCell
            let item = photosReview[indexPath.row]
            
            if item.get("eFileType").uppercased() != "IMAGE" {
                cell.imgMedia.sd_setImage(with: URL(string: item.get("ThumbImage")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                })
                cell.imgPlay.image = UIImage.init(named: "ic_play_new")
                
            } else {
                cell.imgMedia.sd_setImage(with: URL(string: item.get("vImage")), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                })
            }
            self.shadowOnview(view: cell.viewBg)
            cell.viewBg.layer.cornerRadius = 16
            cell.imgMedia.layer.cornerRadius = 16
            return cell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.step1CategoryCollectionView {
            if selectedCategoryIndex != indexPath.row
            {
                self.rentsubCatId = ""
                self.selectedSubCategoryIndex  = -1
                isLoadFirstTimeStep3 = false
            }
            selectedCategoryIndex = indexPath.row
            self.step1CategoryCollectionView.reloadData()
            self.subCatData = mainRentCatData[indexPath.row].arrOf("SubCategory") as! [NSDictionary]
            self.rentCatId = mainRentCatData[indexPath.row].get("iCategoryId")
            //if !isFromHome{
                currentStep = 1
                self.setSteps()
           // }
            // currentStep = 1
            //self.setSteps()
        }
        if collectionView == step4PhotosCollectionView {
            if indexPath.item == 0 {
                self.openImgSelection.isFromStepPhotos = true
                self.openImgSelection.show(type: .ImageFileType) { (isImageUpload) in
                    
                    if(isImageUpload){
                        
                        self.isVideo = self.openImgSelection.isVideo
                        self.openImgSelection.closeSlectionView()
                        
                        self.handlesImages(selectedFileData: self.openImgSelection.selectedFileData, actionType: "Add", iImageId: "")
                        
                    }
                    
                }
            }else {
                if let url = URL(string: photosArray[indexPath.row].get("vImage")) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
        if collectionView == step8MediaCollectionView {
            let item = photosReview[indexPath.row]
            if item.get("eFileType").uppercased() != "IMAGE" {
                if let url = URL(string: item.get("vImage")) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.stepperCollectionView {
            return  steeperArray.count
        }else if collectionView == self.step1CategoryCollectionView{
            return self.mainRentCatData.count
        }else if collectionView == step8MediaCollectionView {
            return self.photosReview.count
        }
        else{
            if self.photosArray.count == 0 {
                return 1
            }
            return self.photosArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.stepperCollectionView {
            if indexPath.item == self.steeperArray.count - 1 { 
                return CGSize(width: 80  , height: 100)
            }
            return CGSize(width: (self.stepperCollectionView.frame.size.width / 3) + 20  , height: 100)
        }else if collectionView == self.step1CategoryCollectionView {
            return CGSize(width: (Application.screenSize.width / 3) - 20, height: 140)
        }else if collectionView == step8MediaCollectionView {
            if photosReview.count > 2 {
                let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (step8MediaCollectionView.frame.size.width - space) / 2.3
                let height:CGFloat = size
                return CGSize(width: size, height: height)
            } else {
                let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (step8MediaCollectionView.frame.size.width - space) / 2.0
                let height:CGFloat = size
                return CGSize(width: size, height: height)
            }
        }else{
            if indexPath.item == 0 {
                return CGSize(width: self.step4PhotosCollectionView.frame.size.width - 25  , height: 200)
            }else{
            return CGSize(width: (self.step4PhotosCollectionView.frame.size.width / 2) - 25  , height: (self.stepperCollectionView.frame.size.width / 2) - 30)
            }
        }
    }
    func setStepperCollectionScroll()  {
        self.stepperCollectionView.reloadData()
        self.stepperCollectionView.isScrollEnabled = true
        
        self.stepperCollectionView.scrollToItem(at:IndexPath(item: self.currentStep, section: 0), at: .centeredHorizontally, animated: true)
        self.stepperCollectionView.isScrollEnabled = false
    }
    // All Step 1 to 9  Data handelFrom here
    func setStep1mainCategory()  {
        self.hideShowSteps(passedView: step1MainView)
        self.step1CategoryCollectionView.register(UINib(nibName: "RentIconCVC", bundle: nil), forCellWithReuseIdentifier: "RentIconCVC")
        self.step1CategoryCollectionView.delegate = self
        self.step1CategoryCollectionView.dataSource = self
        step1CategoryCollectionView!.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        if eType == "RentEstate" {
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select Property Type", key: "LBL_RENT_ESTATE_PROPERTY_TYPE")
        } else if eType == "RentCars"
        {
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select Car Type", key: "LBL_RENT_SELECT_CAR_TYPE")
        }else{
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select a category", key: "LBL_RENT_SELECT_CATEGORY")
        }
        self.setNavigationBar(title: "")
        if self.mainRentCatData.count == 0 {
            self.loadRentCategory()
        }
       
    }
    func setStep2SubCategory()  {
        self.step2SubvategoryTblView.register(UINib(nibName: "RentSubCatTVCell", bundle: nil), forCellReuseIdentifier: "RentSubCatTVCell")
        self.step2SubvategoryTblView.dataSource = self
        self.step2SubvategoryTblView.delegate = self
        self.step2SubvategoryTblView.reloadData()
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select  subCategory", key: "LBL_RENT_SELECT_SUB_CATEGORY")
        self.hideShowSteps(passedView: step2SubCategoryMainView)
        self.setNavigationBar(title: "")
    }
    func setStep3ItemDetails()  {
        
        self.hideShowSteps(passedView: step3ItemDescriptionMainView)
        self.shadowOnview(view: step3ItemDescriptionScrollView)
//        self.step3TtileLbl.text = self.generalFunc.getLanguageLabel(origValue: "Item information", key: "LBL_RENT_ITEM_INFORMMATION")
//        self.step3IteemDescriptionTextView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Discribe the item", key: "LBL_RENT_DISCRIBE_ITEM")
        if eType == "RentEstate" {
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Property Details", key: "LBL_RENT_PROPERTY_DETAIL")
        }else if eType == "RentCars"{
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RENT_CAR_DETAILS")
        }
        else{
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Item details", key: "LBL_RENT_ITEM_DETAILS")
        }
       
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Item details", key: "LBL_RENT_ITEM_DETAILS"))
        if !isLoadFirstTimeStep3 {
        self.getFormDetails()
        }
    }
    func setStep4Photos()  {
        self.hideShowSteps(passedView: step4PhotosMainView)
        self.step4PhotosMainView.isHidden = false
        self.step3ItemDescriptionMainView.isHidden = true
        
        self.step4PhotosCollectionView.register(UINib(nibName: "UploadImageCVC", bundle: nil), forCellWithReuseIdentifier: "UploadImageCVC")
        self.step4PhotosCollectionView.register(UINib(nibName: "StepPhotosCVCell", bundle: nil), forCellWithReuseIdentifier: "StepPhotosCVCell")
        self.step4PhotosCollectionView!.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.step4PhotosCollectionView.delegate = self
        self.step4PhotosCollectionView.dataSource = self
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Photos", key: "LBL_RENT_ITEM_PHOTOS")
        if(Configurations.isRTLMode()){
            self.categoryTitleLbl.textAlignment = .right
        }
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Photos", key: "LBL_RENT_ITEM_PHOTOS"))
        self.handlesImages(selectedFileData: Data(), actionType: "History", iImageId: "")
    }
    func setStep5LocationDetials()  {
        self.hideShowSteps(passedView: step5LocationDetailsMainView)
        //step5SelectLocationTxtFiled.textFiledWithCardview()
        self.shadowOnview(view: self.step5MainContainerView)
        self.step5SelectLocationTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Location", key: "LBL_RENT_LOCATION")
        self.step5SelectLocationTitleLbl.textColor = SColors.textColor
        self.step5HouseNoTtitleLbl.textColor = SColors.textColor
        self.step5AdressTtileLbl.textColor = SColors.textColor
        //self.step5SelectLocationTxtFiled.textPadding = UIEdgeInsets.init(top: 0, left:0, bottom: 0, right: 20)
        self.step5SelectLocationTxtFiled.addImageView(color: UIColor.init(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_arrow_down",  12,12) { (imageView) in
        }
        if editData != nil {
            self.step5SelectLocationTxtFiled.setText(text: editData.get("vLocation"))
            self.selectedLat = editData.get("vLatitude")
            self.selectedLong = editData.get("vLongitude")
        }
        if self.step5SelectLocationTxtFiled.text == "" {
            self.step5SelectLocationTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Select location", key: "LBL_RENT_SELECT_LOCATION"))
        }else{
            self.step5SelectLocationTxtFiled.setPlaceHolder(placeHolder: "")
        }
        
        self.step5SelectLocationTxtFiled.setEnable(isEnabled: false)
        self.step5SelectLocationTxtFiled.myTxtFieldDelegate = self
        
        self.step5HouseNoTtitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "House no.", key: "LBL_RENT_HOUSE_NO")
        self.step5HouseNoTxtFiled.setEnable(isEnabled: true)
        self.step5HouseNoTxtFiled.myTxtFieldDelegate = self
        self.step5HouseNoTxtFiled.onTextChangedDelegate = self

        if editData != nil {
            self.step5HouseNoTxtFiled.setText(text: self.editData.get("vBuildingNo"))
        }
        if self.step5HouseNoTxtFiled.text == "" {
            self.step5HouseNoTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Your house number", key: "LBL_RENT_HOUSE_NUMBER"))
        }else{
            self.step5HouseNoTxtFiled.setPlaceHolder(placeHolder: "")
        }
        
        
        if editData != nil {
            self.step5AdressTextView.text = editData.get("vAddress")
        }
        self.step5AdressTextView.placeholderColor = .lightGray
        self.step5AdressTextView.delegate = self
        //self.step5AdressTextView.borderColor = UIColor.lightGray
        //self.step5AdressTextView.borderWidth = 1
        self.step5AdressTextView.layer.cornerRadius = 6
        step5AdressTextView.layer.addShadow(opacity: 1, radius: 1.0, UIColor.lightGray)
        self.step5AdressTextView.placeholder = self.generalFunc.getLanguageLabel(origValue: "Enter address", key: "LBL_RENT_ENTER_ADDRESS")
        self.step5AdressTtileLbl.text = self.generalFunc.getLanguageLabel(origValue: "Address", key: "LBL_RENT_ADRESS")
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Location details", key: "LBL_RENT_LOCATION_DETAILS")
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Location details", key: "LBL_RENT_LOCATION_DETAILS"))
        
        self.step5LocationCheckBox.offAnimationType = .bounce
        self.step5LocationCheckBox.onAnimationType = .bounce
        self.step5LocationCheckBox.boxType = .square
        self.step5LocationCheckBox.onCheckColor = SColors.ThemeTxt
        self.step5LocationCheckBox.onFillColor = SColors.Theme
        self.step5LocationCheckBox.onTintColor = SColors.Theme
        self.step5LocationCheckBox.tintColor = SColors.Theme
        self.step5LocationCheckBox.isHidden = false
        self.stepp5LocationSecureLbl.text = self.generalFunc.getLanguageLabel(origValue: "Allow User to see my adreess", key: "LBL_ALLOW_USER_TO_SEE_ADDRESS")
        self.step5LocationCheckBox.setOn(locationSwitch, animated: true)
        self.step5LocationCheckBox.handleClick { instance in
            self.locationSwitch = !self.locationSwitch
            self.step5LocationCheckBox.setOn(self.locationSwitch, animated: true)
        }
    }
    func setStep6PricingStructure()  {
        self.hideShowSteps(passedView: step6PricingStructureMainView)
        self.shadowOnview(view: step6MainContentView)
        self.step6AmountTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_AMOUNT")
        self.step6AmountTxtFiled.setEnable(isEnabled: true)
        self.step6AmountTxtFiled.myTxtFieldDelegate = self
        self.step6AmountTxtFiled.onTextChangedDelegate = self

        self.step6CurrencyView.round(corners: [.topRight, .bottomRight], cornerRadius: 8)
        self.step6AmountTxtFiled.getTextField()!.keyboardType = .decimalPad
        if self.editData != nil {
            self.step6AmountTxtFiled.setText(text:self.editData.get("fAmountWithoutSymbol"))
        }
        let userSelectedCurrency = GeneralFunctions.getValue(key: Utils.DEFAULT_CURRENCY_TITLE_KEY) as! String
        self.step6AmountNoteLbl.textColor = SColors.textColor
        self.step6AmountNoteLbl.font = UIFont(name: Fonts().semibold, size: 16)
        //LBL_VALUE_NOTE_PREFIX
//        self.step6AmountNoteLbl.text = self.generalFunc.getLanguageLabel(origValue: "In", key: "LBL_IN") + " ("  + userSelectedCurrency + ")"
//        if  self.step6AmountNoteLbl.text == "" {
//            self.step6AmountNoteLbl.text = " (" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PER_DAY_TXT") + ")"
//        }
//
        self.step6AmuntLbl.text = userSelectedCurrency
        if self.step6AmountTxtFiled.text == "" {
            self.step6AmountTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Enter Amount", key: "LBL_RENT_ITEM_ENTER_AMOUNT"))
        }else{
            self.step6AmountTxtFiled.setPlaceHolder(placeHolder: "")
        }
        
        
        //step6priceViewWidht.constant = step6PricingStructureMainView.frame.size.width - 10
        //step6DurationView.isHidden = true
        if isRent {
//        step6priceViewWidht.constant = (step6PricingStructureMainView.frame.size.width / 2 ) - 25
            step6DurationViewHeight.constant = 110
            step6DurationView.isHidden = false
            step6BgViewHeight.constant = 250
            self.step6PerLbl.isHidden = true
            self.step6PerLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PER")
            if self.eType != "RentEstate"{
                Utils.delayWithSeconds(1) {
                    self.step6DurationTextFiled.addImageView(color: UIColor.init(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_arrow_down",  13,13) { (imageView) in
                    }
                }
            }else{
                self.step6DurationTextFiled.setText(text: self.generalFunc.getLanguageLabel(origValue: "Month", key: "LBL_RENT_MONTH"))
                 self.selectedDuration = self.generalFunc.getLanguageLabel(origValue: "Month", key: "LBL_RENT_MONTH")
                self.step6AmountNoteLbl.text = " (" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PER") + " "  + self.generalFunc.getLanguageLabel(origValue: "Month", key: "LBL_RENT_MONTH") + ")"
            }
            self.step6AmountNoteLbl.isHidden = false
            self.step6PriceRequiredSymbolLbl.isHidden = false
        }else{
            //step6priceViewWidht.constant = step6PricingStructureMainView.frame.size.width - 5
            step6BgViewHeight.constant = 125
            step6DurationViewHeight.constant = 0
            step6DurationView.isHidden = true
            self.step6PerLbl.isHidden = true
            self.step6AmountNoteLbl.isHidden = true
            self.step6PriceRequiredSymbolLbl.isHidden = true
           var  tempAtrStr = NSMutableAttributedString.init(string: "")
            tempAtrStr.append(self.getAttributedString(str:  self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_AMOUNT"),color:SColors.textColor))
            tempAtrStr.append(self.getAttributedString(str: " " + "*",color:UIColor.init(hex: 0xCA3939)))
            self.step6AmountTitleLbl.attributedText = tempAtrStr
        }
        
        
        if editData != nil {
            self.step6DurationTextFiled.text = self.editData.get("eRentItemDuration")
            self.selectedDuration = self.editData.get("eRentItemDuration")
        }
        if self.step6DurationTextFiled.text == "" {
            self.step6DurationTextFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Day/Week/Month", key: "LBL_RENT_DAY_WEEK_MONTH"))
        }else{
            self.step6DurationTextFiled.setPlaceHolder(placeHolder: "")
        }
        
        self.step6DurationTextFiled.setEnable(isEnabled: false)
        self.step6DurationTextFiled.myTxtFieldDelegate = self
        self.step6DurationTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Duration", key: "LBL_RENT_DURATION")
        
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pricing Structure", key: "LBL_RENT_ITEM_PRICING_STRUCTURE")
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Pricing Structure", key: "LBL_RENT_ITEM_PRICING_STRUCTURE"))
    }
    func setStep7PickUpAvalibilty()  {
        self.hideShowSteps(passedView: step7PickUPAvalibilityMainView)
        self.shadowOnview(view: step7TimeContainerView)
        if eType == "RentEstate" {
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Your Avaliability", key: "LBL_RENT_ESTATE_AVAILABILTY_TXT")
        }else if eType == "RentEstate" {
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Your Avaliability", key: "LBL_RENT_ESTATE_AVAILABILTY_TXT")
        }
        else{
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pickup Avaliability", key: "LBL_RENT_ITEM_PICKUP_AVAILBILITY")
        }
        
        self.step7DateTxtFiled.addImageView(color: UIColor.darkGray, transform: .identity, isCustomImage: true, "ic_calender",  25,25) { (imageView) in
        }
        if editData != nil {
            self.step7DateTxtFiled.text = editData.get("dPickupAvailableDate")
        }
        if self.step7DateTxtFiled.text == "" {
            self.step7DateTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Select date", key: "LBL_RENT_SELECT_DATE"))
        }else{
            self.step7DateTxtFiled.setPlaceHolder(placeHolder: "")
        }
        self.step7DateTxtFiled.setEnable(isEnabled: false)
        self.step7DateTxtFiled.myTxtFieldDelegate = self
        self.step7DateTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Date", key: "LBL_RENT_ITEM_DATE")
        
        self.step7TimeTxtFiled.addImageView(color: UIColor.darkGray, transform: .identity, isCustomImage: true, "ic_clock",  25,25) { (imageView) in
        }
        if editData != nil {
            self.step7TimeTxtFiled.text = self.editData.get("dPickupAvailableTime")
        }
        if self.step7TimeTxtFiled.text == "" {
            self.step7TimeTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "Select Time", key: "LBL_RENT_SELECT_TIME"))
        }else{
            self.step7TimeTxtFiled.setPlaceHolder(placeHolder: "")
        }
        lblNote.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_HR_SELECT_NOTE")
        self.monRequiredLbl.text = ""
        if !isTimeLoad{
            self.monTitleLbl.text = self.timeSlot[0].get("dayname")
            self.monSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.monSlot1fromTimeLbl.text = self.timeSlot[0].get("v" + self.timeSlot[0].get("field") + "FromSlot" )
            self.monSlot1ToTimeLbl.text = self.timeSlot[0].get("v" + self.timeSlot[0].get("field") + "ToSlot")
            self.vFromMonTimeSlot1 = self.timeSlot[0].get("v" + self.timeSlot[0].get("field") + "FromSlot" )
            self.vToMonTimeSlot1 = self.timeSlot[0].get("v" + self.timeSlot[0].get("field") + "ToSlot")
            self.monSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.monSlot1FromVw.layer.borderWidth = 1
            self.monSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.monSlot1ToVw.layer.borderWidth = 1
            self.monSlot1Vw.layer.shadowOpacity = 0.5
            self.monSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.monSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            self.monSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.monSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            let monSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            monSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.monSlot1FromVw.addGestureRecognizer(monSlot1FromTimeTapGes)
            self.monSlot1FromVw.tag = 1
            
            let monSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            monSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.monSlot1ToVw.addGestureRecognizer(monSlot1ToTimeTapGes)
            self.monSlot1ToVw.tag = 2
            // Tue Slot 1
            self.tueRequiredLbl.text = ""
            self.tueTitleLbl.text = self.timeSlot[1].get("dayname")
            self.tueSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.tueSlot1fromTimeLbl.text = self.timeSlot[1].get("v" + self.timeSlot[1].get("field") + "FromSlot" )
            self.tueSlot1ToTimeLbl.text =  self.timeSlot[1].get("v" + self.timeSlot[1].get("field") + "ToSlot")
            self.vFromTueTimeSlot1 = self.timeSlot[1].get("v" + self.timeSlot[1].get("field") + "FromSlot" )
            self.vToTueTimeSlot1 = self.timeSlot[1].get("v" + self.timeSlot[1].get("field") + "ToSlot")
            self.tueSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.tueSlot1FromVw.layer.borderWidth = 1
            self.tueSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.tueSlot1ToVw.layer.borderWidth = 1
            self.tueSlot1Vw.layer.shadowOpacity = 0.5
            self.tueSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.tueSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            let tueSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            tueSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.tueSlot1FromVw.addGestureRecognizer(tueSlot1FromTimeTapGes)
            self.tueSlot1FromVw.tag = 3
            
            let tueSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            tueSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.tueSlot1ToVw.addGestureRecognizer(tueSlot1ToTimeTapGes)
            self.tueSlot1ToVw.tag = 4
            
            self.tueSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.tueSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            // wed Slot 1
            self.wedRequiredLbl.text = ""
            self.wedTitleLbl.text = self.timeSlot[2].get("dayname")
            self.wedSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.wedSlot1fromTimeLbl.text = self.timeSlot[2].get("v" + self.timeSlot[2].get("field") + "FromSlot" )
            self.wedSlot1ToTimeLbl.text =  self.timeSlot[2].get("v" + self.timeSlot[2].get("field") + "ToSlot")
            self.vFromWedTimeSlot1 = self.timeSlot[2].get("v" + self.timeSlot[2].get("field") + "FromSlot" )
            self.vToWedTimeSlot1 = self.timeSlot[2].get("v" + self.timeSlot[2].get("field") + "ToSlot" )
            self.wedSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.wedSlot1FromVw.layer.borderWidth = 1
            self.wedSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.wedSlot1ToVw.layer.borderWidth = 1
            self.wedSlot1Vw.layer.shadowOpacity = 0.5
            self.wedSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.wedSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            let wedSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            wedSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.wedSlot1FromVw.addGestureRecognizer(wedSlot1FromTimeTapGes)
            self.wedSlot1FromVw.tag = 5
            
            let wedSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            wedSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.wedSlot1ToVw.addGestureRecognizer(wedSlot1ToTimeTapGes)
            self.wedSlot1ToVw.tag = 6
            
            self.wedSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.wedSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            // Thu Slot 1
            self.thuRequiredLbl.text = ""
            self.thuTitleLbl.text = self.timeSlot[3].get("dayname")
            self.thuSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.thuSlot1fromTimeLbl.text = self.timeSlot[3].get("v" + self.timeSlot[3].get("field") + "FromSlot" )
            self.thuSlot1ToTimeLbl.text =  self.timeSlot[3].get("v" + self.timeSlot[3].get("field") + "ToSlot")
            self.vFromThuTimeSlot1 = self.timeSlot[3].get("v" + self.timeSlot[3].get("field") + "FromSlot" )
            self.vToThuTimeSlot1 = self.timeSlot[3].get("v" + self.timeSlot[3].get("field") + "ToSlot" )
            self.thuSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.thuSlot1FromVw.layer.borderWidth = 1
            self.thuSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.thuSlot1ToVw.layer.borderWidth = 1
            self.thuSlot1Vw.layer.shadowOpacity = 0.5
            self.thuSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.thuSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            let thuSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            thuSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.thuSlot1FromVw.addGestureRecognizer(thuSlot1FromTimeTapGes)
            self.thuSlot1FromVw.tag = 7
            
            let thuSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            thuSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.thuSlot1ToVw.addGestureRecognizer(thuSlot1ToTimeTapGes)
            self.thuSlot1ToVw.tag = 8
            
            self.thuSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.thuSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            // Fri Slot 1
            self.friRequiredLbl.text = ""
            self.friTitleLbl.text = self.timeSlot[4].get("dayname")
            self.friSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.friSlot1fromTimeLbl.text = self.timeSlot[4].get("v" + self.timeSlot[4].get("field") + "FromSlot" )
            self.friSlot1ToTimeLbl.text = self.timeSlot[4].get("v" + self.timeSlot[4].get("field") + "ToSlot")
            self.vFromFriTimeSlot1 = self.timeSlot[4].get("v" + self.timeSlot[4].get("field") + "FromSlot" )
            self.vToFriTimeSlot1 = self.timeSlot[4].get("v" + self.timeSlot[4].get("field") + "ToSlot")
            self.friSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.friSlot1FromVw.layer.borderWidth = 1
            self.friSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.friSlot1ToVw.layer.borderWidth = 1
            self.friSlot1Vw.layer.shadowOpacity = 0.5
            self.friSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.friSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            let friSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            friSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.friSlot1FromVw.addGestureRecognizer(friSlot1FromTimeTapGes)
            self.friSlot1FromVw.tag = 9
            
            let friSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            friSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.friSlot1ToVw.addGestureRecognizer(friSlot1ToTimeTapGes)
            self.friSlot1ToVw.tag = 10
            
            self.friSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.friSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            // sat Slot 1
            self.satSlot1RequiredLbl.text = ""
            self.satSlot1TitleLbl.text = self.timeSlot[5].get("dayname")
            self.satSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.satSlot1fromTimeLbl.text = self.timeSlot[5].get("v" + self.timeSlot[5].get("field") + "FromSlot")
            self.satSlot1ToTimeLbl.text = self.timeSlot[5].get("v" + self.timeSlot[5].get("field") + "ToSlot")
            self.vFromSatTimeSlot1 = self.timeSlot[5].get("v" + self.timeSlot[5].get("field") + "FromSlot")
            self.vToSatTimeSlot1 = self.timeSlot[5].get("v" + self.timeSlot[5].get("field") + "ToSlot")
            self.satSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.satSlot1FromVw.layer.borderWidth = 1
            self.satSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.satSlot1ToVw.layer.borderWidth = 1
            self.satSlot1Vw.layer.shadowOpacity = 0.5
            self.satSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.satSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            let satSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            satSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.satSlot1FromVw.addGestureRecognizer(satSlot1FromTimeTapGes)
            self.satSlot1FromVw.tag = 11
            
            let satSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            satSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.satSlot1ToVw.addGestureRecognizer(satSlot1ToTimeTapGes)
            self.satSlot1ToVw.tag = 12
            
            self.satSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.satSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            // sun Slot 1
            self.sunSlot1RequiredLbl.text = ""
            self.sunSlot1TitleLbl.text = self.timeSlot[6].get("dayname")
            self.sunSlot1ToLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TO")
            self.sunSlot1fromTimeLbl.text = self.timeSlot[6].get("v" + self.timeSlot[6].get("field") + "FromSlot" )
            self.sunSlot1ToTimeLbl.text = self.timeSlot[6].get("v" + self.timeSlot[6].get("field") + "ToSlot")
            self.vFromSunTimeSlot1 = self.timeSlot[6].get("v" + self.timeSlot[6].get("field") + "FromSlot" )
            self.vToSunTimeSlot1 = self.timeSlot[6].get("v" + self.timeSlot[6].get("field") + "ToSlot" )
            self.sunSlot1FromVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.sunSlot1FromVw.layer.borderWidth = 1
            self.sunSlot1ToVw.layer.borderColor = SColors.ThemeTxt.cgColor
            self.sunSlot1ToVw.layer.borderWidth = 1
            self.sunSlot1Vw.layer.shadowOpacity = 0.5
            self.sunSlot1Vw.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.sunSlot1Vw.layer.shadowColor = UIColor(hex: 0xe6e6e6).cgColor
            
            self.sunSlot1ToTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            self.sunSlot1fromTimeLbl.textColor = UIColor.init(hex: 0x8FA1B4)
            
            let sunSlot1FromTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            sunSlot1FromTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.sunSlot1FromVw.addGestureRecognizer(sunSlot1FromTimeTapGes)
            self.sunSlot1FromVw.tag = 13
            
            let sunSlot1ToTimeTapGes : UITapGestureRecognizer = UITapGestureRecognizer()
            sunSlot1ToTimeTapGes.addTarget(self, action: #selector(self.selectTime(sender:)))
            self.sunSlot1ToVw.addGestureRecognizer(sunSlot1ToTimeTapGes)
            self.sunSlot1ToVw.tag = 14
            self.t1ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t1ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t2ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t2ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t3ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t3ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t4ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t4ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t5ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t5ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t6ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t6ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            self.t7ImgView.image = UIImage.init(named: "ic_clock_Nearby")
            self.t7ImgView1.image = UIImage.init(named: "ic_clock_Nearby")
            GeneralFunctions.setImgTintColor(imgView: t1ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t1ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t2ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t2ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t3ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t3ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t4ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t4ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t5ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t5ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t6ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t6ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t7ImgView, color: UIColor.init(hex: 0x8FA1B4))
            GeneralFunctions.setImgTintColor(imgView: t7ImgView1, color: UIColor.init(hex: 0x8FA1B4))
            self.isTimeLoad = true
        }
        self.step7TimeTxtFiled.setEnable(isEnabled: false)
        self.step7TimeTxtFiled.myTxtFieldDelegate = self
        self.step7TimeTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Time", key: "LBL_RENT_ITEM_TIME")
        
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Photos", key: "LBL_RENT_ITEM_PHOTOS"))
        
        self.step7CheckBox.offAnimationType = .bounce
        self.step7CheckBox.onAnimationType = .bounce
        self.step7CheckBox.boxType = .square
        self.step7CheckBox.onCheckColor = SColors.ThemeTxt
        self.step7CheckBox.onFillColor = SColors.Theme
        self.step7CheckBox.onTintColor = SColors.Theme
        self.step7CheckBox.tintColor = SColors.Theme
        self.step7CheckBox.isHidden = false
        self.step7SecureNoLbl.text = self.generalFunc.getLanguageLabel(origValue: "Allow User to call me", key: "LBL_RENT_ALLOW_USER_TO_CALL")
        self.step7CheckBox.setOn(secureNoSwitch, animated: true)
        self.step7CheckBox.handleClick { instance in
            self.secureNoSwitch = !self.secureNoSwitch
            self.step7CheckBox.setOn(self.secureNoSwitch, animated: true)
        }
        
        
        
        
        
        Utils.delayWithSeconds(0.1) {
            
            
            self.step7ScrollView.contentSize = CGSize(width: self.step7ScrollView.contentSize.width, height: (100 * 8))
            self.step7ViewHight.constant = self.step7ScrollView.contentSize.height
        }
    }
    func addslotStep8()  {
        if isPickUpAvalibiltyHide {
            self.step8DetailsViewTop.constant = -80
            self.step8PickUpView.isHidden = true
        }else{
            self.step8PickUpView.isHidden = false
            self.step8DetailsViewTop.constant = 30
            let rentFiledNewArr = self.reviewData.arrOf("timeslot")
            for view in self.step8PickUpSubView.subviews {
                view.removeFromSuperview()
            }
            for i in 0..<rentFiledNewArr.count {
                let dict_temp = rentFiledNewArr[i] as! NSDictionary
                
                
                if  dict_temp.get("Name") == "Yes" ||  dict_temp.get("Description") == "Yes" {
                    
                }else{
                    for (key, value) in dict_temp {
                        
                        let totalSubViewCounts = self.step8PickUpSubView.subviews.count
                        
                        
                        let viewWidth = Application.screenSize.width - 65
                        
                        let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts) * 40), width: viewWidth, height: 40))
                        
                        
                        let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                        let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                        
                        
                        var font = UIFont(name: Fonts().semibold, size: 16)!
                        var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                        var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 15
                        if(widthOfTitle > ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                            widthOfvalue = ((viewWidth * 70) / 100)
                            widthOfTitle = ((viewWidth * 30) / 100)
                        }else if(widthOfTitle < ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 70) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
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
                        
                        lblTitle.textColor = UIColor.black
                        lblValue.textColor = SColors.Theme
                        
                        
                        
                        lblTitle.font = font
                        lblValue.font = font
                        
                        lblTitle.fontFamilyWeight = "Medium"
                        lblValue.fontFamilyWeight = "Medium"
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
                        
                        self.step8PickUpSubView.addSubview(viewCus)
                        
                        if(Configurations.isRTLMode()){
                            lblValue.textAlignment = .left
                        }else{
                            lblValue.textAlignment = .right
                        }
                        
                        
                        
                    }
                    self.step8PickUpSubViewHight.constant = CGFloat((self.step8PickUpSubView.subviews.count) * 40 )
                }
            }
        }
    }
    func setStep8Review()  {
        self.hideShowSteps(passedView: step8ReviewMainView)
        self.shadowOnview(view: self.step8PickUpView)
        self.shadowOnview(view: self.step8CategoryView)
        self.shadowOnview(view: self.step8detailsView)
        self.shadowOnview(view: self.step8DescView)
        let rentFiledNewArr = self.reviewData.arrOf("RentitemFieldarray")
        for i in 0..<rentFiledNewArr.count {
            let dict_temp = rentFiledNewArr[i] as! NSDictionary
            if dict_temp.get("eName") == "Yes" {
                //self.step8nameLbl.text = dict_temp.get("Item Name")
                for (key, value) in dict_temp {
                    
                    if key as! String != "eName"
                    {
                        self.step8nameLbl.text =  Configurations.convertNumToAppLocal(numStr: value as! String)
                    }
                }
            }
            if dict_temp.get("eDescription") == "Yes" {
                
                for (key, value) in dict_temp {
                    
                    if key as! String != "eDescription"
                    {
                        //self.step8descriptionLbl.text =  Configurations.convertNumToAppLocal(numStr: value as! String)
                        self.step8descriptionDLbl.text =  Configurations.convertNumToAppLocal(numStr: value as! String)
                    }
                }
                
            }
        }
        if self.step8descriptionDLbl.text == "" {
            self.step8descriptionView.isHidden = true
            self.step8CategoryViewTop.constant = -80
        }else{
            self.step8descriptionView.isHidden = false
            self.step8CategoryViewTop.constant = 30
        }
        self.step8descriptionDLbl.textColor = SColors.textColor
        self.step8descriptioHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Description", key: "LBL_RENT_DESCRIPTION_TXT")
        self.step8conditionLbl.text = ""
        self.step8priceLbl.text = self.reviewData.get("fAmount")
        if self.reviewData.get("eRentItemDuration") != "" {
        self.step8DurationLbl.text = "/ " + self.reviewData.get("eRentItemDuration")
        }else{
            self.step8DurationLbl.text = ""
        }
        self.step8priceLbl.textColor = SColors.Theme
        self.step8addLbl.text = ""//self.reviewData.get("vAddress")
        self.step8updatedByLbl.text = ""
        
        self.step8anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.step8anchorSubView.backgroundColor = SColors.Theme
       
        
        self.step8locationAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.step8locationAnchorSubView.backgroundColor = SColors.Theme
        self.step8locationHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Location", key: "LBL_RENT_LOCATION")
        self.step8locationLbl.text = self.reviewData.get("vAddress")
        self.shadowOnview(view: self.step8DirectionView)
        self.step8locationLbl.isUserInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.step8locationLbl.addGestureRecognizer(longPressRecognizer)
        self.shadowOnview(view: self.step8detailsMainView)
        self.step8PhotosAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.step8PhotosSubAnchorView.backgroundColor = SColors.Theme
        self.step8PhotosLbl.text = self.generalFunc.getLanguageLabel(origValue: "Photos", key: "LBL_RENT_ITEM_PHOTOS")
        
        self.photosReview = self.reviewData.arrOf("Images") as! [NSDictionary]
        self.step8PageController.setPage(0)
        
        self.step8PageController.drawer = ExtendedDotDrawer.init(numberOfPages: self.photosReview.count, height: 7, width: 7, space: 5, raduis: 5, currentItem: 0, indicatorColor:
                                                                    SColors.Theme, dotsColor: UIColor.white, isBordered: false, borderColor: .clear, borderWidth: 0, indicatorBorderColor: .clear, indicatorBorderWidth: 0)
        
        self.step8PageController.backgroundColor = UIColor(red: 90.0/255, green: 90.0/255, blue: 90.0/255, alpha: 0.7)
        self.step8PageController.layer.cornerRadius = 8
        self.step8PageController.layer.masksToBounds = true
        if self.photosReview.count <= 1 {
            self.step8PageController.isHidden = true
        }else{
            self.step8PageController.isHidden = false
        }
        let location = CLLocation(latitude: Double(self.reviewData.get("vLatitude"))!, longitude: Double(self.reviewData.get("vLongitude"))!)
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: Utils.defaultZoomLevel)
        self.step8PageControllerWidth.constant = CGFloat((self.photosReview.count * 10) + 45)
        self.step8gMap.camera = camera
        
        let marker = GMSMarker(position: location.coordinate)
        marker.map = self.step8gMap
        self.step8ImgSlider.type = .linear
        self.step8ImgSlider.bounces = false
        self.step8ImgSlider.scrollSpeed = 0.8
        self.step8ImgSlider.decelerationRate = 0.8
        self.step8ImgSlider.delegate = self
        self.step8ImgSlider.dataSource = self
        self.step8ImgSlider.reloadData()
        self.step8ImageSliderHight.constant = 0 //Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")
        self.shadowOnview(view: self.step8PickUpSubView)
        self.step8ImgSlider.isHidden = true
        self.step8PaymentAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.step8PaymentAnchorSubView.backgroundColor = SColors.Theme
       
        if editData != nil {
            self.step8PaymentPlanView.isHidden = false
            self.step8PayMentViewHight.constant = 200
            self.step8PaymentView.backgroundColor = SColors.Theme.light(by: 90)
            self.step8PaymentTitleLbl.textColor = SColors.Theme
            self.step8PayMentDisLbl.textColor = SColors.Theme
            self.shadowOnview(view: step8PaymentView)
            self.step8PaymentTitleLbl.text = self.editData.dictOf("RentItemPlanData").get("vPlanName")
            self.step8PayMentDisLbl.text = self.editData.dictOf("RentItemPlanData").get("fAmount")
            if  self.step8PayMentDisLbl.text == "" {
                self.step8PaymentDisTop.constant = 0
                self.step8PaymenTitileLblHight.constant = 23
            }else{
                self.step8PaymentDisTop.constant = 10
                self.step8PaymenTitileLblHight.constant = 23
            }
        }else{
            self.step8PaymentPlanView.isHidden = true
            self.step8PayMentViewHight.constant = 0
        }
        
//        self.step8SelectedCategoryAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
//        self.step8SelectedCategoryAnchorSubView.backgroundColor = SColors.Theme
        self.step8SelectedCategoryLbl.text = self.generalFunc.getLanguageLabel(origValue: "Selected Category", key: "LBL_RENT_SELECTED_CATEGORY")
        if self.reviewData.get("vSubCatName") != ""{
            self.step8CatSubLbl.text = self.reviewData.get("vCatName") + " (" + self.reviewData.get("vSubCatName") + ")"
        }else{
            self.step8CatSubLbl.text = self.reviewData.get("vCatName")
        }
        self.shadowOnview(view:self.step8SelctedCategoryLblContainerView)
       
        self.step8MediaCollectionView.register(UINib(nibName: "RentMediaIconCell", bundle: nil), forCellWithReuseIdentifier: "RentMediaIconCell")
        self.step8MediaCollectionView.delegate = self
        self.step8MediaCollectionView.dataSource = self
        self.step8MediaCollectionView.reloadData()
        
        
        self.step8PickUpAnchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.step8PickUpAnchorSubView.backgroundColor = SColors.Theme
        self.step8gMap.isUserInteractionEnabled = false
        self.shadowOnview(view: self.step8GmapContainerView)
        self.addDetailsStep8()
        if eType == "RentEstate" {
            self.step8PaymentLbl.text = self.generalFunc.getLanguageLabel(origValue: "Selected payment plan", key: "LBL_RENT_SELECTED_PAYMENT_PLAN")
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Review Property Details", key: "LBL_RENT_ESTATE_PROPERTY_REVIEW_DETAILS")
            self.step8PickUpLbl.text = self.generalFunc.getLanguageLabel(origValue: "your availability", key: "LBL_RENT_ESTATE_AVAILABILTY_TXT")
            self.step8detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Property Details", key: "LBL_RENT_PROPERTY_DETAIL")
        }else if eType == "RentCars" {
            self.step8PaymentLbl.text = self.generalFunc.getLanguageLabel(origValue: "Selected payment plan", key: "LBL_RENT_SELECTED_PAYMENT_PLAN")
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Review Car Details", key: "LBL_RENT_CAR_REVIEWS_DETAILS")
            self.step8PickUpLbl.text = self.generalFunc.getLanguageLabel(origValue: "your availability", key: "LBL_RENT_ESTATE_AVAILABILTY_TXT")
            self.step8detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "Car Details", key: "LBL_RENT_CAR_DETAILS")
        }
        else{
            self.step8PickUpLbl.text = self.generalFunc.getLanguageLabel(origValue: "Pickup Avaliability", key: "LBL_RENT_ITEM_PICKUP_AVAILBILITY")
            self.step8PaymentLbl.text = self.generalFunc.getLanguageLabel(origValue: "Selected payment plan", key: "LBL_RENT_SELECTED_PAYMENT_PLAN")
            self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Review all details", key: "LBL_RENT_ITEM_REVIEW")
            self.step8detailsLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_ITEM_DETAILS")
        }
        
        Utils.delayWithSeconds(0.1) {
//            let tempScrContHight =  self.step8nameLbl.frame.size.height + self.step8conditionLbl.frame.size.height + self.step8priceLbl.frame.size.height + self.step8addLbl.frame.size.height + self.step8updatedByLbl.frame.size.height + self.step8descriptionView.frame.size.height
//            var  scrContentHight = tempScrContHight + self.step8descriptionLbl.frame.size.height + self.step8detailsView.frame.size.height + self.step8locationView.frame.size.height + self.step8PhotosView.frame.size.height
//            if !self.step8PickUpView.isHidden {
//                scrContentHight += self.step8PickUpView.frame.size.height
//            }
//            if !self.step8PaymentPlanView.isHidden{
//                scrContentHight += self.step8PayMentViewHight.constant
//            }
//            self.step8ScrContentViewHight.constant = scrContentHight + 250
//
//            self.step8Scrollview.contentSize = CGSize(width: self.step8Scrollview.contentSize.width, height: self.step8ScrContentViewHight.constant + 100)
//            self.step8ScrContentViewHight.constant = self.step8Scrollview.contentSize.height + 250
        }
        
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Review all details", key: "LBL_RENT_ITEM_REVIEW"))
        if(Configurations.isRTLMode()){
            self.step8PhotosLbl.textAlignment = .right
            self.step8detailsLbl.textAlignment = .right
            self.step8PickUpLbl.textAlignment = .right
            self.step8locationHLbl.textAlignment = .right
        }
        self.step8DirectionView.handleClick { instance in
            let openNavOption = OpenNavOption(uv: self, containerView: self.view, placeLatitude: self.reviewData.get("vLatitude"), placeLongitude: self.reviewData.get("vLongitude"), address: self.reviewData.get("vAddress"))
            openNavOption.chooseOption()
        }
        GeneralFunctions.setImgTintColor(imgView: self.step8DirectionImgView, color: UIColor(hex: 0x007AFF))
    }
    func addDetailsStep8()  {
        let rentFiledNewArr = self.reviewData.arrOf("RentitemFieldarray")
        for view in self.step8detailsMainView.subviews {
            view.removeFromSuperview()
        }
        for i in 0..<rentFiledNewArr.count {
            let dict_temp = rentFiledNewArr[i] as! NSDictionary
            
            
            if  dict_temp.get("eName") == "Yes" ||  dict_temp.get("eDescription") == "Yes" {
                
            }else{
                for (key, value) in dict_temp {
                    
                    let totalSubViewCounts = self.step8detailsMainView.subviews.count
                    
                    
                    let viewWidth = Application.screenSize.width - 60
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts) * 40), width: viewWidth, height: 40))
                    
                    
                    let titleStr = Configurations.convertNumToAppLocal(numStr: key as! String)
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                                                                                           
                    
                    var font = UIFont(name: Fonts().semibold, size: 16)!
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 40, font: font) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 40, font: font) + 40
                    if(widthOfTitle > ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 70) / 100)){
                        widthOfvalue = ((viewWidth * 30) / 100)
                        widthOfTitle = ((viewWidth * 30) / 100)
                    }else if(widthOfTitle < ((viewWidth * 30) / 100) && widthOfvalue > ((viewWidth * 70) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
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
                        lblValue.setPadding(paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 30)
                    }
                    
                    lblTitle.textColor = SColors.textColor
                    lblValue.textColor = SColors.Theme
                    
                    
                    
                    lblTitle.font = font
                    lblValue.font = font
                    
                    lblTitle.fontFamilyWeight = "Medium"
                    lblValue.fontFamilyWeight = "Medium"
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
                    
                    self.step8detailsMainView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    
                    
                    
                }
                self.step8MainDetialsViewHight.constant = CGFloat((self.step8detailsMainView.subviews.count) * 40 )
                
            }
        }
        if self.step8MainDetialsViewHight.constant < 10 {
            self.step8detailsView.isHidden = true
            Utils.delayWithSeconds(1) {
                self.step8PhotosTop.constant = -40
            }
            
        }else{
            self.step8detailsView.isHidden = false
            self.step8PhotosTop.constant = 10
        }
    }
    func setStep9PayMentPlan()  {
        self.hideShowSteps(passedView: step9PaymentPlanMainView)
        self.shadowOnview(view: self.step9PayemntView)
       
        self.step9TblView.register(UINib(nibName: "PaymentStepTVC", bundle: nil), forCellReuseIdentifier: "PaymentStepTVC")
        
        
        self.step9TblView.delegate = self
        self.step9TblView.dataSource = self
        self.getPaymentPlan()
      
        self.categoryTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Select payment plan", key: "LBL_RENT_ITEM_SELECT_PAYMENT_PLAN")
        self.setNavigationBar(title: self.generalFunc.getLanguageLabel(origValue: "Photos", key: "LBL_RENT_ITEM_PHOTOS"))
    }
    func setSteps(){
        if self.firstTwoStepsHide {
            if self.currentStep == 0 {
                self.setStep3ItemDetails()
            }
            if  self.currentStep == 1 {
                self.setStep4Photos()
            }
            if  self.currentStep == 2 {
                self.setStep5LocationDetials()
            }
            if  self.currentStep == 3 {
                self.setStep6PricingStructure()
            }
            if  self.currentStep == 4 {
                if !isPickUpAvalibiltyHide {
                    self.setStep7PickUpAvalibilty()
                }else{
                    if !isBackStep{
                        self.PostData()
                    }else{
                        self.setStep8Review()
                        self.addslotStep8()
                    }
                }
            }
            if self.currentStep == 5 {
                if !isPickUpAvalibiltyHide{
                    if !isBackStep{
                        self.PostData()
                    }else{
                        self.setStep8Review()
                        self.addslotStep8()
                    }
                }else{
                    self.setStep9PayMentPlan()
                }
            }
            if  self.currentStep == 6 {
                self.setStep9PayMentPlan()
            }
        }else{
            if self.currentStep == 0 {
                self.setStep1mainCategory()
            }
            if self.currentStep == 1 {
                //self.setStep9PayMentPlan()
                if isSubCatHide {
                    self.setStep3ItemDetails()
                }else{
                    self.setStep2SubCategory()
                }
            }
            if self.currentStep == 2 {
                
                if  isSubCatHide {
                    self.setStep4Photos()
                }
                else{
                    self.setStep3ItemDetails()
                }
            }
            if self.currentStep == 3 {
                if  isSubCatHide {
                    self.setStep5LocationDetials()
                }
                else {
                    self.setStep4Photos()
                }
            }
            if self.currentStep == 4 {
                if  isSubCatHide {
                    self.setStep6PricingStructure()
                }else{
                    self.setStep5LocationDetials()
                }
                
            }
            if self.currentStep == 5 {
                if isSubCatHide {
                    if !isPickUpAvalibiltyHide {
                        self.setStep7PickUpAvalibilty()
                    }else{
                        if !isBackStep{
                            self.PostData()
                        }else{
                            self.setStep8Review()
                            self.addslotStep8()
                        }
                    }
                }
                else{
                    self.setStep6PricingStructure()
                }
            }
            if self.currentStep == 6 {
                if isSubCatHide {
                    if !isPickUpAvalibiltyHide {
                        if !isBackStep{
                            self.PostData()
                        }else{
                            self.setStep8Review()
                            self.addslotStep8()
                        }
                    }else{
                        self.setStep9PayMentPlan()
                    }
                }
                else {
                    if !isPickUpAvalibiltyHide{
                        self.setStep7PickUpAvalibilty()
                    }else{
                        if !isBackStep{
                            self.PostData()
                        }else{
                            self.setStep8Review()
                            self.addslotStep8()
                        }
                    }
                }
            }
            if self.currentStep == 7 {
                if isSubCatHide {
                    self.setStep9PayMentPlan()
                }
                else{
                    if !isPickUpAvalibiltyHide{
                        if !isBackStep{
                            self.PostData()
                        }else{
                            self.setStep8Review()
                            self.addslotStep8()
                        }
                    }else{
                        self.setStep9PayMentPlan()
                    }
                }
            }
            if self.currentStep == 8 {
                self.setStep9PayMentPlan()
            }
        }
        self.viewBottom.isHidden = false
        self.viewPrivious.isHidden = currentStep == 0 ? true : false
        self.setStepperCollectionScroll()
    }
    func hideShowSteps(passedView : UIView)   {
        let tempViewArray = [step1MainView,step2SubCategoryMainView,step3ItemDescriptionMainView,step4PhotosMainView,step5LocationDetailsMainView,step6PricingStructureMainView,step7PickUPAvalibilityMainView,step8ReviewMainView,step9PaymentPlanMainView]
        for val in tempViewArray{
            //if passedView == val {
            val?.isHidden = passedView == val ? false : true
            //}else{
            // val?.isHidden = true
            // }
        }
    }
    func onTextChanged(sender: MyTextField, text: String) {
        
    }
    
    
    func myTxtFieldTapped(sender: MyTextField) {
        view.endEditing(true)
        if sender == step5SelectLocationTxtFiled
        {
            let addDestinationUv = GeneralFunctions.instantiateViewController(pageName: "AddDestinationUV") as! AddDestinationUV
            addDestinationUv.SCREEN_TYPE = "STEPPER"
            addDestinationUv.rentItemPostUV = self
            self.push(uv: addDestinationUv)
        }
        if sender == step6DurationTextFiled {
            if self.eType != "RentEstate"{
                self.openDuration()
            }
        }
        if sender == step7TimeTxtFiled {
            self.openTimePicker()
        }
        if sender == step7DateTxtFiled{
            self.openCalender()
        }
        if !self.step3ItemDescriptionMainView.isHidden {
            for i in 0..<self.fieldObjArray.count{
                
                let item = self.fieldObjArray[i] as NSDictionary
                if item["eInputType"] as! String == "Select"
                {
                    if(sender == item["Object"] as! MyTextField){
                        
                        self.hideKeyboard()
                        
                        let listArray = self.getOptionsName(array: item["Options"] as! NSArray)
                        let openListView = OpenListView(uv: self, containerView: self.view)
                        openListView.selectedItem = (item["Object"] as! MyTextField).text
                        openListView.show(listObjects: listArray, title: item["vFieldName"] as! String, currentInst: openListView, handler: { (selectedItemId) in
                            
                            (item["Object"] as! MyTextField).getTextField()!.isErrorRevealed = false
                           
                            if item.get("eListing") == "Yes"{
                                let iPackageTypeIdDicTemp = (item["Options"] as! NSArray)[Int(selectedItemId)] as! NSDictionary
                                if iPackageTypeIdDicTemp.get("eListingTypeOptions") == "Sale" {
                                    self.isRent = false
                                    if self.pickUpConfiguration == "No" {
                                        self.isPickUpAvalibiltyHide = true
                                        if self.steeperArray.contains("Pick") {
                                            for i in 0 ..< self.steeperArray.count{
                                                if self.steeperArray[i] == "Pick"{
                                                    self.steeperArray.remove(at:i)
                                                    break
                                                }
                                            }
                                        }
                                        self.setNavigationBar(title: "")
                                    }
                                }else  {
                                    self.isRent = true
                                    
                                    if self.pickUpConfiguration == "No" {
                                        self.isPickUpAvalibiltyHide = true
                                        if self.steeperArray.contains("Pick") {
                                            for i in 0 ..< self.steeperArray.count{
                                                if self.steeperArray[i] == "Pick"{
                                                    self.steeperArray.remove(at:i)
                                                    break
                                                }
                                            }
                                        }
                                    }else{
                                        self.isPickUpAvalibiltyHide = false
                                        if !self.steeperArray.contains("Pick") {
                                            self.steeperArray.append("Pick")
                                        }
                                    }
                                   
                                    self.setNavigationBar(title: "")
                                }
                            }
                            let iPackageTypeIdDic = (item["Options"] as! NSArray)[Int(selectedItemId)] as! NSDictionary
                            let dic2 = ["Object": item["Object"] as! MyTextField, "vFieldName": item.get("vFieldName"), "eInputType":"Select","selectedId": iPackageTypeIdDic.get("iOptionId"), "iRentFieldId":item.get("iRentFieldId"), "eListing":item.get("eListing"),"eRequired":item.get("eRequired"), "Options": item["Options"] as! NSArray] as [String : Any]
                            self.fieldObjArray.remove(at: i)
                            self.fieldObjArray.insert(dic2, at: i)
                           
                            (item["Object"] as! MyTextField).setText(text: listArray[selectedItemId])
                            (item["Object"] as! MyTextField).setPlaceHolder(placeHolder: "")
                            (item["Object"] as! MyTextField).getTextField()!.sendActions(for: .editingChanged)
                           
                        })
                    }
        }
    }
        }
    }
    
    func loadRentCategory(){
        
        self.setLoader(ishidden: false)
        self.step1CategoryCollectionView.isHidden = true
        var parameters = ["type":"getRentItemCategories", "userId": GeneralFunctions.getMemberd() , "eType" : self.eType ]
        
        if !isLoadFirstTime {
            parameters["iCategoryId"] = rentCatId
            isLoadFirstTime = true
        }
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            self.step1CategoryCollectionView.isHidden = false
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    self.mainRentCatData = dataDict.arrOf(Utils.message_str) as! [NSDictionary]
                    if self.timeSlot.count == 0 {
                        self.timeSlot = dataDict.arrOf("timeslot") as! [NSDictionary]
                    }
                    for i in 0 ..< self.mainRentCatData.count{
                        let dataTemp = self.mainRentCatData[i]
                        
                        if dataTemp.get("iCategoryId") == self.rentCatId {
                            self.selectedCategoryIndex  = i
                            self.subCatData = self.mainRentCatData[self.selectedCategoryIndex].arrOf("SubCategory") as! [NSDictionary]
                        }
                        
                    }
                    self.step1CategoryCollectionView.reloadData()
                }
            }else{
                self.generalFunc.setError(uv: self)
                
            }
            
            
            
        })
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.step9TblView {
            return paymentPlanArray.count
        }
        return self.subCatData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.step9TblView {
            return UITableView.automaticDimension
        }else{
            if indexPath.row == 0 {
                return 60
            }else{
                return 55
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.step9TblView {
            let cell = step9TblView.dequeueReusableCell(withIdentifier: "PaymentStepTVC", for: indexPath) as! PaymentStepTVC
            var item:NSDictionary!
            item = paymentPlanArray[indexPath.row]
            cell.titleLbl.text = item.get("fAmount")
            cell.descriptionLbl.text = item.get("vPlanName")
            if item.get("vPlanName") == "" {
                //cell.titleLbl.text = " "
                cell.descriptionLbl.text = " "
            }
            cell.hintLbl.text = item.get("iRemainingPost")
            cell.hintLbl2.text = item.get("tDescription")

            self.shadowOnview(view: cell.viewContent)
            if(self.selectdPaymentId == item.get("iPaymentPlanId")){
                
                cell.viewContent.layer.borderWidth = 1
                cell.viewContent.layer.borderColor =  SColors.Theme.cgColor
                cell.titleLbl.textColor = SColors.ThemeTxt
                cell.descriptionLbl.textColor = SColors.ThemeTxt
                cell.viewContent.backgroundColor =  SColors.Theme
                cell.viewContent.alpha = 1
                cell.chcekMarkImgView.isHidden = false
                cell.hintLbl.textColor = SColors.ThemeTxt
                cell.hintLbl2.textColor = SColors.ThemeTxt
                cell.descriptionLbl.numberOfLines = 1
                cell.chcekMarkImgView.image = UIImage.init(named: "ic_trip_finish_check")
                GeneralFunctions.setImgTintColor(imgView: cell.chcekMarkImgView, color: SColors.ThemeTxt)
                cell.chcekMarkImgView.borderWidth = 0
                cell.chcekMarkImgView.borderColor = UIColor.clear
                
            }else if item.get("isDisabled").uppercased() == "YES" {
                cell.viewContent.layer.borderWidth = 1
                cell.viewContent.layer.borderColor =  UIColor.lightGray.cgColor
                cell.titleLbl.textColor = SColors.ThemeTxt
                cell.descriptionLbl.textColor = SColors.ThemeTxt
                cell.hintLbl.textColor = SColors.ThemeTxt
                cell.hintLbl2.textColor = SColors.ThemeTxt
                cell.viewContent.backgroundColor =  UIColor.lightGray
                cell.viewContent.alpha = 0.3
                cell.chcekMarkImgView.isHidden = true
                cell.descriptionLbl.numberOfLines = 1
                cell.chcekMarkImgView.image = UIImage.init(named: "")
                cell.chcekMarkImgView.borderWidth = 1
                cell.chcekMarkImgView.borderColor = UIColor.init(hex: 0x8FA1B4)
                GeneralFunctions.setImgTintColor(imgView: cell.chcekMarkImgView, color: UIColor.clear)
            }else if item.get("isSimpleText").uppercased() == "YES" {
                cell.viewContent.backgroundColor =  UIColor(hex: 0xf6f6f6)
                cell.viewContent.alpha = 1
                cell.chcekMarkImgView.isHidden = true
                cell.descriptionLbl.textColor = SColors.blackColor
                cell.descriptionLbl.numberOfLines = 0
                cell.viewContent.layer.borderWidth = 00
                cell.viewContent.layer.borderColor =  UIColor.clear.cgColor
                cell.viewContent.shadowColor = UIColor.clear
                cell.viewContent.shadowOffset = CGSize(width: 0, height: 0.0)
                cell.viewContent.shadowRadius = 0.0
                cell.viewContent.shadowOpacity = 0.0
                cell.viewContent.masksToBounds = false
                cell.chcekMarkImgView.borderWidth = 1
                cell.chcekMarkImgView.borderColor = UIColor.init(hex: 0x8FA1B4)
                cell.chcekMarkImgView.image = UIImage.init(named: "")
                GeneralFunctions.setImgTintColor(imgView: cell.chcekMarkImgView, color: UIColor.clear)
            }
            else{
                cell.viewContent.layer.borderWidth = 00
                cell.viewContent.layer.borderColor =  UIColor.clear.cgColor
                cell.titleLbl.textColor = SColors.Theme
                cell.descriptionLbl.textColor = UIColor(hex: 0x1B2A3B)
                cell.hintLbl.textColor = UIColor(hex: 0x8FA1B4)
                cell.hintLbl2.textColor = UIColor(hex: 0x8FA1B4)
                cell.viewContent.backgroundColor =  UIColor.white
                cell.viewContent.alpha = 1
                cell.chcekMarkImgView.isHidden = false
                cell.chcekMarkImgView.borderWidth = 1
                cell.chcekMarkImgView.borderColor = UIColor.init(hex: 0x8FA1B4)
                cell.chcekMarkImgView.image = UIImage.init(named: "")
                GeneralFunctions.setImgTintColor(imgView: cell.chcekMarkImgView, color: UIColor.clear)
                //cell.chcekMarkImgView.image = Ui
                cell.descriptionLbl.numberOfLines = 0
            }
            cell.viewContent.handleClick { instance in
                if item.get("isDisabled").uppercased() != "YES" && item.get("isSimpleText").uppercased() != "YES" {
                   
                    self.selectdPaymentId = self.paymentPlanArray[indexPath.item].get("iPaymentPlanId")
                    self.selectdPaymentIndex = indexPath.item
                    self.step9TblView.reloadData()
                   
                }
            }
            
//            self.step9TblView.isUserInteractionEnabled = true
//            cell.isUserInteractionEnabled = true
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RentSubCatTVCell", for: indexPath) as! RentSubCatTVCell
            cell.contentView.backgroundColor = SColors.ThemeTxt
            let item = self.subCatData[indexPath.item]
            cell.descriptionLbl.text = item.get("vTitle")
            Utils.createRoundedView(view: cell.arrowView, borderColor: .clear, borderWidth: 0)
            //cell.arrowView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
            if(Configurations.isRTLMode()){
                cell.arrowImageView.image = UIImage(named:"ic_arrow_righ")?.rotate(180)
            }else{
                cell.arrowImageView.image = UIImage(named:"ic_arrow_righ")
            }
            if selectedSubCategoryIndex == indexPath.row || self.rentsubCatId ==  item.get("iSubCategoryId") {
                cell.descriptionLbl.textColor = SColors.Theme
                cell.containerView.backgroundColor = SColors.Theme.light(by: 90)
            }else{
                cell.containerView.backgroundColor = UIColor.white
                cell.descriptionLbl.textColor = SColors.blackColor
            }
            if self.subCatData.count != 1 {
                if indexPath.row == 0 {
                    
                    cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                    cell.containerView.roundCorners(corners: [.topRight, .topLeft],amount: 10)
                    cell.containerViewTop.constant = 5
                    
                }else {
                    cell.containerViewTop.constant = 0
                }
                
                if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                    cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                    cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 10)
                    cell.sepratorLbl.isHidden = true
                    cell.containerViewBottom.constant = 5
                }else {
                    cell.containerViewBottom.constant = 0
                    cell.sepratorLbl.isHidden = false
                    if indexPath.row != 0 {
                        cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
                    }
                    
                    cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                }
            }else{
                cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                cell.containerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 10)
                cell.sepratorLbl.isHidden = true
                cell.containerViewBottom.constant = 5
                cell.containerViewTop.constant = 5
            }
            
            
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.step9TblView {
            var item:NSDictionary!
            item = paymentPlanArray[indexPath.row]
            if item.get("isDisabled").uppercased() != "YES" && item.get("isSimpleText").uppercased() != "YES" {
               
                self.selectdPaymentId = self.paymentPlanArray[indexPath.item].get("iPaymentPlanId")
                self.selectdPaymentIndex = indexPath.item
                self.step9TblView.reloadData()
               
            }
            
        }else{
            self.selectedSubCategoryIndex = indexPath.row
            self.rentsubCatId = self.subCatData[indexPath.row].get("iSubCategoryId")
            self.step2SubvategoryTblView.reloadData()
            
            currentStep = 2
            self.setSteps()
        }
    }
    func handlesImages(selectedFileData:Data, actionType:String, iImageId:String){
        self.setLoader(ishidden: false)
        self.step4PhotosCollectionView.isHidden = true
        var  parameters = ["type":"RentItemImages","iUserId": GeneralFunctions.getMemberd(), "iItemCategoryId": self.rentCatId, "iItemSubCategoryId": self.rentsubCatId, "iImageId": iImageId, "action_type" : actionType, "iTmpRentItemPostId" : self.TempID ]
        
        if editData != nil {
            parameters["iRentItemPostId"] = self.editData.get("iRentItemPostId")
            
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        var fileName = ""
        if self.isVideo {
            fileName = "\(Utils.currentTimeMillis()).mov"
        }else{
            fileName = "\(Utils.currentTimeMillis()).png"
        }
        if actionType == "History" ||  actionType == "Delete" {
            if actionType == "History" {
                
            }
            exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
                self.step4PhotosCollectionView.isHidden = false
                self.setLoader(ishidden: true)
                if(response != ""){
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        
                        self.photosArray.removeAll()
                        self.photosArray.insert([:] as NSDictionary, at: 0)
                        let dataArr = dataDict.arrOf("AllImages")
                        for i in 0 ..< dataArr.count{
                            let dataTemp = dataArr[i] as! NSDictionary
                            self.photosArray += [dataTemp]
                        }
                        self.step4PhotosCollectionView.reloadData()
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                        
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self)
                    
                    
                }
            })
        }else{
            exeWebServerUrl.uploadImage(fileData: selectedFileData, fileName: fileName ) { (response) -> Void in
                Utils.printLog(msgData: "response::\(response)")
                if(response != ""){
                    self.step4PhotosCollectionView.isHidden = false
                    self.setLoader(ishidden: true)
                    let dataDict = response.toDict()
                    
                    if(dataDict.get("Action") == "1"){
                        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")), uv: self)
                        self.photosArray.removeAll()
                        self.photosArray.insert([:] as NSDictionary, at: 0)
                        let dataArr = dataDict.arrOf("AllImages")
                        for i in 0 ..< dataArr.count{
                            let dataTemp = dataArr[i] as! NSDictionary
                            self.photosArray += [dataTemp]
                        }
                        self.step4PhotosCollectionView.reloadData()
                    }else{
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
            }
        }
        
    }
    func deleteImage(strTitle : String , index : Int){
        self.generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: strTitle, positiveBtn:self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: {(btnClickedId) in
            
            if(btnClickedId == 0){
                
                self.handlesImages(selectedFileData: Data(), actionType: "Delete", iImageId: self.photosArray[index].get("iRentImageId"))
                
            }
            if(btnClickedId == 1)
            {
                
            }
        })
    }
    func getPaymentPlan()  {
        self.setLoader(ishidden: false)
        self.step9PaymentPlanMainView.isHidden = true
        var  parameters = ["type":"getRentItemPaymentPlan", "iUserId":GeneralFunctions.getMemberd(),"eType" : self.eType]
        if self.editData != nil {
            parameters["iRentItemPostId"] = self.editData.get("iRentItemPostId")
        }
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            self.step9PaymentPlanMainView.isHidden = false
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.paymentPlanArray = dataDict.arrOf(Utils.message_str) as! [NSDictionary]
                   
                    self.step9TblView.reloadData()
                    for i in 0..<self.paymentPlanArray.count{
                        let tempItem = self.paymentPlanArray[i]
                        
                        if tempItem.get("isSelected") == "Yes" {
                          
                            self.selectdPaymentIndex = i
                            self.selectdPaymentId = tempItem.get("iPaymentPlanId")
                            
                            
                        }
                    }
                    Utils.delayWithSeconds(1) {
                        
                        self.step9TblView.isScrollEnabled = false
                        self.step9TblHight.constant = CGFloat.greatestFiniteMagnitude
                        self.step9TblView.reloadData()
                        self.step9TblView.layoutIfNeeded()
                        self.step9TblHight.constant = self.step9TblView.contentSize.height
                       
                        self.step9ScrollView.contentSize = CGSize(width: self.step9ScrollView.contentSize.width, height: self.step9TblHight.constant + 100)
                    }
                    
                }else{
                    
                    
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        if ishidden {
            self.viewNext.isUserInteractionEnabled = true
        }else{
            self.viewNext.isUserInteractionEnabled = false
        }
    }
    func getLocation(adress: String, lat : String , long : String)  {
        self.step5SelectLocationTxtFiled.setPlaceHolder(placeHolder: "")
        self.step5SelectLocationTxtFiled.setText(text: adress)
        self.selectedLat = lat
        self.selectedLong = long
    }
    func openDuration()  {
        var filterDataTitleList = [String]()
        let openListView = OpenListView(uv: self, containerView: self.view)
        openListView.openNewList = true
        openListView.isFromDate = true
        openListView.rentItemNewPostUV = self
        openListView.selectedItem = selectedDuration
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "Day", key: "LBL_RENT_DAY"))
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "Week", key: "LBL_RENT_WEEK"))
        filterDataTitleList.append(self.generalFunc.getLanguageLabel(origValue: "Month", key: "LBL_RENT_MONTH"))
        openListView.show(listObjects: filterDataTitleList, title: self.generalFunc.getLanguageLabel(origValue: "Select Duration", key: "LBL_SELECT_DURATION"), currentInst: openListView, .bottom , handler: { (selectedItemId) in
            self.step6DurationTextFiled.setPlaceHolder(placeHolder: "")
            self.step6DurationTextFiled.setText(text: filterDataTitleList[selectedItemId])
            
            self.step6AmountNoteLbl.text = " (" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PER") + " "    + filterDataTitleList[selectedItemId] + ")"
            if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "Day", key: "LBL_RENT_DAY") {
                self.selectedDuration = filterDataTitleList[selectedItemId]
            }else if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "Week", key: "LBL_RENT_WEEK") {
                self.selectedDuration = filterDataTitleList[selectedItemId]
            }else if filterDataTitleList[selectedItemId] == self.generalFunc.getLanguageLabel(origValue: "Month", key: "LBL_RENT_MONTH") {
                self.selectedDuration = filterDataTitleList[selectedItemId]
            }
            
            
        })
    }
    func openTimePicker() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh"
        let hours = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "mm"
        let mins = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "a"
        let amPm =  dateFormatter.string(from: date)
        
        let timeSelector = TimeSelector()
        timeSelector.timeSelected = {
            (timeSelector) in
            let tempValue = timeSelector.isAm == true ? " AM" : " PM"
            self.step7TimeTxtFiled.setText(text: String(timeSelector.hours) + ":" + String(timeSelector.minutes) + tempValue)
            self.step7TimeTxtFiled.setPlaceHolder(placeHolder: "")
        }
        timeSelector.overlayAlpha = 0.4
        timeSelector.clockTint = SColors.Theme
        timeSelector.minutes = Int(mins) ?? 12
        timeSelector.hours = Int(hours) ?? 12
        timeSelector.isAm = amPm.uppercased() == "AM" ? true : false
        timeSelector.presentOnView(view: self.view)
    }
    func validateData() -> Bool  {
        if !step1MainView.isHidden {
            if self.rentCatId == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please select rent item category", key: "LBL_RENT_SELECT_CATEGORY_VALIDATION_MSG"), uv: self)
                return false
            }
        }
        if !step2SubCategoryMainView.isHidden {
            if self.rentsubCatId == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please select rent item sub category", key: "LBL_RENT_SELECT_SUB_CATEGORY_VALIDATION_MSG"), uv: self)
                return false
            }
        }
        
        
        if !step3ItemDescriptionMainView.isHidden {
            
            var verified = ""
            for i in 0..<self.fieldObjArray.count{
                
                let item = self.fieldObjArray[i] as NSDictionary
                
                if item["eInputType"] as! String == "Select"
                {
                    if (item["selectedId"] as! String == "-1" || item.get("selectedId").trimmed.isEmpty) && item["eRequired"] as! String == "Yes"
                    {
                        let valueAdded = (Utils.checkText(textField: (item["Object"] as! MyTextField).getTextField()!)) ? true : Utils.setErrorFields(textField: (item["Object"] as! MyTextField).getTextField()!, error: "")
                        if valueAdded == false
                        {
                            verified = "-1"
                        }
                    }
                    
                }else if item["eInputType"] as! String == "Textarea"{
                    
                    if ((item["Object"] as! KMPlaceholderTextView).text ?? "").trimmed.isEmpty && item["eRequired"] as! String == "Yes"
                    {
                        
                        verified = "-1"
                    }
                    
                }else{
                    
                    
                    if item["eRequired"] as! String == "Yes"
                    {
                        let valueAdded = (Utils.checkText(textField: (item["Object"] as! MyTextField).getTextField()!)) ? true : Utils.setErrorFields(textField: (item["Object"] as! MyTextField).getTextField()!, error: "")
                        if valueAdded == false
                        {
                            verified = "-1"
                        }
                    }
                    
                    
                }
            }
            
            if verified == "-1"
            {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                return false
            }
            
            
        }
        if  !step4PhotosMainView.isHidden {
          
            if self.photosArray.count == 1 {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please Upload atleast 1 Image", key: "LBL_UPLOAD_IMAGE_NOTE"), uv: self)
                return false
            }
        }
        if !self.step5LocationDetailsMainView.isHidden {
            if self.step5SelectLocationTxtFiled.text == ""  ||  step5AdressTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                return false
            }
        }
        if !self.step6PricingStructureMainView.isHidden {
            if isRent {
            if self.step6AmountTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" || self.step6DurationTextFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                return false
            }
            }else{
                if self.step6AmountTxtFiled.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                    Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please enter required fileds", key: "LBL_ENTER_REQUIRED_FIELDS"), uv: self)
                    return false
                }
            }
        }
        if !step7PickUPAvalibilityMainView.isHidden {
            if !isTimeSlotValidate {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please select time slot", key: "LBL_RENT_ITEM_SELECT_TIMESLOT_VALIDATION_MSG"), uv: self)
            }
            return isTimeSlotValidate
        }
        if self.steeperArray.count - 1 == self.currentStep {
            if self.selectdPaymentId == "." {
                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please select payment plan", key: "LBL_RENT_ITEM_SELECT_PAYMENT_PLAN_VALIDATION_MSG"), uv: self)
                return false
            }
        }
        return true
    }
    
    // Get Dynamic Filds For step 3
    func getFormDetails(){
        self.setLoader(ishidden: false)
        self.step3ItemDescriptionMainView.isHidden = true
        let parameters = ["type":"getRentItemFormFields","iMemberId": GeneralFunctions.getMemberd(),"iRentItemId" : self.rentCatId, "iRentItemPostId" : postID, "eType" : self.eType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            
            if(response != ""){
                let dataDict = response.toDict()
                self.step3ItemDescriptionMainView.isHidden = false
                if(dataDict.get("Action") == "1"){
                    if dataDict.get("isBuySell") == "Yes"{
                        self.isRent = false
                    }
                    self.pickUpConfiguration = dataDict.get("IsAvailibilitySectionShow")
                    if self.isRent &&  self.pickUpConfiguration == "No"{
                        self.isPickUpAvalibiltyHide = true
                        if self.steeperArray.contains("Pick") {
                            for i in 0 ..< self.steeperArray.count{
                                if self.steeperArray[i] == "Pick"{
                                    self.steeperArray.remove(at:i)
                                    break
                                }
                            }
                        }
                        self.setNavigationBar(title: "")
                    }else if  !self.isRent {
                        self.isPickUpAvalibiltyHide = true
                        if self.steeperArray.contains("Pick") {
                            for i in 0 ..< self.steeperArray.count{
                                if self.steeperArray[i] == "Pick"{
                                    self.steeperArray.remove(at:i)
                                    break
                                }
                            }
                        }
                        self.setNavigationBar(title: "")
                    }else{
                        self.isPickUpAvalibiltyHide = false
                    }
                    self.loadAndSetData(array: dataDict.arrOf("message"))
                    
                }else{
                    if(dataDict.get(Utils.message_str) == ""){
                        self.generalFunc.setError(uv: self)
                    }else{
                        
                        self.generalFunc.setAlertMessage(uv: self, title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: self.generalFunc.getLanguageLabel(origValue: dataDict.get(Utils.message_str), key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
                            
                            self.currentStep = 0
                            self.setSteps()
                        })
                    }
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    func loadAndSetData(array:NSArray)
    {
       
        if !isLoadFirstTimeStep3 {
            for view in self.step3ItemDescriptionScrollView.subviews {
                view.removeFromSuperview()
            }
            var txtAreaCount = 0
            for i in 0..<array.count{
                
                var item = NSDictionary.init()
                
                item = array[i] as! NSDictionary
                
                
                let y = i * 65 + ((txtAreaCount * 28) + (txtAreaCount * 28))
                let y1 = i * 30
                
                
                if item.get("eInputType") == "Textarea"{
                    
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = SColors.textColor
                    headerLbl.text = item.get("vFieldName")
                    if item.get("eRequired").uppercased() == "YES" {
                        
                        finalStrTerms = NSMutableAttributedString.init(string: "")
                        finalStrTerms.append(self.getAttributedString(str: item.get("vFieldName"),color:SColors.textColor))
                        finalStrTerms.append(self.getAttributedString(str: " " + "*",color:UIColor.init(hex: 0xCA3939)))
                        
                        
                        //self.termsConditionLbl.attributedText = finalStrTerms
                        headerLbl.attributedText = finalStrTerms//item.get("vFieldName") + " *"
                    }
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.medium)
                    let obj = KMPlaceholderTextView.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 90))
                    obj.placeholder = item.get("tDesc")
                    obj.text = item.get("vAddedValue")
                    //obj.placeholderColor = .lightGray
                    obj.placeholderColor = UIColor(hex: 0x646464)
                    obj.font = UIFont.init(name: Fonts().light, size: 15)
                    obj.delegate = self
//                    obj.borderColor = UIColor.lightGray
//                    obj.borderWidth = 1
                    obj.layer.cornerRadius = 8
                    obj.borderColor = UIColor.lightGray
                    obj.borderWidth = 0.5
                    let bottomView = UIView.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 20), height: 0))
                    bottomView.backgroundColor = UIColor.lightGray
                    
                    let requiredLbl = UILabel.init(frame: CGRect(x: 10, y: 38 + y1 + y + 80, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 20), height: 20))
                    requiredLbl.font = UIFont.systemFont(ofSize: 12, weight:UIFont.Weight.thin)
                    requiredLbl.textColor = UIColor.red
                    requiredLbl.isHidden = true
                    requiredLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
                    
                    
                    
                    self.step3ItemDescriptionScrollView.addSubview(bottomView)
                    self.step3ItemDescriptionScrollView.addSubview(headerLbl)
                    self.step3ItemDescriptionScrollView.addSubview(requiredLbl)
                    
                    // obj.placeholder = item.get("vFieldName")
                    txtAreaCount = txtAreaCount + 1
                    self.step3ItemDescriptionScrollView.addSubview(obj)
                    
                    var text = ""
                    if item["text"] != nil
                    {
                        text = item.get("text")
                        obj.text = text
                    }
                    let dic2 = ["Object":obj,"bottomView":bottomView, "headerLbl":headerLbl,"requiredLbl":requiredLbl, "vFieldName":item.get("vFieldName"), "eInputType":"Textarea", "iRentFieldId":item.get("iRentFieldId"), "text":text, "eRequired":item.get("eRequired")] as [String : Any]
                    self.fieldObjArray.append(dic2)
                    
                }else if item.get("eInputType") == "Text" ||   item.get("eInputType") == "Number"{
                    
                    
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = SColors.textColor
                    headerLbl.text = item.get("tFieldName")
                    if item.get("eRequired").uppercased() == "YES" {
                        //headerLbl.text = item.get("vFieldName") + " *"
                        finalStrTerms = NSMutableAttributedString.init(string: "")
                        finalStrTerms.append(self.getAttributedString(str: item.get("vFieldName"),color:SColors.textColor))
                        finalStrTerms.append(self.getAttributedString(str: " " + "*",color:UIColor.init(hex: 0xCA3939)))
                        
                        
                        //self.termsConditionLbl.attributedText = finalStrTerms
                        headerLbl.attributedText = finalStrTerms
                    }
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.medium)
                    
                    let obj = MyTextField.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 60))
                    obj.isCardView = true
                   
                    obj.myTxtFieldDelegate = self
                    obj.onTextChangedDelegate = self

                    if item.get("vAddedValue") == "" {
                        obj.setPlaceHolder(placeHolder: item.get("tDesc"))
                    }else{
                        obj.setText(text:item.get("vAddedValue") )
                    }
                    obj.onTextChangedDelegate = self
                    self.step3ItemDescriptionScrollView.addSubview(headerLbl)
                    self.step3ItemDescriptionScrollView.addSubview(obj)
                    if item.get("eInputType") == "Number" {
                        if item.get("eAllowFloat") == "No"
                        {
                            (obj ).getTextField()!.keyboardType = .numberPad
                        }else
                        {
                            (obj ).getTextField()!.keyboardType = .decimalPad
                        }
                    }
                    
                    var text = ""
                    if item["text"] != nil
                    {
                        text = item.get("text")
                        obj.setText(text: text)
                    }
                    var tempPut = ""
                    if item.get("tempInput") == ""{
                        tempPut = item.get("eInputType")
                    }else{
                        tempPut = item.get("tempInput")
                    }
                    let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Text", "iRentFieldId":item.get("iRentFieldId"), "text":text, "eRequired":item.get("eRequired"),"tempInput" : tempPut,"tDesc" : item.get("tDesc") ] as [String : Any]
                    self.fieldObjArray.append(dic2)
                    
                }
                else if item.get("eInputType") == "Select"
                {
                    let arrObj = item["Options"] as! NSArray
                    
                    //1.
                    let headerLbl = UILabel.init(frame: CGRect(x: 15, y: 30 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 20))
                    headerLbl.textColor = SColors.textColor
                    headerLbl.text = item.get("tFieldName")
                    if item.get("eRequired").uppercased() == "YES" {
                        //headerLbl.text = item.get("vFieldName") + " *"
                        finalStrTerms = NSMutableAttributedString.init(string: "")
                        finalStrTerms.append(self.getAttributedString(str: item.get("vFieldName"),color:SColors.textColor))
                        finalStrTerms.append(self.getAttributedString(str: " " + "*",color:UIColor.init(hex: 0xCA3939)))
                        
                        
                        //self.termsConditionLbl.attributedText = finalStrTerms
                        headerLbl.attributedText = finalStrTerms
                    }
                    headerLbl.font = UIFont.systemFont(ofSize: 16, weight:UIFont.Weight.medium)
                    let obj = MyTextField.init(frame: CGRect(x: 15, y: 60 + y1 + y, width: Int(self.step3ItemDescriptionScrollView.frame.size.width - 30), height: 60))
                    //obj.addImageView(color: UIColor.black, transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)))
                    obj.isCardView = true
                    obj.addImageView(color: UIColor.init(hex: 0x8FA1B4), transform: .identity, isCustomImage: true, "ic_arrow_down",  15,15) { (imageView) in
                    }
                    obj.isCardView = true
                    //obj.setPlaceHolder(placeHolder: item.get("vFieldName"))
                    if item.get("vAddedValue") == "" {
                        obj.setPlaceHolder(placeHolder: item.get("tDesc"))
                    }else{
                        obj.setText(text:item.get("vAddedValue") )
                    }
                    
                    obj.disableMenu()
                    obj.getTextField()!.clearButtonMode = .never
                    obj.setEnable(isEnabled: false)
                    obj.myTxtFieldDelegate = self
                    obj.onTextChangedDelegate = self
                    self.step3ItemDescriptionScrollView.addSubview(headerLbl)
                    self.step3ItemDescriptionScrollView.addSubview(obj)
                    
                    
                    
//                    if item["selectedId"] != nil
//                    {
//
//                        for i in 0..<arrObj.count
//                        {
//                            let item2 = arrObj[i] as! NSDictionary
//                            if item.get("selectedId") == item2.get("iPackageTypeId")
//                            {
//                                selectedId = item.get("selectedId")
//                                obj.setText(text: item2.get("vName"))
//                            }
//                        }
//                    }
                    let selectedId = item.get("iSelectedOptioId")
                    let dic2 = ["Object":obj, "vFieldName":item.get("vFieldName"), "eInputType":"Select","selectedId":selectedId, "Options":arrObj , "iRentFieldId":item.get("iRentFieldId"), "eRequired":item.get("eRequired"),"eListing":item.get("eListing"),"tDesc" : item.get("tDesc")] as [String : Any]
                     self.fieldObjArray.append(dic2)
                    
                }
                
                self.step3ItemDescriptionScrollView.contentSize = CGSize(width: self.step3ItemDescriptionScrollView.contentSize.width, height: CGFloat(15 + y1 + y + 150))
                //self.step3DataHight.constant = self.step3ItemDescriptionScrollView.contentSize.height + 50
                self.step3ItemDescriptionScrollView.isHidden = false
                
            }
            isLoadFirstTimeStep3 = true
        }
    }
    // Calander Delegate
    func cancelTapped() {
        
    }
    
    func okTapped(selectedDate: Date?, selectedDates: [Date]?) {
        step7DateTxtFiled.setText(text: self.dateFormatter.string(from: selectedDate!))
        step7DateTxtFiled.setPlaceHolder(placeHolder: "")
        selectedToDate = self.dateFormatterForAPI.string(from: selectedDate!)
        self.curentSelectedDate = selectedDate!
    }
    func openCalender()  {
        
        let registrationDate = userProfileJson.get("RegistrationDate")
        
        let cView = OpenCalendarView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
        cView.cLocale = tempIdentifier
        cView.dtCalendarActionDelegate = self
        cView.startDate = Date()
        var dayComponent    = DateComponents()
        dayComponent.day    = 365
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
        //Utils.convertStringToDate(dateStr: registrationDate, dateFormat: "yyyy-MM-dd")
        cView.endDate = nextDate
        cView.allowsMultipleSelection = false
        cView.selDate = self.curentSelectedDate
        cView.themeColor = SColors.Theme
        cView.dotColor = SColors.Theme
        cView.setUpView()
        
        Application.window!.addSubview(cView)
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return self.photosReview.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let item = self.photosReview[index]
        var imgView:UIImageView!
        var mainView:UIView!
        var playBackImageView:UIImageView!
        
        let height = Utils.getHeightOfBanner(widthOffset: 30, ratio: "16:9")
        let heightValue = Utils.getValueInPixel(value: height)
        
        if (view == nil){
            mainView = UIView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
            mainView.backgroundColor = UIColor.clear
            
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width, height: height))
            
            imgView.backgroundColor = UIColor.systemGray5
            imgView.layer.cornerRadius = 10
            imgView.clipsToBounds = true
            //        let widthValue = Utils.getValueInPixel(value: carousel.frame.size.width - 0)
            
            
            if item.get("eFileType") != "Image" {
                playBackImageView = UIImageView.init(frame: CGRect(x:0, y:0, width: 50, height: 50))
                playBackImageView.center = imgView.center
                
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:item.get("ThumbImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                playBackImageView.image = UIImage.init(named: "ic_play_new")
                imgView.addSubview(playBackImageView)
                
            }else{
                
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:item.get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            }
            imgView.contentMode = .scaleToFill
            mainView.addSubview(imgView)
            
        }else{
            mainView = view
            for i in 0..<mainView.subviews.count{
                let view = mainView.subviews[i]
                view.removeFromSuperview()
            }
            
            imgView = UIImageView.init(frame: CGRect(x:0, y:0, width: carousel.frame.size.width - 0, height: height))
            imgView.backgroundColor = UIColor.systemGray5
            imgView.layer.cornerRadius = 10
            imgView.clipsToBounds = true
            if item.get("eFileType") != "Image" {
                playBackImageView = UIImageView.init(frame: CGRect(x:0, y:0, width: 50, height: 50))
                playBackImageView.center = imgView.center
                
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:item.get("ThumbImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
                playBackImageView.image = UIImage.init(named: "ic_play_new")
                imgView.addSubview(playBackImageView)
            }else{
                
                let widthValue = Utils.getValueInPixel(value:  carousel.frame.size.width)
                
                imgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl:item.get("vImage"), width: widthValue, height: heightValue, MAX_HEIGHT: heightValue)), placeholderImage:nil)
            }
            
            imgView.contentMode = .scaleToFill
            mainView.addSubview(imgView)
        }
        imgView.handleClick { instance in
            if let url = URL(string: item.get("vImage")) {
                UIApplication.shared.open(url)
            }
        }
        return mainView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        self.step8ImgSlider.contentOffset = CGSize(width: 0, height: 0)
        self.step8PageController.setPage(carousel.currentItemIndex)
        
        
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        
        return value
        
    }
    
    
    func PostData()  {
        //self.setLoader(ishidden: false)
        var selImgIds = ""
        if self.photosArray.count > 0 {
            for i in 0..<self.photosArray.count{
                let id = self.photosArray[i].get("iRentImageId")
                if(selImgIds == ""){
                    selImgIds = id
                }else{
                    selImgIds = selImgIds + "," + id
                }
            }
        }
        if  self.fieldObjArray.count != 0 {
            let deliveryDataArray = ([self.fieldObjArray as AnyObject] as NSArray).mutableCopy() as! NSMutableArray
            for i in 0..<deliveryDataArray.count
            {
                
                
                let itemArray = deliveryDataArray[i] as! NSArray
                for j in 0..<itemArray.count
                {
                    let dic2 = NSMutableDictionary.init()
                    let item = itemArray[j] as! NSDictionary
                    if item.get("eInputType") == "Textarea"{
                        
                       // dic2[item.get("iRentFieldId")] = (item["Object"] as! KMPlaceholderTextView).text
                        dic2["value"] = (item["Object"] as! KMPlaceholderTextView).text
                        dic2["iData"] = item.get("iRentFieldId")
                    }else if item.get("eInputType") == "Text" || item.get("eInputType") == "Number"
                    {
                        //dic2[item.get("iRentFieldId")] = (item["Object"] as! MyTextField).getTextField()!.text
                        dic2["value"] = (item["Object"] as! MyTextField).getTextField()!.text
                        dic2["iData"] = item.get("iRentFieldId")
                    }else if  item.get("eInputType") == "Select" {
                        //dic2[item.get("iRentFieldId")] = item.get("selectedId")
                        dic2["value"] = item.get("selectedId")
                        dic2["iData"] = item.get("iRentFieldId")
                    }
                    self.itemInfoArray.append(dic2)
                }
                
                
                //self.itemInfoArray.append(dic2)
            }
        }
        var parameters = ["type":"CreateRentPostData", "iMemberId":GeneralFunctions.getMemberd(),"iItemCategoryId" : self.rentCatId , "iItemSubCategoryId" : self.rentsubCatId , "iTmpRentItemPostId" : postID ,"eType" : self.eType]
        // step 3 data :
        if editData != nil {
            parameters["iRentItemPostId"] = self.editData.get("iRentItemPostId")
            if self.editData.get("eStatusOrg") == "Expired" {
                parameters["exiprePaymentPending"] = "Yes"
            }
        }
        parameters["tFieldsArr"] = self.itemInfoArray.convertToJson().condenseWhitespace()
        //step4 Data :
        parameters["vImageIds"] = selImgIds
        // step5 Data :
        parameters["vLocation"] = self.step5SelectLocationTxtFiled.text
        parameters["vLatitude"] = self.selectedLat
        parameters["vLongitude"] = self.selectedLong
        parameters["vAddress"] = self.step5AdressTextView.text
        parameters["vBuildingNo"] = self.step5HouseNoTxtFiled.text
        // step6 Data :
        parameters["fAmount"] = step6AmountTxtFiled.text
        parameters["eRentItemDuration"] = self.step6DurationTextFiled.text
        // step7 Data:
        parameters["timeslot"] = self.updatedJsonString()
        if self.secureNoSwitch{
            parameters["eIsUserNumberDisplay"] = "Yes"
        }else{
            parameters["eIsUserNumberDisplay"] = "No"
        }
       
        if self.locationSwitch{
            parameters["eIsUserAddressDisplay"] = "Yes"
        }else{
            parameters["eIsUserAddressDisplay"] = "No"
        }
        //parameters["dPickupAvailableDate"] = self.selectedToDate
        //parameters["dPickupAvailableTime"] = self.step7TimeTxtFiled.text
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
           // self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.reviewData = dataDict.dictOf(Utils.message_str)
                    self.postID = dataDict.dictOf(Utils.message_str).get("iTmpRentItemPostId")
                    self.TempID = dataDict.dictOf(Utils.message_str).get("iTmpRentItemPostId")
                    self.setStep8Review()
                    self.addslotStep8()
                }else{
                    
                    
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func finalPayment()  {
        
        //self.setLoader(ishidden: false)
        let parameters = ["type":"GenerateFinalPost", "iMemberId":GeneralFunctions.getMemberd(), "iTmpRentItemPostId" : self.postID, "iPaymentPlanId" :  self.selectdPaymentId,"eType" : self.eType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            //self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if dataDict.get("RENTITEM_PAYMENT_URL") == "" {
                        self.loadTripFinishView()
                    }else{
                        GeneralFunctions.addPayment(url: dataDict.get("RENTITEM_PAYMENT_URL"), uv: self)
                    }
                    
                }else{
                    
                    
                    
                }
                
            }else{
                self.generalFunc.setError(uv: self)
                
                
            }
        })
    }
    func loadTripFinishView(){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        let title =  self.generalFunc.getLanguageLabel(origValue: "", key:"LBL_RENT_POST_SUCCESS_TXT")
        let desc = self.generalFunc.getLanguageLabel(origValue: "Currently your listing is under review, you will be informed once its approved and published.", key:"LBL_RENT_POST_SUCCESS_MSG")
        opnTripFinishView.isNewDialouge = true
        opnTripFinishView.isFromNewPost = true
        opnTripFinishView.eType = self.eType
        opnTripFinishView.newbtnNegativeTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK")
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_VIEW_ITEMS_USER_TXT")
        
        opnTripFinishView.show(title: title, desc:desc ) {
            
            //self.navigationController?.popViewController(animated: true)
//            let rentItemListUV = GeneralFunctions.instantiateViewController(pageName: "RentItemListUV") as! RentItemListUV
//            rentItemListUV.eType = self.eType
//            rentItemListUV.isFromMyList = true
//            self.push(uv: rentItemListUV)
            
        }
    }
    func getAttributedString(str:String,color:UIColor) -> NSMutableAttributedString
    {
        let string_to_color = str
        
        let range = (string_to_color as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:string_to_color)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    @objc func selectTime(sender: UITapGestureRecognizer){
        
        let index = sender.view!.tag
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "hh:mm a"
        var currentTime = dateFormatter.string(from: date)
        if index == self.monSlot1ToVw.tag{
            if !self.monSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.monSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        
        if index == self.tueSlot1ToVw.tag{
            if !self.tueSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.tueSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        if index == self.wedSlot1ToVw.tag{
            if !self.wedSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.wedSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        
        if index == self.thuSlot1ToVw.tag{
            if !self.thuSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.thuSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        if index == self.friSlot1ToVw.tag{
            if !self.friSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.friSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        if index == self.satSlot1ToVw.tag{
            if !self.satSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.satSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        
        if index == self.sunSlot1ToVw.tag{
            if !self.sunSlot1fromTimeLbl.text!.contains(find: "AM".uppercased())  && !self.satSlot1fromTimeLbl.text!.contains(find: "PM".uppercased()) {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_FROM_TIME"))
                return
            }
        }
        
        switch(index){
        case (self.monSlot1FromVw.tag):
            //currentTime =  self.monSlot1fromTimeLbl.text == "" ? currentTime : self.monSlot1fromTimeLbl.text!
            break;
        case (self.monSlot1ToVw.tag):
            
            //currentTime = self.monSlot1ToTimeLbl.text == "" ? currentTime : self.monSlot1ToTimeLbl.text!
            break;
        case (self.tueSlot1FromVw.tag):
            //currentTime =  self.tueSlot1fromTimeLbl.text == "" ? currentTime : self.tueSlot1fromTimeLbl.text!
            break;
        case (self.tueSlot1ToVw.tag):
            
            //currentTime = self.tueSlot1ToTimeLbl.text == "" ? currentTime : self.tueSlot1ToTimeLbl.text!
            break;
        case (self.wedSlot1FromVw.tag):
            //currentTime =  self.wedSlot1fromTimeLbl.text == "" ? currentTime : self.wedSlot1fromTimeLbl.text!
            break;
        case (self.wedSlot1ToVw.tag):
            
            //currentTime = self.wedSlot1ToTimeLbl.text == "" ? currentTime : self.wedSlot1ToTimeLbl.text!
            break;
        case (self.thuSlot1FromVw.tag):
            //currentTime =  self.thuSlot1fromTimeLbl.text == "" ? currentTime : self.thuSlot1fromTimeLbl.text!
            break;
        case (self.thuSlot1ToVw.tag):
            
            //currentTime = self.thuSlot1ToTimeLbl.text == "" ? currentTime : self.thuSlot1ToTimeLbl.text!
            break;
        case (self.friSlot1FromVw.tag):
            //currentTime =  self.friSlot1fromTimeLbl.text == "" ? currentTime : self.friSlot1fromTimeLbl.text!
            break;
        case (self.friSlot1ToVw.tag):
            
            //currentTime = self.friSlot1ToTimeLbl.text == "" ? currentTime : self.friSlot1ToTimeLbl.text!
            break;
        case (self.satSlot1FromVw.tag):
            //currentTime =  self.satSlot1fromTimeLbl.text == "" ? currentTime : self.satSlot1fromTimeLbl.text!
            break;
        case (self.satSlot1ToVw.tag):
            
            //currentTime = self.satSlot1ToTimeLbl.text == "" ? currentTime : self.satSlot1ToTimeLbl.text!
            break;
        case (self.sunSlot1FromVw.tag):
            //currentTime =  self.sunSlot1fromTimeLbl.text == "" ? currentTime : self.sunSlot1fromTimeLbl.text!
            break;
        case (self.sunSlot1ToVw.tag):
            
            // currentTime = self.sunSlot1ToTimeLbl.text == "" ? currentTime : self.sunSlot1ToTimeLbl.text!
            break;
            
            
        default:
            break;
        }
        
        DatePickerDialog().show(self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TIME_TXT"), doneButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_TXT"), cancelButtonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"),defaultDate: dateFormatter.date(from: currentTime)!, minimumDate: nil, maximumDate: nil, datePickerMode: UIDatePicker.Mode.time) {
            (date) -> Void in
            
            if(date != nil){
                self.isTimeSlotValidate = true
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_GB")
                dateFormatter.dateFormat = "HH:mm"
                
                let dateString = dateFormatter.string(from: date!)
                
                switch(index){
                case (self.monSlot1FromVw.tag):
                    self.vFromMonTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    self.validateTimeFrom(fromTime: dateFormatter.string(from: date!), toTime:  self.monSlot1ToTimeLbl.text!, lbl:self.monSlot1fromTimeLbl, display: dateFormatter.string(from: date!) )
                    self.monSlot1fromTimeLbl.textColor = SColors.textColor
                    // self.monSlot1fromTimeLbl.text = dateFormatter.string(from: date!)
                    
                    
                    
                    
                    break;
                case (self.monSlot1ToVw.tag):
                    self.vToMonTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    //self.monSlot1ToTimeLbl.text = dateFormatter.string(from: date!)
                    self.validateTimeFrom(fromTime:self.monSlot1fromTimeLbl.text! , toTime:  dateFormatter.string(from: date!), lbl:  self.monSlot1ToTimeLbl ,display: dateFormatter.string(from: date!))
                    self.monSlot1ToTimeLbl.textColor = SColors.textColor
                    
                    break;
                case (self.tueSlot1FromVw.tag):
                    self.vFromTueTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    self.tueSlot1fromTimeLbl.text = dateFormatter.string(from: date!)
                    
                    self.validateTimeFrom(fromTime: dateFormatter.string(from: date!) , toTime:  self.tueSlot1ToTimeLbl.text!, lbl: self.tueSlot1fromTimeLbl,display: dateFormatter.string(from: date!))
                    self.tueSlot1fromTimeLbl.textColor = SColors.textColor
                    
                    break;
                case (self.tueSlot1ToVw.tag):
                    self.vToTueTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    self.validateTimeFrom(fromTime: self.tueSlot1fromTimeLbl.text! , toTime:  dateFormatter.string(from: date!), lbl: self.tueSlot1ToTimeLbl, display: dateFormatter.string(from: date!))
                    self.tueSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                case (self.wedSlot1FromVw.tag):
                    self.vFromWedTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    self.validateTimeFrom(fromTime: dateFormatter.string(from: date!) , toTime:  self.wedSlot1ToTimeLbl.text!, lbl: self.wedSlot1fromTimeLbl,display: dateFormatter.string(from: date!))
                    self.wedSlot1fromTimeLbl.textColor = SColors.textColor
                    
                    break;
                case (self.wedSlot1ToVw.tag):
                    self.vToWedTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    self.validateTimeFrom(fromTime: self.wedSlot1fromTimeLbl.text! , toTime:  dateFormatter.string(from: date!), lbl:self.wedSlot1ToTimeLbl ,display: dateFormatter.string(from: date!))
                    self.wedSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                case (self.thuSlot1FromVw.tag):
                    self.vFromThuTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    
                    //
                    self.validateTimeFrom(fromTime: dateFormatter.string(from: date!) , toTime:  self.thuSlot1ToTimeLbl.text!, lbl:self.thuSlot1fromTimeLbl ,display: dateFormatter.string(from: date!))
                    //                    }
                    self.thuSlot1fromTimeLbl.textColor = SColors.textColor

                    break;
                case (self.thuSlot1ToVw.tag):
                    self.vToThuTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    self.validateTimeFrom(fromTime: self.thuSlot1fromTimeLbl.text! , toTime:  dateFormatter.string(from: date!), lbl: self.thuSlot1ToTimeLbl,display: dateFormatter.string(from: date!))
                    self.thuSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                case (self.friSlot1FromVw.tag):
                    self.vFromFriTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    self.validateTimeFrom(fromTime:dateFormatter.string(from: date!) , toTime:self.friSlot1ToLbl.text!  , lbl: self.friSlot1fromTimeLbl,display: dateFormatter.string(from: date!))
                    self.friSlot1fromTimeLbl.textColor = SColors.textColor

                    break;
                case (self.friSlot1ToVw.tag):
                    self.vToFriTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    self.validateTimeFrom(fromTime: self.friSlot1fromTimeLbl.text! , toTime: dateFormatter.string(from: date!)  , lbl: self.friSlot1ToTimeLbl,display: dateFormatter.string(from: date!))
                    self.friSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                case (self.satSlot1FromVw.tag):
                    self.vFromSatTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    
                    self.validateTimeFrom(fromTime: dateFormatter.string(from: date!), toTime:  self.satSlot1ToTimeLbl.text!, lbl: self.satSlot1fromTimeLbl,display: dateFormatter.string(from: date!))
                    //}
                    self.satSlot1fromTimeLbl.textColor = SColors.textColor

                    break;
                case (self.satSlot1ToVw.tag):
                    self.vToSatTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    
                    self.validateTimeFrom(fromTime:  self.satSlot1fromTimeLbl.text! ,toTime: dateFormatter.string(from: date!) , lbl:self.satSlot1ToTimeLbl,display: dateFormatter.string(from: date!))
                    self.satSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                case (self.sunSlot1FromVw.tag):
                    self.vFromSunTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    
                    
                    self.validateTimeFrom(fromTime:  dateFormatter.string(from: date!) , toTime:  self.sunSlot1ToTimeLbl.text!, lbl:self.sunSlot1fromTimeLbl ,display: dateFormatter.string(from: date!) )
                    //}
                    self.sunSlot1fromTimeLbl.textColor = SColors.textColor

                    break;
                case (self.sunSlot1ToVw.tag):
                    self.vToSunTimeSlot1 = dateString
                    dateFormatter.locale = Locale(identifier: Configurations.getGoogleMapLngCode())
                    dateFormatter.dateFormat = "hh:mm a"
                    self.sunSlot1ToTimeLbl.text = dateFormatter.string(from: date!)
                    self.validateTimeFrom(fromTime:  self.sunSlot1fromTimeLbl.text! , toTime: dateFormatter.string(from: date!), lbl: self.sunSlot1ToTimeLbl,display: dateFormatter.string(from: date!))
                    self.sunSlot1ToTimeLbl.textColor = SColors.textColor

                    break;
                    
                    
                default:
                    break;
                }
            }
        }
    }
    func updatedJsonString() -> String{
        
        let Dict1 = ["vMonFromSlot" :  vFromMonTimeSlot1 , "vMonToSlot" : vToMonTimeSlot1 , "dayname" : self.timeSlot[0].get("dayname"), "field" : self.timeSlot[0].get("field")] as NSDictionary
        let Dict2 = ["vTueFromSlot" :  vFromTueTimeSlot1 , "vTueToSlot" : vToTueTimeSlot1 , "dayname" : self.timeSlot[1].get("dayname"), "field" : self.timeSlot[1].get("field")] as NSDictionary
        let Dict3 = ["vWedFromSlot" :  vFromWedTimeSlot1 , "vWedToSlot" : vToWedTimeSlot1 , "dayname" : self.timeSlot[2].get("dayname"), "field" : self.timeSlot[2].get("field")] as NSDictionary
        let Dict4 = ["vThuFromSlot" :  vFromThuTimeSlot1 , "vThuToSlot" : vToThuTimeSlot1 , "dayname" : self.timeSlot[3].get("dayname"), "field" : self.timeSlot[3].get("field")] as NSDictionary
        let Dict5 = ["vFriFromSlot" :  vFromFriTimeSlot1 , "vFriToSlot" : vToFriTimeSlot1 , "dayname" : self.timeSlot[4].get("dayname"), "field" : self.timeSlot[4].get("field")] as NSDictionary
        let Dict6 = ["vSatFromSlot" :  vFromSatTimeSlot1 , "vSatToSlot" : vToSatTimeSlot1 , "dayname" : self.timeSlot[5].get("dayname"), "field" : self.timeSlot[5].get("field")] as NSDictionary
        let Dict7 = ["vSunFromSlot" :  vFromSunTimeSlot1 , "vSunToSlot" : vToSunTimeSlot1 , "dayname" : self.timeSlot[6].get("dayname"), "field" : self.timeSlot[6].get("field")] as NSDictionary
        var temp = [NSDictionary] ()
        temp.append(Dict1)
        temp.append(Dict2)
        temp.append(Dict3)
        temp.append(Dict4)
        temp.append(Dict5)
        temp.append(Dict6)
        temp.append(Dict7)
        
        return temp.convertToJson()
    }
    func validateTimeFrom(fromTime : String , toTime : String, lbl : MyLabel, display : String){
        if toTime.contains(find: "AM".uppercased()) ||  toTime.contains(find: "PM".uppercased()) {
            let f = DateFormatter()
            f.dateFormat = "hh:mm a"
            if f.date(from: fromTime)! >= f.date(from: toTime)! {
                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_TO_GREATER_FROM_TXT"))
                return
            }else{
                lbl.text = display
            }
        }else{
            lbl.text = display
        }
    }
    func deleteImages()  {
        let parameters = ["type": "DeleteRentItemImages", "iMemberId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
            }else{
            }
        })
    }
    func getOptionsName(array:NSArray) -> [String]
    {
        var returnArray = [String]()
        for i in 0..<array.count{
            let item = array[i] as! NSDictionary
            returnArray.append(item.get("vFieldName"))
        }
        return returnArray
    }
    override func close(){
        generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: generalFunc.getLanguageLabel(origValue: "", key: ""), content: generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_EXIT_CONFIRMATION_TXT") , positiveBtn:generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: {(btnClickedId) in
            
            if(btnClickedId == 0){
                if(self.navigationController == nil || self.navigationController?.viewControllers.count == 1){
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        })
        return
        
    }
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Copy", key: "LBL_RENT_ADDRESS_COPY_CLIPBOARD") , uv: self)
       UIPasteboard.general.string = self.step8locationLbl.text
    }
}
