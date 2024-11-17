//

import Foundation

struct TodoServiceEndpoints {
    
    static let todoPath = "todo/"
    
    static let addTodo = Constants.baseUrl + todoPath + "new/"
    
    static let todos = Constants.baseUrl + todoPath + "todos/"
    
    static let getStats = Constants.baseUrl + todoPath + "stats/"
    
    static let getAllStats = Constants.baseUrl + todoPath + "allStats/"
}
