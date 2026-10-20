

import Foundation
extension RaisedButton {
    
    func setTheme(_ sender: UIButton) {
        sender.backgroundColor = SColors.btBg
        
        DispatchQueue.main.async {
            sender.setTitleColor(SColors.btTxt, for: UIControl.State())
            sender.setTitleColor(SColors.btTxt, for: .highlighted)
            sender.setTitleColor(SColors.btTxt, for: .application)
            sender.setTitleColor(SColors.btTxt, for: .reserved)
            sender.setTitleColor(SColors.btTxt, for: .selected)
            sender.setTitleColor(SColors.btTxt, for: .disabled)
            sender.setTitleColor(SColors.btTxt, for: .focused)
        }
        
    }
    
    func setTheme(_ sender: UIButton, isAppTheme:Bool) {
        sender.backgroundColor = SColors.Theme
        
        DispatchQueue.main.async {
            sender.setTitleColor(SColors.ThemeTxt, for: UIControl.State())
            sender.setTitleColor(SColors.ThemeTxt, for: .highlighted)
            sender.setTitleColor(SColors.ThemeTxt, for: .application)
            sender.setTitleColor(SColors.ThemeTxt, for: .reserved)
            sender.setTitleColor(SColors.ThemeTxt, for: .selected)
            sender.setTitleColor(SColors.ThemeTxt, for: .disabled)
            sender.setTitleColor(SColors.ThemeTxt, for: .focused)
        }
        
    }
    
    func setTheme(_ sender: UIButton,disabledColor:UIColor) {
        sender.backgroundColor = SColors.btBg
        
        DispatchQueue.main.async {
            sender.setTitleColor(SColors.btTxt, for: UIControl.State())
            sender.setTitleColor(SColors.btTxt, for: .highlighted)
            sender.setTitleColor(SColors.btTxt, for: .application)
            sender.setTitleColor(SColors.btTxt, for: .reserved)
            sender.setTitleColor(SColors.btTxt, for: .selected)
            sender.setTitleColor(disabledColor, for: .disabled)
            sender.setTitleColor(SColors.btTxt, for: .focused)
        }
        
    }
    
    func setTxtColor(_ color:UIColor) {
        DispatchQueue.main.async {
            self.setTitleColor(color, for: UIControl.State())
            self.setTitleColor(color, for: .highlighted)
            self.setTitleColor(color, for: .application)
            self.setTitleColor(color, for: .reserved)
            self.setTitleColor(color, for: .selected)
            self.setTitleColor(color, for: .disabled)
            self.setTitleColor(color, for: .focused)
        }
        
    }
}
