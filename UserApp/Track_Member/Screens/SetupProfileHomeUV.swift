//
//  SetupProfileHomeUV.swift
//  UserApp
//
//  Created by Apple on 21/11/22.
//

import UIKit
import SysBaseLib
import Lottie

class SetupProfileHomeUV: ParentViewUV, ParentViewUVDelegate, MyBtnClickDelegate {
    
    @IBOutlet weak var setupProfileBtn: MyButton!
    @IBOutlet weak var menuImgViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var subTitleLbl: MyLabel!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    var cntView:UIView!
    
    let generalFunc = GeneralFunctions()
    
    var dataDic = NSDictionary()
    var userProfileJson:NSDictionary!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
   
    func viewType(type: Int) {
        if type == 0 {
            
            
            cntView = self.generalFunc.loadView(nibName: "SetupProfileScreenDesign", uv: self, contentView: contentView)
            self.view.backgroundColor = UIColor(hex: 0xF2F2F4)
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            cntView.backgroundColor = UIColor.clear
            self.contentView.addSubview(cntView)
            self.menuImgViewTopSpace.constant = menuImgViewTopSpace.constant + GeneralFunctions.getSafeAreaInsets().top - 15
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            self.contentView.backgroundColor = UIColor.init(hexString: GeneralFunctions.getValue(key: "LOGIN_BANNER_BG_COLOR") as! String, alpha: 1)
            self.setBackButton()
            self.perofrmAnimation()
            
            self.setData()
            
            
        }else if type == 1 {
            self.configRTL()
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationItem.setHidesBackButton(true, animated: false)
            
        }else if type == 3 {
           
        }
    }
    
    func setBackButton(){
        let img = UIImage(named: "ic_nav_bar_back")!
        if Configurations.isRTLMode() {
                let img1 = img.rotate(180)
                self.menuImgView.image = img1
        }else {
            self.menuImgView.image = img
        }
        self.menuImgView.backgroundColor = UIColor.white
        GeneralFunctions.setImgTintColor(imgView: menuImgView, color: UIColor.black)
        
        self.menuImgView.cornerRadius = 25
        self.menuImgView.shadowColor = UIColor.lightGray
        self.menuImgView.shadowOffset = CGSize(width: 0, height: 0.0)
        self.menuImgView.shadowRadius = 2.0
        self.menuImgView.shadowOpacity = 1.0
        self.menuImgView.masksToBounds = false
        self.menuImgView.shadowPath = UIBezierPath(roundedRect:self.menuImgView.bounds, cornerRadius:self.menuImgView.layer.cornerRadius).cgPath
        self.menuImgView.image = self.menuImgView.image?.addImagePadding(x: 20, y: 20)
        self.menuImgView.handleClick { instance in
            self.close()
        }
        
    }
    
    func setData(){
        
        self.setupProfileBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_SETUP_PROFILE_TXT"))
        self.setupProfileBtn.clickDelegate = self
        
        if(self.userProfileJson.get("TRACK_ANY_SERVICE_ENABLED").uppercased() == "YES"){
            self.titleLbl.text = dataDic.get("vTitle")
        }else{
            self.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_ANY_TXT")
        }
        
        self.subTitleLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_SERVICE_DESC")
    }
    
    func perofrmAnimation(){
    
        animationView.contentMode = .scaleAspectFit
         
        animationView.loopMode = .loop
          
        animationView.play()
        
    }
    
    func myBtnTapped(sender: MyButton) {
        let mainScreenUv = GeneralFunctions.instantiateViewController(pageName: "TrackAnySignupUV") as! TrackAnySignupUV
        mainScreenUv.dataDic = self.dataDic
        self.push(uv: mainScreenUv)
    }
    
}
