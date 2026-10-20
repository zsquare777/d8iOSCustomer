

import Foundation


class RideDeliveryCollectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rideDeliveryServicesDataArray = [NSDictionary] ()
    
    let cellWidth = (Application.screenSize.width - 60) / 3
    
    var moreDeliveriesUV:MoreDeliveriesUV!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "RideDeliveryCVCell", bundle: nil), forCellWithReuseIdentifier: "RideDeliveryCVCell")
        self.collectionView.bounces = false
        //self.collectionView.reloadData()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        self.perform(#selector(reloadCollectionView), with: self, afterDelay: 0.1)
    }
    
    @objc func reloadCollectionView(){
        self.collectionView.layoutIfNeeded()
        self.collectionView.reloadData()
        //self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
        self.collectionView.isHidden = false
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.rideDeliveryServicesDataArray.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RideDeliveryCVCell", for: indexPath as IndexPath) as! RideDeliveryCVCell
        
        let item = self.rideDeliveryServicesDataArray[indexPath.row]
        
        cell.imgViewWidth.constant = cellWidth - 40
        cell.imageViewHeight.constant = cellWidth - 40
        
        
        let heightWidth = Utils.getValueInPixel(value: CGFloat(Int(self.cellWidth) - 40))
        
        
        cell.serviceIconImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: heightWidth, height: heightWidth)), placeholderImage:UIImage(named:"ic_no_icon"))
        
        
        cell.titleLbl.text = item.get("vCategory")
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        
        return CGSize(width: cellWidth, height: cellWidth + 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.moreDeliveriesUV.cateroriesDataArr.count > 0){
            let holder = self.moreDeliveriesUV.cateroriesDataArr[indexPath.item]
            //let item = holder.subCategoriesDataArr[indexPath.row] as! NSDictionary
        
            _ = OpenCatType.init(uv: self.moreDeliveriesUV, navItem: self.moreDeliveriesUV.navItem, item: holder.categoriesDataDict)
        }
       
        
    }


  
}
