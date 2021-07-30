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

struct GenreRow: View{
  
  @Binding var genre: GenreModel
  
  var body: some View{
    VStack {
      Text(genre.name)
        .font(.body)
        .fontWeight(.semibold)
        .foregroundColor(genre.isChecked ? Color.white : Color(white: 0.5))
        .multilineTextAlignment(.center)
    }
    .padding(.horizontal, 15)
    .frame(minWidth: 80, minHeight: 30)
    .background(genre.isChecked ? Color(#colorLiteral(red: 0, green: 0.7542790771, blue: 0.7742473483, alpha: 1)) : Color.white)
    .cornerRadius(25)
    .shadow(color: genre.isChecked ?
              Color(#colorLiteral(red: 0, green: 0.7542790771, blue: 0.7742473483, alpha: 1)).opacity(0.3) :
              Color.black.opacity(0.2), radius: 4, x: 0, y: 3)
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
