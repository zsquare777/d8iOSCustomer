

import UIKit

class GetFeatureClassList: NSObject {

    static func getAllGeneralClasses() -> [String:String]{
    

        
/*************         APPLE WATCH SERVICE     **************/
        
        let AppleWatchModule = NSMutableDictionary()
        AppleWatchModule["APPLE_WATCH_MODULE"] = "No"
        
        let watchClassList = NSMutableArray() // Class List
        watchClassList.add("GeneralFiles/Apple_Watch.swift")
        AppleWatchModule["classNameList"] = watchClassList
        for value in watchClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    AppleWatchModule["APPLE_WATCH_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let watchXibList = NSMutableArray()    // Xib List
        AppleWatchModule["xibList"] = watchXibList
        
        
/*************         VOIP SERVICE     **************/
        let VoipModule = NSMutableDictionary()
        VoipModule["VOIP_SERVICE"] = "No"
        
        var checkPodExsists = false
        let voipClassList = NSMutableArray()      // Class List
        voipClassList.add("SINLocalNotification.h")
        voipClassList.add("Screens/SinchCallingUV.swift")
        voipClassList.add("GeneralFiles/SinchCalling.swift")
        for value in voipClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    
                    if(String(substring) == "SINLocalNotification"){
                        checkPodExsists = true
                    }
                    VoipModule["VOIP_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        if(checkPodExsists == true){
            voipClassList.add("Remove From Pod")
        }
        VoipModule["classNameList"] = voipClassList
        
        
        let voipXibList = NSMutableArray()     // Xib List
        voipXibList.add("ScreenDesigns/SinchCallingScreenDesign.xib")
        VoipModule["xibList"] = voipXibList
        for value in voipXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    VoipModule["VOIP_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        
/*************         BIDDING SERVICE     **************/
        let BiddingModule = NSMutableDictionary()
        BiddingModule["BID_SERVICE"] = "No"
        
        
        let biddingClassList = NSMutableArray() // Class List
        biddingClassList.add("Screens/BiddingDetialsUV.swift")
        biddingClassList.add("Screens/BiddingHistoryUV.swift")
        biddingClassList.add("Screens/BidInfromationUV.swift")
        biddingClassList.add("Cells/BiddingDriverListTVC.swift")
        biddingClassList.add("Cells/BiddingHistoryTVCell.swift")
        BiddingModule["classNameList"] = biddingClassList
        for value in biddingClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    BiddingModule["BID_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        let biddingXibList = NSMutableArray()     // Xib List
        biddingXibList.add("ScreenDesigns/BiddingHistoryScreenDesign.xib")
        biddingXibList.add("ScreenDesigns/BidInfromationScreenDesign.xib")
        biddingXibList.add("ScreenDesigns/BiddingDetialsScreenDesign.xib")
        biddingXibList.add("CellDesign/BiddingDriverListTVC.xib")
        biddingXibList.add("CellDesign/BiddingHistoryTVCell.xib")
        BiddingModule["xibList"] = biddingXibList
        for value in biddingXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    BiddingModule["BID_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
/*************         ADVERTISEMENT     **************/
        let AdvertisementModule = NSMutableDictionary()
        AdvertisementModule["ADVERTISEMENT_MODULE"] = "No"
        
        let advertisementClassList = NSMutableArray() // Class List
        advertisementClassList.add("CustomViewFiles/AdvertisementView.swift")
        AdvertisementModule["classNameList"] = advertisementClassList
        for value in advertisementClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    AdvertisementModule["ADVERTISEMENT_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let advertisementXibList = NSMutableArray()     // Xib List
        advertisementXibList.add("CustomViewDesigns/AdvertisementView.xib")
        AdvertisementModule["xibList"] = advertisementXibList
        for value in advertisementXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    AdvertisementModule["ADVERTISEMENT_MODULE"] = "Yes"
                    break
                }
            }
        }
        
/*************         Live Chat     **************/
        let LiveChatModule = NSMutableDictionary()
        LiveChatModule["LIVE_CHAT"] = "No"
        
        let livechatClassList = NSMutableArray() // Class List
        livechatClassList.add("ExternalLibraries/Frameworks/LiveChatSource.framework")
        LiveChatModule["classNameList"] = livechatClassList
        for value in livechatClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    LiveChatModule["LIVE_CHAT"] = "Yes"
                    break
                }
            }
        }
        
        let livechatXibList = NSMutableArray()    // Xib List
        LiveChatModule["xibList"] = livechatXibList
        

/*************         CARD IO     **************/
        let CardIOModule = NSMutableDictionary()
        CardIOModule["CARD_IO"] = "No"
        
        let cardIoClassList = NSMutableArray() // Class List
        cardIoClassList.add("CardIOCreditCardInfo.h")
        CardIOModule["classNameList"] = cardIoClassList
        for value in cardIoClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    CardIOModule["CARD_IO"] = "Yes"
                    break
                }
            }
        }
        
        let cardIoXibList = NSMutableArray()    // Xib List
        CardIOModule["xibList"] = cardIoXibList
        
        
/*************         LINKEDIN MODULE     **************/
        let LinkedinModule = NSMutableDictionary()
        LinkedinModule["LINKEDIN_MODULE"] = "No"
        
        let linkedinClassList = NSMutableArray() // Class List
        linkedinClassList.add("GeneralFiles/OpenLinkedinLogin.swift")
        LinkedinModule["classNameList"] = linkedinClassList
        for value in linkedinClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    LinkedinModule["LINKEDIN_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let linkedinXibList = NSMutableArray()    // Xib List
        LinkedinModule["xibList"] = linkedinXibList
        
     

/*************         POOL MODULE     **************/
        let PoolModule = NSMutableDictionary()
        PoolModule["POOL_MODULE"] = "No"
        
        let poolClassList = NSMutableArray() // Class List
        poolClassList.add("Cells/PoolSeatsTVCell.swift")
        PoolModule["classNameList"] = poolClassList
        for value in poolClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    PoolModule["POOL_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let poolXibList = NSMutableArray()     // Xib List
        poolXibList.add("CellDesign/PoolSeatsTVCell.xib")
        PoolModule["xibList"] = poolXibList
        for value in poolXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    PoolModule["POOL_MODULE"] = "Yes"
                    break
                }
            }
        }
        

