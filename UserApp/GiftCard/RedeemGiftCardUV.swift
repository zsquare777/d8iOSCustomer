//
//  RedeemGiftCardUV.swift
//  UserApp
//
//  Created by Apple on 30/11/22.
//

import UIKit
import SysBaseLib

class RedeemGiftCardUV: ParentViewUV, ParentViewUVDelegate, MyBtnClickDelegate,TextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var voucherCodeTitleLbl: MyLabel!
    
    @IBOutlet weak var successBgView: UIView!
    @IBOutlet weak var successOkBtn: MyButton!
    @IBOutlet weak var successTitleLbl: MyLabel!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var redeemBtn: MyButton!
    @IBOutlet weak var descLbl: MyLabel!
    @IBOutlet weak var voucherCodetxtFiled: MyTextField!
    var cntView:UIView!
   
    let generalFunc = GeneralFunctions()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            cntView = self.generalFunc.loadView(nibName: "RedeemGiftCardScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            
            self.setData()
        }else if type == 1 {
            self.addBack()
            self.configRTL()
          


        }else if type == 3 {
            
        }
    }
    
    func setData(){
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_REDEEM_GIFT_CARD_TXT")
        
        self.voucherCodeTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_ADD_TXT")
        self.descLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_ENTER_CODE_TO_CLAIM_TXT")
        if(Configurations.isRTLMode()){
            self.descLbl.textAlignment = .right
            self.successTitleLbl.textAlignment = .right
        }else{
            self.descLbl.textAlignment = .left
            self.successTitleLbl.textAlignment = .left
        }
        self.redeemBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_REDEEM_TXT"))
        self.redeemBtn.clickDelegate = self
        
        self.successOkBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_OK_BTN_TXT"))
        self.successOkBtn.clickDelegate = self
        
        self.successTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_CODE_REDEEM_SUCCESS_MSG")
        
        
        self.voucherCodetxtFiled.getTextField()!.attributedPlaceholder = NSAttributedString(
            string: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_GIFT_CARD_VOUCHER_CODE_TXT"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8FA1B4)]
        )
        
    }
 
    
    func myBtnTapped(sender: MyButton) {
        
        if(sender == successOkBtn){
            self.close()
            return
        }
        
        let required_str = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FEILD_REQUIRD")
        let vCodeEntered = Utils.checkText(textField: self.voucherCodetxtFiled.getTextField()!) ? true : Utils.setErrorFields(textField: self.voucherCodetxtFiled.getTextField()!, error: required_str)
        if(vCodeEntered == false){
            return
        }
        
        self.redeemGiftCard()
    }
    
    func redeemGiftCard(){
        
        let parameters = ["type":"RedeemGiftCard", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "vGiftCardCode":self.voucherCodetxtFiled.getTextField()!.text!]
    
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                    self.loadTripFinishView(title: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message_title"), key: dataDict.get("message_title")) , des: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")))
                   
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }

            }else{
                
                self.generalFunc.setError(uv: self)
        
            }
        })
    }
   
    func loadTripFinishView(title : String, des: String){
        let opnTripFinishView = OpenTripFinishView(uv: self)
        opnTripFinishView.isNewDialouge = true
        opnTripFinishView.newbtnNegativeTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_OK")
        opnTripFinishView.newbtnPostiveTitle = self.generalFunc.getLanguageLabel(origValue: " Go to wallet", key: "LBL_GIFT_CARD_CHECK_WALLET_TXT")
        let title = title
        let desc = des
        opnTripFinishView.show(title: title, desc:desc ) {
            
        }
    }
}
