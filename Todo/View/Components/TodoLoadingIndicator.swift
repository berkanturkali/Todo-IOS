//

import SwiftUI

struct TodoLoadingIndicator: View {
    
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 100, height: 100)
                .foregroundColor(.clear)
                .modifier(BackgroundModifier(shadowX: 4, shadowY: 4))
                .overlay {
                    Circle()
                        .trim(from: 0.2, to: 1)
                        .stroke(
                            .text,
                            style: StrokeStyle(
                                lineWidth: 5,
                                lineCap: .round
                            )
                        )
                    
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            .linear(duration: 1).repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                        .padding(30)
                }
            
        }
        .onAppear() {
            isAnimating.toggle()
        }
    }
}

#Preview {
    TodoLoadingIndicator()
}
