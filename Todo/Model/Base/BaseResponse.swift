//

import Foundation


struct BaseResponse<T: Codable> : Codable {
    let status: ResponseStatus
    let message: String?
    let data: T?
}
