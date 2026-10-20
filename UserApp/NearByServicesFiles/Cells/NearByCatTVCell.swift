

import UIKit

class NearByCatTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionLbl: MyLabel!
    @IBOutlet weak var sepratorLbl: UILabel!
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var arrowView: UIView!
   
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var imgCategory: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
