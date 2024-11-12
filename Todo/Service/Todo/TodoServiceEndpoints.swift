//

import Foundation

struct TodoServiceEndpoints {
    
    private static let todoPath = "todo/"
    
    static let addTodo = Constants.baseUrl + todoPath + "new/"
    
    static let todos = Constants.baseUrl + todoPath + "todos/"
}
