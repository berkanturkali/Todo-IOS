//

import SwiftUI

struct FilterTopBar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var isActive: Bool = false
    
    var body: some View {
        
        ZStack {
            Text(LocalizedStrings.filters)
                .font(.custom(Typeface.semibold, size: 20))
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Text(LocalizedStrings.cancel)
                    .font(.custom(Typeface.medium, size: 16))
                    .foregroundColor(.text)
                    .onTapGesture {
                        dismiss()
                    }
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(isActive ? .accentColor : .text.opacity(0.5))
                
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FilterTopBar()
}
