//

import Foundation


enum NetworkError: Error {
    case badURL(String)
    case requestFailed(String)
    case decodingError(Error)
    case httpError(statusCode: Int)
    case notConnectedToInternet
    case timedOut
    case cannotFindHost
    case cannotConnectToHost
    case unknownError
}
