//
//  Modifier.swift
//  NetXMov
//

import Foundation
import SwiftUI

struct TitleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.font(.system(size: 22, weight: .bold, design: .rounded))
    }
}
