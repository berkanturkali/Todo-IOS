//

import SwiftUI

struct SignupScreen: View {
    
    @StateObject var viewModel =  SignupScreenViewModel()
    
    var body: some View {
        
        @State var showAlert = viewModel.errorMessage != nil
        
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(""),
                message: Text(viewModel.errorMessage!),
                dismissButton: .default(Text(LocalizedStrings.okay)) {
                    viewModel.errorMessage = nil
                }
            )
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupScreen()
}
