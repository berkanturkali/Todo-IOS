//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginScreenViewModel()
    
    var body: some View {
        NavigationStack {
            LoginScreenContent(
                email: $viewModel.email,
                password: $viewModel.password,
                onLoginButtonClick: {
                    viewModel.navigateToMainScreen = false
                    Task {
                        await viewModel.onLoginButtonClick()
                    }
                }
            )
            .blurOnAlert(isAlertVisible: viewModel.showAlert || viewModel.isLoading)
            .overlay {
                TodoDialog(message: viewModel.errorMessage ?? "", isVisible: $viewModel.showAlert) {
                    viewModel.errorMessage = nil
                }
                if(viewModel.isLoading) {
                    TodoLoadingIndicator()
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToMainScreen) {
                MainScreen()
            }
        }
    }
    
}

#Preview {
    LoginScreen()
}