/*************         MULTI DELIVERY     **************/
        let MultiDeliveryModule = NSMutableDictionary()
        MultiDeliveryModule["MULTI_DELIVERY"] = "No"
        
        let multiDelClassList = NSMutableArray() // Class List
        multiDelClassList.add("Screens/MultiDeliveryDetailsUV.swift")
        multiDelClassList.add("Screens/MultiDeliveryOptionsUV.swift")
        multiDelClassList.add("Screens/DeliveryDetailsListUV.swift")
        multiDelClassList.add("Screens/RideMultiDetailUV.swift")
        multiDelClassList.add("Screens/AskForPay.swift")
        multiDelClassList.add("Cells/DeliveryDetailsListTVCell.swift")
        
        MultiDeliveryModule["classNameList"] = multiDelClassList
        for value in multiDelClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    MultiDeliveryModule["MULTI_DELIVERY"] = "Yes"
                    break
                }
            }
        }
        
        let multiDelXibList = NSMutableArray()     // Xib List
        multiDelXibList.add("ScreenDesigns/AskForPayScreenDesign.xib")
        multiDelXibList.add("ScreenDesigns/MultiDeliveryDetailsScreenDesign.xib")
        multiDelXibList.add("ScreenDesigns/MultiDeliveryOptionsScreenDesign.xib")
        multiDelXibList.add("ScreenDesigns/RideMultiDetailScreenDesign.xib")
        multiDelXibList.add("CellDesign/DeliveryDetailsListTVCell.xib")
        multiDelXibList.add("CustomViewDesigns/OutStandingAmtViewForMultiDelivery.xib")
        multiDelXibList.add("CustomViewDesigns/EnterPromoCodeForMultiDelView.xib")
        
        MultiDeliveryModule["xibList"] = multiDelXibList
        for value in multiDelXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    MultiDeliveryModule["MULTI_DELIVERY"] = "Yes"
                    break
                }
            }
        }
        
 
/*************         DELIVERY MODULE     **************/
        let DeliveryModule = NSMutableDictionary()
        DeliveryModule["DELIVERY_MODULE"] = "No"
        
        let deliveryClassList = NSMutableArray() // Class List
        deliveryClassList.add("Screens/DeliveryDetailsUV.swift")
        DeliveryModule["classNameList"] = deliveryClassList
        for value in deliveryClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    DeliveryModule["DELIVERY_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let deliveryXibList = NSMutableArray()     // Xib List
        deliveryXibList.add("ScreenDesigns/DeliveryDetailsScreenDesign.xib")
        DeliveryModule["xibList"] = deliveryXibList
        for value in deliveryXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    DeliveryModule["DELIVERY_MODULE"] = "Yes"
                    break
                }
            }
        }
        
/*************        COMMON DELIVERY MODULE     **************/
        let CommonDelModule = NSMutableDictionary()
        CommonDelModule["COMMON_DELIVERY_TYPE_SECTION"] = "No"
        
        var commonDelClassList = NSMutableArray() // Class List
        commonDelClassList.add("Screens/MoreDeliveriesUV.swift")
        commonDelClassList.add("Cells/MoreDeliveriesCVC.swift")
        commonDelClassList.add("Cells/MoreDeliveriesTVC.swift")
        commonDelClassList.add("GeneralFiles/OpenCatType.swift")
        
        let tempCommonDelClassList = NSMutableArray.init(array: commonDelClassList)
        
        for value in commonDelClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    CommonDelModule["COMMON_DELIVERY_TYPE_SECTION"] = "Yes"
                }else{
                    tempCommonDelClassList.remove(value)
                }
            }
        }
        
        commonDelClassList.removeAllObjects()
        commonDelClassList = tempCommonDelClassList
        CommonDelModule["classNameList"] = commonDelClassList
        
        var commonDelXibList = NSMutableArray()     // Xib List
        commonDelXibList.add("ScreenDesigns/MoreDeliveriesScreenDesign.xib")
        commonDelXibList.add("CellDesign/MoreDeliveriesCVC.xib")
        commonDelXibList.add("CellDesign/MoreDeliveriesTVC.xib")
        
        let tempCommonDelXibList = NSMutableArray.init(array: commonDelXibList)
        
        for value in commonDelXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    CommonDelModule["COMMON_DELIVERY_TYPE_SECTION"] = "Yes"
                    
                }else{
                    tempCommonDelXibList.remove(value)
                }
            }
        }
        
        commonDelXibList.removeAllObjects()
        commonDelXibList = tempCommonDelXibList
        CommonDelModule["xibList"] = commonDelXibList
        
        
/*************         NEWS SECTION     **************/
        let NewsSectionModule = NSMutableDictionary()
        NewsSectionModule["NEWS_SECTION"] = "No"
        
        let newsClassList = NSMutableArray() // Class List
        newsClassList.add("Screens/NotificationsTabUV.swift")
        newsClassList.add("Screens/NotificationDetailUV.swift")
        newsClassList.add("Screens/NotificationsUV.swift")
        newsClassList.add("Cells/NotificationTVCell.swift")
        NewsSectionModule["classNameList"] = newsClassList
        for value in newsClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    NewsSectionModule["NEWS_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let newsXibList = NSMutableArray()     // Xib List
        newsXibList.add("ScreenDesigns/NotificationDetailScreenDesign.xib")
        newsXibList.add("ScreenDesigns/NotificationsScreenDesign.xib")
        newsXibList.add("CellDesign/NotificationTVCell.xib")
        NewsSectionModule["xibList"] = newsXibList
        for value in newsXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    NewsSectionModule["NEWS_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        
/*************         BOOKFORSOMEONEELSE SECTION     **************/
        
        let BSModule = NSMutableDictionary()
        BSModule["BOOK_FOR_ELSE_SECTION"] = "No"
        
        let bsClassList = NSMutableArray() // Class List
        bsClassList.add("Cells/BSListTVCell.swift")
        BSModule["classNameList"] = bsClassList
        for value in bsClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    BSModule["BOOK_FOR_ELSE_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let bsXibList = NSMutableArray()     // Xib List
        bsXibList.add("CellDesign/BSListTVCell.xib")
        BSModule["xibList"] = bsXibList
        for value in bsXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    BSModule["BOOK_FOR_ELSE_SECTION"] = "Yes"
                    break
                }
            }
        }
        
/*************         FAVDRIVER SECTION      **************/
        
        let FavDriverModule = NSMutableDictionary()
        FavDriverModule["FAV_DRIVER_SECTION"] = "No"
        
        let favDriverClassList = NSMutableArray() // Class List
        favDriverClassList.add("Screens/FavDriversTabUV.swift")
        favDriverClassList.add("Screens/FavDriversUV.swift")
        favDriverClassList.add("Cells/FavDriversTVCell.swift")
        FavDriverModule["classNameList"] = favDriverClassList
        for value in favDriverClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    FavDriverModule["FAV_DRIVER_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let favDriverXibList = NSMutableArray()     // Xib List
        favDriverXibList.add("CellDesign/FavDriversTVCell.xib")
        favDriverXibList.add("ScreenDesigns/FavDriversScreenDesign.xib")
        FavDriverModule["xibList"] = favDriverXibList
        for value in favDriverXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    FavDriverModule["FAV_DRIVER_SECTION"] = "Yes"
                    break
                }
            }
        }
        
