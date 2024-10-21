//

import SwiftUI

struct MainScreen: View {
    
    @State private var selectedTab: TodoTab = .home
    
    var body: some View {
        
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                Spacer()
                contentView(
                    for: selectedTab
                )
                Spacer()
              
                TodoTabBar(
                    selectedTab: $selectedTab
                )
            
            }
        }
    }
    
    @ViewBuilder
    private func contentView(
        for tab: TodoTab
    ) -> some View {
        switch tab {
        case .home:
            Text(
                "Home"
            )
            .font(
                .body
            )
            
        case .profile:
            Text(
                "Profile"
            )
            .font(
                .body
            )
        }
    }
}

struct TodoTabBar : View {
    @Binding var selectedTab: TodoTab
    
    var body: some View {
        HStack {
            
            TodoTabItem(
                icon: "house.fill",
                selected: selectedTab == .home
            ) {
                selectedTab = .home
            }
            
            TodoTabItem(icon: "person.fill", selected: selectedTab == .profile) {
                selectedTab = .profile
            }
        }
        .padding(
            .vertical,
            8
        )
        .modifier(
            BackgroundModifier(
                radius: 12,
                shadowX: 8,
                shadowY: 8
            )
        )
        .padding()

    }
}

struct TodoTabItem: View {
    
    let icon: String
    
    let selected: Bool
    
    let onButtonClick: () -> Void
    
    var body : some View {
        Button(
            action: {
                onButtonClick()
            }) {
                
                Image(
                    systemName: icon
                )
                .font(
                    .system(
                        size: 24
                    )
                )
                .foregroundColor(
                    selected ? .text : .text.opacity(0.5)
                )
                .modifier(
                    ShadowModifier(
                        x: selected ? 0 : 2,
                        y: selected ? 0 : 2,
                        color: .darkShadow.opacity(0.5)
                    )
                )
                
            }
            .frame(
                maxWidth: .infinity
            )
        
    }
}

#Preview {
    MainScreen()
}