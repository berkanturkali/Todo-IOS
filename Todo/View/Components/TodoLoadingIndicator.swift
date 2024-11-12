//

import SwiftUI

struct TodoLoadingIndicator: View {
    
    var size: CGFloat = 100
    
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.3).ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: size, height: size)
                .foregroundColor(.clear)
                .modifier(BackgroundModifier(shadowX: 4, shadowY: 4))
                .overlay {
                    Circle()
                        .trim(from: 0.2, to: 1)
                        .stroke(
                            .text,
                            style: StrokeStyle(
                                lineWidth: size / 20,
                                lineCap: .round
                            )
                        )
                    
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            .linear(duration: 1).repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                        .frame(width: size / 2.5, height: size / 2.5)
                        .padding(30)
                }
            
        }
        .onAppear() {
            isAnimating.toggle()
        }
    }
}

#Preview {
    VStack {
        TodoLoadingIndicator()
        TodoLoadingIndicator(size: 50)
    }
    
}
