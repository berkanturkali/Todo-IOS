//

import SwiftUI

struct CategoriesView: View {
    
    @Binding var selectedCategory: Category
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryItem(
                        category: category,
                        selected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}

#Preview {
    CategoriesView(selectedCategory: .constant(Category.all))
}
