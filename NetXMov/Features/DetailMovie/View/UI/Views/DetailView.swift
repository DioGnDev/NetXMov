//
//  DetailView.swift
//  NetXMov
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct propertyView: View {
    
    var title: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Text(value)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
        }
    }
}

struct DetailHeader: View {
    
    var movie: DiscoverModel
    
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: movie.imgThumbnail)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .cornerRadius(20)
                .padding(.all, 10)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 0)
            
            VStack(alignment: .leading, spacing: 20) {
                propertyView(title: "Title", value: movie.title)
                propertyView(title: "Popularity", value: "\(movie.popularity)")
                propertyView(title: "Release Date", value: movie.releaseDate)
                Spacer()
            }.padding(.top, 10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
}

struct DetailOverview: View {
    
    var movie: DiscoverModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Description")
                .modifier(TitleModifier())
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            Text(movie.overview)
                .italic()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 5)
    }
}
