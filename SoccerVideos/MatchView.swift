//
//  MatchView.swift
//  SoccerVideos
//
//  Created by Shootr on 22/10/2020.
//

import SwiftUI

extension Color {

    static var matchGradient01: Color {
        return Color("matchGradient01")
    }

    static var matchGradient02: Color {
        return Color("matchGradient02")
    }
}

struct MatchView: View {

    var match: MatchViewModel

    var gradient: LinearGradient {
        return LinearGradient(gradient:Gradient(colors: [Color.matchGradient01, Color.matchGradient02]), startPoint: .bottom, endPoint: .top)
    }

    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                Text(match.team1)
                    .foregroundColor(.primary)
                    .font(.callout)
                    .shadow(color: .white, radius: 5, x: 3, y: 3)
                Text(match.team2)
                    .foregroundColor(.primary)
                    .font(.callout)
                    .shadow(color: .white, radius: 5, x: 3, y: 3)
                Text(match.formattedDate)
                    .foregroundColor(.white)
                    .font(.footnote)
            }.padding(.leading)
        }
        .frame(width: 120, height: 70, alignment: .leading)
        .background(gradient)
        .cornerRadius(8)
    }
}

struct MatchView_Previews: PreviewProvider {

    static let matchData = Match(title: "Barcelona - Mallorca", url: "url", date: "2020-10-22T00:30:00+0000", videos: [], competition: Competition(name: "Spain LaLiga", url: "ulrC"))
    
    static var previews: some View {
        MatchView(match: MatchViewModel(match: matchData))
    }
}
