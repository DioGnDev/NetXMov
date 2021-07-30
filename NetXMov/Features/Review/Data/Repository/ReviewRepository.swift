//
//  ReviewRepository.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 25/07/21.
//

import Foundation
import Combine

protocol ReviewRepositoryProtocol{
  func getReview(from movieId: Int) -> AnyPublisher<[ReviewModel], NError>
}

class ReviewRepository {
  
  private let datasource: ReviewRemoteDataSourceProtocol
  
  private init(datasource: ReviewRemoteDataSourceProtocol) {
    self.datasource = datasource
  }
  
  static let sharedInstance: (ReviewRemoteDataSourceProtocol) -> ReviewRepositoryProtocol = { datasource in
    return ReviewRepository(datasource: datasource)
  }
}

extension ReviewRepository: ReviewRepositoryProtocol {
  
  func getReview(from movieId: Int) -> AnyPublisher<[ReviewModel], NError> {
    return datasource.getReviews(from: movieId).map { response in
      response.results?.map({ result in
        ReviewModel(name: result.authorDetails?.username ?? "",
                    avatar: result.authorDetails?.avatarPath?.toURL(),
                    rating: result.authorDetails?.rating ?? 0,
                    content: result.content ?? "",
                    cretedAt: result.createdAt ?? "")
      }) ?? []
      
    }.eraseToAnyPublisher()
  }
}
