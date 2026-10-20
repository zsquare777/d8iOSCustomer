//
//  BookingSummaryUV.swift
//  UserApp
//
//  Created by # Admin on 12/12/22.
//

import UIKit
import SysBaseLib
class BookingSummaryUV: ParentViewUV,ParentViewUVDelegate,MyBtnClickDelegate {
    
    

    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var editData:NSDictionary!
    var loaderView:UIView!
    var noSeats = ""
    var authPaymentID = ""
    var strTotalPassenger = ""
    var finalStrRP:NSMutableAttributedString!

    
    @IBOutlet weak var dataMainView: UIView!
    @IBOutlet weak var dataContainerViewHight: NSLayoutConstraint!
    @IBOutlet weak var dataContainerView: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    // @IBOutlet weak var requestReplayLbl: MyLabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totoalPriceLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var btnCountinue: MyButton!
    @IBOutlet weak var passengersNoLbl: MyLabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "BookingSummaryScreenDesign", uv: self, contentView: contentView)
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Booking Summary", key: "LBL_RIDE_SHARE_BOOKING_SUMMARY")
            self.dataMainView.isHidden = true
            self.title = self.generalFunc.getLanguageLabel(origValue: "Booking Summary", key: "LBL_RIDE_SHARE_BOOKING_SUMMARY")
            self.contentView.addSubview(cntView)
            self.getBookingSummaery()
        }else if (type == 1){
            self.addBack()
            self.configRTL()
            self.shadowOnview(view: bottomView)
            self.totoalPriceLbl.text = self.generalFunc.getLanguageLabel(origValue: "Total Price", key: "LBL_RIDE_SHARE_TOTAL_PRICE")
            self.priceLbl.textColor = SColors.Theme
            //self.priceLbl.text = self.editData.get("fPrice")
            btnCountinue.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Continue", key: "LBL_RIDE_SHARE_CONTINUE") )
            self.btnCountinue.clickDelegate = self
            if(Configurations.isRTLMode()){
                self.dateLbl.textAlignment = .right
            }
        }else if (type == 2){
          
        }
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
            self.view.isUserInteractionEnabled = ishidden
        
    }
    func bookRide(){
        
        //self.setLoader(ishidden: false)
        var parameters = ["type":"bookRide","GeneralMemberId": GeneralFunctions.getMemberd(),"iPublishedRideId" : self.editData.get("iPublishedRideId") ,"iBookNoOfSeats" : noSeats]
        if authPaymentID != "" {
            parameters["isFareAuthorized"] = "Yes"
            parameters["iAuthorizePaymentId"] = authPaymentID
            
        }
       
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            //self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    if dataDict.get("WebviewPayment").uppercased() == "YES" {
                        self.generalFunc.setAlertMessage(uv: (self.navigationDrawerController?.rootViewController as! UINavigationController), title: self.generalFunc.getLanguageLabel(origValue: "", key: ""), content: dataDict.get("message1") , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: ""), completionHandler: {(btnClickedId) in
                            
                            if(btnClickedId == 0){
                               
                                GeneralFunctions.addPayment(url: dataDict.get("message")  + "&eType=\("RideShare")", uv: self)
                                return
                            }
                            if(btnClickedId == 1)
                            {
                                
                            }
                        })
                    }else{
                        self.loadTripFinishView(title: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message_title"), key: dataDict.get("message_title")) , des: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")))
                    }
                }else if(dataDict.get("Action") == "0") {
                    if(dataDict.get(Utils.message_str) == "LOW_WALLET_AMOUNT"){
                        _ = self.generalFunc.setAlertMessageWithReturnDialog(uv: self, title: "", content:self.generalFunc.getLanguageLabel(origValue: dataDict.get("low_balance_content_msg"), key: dataDict.get("low_balance_content_msg")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD_NOW"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT"), completionHandler: { (btnClickedIndex) in
                            
                            if(btnClickedIndex == 0){
                                let manageWalletUV = GeneralFunctions.instantiateViewController(pageName: "ManageWalletUV") as! ManageWalletUV
                                self.push(uv: manageWalletUV)

                            }
                        })
                    }
                }
                else {
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
            }
        })
    }
    func getBookingSummaery(){
        
        self.setLoader(ishidden: false)
        let parameters = ["type":"BookingSummary","GeneralMemberId": GeneralFunctions.getMemberd(),"iPublishedRideId" : self.editData.get("iPublishedRideId") ,"iBookNoOfSeats" : noSeats]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    let temp = dataDict.dictOf("message")
                    
                    self.priceLbl.text = temp.get("TotalPrice")
                    let boldAttribute = [
                          NSAttributedString.Key.font: UIFont(name: "OpenSans-Bold", size: 16.0)!
                       ]
                       let regularAttribute = [
                          NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 16.0)!
                       ]
                       let boldText = NSAttributedString(string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RIDE_SHARE_REQUEST_REPLY_BY_TXT"), attributes: boldAttribute)
                       let regularText = NSAttributedString(string: " " +  temp.get("dStartDate") , attributes: regularAttribute)
                       let newString = NSMutableAttributedString()
                       newString.append(boldText)
                       newString.append(regularText)
                      self.dateLbl.attributedText = newString
                    
                   // self.requestReplayLbl.attributedText = self.finalStrRP
                    
                   
                    self.passengersNoLbl.text = self.editData.get("vNoOfPassengerText")
                    self.addFareDetails(dataDic: dataDict.dictOf("message"))
                   
                }
            }
        })
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 1.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnCountinue {
            //self.bookRide()
            self.userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            print(self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=\("RideShare")")
            GeneralFunctions.addPayment(url: self.userProfileJson.get("PAYMENT_MODE_URL") + "&eType=\("RideShare")", uv: self)
        }
    }
    func addFareDetails(dataDic:NSDictionary){

        
        
        self.dataContainerView.cornerRadius = 10
        self.shadowOnview(view: self.dataMainView)
        
        self.dataContainerView.masksToBounds = true
        self.dataContainerView.borderWidth = 1
        self.dataContainerView.borderColor = UIColor(hex: 0xDDDDDD)
        for fareSubView in self.dataContainerView.subviews{
            
            fareSubView.removeFromSuperview()
        }
        
        let fareDetailsNewArr = dataDic.arrOf("Summary")
        var totalSeperatorViews = 0
        let seperatorViewHeight = 1
        for i in 0..<fareDetailsNewArr.count
        {
            let dict_temp = fareDetailsNewArr[i] as! NSDictionary
            
            for (key, value) in dict_temp {
                _ = fareDetailsNewArr[i] as! NSDictionary
                let totalSubViewCounts = self.dataContainerView.subviews.count
                
                if((key as! String) == "eDisplaySeperator"){
                    let viewWidth = Application.screenSize.width - 80
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 1))
                    
                    viewCus.backgroundColor = UIColor(hex: 0xdedede)
                    
                    //                    self.fareContainerView.addArrangedSubview(viewCus)
                    self.dataContainerView.addSubview(viewCus)
                    //fairViewArray += [viewCus]
                    
                    totalSeperatorViews = totalSeperatorViews + 1
                }else{
                    let viewWidth = Application.screenSize.width - 80
                    
                    let viewCus = UIView(frame: CGRect(x: 0, y: CGFloat((totalSubViewCounts - totalSeperatorViews) * 50 + (totalSeperatorViews * seperatorViewHeight)), width: viewWidth, height: 50))
                    
                    
                    let titleStr = key as? String ?? ""
                    let valueStr = Configurations.convertNumToAppLocal(numStr: value as! String)
                    
                    
                    
                    var font = UIFont(name: Fonts().regular, size: 16)!
                    var fontTitle = UIFont(name: Fonts().regular, size: 14)!
                    
                    var widthOfTitle = titleStr.width(withConstrainedHeight: 50, font: fontTitle) + 15
                    var widthOfvalue = valueStr.width(withConstrainedHeight: 50, font: font) + 15
                    
                    if(widthOfTitle > ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100)){
                        widthOfvalue = ((viewWidth * 80) / 100)
                        widthOfTitle = ((viewWidth * 20) / 100)
                    }else if(widthOfTitle < ((viewWidth * 20) / 100) && widthOfvalue > ((viewWidth * 80) / 100) && (viewWidth - widthOfTitle - widthOfvalue) < 0){
                        widthOfvalue = viewWidth - widthOfTitle
                    }
                    
                    let widthOfParentView = viewWidth - widthOfvalue
                    
                    var lblTitle = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfParentView - 5, height: 50))
                    var lblValue = MyLabel(frame: CGRect(x: widthOfParentView - 30, y: 0, width: widthOfvalue + 30, height: 50))
                    
                    if(Configurations.isRTLMode()){
                        lblTitle = MyLabel(frame: CGRect(x: widthOfvalue + 5, y: 0, width: widthOfParentView, height: 50))
                        lblValue = MyLabel(frame: CGRect(x: 0, y: 0, width: widthOfvalue + 30, height: 50))
                        
                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                    }else{
                        lblTitle.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 15, paddingRight: 0)
                        lblValue.setPadding(paddingTop: 5, paddingBottom: 5, paddingLeft: 0, paddingRight: 15)
                    }
                    
                    lblTitle.textColor = UIColor(hex: 0x1B2A3B)
                    lblValue.textColor = SColors.Theme
                    
                    lblValue.font = font
                    lblTitle.font = fontTitle
                    
                    lblTitle.fontFamilyWeight = "Semibold"
                    lblValue.fontFamilyWeight = "Bold"
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
                    
                   
                    viewCus.backgroundColor = UIColor.white
                    self.dataContainerView.addSubview(viewCus)
                    
                    if(Configurations.isRTLMode()){
                        lblValue.textAlignment = .left
                    }else{
                        lblValue.textAlignment = .right
                    }
                    lblValue.textColor = SColors.Theme
                    lblValue.font = UIFont(name: Fonts().regular, size: 16)!
                    
                }
                
                
            }
        }
        
        
        self.dataContainerViewHight.constant = CGFloat((self.dataContainerView.subviews.count - totalSeperatorViews) * 50) + CGFloat((totalSeperatorViews * 1))
        self.dataMainView.isHidden = false
}
    func loadTripFinishView(title : String, des: String){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        opnTripFinishView.isNewDialouge = true
        opnTripFinishView.isFromMyBookRide = true
        opnTripFinishView.newbtnNegativeTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK")
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: "View Ride", key: "LBL_RIDE_SHARE_VIEW_PUBLISHED_RIDES_TXT")
        opnTripFinishView.show(title: title, desc:des ) {
            
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
}
