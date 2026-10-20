

import UIKit

class GenieTVCell: UITableViewCell {

    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var nextBtn: MyButton!
    @IBOutlet weak var sTitleLbl: MyLabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
