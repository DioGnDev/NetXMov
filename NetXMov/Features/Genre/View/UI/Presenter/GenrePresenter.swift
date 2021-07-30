//
//  GenrePresenter.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 23/07/21.
//

import Foundation
import RxSwift
import SwiftUI

protocol GenrePresenterProtocol: BasePresenter {
  func getGenres()
  func tapGenre(with index: Int, completion: @escaping (Int) -> Void)
}

class GenrePresenter: ObservableObject, GenrePresenterProtocol{
  
  private let router = GenreRouter()
  private var disposeBag = DisposeBag()
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
    self.isLoading = true
    usecase.getGenres()
      .observe(on: MainScheduler.instance)
      .subscribe { genres in
        self.isLoading = false
        self.genres = genres
      } onError: { error in
        self.isLoading = false
        self.error = error.localizedDescription
      } onCompleted: {
        self.isLoading = false
        let id = self.genres.filter{ $0.isChecked }.map{ $0.id }.first ?? 0
        self.getDiscoveryMovie(with: id)
      }.disposed(by: disposeBag)
    
  }
  
  func getDiscoveryMovie(with id: Int){
    self.isLoading = true
    discoverUsecase.getMovie(with: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { movies in
        self.isLoading = false
        self.movies = movies
      }, onError: { error in
        self.isLoading = false
      }, onCompleted: {
        self.isLoading = false
      }).disposed(by: disposeBag)
  }
  
  func addFavorite(from movie: DiscoverModel){
    discoverUsecase.addFavorite(from: movie)
      .subscribe { succeeded in
        
      } onError: { error in
        
      } onCompleted: {
        
      }.disposed(by: disposeBag)
    
  }
  func deleteFavorite(at index: Int) {
    let movieID = movies[index].id
    favUsecase.deleteFavorite(from: movieID)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { succeeded in
        
      }, onError: { error in
        
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
  
  //make favorite
  func makefavorite(at index: Int){
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
