//
//  SoccerVideosApp.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import SwiftUI

@main
struct SoccerVideosApp: App {

    @StateObject private var dataprovider = DataProvider()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            LandingView(dataprovider: dataprovider)
                .onAppear(perform: {
                    dataprovider.loadCompetitions()
                })
                .onOpenURL { url in
                    print("Received URL: \(url)")
                }
        }
        .onChange(of: scenePhase) { newPhase in
              switch newPhase {
              case .active:
                print("Active")
              case .inactive:
                print("Inactive")
              case .background:
                print("Background")
              @unknown default:
                print("Unexpected")
              }
            }
    }
    
}


// Detail View
// Property Wrappers
// Localization
