

import UIKit

class ListOrganizationTVC: UITableViewCell {

    @IBOutlet weak var orgNameLbl: MyLabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
