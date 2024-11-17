//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject var viewModel = HomeScreenViewModel()
    
    @State private var showFilterScreen = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                if(viewModel.errorMessage != nil) {
                    ErrorView(message: viewModel.errorMessage!) {
                        Task {
                            viewModel.resetQueryParams()
                        }
                    }
                } else if(viewModel.showEmptyView) {
                    TodoEmptyView<AddTodoScreen>(
                        destination: AddTodoScreen(onBackButtonPressed: { refresh in
                            if(refresh) {
                                Task {
                                    viewModel.resetQueryParams()
                                }
                            }
                        }),
                        description: LocalizedStrings.youCanStartByAddingNewTodo,
                        buttonText: LocalizedStrings.addTodo
                    )
                } else {
                    VStack(spacing: 8) {
                        HomeScreenTopBar(
                            showFilterScreen: $showFilterScreen,
                            showBadgeOnTheFilterButton: viewModel.showBadgeOnTheFilterButton
                        ) {
                            Task {
                                await viewModel.fetchTodos()
                            }
                        }
                        
                        CategoriesView(selectedCategory: $viewModel.selectedCategory)
                        if (viewModel.loading) {
                            Spacer()
                            TodoLoadingIndicator(size: 30)
                            Spacer()
                        } else if (viewModel.showEmptyViewForCategoryAndFilter) {
                            Spacer()
                            EmptyViewForQuery(
                                category: viewModel.selectedCategory.title,
                                filter: viewModel.selectedFilter.title
                            )
                            Spacer()
                        } else {
                            TodoList(
                                todos: viewModel.todos, onCompleteUndoButtonPressed: { todo in
                                    Task {
                                        await viewModel.updateCompleteStatus(todo: todo)
                                    }
                                }) { todo in
                                    
                                }
                            
                        }
                    }
                    .blurOnAlert(
                        isAlertVisible: viewModel.loading || viewModel.showCompleteTodoStatusDialog
                    )
                    .fullScreenCover(isPresented: $showFilterScreen) {
                        FiltersScreen(
                            appliedFilter: viewModel.selectedFilter,
                            onCheckMarkTapped: viewModel.onCheckMarkTapped
                        )
                    }
                }
            }
        }
        .overlay {
            TodoDialog(
                message: viewModel.updateCompleteStatusMessage,
                isVisible: $viewModel.showCompleteTodoStatusDialog,
                onOkayButtonClick: {
                    viewModel.updateCompleteStatusMessage = ""
                }
            )
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}

