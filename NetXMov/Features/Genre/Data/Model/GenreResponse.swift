//
//  GenreResponse.swift
//  NetXMov
//
//

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [GenreData]
}

// MARK: - Genre
struct GenreData: Codable {
    let id: Int
    let name: String
}
