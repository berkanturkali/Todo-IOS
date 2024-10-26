//

import SwiftUI

struct FilterItem: View {
    
    let filter: Filter
    
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(filter.title)
                .font(.custom(Typeface.medium, size: 18))
                .foregroundColor(.text)
            
            Spacer()
            
            if(isSelected) {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.text)
            }
        }
        .padding()
        .modifier(BackgroundModifier(radius: 24, shadowX: 4, shadowY: 4))
        .padding(.horizontal)
        
    }
}

#Preview {
    VStack(spacing: 24) {
        FilterItem(filter: Filter.active, isSelected: false)
        
        FilterItem(filter: Filter.active, isSelected: true)
    }
}
