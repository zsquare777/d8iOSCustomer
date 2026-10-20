//
//  LiveActivityDataBundle.swift
//  LiveActivityData
//
//  Created by Apple on 15/03/23.
//

import WidgetKit
import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import ActivityKit
@main
struct LiveActivityDataBundle: WidgetBundle {
    var body: some Widget {
    
        RideActivityWidget()
        DeliverAllActivityWidget()
       
    }
}


struct RideActivityWidget: Widget {
    
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RideAttributes.self) { context in
            // For devices that don't support the Dynamic Island.
    
            VStack(alignment: .leading) {
                HStack(spacing: 10){
                    Text("\(context.state.APP_NAME)").font(.system(size: 17)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).padding(.top, 15).frame(alignment: .top).foregroundColor(Color.white)
                    
                    if(context.state.STATUS.uppercased() != "ONGOINGTRIP"){
                        HStack(spacing: -8){
                            
                            let uiImage = UIImage(contentsOfFile: context.attributes.DRIVER_IMG) ?? UIImage(named:"ic_no_pic_user")!
                            Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit).frame(width: 34, height: 34).fixedSize().background(Color.white).cornerRadius(17).overlay(RoundedRectangle(cornerRadius: 17).stroke(Color.white, lineWidth: 1)).padding(.bottom, 3)
                            
                            let uiImageCar = UIImage(contentsOfFile: context.attributes.VEHICLE_TYPE_IMG) ?? UIImage(named:"Artboard")!
                            Image(uiImage: uiImageCar).resizable().aspectRatio(contentMode: .fit).frame(width: 44, height: 44).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                        }
                    }
                    
                }

                VStack(alignment: .leading) {
                    
                    if(context.state.STATUS.uppercased() == "ONGOINGTRIP"){
                        
                        Group {
                            Text("\(context.state.ETA_TITLE) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white) +
                            Text("\(context.state.ETA)").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12))
                        }
                        
                        Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                        
                    }else{
                        if(context.state.STATUS.uppercased() == "ARRIVED"){
                            
                            HStack{
                                
                                Text("\(context.state.ETA)\(context.state.ETA_TITLE)").lineLimit(2).font(.system(size: 20)).fontWeight(.bold).foregroundColor(Color.white)
                                
                               
                                VStack{
                                    Text("\(context.state.DRIVER_LICENSE_PLATE)").font(.system(size: 19)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .trailing).frame(alignment: .top).padding(.bottom, 0).foregroundColor(Color.white)
                                    Text("\(context.state.DRIVER_VEHICLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .trailing).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                                }
                            }.frame(height: 55)

                        }else{
                            HStack{
                                
                                Group {
                                    Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12)) +
                                    Text("\(context.state.ETA_TITLE)").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white)
                                }
                                
                                Text("\(context.state.DRIVER_LICENSE_PLATE)").font(.system(size: 19)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .trailing).frame(alignment: .top).padding(.bottom, 0).foregroundColor(Color.white)
                               
                            }
                            HStack{
                                Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                                Text("\(context.state.DRIVER_VEHICLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .trailing).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                            }
                        }
                    }
                    
                    
                }
                
                HStack(spacing: 0){
                    
                    let width = (UIScreen.main.bounds.width - 60) / 10
                    if(context.state.DISTANCE_STEP == "1"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width, maxWidth: width, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60), minHeight: 2, maxHeight: 3).zIndex(-1)
                    
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                            
                    }else if(context.state.DISTANCE_STEP == "2"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 2, maxWidth: width * 2, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 2), minHeight: 2, maxHeight: 3).zIndex(-1)
                        
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "3"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 3, maxWidth: width * 3, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 3), minHeight: 2, maxHeight: 3).zIndex(-1)
                        
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "4"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 4, maxWidth: width * 4, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 4)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 4), minHeight: 2, maxHeight: 3).zIndex(-1)
                       
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "5"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 5, maxWidth: width * 5, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 4)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 5), minHeight: 2, maxHeight: 3).zIndex(-1)
                        
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "6"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 6, maxWidth: width * 6, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 4)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 6), minHeight: 2, maxHeight: 3).zIndex(-1)
                        
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "7"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 7, maxWidth: width * 7, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 7), minHeight: 2, maxHeight: 3).zIndex(-1)
                        
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                    }else if(context.state.DISTANCE_STEP == "8"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 8, maxWidth: width * 8, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 8), minHeight: 2, maxHeight: 3).zIndex(-1)
    
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "9"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 9, maxWidth: width * 9, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 9), minHeight: 2, maxHeight: 3).zIndex(-1)
                    
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else if(context.state.DISTANCE_STEP == "10"){
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: width * 9, maxWidth: width * 9, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                       // Rectangle().fill(.gray).frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 9), minHeight: 0, maxHeight: 3).padding(.bottom, 3).zIndex(-1)
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                    }else{
                        Rectangle().fill(Color(hex: 0xF42D12)).frame(minWidth: 10, maxWidth: 10, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                        Image("car").frame(width: 15, height: 15).fixedSize().aspectRatio(contentMode: .fit).padding(.bottom, 3)
                        
                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                   .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - 10, minHeight: 2, maxHeight: 3).zIndex(-1)
                    
                        Image("circle").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20).scaledToFill().padding(.bottom, 3).zIndex(-1)
                    }
                    
                    
                  
                }
                
            }.padding(.bottom, 20).padding(.left, 15).padding(.right, 15).padding(.top, 15).background(Color.black.opacity(0.4))
            
               
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                   
                    Image("kingxpro").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                    
                    if(context.state.STATUS.uppercased() != "ONGOINGTRIP"){
                        HStack(spacing: -8){
                            
                            let uiImage = UIImage(contentsOfFile: context.attributes.DRIVER_IMG) ?? UIImage(named:"ic_no_pic_user")!
                            Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit).frame(width: 34, height: 34).fixedSize().background(Color.white).cornerRadius(17).overlay(RoundedRectangle(cornerRadius: 17).stroke(Color.white, lineWidth: 1)).padding(.bottom, 3)
                            
                            let uiImageCar = UIImage(contentsOfFile: context.attributes.VEHICLE_TYPE_IMG) ?? UIImage(named:"Artboard")!
                            Image(uiImage: uiImageCar).resizable().aspectRatio(contentMode: .fit).frame(width: 44, height: 44).scaledToFill().padding(.bottom, 3).zIndex(-1)
                        
                        }
                        
                        Text("\(context.state.DRIVER_LICENSE_PLATE)").font(.system(size: 10)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(.white)
                        Text("\(context.state.DRIVER_VEHICLE)").font(.system(size: 12)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(.white)
                    }
                    
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.APP_NAME)").font(.system(size: 17)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center).frame(alignment: .top).foregroundColor(Color.white)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if(context.state.STATUS.uppercased() == "ONGOINGTRIP"){
                        VStack{
                            Group {
                                Text("\(context.state.ETA_TITLE) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white) +
                                Text("\(context.state.ETA)").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12))
                            }
                            
                            Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .center).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                        }
                    }else{
                        VStack{
                            if(context.state.STATUS.uppercased() == "ARRIVED"){
                                Text("\(context.state.ETA)\(context.state.ETA_TITLE)").lineLimit(2).font(.system(size: 20)).fontWeight(.bold).foregroundColor(Color.white)
                            }else{
                                Group {
                                    Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12)) +
                                    Text("\(context.state.ETA_TITLE)").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white)
                                }
                                
                                Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .center).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                            }
                           
                        }
                    }
                   
                }
            } compactLeading: {
                Image("kingxpro").resizable().aspectRatio(contentMode: .fit)
            
            } compactTrailing: {
                Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12))
                
            } minimal: {
   
            }
            .keylineTint(.accentColor)
        }
    }
}

