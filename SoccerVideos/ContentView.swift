//
//  ContentView.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject private var dataprovider = DataProvider()

    var body: some View {
        NavigationView {
            List(dataprovider.competitions) { competition in
                VStack(alignment: .leading) {
                    Text(competition.name)
                    ForEach(competition.matches.indexed(), id: \.1.id) { index, match in
                        HStack() {
                            Text(match.title)
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("Competitions"))
        .onAppear(perform: {
            dataprovider.loadCompetitions()
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
