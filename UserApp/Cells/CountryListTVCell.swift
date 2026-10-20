

import UIKit

class CountryListTVCell: UITableViewCell {

    @IBOutlet weak var countryImgView: UIImageView!
    @IBOutlet weak var countryCodeLbl: MyLabel!
    @IBOutlet weak var countryLabelTxt: MyLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
