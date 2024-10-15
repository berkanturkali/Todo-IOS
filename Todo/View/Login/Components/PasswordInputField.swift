//

import SwiftUI

struct PasswordInputField: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack {
            TodoTextInputField(
                hint: LocalizedStrings.password,
                text: $password,
                image: "key"
            )
        }
    }
}

#Preview {
    PasswordInputField(password: .constant(""))
}
