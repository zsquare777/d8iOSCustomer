
import UIKit

class FlyAddressTVCell: UITableViewCell {

    @IBOutlet weak var addHLbl: MyLabel!
    @IBOutlet weak var sAddLbl: MyLabel!
    @IBOutlet weak var distanceLbl: MyLabel!
    @IBOutlet weak var awayLbl: MyLabel!
    @IBOutlet weak var selectedImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
