//
//  FavoriteRepository.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 26/07/21.
//

import Foundation
import Combine
import RealmSwift

protocol FavoriteRepositoryProtocol{
    func getFavorites() -> AnyPublisher<[DiscoverModel], DatabaseError>
    func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class FavoriteRepository: NSObject {
    
    typealias FavoriteInstance = (LocaleFavoriteDataSourceProtocol) -> FavoriteRepositoryProtocol
    
    private let localeDataSource: LocaleFavoriteDataSourceProtocol
   
    private init(localeDataSource: LocaleFavoriteDataSourceProtocol) {
        
        self.localeDataSource = localeDataSource

    }
    
    static let sharedInstance: FavoriteInstance = { local in
        return FavoriteRepository(localeDataSource: local)
    }
}

extension FavoriteRepository: FavoriteRepositoryProtocol{
    
    func getFavorites() -> AnyPublisher<[DiscoverModel], DatabaseError> {
        return localeDataSource.getFavorites().map { entities in
            entities.map { DiscoverModel(id: $0.id,
                                         imgThumbnail: DiscoverModel.transformImage(img: $0.imgThumbnail),
                                         title: $0.title, overview: $0.overview,
                                         popularity: $0.popularity,
                                         releaseDate: $0.releaseDate,
                                         isFavourite: $0.isFavourite) }
        }.eraseToAnyPublisher()
    }
    
    func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError> {
        return localeDataSource.deleteFavorite(from: movieId)
    }
    
    
    
}
