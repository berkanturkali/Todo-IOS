//

import SwiftUI

struct EmptyViewForQuery: View {
    
    let category: String
    
    let filter: String
    
    @State var message = ""
    
    var body: some View {
        VStack(spacing: 12) {
            Text("😕")
                .font(.title)
            Text(message)
                .font(.custom(Typeface.semibold, size: 18))
                .foregroundColor(.text)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal)
        }
        .onAppear {
            let deviceLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            if(deviceLanguage == "tr") {
                message = String(format: LocalizedStrings.thereIsNoTodoFoundFor, category, filter)
            } else {
                message = String(format: LocalizedStrings.thereIsNoTodoFoundFor, filter, category)
            }
        }
    }
}

#Preview {
    EmptyViewForQuery(
        category: Category.music.title,
        filter: Filter.active.title
    )
}
