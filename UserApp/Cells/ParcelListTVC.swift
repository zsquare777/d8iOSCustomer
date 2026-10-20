
import UIKit

class ParcelListTVC: UITableViewCell {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var catImgView: UIImageView!
    @IBOutlet weak var catTitleLbl: MyLabel!
    @IBOutlet weak var catDecLbl: MyLabel!
    @IBOutlet weak var imgParentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
