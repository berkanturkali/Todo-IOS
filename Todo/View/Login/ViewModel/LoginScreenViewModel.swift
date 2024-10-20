//

import Foundation
import Combine

@MainActor
class LoginScreenViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var showAlert: Bool = false
    
    @Published var errorMessage: String? = nil
    
    @Published var loginResponse: LoginResponseModel? = nil
    
    private let authService = AuthService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
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
            
            loginResponse = response
        } catch {
            print("error: \(error)")
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        isLoading = false
        
    }
    
}
