

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var titleLblHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLblTopSpace: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var subTitleLblHeight: NSLayoutConstraint!
    @IBOutlet weak var subTitleLblTopSpace: NSLayoutConstraint!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var stageView1: UIView!
    @IBOutlet weak var stageImgView1: UIImageView!
    @IBOutlet weak var stageLbl1: MarqueeLabel!
    
    @IBOutlet weak var stageView2: UIView!
    @IBOutlet weak var stageImgView2: UIImageView!
    @IBOutlet weak var stageLbl2: MarqueeLabel!
    
    @IBOutlet weak var stageView3: UIView!
    @IBOutlet weak var stageImgView3: UIImageView!
    @IBOutlet weak var stageLbl3: MarqueeLabel!
    
    @IBOutlet weak var stageView4: UIView!
    @IBOutlet weak var stageImgView4: UIImageView!
    @IBOutlet weak var stageLbl4: MarqueeLabel!
    
    @IBOutlet weak var stageStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stageStackViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var stageStackView: UIStackView!
    
    
    @IBOutlet weak var buttonStackViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
  
    @IBOutlet weak var bottomButton1: UIButton!
    @IBOutlet weak var bottomButton2: UIButton!
    
    var dataDic = NSDictionary()
    var finalHeight:CGFloat = 250
    
    var urlPrifix = Bundle.main.bundleIdentifier!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        urlPrifix = urlPrifix.replacingOccurrences(of: ".CustomNotificationUI", with: "", options:
                                                    NSString.CompareOptions.literal, range: nil)
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let notificationPush = notification.request.content.userInfo["aps"] as? NSDictionary
    
        if(notificationPush != nil && notificationPush?.get("alert") != "" && notificationPush?.get("sound") != ""){
            
            if((notificationPush?["body"] as? NSDictionary) != nil){
                dataDic = notificationPush?["body"] as! NSDictionary
                
            }else if((notificationPush?["body"] as? String) != nil){
            
                let jsonData = notificationPush?["body"] as! String
                
                dataDic = jsonData.toDict()
            }
        }else{
            
            let notification = notification.request.content.userInfo
            if((notification["body"] as? NSDictionary) != nil){
                dataDic = notification["body"] as! NSDictionary
                
            }else if((notification["body"] as? String) != nil){
            
                let jsonData = notification["body"] as! String
                
                dataDic = jsonData.toDict()
            }
        }
       
        
        
        print(dataDic)
        self.setData()
        
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: self.finalHeight)

        self.view.setNeedsUpdateConstraints()
        self.view.setNeedsLayout()
        
    }
    
    func setData(){
        
        self.setTitleView()
        
        self.setSubTitleView()
        
        self.setBottomButton()
        
        self.setStagingView()
    
    }
    
    func setTitleView(){
        
        if(dataDic.get("CustomTitle") != ""){
            
            let textHeight = dataDic.get("CustomTitle").height(withConstrainedWidth: self.view.frame.size.width - 40, font: self.titleLbl.font!)
            if(textHeight > 25){
                finalHeight = finalHeight + (textHeight - 25)
            }
            self.titleLbl.text = dataDic.get("CustomTitle")
        }else{
            
            self.titleLblTopSpace.constant = 0
            self.titleLblHeight.constant = 0
            finalHeight = finalHeight - 30
        }
    
    }
    
    func setSubTitleView(){
        
        if(dataDic.get("CustomSubTitle") != ""){
            
            let textHeight = dataDic.get("CustomSubTitle").height(withConstrainedWidth: self.view.frame.size.width - 40, font: self.subTitleLbl.font!)
            if(textHeight > 20){
                finalHeight = finalHeight + (textHeight - 20)
            }
            self.subTitleLbl.text = dataDic.get("CustomSubTitle")
        }else{
            
            self.subTitleLblTopSpace.constant = 0
            self.subTitleLblTopSpace.constant = 0
            finalHeight = finalHeight - 30
        }
    }
    
    func setStagingView(){
        
        let stagingArray = dataDic.getArrObj("CustomMessage")
        
        if(stagingArray.count == 0){
            
            self.stageStackView.isHidden = true
            self.stageStackViewHeight.constant = 0
            self.stageStackViewTopSpace.constant = 0
            finalHeight = finalHeight - 150
        }
        
        self.stageView1.isHidden = true
        self.stageView2.isHidden = true
        self.stageView3.isHidden = true
        self.stageView4.isHidden = true
        
        for i in 0..<stagingArray.count{
            
            let dic = stagingArray[i] as! NSDictionary
            switch i {
            case 0:
                self.stageView1.isHidden = false
                self.stageImgView1.image = self.getImageFromIcon(icon: dic.get("icon"))
                self.stageLbl1.text = dic.get("vStatus")
                
                if (dic.get("isCurrentStatus").uppercased() == "YES"){
                    self.stageView1.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                }
                break
            case 1:
                self.stageView2.isHidden = false
                self.stageImgView2.image = self.getImageFromIcon(icon: dic.get("icon"))
                self.stageLbl2.text = dic.get("vStatus")
                if (dic.get("isCurrentStatus").uppercased() == "YES"){
                    self.stageView2.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                }
                break
            case 2:
                self.stageView3.isHidden = false
                self.stageImgView3.image = self.getImageFromIcon(icon: dic.get("icon"))
                self.stageLbl3.text = dic.get("vStatus")
                if (dic.get("isCurrentStatus").uppercased() == "YES"){
                    self.stageView3.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                }
                break
            case 3:
                self.stageView4.isHidden = false
                self.stageImgView4.image = self.getImageFromIcon(icon: dic.get("icon"))
                self.stageLbl4.text = dic.get("vStatus")
                if (dic.get("isCurrentStatus").uppercased() == "YES"){
                    self.stageView4.transform = CGAffineTransform(scaleX: 1.20, y: 1.20)
                }
                break
            default:
                break
            }
            
        }
    }
    
    func getImageFromIcon(icon:String) -> UIImage{
        
        if(icon == "Active"){
            return UIImage(named: "svg-icon-11")!
        }else if(icon == "Arriving"){
            return UIImage(named: "svg-icon-9")!
        }else if(icon == "Arrived"){
            return UIImage(named: "svg-icon-8")!
        }else if(icon == "OnGoingTrip"){
            return UIImage(named: "svg-icon-14")!
        }else if(icon == "Finished"){
            return UIImage(named: "svg-icon-13")!
        }else if(icon == "cancelled"){
            return UIImage(named: "svg-icon-12")!
        }
        
        
        // For DeliverAll
        if(icon == "Placed"){
            return UIImage(named: "svg-icon-7")!
        }else if(icon == "AcceptedStore"){
            return UIImage(named: "svg-icon-5")!
        }else if(icon == "Pickedup"){
            return UIImage(named: "svg-icon-1")!
        }else if(icon == "Delivered"){
            return UIImage(named: "svg-icon-2")!
        }else if(icon == "Cancelled" || icon == "Declined"){
            return UIImage(named: "svg-icon-6")!
        }else if(icon == "Review"){
            return UIImage(named: "svg-icon-3")!
        }else if(icon == "Billing-Cash" || icon == "Billing"){
            return UIImage(named: "svg-icon-15")!
        }else if(icon == "Billing-Card"){
            return UIImage(named: "svg-icon-4")!
        }else{
            return UIImage(named: "ic_no_icon")!
        }
        
        
    }
    
    func setBottomButton(){
        if(dataDic.get("CustomTrackDetails").uppercased() == "YES"){
            self.bottomButton1.isHidden = false
            self.bottomButton1.setTitle(dataDic.get("LBL_TRACK_ORDER"), for: .normal)
         
        }else{
            self.bottomButton1.isHidden = true
        }
        
        if(dataDic.get("CustomViewBtn").uppercased() == "YES"){
            self.bottomButton2.isHidden = false
            self.bottomButton2.setTitle(dataDic.get("LBL_VIEW_DETAILS"), for: .normal)
        }else{
            self.bottomButton2.isHidden = true
        }
        
        if(dataDic.get("CustomTrackDetails").uppercased() == "NO" && dataDic.get("CustomViewBtn").uppercased() == "NO"){
            finalHeight = finalHeight - 40
        }
    }
    
    @IBAction func bottomButton1Action(_ sender: Any) {
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://LiveTrack@DELIVERALL@\(dataDic.get("iOrderId"))" as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
        if let url = URL(string: urlStr as String)
        {
            self.extensionContext?.open(url, completionHandler: nil)
        }
    }

    @IBAction func bottomButton2Action(_ sender: Any) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
       
        if(dataDic.get("eType").uppercased() == "RIDE"){
            
            let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://ViewDetails@RIDE" as NSString
            let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
            if let url = URL(string: urlStr as String)
            {
                self.extensionContext?.open(url, completionHandler: nil)
            }
            return
        }
        
        if(dataDic.get("eType").uppercased() == "DELIVER"){
            
            let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://ViewDetails@DELIVER" as NSString
            let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
            if let url = URL(string: urlStr as String)
            {
                self.extensionContext?.open(url, completionHandler: nil)
            }
            return
        }
        
        if(dataDic.get("eType") == "Multi-Delivery"){
            
            let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://ViewDetails@Multi-Delivery@vRideNo=\(dataDic.get("vRideNo"))@iTripId=\(dataDic.get("iTripId"))@iDriverId=\(dataDic.get("iDriverId"))@driverImage=\(dataDic.get("driverImage"))@driverName=\(dataDic.get("driverName"))@driverPhone=\(dataDic.get("driverPhone"))@driverRating=\(dataDic.get("driverRating"))" as NSString
            let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
            if let url = URL(string: urlStr as String)
            {
                self.extensionContext?.open(url, completionHandler: nil)
            }
            return
        }
        
        if(dataDic.get("eType").uppercased() == "UBERX"){
            
            let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://ViewDetails@UBERX@vRideNo=\(dataDic.get("vRideNo"))@iTripId=\(dataDic.get("iTripId"))@iDriverId=\(dataDic.get("iDriverId"))@driverImage=\(dataDic.get("driverImage"))@driverName=\(dataDic.get("driverName"))@driverPhone=\(dataDic.get("driverPhone"))@driverRating=\(dataDic.get("driverRating"))" as NSString
            let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
            
            if let finalurl = URL(string: urlStr as String)
            {
                self.extensionContext?.open(finalurl, completionHandler: nil)
            }
            return
        }
        
        let url : NSString = "\(urlPrifix).OpenFromCustomNotiUI://ViewDetails@DELIVERALL@\(dataDic.get("iOrderId"))" as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString
        if let url = URL(string: urlStr as String)
        {
            self.extensionContext?.open(url, completionHandler: nil)
        }
    }
    
}

