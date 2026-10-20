

import UIKit
import SysBaseLib

class RestaurantsFilterTVCell: UITableViewCell {

    @IBOutlet weak var filetrCheckBox: BEMCheckBox!
    
    @IBOutlet weak var titleLbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
