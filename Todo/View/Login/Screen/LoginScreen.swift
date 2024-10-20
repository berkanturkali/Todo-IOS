//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginScreenViewModel()
    
    var body: some View {
        
        @State var showAlert = viewModel.errorMessage != nil
        
        @State var showSuccessAlert = viewModel.loginResponse != nil
        
        NavigationStack {
            LoginScreenContent(
                email: $viewModel.email,
                password: $viewModel.password,
                onLoginButtonClick: {
                    Task {
                        await viewModel.onLoginButtonClick()
                    }
                }
            )
            .blurOnAlert(isAlertVisible: showAlert)
            .overlay {
                TodoDialog(message: viewModel.errorMessage ?? "", isVisible: $showAlert) {
                    viewModel.errorMessage = nil
                }
            }
  
        }
    }
}

#Preview {
    LoginScreen()
}
