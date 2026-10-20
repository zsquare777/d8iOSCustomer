//
//  RentItemOwnerItemTVC.swift
//  UserApp
//
//  Created by # Admin on 31/10/22.
//

import UIKit

class RentItemOwnerItemTVC: UITableViewCell {

    
    @IBOutlet weak var contanierView: UIView!
    
    @IBOutlet weak var itemImageHight: NSLayoutConstraint!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var favIconImage: UIImageView!
    @IBOutlet weak var detialsView: UIView!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var nameLbl: MyLabel!
    @IBOutlet weak var kmLbl: MyLabel!
    @IBOutlet weak var adressLbl: MyLabel!
    @IBOutlet weak var cotactBgView: UIView!
    @IBOutlet weak var secureUserImageView: UIImageView!
    @IBOutlet weak var featuredLbl: MyLabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
