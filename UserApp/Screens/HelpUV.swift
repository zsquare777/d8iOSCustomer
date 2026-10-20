

import UIKit
import SysBaseLib

class HelpUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var cntView:UIView!
    
    let generalFunc = GeneralFunctions()
    
    var loaderView:UIView!
    
    var dataArrList = [NSDictionary]()
    
    var isDataLoad = false
    var isSafeAreaSet = false
   var eSystem = ""
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            cntView = self.generalFunc.loadView(nibName: "HelpScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)

            loaderView =  self.generalFunc.addMDloader(contentView: self.contentView)
            loaderView.backgroundColor = UIColor.clear
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
            self.tableView.bounces = false
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5 + GeneralFunctions.getSafeAreaInsets().bottom, right: 0)

            self.tableView.register(CountryListTVCell.self, forCellReuseIdentifier: "FAQCategoryListTVCell")
            self.tableView.register(UINib(nibName: "FAQCategoryListTVCell", bundle: nil), forCellReuseIdentifier: "FAQCategoryListTVCell")
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            
            self.addBack()
            
            setData()
            
        }else if(type == 1){
            
            self.configRTL()
            
        }else if(type == 2){
            if(isDataLoad == false){
                getFAQData()
                isDataLoad = true
            }
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        if(isSafeAreaSet == false){
            if(cntView != nil){
                self.cntView.frame = self.view.frame
                cntView.frame.size.height = cntView.frame.size.height + GeneralFunctions.getSafeAreaInsets().bottom
            }
            isSafeAreaSet = true
        }
    }


    func setData(){
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAQ_TXT")
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_FAQ_TXT")
    }
    
    func getFAQData(){
        self.dataArrList.removeAll()
        
        let parameters = ["type":"getFAQ", "appType": Utils.appUserType, "iMemberId": GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    let dataArr = dataDict.arrOf(Utils.message_str)
                    self.dataArrList = dataArr as! [NSDictionary]
                    
                    self.tableView.reloadData()
                    
                }else{
                   _ = GeneralFunctions.addMsgLbl(contentView: self.view, msg: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get(Utils.message_str)))
                }
//                self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
            }else{
                self.generalFunc.setError(uv: self)
            }
            self.loaderView.isHidden = true
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArrList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList[section].arrOf("Questions").count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 35))
//        view.backgroundColor = UIColor(hex: 0xf1f1f1)
        
        let label = UILabel.init(frame: CGRect(x:15, y:0, width: tableView.frame.size.width - 35, height: 35))
        label.font = UIFont.init(name: Fonts().semibold, size: 17)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.text = self.dataArrList[section].get("vTitle")
        view.addSubview(label)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCategoryListTVCell", for: indexPath) as! FAQCategoryListTVCell

        cell.selectionStyle = .none

        print(self.dataArrList)
        let itemDict = self.dataArrList[indexPath.section].arrOf("Questions")[indexPath.row] as! NSDictionary
        cell.titleLbl.text = itemDict.get("vTitle")

        let rightImage = "ic_right_arrow"
        if(Configurations.isRTLMode()){
            cell.rightArrowImgView.image = UIImage(named:rightImage)?.rotate(180)
        }else{
            cell.rightArrowImgView.image = UIImage(named:rightImage)
        }
//        GeneralFunctions.setImgTintColor(imgView: cell.rightArrowImgView, color: UIColor.lightGray)

        if self.dataArrList.count != 1 {
            if indexPath.row == 0 {
                cell.viewBg.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewContent.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewContent.roundCorners(corners: [.topRight, .topLeft],amount: 12)
                cell.viewBg.roundCorners(corners: [.topRight, .topLeft],amount: 12)
                cell.viewTopContent.constant = 15
                cell.viewBgTop.constant = 10
                
            } else {
                cell.viewTopContent.constant = 0
                cell.viewBgBottom.constant = 0
                cell.viewBgTop.constant = 0
            }
            
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.viewBg.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewContent.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewContent.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 12)
                cell.viewBg.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 12)
                cell.viewLine.isHidden = true
                cell.viewBottomContent.constant = 15
                cell.viewBgBottom.constant = 5
            } else {
                
                cell.viewBottomContent.constant = 0
//                cell.viewBgBottom.constant = 0
                cell.viewLine.isHidden = false
                if indexPath.row != 0 {
                    cell.viewContent.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
                    cell.viewBg.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
                }
                cell.viewBg.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewContent.layer.addShadow(opacity: 0.5, radius: 1, UIColor.gray)
                cell.viewBgBottom.constant = 0
                if indexPath.row == 0 {
                    cell.viewBgTop.constant = 10
                }
                
            }
        } else {
                cell.viewContent.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                cell.viewContent.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 12)
                cell.viewBg.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 12)
               
                cell.viewLine.isHidden = true
                cell.viewTopContent.constant = 5
                cell.viewBottomContent.constant = 5
                cell.viewBgBottom.constant = 5
                cell.viewBgTop.constant = 5

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 1500
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHelpCategoryItem = self.dataArrList[indexPath.section].arrOf("Questions")[indexPath.row] as! NSDictionary
        let helpQuestionAnswersUv = GeneralFunctions.instantiateViewController(pageName: "HelpQuestionAnswersUV") as! HelpQuestionAnswersUV
        helpQuestionAnswersUv.selectedHelpCategoryItem = selectedHelpCategoryItem
        self.push(uv: helpQuestionAnswersUv)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class HelpCategoryItem {
    
    var vTitle:String!
    var questionList:NSArray!
    
    // MARK: Initialization
    
    init(vTitle: String, questionList:NSArray) {
        // Initialize stored properties.
        self.vTitle = vTitle
        self.questionList = questionList
        
    }
}
