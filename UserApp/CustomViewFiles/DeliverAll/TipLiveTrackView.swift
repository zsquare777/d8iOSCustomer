

import UIKit

class TipLiveTrackView: UIView {

    @IBOutlet weak var tipSubView: UIView!
    @IBOutlet weak var tipSubViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tipAmoVIew1: UIView!
    @IBOutlet weak var tipAmoView2: UIView!
    @IBOutlet weak var tipAmoView3: UIView!
    @IBOutlet weak var tipAmoLbl1: MyLabel!
    @IBOutlet weak var tipAmoLbl2: MyLabel!
    @IBOutlet weak var tipAmoLbl3: MyLabel!
    @IBOutlet weak var tipAmoOtherView: UIView!
    @IBOutlet weak var tipAmoOtherLbl: MyLabel!
    @IBOutlet weak var tipAmoOtherValueView: UIView!
    @IBOutlet weak var tipAmoTxtFiled: UITextField!
    @IBOutlet weak var tipAmoOtherConfImgView: UIImageView!
    @IBOutlet weak var tipAmoImgView1: UIImageView!
    @IBOutlet weak var tipAmoImgView2: UIImageView!
    @IBOutlet weak var tipAmoImgView3: UIImageView!
    @IBOutlet weak var tipAmoOtherImgView: UIImageView!
    @IBOutlet weak var submiBtn: MyButton!
    @IBOutlet weak var closeLbl: MyLabel!
    @IBOutlet weak var tipHLbl: MyLabel!
    @IBOutlet weak var tipHintImgView: UIImageView!
    @IBOutlet weak var topHBGView: UIView!
    @IBOutlet weak var tipRequiredLbl: MyLabel!
    @IBOutlet weak var tipAmountLbl: MyLabel!
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
       
        self.topHBGView.backgroundColor = SColors.Theme
        
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TipLiveTrackView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
