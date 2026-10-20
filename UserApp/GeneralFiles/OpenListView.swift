

import UIKit
import SysBaseLib

class OpenListView: NSObject , UITableViewDataSource , UITableViewDelegate, BEMCheckBoxDelegate,MyBtnClickDelegate{
    
    typealias CompletionHandler = (_ selectedItemId:Int) -> Void
    
    typealias CompletionHandlerWithIds = (_ selectedItemIds:String) -> Void
    
    
    var currentInst:OpenListView!
    var uv:UIViewController!
    var containerView:UIView!
    var handler:CompletionHandler!
    var handlerWithIds:CompletionHandlerWithIds!
    var listView:ListView!
    var bgView:UIView!
    let generalFunc = GeneralFunctions()
    let closeImgTapGue = UITapGestureRecognizer()
    var arrListObj = [String]()
    var listHeightContainer = [CGFloat]()
    var isSelectedImageShow = false
    var textPedding:CGFloat = 15
    var navZposition:CGFloat = 0
    var isShowCheckBox = false
    var checkBoxStatusArr = [Bool]()
    var selectedItem = ""
    var isFromDate = false
    var newListView:ListBottomSheetView!
    var smartLoginBottomSheet:SmartLoginBottomSheet!
    var cameraListView:CameraBottomSheetView!
    var rentItemNewPostUV:RentItemNewPostUV!
    var openNewList = false
    var newListCodeString = [String]()
    
    var colorArray = [UIColor]()
    var textColorArray = [UIColor]()
    
    var appLoginUV:AppLoginUV!
    var editProfileUV:EditProfileUV!
    var viewProfileUV:ViewProfileUV!
    var foodPrefUV:FoodPreferencesUV!
    var signInUV:SignInUV!
    var transactionHistoryUV:TransactionHistoryUV!
    
    var startLoading = false
    var isForCurrency = false
    var isForLang = false
    var selectedIndex = -1
    
    var isForSocialAccount = false
    var isSocialLoginDisable = false
    var isFromProfile = false
    var isFromDiscount = false
    var disCountSubTitle = ""
    var disCountTitle = ""
    var discountImage = ""
    
    var isFromHomeScreen = false
    init(uv:UIViewController?, containerView:UIView){
        super.init()
        
        self.uv = uv
        self.containerView = containerView
        
    }
    