/*************         DONATION SECTION      **************/
        
        let DonationModule = NSMutableDictionary()
        DonationModule["DONATION_SECTION"] = "No"
        
        let donationClassList = NSMutableArray() // Class List
        donationClassList.add("Screens/DonationUV.swift")
        donationClassList.add("Cells/DonationTVCell.swift")
        DonationModule["classNameList"] = donationClassList
        for value in donationClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    DonationModule["DONATION_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let donationXibList = NSMutableArray()     // Xib List
        donationXibList.add("CellDesign/DonationTVCell.xib")
        donationXibList.add("ScreenDesigns/DonationScreenDesign.xib")
        DonationModule["xibList"] = donationXibList
        for value in donationXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    DonationModule["DONATION_SECTION"] = "Yes"
                    break
                }
            }
        }
        
/*************         UFXGenarlModule      **************/
        

        let UFXGenarlModule = NSMutableDictionary()
        UFXGenarlModule["UBERX_GENERAL_SERVICE"] = "No"
        
        let ufxGenarlClassList = NSMutableArray() // Class List
        ufxGenarlClassList.add("Screens/UFXHomeUV.swift")
        ufxGenarlClassList.add("CustomViewFiles/SDragViewForMoreServices.swift")
        UFXGenarlModule["classNameList"] = ufxGenarlClassList
        for value in ufxGenarlClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    UFXGenarlModule["UBERX_GENERAL_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        let ufxGenarlXibList = NSMutableArray()     // Xib List
        ufxGenarlXibList.add("ScreenDesigns/UFXHomeScreenDesign.xib")
        UFXGenarlModule["xibList"] = ufxGenarlXibList
        for value in ufxGenarlXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    UFXGenarlModule["UBERX_GENERAL_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
/*************         DELIVER_ALL_GENERAL      **************/
        
        
        let DelAllGenarlModule = NSMutableDictionary()
        DelAllGenarlModule["DELIVER_ALL_GENERAL"] = "No"
        
        let delAllGenClassList = NSMutableArray() // Class List
        delAllGenClassList.add("Cells/DeliverAll/PrescriptionGalleryCVC.swift")
        delAllGenClassList.add("Screens/DeliverAll/PrescriptionUV.swift")
        DelAllGenarlModule["classNameList"] = delAllGenClassList
        for value in delAllGenClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    DelAllGenarlModule["DELIVER_ALL_GENERAL"] = "Yes"
                    break
                }
            }
        }
        
        let delAllGenXibList = NSMutableArray()     // Xib List
        delAllGenXibList.add("CellDesign/DeliverAll/PrescriptionGalleryCVC.xib")
        delAllGenXibList.add("ScreenDesigns/DeliverAll/PrescriptionScreenDesign.xib")
        DelAllGenarlModule["xibList"] = delAllGenXibList
        for value in delAllGenXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    DelAllGenarlModule["DELIVER_ALL_GENERAL"] = "Yes"
                    break
                }
            }
        }
        
/*************         BUSINESS PROFILE FEATURE     **************/
        let BusinessProfModule = NSMutableDictionary()
        BusinessProfModule["BUSINESS_PROFILE_FEATURE"] = "No"
        
        let businProClassList = NSMutableArray() // Class List
        businProClassList.add("Screens/BusinessEmailSetUpUV.swift")
        businProClassList.add("Screens/BusinessProfileUV.swift")
        businProClassList.add("Screens/BusinessSummaryUV.swift")
        businProClassList.add("Screens/WelcomeBusinessProfileUV.swift")
        businProClassList.add("Screens/ListBusinessProfilesUV.swift")
        businProClassList.add("Screens/ListOrganizationUV.swift")
        businProClassList.add("Screens/SelectOrganizationUV.swift")
        businProClassList.add("Cells/ListBusinessProfilesTVC.swift")
        businProClassList.add("Cells/ListOrganizationTVC.swift")
        
        BusinessProfModule["classNameList"] = businProClassList
        for value in businProClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    BusinessProfModule["BUSINESS_PROFILE_FEATURE"] = "Yes"
                    break
                }
            }
        }
        
        let businProXibList = NSMutableArray()     // Xib List
        businProXibList.add("ScreenDesigns/BusinessEmailSetUpScreenDesign.xib")
        businProXibList.add("ScreenDesigns/BusinessSummaryScreenDesign.xib")
        businProXibList.add("ScreenDesigns/WelcomeBusinessProfileScreenDesign.xib")
        businProXibList.add("ScreenDesigns/ListBusinessProfilesScreenDesign.xib")
        businProXibList.add("ScreenDesigns/ListOrganizationScreenDesign.xib")
        businProXibList.add("ScreenDesigns/SelectOrganizationScreenDesign.xib")
        businProXibList.add("CellDesign/ListBusinessProfilesTVC.xib")
        businProXibList.add("CellDesign/ListOrganizationTVC.xib")
        
        BusinessProfModule["xibList"] = businProXibList
        for value in businProXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    BusinessProfModule["BUSINESS_PROFILE_FEATURE"] = "Yes"
                    break
                }
            }
        }
        
        
/*************         RENTAL FEATURE    **************/
        let RentalModule = NSMutableDictionary()
        RentalModule["RENTAL_FEATURE"] = "No"
        
        let rentalClassList = NSMutableArray() // Class List
        rentalClassList.add("Screens/RentalFareDetailsUV.swift")
        rentalClassList.add("Screens/RentalPackageDetailsUV.swift")
        RentalModule["classNameList"] = rentalClassList
        for value in rentalClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    RentalModule["RENTAL_FEATURE"] = "Yes"
                    break
                }
            }
        }
        
        let rentalXibList = NSMutableArray()     // Xib List
        rentalXibList.add("ScreenDesigns/RentalFareDetailsScreenDesign.xib")
        rentalXibList.add("ScreenDesigns/RentalPackageDetailsScreenDesign.xib")
        rentalXibList.add("CustomViewDesigns/PackageDataItemView.xib")
        RentalModule["xibList"] = rentalXibList
        for value in rentalXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    RentalModule["RENTAL_FEATURE"] = "Yes"
                    break
                }
            }
        }
 

