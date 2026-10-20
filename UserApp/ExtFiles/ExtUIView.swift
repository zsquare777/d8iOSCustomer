

import Foundation
extension UIView {
    typealias OnClickedHandler = (_ instance:UIView) -> Void
    
    private struct ClickHolder {
        static var onClickHandlerKey = "@ViewClickHolder"
    }
    
    func handleClick(clickHandler:@escaping OnClickedHandler){
        self.isUserInteractionEnabled = true
        let tapGue = UITapGestureRecognizer()
        tapGue.addTarget(self, action: #selector(self.onClick(sender:)))
        
        self.addGestureRecognizer(tapGue)
        
        objc_setAssociatedObject(self, &ClickHolder.onClickHandlerKey, clickHandler, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc private func onClick(sender:UITapGestureRecognizer){
        if let clickHandler = objc_getAssociatedObject(self, &ClickHolder.onClickHandlerKey) as? OnClickedHandler {
            clickHandler(self)
        }
    }
    
    func roundTo(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(corners : CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    func addShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func createShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func createDashedLine(color: UIColor = .lightGray, lineWidth:CGFloat, _ isLineDashPattern:Bool = false) {
        layer.sublayers?.filter({ $0.name == "DashedTopLine" }).forEach({ $0.removeFromSuperlayer() })
        backgroundColor = .clear
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: (frame.width / 2) + (lineWidth / 2), y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        if(isLineDashPattern != true){
            shapeLayer.lineDashPattern = [4, 4]
        }else{
            shapeLayer.lineDashPattern = [2, 3]
        }
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: (frame.width / 2) - (lineWidth / 2), y: frame.height))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
    
    func createDashedBorder() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 0.5
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func customDashedBorder(_ linerWidth : Double = 1.0,_ color : CGColor = UIColor.lightGray.cgColor) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = linerWidth
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addLineDashedStroke(radius: CGFloat, color: CGColor,_ pattern: [NSNumber] = [2,2]) -> CALayer {
            let borderLayer = CAShapeLayer()

            borderLayer.strokeColor = color
            borderLayer.lineDashPattern = pattern
        borderLayer.width = 1
            borderLayer.frame = bounds
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

            layer.addSublayer(borderLayer)
            return borderLayer
        }
    
    
    func createDashedBorderForWholeView() {
        layer.sublayers?.filter({ $0.name == "borderLayer" }).forEach({ $0.removeFromSuperlayer() })
        
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = self.frame.size
        let shapeRect = CGRect(0, 0, frameSize.width, frameSize.height)
        
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(frameSize.width/2,frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.lightGray.cgColor
        borderLayer.lineWidth = 2
        borderLayer.lineJoin=CAShapeLayerLineJoin.round
        borderLayer.lineDashPattern = [5,5]
        
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 0)
        borderLayer.path = path.cgPath
        self.layer.addSublayer(borderLayer)
    }
    
    func createShadowWithCornerRadius(cornerRadius:CGFloat,_ ShadowColor:UIColor = .gray,_ Opacity:Float = 0.5, fillColor :UIColor = .clear) {
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        
        shadowLayer.shadowColor = ShadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.shadowOpacity = Opacity
        shadowLayer.shadowRadius = 3
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func getImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func showAnimation(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func hideAnimation(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
    func addShadowWithCornerRadius(cornerRadius:CGFloat,_ ShadowColor:UIColor = .gray,_ Opacity:Float = 0.5, fillColor :UIColor = .clear) {
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        
        shadowLayer.shadowColor = ShadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.shadowOpacity = Opacity
        shadowLayer.shadowRadius = 3
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func dashedBorderLayerWithColor(color:CGColor){
        let  borderLayer = CAShapeLayer()
        borderLayer.name  = "borderLayer"
        let frameSize = self.frame.size
        let shapeRect = CGRect(x:0, y:0, width:frameSize.width, height:frameSize.height)
        
        borderLayer.bounds=shapeRect
        borderLayer.position = CGPoint(x: frameSize.width/2, y:frameSize.height/2)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth=5
        borderLayer.lineJoin=CAShapeLayerLineJoin.round
        borderLayer.lineDashPattern = [NSNumber(value: 8),NSNumber(value:4)]
        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 0)
        
        borderLayer.path = path.cgPath
        self.layer.addSublayer(borderLayer)
    }
    
    func constraintWith(identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first(where: {$0.identifier == identifier})
    }
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
    func shadowOnCustomview(){
        self.shadowColor = UIColor.lightGray
        self.shadowOffset = CGSize(width: 0, height: 0.0)
        self.shadowRadius = 2.0
        self.shadowOpacity = 1.0
        self.masksToBounds = false
    }
    func lightshadowOnCustomview(){
        self.shadowColor = UIColor.lightGray
        self.shadowOffset = CGSize(width: 0, height: 0.0)
        self.shadowRadius = 1.0
        self.shadowOpacity = 0.7
        self.masksToBounds = false
    }
    func getViewHightWidth(baseWidhth : Double , baseHight : Double, _ defalutWidth:Double = 0.0 , _ defalutHight:Double = 0.0) -> (Double, Double){
        
        let width = ((defalutWidth * Application.screenSize.width) / baseWidhth)
        let hight = ((defalutHight * Application.screenSize.height) / baseHight)
        return (width,hight)
    }
    
    
    
    func addShadowWithCornerRadius_new(cornerRadius:CGFloat = 8.0,ShadowColor:CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor,Opacity:Float = 1.0,shadowRadius : CGFloat = 2.0) {
        self.layer.shadowOpacity = Opacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = ShadowColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }
    func applyGradient(colours: [UIColor]){
           self.applyGradient(colours: colours, locations: nil)
        }

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            gradient.locations = locations
            gradient.cornerRadius = 10
            self.layer.insertSublayer(gradient, at: 0)
            
        }
    
}


// FOR MULTI_DELIVERY
class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var filColor:UIColor = SColors.Theme
    var storkColor:UIColor = UIColor.lightGray
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.setLineWidth(1.0)
        context.setStrokeColor(storkColor.cgColor)
        context.setFillColor(filColor.cgColor)
        
        context.closePath()
        
        context.drawPath(using: .fillStroke)
        
    }
}

class TriangleViewForUFX : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY / 2.0)))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        
        //        It will draw linke this >
        //        This will start from MinX, MaxY;
        //        Draw a line from the start to MaxX, MaxY / 2.0;
        //        Draw a line from MaxX,MaxY / 2.0 to MinX, MinY;
        //        Then close the path to the start location.
        
