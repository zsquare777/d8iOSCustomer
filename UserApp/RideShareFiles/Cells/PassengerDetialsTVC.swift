//
//  PassengerDetialsTVC.swift
//  UserApp
//
//  Created by # Admin on 13/12/22.
//

import UIKit

class PassengerDetialsTVC: UITableViewCell {

    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var btnDecline: MyButton!
    @IBOutlet weak var btnAceept: MyButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var userAddressLbl: MyLabel!
    @IBOutlet weak var userImageView: UIImageView!
    
   
    @IBOutlet weak var fareIconImgeView: UIImageView!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var seatLbl: MyLabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var callImageView: UIImageView!
    @IBOutlet weak var bottomViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var btnViewTop: NSLayoutConstraint!
    @IBOutlet weak var paymentLbl: MyLabel!
    
    
    @IBOutlet weak var paymentTypeLbl: MyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
