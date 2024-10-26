//

import SwiftUI

struct HomeScreen: View {
    
    let todos: [Todo]
    
    @StateObject var viewModel = HomeScreenViewModel()
    
    @State private var showFilterScreen = false
    
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            ScrollView() {
                LazyVStack {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.title)
                        .padding(.horizontal)
                        .onTapGesture {
                            showFilterScreen = true
                        }
                    
                    Spacer(minLength: 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(Category.allCases, id: \.self) { category in
                                CategoryItem(
                                    category: category,
                                    selected: viewModel.selectedCategory == category
                                ) {
                                    viewModel.selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                    
                    ForEach(todos, id: \.self) { todo in
                        TodoItem(todo: todo)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 2)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showFilterScreen) {
            FiltersScreen(
                appliedFilter: viewModel.selectedFilter,
                onCheckMarkTapped: viewModel.onCheckMarkTapped
            )
        }
        
    }
}

#Preview {
    HomeScreen(
        todos: (1...100).map({ i in
            Todo.mockTodo
        })
    )
}
