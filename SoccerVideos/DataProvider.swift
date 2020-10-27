//
//  DataProvider.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 21/10/2020.
//

import Foundation

final class DataProvider: ObservableObject {
    
    private let networker = NetworkingProvider()
    @Published var competitions: [CompetitionViewModel] = []
    
    func loadCompetitions() {
        let endpoint = Endpoint(path: "/video-api/v1", queryItems:nil)
        guard let url = endpoint.url  else { return }

        networker.load(url: url) { (result: Result<[Match], GeneralError>) in
            switch result {
            case .failure(let error): print("\(error)")
            case .success(let matches): self.competitions = matches.groupByTournament()
            }
        }
    }
}

extension Collection where Element == Match {

    func groupByTournament() -> [CompetitionViewModel] {
        let groups = Dictionary(grouping: self, by: { $0.competition })
        var competitions:[CompetitionViewModel] = []
        for (com, matches) in groups {
            competitions.append(CompetitionViewModel(id: UUID(), name: com.name, url: com.url, matches: matches))
        }
        return competitions
    }
}
