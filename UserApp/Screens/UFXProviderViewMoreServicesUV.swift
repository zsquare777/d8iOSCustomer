

import UIKit
import SysBaseLib

class UFXProviderViewMoreServicesUV: ParentViewUV, UITableViewDelegate, UITableViewDataSource, ParentViewUVDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var cntView:UIView!
    
    var generalFunc = GeneralFunctions()
    
    var dataArrList = [NSDictionary]()
    var iTripID = ""
    var iCabRequestID = ""
    var iCabBookingId = ""
    var driverID = ""
    var extraHeightContainer = [CGFloat]()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            self.addBack()
            
            cntView = self.generalFunc.loadView(nibName: "UFXProviderViewMoreServicesScreenDesign", uv: self, contentView: contentView)
            
            self.contentView.addSubview(cntView)
            
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TITLE_REQUESTED_SERVICES")
            
            self.tableView.register(UINib(nibName: "UFXReqServicesTVCell", bundle: nil), forCellReuseIdentifier: "UFXReqServicesTVCell")
            self.tableView.delegate = self
            self.tableView.bounces = false
            self.tableView.dataSource = self
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom, right: 0)
            self.tableView.tableFooterView = UIView()
            if #available(iOS 15.0, *) {
                self.tableView.sectionHeaderTopPadding = 0
            } else {}
            self.tableView.separatorStyle = .none
            self.getData()
            
        }else if(type == 1){
            
            self.configRTL()
            
        }
    }
    
    
    func getData(){
        
        self.dataArrList.removeAll()
        let parameters = ["type": "getSpecialInstructionData", "UserType": Utils.appUserType, "GeneralMemberId": GeneralFunctions.getMemberd(), "iTripId": self.iTripID, "iCabRequestId": self.iCabRequestID, "iCabBookingId":self.iCabBookingId, "iMemberId":GeneralFunctions.getMemberd()]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    
                    self.dataArrList = dataDict.arrOf(Utils.message_str) as! [NSDictionary]
                    
                    for i in 0..<self.dataArrList.count{
                        
                        let discHeight = self.dataArrList[i].get("comment").trim().height(withConstrainedWidth: Application.screenSize.width - 20, font: UIFont(name: Fonts().light, size: 16)!)
                        self.extraHeightContainer.append(discHeight)
                    }
                    self.tableView.reloadData()
                    
                }else{
                    self.generalFunc.setError(uv: self)
                }
                
            }else{
                self.getData()
            }
    
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UFXReqServicesTVCell", for: indexPath) as! UFXReqServicesTVCell
        cell.selectionStyle = .none
        cell.serviceTypeLbl.text = self.dataArrList[indexPath.row].get("title")
        cell.serviceTypeDesLbl.sizeToFit()
        cell.serivceDesHbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SPECIAL_INSTRUCTION_TXT").uppercased() + ":"
        cell.serviceTypeDesLbl.text = self.dataArrList[indexPath.row].get("comment") == "" ? self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO_SPECIAL_INSTRUCTION") : self.dataArrList[indexPath.row].get("comment")
       
        cell.serviceCountLbl.text = Configurations.convertNumToAppLocal(numStr: self.dataArrList[indexPath.row].get("Qty"))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.extraHeightContainer[indexPath.row] > 30){
            return 120 + (self.extraHeightContainer[indexPath.row] - 30) + 10
        }
        return 120
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
