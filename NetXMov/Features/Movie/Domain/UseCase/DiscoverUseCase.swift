//
//  DiscoverUseCase.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import RxSwift

protocol DiscoverUseCase {
    func getMovie(with id: Int) -> Observable<[DiscoverModel]>
    func addFavorite(from movie: DiscoverModel) -> Observable<Bool>
}

class DiscoverInteractor: DiscoverUseCase {
    
    private let repository: DiscoverRepositoryProtocol
    
    required init(repository: DiscoverRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovie(with id: Int) -> Observable<[DiscoverModel]> {
        return repository.getMovie(with: id)
    }
    
    func addFavorite(from movie: DiscoverModel) -> Observable<Bool> {
        return repository.addFavorite(from: movie)
    }

}
