

import UIKit

class TransactionHistoryListTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var indicatorImgView: UIImageView!
    @IBOutlet weak var moneyLbl: MyLabel!
    @IBOutlet weak var descriptionLbl: MyLabel!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var highLightView: UIView!
    @IBOutlet weak var sepratorLbl: UILabel!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containerViewBottom: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
