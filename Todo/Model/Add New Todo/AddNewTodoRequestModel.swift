//

import Foundation

struct AddNewTodoRequestModel: Codable {
    let category: String
    let date: Int
    let todo: String
    let important: Bool
    let notifyMe: Bool
}
