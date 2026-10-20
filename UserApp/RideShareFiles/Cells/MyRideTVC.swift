//
//  MyRideTVC.swift
//  UserApp
//
//  Created by # Admin on 05/12/22.
//

import UIKit

class MyRideTVC: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var startCityLbl: MyLabel!
    @IBOutlet weak var endCityLbl: MyLabel!
    @IBOutlet weak var startCityView: UIView!
    @IBOutlet weak var endCityView: UIView!
    @IBOutlet weak var dottedView: UIView!
    @IBOutlet weak var dateTimeLbl: MyLabel!
    @IBOutlet weak var bookingLbl: MyLabel!
    @IBOutlet weak var startAddLbl: MyLabel!
    @IBOutlet weak var endAddLbl: MyLabel!
    @IBOutlet weak var startTimeLbl: MyLabel!
    @IBOutlet weak var endTimeLbl: MyLabel!
    @IBOutlet weak var perPassngerLbl: MyLabel!
    
    @IBOutlet weak var priceLbl: MyLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
