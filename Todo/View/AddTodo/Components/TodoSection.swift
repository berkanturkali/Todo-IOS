//

import SwiftUI

struct TodoSection<Content: View>: View {
    
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .bold()
                
                Text(title)
                    .font(
                        .custom(
                            Typeface.semibold,
                            size: 20
                        )
                    )
            }
            .foregroundColor(.text)
            
            content
            
        }
    }
}

#Preview {
    TodoSection(
        title: LocalizedStrings.category,
        icon: "square.grid.2x2",
        content: {
            EmptyView()
        }
    )
}
