//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Circle()
            .stroke(Color.gray)
            .fill(Color.background)
            .frame(width: 36, height: 36)
            .modifier(ShadowModifier(x: 1.5, y: 1.5))
            .onTapGesture {
                dismiss()
            }
            .overlay {
                Image(systemName: "chevron.backward")
                    .font(.title3)
                    .padding()
                    .foregroundColor(.text)
            }
    }
}

#Preview {
    BackButton()
}

