

import UIKit
import SysBaseLib

class FoodRatingUV: ParentViewUV, MyBtnClickDelegate, RatingViewDelegate, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate {
    
   

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var submitBtn: MyButton!
    @IBOutlet weak var driverReviewTxtField: MyTextField!
    @IBOutlet weak var driverRatingview: RatingView!
    @IBOutlet weak var driverNameLbl: MyLabel!
    @IBOutlet weak var comanyName: MyLabel!
    @IBOutlet weak var comapnyReviewtxtfield: MyTextField!
    @IBOutlet weak var companyRatingView: RatingView!
    @IBOutlet weak var driverRatingView: UIView!
    @IBOutlet weak var driverRatingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var foodDetailRatingView: UIView!
    @IBOutlet weak var foodDetailRatingImgView: UIImageView!
    @IBOutlet weak var foodRatingDetailTxtLbl: MyLabel!
    @IBOutlet weak var foodratingDetailThemeView: UIView!
    @IBOutlet weak var foodratingDeatailDelLblTopSpace: NSLayoutConstraint!
    @IBOutlet weak var foodratingDetailDelLbl: MyLabel!
    @IBOutlet weak var foodRatingDetailRatingView: RatingView!
    @IBOutlet weak var foodratingDetailImgViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var foodRatingDetailImgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ratingQueAnsSepView1: UIView!
    @IBOutlet weak var ratingQueAnsTableView: UITableView!
    @IBOutlet weak var foodDetailRatingSubmitBtn: MyButton!
    @IBOutlet weak var footerStoreRatingDetailView: UIView!
    
    var ratingValue:Float = 0.0
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var ratingData:NSDictionary!

    var isOpenRestaurantDetail = "No"
    
    var userProfileJson:NSDictionary!
    
    var isOpenFromOrderList = false
    
    var queArray = [NSDictionary]()
    
    var isDetailFlow = false
    var isFromTracking = false
    var isDetailFlowForStore = false
    var liveTrackUv : LiveTrackUV!
    var ansArray = [String]()
    
    var isLastOrderTakeAway = "No"
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            
            isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
            
