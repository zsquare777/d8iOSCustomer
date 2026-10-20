

import UIKit
import SysBaseLib

class ListOrganizationUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var hLbl: MyLabel!
    @IBOutlet weak var tableView: UITableView!
    
    let generalFunc = GeneralFunctions()
    var containerViewHeight:CGFloat = 0
    
    var businessProfileUv:BusinessProfileUV!
    
    var organizationDataArr = [NSDictionary]()
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            if(self.parent == nil){
                return
            }
            
            businessProfileUv = (self.parent as! BusinessProfileUV)

            self.contentView.addSubview(self.generalFunc.loadView(nibName: "ListOrganizationScreenDesign", uv: self, contentView: contentView))
            
            self.hLbl.backgroundColor = SColors.Theme
            self.hLbl.textColor = SColors.ThemeTxt
            
    //        self.hLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YOUR_ORGANIZATION")
            
            self.hLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_ORGANIZATION_LINK_TO")
            
            
            self.tableView.delegate = self
            
            self.tableView.dataSource = self
            self.tableView.bounces = false
            self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 15, right: 0)
            
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.register(UINib(nibName: "ListOrganizationTVC", bundle: nil), forCellReuseIdentifier: "ListOrganizationTVC")
            
            self.tableView.estimatedRowHeight = 50
            self.tableView.rowHeight = UITableView.automaticDimension
            
            self.tableView.reloadData()
            
            
            let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.searchTapped))
            self.parent!.navigationItem.rightBarButtonItem = rightButton
            
            self.organizationDataArr.removeAll()
            self.organizationDataArr.append(contentsOf: businessProfileUv.organizationDataArr)
            
            
            self.tableView.reloadData()
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            if(businessProfileUv == nil){
                viewDidLoad()
            }
            
        }
    }
    
    
    @objc func searchTapped(){
        if(businessProfileUv.organizationDataArr.count == 0){
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            let searchBar = UISearchBar()
            searchBar.sizeToFit()
            searchBar.delegate = self
            if #available(iOS 13, *) {
                searchBar.searchTextField.backgroundColor = UIColor.white
            }
            
            searchBar.placeholder = self.generalFunc.getLanguageLabel(origValue: "Search", key: "LBL_Search")
            self.parent!.navigationItem.titleView = searchBar
            
            let cancelLbl = MyLabel()
            cancelLbl.font = UIFont(name: Fonts().light, size: 17)!
            cancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
            cancelLbl.setClickHandler { (instance) in
                self.setDefaultNavBar()
                self.resetToAllData()
            }
            cancelLbl.fit()
            cancelLbl.textColor = SColors.ThemeTxt
            self.parent!.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelLbl)
            self.parent!.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:  UIView())
            
            searchBar.becomeFirstResponder()
            
        })
    }
    
    
    @objc func keyboardWillDisappear(sender: NSNotification){
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 15, right: 0)
    }
    
    @objc func keyboardWillAppear(sender: NSNotification){
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardSize, right: 0)
    }
    
    func setDefaultNavBar(){
        self.businessProfileUv.addBack()
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search_nav")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.searchTapped))
        self.parent!.navigationItem.rightBarButtonItem = rightButton
        self.parent!.navigationItem.titleView = nil
        
        resetToAllData()
        
        self.hideKeyboard()
    }
    
    func resetToAllData(){
        self.organizationDataArr.removeAll()
        self.organizationDataArr.append(contentsOf: businessProfileUv.organizationDataArr)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText.trim()
        self.organizationDataArr.removeAll()
        
        if(searchQuery == ""){
            self.resetToAllData()
        }else{
            for i in 0..<businessProfileUv.organizationDataArr.count{
                let dict = businessProfileUv.organizationDataArr[i]
                
                if(dict.get("vCompany").uppercased().starts(with: searchQuery.uppercased())){
                    self.organizationDataArr.append(dict)
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.organizationDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOrganizationTVC", for: indexPath) as! ListOrganizationTVC
        
        let item = self.organizationDataArr[indexPath.row]
    
        GeneralFunctions.setImgTintColor(imgView: cell.arrowImgView, color: SColors.Theme)
        cell.arrowImgView.isHidden = true
        cell.orgNameLbl.text = item.get("vCompany")
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.setDefaultNavBar()
        
        self.parent!.navigationItem.titleView = nil
        self.parent!.navigationItem.rightBarButtonItem = nil
        self.hideKeyboard()
        
        let item = self.organizationDataArr[indexPath.row]
        businessProfileUv.selectedOrganizationPosition = indexPath.row
        businessProfileUv.selectedOrganizationId = item.get("iOrganizationId")
        businessProfileUv.selectedOrganizationCompany = item.get("vCompany")
        businessProfileUv.openSelectOrganizationUv()
    }

}
