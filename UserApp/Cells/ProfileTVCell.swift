

import UIKit

class ProfileTVCell: UITableViewCell {

    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var rideDelWhereToLbl: MyLabel!
    @IBOutlet weak var saparaterLine: UIView!
    @IBOutlet weak var nextArrowContainerView: UIView!
    @IBOutlet weak var nextArrowImgView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var rightArrowImageWidth: NSLayoutConstraint!
    @IBOutlet weak var rightArrowImageHight: NSLayoutConstraint!
    @IBOutlet weak var titleLblTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewSmartLogin: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
