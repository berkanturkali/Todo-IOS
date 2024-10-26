//

import SwiftUI

struct CategoryItem: View {
    
    let animationDuration = 0.1
    
    let category: Category
    
    let selected: Bool
    
    let onItemClick: () -> Void

    @State private var jumpOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            
            Image(systemName: selected ? "checkmark" : category.icon)
                .font(.callout)
            
            Text(category.title)
            
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
        .offset(y: jumpOffset)
        .onTapGesture {
 
            withAnimation(.snappy(duration: animationDuration)) {
                jumpOffset = -5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                withAnimation(.easeIn(duration: animationDuration)) {
                    jumpOffset = 0
                }
            }
            
            onItemClick()
        }
        
    }
}

#Preview {
    HStack {
        CategoryItem(
            category: Category.work,
            selected: true,
            onItemClick: {}
        )
        CategoryItem(
            category: Category.work,
            selected: false,
            onItemClick: {}
        )
    }
}
