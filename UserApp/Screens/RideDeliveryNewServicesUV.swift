//
//  RideDeliveryNewServicesUV.swift
//  
//
//  Created by # Admin on 22/03/23.
//

import UIKit
import SysBaseLib
class RideDeliveryNewServicesUV:  ParentViewUV,ParentViewUVDelegate,UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeTabBar:HomeScreenTabBarUV!
    var servicesRowDataArray = NSMutableArray()
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    var moreServicesView:SDragViewForMoreServicesRD!
    var moreServicesBGView:UIView!
    var btnSheetCollectionView:UICollectionView!
    var selectedServiceParentID = ""
    var selectedCategoryIds = [NSMutableDictionary]()
    var moreDataFor22 = [NSDictionary] ()
    var titleView:MyLabel!
    var moreTitle = ""
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tblView: UITableView!
    var cntView:UIView!
    @IBOutlet weak var mainPHView: UIView!
    @IBOutlet weak var phView1: UIView!
    @IBOutlet weak var phView2: UIView!
    @IBOutlet weak var phView3: UIView!
    @IBOutlet weak var phView4: UIView!
    @IBOutlet weak var phView5: UIView!
    @IBOutlet weak var phView6: UIView!
    @IBOutlet weak var phView7: UIView!
    @IBOutlet weak var phView8: UIView!
    @IBOutlet weak var phView9: UIView!
    @IBOutlet weak var phView13: UIView!
    @IBOutlet weak var phView14: UIView!
    @IBOutlet weak var phView10: UIView!
    @IBOutlet weak var phView11: UIView!
    var placeholderMarker:Placeholder!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        if (type == 0) {
            
            cntView = self.generalFunc.loadView(nibName: "RideDeliveryNewServicesScreenDesign", uv: self, contentView: contentView)
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            self.contentView.addSubview(cntView)
            self.getServices()
        }else if (type == 1) {
            self.tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
            self.setData()
        }else if (type == 2){
            
        }
    }
    func setData(){
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
        label.font = UIFont(name: Fonts().regular, size: 18)!
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = self.generalFunc.getLanguageLabel(origValue: "Services", key: "LBL_SERVICES")
        label.textColor = SColors.ThemeTxt
        if(self.homeTabBar != nil){
            self.homeTabBar.navItem.titleView = label
        }else {
            self.navigationItem.titleView = label
        }
        
        userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            self.tblView.sectionHeaderTopPadding = 0
        } else {}
        self.tblView.register(UINib(nibName: "UFXProTitleViewTVCell", bundle: nil), forCellReuseIdentifier: "UFXProTitleViewTVCell")
        self.tblView.register(UINib(nibName: "RdServicesTVC", bundle: nil), forCellReuseIdentifier: "RdServicesTVC")
    }
    func getServices(){
        
        
        if(self.servicesRowDataArray.count == 0){
            self.setPlaceHolderView()
        }
        
        
        let parameters = ["type":"getAllServiceCategories", "userId": GeneralFunctions.getMemberd()]
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    
                    self.setRowDataArray(dataDic:dataDict)
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else {
                self.generalFunc.setError(uv: self)
            }
            
        })
        
    }
    func setRowDataArray(dataDic:NSDictionary){
        
        self.removePlaceHolderView()
        self.servicesRowDataArray.removeAllObjects()
        let dataArray = dataDic.arrOf("SERVICES_SCREEN_DATA")
        
        for i in 0..<dataArray.count{
            
            let dict = dataArray[i] as! NSDictionary
            if(dict.get("eViewType") == "IntroView"){
                
                let uFXProTitleView = UFXProTitleView(eViewType: dict.get("eViewType"), titleText: dict.get("vTitle"), subTitleText: dict.get("vSubtitle"), vImage: dict.get("vImage"),isShowAll:dict.get("isShowAll"),topPadding: dict.get("AddTopPadding"))
                self.servicesRowDataArray.add(uFXProTitleView)
                
            }else if(dict.get("eViewType") == "BannerView"){
                
                let uFXProBannerView1 = UFXProBannerView(isScroll: (dict.get("isScroll") == "Yes" ? true : false), bannerHeight: GeneralFunctions.parseDouble(origValue: 0.0, data: dict.get("vImageHeight")), bannerWidth: GeneralFunctions.parseDouble(origValue: 0.0, data: dict.get("vImageWidth")), imagesArray: dict.arrOf("imagesArr") as! [NSDictionary], displayCount: GeneralFunctions.parseInt(origValue: 0, data: dict.get("displayCount")), isFullWidth: (dict.get("isFullView") == "Yes" ? true : false), isBookBtn:(dict.get("BookBtn") == "Yes" ? true : false), bookBtnTxt:dict.get("BookBtnText"), isClickable:(dict.get("isClickable") == "Yes" ? true : false), isOnlyImage:(dict.get("isOnlyImage") == "Yes" ? true : false), AddTopPadding:(dict.get("AddTopPadding") == "Yes" ? true : false), AddBottomPadding:(dict.get("AddBottomPadding") == "Yes" ? true : false), eServiceType: (dict.get("eServiceType")),displaySize : dict.get("DisplaySize") )
                self.servicesRowDataArray.add(uFXProBannerView1)
            }else if(dict.get("eViewType") == "TitleView"){
                
                let uFXProTitleView = UFXProTitleView(titleText: dict.get("vTitle"), subTitleText: dict.get("vSubtitle"),isShowAll:dict.get("isShowAll"),topPadding: dict.get("AddTopPadding"))
                self.servicesRowDataArray.add(uFXProTitleView)
                
            }
            self.tblView.reloadData()
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.servicesRowDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(self.servicesRowDataArray[indexPath.row] as? UFXProTitleView != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UFXProTitleViewTVCell", for: indexPath) as! UFXProTitleViewTVCell
            
            let uFXProTitleView = self.servicesRowDataArray[indexPath.row] as! UFXProTitleView
            cell.seeAllLbl.isHidden = true
            cell.imagView.isHidden = true
            cell.titleLbl.font = UIFont.init(name: Fonts().regular, size: 22)
            cell.titleLbl.setFontFamily()
            cell.titleLbl.text = uFXProTitleView.titleText
            
            if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
                if uFXProTitleView.topPadding == "No" {
                    cell.titleLblTop.constant = 0
                }else{
                    cell.titleLblTop.constant = 15
                }
            }
            cell.titleLeading.constant = 20
            cell.subTitleLbl.text = uFXProTitleView.subTitleText
            return cell
        }else if(self.servicesRowDataArray[indexPath.row] as? UFXProBannerView != nil){
            
            let uFXProBannerView = self.servicesRowDataArray[indexPath.row] as! UFXProBannerView
            let cell = tableView.dequeueReusableCell(withIdentifier: "RdServicesTVC", for: indexPath) as! RdServicesTVC
            cell.uFXProBannerView = uFXProBannerView
            cell.view1.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vBgColor"), alpha: 1)
            cell.titleLbl1.text = uFXProBannerView.imagesArray[0].get("vCategoryTitle")
            cell.titleLbl1.textColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[0]).get("vTextColor"), alpha: 1)
            
            //cell.imageView1.contentMode = .bottomRight
            cell.imageView1.contentMode = .scaleAspectFill
            Utils.delayWithSeconds(1) {
                let ratio =  GeneralFunctions.parseDouble(origValue: 1.0, data: (uFXProBannerView.imagesArray[0]).get("vImageWidth")) / GeneralFunctions.parseDouble(origValue: 1.0, data: (uFXProBannerView.imagesArray[0]).get("vImageHeight"))
                 var hight = Float(cell.view1.frame.size.height) / Float(ratio)
                cell.image1Hight.constant = CGFloat(hight)
                cell.image1Width.constant = cell.view1.frame.size.height
//                 if uFXProBannerView.displaySize == "Big"{
//                     if uFXProBannerView.displayCount == 1 {
//                         hight = Float(cell.view1.frame.size.height) + 8
//                         cell.image1Hight.constant = CGFloat(hight)
//                         cell.image1Width.constant = CGFloat(hight)
//                     }else{
//                         hight = Float(cell.view1.frame.size.width - 50) / Float(ratio)
//                         cell.image1Hight.constant = CGFloat(hight)
//                         cell.image1Width.constant = cell.view1.frame.size.width - 50
//                     }
//                 }
                 let vImage = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[0]).get("vImage"), width: Utils.getValueInPixel(value: cell.image1Width.constant) , height: Utils.getValueInPixel(value: CGFloat(hight)))
                cell.imageView1.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                 })
                cell.titileTraing.constant = cell.image1Width.constant - 5
            }
          

            
            if uFXProBannerView.displaySize == "Big"{
                cell.titleLbl1.font = UIFont.init(name: Fonts().bold, size: 20)
                cell.titileLbl2.font = UIFont.init(name: Fonts().bold, size: 20)
                cell.titleLblTop.constant = 20
                cell.titleLbl2Top.constant = 20
                cell.view1.cornerRadius = 16
                cell.view2.cornerRadius = 16
            }else{
                cell.titleLbl1.font = UIFont.init(name: Fonts().bold, size: 12 )
                cell.titileLbl2.font = UIFont.init(name: Fonts().bold, size: 12)
                cell.titleLblTop.constant = 8
                cell.titleLbl2Top.constant = 8
                cell.view1.cornerRadius = 8
                cell.view2.cornerRadius = 8
                
            }
            cell.view1.handleClick { instance in
               
                var item = uFXProBannerView.imagesArray[0]
               
                
                if (item.arrOf("servicesArr").count) > 1{
                    self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
                }else{
                    _ = OpenCatType(uv: self, navItem: self.homeTabBar.navItem, item: item)
                }
            }
            if uFXProBannerView.displayCount == 2 {
                cell.view2.isHidden = false
                cell.view2.backgroundColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[1]).get("vBgColor"), alpha: 1)
                cell.titileLbl2.text = uFXProBannerView.imagesArray[1].get("vCategoryTitle")
                cell.titileLbl2.textColor = UIColor.init(hexString: (uFXProBannerView.imagesArray[1]).get("vTextColor"), alpha: 1)
                
                
                
                cell.imageView2.contentMode = .scaleAspectFill
                Utils.delayWithSeconds(1) {
                    let ratio =  GeneralFunctions.parseDouble(origValue: 1.0, data: (uFXProBannerView.imagesArray[1]).get("vImageWidth")) / GeneralFunctions.parseDouble(origValue: 1.0, data: (uFXProBannerView.imagesArray[1]).get("vImageHeight"))
                    var hight = Float(cell.view2.frame.size.height) / Float(ratio)
                    cell.image2Hight.constant = CGFloat(hight)
                    cell.image2Width.constant = cell.view2.frame.size.height
//                     if uFXProBannerView.displaySize == "Big"{
//                         hight = Float(cell.view2.frame.size.width - 50) / Float(ratio)
//                         cell.image2Hight.constant = CGFloat(hight)
//                         cell.image2Width.constant = cell.view2.frame.size.width - 50
//                     }
                     let vImage = Utils.getResizeImgURL(imgUrl: (uFXProBannerView.imagesArray[1]).get("vImage"), width: Utils.getValueInPixel(value: cell.image2Width.constant) , height: Utils.getValueInPixel(value: CGFloat(hight)))
                    cell.imageView2.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                     })
                    cell.title2Trailng.constant = cell.image2Width.constant - 5
                }
               
                cell.view2.handleClick { instance in
                    var item = uFXProBannerView.imagesArray[1]
                    if (item.arrOf("servicesArr").count) > 1{
                        self.openMoreView(dataArray: item.arrOf("servicesArr") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
                    }else{
                        _ = OpenCatType(uv: self, navItem: self.homeTabBar.navItem, item: item)
                    }
                }
                
            }else {
                cell.view2.isHidden = true
            }
            return cell
            
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.servicesRowDataArray[indexPath.row] as? UFXProTitleView != nil){
            let uFXProTitleView = self.servicesRowDataArray[indexPath.row] as! UFXProTitleView
            if uFXProTitleView.topPadding == "Yes"{
                return 50
            }
            else{
                return 35
            }
        }else{
            let uFXProBannerView = self.servicesRowDataArray[indexPath.row] as! UFXProBannerView
            if uFXProBannerView.displayCount == 1 {
                return Utils.getHeightOfBanner(widthOffset: 40, ratio: "", 4.0)
            }
            else if uFXProBannerView.displaySize == "Big" {
                return Utils.getHeightOfBanner(widthOffset: 40, ratio: "", 3.1)
            }
            return Utils.getHeightOfBanner(widthOffset: 40, ratio: "", 4.0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moreDataFor22.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        cell.cntView.clipsToBounds = true
        cell.cntView.layer.cornerRadius = 10.0
        cell.cntView.layer.borderColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.borderWidth = 0.5
        cell.cntView.layer.shadowColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cntView.layer.shadowRadius = 1.5
        cell.cntView.layer.shadowOpacity = 1
        cell.cntView.layer.masksToBounds = false
        
        let item = self.moreDataFor22[indexPath.item]
        cell.serTitleLbl.text = item.get("vCategory")
        cell.serTitleLbl.textColor = UIColor(hex: 0x1B2A3B)
        
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: 56) , height: Utils.getValueInPixel(value: 56))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            cell.cntView.layer.cornerRadius = 10.0
        })
        
        // cell.imageParentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
        cell.imageParentView.cornerRadius = 23
        cell.imageParentView.isHidden = false
        cell.serImgView.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 120.0
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            width = 150.0
        }
        //var height = 140.0
        
        let applicationWidth = Application.screenSize.width
        
        var boxMaxCount = Int((applicationWidth / width).rounded(.towardZero))
        var extraSpace =  Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) - Double((boxMaxCount * 15) + 15)
        extraSpace = abs(extraSpace)
        if(Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) < Double((boxMaxCount * 15) + 15)){
            width = 105.0
            boxMaxCount = Int((applicationWidth / width).rounded(.towardZero))
            extraSpace =  Double((width * ((applicationWidth / width) - Double(boxMaxCount)))) - Double((boxMaxCount * 15) + 15)
        }
        
        width = width + Double((extraSpace / Double(boxMaxCount)))
        
        return CGSize(width: width, height: width * 1.21)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.closeMoreServices()
        let item = self.moreDataFor22[indexPath.row]
        
        _ = OpenCatType(uv: self, navItem: self.homeTabBar.navItem, item: item)
        
    }
    func openMoreView(dataArray:[NSDictionary], moreTitle:String){
        
        self.moreTitle = moreTitle
        
        if self.moreServicesView == nil{
            self.addMoreServiceView()
        }
        
        titleView.text = self.moreTitle
        
        self.btnSheetCollectionView.setContentOffset(CGPoint(x: self.btnSheetCollectionView.contentOffset.x, y:-self.btnSheetCollectionView.contentInset.top), animated: false)
        self.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
        self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
        self.moreServicesView.dragViewAnimatedTopMargin = 0
        self.btnSheetCollectionView.reloadData()
        self.moreServicesBGView.isHidden = false
        
        self.moreDataFor22 = dataArray
        
    }
    func addMoreServiceView(){
        
        let window = UIApplication.shared.delegate!.window!
        
        moreServicesBGView = UIView.init(frame: CGRect(x: 0, y:0 , width: (window?.frame.width)!, height: (window?.frame.height)!))
        moreServicesBGView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        moreServicesBGView.isHidden = true
        Application.window!.addSubview(moreServicesBGView)
        moreServicesView = SDragViewForMoreServicesRD(dragViewAnimatedTopSpace:0, viewDefaultHeightConstant:0, uv:self)
        Application.window!.addSubview(moreServicesView)
        
        let topBGViw:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: 44))
        topBGViw.clipsToBounds = true
        topBGViw.backgroundColor = SColors.Theme
        moreServicesView.addSubview(topBGViw)
        let stackView = UIStackView.init(frame: CGRect(x: 15, y: 0, width: Application.screenSize.width - 30 , height: topBGViw.frame.size.height))
        
        topBGViw.addSubview(stackView)
        
        
        let imgBg = UIView(frame: CGRect(x: Application.screenSize.width - 60, y: 8, width: 30, height: 30))
        if(Configurations.isRTLMode()){
            imgBg.frame =  CGRect(x: 5, y: imgBg.frame.origin.y, width: imgBg.frame.width, height: imgBg.frame.height)
        }
        imgBg.layer.cornerRadius = imgBg.frame.size.width / 2
        imgBg.clipsToBounds = true
        imgBg.backgroundColor = UIColor.white
        imgBg.handleClick { instance in
            self.closeMoreServices()
        }
        let imageViewCancel = UIImageView(frame: CGRect(x:5 , y: 5, width: 20, height: 20))
        //        if(Configurations.isRTLMode()){
        //            imgBg.frame =  CGRect(x: 10, y: 5, width: 25, height: 25)
        //        }
        imageViewCancel.image = UIImage.init(named: "cm_close_white")
        GeneralFunctions.setImgTintColor(imgView: imageViewCancel, color: SColors.Theme)
        let ViewCancelTransparent = UIImageView(frame: CGRect(x:imageViewCancel.frame.origin.x , y: 7, width: 50, height: 50))
        ViewCancelTransparent.backgroundColor = UIColor.clear
        ViewCancelTransparent.handleClick { instance in
            self.closeMoreServices()
        }
        titleView = MyLabel(frame: CGRect(x: 1, y: 0, width: Application.screenSize.width - 20, height: topBGViw.frame.size.height))
        if(Configurations.isRTLMode()){
            titleView.frame = CGRect(x: Application.screenSize.width - 60, y: 0, width:  Application.screenSize.width - 60, height: topBGViw.frame.size.height)
        }
        titleView.text = self.moreTitle
        
        titleView.textAlignment = .natural
        titleView.backgroundColor = UIColor.clear
        titleView.textColor = SColors.ThemeTxt
        titleView.font = UIFont(name: Fonts().light, size: 17)!
        // lblServiceSlect = titleView
        //stackView.addArrangedSubview(titleView)
        //stackView.addSubview(titleView)
        //stackView.addArrangedSubview((imageViewCancel))
        stackView.addSubview(titleView)
        stackView.addSubview(imgBg)
        imgBg.addSubview(imageViewCancel)
        stackView.addSubview(ViewCancelTransparent)
        
        // ADD CollectionView IN MoreServicesView
        self.btnSheetCollectionView = UICollectionView(frame: CGRect(x: 0, y: topBGViw.frame.size.height, width: Application.screenSize.width, height: Application.screenSize.height - topBGViw.frame.size.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.btnSheetCollectionView.delegate = self
        self.btnSheetCollectionView.dataSource = self
        self.btnSheetCollectionView.backgroundColor = .white
        self.btnSheetCollectionView.register(UINib(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
        self.btnSheetCollectionView.bounces = false
        self.btnSheetCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.btnSheetCollectionView.showsVerticalScrollIndicator = false
        
        self.btnSheetCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 15, bottom: 10, right: 15)
        
        self.moreServicesView.addSubview(self.btnSheetCollectionView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: topBGViw.frame.size.height),
            stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: stackView.superview!.rightAnchor, constant: 15),
        ])
    }
    
    func closeMoreServices(){
        // scrollView.setContentOffset(.zero, animated: false)
        if(moreServicesView != nil){
            
            self.moreServicesView.isFromMoremedical = false
            self.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:true, closeFull:true)
        }
    }
    @objc func moreServicesViewSwipePerformed(){
        if(self.moreServicesView.bgViewIsHidden == true){
            self.moreServicesBGView.isHidden = true
        }else{
            self.moreServicesBGView.isHidden = false
        }
    }
    
    func setPlaceHolderView(){
        
        self.mainPHView.isHidden = false
        
        placeholderMarker = Placeholder()
        let viewElements: [UIView] = [phView1, phView2, phView3, phView4, phView5, phView6, phView7, phView8, phView9, phView13, phView14 , phView10, phView11]
        
        placeholderMarker.register(viewElements)
        placeholderMarker.startAnimation()
        
    }
    
    func removePlaceHolderView(){
        if(self.mainPHView != nil){
            
            self.mainPHView.isHidden = true
        }
    }
     
    
    
}

