//
//  PropertyView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import SwiftUI

struct PropertyView: View {
  
  var text: String
  var symbol: String
  var color: Color
  
  var body: some View {
    HStack {
      Image(systemName: symbol)
        .resizable()
        .foregroundColor(Color.white)
        .frame(width: 15, height: 15)
      
      Text(text)
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(Color.white)
        .multilineTextAlignment(.leading)
      
    }
    .padding(.trailing, 3)
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30)
    .background(color)
    .cornerRadius(25)
    .shadow(color: color.opacity(0.3), radius: 4, x: 0, y: 3)
  }
}

struct PropertyView_Previews: PreviewProvider {
  static var previews: some View {
    PropertyView(text: "", symbol: "", color: Color.black)
  }
}
