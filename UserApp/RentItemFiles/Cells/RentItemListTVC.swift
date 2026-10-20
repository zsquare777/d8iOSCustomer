//
//  RentItemListTVC.swift
//  
//
//  Created by # Admin on 22/10/22.
//

import UIKit

class RentItemListTVC: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgSlider: iCarousel!
    @IBOutlet weak var imgSliderHight: NSLayoutConstraint!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var itemNameLbl: MyLabel!
    @IBOutlet weak var itemStatusLbl: MyLabel!
    @IBOutlet weak var btnDelete: MyButton!
    @IBOutlet weak var bntRejectReason: MyButton!
    @IBOutlet weak var imageHintView: UIImageView!
    @IBOutlet weak var lblOriStatus: MyLabel!
    @IBOutlet weak var btnEdit: MyButton!
    @IBOutlet weak var bookingNoLbl: MyLabel!
    @IBOutlet weak var imageViewHight: NSLayoutConstraint!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var btnRejectReasonHight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
