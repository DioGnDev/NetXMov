//
//  GenreUseCase.swift
//  NetXMov
//
//

import Foundation
import RxSwift

protocol GenreUseCase {
    func getGenres() -> Observable<[GenreModel]>
}

class GenreInteractor: GenreUseCase{
    
    private let repository: GenreRepositoryProtocol
    
    required init(repository: GenreRepositoryProtocol){
        self.repository = repository
    }
    
    func getGenres() -> Observable<[GenreModel]> {
        return repository.getGenres()
    }
    
}
