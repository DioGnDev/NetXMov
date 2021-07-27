//
//  GenreRouter.swift
//  NetXMov
//

import Foundation
import SwiftUI

class GenreRouter {
    
    func makeDetailView(for movie: DiscoverModel) -> some View {
        
        let reviewUsecase = ReviewInjection.init().provideReview(movie: movie)
        let presenter = DetailPresenter(reviewUsecase: reviewUsecase)
        return DetailMovieView(presenter: presenter, showDetailReview: false,
                               model: .init(name: "",
                                            avatar: URL(string: ""),
                                            rating: 0,
                                            content: "",
                                            cretedAt: ""))
    }
    
}
