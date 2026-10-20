

import UIKit

class DonationTVCell: UITableViewCell {

    @IBOutlet weak var bottomBorderView: UIView!
    @IBOutlet weak var donateImgView: UIImageView!
    @IBOutlet weak var donateHLbl: MyLabel!
    @IBOutlet weak var donateSHLbl: MyLabel!
    @IBOutlet weak var startLbl: MyLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
