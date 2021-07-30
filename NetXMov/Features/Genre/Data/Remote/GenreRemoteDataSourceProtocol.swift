//
//  RemoteDataSource.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 23/07/21.
//

import Foundation
import Alamofire
import RxSwift

protocol GenreRemoteDataSourceProtocol {
  func getGenres() -> Observable<GenreResponse>
}

class GenreRemoteDataSource: NSObject {
  
  private override init() {}
  
  static let sharedInstance = GenreRemoteDataSource()
}

extension GenreRemoteDataSource: GenreRemoteDataSourceProtocol {
  
  func getGenres() -> Observable<GenreResponse> {
    
    let params = ["api_key": "4b92f9b248d265764f53e0b869bebe4d"]
    
    return Observable<GenreResponse>.create { observer in
      NetworkManager.sharedInstance.request(with: "/genre/movie/list", withParameter: params) { result in
        switch result{
        case let .failure(error):
          observer.onError(error)
        case let .success(data):
          do {
            let response = try JSONDecoder().decode(GenreResponse.self, from: data)
            observer.onNext(response)
            observer.onCompleted()
          }catch{
            observer.onError(NError.parseError)
          }
          
        }
      }
      
      return Disposables.create()
    }
  }
}
