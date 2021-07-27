//
//  DiscoverModel.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import Foundation

protocol MovieProtocol {
    static func transformImage(img: String) -> URL?
}

class DiscoverModel: MovieProtocol, Hashable {
    let id: Int
    let imgThumbnail: URL?
    let title: String
    let overview: String
    let popularity: Int
    let releaseDate: String
    var isFavourite: Bool = false
    
    init() {
        self.id = 0
        self.imgThumbnail = nil
        self.title = ""
        self.overview = ""
        self.popularity = 0
        self.releaseDate = ""
        self.isFavourite = false
    }
    
    init(id: Int,
         imgThumbnail: URL?,
         title: String,
         overview: String,
         popularity: Int,
         releaseDate: String,
         isFavourite: Bool = false) {
        
        self.id = id
        self.imgThumbnail = imgThumbnail
        self.title = title
        self.overview = overview
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.isFavourite = isFavourite
    }
    
    static func transformImage(img: String) -> URL? {
        let imageURL = "https://image.tmdb.org/t/p/w500/"
        let completePath = imageURL.appending(img)
        return URL(string: completePath)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DiscoverModel, rhs: DiscoverModel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}
