//
//  PaymentStepTVC.swift
//  UserApp
//
//  Created by # Admin on 16/02/23.
//

import UIKit

class PaymentStepTVC: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var descriptionLbl: MyLabel!
    @IBOutlet weak var chcekMarkImgView: UIImageView!
   
    @IBOutlet weak var hintLbl2: MyLabel!
    @IBOutlet weak var hintLbl: MyLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
