//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginScreenViewModel()
    
    var body: some View {
        
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
            .blurOnAlert(isAlertVisible: viewModel.showAlert)
            .overlay {
                TodoDialog(message: viewModel.errorMessage ?? "", isVisible: $viewModel.showAlert) {
                    viewModel.errorMessage = nil
                }
            }
            
        }
    }
}

#Preview {
    LoginScreen()
}
