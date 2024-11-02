//

import SwiftUI

struct TodoEmptyView<Destination: View>: View {
    
    var destination: Destination? = nil
    
    var message: String = LocalizedStrings.nothingToSeeHere
    
    var description: String? = nil
    
    var buttonText: String? = nil
    
    var action: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                Text("😕")
                    .font(.largeTitle)
                
                Text(message)
                    .font(.custom(Typeface.medium, size: 18))
                    .foregroundColor(.text)
                    .multilineTextAlignment(.center)
                
                if let description {
                    Text(description)
                        .font(.custom(Typeface.medium, size: 14))
                        .foregroundColor(.text.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                if let text = buttonText {
                    if(destination == nil) {
                        Text(text)
                            .font(.custom(Typeface.semibold, size: 16))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .cornerRadius(8)
                            .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
                            .foregroundColor(.text)
                            .onTapGesture {
                                if(action != nil) {
                                    action!()
                                }
                            }
                        
                    } else {
                        TodoNavigationButton<Destination>(
                            destination: destination!,
                            labelText: text
                        )
                        
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TodoNavigationButton<Destination: View>: View {
    let destination: Destination
    let labelText: String
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(labelText)
                .font(.custom(Typeface.semibold, size: 16))
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .cornerRadius(8)
                .modifier(BackgroundModifier(radius: 10, shadowX: 8, shadowY: 8))
                .foregroundColor(.text)
        }
    }
}

#Preview {
    TodoEmptyView<EmptyView>()
}
