//
//  ActivityAttributes.swift
//  UserApp
//
//  Created by Apple on 15/03/23.
//

import SwiftUI
import ActivityKit

struct RideAttributes: ActivityAttributes {
    public typealias RideStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var APP_TYPE: String
        var STATUS: String
        var APP_NAME: String
        var DISTANCE_STEP: String
        var DRIVER_IMG: String
        var DRIVER_LICENSE_PLATE: String
        var DRIVER_VEHICLE: String
        var ETA: String
        var ETA_SUBTITLE: String
        var ETA_TITLE: String
        var VEHICLE_TYPE_IMG: String
    }

    var DRIVER_IMG: String
    var VEHICLE_TYPE_IMG: String
  
    
}

struct DeliverAllAttributes: ActivityAttributes {
    public typealias DeliverAllStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var APP_TYPE: String
        var APP_NAME: String
        var ORDER_STAGE: String
        var DISTANCE_STEP: String
        var ETA: String
        var ETA_SUBTITLE: String
        var ETA_TITLE: String
        var STORE_NAME: String
    }
    
    var DRIVER_IMG: String
    
}
