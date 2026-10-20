

import Foundation

class Table22HeaderTVCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLblLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var anchorViewWidth: NSLayoutConstraint!
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var anchorSubView: UIView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var lblTitley: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
