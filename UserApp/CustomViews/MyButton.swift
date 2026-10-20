
import UIKit

protocol MyBtnClickDelegate {
    func myBtnTapped(sender:MyButton)
}

class MyButton: UIView {
    
    typealias OnBtnClickedHandler = (_ instance:MyButton) -> Void
    
    @IBInspectable internal var isAppTheme:Bool = false
    @IBInspectable internal var isAppTheme1:Bool = true
    @IBInspectable internal var isGradinatButton: Bool = false
    @IBInspectable internal var title:String = ""
    
    @IBInspectable internal var titleColor:UIColor!
    @IBInspectable internal var bgColor:UIColor!
    @IBInspectable internal var pulseColor:UIColor!
    @IBInspectable internal var fontFamilyWeight:String = "Regular"
    @IBInspectable internal var fontSize:CGFloat = 18
    
    // MARK:- Delegate
    var clickDelegate:MyBtnClickDelegate?
    
    var buttonTitle = ""
    
    var button:RaisedButton?
    
    var customTitleColor:UIColor!
    
    var isBtnEnabled = true
    var btnType = ""
    var isBtnTitileCapital = true
    var clickHandler:OnBtnClickedHandler!
    
    var fontName = Fonts().light
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        initializeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        initializeButton()
    }
    
    func initializeButton(){
        if(self.button == nil){
            self.button = RaisedButton()
            self.button?.layer.cornerRadius = 10
        }
    }
    
    override func layoutSubviews() {
        addButton()
    }
    
    func setClickHandler(handler:@escaping OnBtnClickedHandler){
        self.clickHandler = handler
    }
    
    func addButton(){
        self.backgroundColor = UIColor.clear
        
        initializeButton()
        
        if(isAppTheme == false && isAppTheme1 == false){
//            button = RaisedButton(title: title.uppercased(), titleColor: titleColor)
           // button!.title = title.uppercased()
            button!.titleColor = titleColor
            button!.pulseColor = SColors.Theme_Hover
            button!.backgroundColor = bgColor
        }else if(isAppTheme){
            //            button = RaisedButton(title: title, titleColor: ColorATColor.ThemeTxt)
           // button!.title = title.uppercased()
            button!.titleColor = SColors.ThemeTxt
            button!.pulseColor = SColors.Theme_Hover
            button!.backgroundColor = SColors.Theme
        }else if(titleColor != nil && bgColor != nil && pulseColor != nil){
//            button = RaisedButton(title: title, titleColor: ColorATColor.ThemeTxt_1)
           // button!.title = title.uppercased()
            button!.titleColor = titleColor
            button!.pulseColor = pulseColor
            button!.backgroundColor = bgColor
        }else{
            //button!.title = title.uppercased()
            button!.titleColor = SColors.ThemeTxt_1
            button!.pulseColor = SColors.Theme_1_Hover
            button!.backgroundColor = SColors.Theme_1
        }
        
        var compareStr = ""
        var fontCon = [String] ()
        fontCon = fontFamilyWeight.components(separatedBy: "-")
        if(fontCon.count > 0){
            compareStr = fontCon.last ?? ""
        }
        
        if("Regular" == fontFamilyWeight || "Regular" == compareStr || Utils.fontFname == fontCon.first ?? ""){
            fontName = Fonts().regular
        }else if("Medium" == fontFamilyWeight || "Medium" == compareStr || "Semibold" == compareStr || "Semibold" == fontFamilyWeight){
            fontName = Fonts().semibold
        }else if("Light" == fontFamilyWeight || "Light" == compareStr){
            fontName = Fonts().light
        }else if("Bold" == fontFamilyWeight || "Bold" == compareStr){
            fontName = Fonts().bold
        }else{
            fontName = Fonts().light
        }
        
        button!.frame = self.frame
        button!.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
         button!.pulseAnimation = .centerWithBacking
        button!.titleLabel!.font = UIFont(name: fontName, size: fontSize)
        if isGradinatButton {
            
                self.button?.applyGradient(colours: [SColors.parcelDeliveryBtnGradiantColor1,SColors.parcelDeliveryBtnGradiantColor2])
            
            
        }
        setScaleFactor()
//        if isBtnTitileCapital {
//            // as per new design changes all button title not come in uppercase
//        //button!.title = self.buttonTitle.uppercased()
//        }else{
//            button!.title = self.buttonTitle
//        }
        button!.title = self.buttonTitle
        if(customTitleColor != nil){
            self.button!.titleColor = customTitleColor
        }
        
        self.button!.isEnabled = self.isBtnEnabled
        
        self.addSubview(button!)
        
        
//        let tapGue = UITapGestureRecognizer()
//        tapGue.addTarget(self, action: #selector(self.btnTapped(sender:)))
//        
//        self.addGestureRecognizer(tapGue)
        button!.addTarget(self, action:#selector(self.btnTapped), for: .touchUpInside)
    }
    
    private func setScaleFactor(){
        button!.titleLabel?.frame = self.frame
        button!.titleLabel?.lineBreakMode = .byWordWrapping
        button!.titleLabel?.numberOfLines = 2
        button!.titleLabel?.minimumScaleFactor = 0.6
        button!.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 2.0, bottom: 0.0, right: 2.0)
        button!.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func enableCustomColor(){
        button!.titleColor = titleColor
        button!.pulseColor = pulseColor
        button!.backgroundColor = bgColor
    }
    
    @objc func btnTapped(){
        if (Application.window != nil){
            Application.window?.endEditing(true)
        }
        
        clickDelegate?.myBtnTapped(sender: self)
        
        if(clickHandler != nil){
            clickHandler(self)
        }
    }
    
    func setButtonEnabled(isBtnEnabled:Bool){
        if(self.button == nil){
            self.isBtnEnabled = isBtnEnabled
        }else{
            self.isBtnEnabled = isBtnEnabled
            self.button?.isEnabled = isBtnEnabled
        }
        
        if(isBtnEnabled){
            self.button?.alpha = 1
        }else{
            self.button?.alpha = 0.5
        }
    }
    
    func setButtonTitle(buttonTitle:String){

        self.buttonTitle = buttonTitle
        if(getButton() != nil){
           // getButton()!.title = buttonTitle.uppercased()
            getButton()!.title = buttonTitle
        }
    }
    func setButtonTitleWithoutUppercased(buttonTitle:String){
        isBtnTitileCapital = false
        self.buttonTitle = buttonTitle
        if(getButton() != nil){
            
            getButton()!.title = buttonTitle
        }
    }
    func setButtonTitleColor(color:UIColor){
        self.customTitleColor = color
        if(self.button != nil){
            self.button!.titleColor = color
        }
    }
    
    func setAppThemeColor(isAppTheme:Bool){
        if(isAppTheme){
            self.isAppTheme = true
            self.isAppTheme1 = false
        }else{
            self.isAppTheme = false
            self.isAppTheme1 = true
        }
        
        if(self.button != nil){
            if(isAppTheme){
                button!.titleColor = SColors.ThemeTxt
                button!.pulseColor = SColors.Theme_Hover
                button!.backgroundColor = SColors.Theme
            }else{
                button!.titleColor = SColors.ThemeTxt_1
                button!.pulseColor = SColors.Theme_1_Hover
                button!.backgroundColor = SColors.Theme_1
            }
        }
    }
    
    func setCustomColor(textColor:UIColor, bgColor:UIColor, pulseColor:UIColor){
        isAppTheme = false
        isAppTheme1 = false
        
        self.titleColor = textColor
        self.bgColor = bgColor
        self.pulseColor = pulseColor
        
        button!.titleColor = textColor
        button!.pulseColor = pulseColor
        button!.backgroundColor = bgColor
    }
    
    func setCustomColor(textColor:UIColor, bgColor:UIColor, pulseColor:UIColor, borderColor:UIColor, borderWidth:CGFloat, cornerRadius:CGFloat){
        isAppTheme = false
        isAppTheme1 = false
        
        self.titleColor = textColor
        self.bgColor = bgColor
        self.pulseColor = pulseColor
        
        button!.titleColor = textColor
        button!.pulseColor = pulseColor
        button!.backgroundColor = bgColor
        button!.borderColor = borderColor
        button?.borderWidth = borderWidth
        button?.cornerRadius = cornerRadius
    }
    
    func getButton() -> RaisedButton?{
//        return self.subviews[0] as! RaisedButton
        if(self.subviews.count > 0){
            return self.subviews[0] as? RaisedButton
        }else{
            return nil
        }
    }
    func setFont(fontSize:CGFloat){
        button!.titleLabel!.font = UIFont(name: fontName, size: fontSize)

    }
    func centerButtonText(){
      //  button?.contentHorizontalAlignment = .center
         button?.titleLabel?.textAlignment = .center
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
