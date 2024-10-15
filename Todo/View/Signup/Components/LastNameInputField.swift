//

import SwiftUI

struct LastNameInputField: View {
    
    @Binding var lastName: String
    
    var body: some View {
        TodoTextInputField(
            hint: LocalizedStrings.lastName,
            text: $lastName,
            image: "person.circle"
        )
    }
}

#Preview {
    LastNameInputField(lastName: .constant(""))
}
