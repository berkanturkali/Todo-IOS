//

import Foundation


struct TodoService {
    
    private var networkManager = NetworkManager.shared
    
    static let shared = TodoService()
    
    private init() {
        networkManager.setSendToken(send: true)
    }
    
    
    func addNewTodo(body: AddNewTodoRequestModel) async throws -> String {
        let url = TodoServiceEndpoints.addTodo
        
        do {
            let response: BaseResponse<NoData> = try await networkManager.request(
                to: url,
                method: HttpMethod.POST,
                body: body ,
                responseType: BaseResponse<NoData>.self
            )
            
            return response.message ?? ""
        } catch {
            throw error
        }
    }
    
    func fetchTodos(filter: String, category: String) async throws -> [Todo] {
        let url = TodoServiceEndpoints.todos
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "filter", value: filter),
            URLQueryItem(name: "category", value: category)
        ]
        
        do {
            let response: BaseResponse<[Todo]> = try await networkManager.requestWithoutBody(
                to: urlComponents.url!.absoluteString,
                responseType: BaseResponse<[Todo]>.self
            )
            
            return response.data ?? []
        } catch {
            throw error
        }
    }
    
    func fetchProfile() async throws ->  FetchProfileResponseModel {
        let url = TodoServiceEndpoints.getStats
        
        do {
            let response: BaseResponse<FetchProfileResponseModel> = try await networkManager.requestWithoutBody(
                to: url,
                responseType: BaseResponse<FetchProfileResponseModel>.self
            )
            
            return response.data!
        } catch {
            throw error
        }
    }
    
    func fetchAllStats() async throws ->  [Stat] {
        
        let url = TodoServiceEndpoints.getAllStats
        
        do {
            let response: BaseResponse<[Stat]> = try await networkManager.requestWithoutBody(
                to: url,
                responseType: BaseResponse<[Stat]>.self
            )
            return response.data ?? []
        } catch {
            throw error
        }
    }
    
    func updateCompleteStatus(id: String, completed: Bool) async throws -> BaseResponse<Todo> {
        let url = Constants.baseUrl + TodoServiceEndpoints.todoPath + id + "/\(!completed)"
        
        do {
            let response: BaseResponse<Todo> = try await networkManager.requestWithoutBody(
                to: url,
                responseType: BaseResponse<Todo>.self,
                method: HttpMethod.PUT
            )
            
            return response
        } catch {
            throw error
        }
        
    }
    
    func deleteTodo(id: String) async throws -> BaseResponse<Todo> {
        let url = Constants.baseUrl + TodoServiceEndpoints.todoPath + id
        do {
            let response: BaseResponse<Todo> = try await networkManager.requestWithoutBody(
                to: url,
                responseType: BaseResponse<Todo>.self,
                method: HttpMethod.DELETE
            )
            return response
        } catch {
            throw error
        }
    }
}
