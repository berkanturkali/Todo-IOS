//

import SwiftUI

struct FilterTopBar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isCheckMarkActive: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ZStack {
                Text(LocalizedStrings.filters)
                    .font(.custom(Typeface.semibold, size: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Text(LocalizedStrings.cancel)
                        .font(.custom(Typeface.medium, size: 15))
                        .foregroundColor(.text)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .foregroundColor(isCheckMarkActive ? .accentColor : .text.opacity(0.5))
                    
                }
                .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity)
            Divider()
        }
    }
}

#Preview {
    FilterTopBar(isCheckMarkActive: .constant(false))
}
