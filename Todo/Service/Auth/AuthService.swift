//

import Foundation


struct AuthService {
    
    private let networkManager = NetworkManager.shared
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(body: LoginRequestModel) async throws -> LoginResponseModel {
        
        let url = AuthServiceEndpoints.login
        
        do {
            let response: BaseResponse<LoginResponseModel> = try await networkManager.request(
                to: url,
                method: HttpMethod.POST,
                body: body,
                responseType:BaseResponse<LoginResponseModel>.self
            )
            
            return response.data!
        } catch {
            throw error
        }
        
        
        
    }
    
    func signup(body: SignupRequestModel) async throws -> String {
        
        let endpoint = AuthServiceEndpoints.signup
        
        do {
            
            let response: BaseResponse<NoData> = try await networkManager.request(
                to: endpoint,
                method: HttpMethod.POST,
                body: body,
                responseType: BaseResponse<NoData>.self
            )
            return response.message ?? ""
            
        } catch  {
            
            throw error
        }
    }
    
}
