//

import Foundation


struct AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login() {
        
        let url = AuthServiceEndpoints.login
        
        
        
    }
    
    func signup(body: SignupRequestModel) async throws -> String {
        
        let endpoint = AuthServiceEndpoints.signup
        
        do {
                
            let response: BaseResponse<NoData> = try await NetworkManager.shared.request(
                to: endpoint,
                method: HttpMethod.POST,
                body: body,
                responseType: BaseResponse<NoData>.self
            )
            return response.message
            
        } catch  {
                
            throw error
        }
    }

}
