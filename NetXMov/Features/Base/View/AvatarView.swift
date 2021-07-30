//
//  AvatarView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import SwiftUI

struct AvatarView: View {
  
  let imgName: String
  let size: CGSize
  
  var body: some View {
    Image(imgName)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: size.width, height: size.height)
      .clipShape(Circle())
      .shadow(radius: 20)
  }
}

struct AvatarView_Previews: PreviewProvider {
  static var previews: some View {
    AvatarView(imgName: "Dio", size: CGSize(width: 100, height: 100))
  }
}
