//

import Foundation

struct LocalizedStrings {
    
    static var login: String { return localizedString(for: "login") }
    static var email: String { return localizedString(for: "email") }
    static var password: String { return localizedString(for: "password") }
    
    static func localizedString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