            cntView = self.generalFunc.loadView(nibName: "FoodRatingScreenDesign", uv: self, contentView: contentView) //,
            self.contentView.addSubview(cntView)
            
            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200, height: 44.0))
            label.backgroundColor = UIColor.clear
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.center
            label.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATING") + "(" + self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER") + "#" + self.ratingData.get("LastOrderNo") + ")"
            label.textColor = SColors.ThemeTxt
            self.navigationItem.titleView = label
            
            self.companyRatingView.rating = self.ratingValue
            self.comanyName.text = self.ratingData.get("LastOrderCompanyName")
            self.driverNameLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE_DELIVERY_BY") + " " + self.ratingData.get("LastOrderDriverName")
            self.comapnyReviewtxtfield.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RESTAURANT_RATING_NOTE"))
            self.driverReviewTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DRIVER_RATING_NOTE"))
            self.isLastOrderTakeAway = self.ratingData.get("isLastOrderTakeAway")
            print(self.ratingData)
            self.submitBtn.clickDelegate = self
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ENTER_DELIVERY_RATING").uppercased())
            
            self.userProfileJson =  (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            self.checkForTakeAwayOrder()
            self.contentView.isHidden = true

        }else if(type == 1){
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            if(isDetailFlow == true){
                self.showRatingDetailView()
            }else {
                self.foodDetailRatingView.isHidden = true
            }
            
            self.checkForTakeAwayOrder()
            self.contentView.isHidden = false

        }
    }
    
    
    override func close(){
       
        if self.isFromTracking {
//            let window = Application.window
//
//            let getUserData = GetUserData(uv: self, window: window!)
//            getUserData.getdata()
           // super.close()
          //  liveTrackUv.close()
            super.close()
            return
        }
        if(self.isOpenFromOrderList == true){
            super.close()
            return
        }
        if(self.isOpenRestaurantDetail.uppercased() == "YES"){
            self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
        }else{
            self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
        }
      
    }
    
    func showRatingDetailView(){
        
        self.foodDetailRatingView.isHidden = false
        
        self.ratingQueAnsSepView1.backgroundColor = SColors.Theme
        self.foodRatingDetailRatingView.delegate = self
        self.foodRatingDetailRatingView.isCustomEmojies = true
        
        let getReceiptBtn = UIBarButtonItem(image: UIImage(named: "ic_info")?.tintTo(color: SColors.ThemeTxt), style: .plain, target: self, action:#selector(self.helpTapped))
        self.navigationItem.rightBarButtonItem = getReceiptBtn
        
        self.isLastOrderTakeAway = self.ratingData.get("isLastOrderTakeAway")
        self.foodratingDetailThemeView.backgroundColor = SColors.Theme
        self.foodRatingDetailTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RATE_DELIVERY_BY")
        self.foodratingDetailDelLbl.text = self.ratingData.get("LastOrderDriverName")
        
        self.foodDetailRatingSubmitBtn.clickDelegate = self
        self.foodDetailRatingSubmitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SUBMIT_FEEDBACK").uppercased())
        
        for _ in 0..<queArray.count{
            
            self.ansArray.append("")
        }
        
        self.ratingQueAnsTableView.delegate = self
        self.ratingQueAnsTableView.dataSource = self
        self.ratingQueAnsTableView.register(UINib(nibName: "FoodRatingDetailQueAnsTVCell", bundle: nil), forCellReuseIdentifier: "FoodRatingDetailQueAnsTVCell")
        self.ratingQueAnsTableView.register(UINib(nibName: "FoodRatingDetailCustomAnsTVCell", bundle: nil), forCellReuseIdentifier: "FoodRatingDetailCustomAnsTVCell")
        
        self.ratingQueAnsTableView.tableFooterView = self.footerStoreRatingDetailView
        
        self.foodDetailRatingSubmitBtn.setButtonEnabled(isBtnEnabled: false)
        
        if(self.isLastOrderTakeAway == "Yes"){
            self.setDriverStoreDetailView()
        }
    }
    
    func ratingView(_ ratingView: RatingView, didChangeRating newRating: Float) {
        if(isDetailFlow == true){
            
            if(self.isLastOrderTakeAway != "Yes"){
                if(self.foodDetailRatingSubmitBtn.isHidden == false){
                    let cell2 = self.ratingQueAnsTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! FoodRatingDetailCustomAnsTVCell
                    
                    if(foodRatingDetailRatingView.rating > 0 && cell2.companyRatingView.rating > 0){
                        self.foodDetailRatingSubmitBtn.setButtonEnabled(isBtnEnabled: true)
                    }else{
                        self.foodDetailRatingSubmitBtn.setButtonEnabled(isBtnEnabled: false)
                    }
                }
                
                
                if(foodRatingDetailRatingView == ratingView){
                    self.setDriverStoreDetailView()
                }
            }else{
                if(self.foodDetailRatingSubmitBtn.isHidden == false){
                    let cell2 = self.ratingQueAnsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FoodRatingDetailCustomAnsTVCell
                    
                    if(cell2.companyRatingView.rating > 0){
                        self.foodDetailRatingSubmitBtn.setButtonEnabled(isBtnEnabled: true)
                    }else{
                        self.foodDetailRatingSubmitBtn.setButtonEnabled(isBtnEnabled: false)
                    }
                }
            }
            
            
        }
    }
    
    func setDriverStoreDetailView(){
        view.layoutIfNeeded()
        foodRatingDetailImgViewHeight.constant = 0
        foodratingDetailImgViewTopSpace.constant = 0
        
        if(self.isLastOrderTakeAway == "Yes"){
            foodratingDeatailDelLblTopSpace.constant = -150
        }else{
            foodratingDeatailDelLblTopSpace.constant = 30
        }
        
        self.foodRatingDetailTxtLbl.isHidden = true
        self.foodratingDetailThemeView.isHidden = true
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.foodDetailRatingSubmitBtn.isHidden = false
            self.ratingQueAnsTableView.isHidden = false
            //self.ratingQueAnsSepView1.isHidden = false
            self.ratingQueAnsTableView.reloadData()
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if(self.isLastOrderTakeAway != "Yes"){
            return 3
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.isLastOrderTakeAway != "Yes"){
            if(section == 0){
                return self.queArray.count
            }else{
                return 1
            }
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.isLastOrderTakeAway != "Yes"){
            if(indexPath.section == 0){
                let cell = self.ratingQueAnsTableView.dequeueReusableCell(withIdentifier: "FoodRatingDetailQueAnsTVCell") as! FoodRatingDetailQueAnsTVCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                let dic =  self.queArray[indexPath.row]
                cell.queLbl.text = dic.get("tQuestion")
                
                cell.ansNoLbl.clipsToBounds = true
                cell.ansYesLbl.clipsToBounds = true
                cell.ansNoLbl.tag = indexPath.row
                cell.ansYesLbl.tag = indexPath.row
                cell.ansNoLbl.handleClick { (instance) in
                    
                    cell.ansNoLbl.backgroundColor = SColors.Theme
                    cell.ansNoLbl.textColor = SColors.ThemeTxt
                    
                    cell.ansYesLbl.backgroundColor = UIColor.white
                    cell.ansYesLbl.textColor = UIColor.black
                    
                    self.ansArray.remove(at: instance.tag)
                    self.ansArray.insert("No", at: instance.tag)
                }
                
                cell.ansYesLbl.handleClick { (instance) in
                    
                    cell.ansYesLbl.backgroundColor = SColors.Theme
                    cell.ansYesLbl.textColor = SColors.ThemeTxt
                    
                    cell.ansNoLbl.backgroundColor = UIColor.white
                    cell.ansNoLbl.textColor = UIColor.black
                    
                    self.ansArray.remove(at: instance.tag)
                    self.ansArray.insert("Yes", at: instance.tag)
                }
                
                return cell
            }else if(indexPath.section == 1){
                let cell = self.ratingQueAnsTableView.dequeueReusableCell(withIdentifier: "FoodRatingDetailCustomAnsTVCell") as! FoodRatingDetailCustomAnsTVCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                
                cell.tellUsTxtFiled.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELIVERY_FEEDBACK"))
                cell.subTxtLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YOUR_WORDS")
                return cell
            }else {
                let cell = self.ratingQueAnsTableView.dequeueReusableCell(withIdentifier: "FoodRatingDetailCustomAnsTVCell") as! FoodRatingDetailCustomAnsTVCell
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                cell.topSapView.backgroundColor = SColors.Theme
                cell.storeratingView.isHidden = false
                
                cell.companyNameLbl.text = self.ratingData.get("LastOrderCompanyName")
                cell.companyRatingDetailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TELL_US"))
                
                cell.companyRatingView.delegate = self
                cell.companyRatingView.isCustomEmojies = true
                
                return cell
            }
        }else{
            let cell = self.ratingQueAnsTableView.dequeueReusableCell(withIdentifier: "FoodRatingDetailCustomAnsTVCell") as! FoodRatingDetailCustomAnsTVCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.topSapView.backgroundColor = SColors.Theme
            cell.storeratingView.isHidden = false
            
            cell.companyNameLbl.text = self.ratingData.get("LastOrderCompanyName")
            cell.companyRatingDetailTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TELL_US"))
            
            cell.companyRatingView.delegate = self
            cell.companyRatingView.isCustomEmojies = true
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.isLastOrderTakeAway != "Yes"){
            if(indexPath.section == 0){
                let dic =  self.queArray[indexPath.row]
                return dic.get("tQuestion").height(withConstrainedWidth: Application.screenSize.width - 200, font: UIFont.init(name: Fonts().light, size: 13)!) + 25
                
            }else if(indexPath.section == 1){
                return 160
            }else {
                return 250
            }
        }else{
            return 250
        }
        
    }
    
    @objc func helpTapped(){
        let helpCategoryUv = GeneralFunctions.instantiateViewController(pageName: "HelpCategoryUV") as! HelpCategoryUV
        helpCategoryUv.iTripId =  self.ratingData.get("LastOrderId")
        helpCategoryUv.eSystem = "DeliverAll"
        self.push(uv: helpCategoryUv)
    }
    
    func submitRating(){
       
        var detailAnsDic = [NSDictionary]()
        
        if(self.isDetailFlow == true){
            for i in 0..<self.queArray.count{
                
                let dataDic = self.queArray[i]
                
                let dic = ["iFeedbackId": dataDic.get("iFeedbackId"), "ans":self.ansArray[i]]
                detailAnsDic.append(dic as NSDictionary)
            }
        }
        var cell = FoodRatingDetailCustomAnsTVCell()
        var cell2 = FoodRatingDetailCustomAnsTVCell()
        
        if(self.isLastOrderTakeAway != "Yes"){
            if(self.isDetailFlow == true){
                cell = self.ratingQueAnsTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! FoodRatingDetailCustomAnsTVCell
                
                cell2 = self.ratingQueAnsTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! FoodRatingDetailCustomAnsTVCell
            }
        }else{
            if(self.isDetailFlow == true){
                cell2 = self.ratingQueAnsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FoodRatingDetailCustomAnsTVCell
            }
        }
        
        var driverMsg = ""
        if(cell.tellUsTxtFiled != nil){
            driverMsg = Utils.getText(textField: cell.tellUsTxtFiled.getTextField()!)
        }
        var paramTemp = NSDictionary()
        if(self.isLastOrderTakeAway == "Yes") {
            paramTemp = ["type":"submitRating", "iOrderId": self.ratingData.get("LastOrderId"),"iMemberId": GeneralFunctions.getMemberd(), "tripID": "", "rating": self.isDetailFlow == true ? "\(cell2.companyRatingView.rating)" : "\(self.companyRatingView.rating)", "message": self.isDetailFlow == true ? Utils.getText(textField: cell2.companyRatingDetailTxtField.getTextField()!) : Utils.getText(textField: self.comapnyReviewtxtfield.getTextField()!), "rating1": self.isDetailFlow == true ? "\(self.foodRatingDetailRatingView.rating)" : "\(self.driverRatingview.rating)", "message1": self.isDetailFlow == true ? driverMsg : Utils.getText(textField: self.driverReviewTxtField.getTextField()!), "eFromUserType": Utils.appUserType, "eToUserType": "Company", "ENABLE_FOOD_RATING_DETAIL_FLOW": self.isDetailFlow == true ? "Yes" : "No", "isDetailRatingForDriver":"", "eSystem": "DeliverAll"]
        }else {
            paramTemp = ["type":"submitRating", "iOrderId": self.ratingData.get("LastOrderId"),"iMemberId": GeneralFunctions.getMemberd(), "tripID": "", "rating": self.isDetailFlow == true ? "\(cell2.companyRatingView.rating)" : "\(self.companyRatingView.rating)", "message": self.isDetailFlow == true ? Utils.getText(textField: cell2.companyRatingDetailTxtField.getTextField()!) : Utils.getText(textField: self.comapnyReviewtxtfield.getTextField()!), "rating1": self.isDetailFlow == true ? "\(self.foodRatingDetailRatingView.rating)" : "\(self.driverRatingview.rating)", "message1": self.isDetailFlow == true ? driverMsg : Utils.getText(textField: self.driverReviewTxtField.getTextField()!), "eFromUserType": Utils.appUserType, "eToUserType": "Company", "ENABLE_FOOD_RATING_DETAIL_FLOW": self.isDetailFlow == true ? "Yes" : "No", "isDetailRatingForDriver":"", "driverFeedbackDetails":detailAnsDic.convertToJson(), "eSystem": "DeliverAll"]
        }
        let exeWebServerUrl = ApiHandler(dict_data: paramTemp as! [String : String], currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let userDic = dataDict.dictOf("USER_DATA")
                    
                    GeneralFunctions.saveValue(key: Utils.USER_PROFILE_DICT_KEY, value: userDic.toJsonStr() as AnyObject)
                    
//                    if(self.isOpenFromOrderList == true){
//                        self.generalFunc.setAlertMessage(uv: nil, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), nagativeBtn: "", completionHandler: { (btnClickedIndex) in
//
//                            if(btnClickedIndex == 0){
//
//                                if(self.isOpenFromOrderList == true){
//                                    super.close()
//                                    return
//                                }
//                                if(self.isOpenRestaurantDetail.uppercased() == "YES"){
//                                    self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
//                                }else{
//                                    self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
//                                }
//
//                            }
//
//                        })
//
//                        return
//                    }
                    
                    if self.isFromTracking {
//                        let window = Application.window
//
//                        let getUserData = GetUserData(uv: self, window: window!)
//                        getUserData.getdata()
//                        return
                        super.close()
                    }
                    if(self.isOpenFromOrderList == true){
                        super.close()
                        return
                    }
                    
                    if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                        self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                    }
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
                
            }else{
                

                _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: InternetConnection.isConnectedToNetwork() ? "LBL_TRY_AGAIN_TXT" : "LBL_NO_INTERNET_TXT"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "Retry", key: "LBL_RETRY_TXT"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT"), completionHandler: { (btnClickedIndex) in
                    
                    if(btnClickedIndex == 0){
                        self.submitRating()
                    }
                })
            }
        })
    }
    
    //0010630: Pharmacy | Take Away | user app | order | rating - driver rating coming in user app
    
    func checkForTakeAwayOrder(){
        //if(userProfileJson.get("LastOrderTakeaway").uppercased() == "YES"){
        if isLastOrderTakeAway.uppercased() == "YES"{
            self.driverRatingView.isHidden = true
            self.driverRatingViewHeight.constant = 0
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == foodDetailRatingSubmitBtn){
            
            self.submitRating()
            return
        }
        if self.companyRatingView.rating > 0 //&& self.driverRatingview.rating > 0
        {
            self.submitRating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
