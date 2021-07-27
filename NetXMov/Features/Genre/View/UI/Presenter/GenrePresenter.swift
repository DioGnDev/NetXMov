//
//  GenrePresenter.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 23/07/21.
//

import Foundation
import Combine
import SwiftUI

class GenrePresenter: ObservableObject {
    
    private let router = GenreRouter()
    private var cancellables: Set<AnyCancellable> = []
    private let usecase: GenreUseCase
    private let favUsecase: FavoriteUsecase
    private let discoverUsecase: DiscoverUseCase
    
    //Publisher
    @Published var isLoading: Bool = true
    @Published var genres: [GenreModel] = []
    @Published var movies: [DiscoverModel] = []
    @Published var error: String = ""
    
    init(usecase: GenreUseCase, discoverUsecase: DiscoverUseCase, favUsecase: FavoriteUsecase) {
        self.usecase = usecase
        self.favUsecase = favUsecase
        self.discoverUsecase = discoverUsecase
    }
    
    func getGenres(){
        isLoading = true
        usecase.getGenres()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.isLoading = false
                    self.error = error.description
                case .finished:
                    self.isLoading = false
                    if let selectedGenre =  self.genres.filter({ $0.isChecked == true }).first{
                        //discover movie with genre
                        self.getDiscoveryMovie(with: selectedGenre.id)
                    }
                }
            } receiveValue: { genres in
                self.isLoading = false
                self.genres = genres
            }.store(in: &cancellables)
    }
    
    func getDiscoveryMovie(with id: Int){
        self.isLoading = true
        discoverUsecase.getMovie(with: id)
            .receive(on: RunLoop.main)
            .sink { result in
                switch result{
                case .failure(let error):
                    self.isLoading = false
                    self.error = error.description
                case .finished:
                    self.isLoading = false
                    break
                }
            } receiveValue: { model in
                self.isLoading = false
                self.movies = model
            }.store(in: &cancellables)
        
    }
    
    func addFavorite(from movie: DiscoverModel){
        discoverUsecase.addFavorite(from: movie)
            .sink { result in
                
            } receiveValue: { succeeded in
                
            }.store(in: &cancellables)
    }
    
    func deleteFavorite(from movieId: Int) {
        favUsecase.deleteFavorite(from: movieId)
            .sink { result in
                switch result {
                case .failure(let error):
                    print("error", error.description)
                    break
                case .finished:
                    break
                }
            } receiveValue: { succeeded in
                print("success", succeeded)
            }.store(in: &cancellables)
        
    }
    
    //make favorite
    func makefavorite(index: Int){
        movies[index].isFavourite.toggle()
    }
    
    //choosing genre
    func tapGenre(with index: Int, completion: @escaping (Int) -> Void){
        for i in 0 ..< self.genres.count {
            self.genres[i].isChecked = (i == index) ? true : false
        }
        let genreId = self.genres[index].id
        completion(genreId)
        
    }
    
    //Goto Detail Movie
    func linkBuilder<Content: View>(for movie: DiscoverModel,
                                    @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: movie),
            label: {
                content()
            })
        
    }
    
}
