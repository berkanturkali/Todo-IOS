//

import Foundation

enum DeleteOptions: String, CaseIterable {
    
    case deleteAll
    case deleteAllCompleted
    
    
    var value: String {
        switch self {
        case .deleteAll: LocalizedStrings.deleteAll
        case .deleteAllCompleted: LocalizedStrings.deleteCompletedTodos
        }
    }
    
}
