

import UIKit
import SysBaseLib
import Lottie

class OrderPlacedUV: ParentViewUV, MyBtnClickDelegate, ParentViewUVDelegate {

    // MARK: PROPERTIES & OUTLETS
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var orderPlacedImgeView: UIImageView!
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLbl: MyLabel!
    @IBOutlet weak var submitBtn: MyButton!
    @IBOutlet weak var submitBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var orederPlacedHintLbl: MyLabel!
    
    var cntView:UIView!
    let generalFunc = GeneralFunctions()
    var ordeIdForDirectLiveTrack = ""
    
    var userProfileJson:NSDictionary!
    
    var isOpenRestaurantDetail = "No"
    var isTakeAway = "No"
    
    var isForGenie = false
    var isFromPublishRide = false
    var isFromBookedRide = false
    var hintMsgForPublishRide = ""
   
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parentViewUVDelegate = self
    }
    
    func viewType(type: Int) {
        
        if(type == 0){
           
            // Do any additional setup after loading the view.
            
            isOpenRestaurantDetail = GeneralFunctions.getValue(key:  "CHECK_SYSTEM_STORE_SELECTION") as! String
            
            userProfileJson = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
            
            cntView = self.generalFunc.loadView(nibName: "OrderPlacedScreenDesign", uv: self, contentView: contentView) //,
            self.contentView.addSubview(cntView)
            
            if isFromPublishRide {
                self.title = self.generalFunc.getLanguageLabel(origValue: "Published Ride", key: "LBL_RIDE_SHARE_PUBLISHED_RIDE_TXT")
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "See My Ride", key: "LBL_RIDE_SHARE_SEE_MY_RIDE_TXT"))
                self.orederPlacedHintLbl.text = hintMsgForPublishRide
            }else if isFromBookedRide{
                self.title = self.generalFunc.getLanguageLabel(origValue: "Published Ride", key: "LBL_RIDE_SHARE_PUBLISHED_RIDE_TXT")
                self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "See My Ride", key: "LBL_RIDE_SHARE_SEE_MY_RIDE_TXT"))
                self.orederPlacedHintLbl.text = hintMsgForPublishRide
                self.titleLbl.text = self.generalFunc.getLanguageLabel(origValue: "Booking approved", key: "LBL_RIDE_SHARE_BOOKING_APPROVED_TXT")
            }
            else{
            self.title = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_PLACED")
            self.submitBtn.setButtonTitle(buttonTitle: self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_TRACK_YOUR_ORDER"))
                if(self.isTakeAway.uppercased() == "YES"){
                      self.orederPlacedHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_PLACE_MSG_TAKE_AWAY")
                }else{
                      self.orederPlacedHintLbl.text = self.generalFunc.getLanguageLabel(origValue: "", key: "LBL_ORDER_PLACE_MSG")
                }
            }
            
          
            //0010727: Foodx | take away | user app | order placed screen - Change texts -"Your order has placed and will be delivered soon."
            
            //self.orederPlacedHintLbl.textColor = SColors.Theme
            
            self.submitBtn.clickDelegate = self
    //        if GeneralFunctions.getSafeAreaInsets().bottom > 0
    //        {
    //            self.submitBtnHeight.constant = 50 + 30.0
    //        }
            
            self.orderPlacedImgeView.isHidden = true
            if (GeneralFunctions.isKeyExistInUserDefaults(key: Utils.SERVICE_CATEGORY_ID) == true && GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ID) as! String != "1"){
                self.orderPlacedImgeView.image = UIImage.init(named:"ic_grocery_order_placed")
            }
          
            if(isForGenie != true) && !isFromPublishRide && !isFromBookedRide{
                self.clearCart()
            }
            
            self.perofrmLoginAnimation()
            
            
        }else if(type == 1){
            
            self.configRTL()
            self.addBack()
            
        }else if(type == 2){
            self.animationView.play()
        }
    }
    
   
    func perofrmLoginAnimation(){
        
//        let jsonName = "order_placed"
//        let animationView = AnimationView.init(name: jsonName)
//
//        animationView.frame = CGRect(x: self.orderPlacedImgeView.frame.origin.x, y: self.orderPlacedImgeView.frame.origin.y, width: 300, height: 300)
          
          // 3. Set animation content mode
          
        self.animationView.contentMode = .scaleToFill
          
          // 4. Set animation loop mode
          
        self.animationView.loopMode = .playOnce
        self.animationView.play()
          // 5. Adjust animation speed
          
        //animationView.animationSpeed = 0.5
          
        
        //Application.window!.addSubview(view)
          
          // 6. Play animation
          
       // animationView.play()
        
        //return animationView
    }
    

    override func close(){
       
        if(ServiceModule.isDeliverAllOnly()) // For only DeliverAll app
        {
            let serviceCategoryArray = GeneralFunctions.getValue(key: Utils.SERVICE_CATEGORY_ARRAY) as! NSArray
            if serviceCategoryArray.count > 1
            {
                if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
                }
                
            }else
            {
                if(self.isOpenRestaurantDetail.uppercased() == "YES"){
                    self.performSegue(withIdentifier: "unwindToRestaurantDetail", sender: self)
                }else{
                    self.performSegue(withIdentifier: "unwindToDelAllUFXHomeScreen", sender: self)
                }
            }
        }else
        {
            if(userProfileJson.get("ENABLE_NEW_HOME_SCREEN_LAYOUT_APP_23").uppercased() == "YES"){
                self.performSegue(withIdentifier: "unwindToUFXProScreen", sender: self)
            }else{
                self.performSegue(withIdentifier: "unwindToUFXHomeScreen", sender: self)
            }
            
        }
        
    }
    
    func myBtnTapped(sender: MyButton) {
        
        if isFromPublishRide || isFromBookedRide {
            let myRideUV = GeneralFunctions.instantiateViewController(pageName: "MyRideTabUV") as! MyRideTabUV
            self.push(uv: myRideUV)
        }else{
        let rideOrderHistoryTabUV = GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV
        
        if(ServiceModule.isDeliverAllOnly() == false){
            
            GeneralFunctions.removeValue(key: Utils.SERVICE_CATEGORY_ID)
            rideOrderHistoryTabUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
            rideOrderHistoryTabUV.directToLiveTrack = true
            rideOrderHistoryTabUV.isDirectPush = true
            //self.push(uv: rideOrderHistoryTabUV)
            self.navigationController?.pushViewController(rideOrderHistoryTabUV, animated: true)
         
        }else{
            let ordersListUV = GeneralFunctions.instantiateViewController(pageName: "OrdersListUV") as! OrdersListUV
            ordersListUV.navItem = self.navigationItem
            ordersListUV.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
            ordersListUV.directToLiveTrack = true
            //self.push(uv: ordersListUV)
            self.navigationController?.pushViewController(ordersListUV, animated: true)
            
        }
        }
        
//        let orderListUv = (GeneralFunctions.instantiateViewController(pageName: "RideOrderHistoryTabUV") as! RideOrderHistoryTabUV)
//        orderListUv.ordeIdForDirectLiveTrack = self.ordeIdForDirectLiveTrack
//        orderListUv.directToLiveTrack = true
//        orderListUv.isDirectPush = true
//
//        self.navigationController?.pushViewController(orderListUv, animated: false)
    }
    
    func clearCart()
    {
        let cartItemsArray = (GeneralFunctions.getValue(key: Utils.CART_INFO_DATA) as! NSArray).mutableCopy() as! NSMutableArray
        cartItemsArray.removeAllObjects()
        GeneralFunctions.saveValue(key: Utils.CART_INFO_DATA, value: cartItemsArray as AnyObject)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
