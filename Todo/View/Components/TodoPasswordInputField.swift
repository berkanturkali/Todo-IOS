//

import SwiftUI

struct TodoPasswordInputField: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isFocused: Bool
    var body: some View {
        HStack {
            Image(systemName: "key")
                .foregroundColor(.text.opacity(0.5))
            
            Group {
                if(isPasswordVisible) {
                    TextField(
                        LocalizedStrings.password,
                        text: $password,
                        prompt: Text(
                            LocalizedStrings.password
                        ).foregroundColor(
                            .text.opacity(
                                0.5
                            )
                        )
                    )
                    .focused($isFocused)
                    
                } else {
                    SecureField(
                        LocalizedStrings.password,
                        text: $password,
                        prompt: Text(
                            LocalizedStrings.password
                        ).foregroundColor(
                            .text.opacity(
                                0.5
                            )
                        )
                    )
                    .focused($isFocused)
                    
                }
            }
            .font(.custom(Typeface.light, size: 16))
            .keyboardType(.default)
            .textContentType(.password)
            .accentColor(.text)
            .foregroundColor(.text)
            
            if(!password.isEmpty) {
                Button {
                    
                    isPasswordVisible.toggle()
                    
                    DispatchQueue.main.async {
                        isFocused = true
                    }
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.text.opacity(0.5))
                }
                .padding(.trailing, 4)
                
            }
            
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
        .padding(.horizontal)
    }
}

#Preview {
    TodoPasswordInputField(password: .constant(""))
}
