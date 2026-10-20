

import UIKit
import CoreLocation
import WebKit

class RentCategoryListTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WKNavigationDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    var pageControl:UIPageControl = UIPageControl()
    
    var dataArray = [NSDictionary]()
    var isListAll = false
    let generalFunc = GeneralFunctions()
    var currentLocation:CLLocation!
    var uv:UIViewController!
    var whoDetailView:WhoDetailView! = nil
    var eType = ""
    var isBuySell = ""
    @IBOutlet weak var advertiseView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isScrollEnabled = false
       
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        self.collectionView.register(UINib.init(nibName: "RentItemListCVCell", bundle: nil), forCellWithReuseIdentifier: "RentItemListCVCell")
        self.collectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    } 
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentItemListCVCell", for: indexPath as IndexPath) as! RentItemListCVCell
        
        cell.contanierView.cornerRadius = 8.0
        GeneralFunctions.setImgTintColor(imgView: cell.secureUserImageView, color: SColors.Theme)
        GeneralFunctions.setImgTintColor(imgView: cell.addressImgView, color: UIColor(hex: 0x1B2A3B))
        cell.contanierView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contanierView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.contanierView.layer.shadowRadius = 3.0
        cell.contanierView.layer.shadowOpacity = 1
        cell.contanierView.layer.masksToBounds = false
        cell.cotactBgView.layer.cornerRadius = cell.cotactBgView.frame.size.width / 2
        cell.cotactBgView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.cotactBgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.cotactBgView.layer.shadowRadius = 3.0
        cell.cotactBgView.layer.shadowOpacity = 1
        Utils.delayWithSeconds(0.1) {
            cell.imageView.round(corners: [.topLeft,.topRight], cornerRadius: 8)
        }
        
        let item = self.dataArray[indexPath.item]
        let sizeValue = Utils.getValueInPixel(value: 100)
        let imageUrl = item.arrOf("Images") as! [NSDictionary]
        if item.get("eIsFavourite").uppercased() == "YES" {
            cell.favIconImage.image = UIImage.init(named: "ic_sel_favStore")
        }else{
            cell.favIconImage.image = UIImage.init(named: "ic_dis_favStore")
        }
        cell.imageView.sd_setImage(with: URL(string: Utils.getResizeImgURL(imgUrl: imageUrl[0].get("vImage"), width: Utils.getValueInPixel(value: cell.imageView.frame.size.width), height: Utils.getValueInPixel(value: 100))), placeholderImage:nil)
        cell.priceLbl.text = item.get("fAmount")
        cell.nameLbl.text = item.get("vItemName")
        cell.nameLbl.textColor = SColors.Theme
        if item.get("eRentItemDuration") != "" {
            cell.kmLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_RENT_PER") + " " + item.get("eRentItemDuration")
            cell.kmLblHight.constant = 18
        }else{
            cell.kmLblHight.constant = 0
            cell.kmLbl.text = ""
        }
        cell.contentView.backgroundColor = SColors.ThemeTxt
        if item.get("eIsUserAddressDisplay") == "Yes" {
            cell.adressLbl.text = item.get("vLocation")
            cell.addressImgView.isHidden = false
        }else{
            cell.adressLbl.text = ""
            cell.addressImgView.isHidden = true
        }
        if item.get("eListingType") != "" {
            cell.buySellView.backgroundColor = UIColor.init(hexString: item.get("typeBGColor"), alpha: 1)
            cell.buySellLbl.text = item.get("eListingType")
            cell.buySellLbl.textColor = SColors.ThemeTxt
            cell.buySellView.isHidden = false
        }else{
            cell.buySellView.isHidden = true
        }
        
        cell.adressLbl.isHidden = false
        if item.get("eFeatured") != "" {
            cell.featuredLbl.isHidden = false
            cell.featuredView.isHidden = false
            cell.featuredLbl.text = item.get("eFeatured").uppercased()
        }else{
            cell.featuredLbl.isHidden = true
            cell.featuredView.isHidden = true
        }
        cell.featuredView.backgroundColor = UIColor(hex: 0xEF9007)
        cell.featuredLbl.textColor = SColors.ThemeTxt
        
        if(Configurations.isRTLMode()){
            cell.adressLbl.textAlignment = .right
            Utils.delayWithSeconds(0.1) {
                cell.featuredView.round(corners: [.bottomLeft,.topLeft], cornerRadius: 4)
            }
        }else{
            cell.adressLbl.textAlignment = .left
            Utils.delayWithSeconds(0.1) {
                cell.featuredView.round(corners: [.bottomRight,.topRight], cornerRadius: 4)
               
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if isBuySell == "Yes" {
            return CGSize(width: (Application.screenSize.width / 2) - 10, height: 215)
        }
        
        return CGSize(width: (Application.screenSize.width / 2) - 10, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.dataArray[indexPath.row]
        let rentDetailView = GeneralFunctions.instantiateViewController(pageName: "RentItemDetailsUV") as! RentItemDetailsUV
        rentDetailView.data = item
        rentDetailView.eType = eType
        if item.get("iUserId") == GeneralFunctions.getMemberd(){
            rentDetailView.isBottomViewHide = true
        }else{
            rentDetailView.isBottomViewHide = false
        }
       
        rentDetailView.rentItemHomeuv = uv as? RentItemHomeUV
        self.uv.push(uv: rentDetailView)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString{
            DispatchQueue.main.async {
                self.whoDetailView.activityIndicator.startAnimating()
            }
           
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.whoDetailView.activityIndicator.stopAnimating()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(Application.screenSize.width - 80 + 0)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
