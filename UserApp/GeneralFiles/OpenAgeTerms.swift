

import UIKit
import SysBaseLib

class OpenAgeTerms: NSObject, BEMCheckBoxDelegate, MyBtnClickDelegate {

    var ageVerificationView:AgeVerificationView!
    var ageVerificationBGView:UIView!
    
    var termsArray = [NSDictionary]()
    
    var item:NSDictionary!
    let generalFunc = GeneralFunctions()
    
    var termsChecked = false
    
    var openCatType:OpenCatType!
    var deliverAllUFXHome:DelAllUFXHomeUV!
    var deliveryAllUV:DeliveryAllUV!
    
    func openAgeTermsView(item:NSDictionary){
        
        self.item = item
        
        if(GeneralFunctions.isKeyExistInUserDefaults(key: "TERMS_ARRAY") == true){
            
            termsArray = (GeneralFunctions.getValue(key: "TERMS_ARRAY") as! [NSDictionary])
            for i in 0..<termsArray.count{
                let dataDic = termsArray[i]
                if(dataDic.get("iServiceId") == item.get("iServiceId")){
                    termsChecked = dataDic.get("termsChecked") == "No" ? false : true
                    break
                }
            }
        }
        
        if(self.item.get("eShowTerms").uppercased() == "YES" && termsChecked == false){
            ageVerificationView = AgeVerificationView(frame: CGRect(x: 15, y: (Application.screenSize.height / 2) - 220, width: Application.screenSize.width - 30, height: 390))
            ageVerificationBGView = UIView(frame: CGRect(x: 0, y: 0, width: Application.screenSize.width, height: Application.screenSize.height))
            ageVerificationView.layer.cornerRadius = 10
            ageVerificationView.clipsToBounds = true
            Utils.createRoundedView(view: ageVerificationView.newCancelView, borderColor: UIColor.clear, borderWidth: 0)
            ageVerificationView.newCancelView.backgroundColor = SColors.Theme
            GeneralFunctions.setImgTintColor(imgView: ageVerificationView.cancelImgView, color: SColors.ThemeTxt)
            
            ageVerificationBGView.backgroundColor = UIColor.black
            ageVerificationBGView.alpha = 0.7
            ageVerificationBGView.isUserInteractionEnabled = true
            Application.window?.addSubview(ageVerificationBGView)
            Application.window?.addSubview(ageVerificationView)
            
            ageVerificationView.hLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AGE_CONFIRMATION")
            ageVerificationView.sHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_AGE_NOTE")
            ageVerificationView.confirmBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONFIRM_TXT").uppercased())

            ageVerificationView.selctionChkBox.delegate = self
            ageVerificationView.confirmBtn.setButtonEnabled(isBtnEnabled: false)
            ageVerificationView.confirmBtn.clickDelegate = self
            ageVerificationView.cancelImgView.handleClick { (instance) in
                self.closeAgeVerificationView()
            }
            
            ageVerificationView.imgView.backgroundColor = SColors.Theme
            ageVerificationView.imgView.image = ageVerificationView.imgView.image?.addImagePadding(x: 30, y: 30)
            ageVerificationView.newCancelView.handleClick { (instance) in
                self.closeAgeVerificationView()
            }
            if(deliverAllUFXHome != nil){
                ageVerificationView.cancelImgView.isHidden = true
            }
            
        }else{
            if(self.openCatType != nil){
                self.openCatType.continueToOpen()
                return
            }
            if(self.deliveryAllUV != nil){
                GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: self.deliveryAllUV.collectionViewItemsArray[self.deliveryAllUV.currentIndexPath.row].get("iServiceId") as AnyObject)
                self.deliveryAllUV.changeLanguage(indexPath:self.deliveryAllUV.currentIndexPath)
                return
            }
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        if(self.ageVerificationView.selctionChkBox.on){
            self.closeAgeVerificationView()
            
            let dic = ["termsChecked":"Yes", "iServiceId" : item.get("iServiceId")] as NSDictionary
            termsArray.append(dic)
            GeneralFunctions.saveValue(key: "TERMS_ARRAY", value: termsArray as AnyObject)
            
            
            if(self.openCatType != nil){
                self.openCatType.continueToOpen()
                return
            }
            
            if(self.deliveryAllUV != nil){
                GeneralFunctions.saveValue(key: Utils.SERVICE_CATEGORY_ID, value: self.deliveryAllUV.collectionViewItemsArray[self.deliveryAllUV.currentIndexPath.row].get("iServiceId") as AnyObject)
                self.deliveryAllUV.changeLanguage(indexPath:self.deliveryAllUV.currentIndexPath)
                return
            }
            
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if(checkBox.on){
            ageVerificationView.confirmBtn.setButtonEnabled(isBtnEnabled: true)
            self.ageVerificationView.selctionChkBox.on = true
        }else{
            ageVerificationView.confirmBtn.setButtonEnabled(isBtnEnabled: false)
            self.ageVerificationView.selctionChkBox.on = false
        }
        
    }
    
    func closeAgeVerificationView(){
        ageVerificationView.removeFromSuperview()
        ageVerificationBGView.removeFromSuperview()
    }
}
