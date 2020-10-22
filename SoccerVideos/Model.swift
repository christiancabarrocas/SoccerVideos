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
