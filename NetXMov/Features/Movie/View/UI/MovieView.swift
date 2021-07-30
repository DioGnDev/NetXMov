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

struct PropertyView: View {
  
  var text: String
  var symbol: String
  var color: Color
  
  var body: some View {
    HStack {
      Image(systemName: symbol)
        .resizable()
        .foregroundColor(Color.white)
        .frame(width: 15, height: 15)
      
      Text(text)
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(Color.white)
        .multilineTextAlignment(.leading)
      
    }
    .padding(.trailing, 3)
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30)
    .background(color)
    .cornerRadius(25)
    .shadow(color: color.opacity(0.3), radius: 4, x: 0, y: 3)
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
