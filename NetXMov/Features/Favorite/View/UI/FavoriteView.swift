//
//  FavoriteView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 26/07/21.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var presenter: FavoritePresenter
  
  var body: some View {
    List{
      ForEach(presenter.favorites.indices, id: \.self) { index in
        presenter.linkBuilder(for: presenter.favorites[index]) {
          FavoriteRow(movie: $presenter.favorites[index])
        }
      }.onDelete { indexSet in
        presenter.deleteFavorite(at: indexSet.first!)
      }
    }
    .listStyle(PlainListStyle())
    .onAppear{
      presenter.getFavorites()
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView(presenter: FavoritePresenter(usecase: FavoriteInjection.init().provideFavorite()))
  }
}
