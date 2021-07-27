//
//  FavoritePresenter.swift
//  NetXMov
//
//

import Foundation
import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    @Published var favorites: [DiscoverModel] = []
    @Published var errorMessage: String = ""
    
    private var usecase: FavoriteUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FavoriteUsecase) {
        self.usecase = usecase
    }
    
    func getFavorites(){
        
        usecase.getFavorites()
            .receive(on: RunLoop.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.description)
                    break
                case .finished:
                    break
                }
            } receiveValue: { models in
                self.favorites = models
            }.store(in: &cancellables)
    }
    
    func deleteMovie(at index: Int){

        let movieID = favorites[index].id
        
        usecase.deleteFavorite(from: movieID)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.errorMessage = error.description
                case .finished:
                    break
                }
            } receiveValue: { succeed in
                self.favorites.remove(at: index)
            }.store(in: &cancellables)
    }
    
}
