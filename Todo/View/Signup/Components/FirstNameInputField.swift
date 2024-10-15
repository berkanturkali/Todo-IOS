//

import SwiftUI

struct FirstNameInputField: View {
    
    @Binding var firstName: String
    
    var body: some View {
        TodoTextInputField(
            hint: LocalizedStrings.firstName,
            text: $firstName,
            image: "person.circle"
        )
    }
}

#Preview {
    FirstNameInputField(firstName: .constant(""))
}
