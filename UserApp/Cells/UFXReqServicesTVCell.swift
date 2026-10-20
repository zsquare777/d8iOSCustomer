

import UIKit

class UFXReqServicesTVCell: UITableViewCell {

    @IBOutlet weak var serviceTypeLbl: MyLabel!
    @IBOutlet weak var serviceTypeDesLbl: MyLabel!
    @IBOutlet weak var serviceCountLbl: MyLabel!
    @IBOutlet weak var serivceDesHbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
