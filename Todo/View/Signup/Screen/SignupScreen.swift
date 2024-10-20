//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var viewModel =  SignupScreenViewModel()
    
    var body: some View {
        
        @State var showAlert = viewModel.errorMessage != nil
        
        @State var showSuccessAlert = viewModel.signupResponse != nil
        
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
        .overlay {
//            if(showSuccessAlert) {
//                TodoDialog(message: viewModel.signupResponse!) {
//                    viewModel.signupResponse = nil
//                }
//            }
//            if(showAlert) {
//                TodoDialog(message: viewModel.errorMessage!) {
//                    viewModel.errorMessage = nil
//                }
//            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupScreen()
}
