//
//  ReviewRemoteDataSource.swift
//  NetXMov
//

import Foundation
import Combine
import Alamofire

protocol ReviewRemoteDataSourceProtocol {
  func getReviews(from movieId: Int) -> AnyPublisher<ReviewResponse, NError>
}

class ReviewRemoteDataSource: NSObject {
  
  private override init() {}
  
  static let sharedInstance = ReviewRemoteDataSource()
}

extension ReviewRemoteDataSource: ReviewRemoteDataSourceProtocol {
  
  func getReviews(from movieId: Int) -> AnyPublisher<ReviewResponse, NError> {
    
    let endpoint = "/movie/\(movieId)/reviews"
    let params: Parameters = ["api_key": "4b92f9b248d265764f53e0b869bebe4d"]
    
    return Future<ReviewResponse, NError> { completion in
      NetworkManager.sharedInstance.request(with: endpoint, withParameter: params) { result in
        switch result {
        case .failure(let error):
          completion(.failure(error))
        case .success(let data):
          do{
            let json = try JSONDecoder().decode(ReviewResponse.self, from: data)
            completion(.success(json))
          }catch {
            completion(.failure(.serializationError))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
