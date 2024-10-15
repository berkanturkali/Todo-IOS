//

import SwiftUI

struct LoginScreenContent: View {
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            Text(LocalizedStrings.login)
                .font(.custom(Typeface.extraBold, size: 40))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 32)
                .padding(.top, 36)
            
            VStack(spacing: 24) {
                EmailInputField(email: .constant(""))
                PasswordInputField()
                LoginButton()
            }
            .padding(.vertical, 32)
            .modifier(BackgroundModifier())
            .padding(.horizontal)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

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


#Preview {
    LoginScreenContent()
}
