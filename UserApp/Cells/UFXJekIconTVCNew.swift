

import UIKit

class UFXJekIconTVCNew: UITableViewCell {

    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var bookNowLbl: MyLabel!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomCornerView: UIView!
    @IBOutlet weak var bottomCornerImgView: UIImageView!
    @IBOutlet weak var categoryLbl: MyLabel!
    @IBOutlet weak var CategoryDesLbl: MyLabel!
    @IBOutlet weak var catrgoryViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTraling: NSLayoutConstraint!
    
    @IBOutlet weak var categoryLblY: NSLayoutConstraint!
    
    @IBOutlet weak var categoryViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var cateGoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
