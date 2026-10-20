//
//  TrackingListUV.swift
//  UserApp
//
//  Created by Apple on 22/11/22.
//

import UIKit
import SysBaseLib
import Lottie

class TrackingListUV: ParentViewUV, ParentViewUVDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    
    var isFromTrackingSignup = false
    
    var dataArrList = [NSDictionary]()
    
    var trackingStatusCheckTimer:Timer!
    var isOpenSignup = false
    
    var userProfileJson:NSDictionary!
    
    var typeDataDic = NSDictionary()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            cntView = self.generalFunc.loadView(nibName: "TrackingListScreenDesign", uv: self, contentView: contentView)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
           
            self.contentView.addSubview(cntView)
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            
            self.setData()
            self.getTrackingList()
            
        }else if type == 1 {
            self.isOpenSignup = false
            self.configRTL()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
//            if(self.isFromTrackingSignup){
//                self.navigationItem.leftBarButtonItems = []
//                self.navigationItem.setHidesBackButton(true, animated: false)
//            }else{
//                self.navigationItem.setHidesBackButton(false, animated: false)
//
//            }
            
            self.addBack()
            
            
            
        }else if type == 3 {
           
        }
    }
    
    func startMonitaringTimer(){
        
        if(self.trackingStatusCheckTimer == nil){
            self.trackingStatusCheckTimer = Timer.scheduledTimer(timeInterval: 55.0,
                                                 target: self,
                                                 selector: #selector(eventWith(timer:)),
                                                 userInfo: nil,
                                                 repeats: true)
        }
        
    }
    
    @objc func eventWith(timer: Timer!) {
        self.getTrackingList(false)
    }
    
    override func close(){
        
        if(self.trackingStatusCheckTimer != nil){
            self.trackingStatusCheckTimer.invalidate()
            self.trackingStatusCheckTimer = nil
        }
        
        if(self.isFromTrackingSignup){
            
            let userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            }else{
                performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
            }
            
        }else{
            super.close()
        }
        
    }
    
    func setData(){
//        let rightButton = UIBarButtonItem(image: UIImage(named: "ic_add_nav_bar")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openAddNewVehicle))
//        self.navigationItem.rightBarButtonItem = rightButton
        
        self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ANY_TXT")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "TrackingListTVCell", bundle: nil), forCellReuseIdentifier: "TrackingListTVCell")
        
        self.tableView.contentInset = UIEdgeInsets.init(top: 6, left: 0, bottom: GeneralFunctions.getSafeAreaInsets().bottom + 20, right: 0)
    
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            self.tableView.register(UINib(nibName: "NewTrackingListTVCell", bundle: nil), forCellReuseIdentifier: "NewTrackingListTVCell")
            self.title = typeDataDic.get("vTitle")
            
        }
        self.tableView.addSubview(self.refreshControl)
        
        self.addView.backgroundColor = SColors.Theme
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        Utils.createRoundedView(view: self.addView, borderColor: .clear, borderWidth: 0)
        self.addView.layer.addShadow(opacity: 5, radius: 3.0, UIColor.lightGray)
        GeneralFunctions.setImgTintColor(imgView: addImageView, color: SColors.ThemeTxt)
        self.addView.handleClick { instance in
            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackAnySignupUV") as! TrackAnySignupUV
            mainScreenUv.dataDic = self.typeDataDic
            self.push(uv: mainScreenUv)
        }
        
    }
    
    // For Pull To Refersh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = SColors.Theme
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
       
        //self.dataArrList.removeAll()
       
        if(self.tableView != nil){
            
            self.tableView.reloadData()
        }
        
        
        self.getTrackingList()
    }
    
