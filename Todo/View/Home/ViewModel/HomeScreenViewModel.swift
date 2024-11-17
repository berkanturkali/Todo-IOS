//

import Foundation
import Combine

@MainActor
class HomeScreenViewModel: ObservableObject {
    
    
    @Published var selectedCategory: Category = .all
    
    @Published var selectedFilter: Filter = .all
    
    @Published var showBadgeOnTheFilterButton: Bool = false
    
    @Published var showEmptyView: Bool = false
    
    @Published var todos: [Todo] = []
    
    @Published var loading: Bool = false
    
    @Published var errorMessage: String? = nil
    
    @Published var showEmptyViewForCategoryAndFilter: Bool = false
    
    @Published var updateCompleteStatusMessage: String = ""
    
    @Published var showCompleteTodoStatusDialog: Bool = false
    
    private let todoService = TodoService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        $todos
            .map({ $0.isEmpty })
            .sink { [weak self] isEmpty in
                if(isEmpty) {
                    let selectedCategoryAndFilterIsAll = self?.selectedCategory == .all && self?.selectedFilter == .all
                    self?.showEmptyView = selectedCategoryAndFilterIsAll
                    self?.showEmptyViewForCategoryAndFilter = !selectedCategoryAndFilterIsAll
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($selectedCategory, $selectedFilter)
            .sink { [weak self] (category, filter) in
                self?.loading = true
                Task {
                    await self?.fetchTodos()
                }
            }
            .store(in: &cancellables)
        
        $updateCompleteStatusMessage
            .map { message in
                !message.isEmpty
            }
            .sink{ [weak self] show in
                self?.showCompleteTodoStatusDialog = show
            }
            .store(in: &cancellables)
        
    }
    
    func onCheckMarkTapped(selectedFilter: Filter) {
        self.selectedFilter = selectedFilter
        showBadgeOnTheFilterButton = selectedFilter != .all
    }
    
    func fetchTodos() async {
        errorMessage = nil
        showEmptyView = false
        showEmptyViewForCategoryAndFilter = false
        
        do {
            loading = true
            let response = try await todoService.fetchTodos(
                filter: selectedFilter.rawValue,
                category: selectedCategory.rawValue
            )
            
            todos = response
        } catch {
            errorMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        loading = false
    }
    func resetQueryParams() {
        selectedFilter = .all
        selectedCategory = .all
    }
    
    func updateCompleteStatus(todo: Todo) async {
        do {
            loading = true
            let response = try await todoService.updateCompleteStatus(
                id: todo._id,
                completed: todo.completed
            )
            
            updateCompleteStatusMessage = response.message!
            updateListWithUpdatedItem(item: response.data!)
            
        } catch {
            updateCompleteStatusMessage = NetworkManager.shared.handleNetworkError(error as! NetworkError)
        }
        
        loading = false
    }
    
    private func updateListWithUpdatedItem(item : Todo) {
        let indexOfItem = todos.firstIndex(where: { $0._id == item._id})!
        var updatedItem = todos[indexOfItem]
        updatedItem.completed = !item.completed
        todos[indexOfItem] = updatedItem
        todos = todos
    }
    
}
