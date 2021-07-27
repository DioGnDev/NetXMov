//
//  NetXMovTests.swift
//  NetXMovTests
//
//  Created by TMLI IT DEV on 23/07/21.
//

import XCTest
import Alamofire
import Combine
@testable import NetXMov

class NetXMovTests: XCTestCase {
    
    func testReviewUsecase(){
        let interactor = ReviewInteractorMock(repository: DetailInjection.init().provideRepository())
        let result = interactor.getContent()
        XCTAssertEqual("Kamurai", result)
        
    }
}

class ReviewInteractorMock: ReviewUsecase{
    
    var cancellables = Set<AnyCancellable>()
    
    let repository: ReviewRepositoryProtocol
    
    init(repository: ReviewRepositoryProtocol){
        self.repository = repository
    }
    
    func getReviews(from movieId: Int) -> AnyPublisher<[ReviewModel], NError> {
        return repository.getReview(from: movieId)
    }
    
    func getContent() -> String{
        var message = ""
        getReviews(from: 615658)
            .receive(on: RunLoop.main)
            .sink { _ in
            } receiveValue: { models in
                message = models[0].name
            }.store(in: &cancellables)

        return message
    }
    
    func getDiscover() -> DiscoverModel {
        fatalError()
    }
}
