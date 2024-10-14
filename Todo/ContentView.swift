//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .font(.custom(Typeface.regular, size: 18))

    }
    
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("--  \(fontName)")
            }
        }
    }
}

#Preview {
    ContentView()
}
