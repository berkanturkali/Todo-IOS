//

import Foundation

struct AuthServiceEndpoints {
    
    private static let authPath = "auth/"
    
    static let login = Constants.baseUrl + authPath  + "login/"
    
    static let signup = Constants.baseUrl + authPath + "signup/"
}
