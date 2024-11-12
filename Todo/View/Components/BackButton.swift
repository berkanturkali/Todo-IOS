//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var alternaviteAction: (() -> Void)? = nil
    
    var body: some View {
        Circle()
            .stroke(Color.gray)
            .fill(Color.background)
            .frame(width: 32, height: 32)
            .modifier(ShadowModifier(x: 1.5, y: 1.5))
            .onTapGesture {
                dismiss()
                alternaviteAction?()
            }
            .overlay {
                Image(systemName: "chevron.backward")
                    .font(.callout)
                    .padding()
                    .foregroundColor(.text)
            }
    }
}

#Preview {
    BackButton()
}

