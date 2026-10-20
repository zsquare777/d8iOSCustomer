

import UIKit
import PullUpController
class LiveTrackPullUpUV: PullUpController {

    
    @IBOutlet weak var viewHeader: UIView!
    
    
    @IBOutlet weak var lblOrderStatus: MyLabel!
    
    @IBOutlet weak var priceLbl: MyLabel!
    @IBOutlet weak var dateLbl: MyLabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblOrderTime: MyLabel!
    @IBOutlet weak var itemNameLbl: MyLabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var contactLessDeliveryLbl: MyLabel!
    @IBOutlet weak var restaurentAdressView: UIView!
    @IBOutlet weak var howsWrokLbl: MyLabel!
    @IBOutlet weak var contactLessDeliveryView: UIView!
    @IBOutlet weak var ContactLessDeliveryViewHight: NSLayoutConstraint!
    @IBOutlet weak var restaurentAdresslLbl: MyLabel!
    @IBOutlet weak var navigateLbl: MyLabel!
    @IBOutlet weak var restAdressViewHight: NSLayoutConstraint!
    @IBOutlet weak var pickUpOrderView: UIView!
    @IBOutlet weak var pickUpTimeLbl: MyLabel!
    
    @IBOutlet weak var restAddresImgView: UIImageView!
    @IBOutlet weak var pickUpTimeLblHight: NSLayoutConstraint!
    
    @IBOutlet weak var providerView: UIView!
    @IBOutlet weak var providerNameLbl: MyLabel!
    @IBOutlet weak var providerRatingLbl: MyLabel!
    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var callImageView: UIImageView!
    @IBOutlet weak var tblHeaderView: UIView!
    @IBOutlet weak var tblPullUp: UITableView!
    @IBOutlet weak var etaMainView: UIView!
    @IBOutlet weak var etaView: UIView!
    @IBOutlet weak var etaTimeLbl: MyLabel!
    
    @IBOutlet weak var etaSLbl: MyLabel!
    
    @IBOutlet weak var etaMainViewHight: NSLayoutConstraint!
    @IBOutlet weak var ViewTopHight: NSLayoutConstraint!
    @IBOutlet weak var orderDelOkTopSpace: NSLayoutConstraint!
    @IBOutlet weak var orderDelSubLbl: MyLabel!
    @IBOutlet weak var orderDelHLbl: MyLabel!
    @IBOutlet weak var orderDeliveredViewHeight: NSLayoutConstraint!
    @IBOutlet weak var orderDeliveredView: UIView!
    @IBOutlet weak var notDelLblHeight: NSLayoutConstraint!
    @IBOutlet weak var delliveredProofImg: UIImageView!
    @IBOutlet weak var delliveredProofImgHeight: NSLayoutConstraint!
    @IBOutlet weak var deliveredView: UIView!
    @IBOutlet weak var notDeliveredView: UIView!
    @IBOutlet weak var orderDelBGView: UIView!
    @IBOutlet weak var enjoyYFoodLbl: MyLabel!
    @IBOutlet weak var orderDelCallDelLbl: MyLabel!
    @IBOutlet weak var orderDelOkLbl: MyLabel!
    @IBOutlet weak var ordernotDelLbl: MyLabel!
    
    @IBOutlet weak var rateView: UIView!
    
    @IBOutlet weak var rateLbl: MyLabel!
    
    @IBOutlet weak var ratingImgView: UIImageView!
    var isFirstLoad = true
    var isOrderDeliverd = false
    var isProviderViewShown = false
    var isPickedorder = false
    var position = "DOWN"
   
    enum InitialState {
        case contracted
        case expanded
    }
    public var portraitSize: CGSize = .zero
    public var landscapeFrame: CGRect = .zero
    public var hightOfHeader = CGFloat()
    public var hightOfHeaderWhenUp = CGFloat()
    public var hightOfHeaderWhenDwon = CGFloat()
    public var hightOfDeliverdView = CGFloat()
    public var safeAreaAdditionalOffset: CGFloat {
        hasSafeArea ? 20 : 0
    }
   
    var initialState: InitialState = .contracted
    
