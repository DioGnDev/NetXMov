//
//  TextView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import SwiftUI

struct TextView: View {
  var title: String
  var value: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.system(size: 14, weight: .medium, design: .default))
        .foregroundColor(Color.gray)
      
      Text(value)
        .font(.system(size: 18, weight: .medium, design: .rounded))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

struct TextView_Previews: PreviewProvider {
  static var previews: some View {
    TextView(title: "Full Name", value: "Ilham Hadi P.")
  }
}
