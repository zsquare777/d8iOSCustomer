

import UIKit

class CuisinesCVC: UICollectionViewCell {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var iconBGView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var imgViewHight: NSLayoutConstraint!
    @IBOutlet weak var imgViewWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
