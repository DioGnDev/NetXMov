//
//  DetailMovieView.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 24/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieView: View {
    
    @ObservedObject var presenter: DetailPresenter
    @State var showDetailReview: Bool
    @State var model: ReviewModel = ReviewModel(name: "", avatar: URL(string: ""), rating: 0, content: "", cretedAt: "")
    @State var cardHeight = CGSize.zero
    @State var showFull: Bool = false
    
    var body: some View {
        
        let movie = presenter.movie
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    DetailHeader(movie: movie)
                    
                    DetailOverview(movie: movie)
                    
                    if presenter.isLoading {
                        Text("Loading....")
                    }else {
                        if presenter.errorMessage.isEmpty {
                            VStack(spacing: 10) {
                                Text("Review")
                                    .modifier(TitleModifier())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ForEach(presenter.reviews, id: \.self) { review in
                                    ReviewRow(review: review){
                                        self.model = review
                                        self.showDetailReview.toggle()
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 10)
                        }
                    }
                }
                .onAppear{
                    presenter.getReviews(from: movie.id)
                }
            }
            
            DetailReview(review: model) {
                self.showDetailReview = false
            }
            .offset(x: 0, y: (showDetailReview) ? 50 : 1000)
            .offset(y: cardHeight.height)
            .animation(.spring())
        }
    }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(presenter: .init(reviewUsecase: ReviewInjection.init().provideReview(
                                            movie: DiscoverModel.init())),
                        showDetailReview: false,
                        model: ReviewModel(name: "",
                                           avatar: URL(string: ""),
                                           rating: 0,
                                           content: "",
                                           cretedAt: "")
        ).previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
