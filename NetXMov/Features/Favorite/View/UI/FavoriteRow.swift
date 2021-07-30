//
//  FavoriteRow.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
  @Binding var movie: DiscoverModel
  @State var isFavourite: Bool = false
  
  var onTapped : (() -> Void)?
  
  var body: some View {
    HStack(alignment: .top) {
      WebImage(url: movie.imgThumbnail)
        .resizable()
        .placeholder(Image("avenger"))
        .indicator(.activity)
        .animation(.default)
        .aspectRatio(contentMode: .fit)
        .frame(width: 100)
        .cornerRadius(20)
      
      VStack(alignment: .leading, spacing: 5){
        Text(movie.title)
          .font(.headline)
          .fontWeight(.medium)
          .foregroundColor(Color.black)
          .multilineTextAlignment(.leading)
        
        Text(movie.overview)
          .font(.subheadline)
          .fontWeight(.regular)
          .foregroundColor(Color.gray)
          .multilineTextAlignment(.leading)
          .lineLimit(3)
        
        Spacer()
        
        HStack {
          PropertyView(text: String(describing: movie.popularity),
                       symbol: "star.fill", color: Color(#colorLiteral(red: 0.261575371, green: 0.2410385311, blue: 0.2478922307, alpha: 1)))
          PropertyView(text: movie.releaseDate,
                       symbol: "clock.fill", color: Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
        }
        .padding(.bottom, 10)
      }
      .frame(maxWidth: .infinity)
      .padding(.leading, 5)
    }
  }
}

struct FavoriteRow_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteRow(movie: .constant(DiscoverModel.init()))
  }
}
