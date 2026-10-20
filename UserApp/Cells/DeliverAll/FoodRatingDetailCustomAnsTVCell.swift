
import Foundation


class FoodRatingDetailCustomAnsTVCell: UITableViewCell{
    
    
    @IBOutlet weak var storeratingView: UIView!
    @IBOutlet weak var companyRatingDetailTxtField: MyTextField!
    @IBOutlet weak var companyRatingView: RatingView!
    @IBOutlet weak var companyNameLbl: MyLabel!
    @IBOutlet weak var topSapView: UIView!
    @IBOutlet weak var subTxtLbl: MyLabel!
    @IBOutlet weak var tellUsTxtFiled: MyTextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
