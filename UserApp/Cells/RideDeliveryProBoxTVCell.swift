//
//  RideDeliveryProBoxTVCell.swift
//  
//
//  Created by # Admin on 23/03/23.
//

import UIKit

class RideDeliveryProBoxTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var boxCollectionView: UICollectionView!
    var uv:UFXProUV!
    let generalFunc = GeneralFunctions()
    
    var riideDeliveryBoxView:RideDeliveryBoxView!
    var dataArray = [NSDictionary] ()
    
    var didSelectBoxCloser : ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.boxCollectionView.dataSource = self
        self.boxCollectionView.delegate = self
        
        self.boxCollectionView.register(UINib.init(nibName: "RideDeliveryNewCVCell", bundle: nil), forCellWithReuseIdentifier: "RideDeliveryNewCVCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func setData(){
        
        self.dataArray = self.riideDeliveryBoxView.servicesArray
        self.boxCollectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RideDeliveryNewCVCell", for: indexPath as IndexPath) as! RideDeliveryNewCVCell
        
        let item = self.dataArray[indexPath.item]
        cell.titleLbl.text = item.get("vTitle")
        cell.subTitleLbl.text = item.get("vSubTitle")
        cell.itemImageHight.constant = (getSizeOfImg() - 10)
        
        let isImageRadius = (item.get("ImageRadius") as NSString).boolValue
        if isImageRadius {
            cell.itemImageView.cornerRadius = 8.0
        }else {
            cell.itemImageView.cornerRadius = 0
        }
        cell.itemImageView.clipsToBounds = true

        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: cell.itemImageHight.constant) , height: Utils.getValueInPixel(value: cell.itemImageHight.constant))
        cell.itemImageView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthImg = getSizeOfImg()
        return CGSize(width: widthImg, height: widthImg + 80)
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectBoxCloser?(indexPath.row)
    }
    
    private func getSizeOfImg(noOfCellsInRow : Int = 3) -> CGFloat {
        let flowLayout = boxCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        return (boxCollectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)
    }
}