/*************         RDU SECTION    **************/
        let RDUModule = NSMutableDictionary()
        RDUModule["RDU_SECTION"] = "No"
        
        let RDUClassList = NSMutableArray() // Class List
        RDUClassList.add("Screens/MainScreenUV.swift")
        RDUClassList.add("Screens/FareBreakDownUV.swift")
        RDUClassList.add("Screens/RideDetailUV.swift")
        RDUClassList.add("Screens/RideHistoryUV.swift")
        RDUClassList.add("Screens/RideHistoryTabUV.swift")
        RDUClassList.add("Screens/RatingUV.swift")
        RDUClassList.add("Cells/RideHistoryTVCell.swift")
        RDUClassList.add("Cells/CabTypeCVCell.swift")
        RDUClassList.add("Cells/UFXJekIconCVC.swift")
        RDUClassList.add("Cells/UFXJekIconTVC.swift")
        RDUClassList.add("CustomViewFiles/RideDeliveryOptionView.swift")
        RDUClassList.add("CustomViewFiles/SurgePriceView.swift")
        RDUClassList.add("CustomViewFiles/PreferencesOptionView.swift")
        RDUClassList.add("CustomViewFiles/CancelBookingView.swift")
        RDUClassList.add("CustomViewFiles/ProviderDetailView.swift")
        RDUClassList.add("CustomViewFiles/OutStandingAmtView.swift")
        RDUClassList.add("CustomViewFiles/FareDetailView.swift")
        RDUClassList.add("CustomViewFiles/TollDesignView.swift")
        RDUClassList.add("CustomViewFiles/ProviderDetailMarkerView.swift")
        RDUClassList.add("GeneralFiles/OpenCancelBooking.swift")
        RDUClassList.add("GeneralFiles/OpenCancelBooking.swift")
        RDUClassList.add("GeneralFiles/OpenOutStandingView.swift")
        RDUClassList.add("GeneralFiles/OpenTollBox.swift")
        RDUClassList.add("GeneralFiles/OpenSurgePriceView.swift")
        RDUClassList.add("GeneralFiles/OpenBookingFinishedView.swift")
        RDUClassList.add("GeneralFiles/LoadAvailableCab.swift")
        RDUClassList.add("GeneralFiles/OpenPrefOptionsView.swift")
        RDUClassList.add("CustomViewFiles/AddressContainerView.swift")
        
        RDUModule["classNameList"] = RDUClassList
        for value in RDUClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    RDUModule["RDU_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let RDUXibList = NSMutableArray()     // Xib List
        RDUXibList.add("ScreenDesigns/MainScreenDesign.xib")
        RDUXibList.add("ScreenDesigns/FareBreakDownScreenDesign.xib")
        RDUXibList.add("ScreenDesigns/RideDetailScreenDesign.xib")
        RDUXibList.add("ScreenDesigns/RideHistoryScreenDesign.xib")
        RDUXibList.add("ScreenDesigns/RatingScreenDesign.xib")
        RDUXibList.add("CellDesign/RideHistoryTVCell.xib")
        RDUXibList.add("CellDesign/CabTypeCVCell.xib")
        RDUXibList.add("CellDesign/UFXJekIconCVC.xib")
        RDUXibList.add("CellDesign/UFXJekIconTVC.xib")
        RDUXibList.add("CustomViewDesigns/RideDeliveryOptionView.xib")
        RDUXibList.add("CustomViewDesigns/SurgePriceView.xib")
        RDUXibList.add("CustomViewDesigns/PreferencesOptionView.xib")
        RDUXibList.add("CustomViewDesigns/CancelBookingView.xib")
        RDUXibList.add("CustomViewDesigns/OutStandingAmtView.xib")
        RDUXibList.add("CustomViewDesigns/FareDetailView.xib")
        RDUXibList.add("CustomViewDesigns/TollDesignView.xib")
        RDUXibList.add("CustomViewDesigns/GiveTipView.xib")
        RDUXibList.add("CustomViewDesigns/SignatureDisplayView.xib")
        RDUXibList.add("CustomViewDesigns/ASkForPaySelView.xib")
        RDUXibList.add("CustomViewDesigns/EnterTipView.xib")
        RDUXibList.add("CustomViewDesigns/ConfirmCardViewForDelivery.xib")
        RDUXibList.add("CustomViewDesigns/DriverDetailView.xib")
        RDUXibList.add("CustomViewDesigns/RequestCabView.xib")
        RDUXibList.add("CustomViewDesigns/AddressContainerView.xib")
        
        RDUModule["xibList"] = RDUXibList
        for value in RDUXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    RDUModule["RDU_SECTION"] = "Yes"
                    break
                }
            }
        }
        
/*************         ONGOING JOB SECTION    **************/
        
        let OngoingModule = NSMutableDictionary()
        OngoingModule["ON_GOING_JOB_SECTION"] = "No"
        
        let ongoingClassList = NSMutableArray() // Class List
        ongoingClassList.add("Screens/MyOnGoingTripsUV.swift")
        ongoingClassList.add("Screens/MyOnGoingTripDetailsUV.swift")
        ongoingClassList.add("Cells/MyOnGoingTripDetailsTVCell.swift")
        ongoingClassList.add("Cells/MyOnGoingTripsListTVCell.swift")
        OngoingModule["classNameList"] = ongoingClassList
        for value in ongoingClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    OngoingModule["ON_GOING_JOB_SECTION"] = "Yes"
                    break
                }
            }
        }
        
        let ongoingXibList = NSMutableArray()     // Xib List
        ongoingXibList.add("ScreenDesigns/MyOnGoingTripDetailsScreenDesign.xib")
        ongoingXibList.add("ScreenDesigns/MyOnGoingTripsScreenDesign.xib")
        ongoingXibList.add("CellDesign/MyOnGoingTripDetailsTVCell.xib")
        ongoingXibList.add("CellDesign/MyOnGoingTripsListTVCell.xib")
        OngoingModule["xibList"] = ongoingXibList
        for value in ongoingXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    OngoingModule["ON_GOING_JOB_SECTION"] = "Yes"
                    break
                }
            }
        }
        
