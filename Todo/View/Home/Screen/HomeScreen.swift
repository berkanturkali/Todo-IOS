//

import SwiftUI

struct HomeScreen: View {
    
    let todos: [Todo]
    
    @State private var showFilterScreen = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
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
                                FilterCategoryItem(icon: category.icon, name: category.title)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                    
                    ForEach(todos, id: \.self) { todo in
                        TodoItem(todo: todo)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 8)
                    }
                }
            }
            
        }
        .sheet(isPresented: $showFilterScreen) {
                
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
