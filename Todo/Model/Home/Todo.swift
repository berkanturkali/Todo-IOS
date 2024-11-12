//

import Foundation

struct Todo: Hashable, Codable {
    let _id: String
    let category: String
    let date: Int64
    let todo: String
    let completed: Bool
    let important: Bool
    
    var categoryEnum: Category {
        return Category(rawValue: category.lowercased())!
    }
    
    static var mockTodo: Todo {
        return Todo(
            _id: UUID().uuidString,
            category: Category.all.title,
            date: 12312312,
            todo: "Get Married",
            completed: true,
            important: true
        )
    }
}
