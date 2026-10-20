

import UIKit

class BiddingDriverListTVC: UITableViewCell {

    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var driverNameLbl: MyLabel!
    @IBOutlet weak var amountByMeLbl: MyLabel!
    @IBOutlet weak var amountByDriverLbl: MyLabel!
    
    @IBOutlet weak var btnAccpet: MyButton!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var btndecline: MyButton!
    @IBOutlet weak var btnReoffer: MyButton!
    @IBOutlet weak var waitingLbl: MyLabel!
    @IBOutlet weak var amountByMeHight: NSLayoutConstraint!
    @IBOutlet weak var amountByDriverHight: NSLayoutConstraint!
    @IBOutlet weak var stackViewHight: NSLayoutConstraint!
    @IBOutlet weak var btnReOfferHight: NSLayoutConstraint!
    
    @IBOutlet weak var waitingLblHight: NSLayoutConstraint!
    @IBOutlet weak var waitingToplbl: NSLayoutConstraint!
    
    @IBOutlet weak var imageChat: UIImageView!
   
    @IBOutlet weak var userDisLbl: MyLabel!
    
    
    @IBOutlet weak var driverDisLbl: MyLabel!
    
    @IBOutlet weak var userReadMoreLbl: MyLabel!
    @IBOutlet weak var driverReadMoreLbl: MyLabel!
    
    @IBOutlet weak var ratingViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var driverReadMoreLblHight: NSLayoutConstraint!
    @IBOutlet weak var userReadMoreLblHight: NSLayoutConstraint!
    
    
    @IBOutlet weak var driverDesTop: NSLayoutConstraint!
    
    @IBOutlet weak var userDesTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
