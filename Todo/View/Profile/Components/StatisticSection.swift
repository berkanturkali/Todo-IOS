//

import SwiftUI

struct StatisticSection: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(Typeface.semibold, size: 12))
                .foregroundColor(.text)
            
            Spacer()
            
            Text(value)
                .font(.custom(Typeface.medium, size: 12))
                .foregroundColor(.text)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .modifier(BackgroundModifier(radius: 10, shadowX: 2, shadowY: 2))
        .padding(.horizontal, 8)
        
    }
}

#Preview {
    StatisticSection(
        title: LocalizedStrings.important,
        value: "100"
    )
}
