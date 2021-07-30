//
//  ReviewInjection.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 25/07/21.
//

import Foundation

class ReviewInjection {
  func provideRepository() -> ReviewRepositoryProtocol {
    let datasource = ReviewRemoteDataSource.sharedInstance
    return ReviewRepository.sharedInstance(datasource)
  }
  
  func provideReview(movie: DiscoverModel) -> ReviewUsecase {
    let repository = provideRepository()
    return ReviewInteractor(repository: repository, movie: movie)
  }
}
