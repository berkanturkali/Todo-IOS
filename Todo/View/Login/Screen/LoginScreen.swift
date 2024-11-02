//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginScreenViewModel()
    
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
            .blurOnAlert(isAlertVisible: viewModel.showAlert)
            .overlay {
                TodoDialog(message: viewModel.errorMessage ?? "", isVisible: $viewModel.showAlert) {
                    viewModel.errorMessage = nil
                }
            }
            .onChange(of: viewModel.navigateToMainScreen) {
                if(viewModel.navigateToMainScreen) {
                    navigationPath.append("Main")
                }
            }
            .navigationDestination(for: String.self) { destination in
                if(destination == "Main") {
                    MainScreen()
                }
            }
        }
    }
    
}

#Preview {
    LoginScreen()
}
