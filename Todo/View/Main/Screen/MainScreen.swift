//

import SwiftUI

struct MainScreen: View {
    
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

extension UITabBarController {
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.background)
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.text.opacity(0.5))
        
        self.tabBar.standardAppearance = appearance
    }
}


#Preview {
    MainScreen()
}
