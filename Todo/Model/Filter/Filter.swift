//

import Foundation

enum Filter: String, CaseIterable {
    case all
    case active
    case completed
    case important
    
    var title: String {
        switch self {
        case .all: LocalizedStrings.all
        case .active: LocalizedStrings.active
        case .completed: LocalizedStrings.completed
        case .important: LocalizedStrings.important
        }
    }
}
