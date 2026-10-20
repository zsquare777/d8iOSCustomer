//
//  RentItemListTVC.swift
//  UserApp
//
//  Created by # Admin on 30/12/22.
//

import UIKit

class RentItemListTVC2: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: MyLabel!
    @IBOutlet weak var itemStatusLbl: MyLabel!
    @IBOutlet weak var btnDelete: MyButton!
    @IBOutlet weak var bntRejectReason: MyButton!
    @IBOutlet weak var imageHintView: UIImageView!
    @IBOutlet weak var lblOriStatus: MyLabel!
    @IBOutlet weak var btnEdit: MyButton!
    @IBOutlet weak var bookingNoLbl: MyLabel!
    
    
    @IBOutlet weak var btnRejectListHight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
