//
//  RemoteDataSource.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 23/07/21.
//

import Foundation
import Combine
import Alamofire

protocol GenreRemoteDataSourceProtocol {
    func getGenres() -> AnyPublisher<GenreResponse, NError>
}

class GenreRemoteDataSource: NSObject {
    
    private override init() {}
    
    static let sharedInstance = GenreRemoteDataSource()
}

extension GenreRemoteDataSource: GenreRemoteDataSourceProtocol {
    
    func getGenres() -> AnyPublisher<GenreResponse, NError> {
        
        let params = ["api_key": "4b92f9b248d265764f53e0b869bebe4d"]
        
        return Future<GenreResponse, NError> { completion in
            NetworkManager.sharedInstance.request(with: "/genre/movie/list", withParameter: params) { result in
                switch result{
                case let .failure(error):
                    completion(.failure(error))
                case let .success(data):
                    do {
                        let response = try JSONDecoder().decode(GenreResponse.self, from: data)
                        completion(.success(response))
                    }catch{
                        completion(.failure(.parseError))
                    }
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