/*************         UBERX SERVICE     **************/
        let uberXModule = NSMutableDictionary()
        uberXModule["UBERX_SERVICE"] = "No"
        
        let uberXClassList = NSMutableArray() // Class List
        
        uberXClassList.add("Screens/UFXConfirmBookingDetailsUV.swift")
        uberXClassList.add("Screens/UFXConfirmServiceUV.swift")
        uberXClassList.add("Screens/UFXSelectPaymentModeUV.swift")
        uberXClassList.add("Screens/UFXSelectServiceUV.swift")
        uberXClassList.add("Screens/UFXServiceSelectUV.swift")
        uberXClassList.add("Screens/UFXFilterServicesUV.swift")
        uberXClassList.add("Screens/UFXProviderInfoTabUV.swift")
        uberXClassList.add("Screens/UFXProviderServicesUV.swift")
        uberXClassList.add("Screens/UFXProviderGalleryUV.swift")
        uberXClassList.add("Screens/UFXProviderReviewsUV.swift")
        uberXClassList.add("Screens/UFXCartUV.swift")
        uberXClassList.add("Screens/UFXCheckOutUV.swift")
        uberXClassList.add("Screens/UFXProviderInfoUV.swift")
        uberXClassList.add("Screens/ChooseServiceDateUV.swift")
        uberXClassList.add("Screens/UFXProviderViewMoreServicesUV.swift")
        uberXClassList.add("Cells/UFXReqServicesTVCell.swift")
        uberXClassList.add("Cells/JobDateSelectionCVCell.swift")
        uberXClassList.add("Cells/JobTimeSelectionCVCell.swift")
        uberXClassList.add("Cells/UFXProviderListTVCell.swift")
        uberXClassList.add("Cells/UFXServiceSelectTVCell.swift")
        uberXClassList.add("Cells/UFXProviderServicesTVCell.swift")
        uberXClassList.add("Cells/UFXProviderGalleryCVC.swift")
        uberXClassList.add("Cells/UFXProviderReviewsTVCell.swift")
        uberXClassList.add("CustomViewFiles/UFXNoProviderView.swift")
        uberXClassList.add("CustomViewFiles/UfxSelectServiceItemDesignView.swift")
        uberXClassList.add("CustomViewFiles/UFXCheckOutItemView.swift")
        uberXClassList.add("GeneralFiles/OpenProviderDetailView.swift")
        
        
        uberXModule["classNameList"] = uberXClassList
        for value in uberXClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    uberXModule["UBERX_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        let uberXXibList = NSMutableArray()     // Xib List
        
        uberXXibList.add("ScreenDesigns/UFXProviderViewMoreServicesScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXConfirmBookingDetailsScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXConfirmServiceScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXSelectPaymentModeScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXSelectServiceScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXServiceSelectScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXFilterServicesScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXProviderServicesScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXProviderGalleryScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXProviderReviewsScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXCartScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXCheckOutScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/UFXProviderInfoScreenDesign.xib")
        uberXXibList.add("ScreenDesigns/ChooseServiceDateScreenDesign.xib")
        uberXXibList.add("CellDesign/UFXReqServicesTVCell.xib")
        uberXXibList.add("CellDesign/JobDateSelectionCVCell.xib")
        uberXXibList.add("CellDesign/JobTimeSelectionCVCell.xib")
        uberXXibList.add("CellDesign/UFXProviderListTVCell.xib")
        uberXXibList.add("CellDesign/UFXServiceSelectTVCell.xib")
        uberXXibList.add("CellDesign/UFXProviderServicesTVCell.xib")
        uberXXibList.add("CellDesign/UFXProviderGalleryCVC.xib")
        uberXXibList.add("CellDesign/UFXProviderReviewsTVCell.xib")
        uberXXibList.add("CustomViewDesigns/ProviderDetailMarkerView.xib")
        uberXXibList.add("CustomViewDesigns/ProviderDetailView.xib")
        uberXXibList.add("CustomViewDesigns/ProviderMapMarkerView.xib")
        uberXXibList.add("CustomViewDesigns/UfxCategoryHorizontalStackViewDesign.xib")
        uberXXibList.add("CustomViewDesigns/UFXConfirmCardView.xib")
        uberXXibList.add("CustomViewDesigns/UFXNoProviderView.xib")
        uberXXibList.add("CustomViewDesigns/UfxParentCategoryItemDesign.xib")
        uberXXibList.add("CustomViewDesigns/UfxSelectServiceItemDesignView.xib")
        uberXXibList.add("CustomViewDesigns/UFXServiceSelectHeaderView.xib")
        uberXXibList.add("CustomViewDesigns/UfxSubCategoryDesignItem.xib")
        uberXXibList.add("CustomViewDesigns/UFXCheckOutItemView.xib")
        uberXXibList.add("CustomViewDesigns/UFXProviderRequestCabView.xib")
        
        
        
        uberXModule["xibList"] = uberXXibList
        for value in uberXXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    uberXModule["UBERX_SERVICE"] = "Yes"
                    break
                }
            }
        }
     
        