//    @objc func openAddNewVehicle(){
//
//        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackAnySignupUV") as! TrackAnySignupUV
//        mainScreenUv.dataDic = self.typeDataDic
//        self.push(uv: mainScreenUv)
//    }
    
    
    func getTrackingList(_ isLoader:Bool = true){
        
        let parameters = ["type":"listTrackingUsers", "iMemberId": GeneralFunctions.getMemberd(), "UserType": Utils.appUserType, "MemberType": self.typeDataDic.get("MemberType")]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: isLoader)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                print(dataDict)
                if(dataDict.get("Action") == "1"){
                    
                    self.dataArrList = dataDict.arrOf("message") as! [NSDictionary]
                    if(self.dataArrList.count > 0){
                        
//                        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() != "YES"){
//
//                        }
                        self.startMonitaringTimer()
                        
                        self.tableView.reloadData()
                    }else{
                        
                        if(self.isOpenSignup == false){
                            let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackAnySignupUV") as! TrackAnySignupUV
                            mainScreenUv.dataDic = self.typeDataDic
                            mainScreenUv.isFromListing = true
                            self.push(uv: mainScreenUv)
                            self.isOpenSignup = true
                        }
                        
                    }
                    
                }else{
                   
                    if(isLoader == true){
                        self.generalFunc.setError(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: dataDict.get("message")))
                    }
                    
                
                }

            }else{
                
                if(isLoader == true){
                    self.generalFunc.setError(uv: self)
                }
        
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataArrList[indexPath.item]
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewTrackingListTVCell", for: indexPath) as! NewTrackingListTVCell
            
            cell.selectionStyle = .none
            cell.dataView.layer.shadowOpacity = 1.0
            cell.dataView.layer.shadowRadius = 2.0
            cell.dataView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.dataView.layer.shadowColor = UIColor.lightGray.cgColor
            
            cell.dataView.layer.masksToBounds = false
            
            cell.deleteImgView.backgroundColor = SColors.Theme
           
            cell.deleteImgView.image = UIImage(named: "ic_deleteN")!.addImagePadding(x: 10, y: 10)
            cell.callImgView.image = UIImage(named: "ic_callN")!.addImagePadding(x: 10, y: 10)
            
            cell.nameLbl.text = item.get("userName")
            cell.phoneNumberLbl.text = item.get("userPhone")
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value:90), height: Utils.getValueInPixel(value:90))
            cell.profileImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_pic_user"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            
            cell.deleteImgView.handleClick { (instance) in
                self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_DELETE_CONFIRM_MSG"), positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_YES"), nagativeBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_NO"), completionHandler: { (btnClickedIndex) in
                    if(btnClickedIndex == 0){
                        self.deleteUser(pairedUserID: item.get("iTrackServiceUserId"))
                    }
                })
            }
            
            cell.phoneNumberLbl.handleClick { instance in
                UIApplication.shared.openURL(NSURL(string: ("telprompt:\(item.get("userPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
            }
            
            cell.callImgView.handleClick { instance in
                UIApplication.shared.openURL(NSURL(string: ("telprompt:\(item.get("userPhone"))").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)! as URL)
            }
            
            
            cell.liveTrackLbl.borderWidth = 1.0
            cell.liveTrackLbl.borderColor = SColors.blackColor
            cell.liveTrackLbl.textColor = SColors.blackColor
            cell.liveTrackLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LIVE_TRACK_TXT")
            
            cell.liveTrackLbl.handleClick { instance in
                let trackingLiveUV = GeneralFunctions.instantiateViewController(pageName: "TrackingLiveUV") as! TrackingLiveUV
                trackingLiveUV.dataDic = item
                self.push(uv: trackingLiveUV)
            }
            
            cell.trackingStatusHLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_TRACKING_STATUS_TXT") + ":"
            
            if(item.get("LocationTrackingStatus").uppercased() == "YES"){
                cell.trackingStatusVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ACTIVE_STATUS")
                cell.trackingStatusVLbl.textColor = SColors.green
                
            }else{
                cell.trackingStatusVLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_INACTIVE_STATUS")
                
                cell.trackingStatusVLbl.textColor = UIColor(hex: 0xb90d1b)
                
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackingListTVCell", for: indexPath) as! TrackingListTVCell
            
            cell.selectionStyle = .none
            cell.dataView.layer.shadowOpacity = 1.0
            cell.dataView.layer.shadowRadius = 2.0
            cell.dataView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.dataView.layer.shadowColor = UIColor.lightGray.cgColor
            Utils.createRoundedView(view: cell.dataView, borderColor: UIColor.clear, borderWidth: 0, cornerRadius: 10)
            cell.dataView.layer.masksToBounds = false
            
            cell.tripStatusLbl.text = item.get("TripStatusDisplay")
            cell.nameLbl.text = item.get("userName")
            cell.liveTrackInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_LIVE_TRACK_TXT")
            cell.vehicleInfoLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_VEHICLE_DETAILS_TXT")
            cell.profileLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_PROFILE_TXT")
            cell.profileLbl.backgroundColor = SColors.blackColor
            cell.vehicleInfoLbl.backgroundColor = SColors.Theme
            cell.liveTrackInfoLbl.backgroundColor = SColors.Theme
            
            cell.profileImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 80), height: Utils.getValueInPixel(value: 80))), placeholderImage:UIImage(named:"ic_no_pic_user"))
            cell.profileLbl.textColor = SColors.ThemeTxt
            cell.vehicleInfoLbl.textColor = SColors.ThemeTxt
            cell.liveTrackInfoLbl.textColor = SColors.ThemeTxt
            
            
            if(item.get("TripStatus") == ""){
                cell.liveTrackInfoLbl.isHidden = true
                cell.statusImgView.image = UIImage(named:"ic_clock")
                GeneralFunctions.setImgTintColor(imgView: cell.statusImgView, color: UIColor.orange)
            }else{
                cell.liveTrackInfoLbl.isHidden = false
                cell.statusImgView.image = UIImage(named:"ic_liveTrackTrue")
                GeneralFunctions.setImgTintColor(imgView: cell.statusImgView, color: UIColor.green)
            }
            
            if(item.get("TripStatusDisplay") == ""){
                cell.statusImgView.isHidden = true
            }else{
                cell.statusImgView.isHidden = false
            }
            
            cell.liveTrackInfoLbl.handleClick { instance in
                let trackingLiveUV = GeneralFunctions.instantiateViewController(pageName: "TrackingLiveUV") as! TrackingLiveUV
                trackingLiveUV.dataDic = item
                self.push(uv: trackingLiveUV)
            }
            
            cell.vehicleInfoLbl.handleClick { instance in
                let profileInfoUV = GeneralFunctions.instantiateViewController(pageName: "ProfileInfoUV") as! ProfileInfoUV
                profileInfoUV.dataDic = item
                profileInfoUV.isForVehicleInfo = true
                self.push(uv: profileInfoUV)
                
            }
            
            cell.profileLbl.handleClick { instance in
                let profileInfoUV = GeneralFunctions.instantiateViewController(pageName: "ProfileInfoUV") as! ProfileInfoUV
                profileInfoUV.dataDic = item
                profileInfoUV.trackingListUV = self
                profileInfoUV.index = indexPath.row
                self.push(uv: profileInfoUV)
            }
            
            cell.profileImgView.handleClick { instance in
                let profileInfoUV = GeneralFunctions.instantiateViewController(pageName: "ProfileInfoUV") as! ProfileInfoUV
                profileInfoUV.dataDic = item
                profileInfoUV.trackingListUV = self
                profileInfoUV.index = indexPath.row
                self.push(uv: profileInfoUV)
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            return 190.0
        }else{
            if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
                return 140.0
            }else{
                return 165.0
            }
        }
    
    }
    
    func deleteUser(pairedUserID:String){
        
        let parameters = ["type":"removeLinkedMember", "PairedUserId":pairedUserID, "UserType": Utils.appUserType]
        
        let exeWebServerUrl = ApiHandler(dict_data: parameters, currentView: self.view, isOpenLoader: true)
        
        exeWebServerUrl.executePostProcess(completionHandler: { (response) -> Void in
            
            if(response != ""){
                let dataDict = response.toDict()
                
                if(dataDict.get("Action") == "1"){
                   
                    self.getTrackingList()
                    
                }else{
                   
                    self.generalFunc.setAlertMessage(uv: self, title: "", content: self.generalFunc.getLanguageLabel(origValue: dataDict.get("message"), key: dataDict.get("message")) , positiveBtn: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_BTN_OK_TXT") , nagativeBtn: "", completionHandler: { btnClickedId in
                    })
                    
                }

            }else{
                self.generalFunc.setError(uv: self)
                
            }
        })
    }
    
}
