

import Foundation


class UFXProHBoxTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var iconCollectionView: UICollectionView!
    
    @IBOutlet weak var icomCollectionViewLeading: NSLayoutConstraint!
    @IBOutlet weak var iconCollectionViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var iconColletionViewTop: NSLayoutConstraint!
    let generalFunc = GeneralFunctions()
   
    var uFXProHBoxView:UFXProHBoxView!
    
    var dataArray = [NSDictionary] ()
   
    var uv:UFXProUV!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconCollectionView.dataSource = self
        self.iconCollectionView.delegate = self
        
        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
            
            icomCollectionViewLeading.constant = 15
            iconCollectionViewTrailing.constant = 15
            iconColletionViewTop.constant = 0
        }else{
            icomCollectionViewLeading.constant = 0
            iconCollectionViewTrailing.constant = 0
            iconColletionViewTop.constant = 5
        }
        self.iconCollectionView.register(UINib.init(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
        
    }

    @objc func setData(){
        
        self.dataArray = self.uFXProHBoxView.servicesArray
        
    
        self.iconCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("ABCCCCCCC:\(self.dataArray.count)")
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        
        let item = self.dataArray[indexPath.item]
        cell.serTitleLbl.text = item.get("vCategory")
        var pImageHight = 70
        var imageHight = 60
        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
          
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                
                pImageHight = Int(Application.screenSize.width / 4) - 60
                imageHight = Int(Application.screenSize.width / 4) - 60
                cell.imgParentViewWidth.constant = (Application.screenSize.width / 4 ) - 40
                cell.imgParentViewHeight.constant = (Application.screenSize.width / 4 ) - 40
                cell.orgIconImgViewWidth.constant = (Application.screenSize.width / 4 ) - 60
                cell.orgIconImgViewHeight.constant = (Application.screenSize.width / 4 ) - 60
                cell.lblTop.constant = 40
                cell.imgParentViewCenterY.constant = 20
            }else{
                pImageHight = 74
                imageHight = 64
                cell.imgParentViewWidth.constant = 74
                cell.imgParentViewHeight.constant = 74
                cell.orgIconImgViewWidth.constant = 64
                cell.orgIconImgViewHeight.constant = 64
            }
        }
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: CGFloat(imageHight)) , height: Utils.getValueInPixel(value: CGFloat(imageHight)))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
            
            cell.settitleLblHeight.constant = 40
        }
        
        //cell.imageParentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
        cell.origIconImgView.clipsToBounds = true
        let isImageRadius = (item.get("ImageRadius") as NSString).boolValue
        if isImageRadius {
            cell.origIconImgView.cornerRadius = 8.0
            cell.viewOrgImgShadow.cornerRadius = 8.0
        }else {
            cell.origIconImgView.cornerRadius = 0
            cell.viewOrgImgShadow.cornerRadius = 0
        }

        cell.viewOrgImgShadow.clipsToBounds = true
        let showBackgroundShadow = (item.get("showBackgroundShadow") as NSString).boolValue
        if showBackgroundShadow {
            
            cell.viewOrgImgShadow.shadowColor = UIColor.black.withAlphaComponent(0.25)
            cell.viewOrgImgShadow.shadowOffset = CGSize(width: 0, height: 0.0)
            cell.viewOrgImgShadow.shadowRadius = 2
            cell.viewOrgImgShadow.shadowOpacity = 0.7
            
            cell.viewOrgImgShadow.clipsToBounds = false
        }

        cell.imageParentView.isHidden = false
        cell.serImgView.isHidden = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    

        if  ServiceModule.rideProduct || ServiceModule.rideDeliveryProduct || ServiceModule.cubex {
            let widthImg = getSizeOfImg()
            return CGSize(width: widthImg, height: widthImg + 30)
        }
        let width = ((Application.screenSize.width / 4))
        return CGSize(width: width, height: width + 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.uv != nil){
            let item = self.dataArray[indexPath.item]
            if(item.get("moreSection") == "Yes"){
                self.uv.openMoreView(dataArray: item.arrOf("moreCategories") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
            }else{
                self.uv.openCategory(item: item)
            }
    
        }
    }
    private func getSizeOfImg(noOfCellsInRow : Int = 4) -> CGFloat {
        let flowLayout = iconCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        return (iconCollectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)
    }
   

}
