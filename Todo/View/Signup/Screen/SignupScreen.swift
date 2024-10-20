//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var viewModel =  SignupScreenViewModel()
    
    var body: some View {
        
        SignupScreenContent(
            firstName: $viewModel.firstName,
            lastName: $viewModel.lastName,
            email: $viewModel.email,
            password: $viewModel.password,
            onSignupButtonClick: {
                Task {
                    await viewModel.onSignupButtonClick()
                }
            }
        )
        
        .blurOnAlert(isAlertVisible: viewModel.showAlert)
        .overlay {
            TodoDialog(message: viewModel.messageWithCallback?.message ?? "", isVisible: $viewModel.showAlert) {
                if let callback = viewModel.messageWithCallback?.callback {
                    callback()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupScreen()
}
