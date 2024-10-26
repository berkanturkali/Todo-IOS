//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    
    @Published var selectedCategory: Category = .all
    
    @Published var selectedFilter: Filter = .all
    
    func onCheckMarkTapped(selectedFilter: Filter) {
        self.selectedFilter = selectedFilter
    }
    
}
