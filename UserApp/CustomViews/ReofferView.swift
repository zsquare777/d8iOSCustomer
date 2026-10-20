

import Foundation

import UIKit
import SysBaseLib

class ReofferView: UIView {


    
    var view: UIView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var topheaderView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var reofferLbl: MyLabel!
    @IBOutlet weak var commentTxtView: KMPlaceholderTextView!
    @IBOutlet weak var amtTxtField: MyTextField!
    @IBOutlet weak var btnCancel: MyButton!
    @IBOutlet weak var btnOk: MyButton!
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
        
       // self.closeImgView.image = self.closeImgView.image?.addImagePadding(x: 15, y: 15)
        
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReofferViewDesign", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
