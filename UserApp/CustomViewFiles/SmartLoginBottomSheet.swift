

import Foundation

import UIKit
import SysBaseLib
import Lottie
class SmartLoginBottomSheet: UIView {

  
    
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var btnOk: MyButton!
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
        
        //self.closeImgView.image = self.closeImgView.image?.addImagePadding(x: 15, y: 15)
        
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SmartLoginBottomSheet", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
