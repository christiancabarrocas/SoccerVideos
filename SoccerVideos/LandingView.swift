//
//  LandingView.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import SwiftUI
import Combine

struct LandingView: View {
    
    @ObservedObject var dataprovider: DataProvider

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(dataprovider.competitions) { competition in
                    VStack(alignment: .leading, spacing: 15) {
                        Spacer()
                        Text(competition.name)
                            .font(.system(size: 17, weight: .semibold, design: .default))

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(competition.matches) { match in
                                    let mvm = MatchViewModel(match: match)
                                    MatchView(match: mvm)
                                }
                            }.frame(height: 100)
                        }
                    }
                    .padding(.leading)
                }
            }
            .navigationBarTitle(Text("Competitions"))
            
        }
    }
    
}

#if DEBUG
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        let dataProvider = DataProvider()
        LandingView(dataprovider: dataProvider)
            .onAppear(perform: {
                dataProvider.loadCompetitions()
            })
    }
}
#endif
