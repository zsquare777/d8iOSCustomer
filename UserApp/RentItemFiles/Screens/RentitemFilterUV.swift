//
//  RentitemFilterUV.swift
//  UserApp
//
//  Created by # Admin on 07/12/22.
//

import UIKit
import SysBaseLib
class RentitemFilterUV:  ParentViewUV,ParentViewUVDelegate,MyBtnClickDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    @IBOutlet weak var catLbl: MyLabel!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var btnApply: MyButton!
    @IBOutlet weak var btnReset: MyButton!
    @IBOutlet weak var tblView: UITableView!
    var loaderView:UIView!
    var subCatData = [NSDictionary] ()
    var selectedData = [String] ()
    var selectedDataOption = [String] ()
    var catID = ""
    var eType = ""
    var rentItemHomeUv : RentItemHomeUV!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "RentitemFilterScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
        }else if (type == 1){
            self.setData()
        }
    }
    func setData()  {
        self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Filter", key: "LBL_RENT_FILTER")
        self.title = self.generalFunc.getLanguageLabel(origValue: "Filter", key: "LBL_RENT_FILTER")
        self.addBack()
        self.configRTL()
              
        self.anchorView.backgroundColor = UIColor(hex: 0xf1f1f1)
        self.anchorSubView.backgroundColor = SColors.Theme
        self.btnReset.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Reset", key: "LBL_RENT_RESET"))
        self.btnApply.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "Apply", key: "LBL_RENT_APPLY"))
        self.btnReset.setCustomColor(textColor: SColors.textColor, bgColor: UIColor.white, pulseColor: SColors.Theme, borderColor: SColors.textColor, borderWidth: 1, cornerRadius: 5)
        self.btnReset.clickDelegate = self
        self.btnApply.clickDelegate = self
        self.tblView.register(UINib(nibName: "RentSubCatTVCell", bundle: nil), forCellReuseIdentifier: "RentSubCatTVCell")
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.loadRentCategory()
    }
    func myBtnTapped(sender: MyButton) {
        if sender == self.btnApply {
            var idS = ""
            var optIdS = ""
            //DevNote : Commented for set as like android
//            if self.selectedData.count == 0 && self.selectedDataOption.count == 0 {
//                Utils.showSnakeBar(msg: self.generalFunc.getLanguageLabel(origValue: "Please Select Filter Option", key: "LBL_RENT_FILTER_SELECT_OPTION"), uv: self)
//                return
//            }
            if rentItemHomeUv != nil {
                for i in 0 ..< self.selectedData.count{
                    if(idS == ""){
                        idS = self.selectedData[i]
                    }else{
                        idS = idS + "," + self.selectedData[i]
                    }
                }
                for i in 0 ..< self.selectedDataOption.count{
                    if(optIdS == ""){
                        optIdS = self.selectedDataOption[i]
                    }else{
                        optIdS = optIdS + "," + self.selectedDataOption[i]
                    }
                }
                
                //self.rentItemHomeUv.getSubFilter(id: idS, selectedDataTemp: self.selectedData )
                self.rentItemHomeUv.getSubFilter(id: idS, optID: optIdS, selectedDataTemp: self.selectedData, selectedOptDataTemp: self.selectedDataOption )
                self.close()
            }
        }else if sender == self.btnReset {
            self.selectedData.removeAll()
            self.selectedDataOption.removeAll()
            self.tblView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.subCatData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = self.subCatData[section]
        let dataArr = self.subCatData[section].arrOf("subData") as! [NSDictionary]
        return dataArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 75
        }else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1{
            return 75
        }
            else{
            return 60
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentSubCatTVCell", for: indexPath) as! RentSubCatTVCell
        let data = self.subCatData[indexPath.section]
        let dataArr = self.subCatData[indexPath.section].arrOf("subData") as! [NSDictionary]
        let item = dataArr[indexPath.row]
        cell.containerView.addShadowWithCornerRadius_new()
        cell.descriptionLbl.textColor = SColors.textColor
        cell.descriptionLbl.text = item.get("vTitle")
        Utils.createRoundedView(view: cell.arrowView, borderColor: .clear, borderWidth: 0)
        cell.arrowView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        if(Configurations.isRTLMode()){
            cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")?.rotate(180)
        }else{
            cell.arrowImageView.image = UIImage(named:"ic_btn_rightarrow")
        }
        
        
        if self.subCatData.count != 1 {
            if indexPath.row == 0 {
                cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                
                cell.containerView.roundCorners(corners: [.topRight, .topLeft],amount: 10)
                cell.contentView.roundCorners(corners: [.topRight, .topLeft],amount: 10)
                cell.containerViewTop.constant = 20
                
            }else {
                cell.containerViewTop.constant = 0
            }
            
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
               
                cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 10)
                cell.contentView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 10)
                cell.sepratorLbl.isHidden = true
                cell.containerViewBottom.constant = 20
            }else {
                cell.containerViewBottom.constant = 0
                cell.sepratorLbl.isHidden = false
                if indexPath.row != 0 {
                    cell.containerView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
                    cell.contentView.roundCorners(corners: [.bottomLeft, .bottomRight],amount: 0)
                }
                
                cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
                
            }
        }else{
            cell.containerView.layer.addShadow(opacity: 1.0, radius: 2, UIColor.gray)
            cell.containerView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 10)
            cell.contentView.roundCorners(corners: [.topRight, .topLeft,.bottomLeft,.bottomRight],amount: 10)
           
            cell.sepratorLbl.isHidden = true
            cell.containerViewBottom.constant = 5
            cell.containerViewTop.constant = 5
        }
        cell.arrowView.isHidden = true
        cell.checkBox.tag = indexPath.row
        cell.checkBox.offAnimationType = .bounce
        cell.checkBox.onAnimationType = .bounce
        cell.checkBox.boxType = .square
        cell.checkBox.onCheckColor = SColors.ThemeTxt
        cell.checkBox.onFillColor = SColors.Theme
        cell.checkBox.onTintColor = SColors.Theme //SColors.ThemeTxt
        cell.checkBox.tintColor = UIColor.init(hex: 0x8FA1B4) //SColors.Theme
        cell.checkBox.isHidden = false
        if item.get("iSubCategoryId") != "" {
        if selectedData.contains(item.get("iSubCategoryId")){
            cell.checkBox.setOn(true, animated: true)
        }else{
            cell.checkBox.setOn(false, animated: true)
        }
        }else{
            if selectedDataOption.contains(item.get("iOptionId")){
                cell.checkBox.setOn(true, animated: true)
            }else{
                cell.checkBox.setOn(false, animated: true)
            }
        }
