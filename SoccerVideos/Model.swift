//
//  Model.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import Foundation

struct Competition: Codable, Hashable {
    let name: String
    let url: String
}

struct Match: Codable {
    let title: String
    let url: String
    let date: String
    let videos: [Video]
    let competition: Competition
}

extension Match: Identifiable {
    var id: UUID { return UUID() }
}

struct Video: Codable {
    let title: String
    let embed: String
}

struct CompetitionViewModel: Identifiable {
    var id: UUID
    let name: String
    let url: String
    let matches: [Match]
}

struct MatchViewModel {
    let title: String
    let url: URL!
    let date: String
    let videos: [Video]
    let competition: String

    init(match: Match) {
        self.title = match.title
        self.url = URL(string: match.url)
        self.videos = match.videos
        self.competition = match.competition.name
        self.date = match.date
    }
}

extension MatchViewModel {

    var formattedDate: String {
        return formatDate(date)
    }

    var team1: String {
        let items = title.components(separatedBy: "-")
        return "\(items[0])".trimmingCharacters(in: CharacterSet.whitespaces)
    }

    var team2: String {
        let items = title.components(separatedBy: "-")
        return "\(items[1])".trimmingCharacters(in: CharacterSet.whitespaces)
    }

    private func formatDate(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!

        let sFormatter = DateFormatter()
        sFormatter.dateFormat = "MM-dd"
        return sFormatter.string(from: date)
    }
}
