

import UIKit

class RestaurantDetailRecommendedCVCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var menuScrollCntViewWidth: NSLayoutConstraint!
    @IBOutlet weak var menuScrollCntView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var scrollCntViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollCntView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemTypeImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imgHintLbl: MyLabel!
    @IBOutlet weak var hintImgView: UIImageView!
    @IBOutlet weak var itemTypeImgView: UIImageView!
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var itemHLbl: MarqueeLabel!
    @IBOutlet weak var itemSLbl: MyLabel!
    @IBOutlet weak var strikeOutPriceLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var addBtnLbl: MyLabel!
    @IBOutlet weak var priceLblTopSpace: NSLayoutConstraint!
    @IBOutlet weak var strikeOutPriceLblHeight: NSLayoutConstraint!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var dataArray = [NSDictionary]()
    var isRestaurantClose = false
    var mainDic = NSDictionary ()
    var generalFunc = GeneralFunctions()
    var uv:UIViewController!
    var minOrdeValue = ""
    

    var checkImgLoadedArray = [Bool]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.itemCollectionView.dataSource = self
        self.itemCollectionView.delegate = self
        self.itemCollectionView.register(UINib.init(nibName: "RecomandeditemCVCell", bundle: nil), forCellWithReuseIdentifier: "RecomandeditemCVCell")
        //self.itemCollectionView.reloadData()
        
        self.itemCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        if self.dataArray.count != 0{
                    self.perform(#selector(reloadCollectionView), with: self, afterDelay: 0.1)
                }
       // self.perform(#selector(reloadCollectionView), with: self, afterDelay: 0.1)
        //self.itemCollectionView.reloadData()
        
    }
    
    @objc func reloadCollectionView(){
        self.itemCollectionView.layoutIfNeeded()
        self.itemCollectionView.reloadData()
        self.itemCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
        self.itemCollectionView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return self.dataArray.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomandeditemCVCell", for: indexPath as IndexPath) as! RecomandeditemCVCell
    
        let detailUV = (self.uv as! RestaurantDetailsUV)
       
        let foodItemArray = self.dataArray
        
        let i = indexPath.row
       
        let dic = Configurations.isRTLMode() ? foodItemArray[i] : foodItemArray[i]
       
        if dic.get("eFoodType") == "Veg"
        {
            cell.itemTypeImgViewWidth.constant = 18
            cell.itemTypeImgView.image = UIImage(named: "ic_veg")
        }else if foodItemArray[i].get("eFoodType") == "NonVeg"
        {
            cell.itemTypeImgViewWidth.constant = 18
            cell.itemTypeImgView.image = UIImage(named: "ic_nonVeg")
        }else if (foodItemArray[i].get("prescription_required").uppercased() == "YES"){
            cell.itemTypeImgViewWidth.constant = 18
            cell.itemTypeImgView.isHidden = false
            cell.itemTypeImgView.image = UIImage(named: "ic_drugs")?.addImagePadding(x: 5, y: 5)
        }else{
            cell.itemTypeImgViewWidth.constant = 0
            cell.itemTypeImgView.isHidden = true
        }
        
        
        if GeneralFunctions.parseDouble(origValue: 0, data: foodItemArray[indexPath.row].get("fOfferAmt")) > 0
        {
            let attributedString = NSMutableAttributedString(string: Configurations.convertNumToAppLocal(numStr: foodItemArray[i].get("StrikeoutPrice")))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
            
            cell.strikeOutPriceLbl.attributedText = attributedString
            cell.priceLbl.text = Configurations.convertNumToAppLocal(numStr: foodItemArray[i].get("fDiscountPricewithsymbol"))
            cell.priceLbl.textColor = SColors.blackColor
            
            cell.strikeOutPriceLblHeight.constant = 15
            cell.priceLblTopSpace.constant = 2
            
        }else
        {
            cell.strikeOutPriceLblHeight.constant = 0
            cell.priceLblTopSpace.constant = 8
            cell.priceLbl.text = Configurations.convertNumToAppLocal(numStr: foodItemArray[i].get("StrikeoutPrice"))
            cell.priceLbl.textColor = SColors.blackColor
        }
        
        cell.itemImgView.sd_setShowActivityIndicatorView(true)
        cell.itemImgView.sd_setIndicatorStyle(.gray)
        cell.itemImgView.tag = i
        
  
        cell.cntViewWidth.constant = 280
        cell.cntViewHeight.constant = collectionView.frame.height
        
        cell.itemImgView.contentMode = .scaleAspectFit
        let heightOfImag = collectionView.frame.height - 100
        
        
        cell.itemImgView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: foodItemArray[i].get("vImage"), width: Utils.getValueInPixel(value: 280), height: Utils.getValueInPixel(value: heightOfImag))), placeholderImage:nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            
            if image == nil {
                cell.itemImgView.contentMode = .scaleAspectFit
            }else{
                cell.itemImgView.contentMode = .scaleToFill
            }
        })
        Utils.delayWithSeconds(0.5) {
            cell.itemImgView.roundTo(corners: [.topLeft,.topRight], radius: 10)
        }
        
        cell.itemImgViewHeight.constant = CGFloat(heightOfImag)
       
        // Recmoomanded Animation
        
        cell.itemImgView.handleClick { (instance) in
            
            detailUV.bottomCartView.isHidden = true
            detailUV.bottomCartViewHeight.constant = 0
            
            detailUV.recommandedView.isHidden = false
            detailUV.navigationController?.setNavigationBarHidden(true, animated: true)
            
            detailUV.recommandedCollectionView.scrollToItem(at: IndexPath(row: instance.tag, section: 0), at: .top, animated: false)
            Utils.delayWithSeconds(2) {
                

                detailUV.recommandedCollectionView.reloadData()
               // detailUV.recommandedCollectionView.scrollToItem(at: IndexPath(row: instance.tag, section: 0), at: .top, animated: false)

            }
        }
        