//        let carTypeChkBoxTapGue = UITapGestureRecognizer()
//        carTypeChkBoxTapGue.addTarget(self, action: #selector(self.carTypeChkBoxTapped(sender:)))
        //cell.checkBox.addGestureRecognizer(carTypeChkBoxTapGue)
        cell.checkBox.handleClick { instance in
            let data = self.subCatData[indexPath.section]
            let dataArr = self.subCatData[indexPath.section].arrOf("subData") as! [NSDictionary]
            let item = dataArr[indexPath.row]
            if item.get("iSubCategoryId") != "" {
            if self.selectedData.contains(item.get("iSubCategoryId")) {
                for i in 0 ..< self.selectedData.count{
                    if self.selectedData.count != 0 {
                    if self.selectedData[i] == item.get("iSubCategoryId"){
                        self.selectedData.remove(at:i)
                        break
                    }
                    }
                }
            }else{
                self.selectedData.append(item.get("iSubCategoryId"))
            }
            }else{
               
                if self.selectedDataOption.contains(item.get("iOptionId")) {
                    for i in 0 ..< self.selectedDataOption.count{
                        if self.selectedDataOption.count != 0 {
                        if self.selectedDataOption[i] == item.get("iOptionId"){
                            self.selectedDataOption.remove(at:i)
                            break
                        }
                        }
                    }
                }else{
                    self.selectedDataOption.append(item.get("iOptionId"))
                }
            }
            self.tblView.reloadData()
        }
        cell.containerView.handleClick { instance in
            let data = self.subCatData[indexPath.section]
            let dataArr = self.subCatData[indexPath.section].arrOf("subData") as! [NSDictionary]
            let item = dataArr[indexPath.row]
            if item.get("iSubCategoryId") != "" {
            if self.selectedData.contains(item.get("iSubCategoryId")) {
                for i in 0 ..< self.selectedData.count{
                    if self.selectedData.count != 0 {
                    if self.selectedData[i] == item.get("iSubCategoryId"){
                        self.selectedData.remove(at:i)
                        break
                    }
                    }
                }
            }else{
                self.selectedData.append(item.get("iSubCategoryId"))
            }
            }else{
               
                if self.selectedDataOption.contains(item.get("iOptionId")) {
                    for i in 0 ..< self.selectedDataOption.count{
                        if self.selectedDataOption.count != 0 {
                        if self.selectedDataOption[i] == item.get("iOptionId"){
                            self.selectedDataOption.remove(at:i)
                            break
                        }
                        }
                    }
                }else{
                    self.selectedDataOption.append(item.get("iOptionId"))
                }
            }
            self.tblView.reloadData()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
        let item = self.subCatData[section]
        let categoryHview = CategoryHeaderViewRent(frame: CGRect(x:-30, y: 0, width: Application.screenSize.width, height: 50))
        categoryHview.headerlbl.text = item.get("headerTitle")//self.generalFunc.getLanguageLabel(origValue: "Find a item", key: "LBL_FIND_ITEM_TXT") //"Find A item"
        categoryHview.backgroundColor = SColors.ThemeTxt
        categoryHview.anchoeView.backgroundColor = SColors.Theme
        categoryHview.anchorSubView.backgroundColor = SColors.Theme
        categoryHview.anchoeView.isHidden = true
        categoryHview.anchorSubView.isHidden = true
           
           
          return categoryHview
        
    }
    func loadRentCategory(){
        
        self.setLoader(ishidden: false)
       
        var parameters = ["type":"getFilterRentData", "userId": GeneralFunctions.getMemberd() , "iCategoryId" : self.catID, "eType" : eType ]
        
        
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            self.setLoader(ishidden: true)
            
            if(response != ""){
                let dataDict = response.toDict()
                if(dataDict.get("Action") == "1"){
//                    var tempData = dataDict.dictOf(Utils.message_str) as! NSDictionary //dataDict.dict(Utils.message_str) as! [NSDictionary]
//                    print(tempData)
                   
                    self.subCatData = dataDict.arrOf(Utils.message_str) as! [NSDictionary]
                   
                    self.tblView.reloadData()
                }
            }else{
                self.generalFunc.setError(uv: self)
                
            }
            
            
            
        })
    }
    func setLoader(ishidden : Bool)  {
        
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
    }
//    func temp()  {
//
//    }
    @objc func carTypeChkBoxTapped(sender:UITapGestureRecognizer){
        let index = sender.view!.tag
        let item = self.subCatData[index]
        if item.get("iSubCategoryId") != "" {
        if self.selectedData.contains(item.get("iSubCategoryId")) {
            for i in 0 ..< self.selectedData.count{
                if self.selectedData.count != 0 {
                if self.selectedData[i] == item.get("iSubCategoryId"){
                    selectedData.remove(at:i)
                    break
                }
                }
            }
        }else{
            self.selectedData.append(item.get("iSubCategoryId"))
        }
        }else{
           
            if self.selectedDataOption.contains(item.get("iOptionId")) {
                for i in 0 ..< self.selectedDataOption.count{
                    if self.selectedDataOption.count != 0 {
                    if self.selectedDataOption[i] == item.get("iOptionId"){
                        selectedDataOption.remove(at:i)
                        break
                    }
                    }
                }
            }else{
                self.selectedDataOption.append(item.get("iOptionId"))
            }
        }
        self.tblView.reloadData()
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
            return 50
    }
}
