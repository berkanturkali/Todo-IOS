//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject var viewModel = HomeScreenViewModel()
    
    @State private var showFilterScreen = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            if(!viewModel.showEmptyView) {
                VStack {
                    HStack(spacing: 12) {
                        NavigationLink {
                            AddTodoScreen()
                        } label: {
                            Image(systemName: "plus.app")
                        }
                        
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .overlay(
                                Circle()
                                    .fill(Color.buttonSecondary)
                                    .frame(width: 10, height: 10)
                                    .offset(x: 10, y: -10)
                                    .opacity(viewModel.showBadgeOnTheFilterButton ? 1 : 0)
                            )
                        
                            .onTapGesture {
                                showFilterScreen = true
                            }
                    }
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.title)
                    .padding(.horizontal)
                    
                    ScrollView() {
                        LazyVStack {
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
                            
                            ForEach(viewModel.todos, id: \.self) { todo in
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
                
            } else {
                TodoEmptyView<AddTodoScreen>(
                    destination: AddTodoScreen(),
                    description: LocalizedStrings.youCanStartByAddingNewTodo,
                    buttonText: LocalizedStrings.addTodo
                )
            }
            
        }
        
        
    }
    
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
