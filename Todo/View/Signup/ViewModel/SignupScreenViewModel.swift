//

import Foundation

class SignupScreenViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    
    @Published var lastName: String = ""
    
    @Published var email: String = ""
    
    @Published var password: String = ""
    
    
    func onSignupButtonClick() {
        
    }
}
