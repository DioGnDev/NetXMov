//
//  MovieView.swift
//  NetXMov
//
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieView: View {
  
  @ObservedObject var presenter: GenrePresenter
  
  var body: some View {
    List{
      ForEach(presenter.movies.indices, id: \.self) { index in
        VStack{
          presenter.linkBuilder(for: presenter.movies[index]) {
            MovieRow(movie: $presenter.movies[index]) {
              presenter.makefavorite(at: index)
              if presenter.movies[index].isFavourite == true{
                presenter.addFavorite(from: presenter.movies[index])
              }else{
                presenter.deleteFavorite(at: index)
              }
            }
          }
        }
      }
    }
    .listStyle(PlainListStyle())
  }
}

struct MovieView_Previews: PreviewProvider {
  static var previews: some View {
    //Usecase
    let usecase = Injection.init().provideGenre()
    let discoverUsecase = DiscoverInjection.init().provideDiscover()
    let favUsecase = FavoriteInjection.init().provideFavorite()
    let presenter = GenrePresenter(usecase: usecase, discoverUsecase: discoverUsecase, favUsecase: favUsecase)
    MovieView(presenter: presenter)
  }
}
