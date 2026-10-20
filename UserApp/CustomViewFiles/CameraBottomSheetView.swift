
import Foundation

import UIKit
import SysBaseLib

class CameraBottomSheetView: UIView {

  
    
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var closeImgView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var lblVideo: MyLabel!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var lblCamera: MyLabel!
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
        
       // self.closeImgView.image = self.closeImgView.image?.addImagePadding(x: 0, y: 15)
        self.closeImgView.image = self.closeImgView.image?.addImagePadding(x:30 , y: 30)
        GeneralFunctions.setImgTintColor(imgView: self.closeImgView, color: SColors.ThemeTxt)
        self.closeImgView.backgroundColor = SColors.Theme
        self.closeImgView.cornerRadius = 12.5
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CameraBottomSheetView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
