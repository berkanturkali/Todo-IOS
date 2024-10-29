//

import Foundation


struct TodoService {
    
    private let networkManager = NetworkManager.shared
    
    static let shared = TodoService()
    
    
    func addNewTodo(body: AddNewTodoRequestModel) async throws -> String {
        let url = TodoServiceEndpoints.addTodo
        
        do {
            let response: BaseResponse<NoData> = try await networkManager.request(
                to: url,
                method: HttpMethod.POST,
                body: body ,
                responseType: BaseResponse<NoData>.self
            )
            
            return response.message
        } catch {
            throw error
        }
    }
}
