//
//  AboutView.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 27/07/21.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    List {
      VStack {
        AvatarView(imgName: "avatar", size: .init(width: 80, height: 80))
          .padding(.all, 20)
      }.frame(maxWidth: .infinity)
      
      TextView(title: "Full Name", value: "Ilham Hadi Prabawa")
      TextView(title: "Address", value: "Kesamben, Blitar")
      TextView(title: "Job", value: "iOS Developer")
      TextView(title: "About Me", value: "Always Learning")
    }
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
