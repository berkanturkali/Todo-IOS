//

import SwiftUI

struct TodoDialog: View {
    
    let message: String
    
    let onOkayButtonClick: () -> Void
    
    var body: some View {
        
        ZStack {
            Color.background.opacity(0.9).ignoresSafeArea()
                .blur(radius: 10)
                .transition(.opacity)
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
                .fill(Color.background)
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .padding(.horizontal, 50)
                .modifier(ShadowModifier(x: 8, y: 8))
                .overlay {
                    VStack(spacing: 12) {
                        Text(message)
                            .font(.custom(Typeface.medium, size: 14))
                            .padding(.horizontal, 70)
                            .frame(height: 50)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .foregroundColor(Color.text)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                            .fill(Color.background)
                            .frame(width: 120, height: 30)
                            .modifier(ShadowModifier(x: 4, y: 3))
                            .overlay {
                                Text(LocalizedStrings.okay)
                                    .font(.custom(Typeface.medium, size: 12))
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 10)
                                    .foregroundColor(Color.text)
                            }
                            .onTapGesture {
                                onOkayButtonClick()
                            }
                    }
                }
                .animation(.easeInOut, value: true)
        }
        
    }
}

#Preview {
    VStack {
        TodoDialog(
            message: LocalizedStrings.firstNameAndLastNameAreRequired,
            onOkayButtonClick: {
            }
        )
        
        TodoDialog(
            message: LocalizedStrings.somethingWentWrong,
            onOkayButtonClick: {
            }
        )
    }
}
