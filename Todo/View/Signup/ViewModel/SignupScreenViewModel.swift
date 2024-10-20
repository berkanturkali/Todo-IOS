//

import Foundation
import Combine

@MainActor
class SignupScreenViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    
    @Published var lastName: String = ""
    
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    @Published var signupResponse: String? = nil
    
    @Published var isLoading = false
    
    @Published var showAlert: Bool = false
    
    @Published var alertMessage: String? = nil
    
    @Published var messageWithCallback: MessageWithCallback? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    private let authService = AuthService.shared
    
    init() {
        $messageWithCallback.map {
            $0?.message != nil
        }
        .assign(to: \.showAlert, on: self)
        .store(in: &cancellables)
    }
    
    
    func onSignupButtonClick() async {
        
        guard !isLoading else { return }
        
        let firstNameLastNameAreValid = checkIfTheFirstNameAndLastNamesAreValid()
        
        let emailIsValid = EmailValidator.checkIfTheEmailIsValid(email: email)
        
        let passwordIsValid = PasswordValidator.checkIfThePasswordIsValid(password: password)
        
        let errorMessage = !firstNameLastNameAreValid ? LocalizedStrings.firstNameAndLastNameAreRequired :
        !emailIsValid ? LocalizedStrings.emailIsNotValid :
        !passwordIsValid ? LocalizedStrings.passwordIsNotValid : nil
        
        if(errorMessage != nil) {
            messageWithCallback = MessageWithCallback(message: errorMessage) {
                self.messageWithCallback?.message = nil
            }
           return
        }
        
        messageWithCallback = MessageWithCallback(message: nil)
        
        isLoading = true
        
        do {
            let body = SignupRequestModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password
            )
            
            let response = try await authService.signup(body: body)
            
            messageWithCallback = MessageWithCallback(message: response) {
                self.messageWithCallback?.message = nil
            }
        } catch {
            messageWithCallback = MessageWithCallback(message: NetworkManager.shared.handleNetworkError(error as! NetworkError)) {
                self.messageWithCallback?.message = nil
            }
        }
        
        isLoading = false
        
    }
    
    func checkIfTheFirstNameAndLastNamesAreValid() -> Bool {
        return !(firstName.isEmpty && lastName.isEmpty)
    }
}
