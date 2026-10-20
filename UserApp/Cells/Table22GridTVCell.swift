

import Foundation
class Table22GridTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
 
    @IBOutlet weak var gridCollectionView: UICollectionView!
    var uv:UFXHomeUV!
    
    var listOfParentGridCategories = [NSDictionary] ()
    var dataArray = [NSDictionary] ()
    
    var moreServiceImg = ""
    let generalFunc = GeneralFunctions()
    
    var moreAvailable = false
    var moreIconImage = ""
   
    var cellHeight = 0.0
    var isVideoSection = "No"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.gridCollectionView.dataSource = self
        self.gridCollectionView.delegate = self
        self.gridCollectionView.register(UINib.init(nibName: "UFXJekIconCVC", bundle: nil), forCellWithReuseIdentifier: "UFXJekIconCVC")
       
        self.gridCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UFXJekIconCVC", for: indexPath as IndexPath) as! UFXJekIconCVC
        
        let item = self.dataArray[indexPath.item]
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vLogo_image"), width: Utils.getValueInPixel(value: 60), height: Utils.getValueInPixel(value: 60))
        
        cell.iconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: UIImage(named:"ic_no_icon"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
            if(image != nil){
                cell.iconImgView.image = image
            }else if(item.get("vLogo_image") != "" && !item.get("vLogo_image").contains(find: "http")){
                cell.iconImgView.image = UIImage(named: item.get("vLogo_image"))
            }else{
               cell.iconImgView.image = UIImage(named: "ic_no_icon")
            }
        })

        cell.bgView.backgroundColor = UIColor.clear
        cell.categoryLbl.text = item.get("vCategory")
        if(item.get("vCategory").contains(find: " ")){
            cell.categoryLbl.numberOfLines = 2
        }else{
            cell.categoryLbl.numberOfLines = 1
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
       
    }

    func getWidthOfItem() -> CGFloat{
        let totalItemInRow = Int(Application.screenSize.width / 100) < 4 ? 4 : Int(Application.screenSize.width / 100)
        return (Application.screenSize.width / CGFloat(totalItemInRow)) - 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: getWidthOfItem(), height: 115)
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = self.dataArray[indexPath.row]
        let eCatType = item.get("eCatType")
        if(eCatType.uppercased() == "MORE"){
            
            self.uv.moreTitle = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_SELECT_SERVICE")
            if self.uv.moreServicesView == nil{
                self.uv.addMoreServiceView()
            }

            self.uv.moreDataFor22 = self.listOfParentGridCategories
            self.uv.btnSheetCollectionView.reloadData()
            
            self.uv.btnSheetCollectionView.setContentOffset(CGPoint(x: self.uv.btnSheetCollectionView.contentOffset.x, y:-self.uv.btnSheetCollectionView.contentInset.top), animated: false)
            self.uv.moreServicesView.dragViewAnimatedTopMargin = Application.screenSize.height - 350
            self.uv.moreServicesView.perfomViewOpenORCloseAction(cancelTapped:false, closeFull:false)
            self.uv.moreServicesView.dragViewAnimatedTopMargin = 0
            self.uv.btnSheetCollectionView.reloadData()
            self.uv.moreServicesBGView.isHidden = false
            
        }
        
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
