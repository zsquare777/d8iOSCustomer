

import Foundation
extension UIColor {
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
        
    var hexS: String {
        let components = self.cgColor.components
        
        let red = Float(components![0])
        let green = Float(components![1])
        let blue = Float(components![2])
        return String(format: "#%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
    }
    
    func light(by percentage:CGFloat=20.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func dark(by percentage:CGFloat=20.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=20.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    
}


public struct SColors {
    
    public static let Red = UIColor(hex: 0xED2939)
    public static let DarkRed = UIColor(hex: 0xb30000)
    public static let Pink = UIColor(hex: 0xE91E63)
    public static let Purple = UIColor(hex: 0x9C27B0)
    public static let DeepPurple = UIColor(hex: 0x673AB7)
    public static let Indigo = UIColor(hex: 0x3F51B5)
    public static let Blue = UIColor(hex: 0x2196F3)
    public static let LightBlue = UIColor(hex: 0x03A9F4)
    public static let Cyan = UIColor(hex: 0x00BCD4)
    public static let Teal = UIColor(hex: 0x009688)
    public static let Green = UIColor(hex: 0x4CAF50)
    public static let LightGreen = UIColor(hex: 0x8BC34A)
    public static let Lime = UIColor(hex: 0xCDDC39)
    public static let Yellow = UIColor(hex: 0xFFEB3B)
    public static let Amber = UIColor(hex: 0xFFC107)
    public static let Orange = UIColor(hex: 0xFF9800)
    public static let DeepOrange = UIColor(hex: 0xFF5722)
    public static let Brown = UIColor(hex: 0x795548)
    public static let Grey = UIColor(hex: 0x9c9c9c)
    public static let BlueGrey = UIColor(hex: 0x607D8B)
    public static let blackColor = UIColor(hex: 0x000000)
    public static let maroon = UIColor(hex: 0x800000)
    public static let status_blue_border = UIColor(hex: 0x1CC9E8)
    public static let skyBlue = UIColor(hex: 0x93bee0)

    public static let light_background_color = UIColor(hex: 0xDCDCDC)
    public static let grey_image_tint_color = UIColor(hex: 0x808080)
    public static let selected_rate_color = UIColor(hex: 0xFAB00A)
    public static let unSelected_rate_color = UIColor(hex: 0xc9c9c9)
    /**
    * App Theme related Changes Started.
    */
    public static let defaultTextColor = UIColor(hex: 0x7C7C7C)
    public static let green = UIColor(hex: 0x008000)
    public static let red = UIColor(hex: 0xFF0000)
    
    public static var Theme = UIColor(hex: 0x0d2744)
//    public static var Theme = UIColor(hex: 0x000000)
//    public static var Theme = UIColor(hex: 0x990099)
    public static let Theme_Dark = UIColor(hex: 0x700070)
    public static let Theme_Hover = UIColor(hex: 0xab00ab)
    public static var ThemeTxt = UIColor(hex: 0xFFFFFF)
    public static let ThemeSBStyle = "LIGHT"
    
    public static let Theme_1 = UIColor(hex: 0x990099)
    public static let Theme_1_Hover = UIColor(hex: 0x272727)
    public static let ThemeTxt_1 = UIColor(hex: 0xFFFFFF)
    
    public static let ThemeColor_2 = UIColor(hex: 0x9900ff)
    public static let ThemeViewColor = UIColor(hex: 0xf1f1f1)

    public static let tfActive = Theme
    public static let tfDividerInActive = UIColor(hex: 0xbfbfbf)
    public static let tfDividerActive = Theme
    public static let tfPlaceholderInActive = UIColor(hex: 0x646464)
    public static let tfPlaceholderActive = Theme
    
    public static let btBg = Theme_1
    public static let btTxt = ThemeTxt_1
    public static let textColor = UIColor(hex: 0x1B2A3B)
    public static let documentPickerNavColor = UIColor(hex: 0x1F72FF)
    public static let parcelDeliveryHomeScreenBgColor = UIColor(hex: 0xF3FAFF)
    public static let parcelDeliveryBtnGradiantColor1 = UIColor(hex: 0x1CA3FF)
    public static let parcelDeliveryBtnGradiantColor2 = UIColor(hex: 0x6AC3FF)
    /**
     * TripEnd Button Related Colors Started
     */
        public static let TripEndButtonColor = UIColor(hex: 0xd20000)
    /**
     * TripEnd Button Related Colors Finished
     */
    
    /**
     * Source & Destination Related Colors Started
     */
    public static let SourceAddColor = UIColor(hex: 0x529800)
    public static let DestAddColor = UIColor(hex: 0xCC0000)
    /**
     * Source & Destination Related Colors Finished
     */
    
    public static let CallImageBGColor = UIColor(hex: 0x39C248)
    public static let ChatImageBGColor = UIColor(hex: 0x027DFF)
    public static let NavigateImageBGColor = UIColor(hex: 0xF29B08)
    public static let MSPCancelImageBGColor = UIColor(hex: 0xd20000)
    
    /**
    * Menu screen Related Colors Started
    */
    public static let menuListBg = UIColor(hex: 0x2a2c2d)
    public static let menuListTxtColor = UIColor(hex: 0xFFFFFF)
    
    public static let logOutBg = Theme  // Generally this is the AppThemeColor
    public static let logOutTxtColor = ThemeTxt  // Generally this is the ThemeTxt
    /**
    * Menu screen Related Colors Finished
    */
    
    /**
    * App Login - Language and Currency Related Changes Started
    */
    
    public static let alDividerNormalColor = UIColor.clear
    public static let alDividerActiveColor = UIColor.clear
    public static let alPlaceholderNormalColor = UIColor.clear
    public static let alPlaceholderActiveColor = UIColor.clear
    public static let alFieldTxtColor = UIColor(hex: 0xFFFFFF)
    public static let alTextFieldBGColor = Theme_Dark
    public static let alFieldBorderColor = UIColor(hex: 0xFFFFFF)
    public static let alFieldArrowColor = UIColor(hex: 0xFFFFFF)
    public static let alFieldBorderWidth:CGFloat = 1
    public static let alFieldLeftPadding:CGFloat = 10
    public static let alFieldRightPadding:CGFloat = 5
    
    /**
    * App Login - Language and Currency Related Changes Finished
    */
    
    public static let tripDetailHeaderBarHTxtColor = UIColor(hex: 0xFFFFFF) // Generally this is the AppThemeColor
    public static let tripDetailUserRatingFillColor = Theme // Generally this is the AppThemeColor
    
    public static let walletPageViewTransBtnTextColor = ThemeTxt_1 // Generally this is the ThemeTxt_1
    public static let walletPageViewTransBtnBGColor = Theme // Generally this is the AppThemeColor_1
    public static let walletPageViewTransBtnPulseColor = walletPageViewTransBtnBGColor.dark(by: 20)! // Generally this is the AppThemeColor_1
    
    public static let paymentConfigBtnTextColor = ThemeTxt_1 // Generally this is the ThemeTxt_1
    public static let paymentConfigBtnBGColor = Theme_1 // Generally this is the AppThemeColor_1
    public static let paymentConfigBtnPulseColor = paymentConfigBtnBGColor.dark(by: 20)! // Generally this is the AppThemeColor_1
    
    public static let requestRetryBtnTextColor = ThemeTxt_1 // Generally this is the ThemeTxt_1
    public static let requestRetryBtnBGColor = Theme_1 // Generally this is the AppThemeColor_1
    public static let requestRetryBtnPulseColor = requestRetryBtnBGColor.dark(by: 20)! // Generally this is the AppThemeColor_1
    
    public static let requestPageRatingFillColor = UIColor(hex: 0x4187D6) // Generally this is the AppThemeColor
    /**
    * App Theme related Changes Finished
    */
}
