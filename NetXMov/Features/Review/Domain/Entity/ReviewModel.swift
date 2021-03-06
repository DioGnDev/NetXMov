//
//  ReviewModel.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import Foundation

struct ReviewModel: Hashable{
    let name: String
    let avatar: URL?
    let rating: Int
    let content: String
    let cretedAt: String
}
