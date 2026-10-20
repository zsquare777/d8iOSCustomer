

import UIKit
import SysBaseLib

class ListTVCell: UITableViewCell {

    @IBOutlet weak var cellSapraterView: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var listLabelTxt: MyLabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var checkBoxWidth: NSLayoutConstraint!
    @IBOutlet weak var listViewOldBG: UIView!
    @IBOutlet weak var checkBoxLeading: NSLayoutConstraint!
    
    @IBOutlet weak var socialSigninTitleLbl: MyLabel!
    @IBOutlet weak var socialSigninImgView: UIImageView!
    @IBOutlet weak var socialSignInView: UIView!
    
    @IBOutlet weak var socialRightArrowicon: UIImageView!
    @IBOutlet weak var newListView: UIView!
    @IBOutlet weak var nListViewLeadingLbl: MyLabel!
    @IBOutlet weak var nListViewTitleLbl: MyLabel!
    @IBOutlet weak var nListViewCheckImg: UIImageView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var imgViewY: NSLayoutConstraint!
    @IBOutlet weak var titlelblY: NSLayoutConstraint!
    @IBOutlet weak var disableQuickLoginLbl: MyLabel!
    @IBOutlet weak var nListViewLeadingLblWidth: NSLayoutConstraint!
    @IBOutlet weak var nListLeadingLblHight: NSLayoutConstraint!
    @IBOutlet weak var nListCheckVIewWidth: NSLayoutConstraint!
    @IBOutlet weak var nListCheckViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var sepratorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
