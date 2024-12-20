//

import SwiftUI

struct AddNewTodoListItem: View {
    
    let selectedValue: String
    
    let onItemClicked: () -> Void
    
    var body: some View {
        HStack {
            Text(selectedValue)

                .font(.custom(Typeface.medium, size: 18))

            Spacer()
            
            Image(systemName: "chevron.down.circle")
                .font(.title3)
                .fontWeight(.medium)
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical)
        .modifier(BackgroundModifier(radius: 12, shadowX: 4, shadowY: 4))
        .padding(.horizontal, 6)
        .foregroundColor(.text)
        .onTapGesture {
            onItemClicked()
        }
    }
}

#Preview {
    AddNewTodoListItem(
        selectedValue: Category.all.title,
        onItemClicked: {}
    )
}
