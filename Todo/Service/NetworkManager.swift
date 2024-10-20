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
            print("here")
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
            
            if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw mapError(error, endpoint: endpoint)
        }
    }
    
    private func mapError(_ error: Error, endpoint: String) -> NetworkError {
        if let urlError = error as? URLError {
            return mapURLError(urlError, endpoint: endpoint)
        } else if let decodingError = error as? DecodingError {
            return .decodingError(decodingError)
        } else {
            return .unknownError
        }
    }
    
    private func mapURLError(_ error: URLError, endpoint: String) -> NetworkError {
        switch error.code {
        case .notConnectedToInternet:
            return .notConnectedToInternet
        case .timedOut:
            return .timedOut
        case .cannotFindHost:
            return .cannotConnectToHost(endpoint)
        default:
            return .requestFailed(error.localizedDescription)
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
