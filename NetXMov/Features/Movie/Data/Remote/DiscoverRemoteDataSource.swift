//
//  DiscoverRemoteDataSource.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import Combine
import Alamofire

protocol DiscoverRemoteDataSourceProtocol {
    func getMovie(with id: Int) -> AnyPublisher<DiscoverResponse, NError>
}

class DiscoverRemoteDataSource: NSObject {
    
    private override init() {}
    
    static let sharedInstance = DiscoverRemoteDataSource()
}

extension DiscoverRemoteDataSource: DiscoverRemoteDataSourceProtocol{
    
    func getMovie(with id: Int) -> AnyPublisher<DiscoverResponse, NError> {
        
        let params: Parameters = ["api_key": "4b92f9b248d265764f53e0b869bebe4d",
                                  "with_genres": id]
        
        return Future<DiscoverResponse, NError> { completion in
            NetworkManager.sharedInstance.request(with: "/discover/movie", withParameter: params) { result in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                    break
                case let .success(data):
                    do{
                        let response = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                        completion(.success(response))
                    }catch {
                        completion(.failure(.serializationError))
                    }
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}
