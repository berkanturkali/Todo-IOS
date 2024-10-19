//

import SwiftUI

struct TodoDialog: View {
    
    let message: String
    
    var body: some View {
        
        ZStack {
            Color.background.opacity(0.5).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
                .fill(Color.background)
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .padding(.horizontal, 50)
                .modifier(ShadowModifier(x: 8, y: 8))
                .overlay {
                    VStack(spacing: 8) {
                        Text(message)
                            .font(.custom(Typeface.medium, size: 14))
                            .padding()
                            .foregroundColor(Color.text)
                        
                        RoundedRectangle(cornerRadius: 10)
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
                                
                            }
                    }
                }
                .animation(.easeInOut, value: true)
        }
        
    }
}

#Preview {
    TodoDialog(message: LocalizedStrings.somethingWentWrong)
}
