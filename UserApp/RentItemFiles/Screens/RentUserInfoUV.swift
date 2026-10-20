//
//  RentUserInfoUV.swift
//  UserApp
//
//  Created by # Admin on 28/10/22.
//

import UIKit
import PullUpController
class RentUserInfoUV: PullUpController {

    
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var msgSubView: UIView!
    private var originalPullUpControllerViewSize: CGSize = .zero
    public var safeAreaAdditionalOffset: CGFloat {
        hasSafeArea ? 20 : 0
    }
    
    enum InitialState {
        case contracted
        case expanded
    }
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero
    var initialState: InitialState = .contracted
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    var initialPointOffset: CGFloat {
        switch initialState {
        case .contracted:
            return 40 + safeAreaAdditionalOffset
        case .expanded:
            
            return 100
        }
    }
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        
        switch initialState {
        case .contracted:
            return [150.00]
        case .expanded:
            
                return [150, Application.screenSize.size.height - 100]
               
            
               
            }
            
        }
    }

    
    
    
    
    
    

    


