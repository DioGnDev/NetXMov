//
//  DiscoverUseCase.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import Combine

protocol DiscoverUseCase {
    func getMovie(with id: Int) -> AnyPublisher<[DiscoverModel], NError>
    func addFavorite(from movie: DiscoverModel) -> AnyPublisher<Bool, DatabaseError>
}

class DiscoverInteractor: DiscoverUseCase {
    
    private let repository: DiscoverRepositoryProtocol
    
    required init(repository: DiscoverRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovie(with id: Int) -> AnyPublisher<[DiscoverModel], NError> {
        return repository.getMovie(with: id)
    }
    
    func addFavorite(from movie: DiscoverModel) -> AnyPublisher<Bool, DatabaseError> {
        return repository.addFavorite(from: movie)
    }
}
