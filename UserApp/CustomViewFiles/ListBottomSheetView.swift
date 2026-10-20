
import Foundation

import UIKit
import SysBaseLib

class ListBottomSheetView: UIView {

  
    @IBOutlet weak var tableViewtopSpace: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var tableViewTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLblTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var popupListCloseImgView: UIImageView!
    @IBOutlet weak var mainViewBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var mainViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var mainViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var mainViewTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var tableSapraterView: UIView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeImgView: UIImageView!
    
    @IBOutlet weak var subTitleLblHight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    var view: UIView!
    
    let generalFunc = GeneralFunctions()
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        //        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        self.closeImgView.image = self.closeImgView.image?.addImagePadding(x: 15, y: 15)
        
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ListBottomSheetView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
