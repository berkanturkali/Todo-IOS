//

import SwiftUI

struct FilterTopBar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isCheckMarkActive: Bool
    
    let onCheckMarkTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ZStack {
                Text(LocalizedStrings.filters)
                    .font(.custom(Typeface.semibold, size: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.text)
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
                        .foregroundColor(isCheckMarkActive ? .text : .text.opacity(0.5))
                        .onTapGesture {
                            onCheckMarkTapped()
                            dismiss()
                        }
                    
                }
                .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity)
            Divider()
        }
    }
}

#Preview {
    FilterTopBar(isCheckMarkActive: .constant(false), onCheckMarkTapped: {})
}
