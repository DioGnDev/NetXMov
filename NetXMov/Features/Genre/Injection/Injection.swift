//
//  Injection.swift
//  NetXMov
//
//

import Foundation
import RealmSwift

class Injection{
    
    private func provideRepository() -> GenreRepositoryProtocol {
        let realm = try? Realm()
        let locale = GenreLocalDataSource.sharedInstance(realm)
        let remote = GenreRemoteDataSource.sharedInstance
        return GenreRepository.sharedInstance(locale, remote)
    }
    
    func provideGenre() -> GenreUseCase{
        let repository = provideRepository()
        return GenreInteractor(repository: repository)
    }

}
