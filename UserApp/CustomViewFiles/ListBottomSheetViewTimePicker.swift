

import Foundation

import UIKit
import SysBaseLib

class ListBottomSheetViewTimePicker: UIView {


    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var dayDateLbl: MyLabel!
    @IBOutlet weak var timeLbl: MyLabel!

    @IBOutlet weak var viewMinuts: UIView!
    @IBOutlet weak var viewHour: UIView!
    @IBOutlet weak var viewAmPm: UIView!

    @IBOutlet weak var hourLbl: MyLabel!
    @IBOutlet weak var minutsLbl: MyLabel!
    @IBOutlet weak var amPmLbl: MyLabel!

    @IBOutlet weak var buttonPositive: MyButton!
    @IBOutlet weak var buttonNegative: MyButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var view: UIView!
    
    @IBOutlet weak var bgView: UIView!
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
        view.frame = bounds
        Utils.delayWithSeconds(1) {
            self.mainView.roundTo(corners: [.topRight, .topLeft], radius: 20)
        }
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ListBottomSheetViewTimePicker", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
