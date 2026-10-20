

import UIKit
import SysBaseLib

class GenieCartItemTVCell: UITableViewCell {

    @IBOutlet weak var addItemView: UIView!
    @IBOutlet weak var addItemLbl: MyLabel!
    @IBOutlet weak var addItemArrowImgView: UIImageView!
    @IBOutlet weak var editItemView: UIView!
    @IBOutlet weak var minusItemView: UIView!
    @IBOutlet weak var minusItemImgView: UIImageView!
    @IBOutlet weak var plusItemImgView: UIImageView!
    @IBOutlet weak var plusItemView: UIView!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var itemNameTxtFiled: UITextField!
    @IBOutlet weak var itemRightShapeImgView: UIImageView!
    @IBOutlet weak var editItemDeleteImgView: UIImageView!
    @IBOutlet weak var editItemDeleteImgViewBG: UIView!
    @IBOutlet weak var extraPaymentChkBox: BEMCheckBox!
    @IBOutlet weak var extraPaymentView: UIView!
    @IBOutlet weak var extraPaymentLbl: MyLabel!
    @IBOutlet weak var extraPaySeparaterView: UIView!
    @IBOutlet weak var extraPaymentSLbl: MyLabel!
    @IBOutlet weak var extraPaymentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var groupBGView: UIView!
    @IBOutlet weak var cellSerialNumLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
