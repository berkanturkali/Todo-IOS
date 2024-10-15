//

import SwiftUI

struct EmailInputField: View {
    
    @Binding var email: String
    
    var body: some View {
        TodoTextInputField(
            hint: LocalizedStrings.email,
            text: $email,
            image: "envelope"
        )
    }
}

#Preview {
    EmailInputField(email: .constant(""))
}
