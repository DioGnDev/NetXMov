//
//  FavoritePresenter.swift
//  NetXMov
//
//

import Foundation
import SwiftUI
import RxSwift

protocol FavoritePresenterProtocol: BasePresenter {
  func getFavorites()
}

class FavoritePresenter: ObservableObject, FavoritePresenterProtocol {
  @Published var favorites: [DiscoverModel] = []
  @Published var errorMessage: String = ""
  
  private let router = FavoriteRouter()
  private var usecase: FavoriteUsecase
  private var disposeBag = DisposeBag()
  
  init(usecase: FavoriteUsecase) {
    self.usecase = usecase
  }
  
  func getFavorites(){
    usecase.getFavorites()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { favorites in
        self.favorites = favorites
      }, onError: { error in
        print("error", error.localizedDescription)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
  
  func deleteFavorite(at index: Int) {
    let movieID = favorites[index].id
    
    usecase.deleteFavorite(from: movieID)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { succeeded in
        self.favorites.remove(at: index)
      }, onError: { error in
        print("error", error.localizedDescription)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
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
