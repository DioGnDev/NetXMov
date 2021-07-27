//
//  DetailReview.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 25/07/21.
//

import SwiftUI

struct DetailReview: View {
    
    var review: ReviewModel
    var onTapped: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Text("Tap to hide")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    
            }
            .frame(width: 120, height: 30)
            .background(Color(#colorLiteral(red: 0, green: 0.7542790771, blue: 0.7742473483, alpha: 1)))
            .cornerRadius(30)
            .onTapGesture {
                onTapped?()
            }
            
            ScrollView(showsIndicators: false){
                Text(review.content)
                    .font(.subheadline)
                    .lineSpacing(4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 50)
            }
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .background(BlurView(blurStyle: .systemUltraThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
struct DetailReview_Previews: PreviewProvider {
    static var previews: some View {
        DetailReview(review: .init(name: "Author",
                                   avatar: URL(string: ""),
                                   rating: 7,
                                   content: "Lorem ipmsum",
                                   cretedAt: "2021-04-04"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
