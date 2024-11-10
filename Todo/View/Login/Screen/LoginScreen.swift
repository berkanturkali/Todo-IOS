//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel : LoginScreenViewModel
    
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: LoginScreenViewModel(appState: appState))
    }
    
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
        }
    }
    
}

#Preview {
    LoginScreen(appState: AppState())
}
