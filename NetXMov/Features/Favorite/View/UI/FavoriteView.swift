//
//  FavoriteView.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 26/07/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter

    var body: some View {
        List{
            ForEach(presenter.favorites.indices, id: \.self) { index in
                MovieRow(movie: $presenter.favorites[index])
            }.onDelete { indexSet in
                presenter.deleteMovie(at: indexSet.first!)
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
