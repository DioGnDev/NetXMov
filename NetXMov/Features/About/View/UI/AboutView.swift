//
//  AboutView.swift
//  NetXMov
//
//  Created by TMLI IT DEV on 27/07/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            VStack {
                AvatarView(name: "avatar", size: .init(width: 80, height: 80))
                    .padding(.all, 20)
            }.frame(maxWidth: .infinity)
            
            Textview(title: "Full Name", value: "Ilham Hadi Prabawa")
            
            Textview(title: "Address", value: "Kesamben, Blitar")
            
            Textview(title: "Job", value: "iOS Developer")
            
            Textview(title: "About Me", value: "Always Learning")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct AvatarView: View {
    
    let name: String
    let size: CGSize
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipShape(Circle())
            .shadow(radius: 20)
    }
}

struct Textview: View {
    
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
