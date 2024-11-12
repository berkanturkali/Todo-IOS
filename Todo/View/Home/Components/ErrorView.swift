//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    
    let onRetry: () -> Void
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                Text(message)
                    .font(.custom(Typeface.semibold, size: 18))
                    .foregroundColor(.text)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.horizontal)
                
                Text(LocalizedStrings.retry)
                    .font(.custom(Typeface.semibold, size: 16))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .cornerRadius(8)
                    .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
                    .foregroundColor(.text)
                    .onTapGesture {
                        onRetry()
                    }
                
            }
        }
    }
}

#Preview {
    ErrorView(message: LocalizedStrings.somethingWentWrong) {
        
    }
}
