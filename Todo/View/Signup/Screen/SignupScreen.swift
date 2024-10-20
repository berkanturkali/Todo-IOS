//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var viewModel =  SignupScreenViewModel()
    
    var body: some View {
        
        @State var showAlert = viewModel.errorMessage != nil
        
        @State var showSignupResponseAlert = viewModel.signupResponse != nil
        
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
       
        .blurOnAlert(isAlertVisible: showAlert)
        .overlay {
            TodoDialog(message: viewModel.signupResponse ?? "", isVisible: $showSignupResponseAlert) {
                viewModel.signupResponse = nil
            }
            
            TodoDialog(message: viewModel.errorMessage ?? "", isVisible: $showAlert) {
                viewModel.errorMessage = nil
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupScreen()
}
