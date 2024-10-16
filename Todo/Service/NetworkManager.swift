//

import Foundation


struct NetworkManager {
    
    static func handleNetworkError(_ error : NetworkError) -> String {        
        switch error {
        case .badURL(let url):
            return url
        case .requestFailed(let errorDescription):
            return errorDescription
        case .decodingError(let error):
            return "Decoding Error: \(error)"
            
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .notConnectedToInternet:
            return "Not Connected to Internet"
        case .timedOut:
            return "Timed Out"
        case .cannotFindHost:
            return "Cannot Find Host"
        case .cannotConnectToHost:
            return "Cannot Connect to Host"
        case .unknownError:
            return "Unknown Error"
        }
    }
}
