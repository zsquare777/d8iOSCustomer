

import UIKit
import SysBaseLib

class AgeVerificationView: UIView {

    var view: UIView!
    @IBOutlet weak var cancelImgView: UIImageView!
    @IBOutlet weak var hLbl: MyLabel!
    @IBOutlet weak var selctionChkBox: BEMCheckBox!
    @IBOutlet weak var sHLbl: MyLabel!
    @IBOutlet weak var confirmBtn: MyButton!
    @IBOutlet weak var newCancelView: UIView!
    @IBOutlet weak var imgView: UIImageView!
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
        
        setStyleOf(self.selctionChkBox)
    }
    
    func setStyleOf(_ checkBox: BEMCheckBox) {
        checkBox.boxType = .square
        checkBox.offAnimationType = .bounce
        checkBox.onAnimationType = .bounce
        checkBox.onCheckColor = SColors.ThemeTxt
        checkBox.onFillColor = SColors.Theme
        checkBox.onTintColor = SColors.Theme
        checkBox.tintColor = SColors.Theme
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AgeVerificationView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
