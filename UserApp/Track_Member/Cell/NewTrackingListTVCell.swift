

import UIKit

class NewTrackingListTVCell: UITableViewCell {
    
   
    
    @IBOutlet weak var liveTrackLbl: MyLabel!
    @IBOutlet weak var trackingStatusVLbl: MyLabel!
    @IBOutlet weak var trackingStatusHLbl: MyLabel!
    @IBOutlet weak var phoneNumberLbl: MyLabel!
    @IBOutlet weak var deleteImgView: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var nameLbl: MyLabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var callImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