/////// ExtCode ///////////////////////////////////////////////////////////////////////////
extension UIImage {
    func setTintColor(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        color.setFill()
        
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.draw(self.cgImage!, in: rect)
        
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
}

extension String {
    func toDict() -> NSDictionary{
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let dict = [String:String]()
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                let jsonDataDict = jsonData as! NSDictionary
                
                return jsonDataDict
            }  catch {
                return dict as NSDictionary
            }
            
        } else {
            return dict as NSDictionary
        }
        
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return boundingBox.width
    }
}

extension NSDictionary{
    func get(_ key:String) -> String{
    
        let value = self.value(forKey: key)
        
        if(value != nil){
            return String(describing: value!)
        }
        
        return ""
    }
    
    func getNsStr(_ key:String) -> NSString{
        
        let value = self.value(forKey: key)
        
        if(value != nil){
            return (value as! NSString)
        }
        
        return ""
    }
    
    func getObj(_ key:String) -> NSDictionary{
        
        let value = self.value(forKey: key)
        
        if(value != nil && (value! as? NSDictionary) != nil){
            return value! as! NSDictionary
        }
        
        return self
    }
    
    func getArrObj(_ key:String) -> NSArray{
        
        let value = self.value(forKey: key)
        
        if(value != nil && (value as? NSArray) != nil){
            return value! as! NSArray
        }
        
        return [String]() as NSArray
    }
    
    func isKeyExist(_ key:String) -> Bool{
        let value = self.value(forKey: key)
        
        if(value != nil){
            return true
        }
        return false
    }
    
    func convertToJson() -> String{
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []) {
            let theJSONText = String(data: theJSONData, encoding: .utf8)
            
            return theJSONText!
        }
        
        return ""
    }

    func getFloat(_ key:String) -> Float{
        if let value = self.value(forKey: key){
            let number = Float(String(describing: value))
            if(number != nil){
                return number!
            }else{
                return 0
            }
        }
        return 0
    }
}

/////// ................... ///////////////////////////////////////////////////////////////////////////
