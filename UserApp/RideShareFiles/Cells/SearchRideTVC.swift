//
//  MyRideTVC.swift
//  UserApp
//
//  Created by # Admin on 05/12/22.
//

import UIKit

class SearchRideTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startCityLbl: MyLabel!
    @IBOutlet weak var endCityLbl: MyLabel!
    @IBOutlet weak var startCityView: UIView!
    @IBOutlet weak var endCityView: UIView!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var dateTimeLbl: MyLabel!
    @IBOutlet weak var startTime: MyLabel!
    @IBOutlet weak var endTime: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var bookingNoLbl: MyLabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var userNameLbl: MyLabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var startAddLbl: MyLabel!
    @IBOutlet weak var endAddLbl: MyLabel!
    @IBOutlet weak var perPassengerLbl: MyLabel!
    
    
    @IBOutlet weak var statusLbl: MyLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
