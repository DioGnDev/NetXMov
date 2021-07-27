//
//  GenreUseCase.swift
//  NetXMov
//
//

import Foundation
import Combine

protocol GenreUseCase {
    func getGenres() -> AnyPublisher<[GenreModel], NError>
}

class GenreInteractor: GenreUseCase{
    
    private let repository: GenreRepositoryProtocol
    
    required init(repository: GenreRepositoryProtocol){
        self.repository = repository
    }
    
    func getGenres() -> AnyPublisher<[GenreModel], NError> {
        return repository.getGenres()
    }
}
