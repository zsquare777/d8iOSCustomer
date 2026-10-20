
import UIKit

class RestaurantDetailItemTVCell: UITableViewCell {

    
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var foodTypeImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var foodTypeImgView: UIImageView!
    
    @IBOutlet weak var titleLblTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: MarqueeLabel!
    @IBOutlet weak var discriptionLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var strkeOutLbl: MyLabel!
    @IBOutlet weak var priceLblLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var cartImgView: UIImageView!
    @IBOutlet weak var foodItemTypeTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bannerImgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bannerImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bannerImgViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bannerImgViewTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var storeNameLbl: MarqueeLabel!
  
    @IBOutlet weak var addBtnLbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