    var dataDict:NSDictionary!
    var initialPointOffset: CGFloat {
        switch initialState {
        case .contracted:
            return 40 + safeAreaAdditionalOffset
        case .expanded:
            if isPickedorder || isOrderDeliverd {
                self.hightOfHeaderWhenUp = self.tblPullUp.parallaxHeader.height - 70
                self.hightOfHeaderWhenDwon = self.tblPullUp.parallaxHeader.height
                if isFirstLoad {
                    self.hightOfHeader = (self.viewHeader.frame.size.height + 70) - 10
                }else{
                    self.hightOfHeader = (self.viewHeader.frame.size.height + 70) + 5
                }
                if isOrderDeliverd {
                    self.etaView.isHidden = true
                }
                if etaView.isHidden == false {
                    if isFirstLoad {
                        self.hightOfHeader = (self.viewHeader.frame.size.height ) + 55 + self.etaView.frame.size.height
                    }else{
                        self.hightOfHeader = (self.viewHeader.frame.size.height ) + 75 + self.etaView.frame.size.height
                    }
                    
                }
                if isOrderDeliverd {
                    
                    self.hightOfHeader += 10
                }
                return  self.hightOfHeader
                
            }else{
                if isFirstLoad {
               
                    self.hightOfHeader = self.viewHeader.frame.size.height + 25
                }else{

                }
            
            return hightOfHeader
        }
    }
    }
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        
        switch initialState {
        case .contracted:
            return [150.00]
        case .expanded:
            if isPickedorder || isOrderDeliverd {
                return [self.hightOfHeader, Application.screenSize.size.height - 100]
               
            }else{
            
            return  [ self.hightOfHeader, Application.screenSize.size.height - 100]
               
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portraitSize = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                              height: Application.screenSize.size.height - 250)
        landscapeFrame = CGRect(x: 5, y: 50, width: 280, height: 600)
        tblPullUp.attach(to: self)

      
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        self.mainView.layer.masksToBounds = true
        self.mainView.roundTo(corners: [.topRight, .topLeft], radius: 20)
        Utils.delayWithSeconds(0.2) {
            self.providerView.roundTo(corners: [.topLeft, .topRight], radius: 15)
        }
        
        self.mainView.layer.addShadow(opacity: 0.9, radius: 2, UIColor.lightGray)
    }
    override func pullUpControllerWillMove(to stickyPoint: CGFloat) {
        tblPullUp.isScrollEnabled  = true
        
        if stickyPoint < 260 {
            let tempHight = self.tblPullUp.parallaxHeader.height
            
            
            tblPullUp.setContentOffset(CGPoint(x: 0, y: -tempHight), animated: true)
            tblPullUp.isScrollEnabled  = false
        }
        
    }
    
    override func pullUpControllerDidMove(to stickyPoint: CGFloat) {
        if isPickedorder || isOrderDeliverd {
            if stickyPoint < 260 {
                if isOrderDeliverd {
                    self.orderDeliveredView.isHidden = true
                    self.orderDeliveredViewHeight.constant = 0
                    self.providerView.isHidden = true
                }else{
                    self.providerView.isHidden = false
                }
               
                self.tblPullUp.parallaxHeader.height = self.hightOfHeaderWhenDwon
                self.position = "DOWN"
            }else{
                if isOrderDeliverd {
                    self.orderDeliveredView.isHidden = false
                    self.orderDeliveredViewHeight.constant = self.hightOfDeliverdView + 40
                }
                self.tblPullUp.parallaxHeader.height = self.hightOfHeaderWhenUp
                self.providerView.isHidden = true
               self.position = "UP"
        }
        }
        if self.orderDeliveredView.isHidden == false {
            self.tblPullUp.parallaxHeader.height = self.hightOfHeaderWhenDwon
            //self.providerView.isHidden = true
        }
        self.tblPullUp.isScrollEnabled = true
        
        if stickyPoint < 260 {
            let tempHight = self.tblPullUp.parallaxHeader.height//self.viewHeader.frame.size.height + 10
            tblPullUp.setContentOffset(CGPoint(x: 0, y: -tempHight), animated: true)
            tblPullUp.isScrollEnabled  = false
        }
       
       
    }
    
    override func pullUpControllerDidDrag(to point: CGFloat) {
        self.tblPullUp.isScrollEnabled = false
       
        
        if point < 260 {
           
            let tempHight = self.tblPullUp.parallaxHeader.height
                tblPullUp.setContentOffset(CGPoint(x: 0, y: -tempHight), animated: true)
                tblPullUp.isScrollEnabled  = false
            }
            
           
    }
    override func pullUpControllerAnimate(action: PullUpController.Action,
                                          withDuration duration: TimeInterval,
                                          animations: @escaping () -> Void,
                                          completion: ((Bool) -> Void)?) {
        switch action {
        case .move:
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: animations,
                           completion: completion)
        default:
            UIView.animate(withDuration: 0.3,
                           animations: animations,
                           completion: completion)
        }
    }
    override var pullUpControllerPreferredSize: CGSize {
        return portraitSize
    }
    
    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return landscapeFrame
    }
    override var pullUpControllerBounceOffset: CGFloat {
        return 25
    }
   
    
}


