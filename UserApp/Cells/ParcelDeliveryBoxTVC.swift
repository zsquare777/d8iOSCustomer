//
//  ParcelDeliveryBoxTVC.swift
//  UserApp
//
//  Created by # Admin on 31/07/23.
//

import UIKit

class ParcelDeliveryBoxTVC: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var sendBtn: MyButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var uv:UFXProUV!
    let generalFunc = GeneralFunctions()
    
    var parcelDeliveryGridView:ParcelDeliveryGridView!
    var dataArray = [NSDictionary] ()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(UINib.init(nibName: "ParcelDeiveryBoxCVC", bundle: nil), forCellWithReuseIdentifier: "ParcelDeiveryBoxCVC")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @objc func setData(){
        
        self.dataArray = self.parcelDeliveryGridView.servicesArray
        self.collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParcelDeiveryBoxCVC", for: indexPath as IndexPath) as! ParcelDeiveryBoxCVC
        
        let item = self.dataArray[indexPath.item]
        cell.serTitleLbl.text = item.get("itemName")
        cell.imageParentView.borderColor = UIColor.init(hexString: "E6E6E6", alpha: 1)
        cell.imageParentView.borderWidth = 1.0
        Utils.delayWithSeconds(0.2) {
            cell.imgParentViewWidth.constant = cell.imageParentView.frame.size.height
        }
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 45), height: Utils.getValueInPixel(value: 45))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: getSizeOfImg(), height: getSizeOfImg() + 15)
        
    }
        
   
    
    private func getSizeOfImg(noOfCellsInRow : Int = 4) -> CGFloat {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        return (collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)
    }
}
