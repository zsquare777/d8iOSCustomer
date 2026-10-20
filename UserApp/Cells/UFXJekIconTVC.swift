

import UIKit

class UFXJekIconTVC: UITableViewCell {

    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryLbl: MyLabel!
    @IBOutlet weak var bookNowLbl: MyLabel!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomCornerView: UIView!
    @IBOutlet weak var bottomCornerImgView: UIImageView!
    @IBOutlet weak var imgBGView: UIView!
    
    @IBOutlet weak var categoryLblLeading: NSLayoutConstraint!
    
    @IBOutlet weak var newView22: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
