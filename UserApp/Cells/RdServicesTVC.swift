//
//  RdServicesTVC.swift
//  
//
//  Created by # Admin on 04/04/23.
//

import UIKit

class RdServicesTVC: UITableViewCell {

    
    
    var uFXProBannerView:UFXProBannerView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var titleLbl1: MyLabel!
    @IBOutlet weak var titileLbl2: MyLabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var image1Hight: NSLayoutConstraint!
    @IBOutlet weak var image1Width: NSLayoutConstraint!
    @IBOutlet weak var image2Hight: NSLayoutConstraint!
    @IBOutlet weak var image2Width: NSLayoutConstraint!
    @IBOutlet weak var titleLblTop: NSLayoutConstraint!
    @IBOutlet weak var titleLbl2Top: NSLayoutConstraint!
    @IBOutlet weak var titileTraing: NSLayoutConstraint!
    @IBOutlet weak var title2Trailng: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