struct DeliverAllActivityWidget: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliverAllAttributes.self) { context in
           
                VStack() {
                    HStack(spacing: 5){
                        Text("\(context.state.STORE_NAME)").font(.system(size: 17)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).padding(.top, 15).frame(alignment: .top).foregroundColor(Color.white)

                        Image("kingxpro").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40)

                    }
                    
                    if(context.state.ORDER_STAGE.uppercased() == "ORDERPLACED"){
                        HStack(spacing: 5){
                            Image("clock").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                            
                            Text("\(context.state.ETA_SUBTITLE)").lineLimit(2).font(.system(size: 18)).fontWeight(.bold).foregroundColor(Color.white)

                        }.frame(alignment: .leading)
                        
                    }else if(context.state.ORDER_STAGE.uppercased() == "ORDERACCEPTED" || context.state.ORDER_STAGE.uppercased() == "ORDERPREPARED" || context.state.ORDER_STAGE.uppercased() == "ORDERDISPATCHED"){
                        
                        VStack(alignment: .leading){
                            
                            Text("\(context.state.ETA_TITLE) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white) +
                            Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0x45AEAC))

                            Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                           
                        }.frame(height:40)
                        
                        ZStack(){
                            HStack(spacing: 0){
                                
                                let width = (UIScreen.main.bounds.width - 60) / 10
                                if(context.state.DISTANCE_STEP == "1"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width, maxWidth: width, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60), minHeight: 2, maxHeight: 3).zIndex(-1)
                                
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                        
                                }else if(context.state.DISTANCE_STEP == "2"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 2, maxWidth: width * 2, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 2), minHeight: 2, maxHeight: 3).zIndex(-1)
                                    
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "3"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 3, maxWidth: width * 3, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 3), minHeight: 2, maxHeight: 3).zIndex(-1)
                                    
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "4"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 4, maxWidth: width * 4, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 4), minHeight: 2, maxHeight: 3).zIndex(-1)
                                   
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "5"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 5, maxWidth: width * 5, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 5), minHeight: 2, maxHeight: 3).zIndex(-1)
                                    
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "6"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 6, maxWidth: width * 6, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 6), minHeight: 2, maxHeight: 3).zIndex(-1)
                                    
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "7"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 7, maxWidth: width * 7, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 7), minHeight: 2, maxHeight: 3).zIndex(-1)
                                    
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                }else if(context.state.DISTANCE_STEP == "8"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 8, maxWidth: width * 8, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 8), minHeight: 2, maxHeight: 3).zIndex(-1)
                
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "9"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: width * 9, maxWidth: width * 9, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 9), minHeight: 2, maxHeight: 3).zIndex(-1)
                                
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else if(context.state.DISTANCE_STEP == "10"){
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: (width * 9) - 20, maxWidth: (width * 9) - 20, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                   // Rectangle().fill(.gray).frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - (width * 9), minHeight: 0, maxHeight: 3).padding(.bottom, 3).zIndex(-1)
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                    
                                }else{
                                    Rectangle().fill(Color(hex: 0x45AEAC)).frame(minWidth: 0, maxWidth: 0, minHeight: 2, maxHeight: 3).padding(.bottom, 3)
                                    Image("scooter").resizable().aspectRatio(contentMode: .fit).frame(width: 35, height: 35).padding(.bottom, 3)
                                    
                                    Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                               .frame(minWidth: 0, maxWidth: (UIScreen.main.bounds.width - 60) - 10, minHeight: 2, maxHeight: 3).zIndex(-1)
                                
                                    Image("home").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3).zIndex(-1)
                                }
                              
                            }.zIndex(-1)
                            
                            Image("store").resizable().aspectRatio(contentMode: .fit).frame(minWidth: 0, maxWidth: 25, minHeight: 0, maxHeight: 25).scaledToFill().padding(.bottom, 3)
                        }
                       
                    }
                    
                }.padding(.bottom, 20).padding(.left, 15).padding(.right, 15).padding(.top, 15).background(Color.black.opacity(0.4))
             
        } dynamicIsland: { context in
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
//
                    Image("kingxpro").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
    
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    
                    if(context.state.ORDER_STAGE.uppercased() == "ORDERPLACED"){
                        Image("clock").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading)
                    }else if(context.state.ORDER_STAGE.uppercased() == "ORDERDISPATCHED"){
                        Image("delivery-bike").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading)
                    }else{
                        Image("restaurant").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    

                    VStack(spacing:5){
                        
                        Text("\(context.state.APP_NAME)").font(.system(size: 17)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center).frame(alignment: .top).foregroundColor(Color.white)
                        
                        Text("\(context.state.STORE_NAME)").multilineTextAlignment(.center).font(.system(size: 15)).fontWeight(.bold).foregroundColor(Color(hex: 0x45AEAC))
                    }
                    
                    
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    
                    if(context.state.ORDER_STAGE.uppercased() == "ORDERPLACED"){
                        
                        Text("\(context.state.ETA_SUBTITLE)").multilineTextAlignment(.center).lineLimit(nil).font(.system(size: 17)).fontWeight(.bold).foregroundColor(.white).padding(.top, 10)
                    }else{
                        
                        VStack(alignment: .center){
                            
                            Text("\(context.state.ETA_TITLE) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color.white) +
                            Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0x45AEAC))

                            Text("\(context.state.ETA_SUBTITLE)").font(.system(size: 14)).fontWeight(.regular).frame(maxWidth: .infinity, alignment: .center).padding(.bottom, 10).frame(alignment: .top).foregroundColor(.white)
                           
                        }.frame(height:40).padding(.top, 10)
                    
                    }
                }
                
            } compactLeading: {
               
                Image("kingxpro").resizable().aspectRatio(contentMode: .fit)
                
                
            } compactTrailing: {
                
                if(context.state.ORDER_STAGE.uppercased() == "ORDERPLACED"){
                    Image("clock").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                }else{
                    Text("\(context.state.ETA) ").font(.system(size: 19)).fontWeight(.bold).foregroundColor(Color(hex: 0xF42D12))
                }
                
                
            } minimal: {
                
            }
            .keylineTint(.accentColor)
        }
    }
}



