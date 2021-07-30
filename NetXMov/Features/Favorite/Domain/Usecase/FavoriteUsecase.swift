//
//  FavoriteUsecase.swift
//  NetXMov
//
//

import Foundation
import Combine

protocol FavoriteUsecase {
  func getFavorites() -> AnyPublisher<[DiscoverModel], DatabaseError>
  func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class FavoriteInteractor: FavoriteUsecase {
  
  private let repository: FavoriteRepositoryProtocol
  
  required init(repository: FavoriteRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavorites() -> AnyPublisher<[DiscoverModel], DatabaseError> {
    return repository.getFavorites()
  }
  
  func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError> {
    return repository.deleteFavorite(from: movieId)
  }
  
}
