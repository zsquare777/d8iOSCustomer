

import UIKit

class FAQCategoryListTVCell: UITableViewCell {

    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var rightArrowImgView: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var viewTopContent: NSLayoutConstraint!
    @IBOutlet weak var viewBottomContent: NSLayoutConstraint!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewBgBottom: NSLayoutConstraint!
    @IBOutlet weak var viewBgTop: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
