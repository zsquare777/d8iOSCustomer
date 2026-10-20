

import Foundation
class Table22ButtonTVCell: UITableViewCell {
    
    
    @IBOutlet weak var buttonLbl: MyLabel!
    @IBOutlet weak var buttonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
