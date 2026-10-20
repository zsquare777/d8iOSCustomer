

import Foundation
import Lottie

class Table22CubeXServicesTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var serviceCntView: UIView!
    @IBOutlet weak var serviceImgHolderView: UIView!
    @IBOutlet weak var serviceImgView: UIImageView!
    @IBOutlet weak var serviceNameTitleLbl: MyLabel!
    @IBOutlet weak var animationView: UIView!
    
    var dataArray = [NSDictionary] ()
    var getItem = NSDictionary ()
    var uv:UFXHomeUV!
    
    
    var listOfCount:Int!
    
    var moreServiceImg = ""
    let generalFunc = GeneralFunctions()
    
    var isVideoSection = "No"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        self.servicesCollectionView.contentInset = UIEdgeInsets(top: 0, left: (Application.screenSize.width * 0.20) + 40, bottom: 0, right: 15)
        self.servicesCollectionView.dataSource = self
        self.servicesCollectionView.delegate = self
        self.servicesCollectionView.register(UINib.init(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")

       // self.servicesCollectionView.reloadData()
        
        
       // self.servicesCollectionView.layoutIfNeeded()
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        
        var width = 125.0
        width = Application.screenSize.width - ((Application.screenSize.width * 0.20) + 40)

        let cellWidth = (width / 2) - 20
        let cellHeight = ((width / 2) - 25) + 40
        
        cell.cntView.clipsToBounds = true
        cell.cntView.layer.cornerRadius = 10.0
        cell.cntView.layer.borderWidth = 0.0
        cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cntView.layer.shadowRadius = 2.0
        cell.cntView.layer.shadowOpacity = 1
        cell.cntView.layer.masksToBounds = false
        
        if(self.isAddMoreBtn() && indexPath.row == self.listOfCount){
            cell.serTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_MORE")

            let vImage = Utils.getResizeImgURL(imgUrl: moreServiceImg, width: Utils.getValueInPixel(value: cellWidth * 0.50) , height: Utils.getValueInPixel(value: cellHeight * 0.47))
            cell.serImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            })
        }else{
            let item = self.dataArray[indexPath.item]
            cell.serTitleLbl.text = item.get("vCategory")
            
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: cellWidth * 0.50) , height: Utils.getValueInPixel(value: cellHeight * 0.47))
            cell.serImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
        }
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
       // return CGSize(width: Application.screenSize.width / 1.3, height:((Application.screenSize.height * 15) / 100) + 160)
        
        var width = 125.0
        width = Application.screenSize.width - ((Application.screenSize.width * 0.20) + 40)
        
//        let quat = Int(Int(width) / 2)
//
//        if(width < (125.0 * Double(quat)) + Double((quat * 20))){
//            width = 125 + 15
//        }else{
//            width = 125
//        }
        
//
        return CGSize(width: (width / 2) - 20, height: ((width / 2) - 25) + 40)
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.isAddMoreBtn() && indexPath.row == self.listOfCount){
            // OPEN MORE VIEW
            let item = self.dataArray[indexPath.row]
            self.uv.moreDataFor22 = self.dataArray
           if  self.uv.lblServiceSlect != nil {
                self.uv.lblServiceSlect.text = getItem.get("vCategoryTitle")
            }else{
                self.uv.moreTitle = getItem.get("vCategoryTitle")
            }
            
            self.uv.handleMore()
            
        }else{
            let item = self.dataArray[indexPath.row]
            
            if(ServiceModule.rideDeliveryUbexProduct || ServiceModule.serviceProviderProduct){

                self.uv.selectServiceLbl.layer.borderColor = UIColor.clear.cgColor
                _ = OpenCatType.init(uv: self.uv, navItem: self.uv.homeTabBar.navItem, item: item)
                

            }
            
            if(self.uv.userProfileJson.get("UBERX_PARENT_CAT_ID") == "0" && self.uv.currentMode == "PARENT_MODE" && item.get("eCatType").uppercased() == "SERVICEPROVIDER"){
                
                self.uv.selectServiceLbl.text = item.get("vCategory")
                self.uv.serviceTitle22Lbl.text = item.get("vCategory")
                
                var isVideo = "No"
                if(ServiceModule.vcM && isVideoSection.uppercased() == "YES"){
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.x > 0.0){
            self.showHideDefaultViewOnScroll(isHide: true)
        }else{
            self.showHideDefaultViewOnScroll(isHide: false)
        }
       
    }
    
    func showHideDefaultViewOnScroll(isHide:Bool){
        
        
        if(isHide){
            self.serviceImgView.isHidden = true
            self.serviceNameTitleLbl.isHidden = true
        }else{
            self.serviceImgView.isHidden = false
            self.serviceNameTitleLbl.isHidden = false
        }
    }
    
}
