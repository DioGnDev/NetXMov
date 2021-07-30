//
//  LocaleFavoriteDataSource.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 25/07/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleFavoriteDataSourceProtocol {
  func getFavorites() -> Observable<[FavoriteEntity]>
  func deleteFavorite(from movieId: Int) -> Observable<Bool>
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
  
  func getFavorites() -> Observable<[FavoriteEntity]> {
    return Observable<[FavoriteEntity]>.create { observer in
      if let realm = self.realm {
        let results: Results<FavoriteEntity> = {
          realm.objects(FavoriteEntity.self).sorted(byKeyPath: "title", ascending: true)
        }()
        
        let entities = Array(results)
        observer.onNext(entities)
        observer.onCompleted()
      }else{
        observer.onError(DatabaseError.invalidInstance)
      }
      return Disposables.create()
    }
  }
  
  func deleteFavorite(from movieId: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      if let realm = self.realm {
        DispatchQueue.main.async {
          do {
            try realm.write{
              if let entity = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: movieId) {
                realm.delete(entity)
                observer.onNext(true)
              }
            }
          }catch{
            observer.onError(DatabaseError.requestFailed)
          }
        }
      }
      return Disposables.create()
    }
  }
  
}
