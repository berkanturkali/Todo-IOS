//

import Foundation

struct LocalizedStrings {
    
    static var login: String { return localizedString(for: "login") }
    static var email: String { return localizedString(for: "email") }
    static var password: String { return localizedString(for: "password") }
    static var signup: String { return localizedString(for: "signup") }
    static var or: String { return localizedString(for: "or") }
    static var firstName: String { return localizedString(for: "firstname") }
    static var lastName: String { return localizedString(for: "lastname") }
    
    static func localizedString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
