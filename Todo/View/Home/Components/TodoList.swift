//

import SwiftUI


struct TodoList: View {
    
    @State var todos: [Todo]
    
    @State private var swipedItemId: String? = "-1"
    
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
                    
                    
                    
                    TodoItem(index: index, todo: todo, swipedItemId: $swipedItemId)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 2)
       
                }
                
                
            }
        }
        
    }
    
    
    private func markAsCompleted(at index: Int) {
        
    }
    
    private func deleteTodo(at index: Int) {
        
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