class SDragViewForMoreServicesRD: UIView,UIGestureRecognizerDelegate {

    //  MARK: - Public properties
    public var viewCornerRadius:CGFloat = 2
    public var viewBackgroundColor:UIColor = UIColor.white
    
    
    // MARK: - Private properties
    public var dragViewAnimatedTopMargin:CGFloat = 25.0 // View fully visible (upper spacing)
    public var viewDefaultHeight:CGFloat = 80.0// View height when appear
    private var gestureRecognizer = UIPanGestureRecognizer()
    private var dragViewDefaultTopMargin:CGFloat!
    private var viewLastYPosition = 0.0
    var bgViewIsHidden = true
    
    var rideDeliveryNewServicesUV:RideDeliveryNewServicesUV!
    
    var disablePan = false
    var isFromMoremedical = false
    
    fileprivate var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    fileprivate lazy var navigationBarHeight: CGFloat = {
        return UINavigationBar().intrinsicContentSize.height
    }()
    
    required init(dragViewAnimatedTopSpace:CGFloat, viewDefaultHeightConstant:CGFloat, uv:RideDeliveryNewServicesUV)
    {
        self.rideDeliveryNewServicesUV = uv
        dragViewAnimatedTopMargin = dragViewAnimatedTopSpace
        viewDefaultHeight = viewDefaultHeightConstant
        
        let screenSize: CGRect = UIScreen.main.bounds
        dragViewDefaultTopMargin = screenSize.height - viewDefaultHeight
        
        //super.init(frame: CGRect(x: 0, y:0 , width: screenSize.width, height: screenSize.height))
        super.init(frame: CGRect(x: 0, y:dragViewDefaultTopMargin , width: screenSize.width, height: screenSize.height - dragViewAnimatedTopMargin))
        
        self.backgroundColor = viewBackgroundColor//.withAlphaComponent(0.20) //
        self.layer.cornerRadius = self.viewCornerRadius
        
        self.clipsToBounds = true

        self.layoutIfNeeded()
        
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gestureRecognizer.delegate = self
        
        self.addGestureRecognizer(gestureRecognizer)
    
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if disablePan == true || isFromMoremedical{
           
            return
        }
    
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
          
            if self.frame.origin.y <= 0.0 || self.frame.origin.y == Application.screenSize.height - 350{
                
                    self.rideDeliveryNewServicesUV.btnSheetCollectionView.isScrollEnabled = true
            }else{
                    self.rideDeliveryNewServicesUV.btnSheetCollectionView.isScrollEnabled = false
            }
            
            var newTranslation = CGPoint()
            var oldTranslation = CGPoint()
            newTranslation = gestureRecognizer.translation(in: self.superview)
            
            
            if(!(newTranslation.y < 0 && self.frame.origin.y + newTranslation.y <= dragViewAnimatedTopMargin))
            {
                self.translatesAutoresizingMaskIntoConstraints = true
                self.center = CGPoint(x: self.center.x, y: self.center.y + newTranslation.y)
                
                if (newTranslation.y < 0)
                {
                    if("\(self.frame.size.width)" != "\(String(describing: self.superview?.frame.size.width))")
                    {
                        if self.frame.size.width >= (self.superview?.frame.size.width)!
                        {
                            self.frame = CGRect(x: self.frame.origin.x, y:self.frame.origin.y , width: self.frame.size.width, height: self.frame.size.height)
                        }
                        else{
                            self.frame = CGRect(x: self.frame.origin.x, y:self.frame.origin.y , width: self.frame.size.width, height: self.frame.size.height)
                        }
                        
                    }
                }
                else
                {
                    if("\(self.frame.size.width)" != "\((self.superview?.frame.size.width)!)")
                    {
                        self.frame = CGRect(x: self.frame.origin.x, y:self.frame.origin.y , width: self.frame.size.width, height: self.frame.size.height)
                    }
                }
                
                // self.layoutIfNeeded()
                gestureRecognizer.setTranslation(CGPoint.zero, in: self.superview)
                
                oldTranslation.y = newTranslation.y
            }
            else
            {
                self.frame.origin.y = dragViewAnimatedTopMargin
                //self.isUserInteractionEnabled = false
            }
            
        }
        else if (gestureRecognizer.state == .ended)
        {
            //self.isUserInteractionEnabled = true
            let vel = gestureRecognizer.velocity(in: self.superview)
            
            
            let finalY: CGFloat = 50.0
            let curY: CGFloat = self.frame.origin.y
            let distance: CGFloat = curY - finalY
            
            let springVelocity: CGFloat = 1.0 * vel.y / distance
            
            if(springVelocity > 0 && self.frame.origin.y <= dragViewAnimatedTopMargin)
            {
                self.frame = CGRect(x: 0, y:self.frame.origin.y , width: (self.superview?.frame.size.width)!, height: self.frame.size.height)
                self.bgViewIsHidden = false
            }
            else if (springVelocity > 0)
            {
                let velocityDirection = gestureRecognizer.velocity(in: self)
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    if(self.frame.size.width != (self.superview?.frame.size.width)!)
                    {
                        self.frame = CGRect(x:0, y:self.frame.origin.y , width: (self.superview?.frame.size.width)!, height: self.frame.size.height)
                        
                    }
                    
                    if velocityDirection.y > 0{
                        if self.frame.origin.y > self.dragViewDefaultTopMargin{
                            self.dragViewDefaultTopMargin = Application.screenSize.height
                            self.frame.origin.y = self.dragViewDefaultTopMargin
                            self.bgViewIsHidden = true
                        }else{
                            
                            self.dragViewDefaultTopMargin = Application.screenSize.height - 350
                            self.frame.origin.y = self.dragViewDefaultTopMargin
                            self.bgViewIsHidden = false
                        }
                        
                    }else{
                        
                       
                        self.dragViewDefaultTopMargin = 0
                        self.frame.origin.y = self.dragViewDefaultTopMargin
                        
                       
                            self.rideDeliveryNewServicesUV.btnSheetCollectionView.setContentOffset(CGPoint(x: self.rideDeliveryNewServicesUV.btnSheetCollectionView.contentOffset.x, y:-self.rideDeliveryNewServicesUV.btnSheetCollectionView.contentInset.top), animated: true)
                        
                        
                        self.bgViewIsHidden = false
                    }
                    
                }), completion:  { (finished: Bool) in
                    
                        self.rideDeliveryNewServicesUV.moreServicesViewSwipePerformed()
                    
                    
                })
                
            }
            else if (springVelocity == 0)// If Velocity zero remain at same position
            {
                
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    self.frame.origin.y = CGFloat(self.viewLastYPosition)
                    
                    if(self.frame.origin.y == self.dragViewDefaultTopMargin)
                    {
                        if("\(self.frame.size.width)" == "\(String(describing: self.superview?.frame.size.width))")
                        {
                            self.frame = CGRect(x:0, y:self.frame.origin.y , width: self.frame.size.width, height: self.frame.size.height)
                            self.bgViewIsHidden = true
                        }
                    }
                    else{
                        if("\(self.frame.size.width)" != "\(String(describing: self.superview?.frame.size.width))")
                        {
                            self.frame = CGRect(x: 0, y:self.frame.origin.y , width: (self.superview?.frame.size.width)!, height: self.frame.size.height)
                            self.bgViewIsHidden = false
                        }
                    }
                    
                }), completion: { (finished: Bool) in
                    
                        self.rideDeliveryNewServicesUV.moreServicesViewSwipePerformed()
                    
                    
                })
            }
            else
            {
                if("\(self.frame.size.width)" != "\(String(describing: self.superview?.frame.size.width))")
                {
                    self.frame = CGRect(x: 0, y:self.frame.origin.y , width: (self.superview?.frame.size.width)!, height: self.frame.size.height)
                    
                }
                
                self.bgViewIsHidden = false
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    if self.dragViewAnimatedTopMargin == 0{
                        
                            self.rideDeliveryNewServicesUV.btnSheetCollectionView.setContentOffset(CGPoint(x: self.rideDeliveryNewServicesUV.btnSheetCollectionView.contentOffset.x, y:-self.rideDeliveryNewServicesUV.btnSheetCollectionView.contentInset.top), animated: true)
                        
                        
                    }
                    self.frame.origin.y = self.dragViewAnimatedTopMargin
                    
                }), completion: nil)
            }
            viewLastYPosition = Double(self.frame.origin.y)
            
            
                self.rideDeliveryNewServicesUV.moreServicesViewSwipePerformed()
                
                self.addGestureRecognizer(gestureRecognizer)
                self.rideDeliveryNewServicesUV.btnSheetCollectionView.isScrollEnabled = true
                
                self.setNavBarViewHeight()
            
            
            
            
        }
        
    }
 
    
    func perfomViewOpenORCloseAction(cancelTapped:Bool,closeFull:Bool) {
        
        if(cancelTapped == true)
        {
            if self.frame.origin.y <= 0.0 && closeFull == false{
                self.dragViewDefaultTopMargin = Application.screenSize.height - 350
                bgViewIsHidden = false
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    
                    self.frame = CGRect(x:0, y:self.dragViewDefaultTopMargin , width: UIScreen.main.bounds.width, height: self.frame.size.height)
                    
                    
                }), completion: nil)
                
            }else{
                UIApplication.shared.isStatusBarHidden = false
                self.dragViewDefaultTopMargin = Application.screenSize.height
                bgViewIsHidden = true
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    
                    self.frame = CGRect(x:0, y:self.dragViewDefaultTopMargin , width: UIScreen.main.bounds.width, height: self.frame.size.height)
                    
                    
                }), completion: nil)
            }
        
        }
        else{
            
            self.dragViewDefaultTopMargin = Application.screenSize.height - 350
            bgViewIsHidden = false
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
               
                self.frame = CGRect(x:0, y:self.dragViewAnimatedTopMargin , width: UIScreen.main.bounds.width, height: self.frame.size.height)
                
            }), completion: nil)
        }
       
        
        self.setNavBarViewHeight()
       
            self.rideDeliveryNewServicesUV.moreServicesViewSwipePerformed()
        
        
    }
    
    func setNavBarViewHeight(){
        
        self.layoutIfNeeded()
        
        if self.frame.origin.y <= 0.0{
            for view in self.subviews{
                if view.isKind(of: UIView.self){
                    view.frame = CGRect(x:view.frame.origin.x, y:view.frame.origin.y, width:view.frame.size.width, height: navigationBarHeight + statusBarHeight)
                    for subView in view.subviews{
                        if subView.isKind(of: UIStackView.self){
                           // subView.frame = CGRect(x:subView.frame.origin.x, y:GeneralFunctions.getSafeAreaInsets().top
                                                  //  > 0 ? 40 : 20, width:subView.frame.size.width, height: navigationBarHeight)
                      
                            subView.frame = CGRect(x:subView.frame.origin.x, y:Configurations.isIponeXDevice() ? 40 : 20, width:subView.frame.size.width, height: navigationBarHeight + statusBarHeight)
                                   

                            
                        }
                        
                    }
                }
                
                if view.isKind(of: UICollectionView.self){
                    view.frame = CGRect(x:view.frame.origin.x, y: navigationBarHeight + statusBarHeight, width:view.frame.size.width, height: Application.screenSize.height - (navigationBarHeight + statusBarHeight))
                }
            }
           
        }else{
            for view in self.subviews{
                if view.isKind(of: UIView.self){
                    view.frame = CGRect(x:view.frame.origin.x, y:view.frame.origin.y, width:view.frame.size.width, height: navigationBarHeight)
                    for subView in view.subviews{
                        if subView.isKind(of: UIStackView.self){
                            subView.frame = CGRect(x:subView.frame.origin.x, y:0, width:subView.frame.size.width, height: navigationBarHeight)
                        }
                        
                    }
                }
                
                if view.isKind(of: UICollectionView.self){
                    view.frame = CGRect(x: view.frame.origin.x, y: navigationBarHeight, width: view.frame.size.width, height:  Application.screenSize.height - navigationBarHeight)
                }
            }
           
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        }, completion:{ _ in
            
            if self.frame.origin.y == Application.screenSize.height{
                self.bgViewIsHidden = true
            }
            
        })
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (otherGestureRecognizer.view?.isKind(of: UICollectionView.self))!
        {
        
            
                self.rideDeliveryNewServicesUV.btnSheetCollectionView.bounces = true
                if self.rideDeliveryNewServicesUV.btnSheetCollectionView.contentOffset.y <= 0.0{
                  
                    disablePan = false
                    return true
                }else{
                    
                    if(self.frame.origin.y == 0){
                        disablePan = true
                        return false
                    }else{
                        disablePan = false
                        return true
                    }
                    
                }
            
            
        }else{
            
            disablePan = false
            return true
        }
    }
     

}
