

import UIKit
import SysBaseLib

class DeliveryPreferencesTVcell: UITableViewCell {
    
    @IBOutlet weak var deliveryPreferenceNameLbl: MyLabel!
    @IBOutlet weak var deliveryPreferenceDescriptionLbl: MyLabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var mainTap: UIButton!
    @IBOutlet weak var checkBoxWidth: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkBox.boxType = .square
        checkBox.boxType = .square
        checkBox.offAnimationType = .bounce
        checkBox.onAnimationType = .bounce
        checkBox.onCheckColor = SColors.ThemeTxt
        checkBox.onFillColor = SColors.Theme
        checkBox.onTintColor = SColors.Theme
        checkBox.tintColor = SColors.Theme_1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
