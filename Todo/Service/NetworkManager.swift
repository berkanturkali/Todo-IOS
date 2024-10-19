//

import Foundation


struct NetworkManager {
    
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func handleNetworkError(_ error : NetworkError) -> String {
        switch error {
        case .badURL(let url):
            return String(format: LocalizedStrings.invalidUrl, url)
        case .requestFailed(let errorDescription):
            return errorDescription
        case .decodingError(let error):
            return String(format: LocalizedStrings.decodingError, error.localizedDescription)
        case .httpError(let code, let message):
            return String(format: LocalizedStrings.somethingWentWrongWithTheCodeAndMessage, code, message)
        case .notConnectedToInternet:
            return LocalizedStrings.notConnectedToInternet
        case .timedOut:
            return LocalizedStrings.timeout
        case .cannotConnectToHost(let host):
            return String(format: LocalizedStrings.canNotConnectedToHost, host)
        case .unknownError:
            return LocalizedStrings.somethingWentWrong
        }
    }
    
    func request<T: Encodable, U: Codable> (
        to endpoint: String,
        method: HttpMethod,
        body: T? = nil,
        responseType: U.Type
    ) async throws -> U {
        
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.badURL(endpoint)
        }
        
        do {
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let body = body {
                let jsonBody = try JSONEncoder().encode(body)
                request.httpBody = jsonBody
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                if let errorMessage = extractErrorMessage(from: data) {
                    throw NetworkError.httpError(statusCode: statusCode, localizedDesc: errorMessage)
                } else {
                    throw NetworkError.httpError(statusCode: statusCode, localizedDesc: LocalizedStrings.somethingWentWrong)
                }
            }
            
            let decodedResponse = try JSONDecoder().decode(responseType, from: data)
            return decodedResponse
            
            
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
    
    private func extractErrorMessage(from data: Data) -> String? {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return errorResponse.message
        } catch {
            return nil
        }
    }
}
