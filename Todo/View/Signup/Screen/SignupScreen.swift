//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var viewModel = SignupScreenViewModel()
    
    
    var body: some View {
        
        SignupScreenContent(
            firstName: $viewModel.firstName,
            lastName: $viewModel.lastName,
            email: $viewModel.email,
            password: $viewModel.password,
            onSignupButtonClick: viewModel.onSignupButtonClick
        )
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupScreen()
}
