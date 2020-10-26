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
    
    var body: some Scene {
        WindowGroup {
            LandingView(dataprovider: dataprovider)
                .onAppear(perform: {
                    dataprovider.loadCompetitions()
                })
        }
    }
}


// Detail View
// Property Wrappers
// Localization
