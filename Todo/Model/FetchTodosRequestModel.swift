//

import Foundation

struct FetchTodosRequestModel: Encodable {
    let filter: String
    let category: String
}
