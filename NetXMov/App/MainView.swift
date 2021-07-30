//
//  MainView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 23/07/21.
//

import SwiftUI

struct MainView: View {
  
  @EnvironmentObject var presenter: GenrePresenter
  
  var body: some View {
    NavigationView {
      VStack{
        GenreList(genres: $presenter.genres) { index in
          presenter.tapGenre(with: index) { genreId in
            self.presenter.getDiscoveryMovie(with: genreId)
          }
        }
        ContentView(presenter: presenter)
      }.onAppear{
        if presenter.genres.count == 0 {
          self.presenter.getGenres()
        }
      }
      .navigationTitle(Text("Movies"))
      .toolbar {
        ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
          let usecase = FavoriteInjection.init().provideFavorite()
          let presenter = FavoritePresenter(usecase: usecase)
          
          NavigationLink(
            destination: FavoriteView(presenter: presenter),
            label: {
              Image(systemName: "list.bullet")
            }
          )
          
          NavigationLink(
            destination: AboutView(),
            label: {
              Image(systemName: "person.circle")
            }
          )
        }
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().environmentObject( GenrePresenter(
      usecase: Injection.init().provideGenre(),
      discoverUsecase: DiscoverInjection.init().provideDiscover(),
      favUsecase: FavoriteInjection.init().provideFavorite()
    ))
  }
}
