

import UIKit

class NearByListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var restImgView: UIImageView!
    @IBOutlet weak var headerLbl: MyLabel!
    @IBOutlet weak var subHeaderLbl: MyLabel!
    @IBOutlet weak var timeInfoLbl: MyLabel!
    @IBOutlet weak var timeImgView: UIImageView!
    @IBOutlet weak var closedLbl: MyLabel!
   
    
   
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
