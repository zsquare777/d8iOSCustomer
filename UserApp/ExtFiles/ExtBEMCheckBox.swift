

import Foundation
import SysBaseLib

extension BEMCheckBox{
    func setStyle(_ style: BEMBoxType = .square){
        self.boxType = style
        self.tintColor = UIColor.lightGray
        self.lineWidth = 1.0
    }
    
    func anim(){
        self.offAnimationType = .bounce
        self.onAnimationType = .bounce
    }
    
    func theme(){
        self.onCheckColor = SColors.ThemeTxt
        self.onFillColor = SColors.Theme
        self.onTintColor = SColors.Theme
    }
    
    func createSysBox(){
        setStyle()
        anim()
        theme()
    }
}
