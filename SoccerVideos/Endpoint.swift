//
//  Endpoint.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]!
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.scorebat.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
//www.scorebat.com/video-api/v1/")
