//

import SwiftUI


struct TodoList: View {
    
    let  todos: [Todo]
    
    var body: some View {
        ScrollView() {
            LazyVStack {
                ForEach(todos, id: \.self) { todo in
                    TodoItem(todo: todo)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 2)
                }
            }
        }
        
    }
    
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        TodoList(
            todos: (1...5).map(
                { i in
                    Todo.mockTodo
                })
        )
    }
}
