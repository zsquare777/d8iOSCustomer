//
//  SessionUpdatingView.swift
//  UserApp
//
//  Created by Apple on 24/08/22.
//

import Foundation
import UIKit
import Lottie

class SessionUpdatingView: UIView {


    @IBOutlet weak var msgLbl: MyLabel!
    @IBOutlet weak var animationView: AnimationView!

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
    
    deinit {
        self.animationView.stop()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        //        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.loopMode = .loop
        self.animationView.play()
        self.msgLbl.text = self.generalFunc.getLanguageLabel(origValue: "Upating Your Session...", key: "LBL_UPDATE_SESSION")
     
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SessionUpdatingView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
}
