//

import SwiftUI

struct PasswordInputField: View {
    var body: some View {        
        HStack {
            Image(systemName: "key")
                .foregroundColor(.text)
                .padding(.vertical, 14)
                .padding(.horizontal)
            
            
            TextField(LocalizedStrings.password, text: .constant(""))
                .font(.custom(Typeface.light, size: 16))
                .autocapitalization(.none)
                .keyboardType(.default)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
                    x: 8, y: 8
                )
            )
        )
        .padding(.horizontal)
    }
}

#Preview {
    PasswordInputField()
}
