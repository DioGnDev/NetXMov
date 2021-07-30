//
//  ContentView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import SwiftUI

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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(presenter: GenrePresenter(usecase: Injection.init().provideGenre(),
                                          discoverUsecase: DiscoverInjection.init().provideDiscover(),
                                          favUsecase: FavoriteInjection.init().provideFavorite()))
  }
}
