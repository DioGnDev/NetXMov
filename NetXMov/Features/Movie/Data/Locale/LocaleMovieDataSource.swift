//
//  LocaleMovieDataSource.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 26/07/21.
//

import Foundation
import Foundation
import Combine
import RealmSwift

protocol LocaleMovieDataSourceProtocol {
    func addFavourite(from movie: FavoriteEntity) -> AnyPublisher<Bool, DatabaseError>
}

class LocaleMovieDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleMovieDataSourceProtocol = { db in
        return LocaleMovieDataSource(realm: db)
    }
}

extension LocaleMovieDataSource: LocaleMovieDataSourceProtocol {
    
    func addFavourite(from movie: FavoriteEntity) -> AnyPublisher<Bool, DatabaseError> {
        
        return Future<Bool, DatabaseError> { completion in
            
            guard let realm = self.realm else {
                completion(.failure(.invalidInstance))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    try realm.write{
                        realm.add(movie, update: .all)
                    }
                    completion(.success(true))
                }catch {
                    completion(.failure(.saveFailed))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
}
