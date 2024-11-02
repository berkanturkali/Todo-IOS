//

import SwiftUI

struct LoginScreenContent: View {
    
    @Binding var email: String
    @Binding var password: String
    
    let onLoginButtonClick: () -> Void
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                
                Text(LocalizedStrings.login)
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
                    EmailInputField(email: $email)
                    PasswordInputField(password: $password)
                    LoginButton(onButtonClick: onLoginButtonClick)
                }
                .padding(.vertical, 32)
                .modifier(BackgroundModifier())
                
                VStack {
                    Text(LocalizedStrings.or)
                        .font(.custom(Typeface.semibold, size: 16))
                        .foregroundColor(.text)
                    
                    
                    NavigationLink(destination: SignupScreen()) {
                        Text(LocalizedStrings.signup)
                            .font(.custom(Typeface.semibold, size: 16))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                            .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
                            .foregroundColor(.text)
                    }
                    
                }
            }
            .padding(.horizontal)
            
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}


#Preview {
    LoginScreenContent(
        email: .constant(
            ""
        ),
        password: .constant(
            ""
        ),
        onLoginButtonClick: {}
    )
}
