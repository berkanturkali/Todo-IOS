//

import SwiftUI

struct LoginButton: View {
    
    let onButtonClick: () -> Void
    
    var body: some View {
        Button(action: {
            onButtonClick()
        }) {
            Text(LocalizedStrings.login)
                .font(.custom(Typeface.semibold, size: 16))
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .cornerRadius(8)
                .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
                .foregroundColor(.text)
            
        }
    }
}



#Preview {
    LoginButton(onButtonClick: {})
}
