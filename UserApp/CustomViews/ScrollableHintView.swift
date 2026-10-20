

import UIKit

class AnchTriangleView : UIView {
    
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
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        context.setFillColor(UIColor.white.withAlphaComponent(1.0).cgColor)
        context.fillPath()
    }
}

class ScrollableHintView: UIView {

    // Public Variables
    
    var hintTextColor = UIColor.black
    var hintViewGradiantColorArray = [UIColor.white.cgColor,UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1.0).cgColor]
    var hintViewIsHidden = false
    
    // Private Variables
    private var scrollView:UIView!
    private var label:MyLabel!
    private var helpImgView:UIImageView!
    var anchorView:AnchTriangleView!
    private var anchorXAdj:CGFloat = 0.0
    private var setDown = false
    
    
    required init(viewX:CGFloat, withWidth:CGFloat, setDownToView:Bool, viewY:CGFloat, withText:String, uv:MainScreenUV!)
    {
      
        var viewWidth = withText.width(withConstrainedHeight: 50, font: UIFont.init(name: Fonts().semibold, size: 14)!) + 40
        viewWidth = viewWidth > Application.screenSize.width - 40 ? Application.screenSize.width - 40 : viewWidth
        
        super.init(frame: CGRect(x: 25, y:viewY, width: viewWidth, height: 50))
       
      
        if viewX > (self.frame.origin.x + viewWidth)
        {
           
            self.frame.origin.x = self.frame.origin.x + (viewX - (self.frame.origin.x + viewWidth)) + 30
            
        }
      
        self.alpha = 0
        
        self.layer.cornerRadius = 6
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4

        
        self.showAnimate()
        
       
        // Scroll View
        scrollView = UIView.init(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clear
        self.addSubview(scrollView)
        
        // Hint LblView
        label = MyLabel.init(frame: CGRect(x: 10, y:0, width: viewWidth - 20, height: 50))
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = withText
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor.clear
        self.scrollView.addSubview(label)
        
        label.textColor = UIColor(hex: 0x2b87f0)
        label.font =  UIFont.init(name: Fonts().semibold, size: 14)!
        label.fontFamilyWeight = "Medium"
        label.setFontFamily()
        
        label.addImage(originalText: Configurations.isRTLMode() ? " \(withText)" : "\(withText) ", image: UIImage(named: "ic_fare_detail")!.resize(toWidth: 15)!.resize(toHeight: 15)!, color: UIColor(hex: 0x2b87f0), position:  Configurations.isRTLMode() ? .left : .right)
        
        
        // Anchor View
        if setDown == true{
            anchorView = AnchTriangleView.init(frame: CGRect(x: viewX - 10, y: viewY, width: 20, height: 10))
            anchorView.layer.borderColor = UIColor.black.cgColor
            anchorView.backgroundColor = UIColor.clear
            uv.contentView.addSubview(anchorView)
        }
        else{
            
            anchorView = AnchTriangleView.init(frame: CGRect(x: viewX - 10, y:viewY + 50, width: 20, height: 10))
            anchorView.layer.borderColor = UIColor.black.cgColor
            anchorView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            anchorView.backgroundColor = UIColor.clear
            uv.contentView.addSubview(anchorView)
        }
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc func hideView(){
        
        if scrollView != nil && label != nil
        {
            self.scrollView.removeFromSuperview()
            self.label.removeFromSuperview()
            self.scrollView = nil
            self.label = nil
            
            self.removeAnimate()
        }
    }
    
  
    
    // Hint View Animtion
    func showAnimate()
    {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.isHidden = true
            }
        });
    }
   
}
