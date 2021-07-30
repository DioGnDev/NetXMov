//
//  FavoriteInjection.swift
//  NetXMov
//

import Foundation
import RealmSwift

class FavoriteInjection {
  
  func provideRepository() -> FavoriteRepositoryProtocol {
    let realm = try? Realm()
    let locale = LocaleFavoriteDataSource.sharedInstance(realm)
    return FavoriteRepository.sharedInstance(locale)
  }
  
  func provideFavorite() -> FavoriteUsecase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
}
