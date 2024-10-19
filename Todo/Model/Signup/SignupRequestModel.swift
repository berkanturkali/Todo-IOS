//

import Foundation


struct SignupRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