    func showWithcheckBox(listObjects : [String] ,checkBoxStatusArr : [Bool],  title : String,currentInst:OpenListView, handlerWithIds: @escaping CompletionHandlerWithIds){
        
        self.listHeightContainer = []
        
        self.handlerWithIds = handlerWithIds
        self.currentInst = currentInst
        
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        bgView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
        
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        
        bgView.isUserInteractionEnabled = true
        
        let bgViewTapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
        bgViewTapGesture.addTarget(self, action: #selector(currentInst.removeView))
        bgView.addGestureRecognizer(bgViewTapGesture)
        
        arrListObj = listObjects
        
        let width = (Application.screenSize.width > 390 ? 375 : (Application.screenSize.width - 40))
        
        let paddingTopBottom : CGFloat = 58
        let heightTitleLbl : CGFloat = 41
        var totalCellsHeight : CGFloat = 0
        
        for i in 0 ..< arrListObj.count{
            let listNameHeight = arrListObj[i].height(withConstrainedWidth: width - 68, font: UIFont(name: Fonts().regular, size: 17)!) + 4
            self.listHeightContainer.append(listNameHeight + 15)
            totalCellsHeight = totalCellsHeight + listNameHeight + 15
        
            
        }
        
        self.checkBoxStatusArr.removeAll()
        self.checkBoxStatusArr = checkBoxStatusArr
        
        var extraHeight : CGFloat =  totalCellsHeight + paddingTopBottom + heightTitleLbl + 10 + (isShowCheckBox == true ? 30 : 0)
        if(extraHeight > Application.screenSize.height){
            extraHeight = Application.screenSize.height - 70
        }
        
        listView = ListView(frame: CGRect(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2, width: width, height: CGFloat(extraHeight)))
        listView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        listView.tableView.dataSource = currentInst
        listView.tableView.delegate = currentInst
        listView.titleLabelTxt.text = title
        listView.tableView.tableFooterView = UIView()
        if #available(iOS 15.0, *) {
            listView.tableView.sectionHeaderTopPadding = 0
        } else {}
        listView.tableView.allowsSelection = true
        listView.tableView.register(ListTVCell.self, forCellReuseIdentifier: "ListTVCell")
        listView.tableView.register(UINib(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")
        
        if(isShowCheckBox == true){
        
            if(self.checkBoxStatusArr.contains(true)){
                listView.applyLbl.isHidden = false
                listView.resetLbl.isHidden = false
            }else{
                listView.applyLbl.isHidden = true
                listView.resetLbl.isHidden = true
            }
            listView.applyLblHeight.constant = 30
            listView.applyLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLY")
            listView.resetLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESET")
            listView.resetLbl.textColor = SColors.red
        
        }else{
            listView.applyLblHeight.constant = -10
            listView.applyLbl.isHidden = true
            listView.resetLbl.isHidden = true
        }
        
       
        
        listView.resetLbl.handleClick { (instance) in
            self.removeView()
            self.handlerWithIds("")
        }
        
        listView.applyLbl.handleClick { (instance) in
        
            self.removeView()
            if(self.handlerWithIds != nil){
                
                var idsString = ""
                for i in 0..<self.checkBoxStatusArr.count{
                    if(self.checkBoxStatusArr[i] == true){
                        if(idsString == ""){
                            idsString = "\(i)"
                        }else{
                            idsString = idsString + "," + "\(i)"
                        }
                        
                    }
                }
                self.handlerWithIds(idsString)
            }
        }
        
        closeImgTapGue.addTarget(self, action: #selector(currentInst.removeView))
        listView.closeView.isUserInteractionEnabled = true
        listView.closeView.addGestureRecognizer(closeImgTapGue)
        
        GeneralFunctions.setImgTintColor(imgView: listView.closeImgView, color: SColors.Theme)
        
        listView.layer.shadowOpacity = 0.5
        listView.layer.shadowOffset = CGSize(width: 0, height: 3)
        listView.layer.shadowColor = UIColor.black.cgColor
        
        listView.titleLabelTxt.fit()
        listView.tableView.reloadData()
        
        let currentWindow = Application.window
        
        if(self.uv == nil){
            currentWindow?.addSubview(bgView)
            currentWindow?.addSubview(listView)
        }else if(self.uv.navigationController != nil){
            self.uv.navigationController?.view.addSubview(bgView)
            self.uv.navigationController?.view.addSubview(listView)
            
            listView.tag = Utils.ALERT_DIALOG_CONTENT_TAG
            bgView.tag = Utils.ALERT_DIALOG_BG_TAG
            navZposition = self.uv.navigationController!.navigationBar.layer.zPosition
            self.uv.navigationController?.navigationBar.layer.zPosition = -1
        }else{
            self.uv.view.addSubview(bgView)
            self.uv.view.addSubview(listView)
        }
    }
    
    
    
    func show(isSelectedImageShow:Bool = true, listObjects : [String], title : String,currentInst:OpenListView, _ openDirection:OpenDirection = .center , handler: @escaping CompletionHandler){
        
        self.listHeightContainer = []
        self.isSelectedImageShow = isSelectedImageShow
        self.handler = handler
        self.currentInst = currentInst
        
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.6
        bgView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
        
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        
        bgView.isUserInteractionEnabled = true
        
        arrListObj = listObjects
        
        let width = (Application.screenSize.width > 390 ? 375 : (Application.screenSize.width - 40))
        
        let paddingTopBottom : CGFloat = 58
        let heightTitleLbl : CGFloat = 41
        var totalCellsHeight : CGFloat = 0
        
        if(self.isForSocialAccount){
            for i in 0 ..< arrListObj.count{
                let listNameHeight = arrListObj[i].height(withConstrainedWidth: width - 68, font: UIFont(name: Fonts().regular, size: 17)!) + 4
                self.listHeightContainer.append(listNameHeight + 15)
                totalCellsHeight = totalCellsHeight + listNameHeight + 15
                
                if (selectedItem.lowercased() == arrListObj[i].lowercased()) {
                    self.selectedIndex = i
                }
            }
        }else{
            for i in 0 ..< arrListObj.count{
                let listNameHeight = arrListObj[i].height(withConstrainedWidth: width - 68, font: UIFont(name: Fonts().regular, size: 17)!) + 4
                self.listHeightContainer.append(listNameHeight + 15)
                totalCellsHeight = totalCellsHeight + listNameHeight + 15
                
                if (selectedItem.lowercased() == arrListObj[i].lowercased()) {
                    self.selectedIndex = i
                }
            }
        }
        
        
        var extraHeight : CGFloat =  totalCellsHeight + paddingTopBottom + heightTitleLbl + 40
        if(extraHeight > Application.screenSize.height){
            extraHeight = Application.screenSize.height - 70
        }
        
        let currentWindow = Application.window
        
        if(openNewList == false){
            
            let bgViewTapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
            bgViewTapGesture.addTarget(self, action: #selector(currentInst.removeView))
            bgView.addGestureRecognizer(bgViewTapGesture)
            
            let yPos = Application.screenSize.height - extraHeight
            if openDirection == .center {
                listView = ListView(frame: CGRect(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2, width: width + 30, height: CGFloat(extraHeight)))
                listView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
            }else {
                listView = ListView(frame: CGRect(x: 0, y: yPos, width: Application.screenSize.width, height: CGFloat(extraHeight)))
                listView.backgroundColor = SColors.ThemeTxt
                listView.closeImgView.contentMode = .scaleAspectFit
                listView.listViewLeadMargin.constant = 0
                listView.listViewTrailMargin.constant = 0
                listView.listViewBottomMargin.constant = 15
                listView.listViewTopMargin.constant = 0
                listView.layer.cornerRadius = 8
                
            }
//            listView.closeImgView.image = UIImage(named:"cm_close_white")!.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -5, bottom: -10, right: -5))
            listView.closeImgView.image = UIImage(named:"ic_cancel_forgotpass")!.withRenderingMode(.alwaysTemplate)
            listView.closeImgView.backgroundColor = SColors.Theme

            listView.tableView.dataSource = currentInst
            listView.tableView.delegate = currentInst
            listView.titleLabelTxt.text = title
            listView.titleLabelTxt.paddingLeft = textPedding - 3
            listView.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                listView.tableView.sectionHeaderTopPadding = 0
            } else {}
            
            listView.tableView.allowsSelection = true
            listView.tableView.register(ListTVCell.self, forCellReuseIdentifier: "ListTVCell")
            listView.tableView.register(UINib(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")
           
            closeImgTapGue.addTarget(self, action: #selector(currentInst.removeView))
            listView.closeView.isUserInteractionEnabled = true
            listView.closeView.addGestureRecognizer(closeImgTapGue)
            listView.layer.shadowOpacity = 0.5
            listView.layer.shadowOffset = CGSize(width: 0, height: 3)
            listView.layer.shadowColor = UIColor.black.cgColor
//            GeneralFunctions.setImgTintColor(imgView: listView.closeImgView, color: UIColor.black.withAlphaComponent(0.60))
            GeneralFunctions.setImgTintColor(imgView: listView.closeImgView, color: UIColor.white)

            listView.titleLabelTxt.fit()
            listView.tableView.reloadData()
            
            if(self.uv == nil){
                currentWindow?.addSubview(bgView)
                currentWindow?.addSubview(listView)
            }else if(self.uv.navigationController != nil){
                self.uv.navigationController?.view.addSubview(bgView)
                self.uv.navigationController?.view.addSubview(listView)
                
                listView.tag = Utils.ALERT_DIALOG_CONTENT_TAG
                bgView.tag = Utils.ALERT_DIALOG_BG_TAG
                navZposition = self.uv.navigationController!.navigationBar.layer.zPosition
                self.uv.navigationController?.navigationBar.layer.zPosition = -1
            }else{
                self.uv.view.addSubview(bgView)
                self.uv.view.addSubview(listView)
            }
            
        }else{
           
            
            var height = 450.0
        
            if(self.isForSocialAccount){
                height = 305
                if  isSocialLoginDisable == true {
                    height = 330
                }
                height = height + Double(((arrListObj.count - 4) * 38))
                
                if(height > (Double(Application.screenSize.height - 150))){
                    height = Double((Application.screenSize.height)) - 150
                }else{
                    //height -= 40
                }
            }else{
                
                if(self.isForLang == true || self.isForCurrency == true){
                    height = 340
                    height = height + Double(((arrListObj.count - 4) * 38))
                    
                    if(height > (Double(Application.screenSize.height - 150))){
                        height = Double((Application.screenSize.height)) - 150
                    }else{
                        //height -= 40
                    }
                    //height = Application.screenSize.height - 150
                }else{
                    if(arrListObj.count > 4){
                        height = height + Double(((arrListObj.count - 4) * 50))
                        
                        if(height > (Double(Application.screenSize.height))){
                            height = Double((Application.screenSize.height))
                        }
                    }
                }
                
            }
            if rentItemNewPostUV != nil {
                
                height = 200 +  Double(((arrListObj.count ) * 50))
                

            }
            
            newListView = ListBottomSheetView(frame: CGRect(x: 0, y: Application.screenSize.height, width: Application.screenSize.width, height: CGFloat(height)))
            if(self.isForSocialAccount){
                newListView.tableView.isScrollEnabled = false
            }
            if(self.isForLang == true || self.isForCurrency == true || self.isForSocialAccount){
                
                newListView.mainViewTopSpace.constant = 0
                newListView.mainViewLeadingSpace.constant = 15
                newListView.mainViewTrailingSpace.constant = -15
                newListView.mainViewBottomSpace.constant = 0
                newListView.titleLblTrailingSpace.constant = 60
                newListView.tableViewtopSpace.constant = 30
                newListView.tableViewBottomSpace.constant = 15
                newListView.tableViewLeadingSpace.constant = 15
                newListView.tableViewTrailingSpace.constant = 15
                newListView.tableView.borderWidth = 0.5
                newListView.tableView.borderColor = .lightGray
                newListView.tableView.cornerRadius = 8
                newListView.tableView.clipsToBounds = true
                
                newListView.popupListCloseImgView.isHidden = false
                newListView.closeImgView.isHidden = true
                
                newListView.mainView.backgroundColor = UIColor(hex: 0xf6f6f6)
                newListView.popupListCloseImgView.image = newListView.popupListCloseImgView.image?.addImagePadding(x: 12, y: 12)
               // GeneralFunctions.setImgTintColor(imgView: newListView.popupListCloseImgView, color: SColors.ThemeTxt)
                //newListView.popupListCloseImgView.backgroundColor = SColors.Theme
                newListView.popupListCloseImgView.handleClick { (instance) in
                    self.closeNewListView()
                }
                
            }
            
            if(self.uv == nil){
                currentWindow?.addSubview(bgView)
                currentWindow?.addSubview(newListView)
            }else if(self.uv.navigationController != nil){
                self.uv.navigationController?.view.addSubview(bgView)
                self.uv.navigationController?.view.addSubview(newListView)
              
            }else{
                self.uv.view.addSubview(bgView)
                self.uv.view.addSubview(newListView)
            }
            
            self.newListView.titleLbl.text = title
            if(self.isForCurrency){
                self.newListView.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CURRENCY_PREFER")
            }else{
                self.newListView.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANG_PREFER")
            }
            
           if  self.isFromDate{
                self.newListView.subTitleLbl.isHidden = true
                self.newListView.subTitleLblHight.constant = 0
                self.newListView.tableViewTop.constant = 0
            }
            if(self.isForSocialAccount){
                self.newListView.subTitleLbl.isHidden = true
                self.newListView.subTitleLblHight.constant = 0
                self.newListView.tableViewTop.constant = 8
            }
            
            if(self.isForLang == true || self.isForCurrency == true || isForSocialAccount){
                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    if (height > (Double(Application.screenSize.height - 150))){
                        self.newListView.frame.origin.y = 75
                    }else{
                        self.newListView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
                    }
                   
                    
                
                }), completion: nil)
                
            }else{
                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: ({
                    
                    self.newListView.frame.origin.y = Application.screenSize.height - CGFloat((height - 30))
                
                }), completion: nil)
            }
            
            
            self.newListView.closeImgView.handleClick { (instance) in
                self.closeNewListView()
            }
            
            self.bgView.handleClick { (instance) in
                self.closeNewListView()
            }
            
            self.newListView.tableView.delegate = self
            self.newListView.tableView.backgroundColor = UIColor.white
            self.newListView.tableView.dataSource = self
            self.newListView.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.newListView.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.newListView.tableView.bounces = false
            self.newListView.tableView.register(UINib(nibName: "ListTVCell", bundle: nil), forCellReuseIdentifier: "ListTVCell")
            self.newListView.tableView.reloadData()
            self.newListView.tableView.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom: 50, right: 0)
            self.newListView.tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 20, right: 0)
            self.newListView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if(self.selectedIndex != -1){
                self.newListView.tableView.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .top, animated: true)
            }
            
        }
        
    }
    
  
    func closeNewListView(){
        
        if(self.isForSocialAccount){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.newListView.frame.origin.y = Application.screenSize.height
            }, completion: {_ in
                self.startLoading = false
        
                self.bgView.removeFromSuperview()
                self.newListView.removeFromSuperview()
            })
        }else{
            if(self.startLoading == false){
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.newListView.frame.origin.y = Application.screenSize.height
                }, completion: {_ in
                    self.startLoading = false
            
                    self.bgView.removeFromSuperview()
                    self.newListView.removeFromSuperview()
                })
            }
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTVCell", for: indexPath) as! ListTVCell
        let title = arrListObj[indexPath.row]
        
        if(openNewList){
            
            if(self.isForLang == true || self.isForCurrency == true){
                cell.cellSapraterView.isHidden = false
                
                cell.nListCheckVIewWidth.constant = 25
                cell.nListCheckViewHight.constant = 25
                cell.nListLeadingLblHight.constant = 30
                cell.nListViewLeadingLblWidth.constant = 30
                Utils.delayWithSeconds(0.1) {
                    Utils.createRoundedView(view: cell.nListViewCheckImg, borderColor: UIColor.clear, borderWidth: 0)
                    Utils.createRoundedView(view: cell.nListViewLeadingLbl, borderColor: UIColor.clear, borderWidth: 0)
                }
                
            }else{
                cell.nListViewLeadingLblWidth.constant = 38
                Utils.delayWithSeconds(0.1) {
                    Utils.createRoundedView(view: cell.nListViewCheckImg, borderColor: UIColor.clear, borderWidth: 0)
                    Utils.createRoundedView(view: cell.nListViewLeadingLbl, borderColor: UIColor.clear, borderWidth: 0)
                }
                
            }
            
            cell.newListView.isHidden = false
            
            if(self.isForSocialAccount){
                cell.socialSignInView.isHidden = false
                cell.selectionStyle = .none
                
                if(title == "smartid"){
                    cell.socialSigninImgView.image = UIImage(named: "ic_biometric")
                    
                    cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SMART_LOGIN_APPLOGIN")
                    if  isSocialLoginDisable == true {
                        cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN")
                        cell.disableQuickLoginLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SMART_LOGIN_ACTIVATION_MSG")
                        cell.disableQuickLoginLbl.isHidden = false
                        cell.socialSigninTitleLbl.textColor = UIColor(hex: 0x8FA1B4)
                        cell.sepratorView.isHidden = true
                        //cell.imgViewY.constant = -10
                        cell.titlelblY.constant = -10
                        cell.socialSigninImgView.image = UIImage(named: "ic_biomatric_diable")
                        cell.socialRightArrowicon.isHidden = true
                        //cell.socialSigninImgView.alpha = 0.5
                    }else{
                        cell.socialRightArrowicon.isHidden = false
                        //cell.imgViewY.constant = -10
                    }
                }else if(title == "apple"){
                    cell.socialRightArrowicon.isHidden = false
                    cell.sepratorView.isHidden = true
                    cell.imgViewY.constant = 0
                    cell.titlelblY.constant = 0
                    cell.socialSigninTitleLbl.alpha = 1
                    cell.disableQuickLoginLbl.isHidden = true
                    cell.socialSigninImgView.image = UIImage(named: "ic_apple_signin")
                    cell.socialSigninImgView.alpha = 1
                    cell.socialSigninTitleLbl.textColor = UIColor(hex: 0x1B2A3B)
                    cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_APPLE")
                }else if(title == "fb"){
                    cell.socialSigninImgView.image = UIImage(named: "ic_fb")
                    cell.socialRightArrowicon.isHidden = false
                    cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FACEBOOK_TXT")
                }else if(title == "linkedin"){
                    cell.socialRightArrowicon.isHidden = false
                    cell.socialSigninImgView.image = UIImage(named: "ic_linkedin")
                    cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LINKEDIN_TXT")
                }else if(title == "google"){
                    cell.socialRightArrowicon.isHidden = false
                    cell.socialSigninImgView.image = UIImage(named: "ic_google")
                    cell.socialSigninTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GOOGLE_TXT")
                }
                
            }else{
                let code = indexPath.row < newListCodeString.count ? newListCodeString[indexPath.row] : ""
                let color = indexPath.row < self.colorArray.count ? self.colorArray[indexPath.row] : UIColor.white
                
                cell.loaderView.color = SColors.Theme
                
                
                if(Configurations.isRTLMode()){
                    cell.nListViewTitleLbl.textAlignment = .right
                }else{
                    cell.nListViewTitleLbl.textAlignment = .left
                }
                cell.nListViewTitleLbl.text = title
                
                GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: UIColor.gray)
                if isForLang || isForCurrency {
                    if selectedItem.lowercased() == title.lowercased() {
                        cell.nListViewCheckImg.image = UIImage(named:"ic_trip_finish_check")
                        //cell.nListViewCheckImg.backgroundColor = SColors.Theme
                        GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: SColors.Theme)
                    }else{
                        cell.nListViewCheckImg.image = UIImage(named:"ic_list_false")
                        //cell.nListViewCheckImg.backgroundColor = SColors.ThemeTxt
                        GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: UIColor(hex: 0x8FA1B4))
                    }
                }else{
                    if selectedItem.lowercased() == title.lowercased() {
                        cell.nListViewCheckImg.image = UIImage(named:"ic_list_true")
                        GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: SColors.Theme)
                    }else{
                        cell.nListViewCheckImg.image = UIImage(named:"ic_list_false")
                        GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: UIColor.gray)
                    }
                }
                if(self.startLoading){
                    cell.nListViewCheckImg.isHidden = true
                }
                
                if isFromDate {
                    cell.selectionStyle = .none
                    cell.nListViewLeadingLbl.isHidden = true
                    
                    if  cell.nListViewTitleLbl.text == self.generalFunc.getLanguageLabel(origValue: "Select Date Range", key: "LBL_SELECT_DATE_RANGE") {
                        cell.nListViewCheckImg.isHidden = false
                        cell.nListViewCheckImg.image = UIImage(named:"ic_arrow_right")
                        GeneralFunctions.setImgTintColor(imgView: cell.nListViewCheckImg, color: UIColor.black)
                    }else {
                        cell.nListViewCheckImg.isHidden = true
                    }
                    cell.nListViewLeadingLblWidth.constant = 0
                    cell.nListViewTitleLbl.fontFamilyWeight = "Regular"
                    cell.nListViewTitleLbl.setFontFamily()
                    if selectedItem.lowercased() == title.lowercased() {
                        cell.nListViewTitleLbl.textColor = SColors.Theme
                    }else {
                        cell.nListViewTitleLbl.textColor = UIColor.black
                    }
                    
                }else {
                    cell.nListViewLeadingLbl.isHidden = false
                    cell.nListViewLeadingLbl.text = code
                    cell.nListViewLeadingLbl.backgroundColor = color
                    cell.nListViewCheckImg.isHidden = false
                    
                    cell.nListViewTitleLbl.fontFamilyWeight = "Medium"
                    cell.nListViewTitleLbl.setFontFamily()
                }
                cell.loaderView.stopAnimating()
                cell.loaderView.isHidden = true
                
                if(selectedItem.lowercased() == title.lowercased() && self.startLoading){
                    cell.loaderView.startAnimating()
                    cell.loaderView.isHidden = false
                    cell.nListViewCheckImg.isHidden = true
                }
            }
            if(self.isForLang == true || self.isForCurrency == true || isForSocialAccount){
                if  indexPath.row == arrListObj.count - 1 {
                    cell.cellSapraterView.isHidden = true
                }else{
                    cell.cellSapraterView.isHidden = false
                }
            }
        }else{
            cell.listViewOldBG.isHidden = false
            cell.listViewOldBG.backgroundColor = UIColor(hex: 0xf6f6f6)
            cell.newListView.isHidden = true
            cell.listLabelTxt.text = title.html2String
            if Configurations.isRTLMode() {
                cell.listLabelTxt.paddingRight = textPedding
            }else {
                cell.listLabelTxt.paddingLeft = textPedding
            }
//            cell.listLabelTxt.fit()

            cell.checkBox.tag = indexPath.row
            cell.checkBox.boxType = .square
            cell.checkBox.offAnimationType = .bounce
            cell.checkBox.onAnimationType = .bounce
            cell.checkBox.onCheckColor = SColors.ThemeTxt
            cell.checkBox.onFillColor = SColors.Theme
            cell.checkBox.onTintColor = SColors.Theme
            cell.checkBox.tintColor = SColors.Theme_1
            cell.selectedImageView.image = UIImage(named:"ic_liveTrackTrue")!.resize(toHeight: 15)?.resize(toWidth: 15)

            if(isShowCheckBox == true){
                cell.selectionStyle = .none
                cell.checkBox.isHidden = false
                cell.checkBoxWidth.constant = 25
                cell.checkBoxLeading.constant = 12
                if(self.checkBoxStatusArr[indexPath.row] == true){
                    cell.checkBox.setOn(true, animated: true)
                    
                }else{
                    cell.checkBox.setOn(false, animated: true)
                    
                }
                cell.checkBox.delegate = self
                
            }else{
                cell.checkBoxLeading.constant = 0
                cell.selectionStyle = .default
                cell.checkBox.isHidden = true
                cell.checkBoxWidth.constant = 0
                cell.viewImage.isHidden = !self.isSelectedImageShow
                cell.selectedImageView.contentMode = .scaleAspectFit
                
                if selectedItem.lowercased() == title.lowercased() {
                    cell.listLabelTxt.textColor = SColors.Theme
                    GeneralFunctions.setImgTintColor(imgView: cell.selectedImageView, color: SColors.Theme)
                }else{
                    cell.listLabelTxt.textColor = UIColor.black.withAlphaComponent(0.60)
//                    GeneralFunctions.setImgTintColor(imgView: cell.selectedImageView, color: UIColor.black.withAlphaComponent(0.60))
                    GeneralFunctions.setImgTintColor(imgView: cell.selectedImageView, color: UIColor.black)

                }
            }
        }
        

        return cell
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        self.checkBoxStatusArr[checkBox.tag] = checkBox.on
        
        self.listView.tableView.reloadRows(at: [IndexPath(item: checkBox.tag, section: 0)], with: .none)
        
        if(self.checkBoxStatusArr.contains(true)){
            listView.applyLbl.isHidden = false
            listView.resetLbl.isHidden = false
        }else{
            listView.applyLbl.isHidden = true
            listView.resetLbl.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.handler != nil){
            let title = arrListObj[indexPath.row]
            if title == "smartid" {
                if isSocialLoginDisable {
                    //self.removeView()
                    return
                }
            }
        }
        if(openNewList){
            
            if(self.isForCurrency){
                self.closeNewListView()
                if(self.appLoginUV != nil){
                    self.appLoginUV.currencyValueChanged(selectedItemId: indexPath.row)
                }else if(self.editProfileUV != nil){
                    self.editProfileUV.currencyValueChanged(selectedItemId: indexPath.row)
                }
                
                self.newListView.tableView.reloadData()
                
                if(self.viewProfileUV != nil){
                    if(self.handler != nil){
                        self.handler(indexPath.row)
                    }
                }
                
            }else{
                
               
                self.newListView.isUserInteractionEnabled = false
                if(self.appLoginUV != nil){
                    self.appLoginUV.lngValueChanged(selectedItemId: indexPath.row)
                }else if(self.foodPrefUV != nil){
                    self.foodPrefUV.lngValueChanged(selectedItemId: indexPath.row)
                }else if(self.editProfileUV != nil){
                    self.editProfileUV.lngValueChanged(selectedItemId: indexPath.row)
                }
                
                self.startLoading = true
                let title = arrListObj[indexPath.row]
                self.selectedItem = title
                self.newListView.tableView.reloadData()
                
                if(self.viewProfileUV != nil){
                    if(self.handler != nil){
                        self.handler(indexPath.row)
                    }
                }
            }
            if (self.signInUV != nil) {
             if(self.handler != nil){
                 let title = arrListObj[indexPath.row]
                 if title == "smartid" {
                     if isSocialLoginDisable {
                         //self.removeView()
                     }else{
                         self.removeView()
                         self.handler(indexPath.row)
                     }
                 }else{
                self.removeView()
                self.handler(indexPath.row)
                 }
             }
            }
            if transactionHistoryUV != nil {
                if(self.handler != nil){
                    self.removeView()
                    self.handler(indexPath.row)
                   
                }
            }
            if rentItemNewPostUV != nil {
                if(self.handler != nil){
                    self.removeView()
                    self.handler(indexPath.row)
                   
                }
            }
        }else{
            if(isShowCheckBox != true){
                self.removeView()
                if(self.handler != nil){
                    self.handler(indexPath.row)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(openNewList){
            if(self.isForSocialAccount){
                let title = arrListObj[indexPath.row]
                if(title == "smartid"){
                    if  isSocialLoginDisable == true {
                        return 70
                    }else{
                        return 55
                    }
                }else{
                return 55
                }
            }else if isForCurrency || isForLang {
                return 48
            }
            else{
                return 60
            }
        
        }else{
            return self.listHeightContainer[indexPath.row] + 5
           
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(self.isForLang == true || self.isForCurrency == true || isForSocialAccount){
            if(self.newListView != nil){
                self.newListView.tableSapraterView.isHidden = true
            }
        }else{
            if(self.newListView != nil){
                if(scrollView.contentOffset.y > 0){
                    self.newListView.tableSapraterView.isHidden = false
                }else{
                    self.newListView.tableSapraterView.isHidden = true
                }
            }
        }
        
        
    }
  
    @objc func removeView(){
        
        if self.smartLoginBottomSheet != nil {
            self.smartLoginBottomSheet.removeFromSuperview()
            bgView.removeFromSuperview()
            return
        }
        if(self.listView == nil && openNewList){
            self.startLoading = false
            self.newListView.removeFromSuperview()
            bgView.removeFromSuperview()
        }else{
            listView.frame.origin.y = Application.screenSize.height + 2500
            listView.removeFromSuperview()
            bgView.removeFromSuperview()
            if(self.uv != nil){
                self.uv.navigationController?.navigationBar.layer.zPosition = navZposition
            }
        }
        
    }
    @objc func removeViewSmartLogin(){
        
        self.smartLoginBottomSheet.removeFromSuperview()
        bgView.removeFromSuperview()
//        if(self.listView == nil && openNewList){
//            self.startLoading = false
//            self.newListView.removeFromSuperview()
//            bgView.removeFromSuperview()
//        }else{
//            listView.frame.origin.y = Application.screenSize.height + 2500
//            listView.removeFromSuperview()
//            bgView.removeFromSuperview()
//            if(self.uv != nil){
//                self.uv.navigationController?.navigationBar.layer.zPosition = navZposition
//            }
//        }
        
    }
    func showCameraSheet(currentInst:OpenListView, handler: @escaping CompletionHandler){
        self.handler = handler
        self.currentInst = currentInst
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        bgView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        bgView.isUserInteractionEnabled = true
//        let bgViewTapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
//        bgViewTapGesture.addTarget(self, action: #selector(currentInst.removeView))
//        bgView.addGestureRecognizer(bgViewTapGesture)
        let currentWindow = Application.window
        smartLoginBottomSheet = SmartLoginBottomSheet(frame: CGRect(x: 0, y: Application.screenSize.height, width: Application.screenSize.width, height: 650))
        
        if(self.uv == nil) {
            currentWindow?.addSubview(bgView)
            currentWindow?.addSubview(smartLoginBottomSheet)
        }else if(self.uv.navigationController != nil){
            self.uv.navigationController?.view.addSubview(bgView)
            self.uv.navigationController?.view.addSubview(smartLoginBottomSheet)
        }else{
            self.uv.view.addSubview(bgView)
            self.uv.view.addSubview(smartLoginBottomSheet)
        }
        // label and images Changes based on view
        
        self.smartLoginBottomSheet.headerView.backgroundColor = SColors.Theme
        
      
        self.smartLoginBottomSheet.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN")
        //self.smartLoginBottomSheet.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN_NOTE_2_TXT")
        if isFromProfile {
        self.smartLoginBottomSheet.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN_NOTE_2_TXT")
        }else{
            self.smartLoginBottomSheet.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_QUICK_LOGIN_NOTE_TXT")
        }
        self.smartLoginBottomSheet.subTitleLbl.sizeToFit()
        self.smartLoginBottomSheet.titleLbl.sizeToFit()
        if UIDevice().type == .iPhone5 || UIDevice().type == .iPhone5C || UIDevice().type == .iPhone5S{
        self.smartLoginBottomSheet.frame.size.height = self.smartLoginBottomSheet.titleLbl.frame.size.height + self.smartLoginBottomSheet.subTitleLbl.frame.size.height + 370
        }else{
            self.smartLoginBottomSheet.frame.size.height = self.smartLoginBottomSheet.titleLbl.frame.size.height + self.smartLoginBottomSheet.subTitleLbl.frame.size.height + 320
        }
       
        self.smartLoginBottomSheet.btnOk.setCustomColor(textColor: SColors.ThemeTxt, bgColor: SColors.Theme, pulseColor: SColors.Theme, borderColor: SColors.Theme, borderWidth: 1, cornerRadius: 5)
        self.smartLoginBottomSheet.btnOk.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_Ok_TXT"))
        //self.smartLoginBottomSheet.animationView.name
        if isFromDiscount {
            self.smartLoginBottomSheet.titleLbl.text = self.disCountTitle
            self.smartLoginBottomSheet.subTitleLbl.text = self.disCountSubTitle
            self.smartLoginBottomSheet.animationView.isHidden = true
            self.smartLoginBottomSheet.imageView.isHidden = false
            let vImage = Utils.getResizeImgURL(imgUrl: self.discountImage, width: Utils.getValueInPixel(value:70), height: Utils.getValueInPixel(value:70))
            self.smartLoginBottomSheet.imageView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            self.smartLoginBottomSheet.subTitleLbl.sizeToFit()
            self.smartLoginBottomSheet.titleLbl.sizeToFit()
    //Utils.delayWithSeconds(1) {
                self.smartLoginBottomSheet.frame.size.height = self.smartLoginBottomSheet.titleLbl.frame.size.height + self.smartLoginBottomSheet.subTitleLbl.frame.size.height + 310
                self.smartLoginBottomSheet.frame.origin.y = Application.screenSize.height - self.smartLoginBottomSheet.frame.size.height
                self.smartLoginBottomSheet.subTitleLbl.sizeToFit()
                self.smartLoginBottomSheet.titleLbl.sizeToFit()
            //}
           
        }else{
            self.smartLoginBottomSheet.animationView.isHidden = false
            self.smartLoginBottomSheet.imageView.isHidden = true
            //Utils.delayWithSeconds(1) {
                self.smartLoginBottomSheet.frame.size.height = self.smartLoginBottomSheet.titleLbl.frame.size.height + self.smartLoginBottomSheet.subTitleLbl.frame.size.height + 330
            //}
           
        }
        self.smartLoginBottomSheet.btnOk.clickDelegate = self

        self.smartLoginBottomSheet.animationView.contentMode = .scaleAspectFit
        self.smartLoginBottomSheet.animationView.loopMode = .loop
        self.smartLoginBottomSheet.animationView.animationSpeed = 0.5
        self.smartLoginBottomSheet.animationView.play()
        //self.smartLoginBottomSheet.btnOk(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Ok", key: "LBL_Ok_TXT"))
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
            
            self.smartLoginBottomSheet.frame.origin.y = Application.screenSize.height - CGFloat((self.smartLoginBottomSheet.frame.size.height  - 30))
        
        }), completion: nil)

    }
    func myBtnTapped(sender: MyButton) {
        if self.smartLoginBottomSheet != nil {
            self.removeViewSmartLogin()
        }
    }
    func showVideoAudioPopUp(currentInst:OpenListView, handler: @escaping CompletionHandler){
        self.handler = handler
        self.currentInst = currentInst
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        bgView.frame = CGRect(x:0, y:0, width: Application.screenSize.width, height: Application.screenSize.height)
        bgView.center = CGPoint(x: Application.screenSize.width / 2, y: Application.screenSize.height / 2)
        bgView.isUserInteractionEnabled = true
//        let bgViewTapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
//        bgViewTapGesture.addTarget(self, action: #selector(currentInst.removeView))
//        bgView.addGestureRecognizer(bgViewTapGesture)
        let currentWindow = Application.window
        cameraListView = CameraBottomSheetView(frame: CGRect(x: 0, y: Application.screenSize.height, width: Application.screenSize.width, height: 280))
        
        if(self.uv == nil) {
            currentWindow?.addSubview(bgView)
            currentWindow?.addSubview(cameraListView)
        }else if(self.uv.navigationController != nil){
            self.uv.navigationController?.view.addSubview(bgView)
            self.uv.navigationController?.view.addSubview(cameraListView)
        }else{
            self.uv.view.addSubview(bgView)
            self.uv.view.addSubview(cameraListView)
        }
        // label and images Changes based on view
        if !isFromHomeScreen {
        self.cameraListView.videoImageView.image = UIImage.init(named: "ic_video_2023")
        self.cameraListView.cameraImageView.image = UIImage.init(named: "ic_voice_call2023")
        self.cameraListView.videoImageView.image = self.cameraListView.videoImageView.image?.addImagePadding(x:30,y: 30)
        self.cameraListView.cameraImageView.image = self.cameraListView.cameraImageView.image?.addImagePadding(x:50,y: 50)
        self.cameraListView.videoImageView.backgroundColor = SColors.Theme
        self.cameraListView.cameraImageView.backgroundColor = SColors.Theme
        self.cameraListView.lblVideo.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIDEO_CALL")
        self.cameraListView.lblCamera.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AUDIO_CALL")
        self.cameraListView.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_CALL_TYPE_TXT")
        }else{
            self.cameraListView.videoImageView.image = UIImage.init(named: "ic_video_new")
            self.cameraListView.cameraImageView.image = UIImage.init(named: "new_plus")
            self.cameraListView.lblVideo.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VIDEO_CONSULT_MEDICAL_SERVICES_TITLE")
            self.cameraListView.lblCamera.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ON_DEMAND_MEDICAL_SERVICES_TITLE")
            self.cameraListView.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CHOOSE_MEDICAL_SERVICES_TITLE")
        }
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: ({
            
            self.cameraListView.frame.origin.y = Application.screenSize.height - CGFloat((300 - 30))
        
        }), completion: nil)
        self.cameraListView.videoView.handleClick { (view) in
            if(self.handler != nil){
                self.removeCameraView()
                self.handler(0)
            }
        }
        self.cameraListView.cameraView.handleClick { (view) in
            if(self.handler != nil){
                self.removeCameraView()
                self.handler(1)
            }
        }
        self.cameraListView.closeImgView.handleClick { (instance) in
            self.closeCameraListView()
        }
    }
    @objc func removeCameraView(){
        if self.cameraListView != nil {
        self.cameraListView.removeFromSuperview()
        bgView.removeFromSuperview()
        }
        
    }
    func closeCameraListView(){
        if(self.startLoading == false){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.cameraListView.frame.origin.y = Application.screenSize.height
            }, completion: {_ in
                self.startLoading = false
                self.bgView.removeFromSuperview()
                self.cameraListView.removeFromSuperview()
            })
        }
        
    }
}


public enum OpenDirection {
    case center
    case bottom
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