//        if(foodItemArray[i].get("vImage") == ""){
//            cell.itemImgView.contentMode = .scaleAspectFit
//        }
        
        cell.itemHLbl.text = foodItemArray[i].get("vItemType")
        cell.itemSLbl.text = foodItemArray[i].get("vCategoryName")
        cell.itemHLbl.font = UIFont.init(name: Fonts().semibold, size: 15)
        
        cell.imgHintLbl.textColor = SColors.ThemeTxt
        
        cell.addBtnLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ADD")
        cell.addBtnLbl.textColor = SColors.ThemeTxt
        cell.addBtnLbl.backgroundColor = SColors.Theme
        
        if(Configurations.isRTLMode()){
            cell.itemSLbl.textAlignment = .right
            cell.addBtnLbl.paddingLeft = 25
        }else{
            cell.itemSLbl.textAlignment = .left
            cell.addBtnLbl.paddingLeft = 25
        }
        
        GeneralFunctions.setImgTintColor(imgView: cell.cartImgView, color: SColors.ThemeTxt)
        
        if self.dataArray[i].get("vHighlightName") == ""
        {
            cell.hintImgView.isHidden = true
            cell.imgHintLbl.isHidden = true
        }else
        {
            cell.hintImgView.isHidden = false
            cell.imgHintLbl.isHidden = false
            cell.imgHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: self.dataArray[i].get("vHighlightName")).uppercased()
        }
        
        if(Configurations.isRTLMode()){
            cell.hintImgView.transform  = CGAffineTransform(rotationAngle: 180 * CGFloat(CGFloat.pi/180)).concatenating(CGAffineTransform(scaleX: 1, y: -1))
        }
        
        cell.addBtnLbl.isUserInteractionEnabled = true
        cell.addBtnLbl.tag = i
        cell.addBtnLbl.handleClick { (instance) in
            self.recAddTapped(tag:instance.tag)
        }
        
        //              recmdView.cntView.clipsToBounds = true
        //                recmdView.cntView.layer.addShadow(opacity: 0.8, radius: 1.2, UIColor.lightGray)
        
        
        
        if((Utils.getValueInPixel(value: Application.screenSize.width) / 2) <= 375){
//            if(Configurations.isRTLMode()){
//                cell.transform = CGAffineTransform(scaleX: -1, y: 1)
//            }
//            if(Configurations.isRTLMode()){
//                cell.contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            }
            
            if #available(iOS 13, *) {
                // iOS 11 (or newer) Swift code
            } else {
                if(Configurations.isRTLMode()){
                    cell.contentView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                }
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
       // return CGSize(width: Application.screenSize.width / 1.3, height:((Application.screenSize.height * 15) / 100) + 160)
        return CGSize(width: 280, height: collectionView.frame.height)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }


    @objc func recAddTapped(tag:Int)
    {
        
        let index = tag
        
        let foodItemArray = self.dataArray
        let addToCartUV = GeneralFunctions.instantiateViewController(pageName: "AddToCartUV") as! AddToCartUV
        addToCartUV.isRestaurantClose = self.isRestaurantClose
        //addToCartUV.transitioningDelegate = self
        addToCartUV.modalPresentationStyle = .custom
        addToCartUV.foodItemDetails = foodItemArray[index]
        addToCartUV.companyId = self.mainDic.get("iCompanyId")
        addToCartUV.comapnyName = self.mainDic.get("vCompany")
        addToCartUV.minOrder = self.minOrdeValue
        addToCartUV.vImage = self.mainDic.get("vImage")
        addToCartUV.companyAddress = self.mainDic.get("vCaddress")
        addToCartUV.eAvialble = self.mainDic.get("eAvailable")
        addToCartUV.timeSlot = self.mainDic.get("timeslotavailable")
        self.uv.push(uv: addToCartUV)
    }
}
