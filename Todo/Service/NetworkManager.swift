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
}
