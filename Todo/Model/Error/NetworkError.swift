//

import Foundation


enum NetworkError: Error {
    case badURL(String)
    case requestFailed(String)
    case decodingError(Error)
    case httpError(statusCode: Int, localizedDesc: String)
    case notConnectedToInternet
    case timedOut
    case cannotConnectToHost(String)
    case unknownError
}
