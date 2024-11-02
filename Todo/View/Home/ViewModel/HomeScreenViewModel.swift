//

import Foundation
import Combine

class HomeScreenViewModel: ObservableObject {
    
    
    @Published var selectedCategory: Category = .all
    
    @Published var selectedFilter: Filter = .all
    
    @Published var showBadgeOnTheFilterButton: Bool = false
    
    @Published var showEmptyView: Bool = false
    
    @Published var todos: [Todo] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        $todos
            .map({ $0.isEmpty })
            .assign(to: \.self.showEmptyView, on: self)
            .store(in: &cancellables)
    }
    
    func onCheckMarkTapped(selectedFilter: Filter) {
        self.selectedFilter = selectedFilter
        showBadgeOnTheFilterButton = selectedFilter != .all
    }
    
}
