//
//  MainView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. DEV on 23/07/21.
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
                .renderingMode(.original)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7542790771, blue: 0.7742473483, alpha: 1)))
            }
          )
          
          NavigationLink(
            destination: AboutView(),
            label: {
              Image(systemName: "person.circle")
                .background(Color(#colorLiteral(red: 0, green: 0.7542790771, blue: 0.7742473483, alpha: 1)))
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

struct ContentView: View {
  
  @ObservedObject var presenter: GenrePresenter
  
  var body: some View {
    VStack {
      if presenter.isLoading {
        VStack {
          ProgressView("Loading...")
            .offset(x: 0, y: -70)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }else {
        if presenter.error.isEmpty{
          MovieView(presenter: presenter)
        }else{
          VStack {
            VStack {
              Image("note")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 120)
              
              Text("Sorry movies not found")
            }
            .offset(x: 0, y: -80)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}
