//

import Foundation


enum AddNewTodoClickedItem: CaseIterable {
    case categories
    case importance
    
    var title: String {
        switch self {
        case .categories: "Categories"
        case .importance:  "Importance"
        }
    }
    
}
