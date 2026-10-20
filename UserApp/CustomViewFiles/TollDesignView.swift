
import UIKit
import SysBaseLib

class TollDesignView: UIView {

    @IBOutlet weak var tollHImgView: UIImageView!
    @IBOutlet weak var tollViewHLbl: MyLabel!
    @IBOutlet weak var tollDescriptionLbl: MyLabel!
    @IBOutlet weak var ignoreTollRouteLbl: MyLabel!
    @IBOutlet weak var ignoreTollChkBox: BEMCheckBox!
    @IBOutlet weak var continueBtn: MyButton!
    @IBOutlet weak var cancelLbl: MyLabel!
    @IBOutlet weak var priceLbl: MyLabel!
    
    
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
        
        tollViewHLbl.text = self.generalFunc.getLanguageLabel(origValue: "Toll Route", key: "LBL_TOLL_ROUTE")
        tollViewHLbl.fit()
        
        continueBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CONTINUE_BTN"))
        cancelLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_CANCEL_TXT")
        cancelLbl.borderColor = SColors.Theme
        cancelLbl.textColor = SColors.Theme
        GeneralFunctions.setImgTintColor(imgView: tollHImgView, color: SColors.Theme)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TollDesignView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
