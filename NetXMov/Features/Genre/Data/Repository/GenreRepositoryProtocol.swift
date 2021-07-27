//
//  GenreRespository.swift
//  NetXMov
//
//

import Foundation
import Combine

protocol GenreRepositoryProtocol {
    func getGenres() -> AnyPublisher<[GenreModel], NError>
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
    
    func getGenres() -> AnyPublisher<[GenreModel], NError> {
        return remoteDataSource.getGenres().map { result in
            result.genres.map { GenreModel(id: $0.id,
                                           name: $0.name,
                                           isChecked: $0.name.contains("Action") ? true : false) }
        }.eraseToAnyPublisher()
    }
}
