//
//  MovieRow.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    
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
                HStack {
                    Text(movie.title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: movie.isFavourite || isFavourite ? "suit.heart.fill" : "suit.heart")
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.pink)
                        .onTapGesture {
                            onTapped?()
                            isFavourite.toggle()
                        }
                }
                
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


struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: .constant(DiscoverModel.init()))
    }
}
