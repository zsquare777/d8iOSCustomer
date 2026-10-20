
import UIKit

class LiveTrackStatusTVCell: UITableViewCell {

    @IBOutlet weak var genieMakePaymentView: UIView!
    @IBOutlet weak var genieMakePaymenyBtn: MyButton!
    @IBOutlet weak var makePaymentFareLbl: MyLabel!
    @IBOutlet weak var makePaymentBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var genieMakePaymentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reviewGenieItemViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genieItemDetailsLbl: MyLabel!
    @IBOutlet weak var genieItemReviewBtn: MyButton!
    @IBOutlet weak var genieItemImgView: UIImageView!
    @IBOutlet weak var reviewGenieItemView: UIView!
    @IBOutlet weak var statusImgParentView: UIView!
    @IBOutlet weak var timeLbl: MyLabel!
    @IBOutlet weak var statusDownJointView: UIView!
    @IBOutlet weak var statusUpperJointView: UIView!
    @IBOutlet weak var statusLblTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var statusImgView: UIImageView!
    @IBOutlet weak var statusLbl: MyLabel!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var callImgView: UIImageView!
    @IBOutlet weak var statusHLbl: MyLabel!
    @IBOutlet weak var callViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var timeView: UIView!
    
    @IBOutlet weak var highLiteView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
