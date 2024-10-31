//

import SwiftUI

struct StatisticSection: View {
    var body: some View {
            HStack {
                Text("Title")
                    .font(.custom(Typeface.semibold, size: 12))
                    .foregroundColor(.text)
                
                Spacer()
                
                Text("0")
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
    StatisticSection()
}
