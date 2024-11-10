//

import Foundation
import Combine
import SwiftUI

@MainActor
class LoginScreenViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var showAlert: Bool = false
    
    @Published var errorMessage: String? = nil
    
    @Published var navigateToMainScreen: Bool = false
    
    private let authService = AuthService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    private var appState: AppState
    
    init (appState: AppState) {
        self.appState = appState
        $errorMessage.map { $0 != nil }
            .assign(to: \.showAlert, on: self)
            .store(in: &cancellables)
    }
    
    
    func onLoginButtonClick() async {
        
        guard !isLoading else { return }
        
        let emailIsValid = EmailValidator.checkIfTheEmailIsValid(email: email)
        
        guard emailIsValid else {
            errorMessage = LocalizedStrings.emailIsNotValid
            return
        }
        
        let passwordIsValid = PasswordValidator.checkIfThePasswordIsValid(password: password)
        
        guard passwordIsValid else {
            errorMessage = LocalizedStrings.passwordIsNotValid
            return
        }
        
        errorMessage = nil
        
        isLoading = true
        
        do {
            let body = LoginRequestModel(email: email, password: password)
            
            let response = try await authService.login(body: body)
            
            UserDefaults.standard.set(response.token, forKey: Constants.tokenKey)
            UserDefaults.standard.set(response.id, forKey: Constants.userIdKey)
            
            appState.isLoggedIn = true
            
        } catch {
            print("error: \(error)")
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        isLoading = false
        
    }
    
}
