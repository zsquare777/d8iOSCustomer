

import UIKit

class NotificationTVCell: UITableViewCell {

    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var readMoreLbl: MyLabel!
    @IBOutlet weak var containerView: UIView!
  //  @IBOutlet weak var titleLblHeight: NSLayoutConstraint!
    @IBOutlet weak var descTopSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
