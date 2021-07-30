//
//  ReviewRow.swift
//  NetXMov
//
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewRow: View {
  
  var review: ReviewModel
  var onTapped: (() -> Void)?
  
  var body: some View {
    HStack(alignment: .top, spacing: 10){
      Image("user")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 35, height: 35)
        .clipShape(Circle())
        .shadow(color: Color(#colorLiteral(red: 0.4395326972, green: 0.8289964795, blue: 0.8276603222, alpha: 1)), radius: 5, x: 0, y: 0)
        .padding(.trailing, 4)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(review.name)
          .font(.body)
          .multilineTextAlignment(.leading)
        Text(review.content)
          .lineLimit(4)
          .font(.subheadline)
          .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
        Text(review.cretedAt)
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(.secondary)
      }
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 8)
    .onTapGesture {
      onTapped?()
    }
  }
}

struct ReviewRow_Previews: PreviewProvider {
  static var previews: some View {
    ReviewRow(review: .init(name: "Mantab",
                            avatar: URL(string: ""),
                            rating: 9,
                            content: "muantab film nya",
                            cretedAt: "20-10-2020"))
  }
}
