//

import SwiftUI

struct TodoTextInputField: View {
    
    let hint: String
    
    @Binding var text: String
    
    var image: String? = nil
    
    var keyboardType: UIKeyboardType = .default
    
    var autoCapitalization: UITextAutocapitalizationType = .none
    
    var textSize: CGFloat = 16
    
    var body: some View {
        HStack {
            if let image {
                Image(systemName: image)
                    .foregroundColor(.text)
            }
            
            TextField("Email", text: .constant(""))
                .font(.custom(Typeface.light, size: textSize))
                .autocapitalization(autoCapitalization)
                .keyboardType(keyboardType)
                .accentColor(.text)
            
            if(!text.isEmpty) {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle")
                        .foregroundColor(.text)
                    
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

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String
    
    func body(content: Content) -> some View {
        content.overlay {
            if !fieldText.isEmpty {
                HStack {
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        TodoTextInputField(hint: "Email", text: .constant(""), image: "envelope")
        TodoTextInputField(hint: "Email", text: .constant("asdasdsad"))
    }
}
