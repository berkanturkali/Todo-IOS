//

import SwiftUI

struct LoginButton: View {
    var body: some View {
        Button(action: {
            print("Button tapped!")
        }) {
            Text(LocalizedStrings.login)
                .font(.custom(Typeface.semibold, size: 16))
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .cornerRadius(8)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10
                    ).stroke(
                        .gray,
                        lineWidth: 2
                    ).fill(
                        Color.background
                    )
                    .modifier(
                        ShadowModifier(
                            x: 8,
                            y: 8
                        )
                    )
                    
                )
                .foregroundColor(.text)
            
        }
    }
}



#Preview {
    LoginButton()
}
