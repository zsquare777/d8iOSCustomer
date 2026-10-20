
import UIKit

class MenuListTVCell: UITableViewCell {

    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuTxtLbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
