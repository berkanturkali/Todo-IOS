//

import SwiftUI

struct SwitchSectionItem: View {
    
    let label: String
    
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
                .font(.custom(Typeface.medium, size: 18))
        }
        .toggleStyle(
            .switch
        )
        .padding(.horizontal, 24)
        .padding(.vertical)
        .modifier(BackgroundModifier(radius: 12, shadowX: 4, shadowY: 4))
        .tint(.buttonSecondary)
        .padding(.horizontal, 6)
    }
}

#Preview {
    SwitchSectionItem(label: LocalizedStrings.notifyMe, isOn: .constant(false))
}
