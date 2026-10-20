
import UIKit

class UFXHomeListCatTVCell: UITableViewCell {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var catImgView: UIImageView!
    @IBOutlet weak var catTitleLbl: MyLabel!
    @IBOutlet weak var catDecLbl: MyLabel!
    @IBOutlet weak var catDecLblBottomSpace: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
