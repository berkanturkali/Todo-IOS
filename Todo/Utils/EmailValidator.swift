//

import Foundation


struct EmailValidator {
    static func checkIfTheEmailIsValid(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return !email.isEmpty && emailPredicate.evaluate(with: email)
    }
}
