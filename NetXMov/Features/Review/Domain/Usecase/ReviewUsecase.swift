//
//  ReviewUsecase.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 25/07/21.
//

import Foundation
import Combine

protocol ReviewUsecase {
  func getReviews(from movieId: Int) -> AnyPublisher<[ReviewModel], NError>
  func getDiscover() -> DiscoverModel
}

class ReviewInteractor: ReviewUsecase {
  
  private let repository: ReviewRepositoryProtocol
  private let movie: DiscoverModel
  
  required init(repository: ReviewRepositoryProtocol, movie: DiscoverModel){
    self.repository = repository
    self.movie = movie
  }
  
  func getReviews(from movieId: Int) -> AnyPublisher<[ReviewModel], NError> {
    return repository.getReview(from: movieId)
  }
  
  func getDiscover() -> DiscoverModel {
    return movie
  }
}
