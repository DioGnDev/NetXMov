//
//  DiscoverRepository.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import Combine

protocol DiscoverRepositoryProtocol{
    func getMovie(with id: Int) -> AnyPublisher<[DiscoverModel], NError>
    func addFavorite(from movie: DiscoverModel) -> AnyPublisher<Bool, DatabaseError>
}

class DiscoverRepository: NSObject {
    
    typealias DiscoverInstance = (LocaleMovieDataSourceProtocol, DiscoverRemoteDataSourceProtocol) -> DiscoverRepositoryProtocol
    
    private let localeDataSource: LocaleMovieDataSourceProtocol
    private let remoteDataSource: DiscoverRemoteDataSourceProtocol
    
    private init(localeDataSource: LocaleMovieDataSourceProtocol,
                 remoteDataSource: DiscoverRemoteDataSourceProtocol) {
        
        self.localeDataSource = localeDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    static let sharedInstance: DiscoverInstance = { (local, remote) in
        return DiscoverRepository(localeDataSource: local, remoteDataSource: remote)
    }
}

extension DiscoverRepository: DiscoverRepositoryProtocol{
    
    func getMovie(with id: Int) -> AnyPublisher<[DiscoverModel], NError> {
        
        return remoteDataSource.getMovie(with: id)
            .map { response in
                response.results?.map { DiscoverModel(id: $0.id ?? 0,
                                                      imgThumbnail: DiscoverModel.transformImage(img: $0.posterPath ?? ""),
                                                      title: $0.title ?? "",
                                                      overview: $0.overview ?? "",
                                                      popularity: Int($0.popularity ?? 0),
                                                      releaseDate: $0.releaseDate?.formatDate() ?? "") } ?? []
            }.eraseToAnyPublisher()
    }
    
    func addFavorite(from movie: DiscoverModel) -> AnyPublisher<Bool, DatabaseError> {
        
        let entity = FavoriteEntity()
        entity.id = movie.id
        entity.imgThumbnail = movie.imgThumbnail?.absoluteString ?? ""
        entity.isFavourite = movie.isFavourite
        entity.overview = movie.overview
        entity.popularity = movie.popularity
        entity.releaseDate = movie.releaseDate
        entity.title = movie.title
       
        return localeDataSource.addFavourite(from: entity)
    }
}
