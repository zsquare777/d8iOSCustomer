

import Foundation

class Table22BannerTVCell: UITableViewCell {
    
  
    @IBOutlet weak var bannerTopView: UIView!
    @IBOutlet weak var bannerTitleLbl: MyLabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var banenrImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
