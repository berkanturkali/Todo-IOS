//

import SwiftUI

struct TodoDialog: View {
    
    let message: String
    
    @Binding var isVisible: Bool
    
    let onOkayButtonClick: () -> Void
    
    @State private var dialogOffset: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            if isVisible {
                
                Color.background
                    .opacity(
                        0.5
                    )
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
                    .fill(Color.background)
                    .frame(height: 150)
                    .padding(.horizontal, 50)
                    .modifier(ShadowModifier(x: 8, y: 8))
                    .overlay {
                        VStack(spacing: 12) {
                            Text(message)
                                .font(.custom(Typeface.medium, size: 14))
                                .padding(.horizontal, 70)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .foregroundColor(Color.text)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .fill(Color.background)
                                .frame(width: 120, height: 35)
                                .modifier(ShadowModifier(x: 4, y: 3))
                                .overlay {
                                    Text(LocalizedStrings.okay)
                                        .font(.custom(Typeface.medium, size: 12))
                                        .padding(.horizontal, 40)
                                        .padding(.vertical, 10)
                                        .foregroundColor(Color.text)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        dialogOffset = UIScreen.main.bounds.height
                                    }
                                    isVisible = false
                                    onOkayButtonClick()
                                }
                            
                        }
                    }
                    .offset(y: dialogOffset)
                    .onAppear {
                        withAnimation(.snappy) {
                            dialogOffset = 0
                        }
                    }
            }
            
        }
        .animation(.snappy, value: isVisible)
    }
}

#Preview {
    VStack {
        TodoDialog(
            message: LocalizedStrings.firstNameAndLastNameAreRequired,
            isVisible: .constant(true),
            onOkayButtonClick: {
            }
        )
        
        TodoDialog(
            message: LocalizedStrings.somethingWentWrong,
            isVisible: .constant(true),
            onOkayButtonClick: {
            }
        )
    }
}
