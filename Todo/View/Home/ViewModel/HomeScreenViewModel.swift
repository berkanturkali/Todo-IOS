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
    
}
