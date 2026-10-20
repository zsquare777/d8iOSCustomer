//
//  AddStopMiddiatorUV.swift
//  
//
//  Created by # Admin on 10/04/23.
//

import UIKit
import SysBaseLib
class AddStopMiddiatorUV: ParentViewUV,ParentViewUVDelegate,MyBtnClickDelegate {
    
    
    let generalFunc = GeneralFunctions()
    var userProfileJson:NSDictionary!
    var cntView:UIView!
    
    @IBOutlet weak var imgViewHight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var discriptionLbl: MyLabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var btnOk: MyButton!
    @IBOutlet weak var septatorView: UIView!
    @IBOutlet weak var cancelImgView: UIImageView!
    var selectedLatitude = ""
    var selectedLongitude = ""
    var selectedAddress = ""
    var item = NSDictionary()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    func viewType(type: Int) {
        if (type == 0) {
            
            cntView = self.generalFunc.loadView(nibName: "AddStopMiddiatorScreenDesign", uv: self, contentView: contentView)
            self.view.backgroundColor = SColors.ThemeTxt
            cntView.frame.size = CGSize(width: cntView.frame.width, height: self.cntView.frame.height)
            self.contentView.addSubview(cntView)
            self.imgView.backgroundColor = UIColor(hex: 0xf1f1f1)
        }else if (type == 1) {
            self.configRTL()
            self.setData()
            self.scrView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60 , right: 0)
            

            Utils.delayWithSeconds(1) {
                let ratio =  GeneralFunctions.parseDouble(origValue: 1.0, data: self.item.get("vImageWidth")) / GeneralFunctions.parseDouble(origValue: 1.0, data: self.item.get("vImageHeight"))
                self.imgViewHight.constant = Utils.getHeightOfBanner(widthOffset: 80, ratio: String(ratio) )
                let vImage = Utils.getResizeImgURL(imgUrl: self.item.get("vPageImg"), width: 0 , height: Utils.getValueInPixel(value: CGFloat(self.imgViewHight.constant)), MAX_WIDTH: Utils.getValueInPixel(value: CGFloat(Application.screenSize.width - 80)))
                self.imgView.sd_setImage(with: URL(string: vImage), placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    self.imgView.backgroundColor = UIColor.clear
                })
            }
            self.titleLbl.text = self.item.get("vPageTitle")
            let content = self.item.get("vPageDesc").replace("\n", withString: "<br>")
            discriptionLbl.setHTML(text: content, true)
            self.setData()
            self.cancelImgView.handleClick { instance in
                self.close()
            }
            self.btnOk.setButtonTitle(buttonTitle:item.get("vPageBtn") )
            self.btnOk.clickDelegate = self
        }else if (type == 2){
            
        }else if (type == 3){
            
        }
    }
    func setData(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        Configurations.setDefaultStatusBar()
        septatorView.layer.shadowOpacity = 1.0
        septatorView.layer.shadowRadius = 1
        septatorView.layer.shadowOffset = CGSizeMake(0, 2)
        septatorView.layer.shadowColor = UIColor.lightGray.cgColor
    }
    func myBtnTapped(sender: MyButton) {
        if item.get("eCatType").uppercased() == "ADDSTOP" {
            _ = OpenCatType(uv: self, navItem: self.navigationItem, item: item,addStop: true)
            return
        }
        _ = OpenCatType(uv: self, navItem: self.navigationItem, item: item)
    }
}
