//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.title)
                        .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(Category.allCases, id: \.self) { category in
                                FilterCategoryItem(icon: category.icon, name: category.title)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
