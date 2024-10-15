//

import Foundation
import SwiftUI

struct ShadowModifier: ViewModifier {
    
    var radius: CGFloat = 0
    let x: CGFloat
    let y: CGFloat
    var color: Color = .darkShadow
    func body(
        content: Content
    ) -> some View {
        content
            .shadow(
                color: color,
                radius: radius,
                x: x,
                y: y
            )
    }
}

struct BackgroundModifier: ViewModifier {
    
    var radius: CGFloat = 16
    var strokeColor: Color = .gray
    var strokeWidth: CGFloat = 2
    var fill: Color = Color.background
    
    var shadowX: CGFloat = 12
    var shadowY: CGFloat = 12
    var shadowRadius: CGFloat = 0
    var shadowColor: Color = .darkShadow
    
    func body(
        content: Content
    ) -> some View {
        content
            .background(
                RoundedRectangle(
                    cornerRadius: radius
                )
                .stroke(
                    strokeColor,
                    lineWidth: strokeWidth
                )
                .fill(
                    fill
                )
                .modifier(
                    ShadowModifier(
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY,
                        color: shadowColor
                    )
                )
            )
    }
}
