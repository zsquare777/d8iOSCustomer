

import Foundation


class UFXProVBoxTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var iconCollectionView: UICollectionView!
   
    let generalFunc = GeneralFunctions()
   
    var uFXProVBoxView:UFXProVBoxView!
    var dataArray = [NSDictionary] ()
   
    var uv:UFXProUV!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconCollectionView.dataSource = self
        self.iconCollectionView.delegate = self
        
        self.iconCollectionView.register(UINib.init(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
        self.iconCollectionView.register(UINib.init(nibName: "UfxProFullImgBoxCVCell", bundle: nil), forCellWithReuseIdentifier: "UfxProFullImgBoxCVCell")
        
    }

    @objc func setData(){
        
        self.dataArray = self.uFXProVBoxView.servicesArray
        
    
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
        
        
        if ServiceModule.deliveryKing {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UfxProFullImgBoxCVCell", for: indexPath as IndexPath) as! UfxProFullImgBoxCVCell
            
            
            cell.cntView.clipsToBounds = true
            cell.cntView.layer.cornerRadius = 10.0
            cell.cntView.layer.borderWidth = 0.0
//            cell.cntView.layer.shadowColor = UIColor.lightGray.cgColor
//            cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
//            cell.cntView.layer.shadowRadius = 2.0
//            cell.cntView.layer.shadowOpacity = 1
            cell.cntView.layer.masksToBounds = false
            
            let item = self.dataArray[indexPath.item]
            cell.titleLbl.text = item.get("vCategory")

          
          
            let vImage = Utils.getResizeImgURL(imgUrl: item.get("vListLogo"), width: Utils.getValueInPixel(value: ((Application.screenSize.width - 50) / 3)) , height: Utils.getValueInPixel(value:0))
             
            cell.serviceIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
            })
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        
        cell.cntView.clipsToBounds = true
        cell.cntView.layer.cornerRadius = 10.0
        cell.cntView.layer.borderColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.borderWidth = 0.5
        cell.cntView.layer.shadowColor = UIColor(hex: 0xD9D9D9).cgColor
        cell.cntView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cntView.layer.shadowRadius = 1.5
        cell.cntView.layer.shadowOpacity = 1
        cell.cntView.layer.masksToBounds = false
 
        let item = self.dataArray[indexPath.item]
        cell.serTitleLbl.text = item.get("vCategoryName")
        cell.serTitleLbl.textColor = UIColor(hex: 0x1B2A3B)
       
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 56) , height: Utils.getValueInPixel(value: 56))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            cell.cntView.layer.cornerRadius = 10.0
        })
        
        //cell.imageParentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
        cell.imageParentView.cornerRadius = 23
        cell.imageParentView.isHidden = false
        cell.serImgView.isHidden = true
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
        if ServiceModule.deliveryKing {
            return CGSize(width: (Application.screenSize.width - 50) / 3, height: (Application.screenSize.width - 50) / 3)
        }else{
            var width = 125.0
            var height = 145.0
            
            if(Int(((Application.screenSize.width - 30) / width)) <= 2){
                width = 110.0
                height = 130.0
            }
            
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.uv != nil){
            let item = self.dataArray[indexPath.item]
            
            if((item.arrOf("SubCategories") as! [NSDictionary]).count > 0){
                self.uv.openMoreView(dataArray: item.arrOf("SubCategories") as! [NSDictionary], moreTitle:item.get("vCategoryTitle"))
            }else{
                self.uv.openCategory(item: item)
            }
            
        }
    }
    
}
