//

import Foundation

struct LocalizedStrings {
    
    static var login: String { localizedString(for: "login") }
    static var email: String { localizedString(for: "email") }
    static var password: String { localizedString(for: "password") }
    static var signup: String { localizedString(for: "signup") }
    static var or: String { localizedString(for: "or") }
    static var firstName: String { localizedString(for: "firstname") }
    static var lastName: String { localizedString(for: "lastname") }
    static var canNotConnectedToHost: String { localizedString(for: "can_not_connected_to_host") }
    static var decodingError: String { localizedString(for: "decoding_error") }
    static var invalidUrl: String { localizedString(for: "invalid_url") }
    static var notConnectedToInternet: String { localizedString(for: "not_connected_to_internet") }
    static var somethingWentWrong: String { localizedString(for: "something_went_wrong") }
    static var timeout: String { localizedString(for: "timeout") }
    static var somethingWentWrongWithTheCodeAndMessage: String { localizedString(for: "http_exception")}
    static var firstNameAndLastNameAreRequired: String { localizedString(for: "firstname_lastname_are_required") }
    static var emailIsNotValid: String { localizedString(for: "email_is_not_valid") }
    static var passwordIsNotValid: String { localizedString(for: "password_is_not_valid") }
    static var okay: String { localizedString(for: "okay") }
    static var homeTabLabel: String { localizedString(for: "home_tab_label") }
    static var profileTabLabel: String { localizedString(for: "profile_tab_label") }
    static var all: String { localizedString(for: "all") }
    static var work: String { localizedString(for: "work") }
    static var music: String { localizedString(for: "music") }
    static var travel: String { localizedString(for: "travel") }
    static var study: String { localizedString(for: "study") }
    static var home: String { localizedString(for: "home") }
    static var shopping: String { localizedString(for: "shopping") }
    static var cancel: String { localizedString(for: "cancel") }
    static var filters: String { localizedString(for: "filters") }
    static var active: String { localizedString(for: "active") }
    static var completed: String { localizedString(for: "completed") }
    static var important: String { localizedString(for: "important") }
    
    static func localizedString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