        context.setFillColor(SColors.Theme.cgColor)
        context.fillPath()
    }
}


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var setPlaceholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}

extension UISearchBar {

    public var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            return textField
        }
    }

    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    private var searchIcon: UIImage? {
        let subViews = subviews.flatMap { $0.subviews }
        return  ((subViews.filter { $0 is UIImageView }).first as? UIImageView)?.image
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            let _searchIcon = searchIcon
            if newValue {
                if activityIndicator == nil {
                    let _activityIndicator = UIActivityIndicatorView(style: .gray)
                    _activityIndicator.startAnimating()
                    _activityIndicator.backgroundColor = UIColor.clear
                    let clearImage = UIImage().imageWithPixelSize(size: CGSize.init(width: 14, height: 14)) ?? UIImage()
                    self.setImage(clearImage, for: .search, state: .normal)
                    textField?.leftViewMode = .always
                    textField?.leftView?.addSubview(_activityIndicator)
                    let leftViewSize = CGSize.init(width: 14.0, height: 14.0)
                    _activityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                if #available(iOS 11.0, *) {
                     activityIndicator?.removeFromSuperview()
                    //let _searchIcon = UIImage(named: "ic_search")!
                   // self.setImage(_searchIcon, for: .search, state: .normal)
                    self.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: UIColor(hex: 0x1B2A3B)), for: .search, state: .normal)
                }
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    var isLoadingSearvice: Bool {
        get {
            return activityIndicator != nil
        } set {
            let _searchIcon = searchIcon
            if newValue {
                if activityIndicator == nil {
                    let _activityIndicator = UIActivityIndicatorView(style: .gray)
                    _activityIndicator.startAnimating()
                    _activityIndicator.backgroundColor = UIColor.clear
                    let clearImage = UIImage().imageWithPixelSize(size: CGSize.init(width: 14, height: 14)) ?? UIImage()
                    self.setImage(clearImage, for: .search, state: .normal)
                    textField?.leftViewMode = .always
                    textField?.leftView?.addSubview(_activityIndicator)
                    let leftViewSize = CGSize.init(width: 14.0, height: 14.0)
                    _activityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                if #available(iOS 11.0, *) {
                     activityIndicator?.removeFromSuperview()
                    //let _searchIcon = UIImage(named: "ic_search")!
                   // self.setImage(_searchIcon, for: .search, state: .normal)
                    self.setImage(UIImage(named:"ic_search_nav")?.tintTo(color: UIColor(hex: 0x1B2A3B)), for: .search, state: .normal)
                    //self.setImage(UIImage(), for: .search, state: .normal)
                }
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}

extension CACornerMask {
    static let topLeft : CACornerMask = .layerMinXMinYCorner
    static let topRight : CACornerMask = .layerMaxXMinYCorner
    static let bottomLeft : CACornerMask = .layerMinXMaxYCorner
    static let bottomRight : CACornerMask = .layerMaxXMaxYCorner
}
