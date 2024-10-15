//

import SwiftUI

struct SignupScreenContent: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var password: String
    
    let onSignupButtonClick: () -> Void
    
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                
                Text(LocalizedStrings.signup)
                    .font(
                        .custom(
                            Typeface.extraBold,
                            size: 40
                        )
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .topLeading
                    )
                    .foregroundColor(.text)
                
        
                
                VStack(spacing: 28) {
                    FirstNameInputField(firstName: $firstName)
                    
                    LastNameInputField(lastName: $lastName)
                    
                    EmailInputField(email: $email)
                    
                    PasswordInputField(password: $password)
                    
                    SignupButton(onButtonClick: onSignupButtonClick)
                    
                }
                .padding(.vertical, 32)
                .modifier(BackgroundModifier())
            }
            .padding(.horizontal)
            
            BackButton()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    SignupScreenContent(
        firstName: .constant(
            ""
        ),
        lastName: .constant(
            ""
        ),
        email: .constant(
            ""
        ),
        password: .constant(
            ""
        ),
        onSignupButtonClick: {}
    )
}
