//

import Foundation

struct Stat : Codable, Hashable {
    let total: Int?
    let important: Int?
    let notImportant: Int?
    let completed: Int?
    let active: Int?
    let category : String?    
}
