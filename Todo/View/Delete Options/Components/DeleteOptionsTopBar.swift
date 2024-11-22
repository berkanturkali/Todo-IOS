//

import SwiftUI

struct DeleteOptionsTopBar: View {
    @Environment(\.dismiss) private var dismiss
    
    let onDoneButtonPressed: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ZStack {
                Text(LocalizedStrings.options)
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
                    
                    Text(LocalizedStrings.done)
                        .font(.headline)
                        .foregroundColor(.text)
                        .onTapGesture {
                            onDoneButtonPressed()
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
    DeleteOptionsTopBar(){
        
    }
}
