//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    
    @Published var selectedCategory: Category = .all
    
    @Published var selectedFilter: Filter = .all
    
    @Published var showBadgeOnTheFilterButton: Bool = false
    
    func onCheckMarkTapped(selectedFilter: Filter) {
        self.selectedFilter = selectedFilter
        showBadgeOnTheFilterButton = selectedFilter != .all
    }
    
}
