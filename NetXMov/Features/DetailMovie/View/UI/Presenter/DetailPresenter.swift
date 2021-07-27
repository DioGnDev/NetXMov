//
//  DetailPresenter.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    
    @Published var movie: DiscoverModel
    @Published var reviews: [ReviewModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let reviewUsecase: ReviewUsecase
    
    init(reviewUsecase: ReviewUsecase) {
        self.reviewUsecase = reviewUsecase
        self.movie = reviewUsecase.getDiscover()
    }
    
    func getReviews(from movieId: Int){
        reviewUsecase.getReviews(from: movieId)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result{
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.description
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { reviews in
                self.reviews = reviews
            }.store(in: &cancellables)
    }
}
