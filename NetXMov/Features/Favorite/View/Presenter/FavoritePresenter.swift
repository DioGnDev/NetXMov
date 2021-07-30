//
//  FavoritePresenter.swift
//  NetXMov
//
//

import Foundation
import SwiftUI
import Combine

protocol FavoritePresenterProtocol: BasePresenter {
  func getFavorites()
}

class FavoritePresenter: ObservableObject, FavoritePresenterProtocol {
  @Published var favorites: [DiscoverModel] = []
  @Published var errorMessage: String = ""
  
  private let router = FavoriteRouter()
  private var usecase: FavoriteUsecase
  private var cancellables = Set<AnyCancellable>()
  
  init(usecase: FavoriteUsecase) {
    self.usecase = usecase
  }
  
  func getFavorites(){
    usecase.getFavorites()
      .sink { result in
        switch result {
        case .failure(let error):
          print("error \(error)")
          break
        case .finished:
          break
        }
      } receiveValue: { favorites in
        self.favorites = favorites
      }.store(in: &cancellables)
  }
  
  func deleteFavorite(at index: Int) {
    let movieID = favorites[index].id
    usecase.deleteFavorite(from: movieID)
      .sink(receiveCompletion: { result in
        switch result {
        case .failure(let error):
          print("error \(error)")
          break
        case .finished:
          break
        }
      }, receiveValue: { succeeded in
        self.favorites.remove(at: index)
      }).store(in: &cancellables)
  }
  
  func makefavorite(at index: Int) {
    favorites[index].isFavourite.toggle()
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
