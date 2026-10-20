

import UIKit

class RestaurantsListCVCell: UICollectionViewCell {

 
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var restImgView: UIImageView!
    @IBOutlet weak var headerLbl: MyLabel!
    @IBOutlet weak var subHeaderLbl: MyLabel!
   
    
    @IBOutlet weak var offerViewheight: NSLayoutConstraint!
   
    @IBOutlet weak var timeInfoLbl: MyLabel!
    @IBOutlet weak var pricePerPersonLbl: MyLabel!
    
    @IBOutlet weak var offerImgView: UIImageView!
   
    @IBOutlet weak var timeInfoLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var ratingSeprViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var ratingSeprView: UIView!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLbl: MyLabel!
    @IBOutlet weak var ratingImgView: UIImageView!
    
    @IBOutlet weak var closedLbl: MyLabel!
    @IBOutlet weak var discountLbl: MyLabel!
    @IBOutlet weak var favIconImgView: UIImageView!
    
    @IBOutlet weak var discountView: UIView!
   

    @IBOutlet weak var priceHImgView: UIImageView!
    
    @IBOutlet weak var whoImgView: UIImageView!


    @IBOutlet weak var pricePerPersonView: UIView!
    
  
    
}
