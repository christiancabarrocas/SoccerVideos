//
//  NetworkingProvider.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import Foundation
import Combine

enum GeneralError: Error {
    case statusCodeError
    case decodeError
    case urlError
    case serverError
    case unknown
}

final class NetworkingProvider {
    
    private var data: AnyCancellable?

    #warning("Use Future")
    #warning("Extract to SwiftPackage")
    func load<T: Codable>(completion: @escaping (Result<T, GeneralError>) -> Void) {
        
        let endpoint = Endpoint(path: "/video-api/v1", queryItems:nil)
        guard let url = endpoint.url  else { completion(.failure(.urlError)); return }
                
        data = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ (error) -> (GeneralError) in
                switch error {
                case is DecodingError:
                    completion(.failure(.decodeError))
                    return .decodeError
                case is URLError:
                    completion(.failure(.urlError))
                    return .urlError
                default:
                    completion(.failure(.unknown))
                    return .unknown
                }
            })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print("Finished")
            }, receiveValue: { data in
                completion(.success(data))
            })
    }
}
