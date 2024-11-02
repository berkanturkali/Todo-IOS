//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        if let _ = UserDefaults.standard.string(forKey: Constants.tokenKey) {
            MainScreen()
        } else {
            LoginScreen()
        }
    }
}

#Preview {
    ContentView()
}
