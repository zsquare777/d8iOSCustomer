

import UIKit

class EmergencyContactsTVCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contactNameLbl: MyLabel!
    @IBOutlet weak var myNumLbl: MyLabel!
    @IBOutlet weak var removeImgView: UIImageView!
    @IBOutlet weak var imgRightShape: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
