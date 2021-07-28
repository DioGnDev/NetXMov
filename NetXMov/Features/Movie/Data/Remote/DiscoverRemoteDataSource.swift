//
//  DiscoverRemoteDataSource.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import RxSwift
import Alamofire

protocol DiscoverRemoteDataSourceProtocol {
    func getMovie(with id: Int) -> Observable<DiscoverResponse>
}

class DiscoverRemoteDataSource: NSObject {
    
    private override init() {}
    
    static let sharedInstance = DiscoverRemoteDataSource()
}

extension DiscoverRemoteDataSource: DiscoverRemoteDataSourceProtocol{
    
    func getMovie(with id: Int) -> Observable<DiscoverResponse> {
        
        let params: Parameters = ["api_key": "4b92f9b248d265764f53e0b869bebe4d",
                                  "with_genres": id]
        
        return Observable<DiscoverResponse>.create { observer in
            NetworkManager.sharedInstance.request(with: "/discover/movie", withParameter: params) { result in
                switch result {
                case let .failure(error):
                    observer.onError(error)
                case let .success(data):
                    do{
                        let response = try JSONDecoder().decode(DiscoverResponse.self, from: data)
                        observer.onNext(response)
                        observer.onCompleted()
                    }catch {
                        observer.onError(error)
                    }
                    break
                }
            }
            
            return Disposables.create()
        }
        
    }

}
