//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    var body: some View {
        ZStack {
            if (appState.isLoggedIn) {
                MainScreen()
                    .transition(.move(edge: .trailing))
            } else {
                LoginScreen(appState: self.appState)
                    .transition(.move(edge: .leading))
            }
        } .animation(.easeInOut, value: appState.isLoggedIn)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
