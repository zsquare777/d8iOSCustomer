

import UIKit

class RestaurantDetailHeaderCVCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var newClockImgView: UIImageView!
    @IBOutlet weak var showVegItemViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showVegItemSwitch: UISwitch!
    @IBOutlet weak var showVegItemLbl: UILabel!
    @IBOutlet weak var showVegItemView: UIView!
    @IBOutlet weak var offerLbl: UILabel!
    @IBOutlet weak var restaurantNameLbl: MyLabel!
    @IBOutlet weak var restaurantNameSHLbl: MyLabel!
    @IBOutlet weak var pricePersonLbl: MyLabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingImgView: UIImageView!
    @IBOutlet weak var ratingLbl: MyLabel!
    @IBOutlet weak var ratingSepraterView: UIView!
    @IBOutlet weak var deliveryTimeView: UIView!
    @IBOutlet weak var ratingSHLbl: MyLabel!
    @IBOutlet weak var deliveryTimeSHLbl: MyLabel!
    @IBOutlet weak var deliveryTimeLbl: MyLabel!
    @IBOutlet weak var pricePersonSHLbl: MyLabel!
    @IBOutlet weak var deliveryTimeSeparaterView: UIView!
    @IBOutlet weak var appthemeBgView: UIView!
    @IBOutlet weak var dataCntView: UIView!
    @IBOutlet weak var offerLblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageSlideShowBGView: UIView!
    @IBOutlet weak var imgSlideShowBGViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgSlideShow: iCarousel!
    @IBOutlet weak var imgSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var whoView: UIView!
    @IBOutlet weak var whoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var whoImgView: UIImageView!
    @IBOutlet weak var whoImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var whoLbl: MarqueeLabel!
    @IBOutlet weak var whoArrowImage: UIImageView!
}
