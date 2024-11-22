//

import SwiftUI

struct HomeScreenTopBar: View {
    
    @Binding var showFilterScreen: Bool
    
    @Binding var showDeleteOptions : Bool
    
    let showBadgeOnTheFilterButton: Bool
    
    let refreshHomeScreen: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: "trash.square")
                    .onTapGesture {
                        showDeleteOptions = true
                    }
                
                NavigationLink {
                    AddTodoScreen() { refresh in
                        if(refresh) {
                            refreshHomeScreen()
                        }
                    }
                } label: {
                    Image(systemName: "plus.app")
                }
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .overlay(
                        Circle()
                            .fill(Color.buttonSecondary)
                            .frame(width: 10, height: 10)
                            .offset(x: 10, y: -10)
                            .opacity(showBadgeOnTheFilterButton ? 1 : 0)
                    )
                
                    .onTapGesture {
                        showFilterScreen = true
                    }
            }
            .foregroundColor(.text)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.title)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeScreenTopBar(
        showFilterScreen: .constant(
            false
        ),
        showDeleteOptions:
                .constant(
                    false
                ),
        showBadgeOnTheFilterButton: false
    ) {
        
    }
}
