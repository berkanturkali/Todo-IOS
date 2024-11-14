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
            let response: BaseResponse<[Todo]> = try await networkManager.getRequest(
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
            let response: BaseResponse<FetchProfileResponseModel> = try await networkManager.getRequest(
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
            let response: BaseResponse<[Stat]> = try await networkManager.getRequest(
                to: url,
                responseType: BaseResponse<[Stat]>.self
            )
            return response.data ?? []
        } catch {
            throw error
        }
    }
}
