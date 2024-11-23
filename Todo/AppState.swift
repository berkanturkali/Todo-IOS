//

import Foundation

class AppState: ObservableObject {
    
    @Published var isLoggedIn: Bool = UserDefaults.standard.string(forKey: Constants.tokenKey) != nil
    
    @Published var fetchAllStats: Bool = false
}
