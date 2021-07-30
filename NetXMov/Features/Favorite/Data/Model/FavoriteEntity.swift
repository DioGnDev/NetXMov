//
//  FavoriteModel.swift
//  NetXMov
//

import Foundation
import RealmSwift

class FavoriteEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var imgThumbnail: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var overview: String = ""
  @objc dynamic var popularity: Int = 0
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var isFavourite: Bool = false
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
