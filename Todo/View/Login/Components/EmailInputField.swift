//

import SwiftUI

struct EmailInputField: View {
    
    @Binding var email: String
    
    var body: some View {
        TodoTextInputField(
            hint: LocalizedStrings.email,
            text: .constant(
                ""
            ),
            image: "envelope"
        )
    }
}

#Preview {
    EmailInputField(email: .constant(""))
}
