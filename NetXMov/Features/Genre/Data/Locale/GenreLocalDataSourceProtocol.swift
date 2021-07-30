//
//  GenreLocalDataSourceProtocol.swift
//  NetXMov
//
//

import Foundation
import Combine
import RealmSwift

protocol GenreLocalDataSourceProtocol {
  func getGenres() -> AnyPublisher<[GenreEntity], DatabaseError>
}

class GenreLocalDataSource: NSObject {
  
  private let realm: Realm?
  
  init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> GenreLocalDataSourceProtocol = { realmDB in
    return GenreLocalDataSource(realm: realmDB)
  }
  
}

extension GenreLocalDataSource: GenreLocalDataSourceProtocol{
  
  func getGenres() -> AnyPublisher<[GenreEntity], DatabaseError> {
    return Future<[GenreEntity], DatabaseError> { completion in
      
    }.eraseToAnyPublisher()
  }
  
}
