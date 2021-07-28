//
//  FavoriteUsecase.swift
//  NetXMov
//
//

import Foundation
import RxSwift

protocol FavoriteUsecase {
    func getFavorites() -> Observable<[DiscoverModel]>
    func deleteFavorite(from movieId: Int) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUsecase {
    
    private let repository: FavoriteRepositoryProtocol
    
    required init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> Observable<[DiscoverModel]> {
        return repository.getFavorites()
    }
    
    func deleteFavorite(from movieId: Int) -> Observable<Bool> {
        return repository.deleteFavorite(from: movieId)
    }

}
