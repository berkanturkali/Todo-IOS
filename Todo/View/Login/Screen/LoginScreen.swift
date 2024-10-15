//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var viewModel = LoginScreenViewModel()
    
    var body: some View {
        LoginScreenContent(
            email: $viewModel.email,
            password: $viewModel.password,
            onLoginButtonClick: viewModel.onLoginButtonClick
        )
    }
}

#Preview {
    LoginScreen()
}
