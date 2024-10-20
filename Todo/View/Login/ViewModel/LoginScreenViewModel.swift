//

import Foundation

@MainActor
class LoginScreenViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String? = nil
    
    @Published var loginResponse: LoginResponseModel? = nil
    
    private let authService = AuthService.shared
    
    
    func onLoginButtonClick() async {
        
        guard !isLoading else { return }
        
        let emailIsValid = checkIfTheEmailIsValid()
        
        guard emailIsValid else {
            errorMessage = LocalizedStrings.emailIsNotValid
            return
        }
        
        let passwordIsValid = checkIfThePasswordIsValid()
        
        guard passwordIsValid else {
            errorMessage = LocalizedStrings.passwordIsNotValid
            return
        }
        
        errorMessage = nil
        
        isLoading = true
        
        do {
            let body = LoginRequestModel(email: email, password: password)
            
            let response = try await authService.login(body: body)
            
            loginResponse = response
        } catch {
            print("error: \(error)")
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        isLoading = false
        
    }
    
    
    func checkIfTheEmailIsValid() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return !email.isEmpty && emailPredicate.evaluate(with: email)
    }
    
    func checkIfThePasswordIsValid() -> Bool {
        return !password.isEmpty && password.count >= 8
    }
    
    
    
}