enum NoFlipEdge {
    case left, right
}

struct NoFlipPadding: ViewModifier {
    let edge: NoFlipEdge
    let length: CGFloat?
    @Environment(\.layoutDirection) var layoutDirection
    
    private var computedEdge: Edge.Set {
        if layoutDirection == .rightToLeft {
            return edge == .left ? .trailing : .leading
        } else {
            return edge == .left ? .leading : .trailing
        }
    }
    
    func body(content: Content) -> some View {
        content
            .padding(computedEdge, length)
    }
}

extension View {
    func padding(_ edge: NoFlipEdge, _ length: CGFloat? = nil) -> some View {
        self.modifier(NoFlipPadding(edge: edge, length: length))
    }
}
//// Preview available on iOS 16.2 or above
//@available(iOSApplicationExtension 16.2, *)
//struct PizzaDeliveryActivityWidget_Previews: PreviewProvider {
//    static let activityAttributes = RideAttributes(numberOfPizzas: 2, totalAmount: "1000")
//    static let activityState = RideAttributes.ContentState(appName: "", driverName: "Tim", estimatedDeliveryTime: "0")
//
//    static var previews: some View {
//        activityAttributes
//            .previewContext(activityState, viewKind: .content)
//            .previewDisplayName("Notification")
//
//        activityAttributes
//            .previewContext(activityState, viewKind: .dynamicIsland(.compact))
//            .previewDisplayName("Compact")
//
//        activityAttributes
//            .previewContext(activityState, viewKind: .dynamicIsland(.expanded))
//            .previewDisplayName("Expanded")
//
//        activityAttributes
//            .previewContext(activityState, viewKind: .dynamicIsland(.minimal))
//            .previewDisplayName("Minimal")
//    }
//}


struct RemoteImageView<Placeholder: View, ConfiguredImage: View>: View {
    var url: URL
    private let placeholder: () -> Placeholder
    private let image: (Image) -> ConfiguredImage

    @ObservedObject var imageLoader: ImageLoaderService
    @State var imageData: UIImage?

    init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder image: @escaping (Image) -> ConfiguredImage
    ) {
        self.url = url
        self.placeholder = placeholder
        self.image = image
        self.imageLoader = ImageLoaderService(url: url)
    }

    @ViewBuilder private var imageContent: some View {
        if let data = imageData {
            image(Image(uiImage: data))
        } else {
            placeholder()
        }
    }

    var body: some View {
        imageContent
            .onReceive(imageLoader.$image) { imageData in
                self.imageData = imageData
            }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()

    convenience init(url: URL) {
        self.init()
        loadImage(for: url)
    }

    func loadImage(for url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}


extension Image {
    /// Initializes a SwiftUI `Image` from data.
    init?(data: Data) {
        #if canImport(UIKit)
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
        #elseif canImport(AppKit)
        if let nsImage = NSImage(data: data) {
            self.init(nsImage: nsImage)
        } else {
            return nil
        }
        #else
        return nil
        #endif
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
