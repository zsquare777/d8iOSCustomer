//
//  UfxProRecentLocationTVCell.swift
//  
//
//  Created by # Admin on 22/03/23.
//

import UIKit

class UfxProRecentLocationTVCell: UITableViewCell {

    @IBOutlet weak var cloclImgView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var whereTOLbl: MyLabel!
    @IBOutlet weak var whereToView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var nowLbl: MyLabel!
    @IBOutlet weak var clockImgView: UIImageView!
    @IBOutlet weak var arrowImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
