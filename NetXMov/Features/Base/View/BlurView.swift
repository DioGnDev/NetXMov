//
//  BlurView.swift
//  NetXMov
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
  typealias UIViewType = UIView
  var blurStyle: UIBlurEffect.Style
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: CGRect.zero)
    view.backgroundColor = .clear
    
    let blurEffect = UIBlurEffect(style: blurStyle)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    
    view.insertSubview(blurView, at: 0)
    
    blurView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    blurView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
}
