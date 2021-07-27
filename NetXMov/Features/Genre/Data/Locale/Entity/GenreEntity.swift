//
//  GenreEntity.swift
//  NetXMov
//
//

import Foundation
import RealmSwift

class GenreEntity: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isChecked: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
