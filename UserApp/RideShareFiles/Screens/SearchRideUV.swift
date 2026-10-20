//
//  SearchRideUV.swift
//  UserApp
//
//  Created by # Admin on 10/12/22.
//

import UIKit
import SysBaseLib
class SearchRideUV: ParentViewUV,ParentViewUVDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var contentView: UIView!
    let generalFunc = GeneralFunctions()
    var cntView:UIView!
    var userProfileJson:NSDictionary!
    var loaderView:UIView!
    var dataDic:NSDictionary!
    var rideList = [NSDictionary]()
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var noDataLbl: MyLabel!
    @IBOutlet weak var noDataLbl2: MyLabel!
    @IBOutlet weak var noDataImgHight: NSLayoutConstraint!
    @IBOutlet weak var noDataImgView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }

    func viewType(type: Int) {
        
        if(type == 0){
            self.cntView = self.generalFunc.loadView(nibName: "SearchRideScreenDesign", uv: self, contentView: contentView)
            self.contentView.addSubview(cntView)
            self.tblView.register(UINib(nibName: "SearchRideTVC", bundle: nil), forCellReuseIdentifier: "SearchRideTVC")
            self.tblView.dataSource = self
            self.tblView.delegate = self
        }else if (type == 1){
            self.addBack()
            self.navigationItem.title = self.generalFunc.getLanguageLabel(origValue: "Rides", key: "LBL_RIDE_SHARE_RIDE_SEARCH_TITLE")
            self.title = self.generalFunc.getLanguageLabel(origValue: "Rides", key: "LBL_RIDE_SHARE_RIDE_SEARCH_TITLE")
            self.configRTL()
            self.noDataImgHight.constant = Utils.getHeightOfBanner(widthOffset: 40, ratio: "4:3")
            self.noDataImgView.image = UIImage.init(named: "ic_no_ride")
            self.getRides()
        }else if (type == 2){
            
            
        }
    }
    func getRides(){
        self.tblView.isHidden = true
        self.setLoader(ishidden: false)
        let parameters = ["type":"SearchRide","GeneralMemberId": GeneralFunctions.getMemberd(),"tStartLat" : self.dataDic.get("tStartLat"),"tStartLong" : self.dataDic.get("tStartLong"), "tEndLat" : self.dataDic.get("tEndLat") , "tEndLong" : self.dataDic.get("tEndLong"), "dStartDate" : self.dataDic.get("dStartDate"), "NoOfSeats" : self.dataDic.get("NoOfSeats"),"vFilterParam" : "","page" : "1"]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: false)
        exeWebServerUrl.setDeviceTokenGenerate(isDeviceTokenGenerate: false)
        exeWebServerUrl.currInstance = exeWebServerUrl
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            self.tblView.isHidden = false
            self.setLoader(ishidden: true)
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                    self.rideList =  dataDict.arrOf("message") as! [NSDictionary]
                    self.tblView.reloadData()
                    Utils.delayWithSeconds(1) {
                        self.tblView.reloadData()
                    }
                    self.noDataLbl.isHidden = true
                    self.noDataLbl2.isHidden = true
                    self.noDataImgView.isHidden = true
                }else if (dataDict.get("Action") == "0"){
                    self.noDataLbl.isHidden = false
                    self.noDataLbl2.isHidden = false
                    self.noDataImgView.isHidden = false
                    self.noDataLbl.isHidden = false
                    self.noDataLbl.text = self.generalFunc.getLanguageLabel(origValue: dataDict.get("message_title"), key: dataDict.get("message_title"))
                    self.noDataLbl2.text = self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message"))
                }
            }else{
                self.generalFunc.setError(uv: self)
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.rideList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRideTVC", for: indexPath) as! SearchRideTVC
        let item = self.rideList[indexPath.item]
        self.shadowOnview(view: cell.mainView)
        cell.mainView.tag = indexPath.row
        cell.mainView.handleClick { instance in

            let searchRideDetialsUV = GeneralFunctions.instantiateViewController(pageName: "SearchRideDetialsUV") as! SearchRideDetialsUV
            searchRideDetialsUV.editData = self.rideList[indexPath.item]
            searchRideDetialsUV.noSeats = self.dataDic.get("NoOfSeats")
            self.push(uv: searchRideDetialsUV)
        }
        cell.bookingNoLbl.text = item.get("vBookingNoTxt")
        
        cell.startCityLbl.text = self.generalFunc.getLanguageLabel(origValue: "Start Location", key: "LBL_RIDE_SHARE_DETAILS_START_LOC_TXT")
        cell.startAddLbl.text = item.get("tStartLocation")
        cell.startCityView.layer.masksToBounds = true
        cell.startCityView.layer.cornerRadius = cell.startCityView.frame.width / 2

        cell.endCityLbl.text = self.generalFunc.getLanguageLabel(origValue: "End Location", key: "LBL_RIDE_SHARE_DETAILS_END_LOC_TXT")
        cell.endAddLbl.text = item.get("tEndLocation")
        cell.endCityView.layer.masksToBounds = true
        cell.endCityView.layer.cornerRadius = cell.endCityView.frame.width / 2
      
        
        cell.dateTimeLbl.text = item.get("StartDate")
        
        cell.dottedView.backgroundColor = UIColor.clear
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            cell.dottedView.createDashedLine(color: UIColor(hex: 0xDDDDDD), lineWidth: 2, true)
        })
        
        cell.endTime.textColor = SColors.Theme
        cell.startTime.textColor = SColors.Theme
        cell.startTime.text = item.get("StartTime")
        cell.endTime.text = item.get("EndTime")
       
        cell.userNameLbl.text = item.get("DriverName")
        cell.userNameLbl.textColor = SColors.Theme
       
        cell.priceLbl.text = item.get("fPrice")
        cell.priceLbl.textColor = SColors.Theme
       
        cell.statusView.isHidden = true
        cell.statusView.backgroundColor = UIColor.init(hexString: item.get("vStatusBgColor"))
        cell.statusLbl.text = item.get("eStatusText")
        cell.statusView.cornerRadius = 4
        
        cell.perPassengerLbl.text = item.get("PriceLabel")
        
        cell.userImageView.sd_setImage(with: URL(string: item.get("DriverImg")), placeholderImage:UIImage(named:"ic_no_pic_user"))
        Utils.createRoundedView(view:cell.userImageView, borderColor: SColors.Theme, borderWidth: 0)
       
        cell.bookingNoLbl.text = item.get("vPublishedRideNoTxt")
        if(Configurations.isRTLMode()){
            cell.startTime.textAlignment = .left
            cell.endTime.textAlignment = .left
        }
        return cell
    }
    func shadowOnview(view : UIView)   {
        view.shadowColor = UIColor.lightGray
        view.shadowOffset = CGSize(width: 0, height: 0.0)
        view.shadowRadius = 2.0
        view.shadowOpacity = 1.0
        view.masksToBounds = false
       
    }
    func setLoader(ishidden : Bool)  {
        if(loaderView == nil){
            loaderView =  self.generalFunc.addMDloader(contentView: self.view)
            loaderView.backgroundColor = UIColor.clear
        }else if(loaderView != nil){
            loaderView.isHidden = ishidden
        }
        
    }
    
}
