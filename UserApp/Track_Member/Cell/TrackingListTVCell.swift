

import UIKit

class TrackingListTVCell: UITableViewCell {
    
   
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var liveTrackInfoLbl: MyLabel!
    @IBOutlet weak var vehicleInfoLbl: MyLabel!
    @IBOutlet weak var profileLbl: MyLabel!
    @IBOutlet weak var nameLbl: MyLabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var tripStatusLbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
