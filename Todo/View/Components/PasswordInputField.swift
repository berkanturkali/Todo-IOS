//

import SwiftUI

struct PasswordInputField: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack {
            TodoPasswordInputField(password: $password)
        }
    }
}

#Preview {
    PasswordInputField(password: .constant(""))
}
