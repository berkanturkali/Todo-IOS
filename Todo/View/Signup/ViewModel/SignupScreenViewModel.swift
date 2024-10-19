//

import Foundation

@MainActor
class SignupScreenViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    
    @Published var lastName: String = ""
    
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    @Published var signupResponse: String? = nil
    
    @Published var isLoading = false
    
    @Published var errorMessage: String? = nil

    
    private let authService = AuthService.shared
    
    
    func onSignupButtonClick() async {
        
        guard !isLoading else { return }

        let firstNameLastNameAreValid = checkIfTheFirstNameAndLastNamesAreValid()
        
        guard firstNameLastNameAreValid else {
            errorMessage = LocalizedStrings.firstNameAndLastNameAreRequired
            return
        }
        
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
            let body = SignupRequestModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            )
            
            let response = try await authService.signup(body: body)
            
            signupResponse = response
        } catch {
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        isLoading = false
        
    }
    
    func checkIfTheFirstNameAndLastNamesAreValid() -> Bool {
        return !(firstName.isEmpty && lastName.isEmpty)
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
