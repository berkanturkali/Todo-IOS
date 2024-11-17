import SwiftUI

struct TodoItem: View {
    let index: Int
    let todo: Todo
    @Binding var swipedItemId: String?
    
    @State private var actionWidth: CGFloat = 0
    @State private var showButtons: Bool = false
    @State private var offsetX: CGFloat = 0
    @State private var isDraggingHorizontally: Bool = false
    @State private var dragThreshold: CGFloat = 50
    @State private var maxButtonHeight: CGFloat = 0
    
    let onCompleteUndoButtonPressed : () -> Void
    let onDeletebuttonPressed: () -> Void
    
    var body: some View {
        ZStack {
            
            HStack(spacing: 16) {
                Text(
                    todo.completed ? LocalizedStrings.undo : LocalizedStrings.complete
                )
                .padding(.vertical)
                .font(.custom(Typeface.semibold, size: 10))
                .cornerRadius(8)
                .padding(.horizontal)
                .modifier(BackgroundModifier(radius: 10, shadowX: 4, shadowY: 4))
                .foregroundColor(.text)
                .multilineTextAlignment(.center)
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            maxButtonHeight = geometry.size.height
                        }
                })
                .onTapGesture {
                    onCompleteUndoButtonPressed()
                }
                
                
                Text(LocalizedStrings.delete)
                    .padding(.vertical)
                    .font(.custom(Typeface.semibold, size: 10))
                    .cornerRadius(8)
                    .padding(16)
                    .frame(height: maxButtonHeight)
                    .modifier(BackgroundModifier(radius: 10, shadowX: 4, shadowY: 4))
                    .foregroundColor(.text)
                
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        actionWidth = geometry.size.width
                    }
            })
            .onTapGesture {
                onDeletebuttonPressed()
            }
            .offset(x: max(offsetX + actionWidth, 0))
            .animation(.easeInOut(duration: 0.3), value: offsetX)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
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
                    
                    if todo.important {
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
                    
                    Text(todo.time)
                        .font(.custom(Typeface.medium, size: 14))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .modifier(BackgroundModifier())
            .padding(.horizontal)
            .offset(x: swipedItemId == todo._id ? -actionWidth : 0)
        }
        .onAppear {
            
            Task {
                try? await Task.sleep(for: .seconds(0.09))
                if swipedItemId == todo._id {
                    offsetX = -actionWidth
                    showButtons = true
                } else {
                    offsetX = 0
                    showButtons = false
                }
                
            }
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    
                    if !isDraggingHorizontally {
                        if abs(value.translation.width) > dragThreshold && abs(value.translation.width) > abs(value.translation.height) {
                            isDraggingHorizontally = true
                        }
                    }
                    
                    if isDraggingHorizontally {
                        if value.translation.width < -dragThreshold {
                            withAnimation {
                                swipedItemId = todo._id
                                showButtons = true
                                offsetX = -actionWidth
                            }
                        } else if value.translation.width > dragThreshold {
                            withAnimation {
                                swipedItemId = nil
                                showButtons = false
                                offsetX = 0
                            }
                        } else {
                            offsetX = value.translation.width
                        }
                    }
                }
                .onEnded { _ in
                    isDraggingHorizontally = false
                    if offsetX < -dragThreshold {
                        withAnimation {
                            offsetX = -actionWidth
                        }
                    } else {
                        withAnimation {
                            offsetX = 0
                        }
                    }
                }
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: offsetX)
    }
}