/*************         DeliverAll MODULE     **************/
        let DeliverAllModule = NSMutableDictionary()
        DeliverAllModule["DELIVER_ALL"] = "No"

        let deliverAllClassList = NSMutableArray() // Class List
        
        deliverAllClassList.add("Screens/DeliverAll/ViewDeliveryPreferencesUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/RestaurantSearchOldUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/ItemSearchTabUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/AddToCartUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/CartUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/CheckOutUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/DelAllUFXHomeUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/DeliveryAllUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/FoodItemSearchUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/FoodPreferencesUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/FoodRatingUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/LiveTrackUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/OrderDetailsUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/OrderPlacedUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/OrdersListUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/RestaurantDetailsUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/RestaurantSearchDetailUV.swift")
        deliverAllClassList.add("Screens/DeliverAll/RestaurantSearchUV.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/CartOptionView.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/CartOptionViewForCart.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/CartToppingView.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/CartToppingViewForCart.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/CheckOutItemView.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/RestaurantFoodItemview.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/SDragViewForFilter.swift")
        deliverAllClassList.add("Cells/DeliverAll/CartTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/CusineTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/DeliveryAllCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/FoodItemMenuTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/FoodItemSearchTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/LiveTrackStatusTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/OrderListTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailHeaderCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailItemCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailRecommendedCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailSectionCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantsFilterTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantsListCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RecomandeditemCVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/DeliveryPreferencesTVcell.swift")
        deliverAllClassList.add("Cells/DeliverAll/CuisinesCVC.swift")
        deliverAllClassList.add("Cells/DeliverAll/CategoryListTVCell.swift")
        deliverAllClassList.add("Cells/DeliverAll/RestaurantDetailItemTVCell.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/TipLiveTrackView.swift")
        deliverAllClassList.add("CustomViewFiles/DeliverAll/WhoDetailView.swift")
    
        
        DeliverAllModule["classNameList"] = deliverAllClassList
        for value in deliverAllClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    DeliverAllModule["DELIVER_ALL"] = "Yes"
                    break
                }
            }
        }

        let deliverAllXibList = NSMutableArray()     // Xib List
        
        deliverAllXibList.add("ScreenDesigns/DeliverAll/ViewDeliveryPreferencesDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/RestaurantSearchOldScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/AddToCartScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/AddToCartScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/CartScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/CheckOutScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/DelAllUFXHomeScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/DelAllWayBillScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/DeliveryAllScrennDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/FoodItemSearchScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/FoodPreferencesScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/FoodRatingScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/LiveTrackScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/OrderDetailsScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/OrderPlacedScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/OrdersListScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/RestaSearchDetailScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/RestaurantDetailsScreenDesign.xib")
        deliverAllXibList.add("ScreenDesigns/DeliverAll/RestaurantSearchScreenDesign.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/CartOptionView.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/CartOptionViewForCart.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/CartToppingView.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/CartToppingViewForCart.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/CheckOutItemView.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/ConfirmCardViewForDeliveryAll.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/RestaurantFoodItemView.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/CartTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/CusineTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/DeliveryAllCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/FoodItemMenuTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/FoodItemSearchTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/LiveTrackStatusTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/OrderListTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailHeaderCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailItemCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailRecommendedCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailSectionCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantsFilterTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantsListCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RecomandeditemCVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/DeliveryPreferencesTVcell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/CuisinesCVC.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/CategoryListTVCell.xib")
        deliverAllXibList.add("CellDesign/DeliverAll/RestaurantDetailItemTVCell.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/TipLiveTrackView.xib")
        deliverAllXibList.add("CustomViewDesigns/DeliverAll/WhoDetailView.xib")
        
        DeliverAllModule["xibList"] = deliverAllXibList
        for value in deliverAllXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    DeliverAllModule["DELIVER_ALL"] = "Yes"
                    break
                }
            }
        }
        
        
        
        /*************         RENT ITEM SERVICE     **************/
        let RentItemModule = NSMutableDictionary()
        RentItemModule["RENT_ITEM_SERVICE"] = "No"
        
        
        let rentItemClassList = NSMutableArray() // Class List
        
        rentItemClassList.add("RentItemFiles/Screens/RentItemContactInfo.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentItemDetailsUV.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentitemFilterUV.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentItemHomeUV.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentItemListUV.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentItemNewPostUV.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentSendInquiryUv.swift")
        rentItemClassList.add("RentItemFiles/Screens/RentUserInfoUV.swift")
        rentItemClassList.add("RentItemFiles/Cells/CategoryHeaderViewRent.swift")
        rentItemClassList.add("RentItemFiles/Cells/PaymentPlanCVC.swift")
        rentItemClassList.add("RentItemFiles/Cells/PaymentStepTVC.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentCategoryListTVCell.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentIconCVC.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentItemListCVCell.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentItemListTVC.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentItemListTVC2.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentItemOwnerItemTVC.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentSteeperCVCell.swift")
        rentItemClassList.add("RentItemFiles/Cells/RentSubCatTVCell.swift")
        rentItemClassList.add("RentItemFiles/Cells/StepPhotosCVCell.swift")
        rentItemClassList.add("RentItemFiles/Cells/UploadImageCVC.swift")
        rentItemClassList.add("Cells/RentCuisinesCVC.swift")
        RentItemModule["classNameList"] = rentItemClassList
        
        
        
        for value in rentItemClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    RentItemModule["RENT_ITEM_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        let rentItemXibList = NSMutableArray()     // Xib List
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentItemContactInfo.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentItemDetailsUV.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentitemFilterScreenDesign.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentItemHomeScreenDesign.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentItemListScreenDesignUV.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentSendInqiuryScreenDesign.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentItemNewPostScreenDesign.xib")
        rentItemXibList.add("RentItemFiles/ScreenDesigns/RentSendInquiryUv.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/CategoryHeaderViewRent.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/PaymentPlanCVC.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/PaymentStepTVC.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentCategoryListTVCell.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentIconCVC.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentItemListCVCell.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentItemListTVC.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentItemListTVC2.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentItemOwnerItemTVC.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentSteeperCVCell.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/RentSubCatTVCell.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/StepPhotosCVCell.xib")
        rentItemXibList.add("RentItemFiles/CellDesign/UploadImageCVC.xib")
        rentItemClassList.add("CellDesign/RentCuisinesCVC.xib")
        RentItemModule["xibList"] = rentItemXibList
        for value in rentItemXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    RentItemModule["RENT_ITEM_SERVICE"] = "Yes"
                    break
                }
            }
        }
        
        /*************         NEARBY SERVICE     **************/
        let NearByModule = NSMutableDictionary()
        NearByModule["NEARBY_MODULE"] = "No"
        
        
        let nearByClassList = NSMutableArray() // Class List
        nearByClassList.add("NearByServicesFiles/Screens/NearByDetailsUV.swift")
        nearByClassList.add("NearByServicesFiles/Screens/NearBySearvicesHomeUV.swift")
        nearByClassList.add("NearByServicesFiles/Cells/NearbyCatCVC.swift")
        nearByClassList.add("NearByServicesFiles/Cells/NearByCatTVCell.swift")
        nearByClassList.add("NearByServicesFiles/Cells/NearByListCell.swift")
        nearByClassList.add("Cells/NearByCuisinesCVC.swift")
        NearByModule["classNameList"] = nearByClassList
        for value in nearByClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    NearByModule["NEARBY_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let nearByXibList = NSMutableArray()     // Xib List
        nearByClassList.add("NearByServicesFiles/ScreenDesigns/NearByDetailsScreenDesign.xib")
        nearByClassList.add("NearByServicesFiles/ScreenDesigns/NearByHomeScreenDesign.xib")
        nearByClassList.add("NearByServicesFiles/CellDesign/NearbyCatCVC.xib")
        nearByClassList.add("NearByServicesFiles/CellDesign/NearByCatTVCell.xib")
        nearByClassList.add("NearByServicesFiles/CellDesign/NearByListCell.xib")
        nearByClassList.add("CellDesign/NearByCuisinesCVC.xib")
        NearByModule["xibList"] = nearByXibList
        for value in nearByXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    NearByModule["NEARBY_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        /*************         GIFTCARD MODULE     **************/
        let GiftCardModule = NSMutableDictionary()
        GiftCardModule["GIFTCARD_MODULE"] = "No"
        
        
        let giftCardClassList = NSMutableArray() // Class List
        giftCardClassList.add("GiftCard/Cell/GiftCardThemeCVCell.swift")
        giftCardClassList.add("GiftCard/RedeemGiftCardUV.swift")
        giftCardClassList.add("GiftCard/SendGiftCardUV.swift")
        
        
        GiftCardModule["classNameList"] = giftCardClassList
        for value in giftCardClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    GiftCardModule["GIFTCARD_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let giftCardXibList = NSMutableArray()     // Xib List
        giftCardXibList.add("GiftCard/SendGiftCardScreenDesign.xib")
        giftCardXibList.add("GiftCard/RedeemGiftCardScreenDesign.xib")
        giftCardXibList.add("GiftCard/Cell/GiftCardThemeCVCell.xib")
        
        GiftCardModule["xibList"] = giftCardXibList
        for value in giftCardXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    GiftCardModule["GIFTCARD_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        /*************        TRACKING MODULE     **************/
        let TrackingModule = NSMutableDictionary()
        TrackingModule["TRACKING_MODULE"] = "No"
        
        
        let trackingClassList = NSMutableArray() // Class List
        trackingClassList.add("Track_Member/Screens/ProfileInfoUV.swift")
        trackingClassList.add("Track_Member/Screens/SetupProfileHomeUV.swift")
        trackingClassList.add("Track_Member/Screens/TrackAnySignupUV.swift")
        trackingClassList.add("Track_Member/Screens/TrackingListUV.swift")
        trackingClassList.add("Track_Member/Screens/TrackingLiveUV.swift")
        trackingClassList.add("Track_Member/Cell/NewTrackingListTVCell.swift")
        trackingClassList.add("Track_Member/Cell/TrackingListTVCell.swift")
        
        
        TrackingModule["classNameList"] = trackingClassList
        for value in trackingClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    TrackingModule["TRACKING_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let trackingXibList = NSMutableArray()     // Xib List
        trackingXibList.add("Track_Member/ScreensDesign/ProfileInfoScreenDesign.xib")
        trackingXibList.add("Track_Member/ScreensDesign/SetupProfileScreenDesign.xib")
        trackingXibList.add("Track_Member/ScreensDesign/TrackAnySignupScreenDesign.xib")
        trackingXibList.add("Track_Member/ScreensDesign/TrackingListScreenDesign.xib")
        trackingXibList.add("Track_Member/ScreensDesign/TrackingLiveScreenDesign.xib")
        trackingXibList.add("Track_Member/CellDesign/NewTrackingListTVCell.xib")
        trackingXibList.add("Track_Member/CellDesign/TrackingListTVCell.xib")
        
        TrackingModule["xibList"] = trackingXibList
        for value in trackingXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    TrackingModule["TRACKING_MODULE"] = "Yes"
                    break
                }
            }
        }
        /*************        RIDE SHARE SERVICE     **************/
        let RideShareModule = NSMutableDictionary()
        RideShareModule["RIDESHARE_MODULE"] = "No"
        
        
        let rideShareClassList = NSMutableArray() // Class List
        rideShareClassList.add("RideShareFiles/Screens/BookingSummaryUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/BookRideUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/EditRideUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/MyRideTabUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/MyRideUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/PublishRideUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/SearchRideDetialsUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/SearchRideUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/UploadDocUV.swift")
        rideShareClassList.add("RideShareFiles/Screens/UserRequestUV.swift")
        rideShareClassList.add("RideShareFiles/Cells/MyRideTVC.swift")
        rideShareClassList.add("RideShareFiles/Cells/PassengerDetialsTVC.swift")
        rideShareClassList.add("RideShareFiles/Cells/RideShareDocTVCell.swift")
        rideShareClassList.add("RideShareFiles/Cells/SearchRideTVC.swift")
        
        RideShareModule["classNameList"] = rideShareClassList
        for value in rideShareClassList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isClsExist()){
                    RideShareModule["RIDESHARE_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        let rideShareXibList = NSMutableArray()     // Xib List
        rideShareXibList.add("RideShareFiles/ScreenDesigns/BookingSummaryScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/BookRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/EditRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/MyRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/PassengerDetialsTVC.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/PublishRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/SearchRideDetailsScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/SearchRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/UploadDocScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/UserRequestsScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/CellDesign/MyRideTVC.xib")
        rideShareXibList.add("RideShareFiles/CellDesign/SearchRideTVC.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/SearchRideScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/UploadDocScreenDesign.xib")
        rideShareXibList.add("RideShareFiles/ScreenDesigns/UserRequestsScreenDesign.xib")
        
        RideShareModule["xibList"] = rideShareXibList
        for value in rideShareXibList{
            let valueStr = (value as! String)
            let array:NSArray = valueStr.components(separatedBy: "/") as NSArray
            if let index = ((array.lastObject) as! String).range(of: ".")?.lowerBound {
                let substring = ((array.lastObject) as! String)[..<index]
                if (String(substring).isXibExist()){
                    RideShareModule["RIDESHARE_MODULE"] = "Yes"
                    break
                }
            }
        }
        
        
        
        
        
        
        
        
        var finalDataPara = [String:String]()

        
        if (AppleWatchModule.get("APPLE_WATCH_MODULE").uppercased() == "YES"){
            finalDataPara["APPLE_WATCH_MODULE"] = AppleWatchModule.get("APPLE_WATCH_MODULE")
            finalDataPara["APPLE_WATCH_FILES"] = ((AppleWatchModule["classNameList"] as! NSArray).addingObjects(from: (AppleWatchModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")

        }
        
        if (VoipModule.get("VOIP_SERVICE").uppercased() == "YES"){
            
            finalDataPara["VOIP_SERVICE"] = VoipModule.get("VOIP_SERVICE")
            finalDataPara["VOIP_SERVICE_FILES"] = ((VoipModule["classNameList"] as! NSArray).addingObjects(from: (VoipModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (BiddingModule.get("BID_SERVICE").uppercased() == "YES"){
            
            finalDataPara["BID_SERVICE"] = BiddingModule.get("BID_SERVICE")
            finalDataPara["BID_SERVICE_FILES"] = ((BiddingModule["classNameList"] as! NSArray).addingObjects(from: (BiddingModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        
        if (AdvertisementModule.get("ADVERTISEMENT_MODULE").uppercased() == "YES"){
            
            finalDataPara["ADVERTISEMENT_MODULE"] = AdvertisementModule.get("ADVERTISEMENT_MODULE")
            finalDataPara["ADVERTISEMENT_MODULE_FILES"] = ((AdvertisementModule["classNameList"] as! NSArray).addingObjects(from: (AdvertisementModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        
        
        if (UFXGenarlModule.get("UBERX_GENERAL_SERVICE").uppercased() == "YES"){
            
            finalDataPara["UBERX_GENERAL_SERVICE"] = UFXGenarlModule.get("UBERX_GENERAL_SERVICE")
            finalDataPara["UBERX_GENERAL_SERVICE_FILES"] = ((UFXGenarlModule["classNameList"] as! NSArray).addingObjects(from: (UFXGenarlModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
    
        if (DelAllGenarlModule.get("DELIVER_ALL_GENERAL").uppercased() == "YES"){
            
            finalDataPara["DELIVER_ALL_GENERAL"] = DelAllGenarlModule.get("DELIVER_ALL_GENERAL")
            finalDataPara["DELIVER_ALL_GENERAL_FILES"] = ((DelAllGenarlModule["classNameList"] as! NSArray).addingObjects(from: (DelAllGenarlModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (CardIOModule.get("CARD_IO").uppercased() == "YES"){
            
            finalDataPara["CARD_IO"] = CardIOModule.get("CARD_IO")
            finalDataPara["CARD_IO_FILES"] = "Remove From Pod"
        }
        
        if (BSModule.get("BOOK_FOR_ELSE_SECTION").uppercased() == "YES"){
            
            finalDataPara["BOOK_FOR_ELSE_SECTION"] = BSModule.get("BOOK_FOR_ELSE_SECTION")
            finalDataPara["BOOK_FOR_ELSE_SECTION_FILES"] = ((BSModule["classNameList"] as! NSArray).addingObjects(from: (BSModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (FavDriverModule.get("FAV_DRIVER_SECTION").uppercased() == "YES"){
            
            finalDataPara["FAV_DRIVER_SECTION"] = FavDriverModule.get("FAV_DRIVER_SECTION")
            finalDataPara["FAV_DRIVER_SECTION_FILES"] = ((FavDriverModule["classNameList"] as! NSArray).addingObjects(from: (FavDriverModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (LiveChatModule.get("LIVE_CHAT").uppercased() == "YES"){
            
            finalDataPara["LIVE_CHAT"] = LiveChatModule.get("LIVE_CHAT")
            finalDataPara["LIVE_CHAT_FILES"] = ((LiveChatModule["classNameList"] as! NSArray).addingObjects(from: (LiveChatModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (LinkedinModule.get("LINKEDIN_MODULE").uppercased() == "YES"){
            
            finalDataPara["LINKEDIN_MODULE"] = LinkedinModule.get("LINKEDIN_MODULE")
            finalDataPara["LINKEDIN_MODULE_FILES"] = ((LinkedinModule["classNameList"] as! NSArray).addingObjects(from: (LinkedinModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (PoolModule.get("POOL_MODULE").uppercased() == "YES"){
            
            finalDataPara["POOL_MODULE"] = PoolModule.get("POOL_MODULE")
            finalDataPara["POOL_MODULE_FILES"] = ((PoolModule["classNameList"] as! NSArray).addingObjects(from: (PoolModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (NewsSectionModule.get("NEWS_SECTION").uppercased() == "YES"){
            
            finalDataPara["NEWS_SECTION"] = NewsSectionModule.get("NEWS_SECTION")
            finalDataPara["NEWS_SERVICE_FILES"] = ((NewsSectionModule["classNameList"] as! NSArray).addingObjects(from: (NewsSectionModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (RDUModule.get("RDU_SECTION").uppercased() == "YES"){
            
            finalDataPara["RDU_SECTION"] = RDUModule.get("RDU_SECTION")
            finalDataPara["RDU_SECTION_FILES"] = ((RDUModule["classNameList"] as! NSArray).addingObjects(from: (RDUModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (MultiDeliveryModule.get("MULTI_DELIVERY").uppercased() == "YES"){
            
            finalDataPara["MULTI_DELIVERY"] = MultiDeliveryModule.get("MULTI_DELIVERY")
            finalDataPara["MULTI_DELIVERY_FILES"] = ((MultiDeliveryModule["classNameList"] as! NSArray).addingObjects(from: (MultiDeliveryModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (CommonDelModule.get("COMMON_DELIVERY_TYPE_SECTION").uppercased() == "YES"){
            
            finalDataPara["COMMON_DELIVERY_TYPE_SECTION"] = CommonDelModule.get("COMMON_DELIVERY_TYPE_SECTION")
            finalDataPara["COMMON_DELIVERY_TYPE_SECTION_FILES"] = ((CommonDelModule["classNameList"] as! NSArray).addingObjects(from: (CommonDelModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (DeliveryModule.get("DELIVERY_MODULE").uppercased() == "YES"){
            
            finalDataPara["DELIVERY_MODULE"] = DeliveryModule.get("DELIVERY_MODULE")
            finalDataPara["DELIVERY_MODULE_FILES"] = ((DeliveryModule["classNameList"] as! NSArray).addingObjects(from: (DeliveryModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (DonationModule.get("DONATION_SECTION").uppercased() == "YES"){
            
            finalDataPara["DONATION_SECTION"] = DonationModule.get("DONATION_SECTION")
            finalDataPara["DONATION_SECTION_FILES"] = ((DonationModule["classNameList"] as! NSArray).addingObjects(from: (DonationModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (OngoingModule.get("ON_GOING_JOB_SECTION").uppercased() == "YES"){
            
            finalDataPara["ON_GOING_JOB_SECTION"] = OngoingModule.get("ON_GOING_JOB_SECTION")
            finalDataPara["ON_GOING_JOB_SECTION_FILES"] = ((OngoingModule["classNameList"] as! NSArray).addingObjects(from: (OngoingModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (uberXModule.get("UBERX_SERVICE").uppercased() == "YES"){
            
            finalDataPara["UBERX_SERVICE"] = uberXModule.get("UBERX_SERVICE")
            finalDataPara["UBERX_FILES"] = ((uberXModule["classNameList"] as! NSArray).addingObjects(from: (uberXModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (BusinessProfModule.get("BUSINESS_PROFILE_FEATURE").uppercased() == "YES"){
            
            finalDataPara["BUSINESS_PROFILE_FEATURE"] = BusinessProfModule.get("BUSINESS_PROFILE_FEATURE")
            finalDataPara["BUSINESS_PROFILE_FILES"] = ((BusinessProfModule["classNameList"] as! NSArray).addingObjects(from: (BusinessProfModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        if (RentalModule.get("RENTAL_FEATURE").uppercased() == "YES"){
            
            finalDataPara["RENTAL_FEATURE"] = RentalModule.get("RENTAL_FEATURE")
            finalDataPara["RENTAL_SERVICE_FILES"] = ((RentalModule["classNameList"] as! NSArray).addingObjects(from: (RentalModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        
        if (DeliverAllModule.get("DELIVER_ALL").uppercased() == "YES"){
            
            finalDataPara["DELIVER_ALL"] = DeliverAllModule.get("DELIVER_ALL")
            finalDataPara["DELIVER_ALL_FILES"] = ((DeliverAllModule["classNameList"] as! NSArray).addingObjects(from: (DeliverAllModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        
        
        if (RideShareModule.get("RIDESHARE_MODULE").uppercased() == "YES"){
            
            finalDataPara["RIDESHARE_MODULE"] = RideShareModule.get("RIDESHARE_MODULE")
            finalDataPara["RIDESHARE_MODULE_FILES"] = ((RideShareModule["classNameList"] as! NSArray).addingObjects(from: (RideShareModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        if (RentItemModule.get("RENT_ITEM_SERVICE").uppercased() == "YES"){
            
            finalDataPara["RENT_ITEM_SERVICE"] = RentItemModule.get("RENT_ITEM_SERVICE")
            finalDataPara["RENT_ITEM_SERVICE_FILES"] = ((RentItemModule["classNameList"] as! NSArray).addingObjects(from: (RentItemModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        if (NearByModule.get("NEARBY_MODULE").uppercased() == "YES"){
            
            finalDataPara["NEARBY_MODULE"] = NearByModule.get("NEARBY_MODULE")
            finalDataPara["NEARBY_MODULE_FILES"] = ((NearByModule["classNameList"] as! NSArray).addingObjects(from: (NearByModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        if (GiftCardModule.get("GIFTCARD_MODULE").uppercased() == "YES"){
            
            finalDataPara["GIFTCARD_MODULE"] = GiftCardModule.get("GIFTCARD_MODULE")
            finalDataPara["GIFTCARD_MODULE_FILES"] = ((GiftCardModule["classNameList"] as! NSArray).addingObjects(from: (GiftCardModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        if (TrackingModule.get("TRACKING_MODULE").uppercased() == "YES"){
            
            finalDataPara["TRACKING_MODULE"] = TrackingModule.get("TRACKING_MODULE")
            finalDataPara["TRACKING_MODULE_FILES"] = ((TrackingModule["classNameList"] as! NSArray).addingObjects(from: (TrackingModule["xibList"] as! NSArray) as! [Any]) as NSArray).componentsJoined(by: ",")
        }
        finalDataPara["PACKAGE_NAME"] = Bundle.main.bundleIdentifier
       
        return finalDataPara
        
    }
}
