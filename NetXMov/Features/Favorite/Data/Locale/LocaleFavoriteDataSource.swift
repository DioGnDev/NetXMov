//
//  LocaleFavoriteDataSource.swift
//  NetXMov
//
//  Created by lham Hadi P. on 25/07/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocaleFavoriteDataSourceProtocol {
  func getFavorites() -> AnyPublisher<[FavoriteEntity], DatabaseError>
  func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError>
}

class LocaleFavoriteDataSource: NSObject {
  
  private let realm: Realm?
  
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleFavoriteDataSourceProtocol = { db in
    return LocaleFavoriteDataSource(realm: db)
  }
}

extension LocaleFavoriteDataSource: LocaleFavoriteDataSourceProtocol {
  
  func deleteFavorite(from movieId: Int) -> AnyPublisher<Bool, DatabaseError> {
    return Future<Bool, DatabaseError> { completion in
      if let realm = self.realm {
        DispatchQueue.main.async {
          do {
            try realm.write{
              if let entity = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieId) {
                realm.delete(entity)
                completion(.success(true))
              }
            }
          }catch{
            completion(.failure(.requestFailed))
          }
        }
      }
    }.eraseToAnyPublisher()
    
  }
  
  func getFavorites() -> AnyPublisher<[FavoriteEntity], DatabaseError> {
    return Future<[FavoriteEntity], DatabaseError> { completion in
      if let realm = self.realm {
        let results: Results<FavoriteEntity> = {
          realm.objects(FavoriteEntity.self).sorted(byKeyPath: "title", ascending: true)
        }()
        
        let entities = Array(results)
        completion(.success(entities))
      }else{
        completion(.failure(.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
