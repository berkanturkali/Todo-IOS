//

import SwiftUI

struct FilterScreen: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                FilterTopBar()
                    .padding(.top)
                
                Spacer()
                
                
            }
        
        }
    }
}

#Preview {
    FilterScreen()
}
