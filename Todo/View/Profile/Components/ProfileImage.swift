//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.background)
                .frame(width: 100, height: 100)
                .modifier(ShadowModifier(x: 4, y: 2))
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.text.opacity(0.8))
                .frame(width: 90, height: 90)
                .clipShape(Circle())
        }
        
        
    }
}

#Preview {
    ProfileImage()
}
