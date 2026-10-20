

import Foundation


class UFXProServiceBannerTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    @IBOutlet weak var dataCntView: UIView!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var topCornerImgView: UIImageView!
    @IBOutlet weak var iconCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var iconCollectionView: UICollectionView!
   
    @IBOutlet weak var iconCollectionViewTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var iconCollectionViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var subTitleTopSpace: NSLayoutConstraint!
    @IBOutlet weak var titleLblHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLblLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var dataCntView1: UIView!
    @IBOutlet weak var subTitleLbl1: MyLabel!
    @IBOutlet weak var titleLbl1: MyLabel!
    @IBOutlet weak var topCornerImgView1: UIImageView!
    @IBOutlet weak var iconCollectionView1: UICollectionView!
    @IBOutlet weak var iconCollectionView1Height: NSLayoutConstraint!
    
    var uv:UFXProUV!
    var dataArray = [NSDictionary] ()
    var dataArray1 = [NSDictionary] ()
    
    let generalFunc = GeneralFunctions()
    
    var uFXProServiceBannerStyleView:UFXProServiceBannerStyleView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconCollectionView.dataSource = self
        self.iconCollectionView.delegate = self
        
        self.iconCollectionView1.dataSource = self
        self.iconCollectionView1.delegate = self
        
        self.iconCollectionView.register(UINib.init(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
        self.iconCollectionView1.register(UINib.init(nibName: "Table22ServicesListCVCell", bundle: nil), forCellWithReuseIdentifier: "Table22ServicesListCVCell")
    
    }

    @objc func setData(){
        
        if(self.dataArray.count > 0 || self.dataArray1.count > 0){
            
            if(self.dataArray.count > 0){
                self.iconCollectionView.height = 80
                self.iconCollectionView.isHidden = false
                self.iconCollectionView.reloadData()
            }
            
            if(self.dataArray1.count > 0){
                self.iconCollectionView1.height = 80
                self.iconCollectionView1.isHidden = false
                self.iconCollectionView1.reloadData()
            }
            
        }else{
            
            self.iconCollectionView.isHidden = true
            self.iconCollectionView1.isHidden = true
            self.iconCollectionView.height = 0
            self.iconCollectionView1.height = 0
        }
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("ABCCCCCCC:\(self.dataArray.count)")
        
        if(collectionView == self.iconCollectionView){
            return self.dataArray.count
        }else{
            return self.dataArray1.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Table22ServicesListCVCell", for: indexPath as IndexPath) as! Table22ServicesListCVCell
        
        cell.contentView.backgroundColor = .clear
        cell.cntView.backgroundColor = .clear
        var item = NSDictionary()
        if(collectionView == self.iconCollectionView){
            item = self.dataArray[indexPath.item]
        }else{
            item = self.dataArray1[indexPath.item]
        }

        cell.serTitleLbl.text = item.get("vCategory")
        
        cell.origIconImgView.contentMode = .scaleAspectFit
        
        
        let vImage = Utils.getResizeImgURL(imgUrl: item.get("vImage"), width: Utils.getValueInPixel(value: 38) , height: Utils.getValueInPixel(value: 38))
        cell.origIconImgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
        })
        
        print(item.get("vImage"))
        print(vImage)
        
        //cell.imageParentView.backgroundColor = UIColor.init(hexString: item.get("vBgColor"), alpha: 1)
        cell.imageParentView.cornerRadius = 19
        cell.imageParentView.isHidden = false
        cell.serImgView.isHidden = true
        
        cell.settitleLblHeight.constant = 30
        cell.serTitleLbl.font = UIFont.init(name: Fonts().regular, size: 10)
        cell.cntViewtopSpace.constant = 0
        
        cell.imgParentViewWidth.constant = 38
        cell.imgParentViewHeight.constant = 38
        cell.orgIconImgViewWidth.constant = 38
        cell.orgIconImgViewHeight.constant = 38
        
        cell.contentView.handleClick { instance in
            if(self.uv != nil){
                var dataItem = NSDictionary()
                if(collectionView == self.iconCollectionView){
                    dataItem = self.dataArray[indexPath.item]
                }else{
                    dataItem = self.dataArray1[indexPath.item]
                }
                if(dataItem.get("moreSection") == "Yes"){
                    self.uv.openMoreView(dataArray: dataItem.arrOf("moreCategories") as! [NSDictionary], moreTitle:dataItem.get("vCategoryTitle"))
                }else{
                    self.uv.openCategory(item: dataItem)
                }
            }
        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if(uFXProServiceBannerStyleView.servicesArray.count > 1){
            return CGSize(width: (((Application.screenSize.width - 40) / 2) / 3), height: 80)
        }else{
            return CGSize(width: ((Application.screenSize.width - 110) / 3), height: 80)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.uv != nil){
            var dataItem = NSDictionary()
            if(collectionView == self.iconCollectionView){
                dataItem = self.dataArray[indexPath.item]
            }else{
                dataItem = self.dataArray1[indexPath.item]
            }
            if(dataItem.get("moreSection") == "Yes"){
                self.uv.openMoreView(dataArray: dataItem.arrOf("moreCategories") as! [NSDictionary], moreTitle:dataItem.get("vCategoryTitle"))
            }else{
                self.uv.openCategory(item: dataItem)
            }
        }
    }
  
}
