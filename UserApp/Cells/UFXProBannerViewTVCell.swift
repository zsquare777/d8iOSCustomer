

import Foundation


class UFXProBannerViewTVCell: UITableViewCell {
    
  
    @IBOutlet weak var onlyBannerImgView2: UIImageView!
    @IBOutlet weak var onlyBannerImgView1: UIImageView!
    @IBOutlet weak var promoLbl2: MyLabel!
    @IBOutlet weak var promoLbl1: MyLabel!
    @IBOutlet weak var bannerTxtTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bannerTxtBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var fullBannerTopSpace: NSLayoutConstraint!
    @IBOutlet weak var fullBannerBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var bannerStackTopSpace: NSLayoutConstraint!
    @IBOutlet weak var bannerStackBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var fullBannerLeading: NSLayoutConstraint!
    @IBOutlet weak var fullBannerTrailing: NSLayoutConstraint!
    @IBOutlet weak var fullBannerImgView: UIImageView!
    @IBOutlet weak var titleBannerStackView: UIStackView!
    @IBOutlet weak var titleBannerView1: UIView!
    @IBOutlet weak var titleBannerImgView1: UIImageView!
    @IBOutlet weak var titleBannerView2: UIView!
    @IBOutlet weak var titleBannerLbl1: MyLabel!
    @IBOutlet weak var titleBnnerLbl2: MyLabel!
    @IBOutlet weak var titleBannerImgView2: UIImageView!
    @IBOutlet weak var fullBanner1CenterImgView: UIImageView!
    
    @IBOutlet weak var bannerTxtImgView: UIImageView!
    @IBOutlet weak var bannerTxtBookNowLbl: MyLabel!
    @IBOutlet weak var bannerTxtSubTitleLbl: MyLabel!
    @IBOutlet weak var bannerTxtTitleLbl: MyLabel!
    @IBOutlet weak var bannerTxtView: UIView!
    
    @IBOutlet weak var titleBannerLbl1TopSpace: NSLayoutConstraint!
    @IBOutlet weak var titleBannerLbl1TrailingSpace: NSLayoutConstraint!
    var uFXProBannerView:UFXProBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
   
}
