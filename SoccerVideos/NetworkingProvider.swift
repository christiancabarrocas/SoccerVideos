//
//  NetworkingProvider.swift
//  SoccerVideos
//
//  Created by Christian Cabarrocas on 16/10/2020.
//

import Foundation
import Combine
import Console

enum GeneralError: Error {
    case statusCodeError
    case decodeError
    case urlError
    case serverError
    case unknown
}

final class NetworkingProvider {

    private var cancellable: AnyCancellable?

    #warning("Use Future")
    #warning("Extract to SwiftPackage")

    func load(url: URL) -> AnyPublisher<Data, GeneralError> {

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    Console.log(type: .error, subtype: .networking)
                    throw GeneralError.unknown
                }
                return data
            }
            .mapError { error in
                Console.log(type: .error, subtype: .decoding)
                if let error = error as? GeneralError {
                    return error
                } else {
                    return GeneralError.unknown
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    func load<T: Codable>(url: URL, completion: @escaping (Result<T, GeneralError>) -> Void) {

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
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
                switch completion {
                    case .finished:
                        print("Finished")
                        break
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
            }, receiveValue: { data in
                completion(.success(data))
            })
    }
}
