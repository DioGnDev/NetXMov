//
//  LocaleMovieDataSource.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 26/07/21.
//

import Foundation
import Foundation
import RxSwift
import RealmSwift

protocol LocaleMovieDataSourceProtocol {
  func addFavourite(from movie: FavoriteEntity) -> Observable<Bool>
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
  
  func addFavourite(from movie: FavoriteEntity) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      guard let realm = self.realm else {
        observer.onError(DatabaseError.invalidInstance)
        return Disposables.create()
      }
      
      DispatchQueue.main.async {
        do {
          try realm.write{
            realm.add(movie, update: .all)
          }
          observer.onNext(true)
          observer.onCompleted()
        }catch {
          observer.onError(DatabaseError.saveFailed)
        }
      }
      return Disposables.create()
    }
  }
  
}
