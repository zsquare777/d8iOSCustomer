

import UIKit

class FoodItemMenuTVCell: UITableViewCell {

    @IBOutlet weak var selectedCellView: UIView!
    @IBOutlet weak var sapareterLine: UIView!
    @IBOutlet weak var headerSubtitleLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
