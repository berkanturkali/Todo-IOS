//

import Foundation


struct AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login() {
        
        let url = AuthServiceEndpoints.login
        
        
        
    }
    
    func signup() async throws -> String {
        
        let endpoint = AuthServiceEndpoints.signup
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.badURL(endpoint)
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                throw NetworkError.httpError(statusCode: statusCode)
            }
            
            let decodedResponse = try JSONDecoder().decode(BaseResponse<NoData>.self, from: data)
            
            return decodedResponse.message
            
        } catch let error {
            switch error {
            case let urlError as URLError:
                switch urlError.code {
                case .notConnectedToInternet:
                    throw NetworkError.notConnectedToInternet
                case .timedOut:
                    throw NetworkError.timedOut
                case .cannotFindHost:
                    throw NetworkError.cannotConnectToHost
                default:
                    throw NetworkError.requestFailed(error.localizedDescription)
                }
                
            case let decodingError as DecodingError:
                throw NetworkError.decodingError(decodingError)
            default:
                throw NetworkError.unknownError
            }
            
        }
        
    }
}
