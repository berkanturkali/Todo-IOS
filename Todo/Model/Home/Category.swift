//

import Foundation

enum Category: String, CaseIterable {
    case all
    case work
    case music
    case travel
    case study
    case home
    case shopping
    
    
    var icon: String {
        switch self {
        case .all: "square.grid.2x2"
        case .work: "bag.circle"
        case .music: "music.note"
        case .travel: "airplane.circle"
        case .study: "book.circle"
        case .home: "house.circle"
        case .shopping: "cart.circle"
        }
    }
    
    var title: String {
        switch self {
        case .all: LocalizedStrings.all
        case .work: LocalizedStrings.work
        case .music: LocalizedStrings.music
        case .travel: LocalizedStrings.travel
        case .study: LocalizedStrings.study
        case .home: LocalizedStrings.home
        case .shopping: LocalizedStrings.shopping
        }
    }
    
    
}
