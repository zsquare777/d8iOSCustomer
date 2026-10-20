

import UIKit

class TripFinishView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: MyLabel!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var positiveBtn: MyLabel!
    @IBOutlet weak var negativeBtn: MyLabel!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var okTipBtn: MyLabel!
    // New trip view Outlet
    
    
    @IBOutlet weak var newTripFinishView: UIView!
    @IBOutlet weak var newRoundView: UIView!
    @IBOutlet weak var newRoundImageView: UIImageView!
    @IBOutlet weak var newTitleLbl: MyLabel!
    @IBOutlet weak var newDiscriptionLbl: MyLabel!
    @IBOutlet weak var btnPositive: MyButton!
    @IBOutlet weak var btnNegative: MyButton!
    
    @IBOutlet var mainView: UIView!
    var view: UIView!
    
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
        
        self.backgroundColor = UIColor.clear
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TripFinishView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
