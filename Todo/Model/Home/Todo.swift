//

import Foundation

struct Todo: Hashable, Codable {
    let id: String
    let category: String
    let date: String
    let todo: String
    let completed: Bool
    let important: Bool
    
    var categoryEnum: Category {
        return Category(rawValue: category.lowercased())!
    }
    
    static var mockTodo: Todo {
        return Todo(
            id: UUID().uuidString,
            category: Category.all.title,
            date: "11:02",
            todo: "Get Married",
            completed: true,
            important: true
        )
    }
}
