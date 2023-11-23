//
//  OneMenuApp.swift
//  OneMenu
//
//  Created by iMacRoman on 14.11.2023.
//

import SwiftUI
import AppKit
import ComposableArchitecture

@main
struct OneMenuApp: App {
    var body: some Scene {
        //        WindowGroup {
        MenuBarExtra("UtilityApp", systemImage: "hammer") {
            AppMenu()
        }.menuBarExtraStyle(.window)
        
    }
}


struct AppMenu: View {
    
    let store = Store(initialState: ResolutionFeature.State()){ ResolutionFeature()}
    var body: some View {
        WithViewStore(self.store, observe: { $0}) { viewStore in
            ScrollView{
                    ForEach(viewStore.resolutions, id:\.id) { res in
                        Button{viewStore.send(.switchResolution)} label: {
                            Text(res.name)
                                .padding()
                                .foregroundColor(res.foregraundColor) 
                                .onAppear{print(res.foregraundColor)}
                            
                        }
                    }
                
            }
            .frame(height: 300)
            .onAppear{
                viewStore.send(.screenAppear)
            }
            
        }
    }
}
