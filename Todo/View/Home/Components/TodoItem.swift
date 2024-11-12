//

import SwiftUI

struct TodoItem: View {
    
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 48) {
            HStack {
                Image(systemName: "checkmark.circle")
                    .font(.callout)
                    .foregroundColor(todo.completed ? .green : .text)
                
                Text(todo.todo)
                    .font(.custom(Typeface.medium, size: 18))
                    .foregroundColor(.text)
                    .lineLimit(3)
                    .strikethrough(todo.completed, color: .text)
                
                if(todo.important) {
                    Spacer()
                    
                    Image(systemName: "exclamationmark.circle")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                HStack {
                    Image(systemName: todo.categoryEnum.icon)
                        .font(.callout)
                    
                    Text(todo.categoryEnum.title)
                        .font(.custom(Typeface.medium, size: 14))
                }
                Spacer()
                
                Image(systemName: "clock")
                    .font(.callout)
//                
//                Text(todo.date)
//                    .font(.custom(Typeface.medium, size: 14))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .modifier(BackgroundModifier())
        .padding(.horizontal)
        
    }
}

#Preview {
    TodoItem(todo: Todo.mockTodo)
}
