

import UIKit

class UFXProviderServicesTVCell: UITableViewCell {

    @IBOutlet weak var serviceTitle: MyLabel!
    @IBOutlet weak var servicePriceLbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLbl: MyLabel!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var discriptionLbl: MyLabel!
    @IBOutlet weak var bookBtnView: UIView!
    @IBOutlet weak var bookBtnImgView: UIImageView!
    @IBOutlet weak var bookBtnLbl: MyLabel!
    @IBOutlet weak var highLightView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceTitleTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var desLblTop: NSLayoutConstraint!
    @IBOutlet weak var servicePriceHight: NSLayoutConstraint!
    
    @IBOutlet weak var newContainerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
