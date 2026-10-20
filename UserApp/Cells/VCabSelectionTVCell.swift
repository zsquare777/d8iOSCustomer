
import UIKit

class VCabSelectionTVCell: UITableViewCell {
   
    @IBOutlet weak var fareLblWidth: NSLayoutConstraint!
    @IBOutlet weak var helperImgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var helperImgView: UIImageView!
    @IBOutlet weak var bgThemeView: UIView!
    @IBOutlet weak var cabTypeImgView: UIImageView!
    @IBOutlet weak var cabTypeHoverImgView: UIImageView!
    @IBOutlet weak var cabTypeNameLbl: MyLabel!
    @IBOutlet weak var fareEstLbl: MyLabel!
    @IBOutlet weak var descriptionLbl: MyLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
