//
//  GenreRespository.swift
//  NetXMov
//
//

import Foundation
import RxSwift

protocol GenreRepositoryProtocol {
    func getGenres() -> Observable<[GenreModel]>
}

class GenreRepository: GenreRepositoryProtocol {
    
    typealias GenreInstance = (GenreLocalDataSourceProtocol, GenreRemoteDataSourceProtocol) -> GenreRepositoryProtocol
    
    private let remoteDataSource: GenreRemoteDataSourceProtocol
    private let localDataSource: GenreLocalDataSourceProtocol
    
    private init(localDataSource: GenreLocalDataSourceProtocol,
                 remoteDataSource: GenreRemoteDataSourceProtocol) {
        
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    static let sharedInstance: GenreInstance = { (local, remote) in
        return GenreRepository(localDataSource: local, remoteDataSource: remote)
    }
    
    func getGenres() -> Observable<[GenreModel]> {
        return remoteDataSource.getGenres().map { response in
            response.genres.map { GenreModel(id: $0.id,
                                             name: $0.name,
                                             isChecked: $0.name.contains("Action") ? true : false) }
        }
    }
    
}
