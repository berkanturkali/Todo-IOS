//

import SwiftUI


struct TodoList: View {
    
    let  todos: [Todo]
    
    var body: some View {
        ScrollView() {
            LazyVStack {
                
                ForEach(todos.indices, id: \.self) { index in
                    let todo = todos[index]
                    let sectionTitle = todo.formattedDate
                    
                    if index == 0 || sectionTitle != todos[index - 1].formattedDate {
                        Text(sectionTitle)
                            .font(
                                .custom(
                                    Typeface.bold,
                                    size: 20
                                )
                            )
                            .foregroundColor(
                                .text
                            )
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding(
                                .top,
                                10
                            )
                            .padding(
                                .horizontal,
                                16
                            )
                        
                    }
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
