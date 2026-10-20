

import UIKit
import SysBaseLib

class SearchSearvicesUV: ParentViewUV,ParentViewUVDelegate,UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var contentView: UIView!
    var searchBar:UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: MyLabel!
    
    @IBOutlet weak var noServiceImage: UIImageView!
    var cntView:UIView!
   
    let generalFunc = GeneralFunctions()
    var searchKeyWord = ""
    var dataArrList = [NSDictionary]()
    var dataDic = NSDictionary()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            
            cntView = self.generalFunc.loadView(nibName: "SearchSearvicesScreenDesign", uv: self, contentView: contentView)
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            self.contentView.addSubview(cntView)
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.tblView.bounces = false
            self.tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5 + GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
            self.tblView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tblView.sectionHeaderTopPadding = 0
            } else {}
            self.tblView.keyboardDismissMode = .onDrag
            self.tblView.register(UINib(nibName: "SearchSearvicesTVC", bundle: nil), forCellReuseIdentifier: "SearchSearvicesTVC")
           
        }
          if type == 1 {
            self.setNavigation()
            self.setApplicationStatusBar()
          }
        if type == 3 {
            self.navigationShadow(hide:true)
        }
    }

   
    @objc override func close(){
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        UIControl().sendAction(Selector(("_performMemoryWarning")), to: UIApplication.shared, for: nil)
        
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }else{
            self.view.endEditing(true)
        }
        
        if(self.navigationController == nil || self.navigationController?.viewControllers.count == 1){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func navigationShadow(hide : Bool)   {
        if !hide {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        }else{
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 0
        }
    }
    func setApplicationStatusBar(){
        Utils.delayWithSeconds(1) {
            if(self.navigationController?.navigationBar.isHidden == true){
               Configurations.setStatusBarStyle(style: .default)
            }else{
                Configurations.setStatusBarStyle(style: .default)
                //Configurations.setStatusBarStyle(style: SColors.ThemeSBStyle.uppercased() == "LIGHT" ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default)
            }
        }
    }
    func setNavigation() {
        self.navigationController?.navigationBar.barTintColor = SColors.ThemeTxt
        self.navigationShadow(hide: false)
        
        var backImg = UIImage(named: "ic_nav_bar_backorignal")!
        if(Configurations.isRTLMode()){
            backImg = backImg.rotate(180)
        }
        
        //let leftButton: UIBarButtonItem = UIBarButtonItem(image: backImg, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.close))
        //leftButt
        let button = UIButton(type: .custom)
        button.setImage(backImg, for: .normal)
        button.frame = CGRect(x: 0, y: 0.0, width: 25.0, height: 25.0)
        button.handleClick { (view) in
            self.close()
        }
        //button.addTarget(target, action: nil, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        searchBar = UISearchBar(frame: CGRect(x: 30, y:0 , width: self.view.frame.size.width - 50, height: 200))
        if(Configurations.isRTLMode()){
            searchBar = UISearchBar(frame: CGRect(x: self.view.frame.size.width - 30, y:0 , width: self.view.frame.size.width - 50, height: 200))
        }
        searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SEARCH_SERVICES")
        searchBar.delegate = self
        if #available(iOS 13, *) {
            searchBar.searchTextField.backgroundColor = UIColor.white
        }
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.returnKeyType = .done
        searchBar.becomeFirstResponder()
        //searchBar.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: UIColor.black), for: .search, state: .normal)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItems = [barButtonItem,leftNavBarButton]
        
        self.setnavBarTintColor(color: .white)
        self.navigationController?.navigationBar.tintColor = SColors.Theme
        self.navigationController?.navigationBar.barTintColor = SColors.Theme
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSearvicesTVC", for: indexPath) as! SearchSearvicesTVC
        var item:NSDictionary!
        
        cell.selectionStyle = .none
        item = self.dataArrList[indexPath.row]
        cell.serviceLbl.text = item.get("vCategory")
        //cell.serviceImgView.sd_addActivityIndicator()
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo"), width: Utils.getValueInPixel(value:48), height: Utils.getValueInPixel(value:48))
        cell.serviceImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        //let vImage = Utils.getResizeImgURL(imgUrl: item.get("vIconImage"), width: Utils.getValueInPixel(value: 70) , height: Utils.getValueInPixel(value: 70))
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrList.count
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        dataDic = self.dataArrList[indexPath.row]
        
        let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
        if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
            self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
        }else{
            self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
        }
        

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        let trimmedString = searchText.trimmingCharacters(in: .whitespaces)

        if trimmedString.count >= 3
        {
            searchBar.isLoadingSearvice = true
            searchKeyWord = trimmedString
            self.loadServiceCategory()
        }else
        {
            searchBar.isLoadingSearvice = false
            if searchText == ""{
                searchKeyWord = searchText
                self.loadServiceCategory()
                self.view.endEditing(true)
                self.searchBar.endEditing(true)
                searchBar.resignFirstResponder()
            }
            
            
            //self.tableView.isHidden = true
        }
    }
    func dismissKeyboard()
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dismissKeyboard()
        
    }
    func loadServiceCategory(){
        
       
        self.searchBar.isLoadingSearvice = true

        let parameters = ["type":"SearchService", "search_keyword": searchKeyWord]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            
            
            if(response != ""){
                
               
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    self.searchBar.isLoadingSearvice = false
                    self.dataArrList.removeAll()
                    self.dataArrList = dataArr as! [NSDictionary]
                    self.noDataLbl.isHidden = false
                    self.tblView.isHidden = false
                    self.noServiceImage.isHidden = true
                    self.tblView.reloadData()
                }else if (dataDict.get("Action") == "0") {
                    self.searchBar.isLoadingSearvice = false
                    self.noDataLbl.isHidden = false
                    self.noDataLbl.text = self.generalFunc.getLanguageLabel(origValue: "No Data", key: dataDict.get(Utils.message_str))
                    self.dataArrList.removeAll()
                    self.tblView.reloadData()
                    self.tblView.isHidden = true
                    self.noServiceImage.isHidden = false
                }
                    
            
            }else {
                self.searchBar.isLoadingSearvice = false
                
                self.noDataLbl.text = self.generalFunc.getLanguageLabel(origValue: "No Data", key: "LBL_ERROR_TXT")
                self.noDataLbl.isHidden = false
                self.dataArrList.removeAll()
                self.tblView.reloadData()
                self.tblView.isHidden = true
                self.noServiceImage.isHidden = false
            }
            
        })
    }
}
