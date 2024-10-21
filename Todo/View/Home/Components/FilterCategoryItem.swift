//

import SwiftUI

struct FilterCategoryItem: View {
    
    let icon: String
    let name: String
    
    var selected: Bool = true
    
    var body: some View {
        HStack {
            
            Image(systemName: icon)
            
            Text(name)
                
        }
        .font(.custom(Typeface.medium, size: 14))
        .foregroundColor(selected ? .text : .text.opacity(0.5))
        .padding(.vertical, 8)
        .padding(.horizontal)
        .modifier(
            BackgroundModifier(
                radius: 32,
                strokeWidth: selected ? 2 : 0,
                color: selected ? .background : .white.opacity(0.9),
                shadowX: selected ? 2 : 0,
                shadowY: selected ? 2 : 0
            )
        )
        
    }
}

#Preview {
    HStack {
        FilterCategoryItem(
            icon: "bag.fill", name: "Work"
        )
        FilterCategoryItem(
            icon: "bag.fill", name: "Work", selected: false
        )
    }
}
