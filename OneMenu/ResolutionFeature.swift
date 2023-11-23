//
//  ResolutionFeature.swift
//  OneMenu
//
//  Created by iMacRoman on 15.11.2023.
//

import Foundation
import ComposableArchitecture
import AppKit
import SwiftUI


struct ResolutionViewModel: Identifiable {
  let id: UUID = UUID()
  var name: String
  var resolution: [Int: Int]
  var foregraundColor: Color
}
extension ResolutionViewModel: Equatable {
    static func == ( lhs: ResolutionViewModel,rhs: ResolutionViewModel) -> Bool {
        return lhs.resolution == rhs.resolution
    }
}

@Reducer
struct ResolutionFeature{
    struct State: Equatable {
//        var resolutions: IdentifiedArrayOf<Resolution> = []
        var currentResolution: String?
        var resolutions: [ResolutionViewModel] = []
    }
    enum Action {
        case switchResolution
        case screenAppear
//        case FourK
    }
    
    
    var body: some ReducerOf<Self> {
       Reduce { state, action in
         switch action {
         case .switchResolution:
         
           return .none
             
         case .screenAppear:
             state.currentResolution = getCurrentResolution()
             state.resolutions = getAvailableResolutionsForMainScreen().map{
                 guard  let current = state.currentResolution  else { return ResolutionViewModel( name: $0.resolution, resolution: [$0.pixelHeight : $0.pixelWidth], foregraundColor: .gray)}
                return  ResolutionViewModel( name: $0.resolution, resolution: [$0.pixelHeight : $0.pixelWidth], foregraundColor:  $0.resolution == current ?  .green : .gray)
             }
             return .none
         }
       }
     }
    
    
    
    func getCurrentResolution() -> String? {
        guard let resolution = Display.mode  else { return nil }
        return resolution.resolution
    }
    
    
    func getAvailableResolutionsForMainScreen() ->  [CGDisplayMode]{
//        if let resolution = Display.mode?.resolution {
//            print("Resolution:", resolution)
//        }
        return Display.allModes()
//        state.resolutions =  Display.allModes().map{
//            return Resolution( name: <#T##String#>, resolution: <#T##[Int : Int]#>)
//        }
//         print("hello world")
//        for mode in Display.allModes() {
//            print(mode.resolution)
//        }
    }

  
    
    
    func setScreenResolution(screen: NSScreen, width: Int, height: Int) {
        guard let deviceDescription = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? CGDirectDisplayID else {
            print("Error getting screen information")
            return
        }

        let displayMode = getDisplayMode(for: deviceDescription, width: width, height: height)

        if displayMode != nil {
            CGDisplaySetDisplayMode(deviceDescription, displayMode!, nil)
        } else {
            print("Requested display mode not available")
        }
    }
    
    func getDisplayMode(for displayID: CGDirectDisplayID, width: Int, height: Int) -> CGDisplayMode? {
        let mode = CGDisplayCopyDisplayMode(displayID)

        if let availableModes = CGDisplayCopyAllDisplayModes(displayID, nil) as? [CGDisplayMode] {
            for displayMode in availableModes {
                if Int(displayMode.width) == width && Int(displayMode.height) == height {
                    return displayMode
                }
            }
        }

        return nil
    }
}
