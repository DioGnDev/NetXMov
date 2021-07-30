//
//  GenreList.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 23/07/21.
//

import SwiftUI

struct GenreList: View {
  
  @Binding var genres: [GenreModel]
  var onTap: ((Int) -> Void)?
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack{
        ForEach(genres.indices, id: \.self) { index in
          GenreRow(genre: $genres[index])
            .onTapGesture {
              onTap?(index)
            }
        }
      }
      .padding(.all, 10)
    }
  }
}

struct GenreList_Previews: PreviewProvider {
  static var previews: some View {
    GenreList(genres: .constant([
      GenreModel(id: 1, name: "Comedy", isChecked: true),
      GenreModel(id: 1, name: "Action", isChecked: false),
      GenreModel(id: 1, name: "Drama", isChecked: false)
    ]))
  }
}
