//

import SwiftUI

struct MainScreen: View {
    
    init () {
        UITabBar.appearance().barTintColor = UIColor(Color.background)
        UITabBar.appearance().backgroundColor = UIColor(Color.background)
        UITabBar.appearance().unselectedItemTintColor = UIColor(.text.opacity(0.7))
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.background.ignoresSafeArea(.all)
                TabView {
                    NavigationView {
                        HomeScreen()
                    }.tabItem {
                        Image(
                            systemName: "house.fill"
                        )
                        .accentColor(.text)
                        .font(
                            .system(
                                size: 24
                            )
                        )
                        
                    }
                    
                    NavigationView {
                        ProfileScreen()
                    }.tabItem {
                        Image(
                            systemName: "person.fill"
                        )
                        .font(
                            .system(
                                size: 24
                            )
                        )
                        
                    }
                    
                }
                .accentColor(.text)
                
                Divider()
                    .padding(.bottom, 50)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
