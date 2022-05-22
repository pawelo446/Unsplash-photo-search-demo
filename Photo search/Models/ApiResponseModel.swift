
import Foundation

class APIResponse: Codable {
    var total: Int = 0
    var total_pages: Int = 0
    var results: [Picture] = []
    
}

class Picture: Codable {
    let id: String
    let urls: Urls
    let description: String?
}

class Urls: Codable {
    let full: String
    let small: String
    let regular: String
}

extension Picture: Hashable, Identifiable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Picture: Equatable{
    static func == (lhs: Picture, rhs: Picture) -> Bool {
        lhs === rhs
    }
}
