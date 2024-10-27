//

import Foundation

enum Importance: String, CaseIterable {
    
    case normal
    case important
    
    var value: String {
        switch self {
        case .important: LocalizedStrings.important
        case .normal: LocalizedStrings.normal
        }
    }
    
}
