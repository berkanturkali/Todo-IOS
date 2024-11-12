//

import SwiftUI

struct EmptyViewForQuery: View {
    
    let query: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text("😕")
                .font(.title)
            Text(String(format: LocalizedStrings.thereIsNoTodoFoundFor, query))
                .font(.custom(Typeface.semibold, size: 18))
                .foregroundColor(.text)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal)
        }
    }
}

#Preview {
    EmptyViewForQuery(query: Category.music.title)
}
