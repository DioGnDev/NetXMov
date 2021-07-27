//
//  DiscoverInjection.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation
import RealmSwift

class DiscoverInjection {
    
    func provideRepository() -> DiscoverRepositoryProtocol {
        let realm = try? Realm()
        let locale = LocaleMovieDataSource.sharedInstance(realm)
        let remote = DiscoverRemoteDataSource.sharedInstance
        return DiscoverRepository.sharedInstance(locale, remote)
    }
    
    func provideDiscover() -> DiscoverUseCase {
        let repository = provideRepository()
        return DiscoverInteractor(repository: repository)
    }
}
