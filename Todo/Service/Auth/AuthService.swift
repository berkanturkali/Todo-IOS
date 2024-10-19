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
        
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.badURL(endpoint)
        }
        
        do {
            
            let jsonBody = try JSONEncoder().encode(body)
            
            var request = URLRequest(url: url)
            
            request.httpMethod = HttpMethod.POST.rawValue
            
            request.httpBody = jsonBody
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                if let errorMessage = extractErrorMessage(from: data) {
                    throw NetworkError.httpError(statusCode: statusCode, localizedDesc: errorMessage)
                } else {
                    throw NetworkError.httpError(statusCode: statusCode, localizedDesc: LocalizedStrings.somethingWentWrong)
                }
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
                    throw NetworkError.cannotConnectToHost(endpoint)
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
    
    func extractErrorMessage(from data: Data) -> String? {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return errorResponse.message
        } catch {
            return nil
        }
    }
}
