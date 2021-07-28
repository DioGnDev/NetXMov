//
//  FavoriteRepository.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 26/07/21.
//

import Foundation
import RxSwift
import RealmSwift

protocol FavoriteRepositoryProtocol{
    func getFavorites() -> Observable<[DiscoverModel]>
    func deleteFavorite(from movieId: Int) -> Observable<Bool>
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
    
    func getFavorites() -> Observable<[DiscoverModel]> {
        return localeDataSource.getFavorites().map { entities in
            entities.map { DiscoverModel(id: $0.id,
                                         imgThumbnail: DiscoverModel.transformImage(img: $0.imgThumbnail),
                                         title: $0.title, overview: $0.overview,
                                         popularity: $0.popularity,
                                         releaseDate: $0.releaseDate,
                                         isFavourite: $0.isFavourite) }
        }
    }
    
    func deleteFavorite(from movieId: Int) -> Observable<Bool> {
        return localeDataSource.deleteFavorite(from: movieId)
    }
    
}
