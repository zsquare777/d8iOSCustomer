

import UIKit
import SysBaseLib

class FoodPreferencesUV: ParentViewUV, MyTxtFieldClickDelegate, MyBtnClickDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var languageTxtField: MyTextField!
   
    @IBOutlet weak var updateBtn: MyButton!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var selectedLngCode = ""
    
    var languageNameList = [String]()
    var languageCodes = [String]()
    var languageArrCount = 0
    
    var colorArrayForLang = [UIColor]()
    
    var colorArrayForTextLang = [UIColor]()
    
    var selectedLngColor = UIColor()
    
    var selectedLngTxtColor = UIColor()
    
    var openListView:OpenListView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            cntView = self.generalFunc.loadView(nibName: "FoodPreferencesScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            
            self.setData()
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            languageTxtField.addImageView(color: UIColor(hex: 0xbfbfbf), transform: CGAffineTransform(rotationAngle: 90 * CGFloat(CGFloat.pi/180)))
        }
    }
    

    
    func setData()
    {
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_UPDATE")
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        languageTxtField.setPlaceHolder(placeHolder: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LANGUAGE_TXT"))
        languageTxtField.setText(text: userProfileJson.get("vLang"))
        languageTxtField.disableMenu()
        languageTxtField.setEnable(isEnabled: false)
        self.languageTxtField.myTxtFieldDelegate = self
        
        self.languageTxtField.text = (GeneralFunctions.getValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY) as? String)!
        let dataArr = GeneralFunctions.getValue(key: Utils.LANGUAGE_LIST_KEY) as! NSArray
        self.languageArrCount = dataArr.count
        
        for i in 0 ..< dataArr.count{
            let tempItem = dataArr[i] as! NSDictionary
            
            self.colorArrayForLang.append(UIColor.init(hexString: tempItem.get("vService_BG_color"), alpha: 1))
            self.colorArrayForTextLang.append(UIColor.init(hexString: tempItem.get("vService_TEXT_color"), alpha: 1))
            
            if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) == tempItem.get("vCode")){
                languageTxtField.setText(text: tempItem.get("vTitle"))
               
                self.selectedLngCode = tempItem.get("vCode")
                self.selectedLngColor = self.colorArrayForLang[i]
                self.selectedLngTxtColor = self.colorArrayForTextLang[i]
            }
            
            languageNameList += [tempItem.get("vTitle")]
            languageCodes += [tempItem.get("vCode")]
            
        }
        
        self.updateBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_PROFILE_UPDATE_PAGE_TXT"))
        self.updateBtn.clickDelegate = self
    }
    
    func lngValueChanged(selectedItemId:Int){
        
        self.selectedLngCode = self.languageCodes[selectedItemId]
        self.languageTxtField.setText(text: self.languageNameList[selectedItemId])
        
        if(self.openListView != nil){
            self.openListView.bgView.isUserInteractionEnabled = true
            self.openListView.newListView.isUserInteractionEnabled = true
            self.openListView.startLoading = false
            self.openListView.newListView.tableView.reloadData()
            self.openListView.closeNewListView()
        }
        
    }
    
    func changeLanguage(){
        let parameters = ["type":"changelanguagelabel","vLang": self.selectedLngCode]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: true)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    
                    let window = UIApplication.shared.delegate!.window!
                    
                    GeneralFunctions.saveValue(key: Utils.languageLabelsKey, value: dataDict.dictOf(Utils.message_str))
                    
                    
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_CODE_KEY, value: dataDict.get("vCode") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.LANGUAGE_IS_RTL_KEY, value: dataDict.get("eType") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.DEFAULT_LANGUAGE_TITLE_KEY, value: dataDict.get("vTitle") as AnyObject)
                    GeneralFunctions.saveValue(key: Utils.GOOGLE_MAP_LANGUAGE_CODE_KEY, value: dataDict.get("vGMapLangCode") as AnyObject)
                    GeneralFunctions.languageLabels = nil
                    Configurations.setAppLocal()
                    GeneralFunctions.restartApp(window: window!)
                    
                    
                }else{
                    self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                }
                
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    
    func myTxtFieldTapped(sender: MyTextField) {
        
        if(sender == self.languageTxtField){
            self.openListView = OpenListView(uv: nil, containerView: self.view)
            self.openListView.openNewList = true
            self.openListView.foodPrefUV = self
            self.openListView.newListCodeString = self.languageCodes
            self.openListView.colorArray = self.colorArrayForLang
            self.openListView.textColorArray = self.colorArrayForTextLang
            self.openListView.selectedItem = self.languageTxtField.text
            self.openListView.show(listObjects: self.languageNameList, title: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_LANGUAGE_HINT_TXT"), currentInst: self.openListView, handler: { (selectedItemId) in
               
            })
        }
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if((GeneralFunctions.getValue(key: Utils.LANGUAGE_CODE_KEY) as! String) != self.selectedLngCode){
            changeLanguage()
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
