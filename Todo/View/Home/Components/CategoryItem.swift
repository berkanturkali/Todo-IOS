//

import SwiftUI

struct CategoryItem: View {
    
    let icon: String
    let name: String
    
    var selected: Bool = true
    
    var body: some View {
        HStack {
            
            Image(systemName: icon)
                .font(.callout)
            
            Text(name)
            
        }
        .font(.custom(Typeface.medium, size: 14))
        .foregroundColor(selected ? .text : .text.opacity(0.5))
        .padding(.vertical, 8)
        .padding(.horizontal)
        .modifier(
            BackgroundModifier(
                radius: 32,
                strokeWidth: 2,
                color: selected ? .background : .background.opacity(0.95),
                shadowX: 2,
                shadowY: 2,
                shadowColor: selected ? .darkShadow : .darkShadow.opacity(0.5)
            )
        )
        
    }
}

#Preview {
    HStack {
        CategoryItem(
            icon: "bag.fill", name: "Work"
        )
        CategoryItem(
            icon: "bag.fill", name: "Work", selected: false
        )
    }
}
