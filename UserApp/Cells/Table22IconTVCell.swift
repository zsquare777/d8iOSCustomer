

import Foundation


class Table22IconTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    @IBOutlet weak var collectionViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var iconCollectionView: UICollectionView!
    var uv:UFXHomeUV!
    
    var dataArray = [NSDictionary] ()
    
    var listOfCount:Int!
    
    var moreServiceImg = ""
    let generalFunc = GeneralFunctions()
    var isServiceIcon = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconCollectionView.dataSource = self
        self.iconCollectionView.delegate = self
        
        if(isServiceIcon){
            self.iconCollectionView.register(UINib.init(nibName: "SerrviceIconCVCell", bundle: nil), forCellWithReuseIdentifier: "SerrviceIconCVCell")
           
        }else{
            self.iconCollectionView.register(UINib.init(nibName: "Table22IconCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22IconCVCell")
        }
    
        self.iconCollectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.isAddMoreBtn()){
            return self.listOfCount + 1
        }
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(isServiceIcon){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerrviceIconCVCell", for: indexPath as IndexPath) as! SerrviceIconCVCell
            
            cell.cntView.clipsToBounds = true
            cell.cntView.layer.cornerRadius = 10.0
            cell.cntView.layer.borderWidth = 0.0
            cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.cntView.layer.shadowRadius = 2.0
            cell.cntView.layer.shadowOpacity = 1
            cell.cntView.layer.masksToBounds = false
            
            let item = self.dataArray[indexPath.item]
            cell.titleLbl.text = item.get("vCategory")

           // cell.cntView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
           // cell.cntView.borderColor = UIColor.init(hexString: item.get("vBorderColor"), alpha: 1)
           // cell.cntView.borderWidth = 1.0
            
          
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: ((Application.screenSize.width - 30) / 3) * 0.45) , height: Utils.getValueInPixel(value:0))
             
            cell.serviceIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22IconCVCell", for: indexPath as IndexPath) as! Table22IconCVCell
            cell.serviceIconImgView.clipsToBounds = true
            cell.serviceIconImgView.layer.cornerRadius = 40.0
            cell.serviceIconImgView.layer.borderWidth = 0.0
            cell.serviceIconImgView.layer.shadowColor = UIColor.lightGray.cgColor
            cell.serviceIconImgView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.serviceIconImgView.layer.shadowRadius = 2.0
            cell.serviceIconImgView.layer.shadowOpacity = 1
            cell.serviceIconImgView.layer.masksToBounds = false
            
            if(self.isAddMoreBtn() && indexPath.row == self.listOfCount){
                cell.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")

                let vImage = Utils.getResizeImgURL(imgUrl: self.moreServiceImg, width: Utils.getValueInPixel(value: 80) , height: Utils.getValueInPixel(value: 80))
                cell.serviceIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
            }else{
                let item = self.dataArray[indexPath.item]
                cell.titleLbl.text = item.get("vCategory")

                
                let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 80) , height: Utils.getValueInPixel(value: 80))
                cell.serviceIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    
                })
            }
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
       // return CGSize(width: Application.screenSize.width / 1.3, height:((Application.screenSize.height * 15) / 100) + 160)
        
        if(isServiceIcon){
            return CGSize(width: (Application.screenSize.width - 30) / 3, height: (Application.screenSize.width - 30) / 3)
        }else{
            return CGSize(width: 100, height: 150)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.isAddMoreBtn() && indexPath.row == self.listOfCount){
            // OPEN MORE VIEW
            self.uv.addMoreServiceView()
            
        }else{
            let item = self.dataArray[indexPath.row]
            
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                self.uv.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                _ = OpenCatType.init(uv: self.uv, navItem: self.uv.homeTabBar.navItem, item: item)
            
            }
            
            if(self.uv.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.uv.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                
                var isVideo = "No"
                if(item.get("VideoConsultSection").uppercased() == "YES"){
                    isVideo = "Yes"
                }
               
                self.uv.loadServiceCategory(parentCategoryId: item.get("iVehicleCategoryId"), isVideo)
            }
            
            if item.get("eCatType").uppercased() == "BIDDING"{
               // self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"))
                
                self.uv.selectServiceLbl.text = item.get("vCategory")
                self.uv.serviceTitle22Lbl.text = item.get("vCategory")
                self.uv.loadServiceCategory(parentCategoryId: item.get("iBiddingId"), category: item.get("eCatType"), item.get("isVideoConsultEnable"))
            }
        }
    }
    
    func isAddMoreBtn() -> Bool{
        
        if(self.listOfCount != nil){
            if(self.dataArray.count > self.listOfCount){
                return true
            }
        }
        
        return false
    }

}
