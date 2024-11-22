//

import SwiftUI

struct DeleteOptionItem: View {
    
    let option: DeleteOptions
    
    let isSelected: Bool
    
    
    var body: some View {
        HStack {
            Text(option.value)
                .font(.custom(Typeface.medium, size: 18))
                .foregroundColor(isSelected ? .text : .text.opacity(0.5))
            
            Spacer()
            
            if(isSelected) {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.text)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .modifier(
            BackgroundModifier(
                radius: 24,
                strokeWidth: isSelected ? 2 : 1,
                color: isSelected ? .background : .background.opacity(0.95),
                shadowX: isSelected ? 4 : 3,
                shadowY: isSelected ? 4 : 3,
                shadowColor: isSelected ? .darkShadow : .darkShadow.opacity(0.5)
            )
        )
    }
}

#Preview {
    DeleteOptionItem(
        option: .deleteAll,
        isSelected: true
    )
}