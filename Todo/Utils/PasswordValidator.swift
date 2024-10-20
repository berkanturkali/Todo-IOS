//

import Foundation

struct PasswordValidator {
    static func checkIfThePasswordIsValid(password: String) -> Bool {
        return !password.isEmpty && password.count >= 4
    }
}
