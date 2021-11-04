import Foundation
enum ProjectType: String, Codable {

    case commercial = "commercial"
    case residential = "residential"

    var value: String {
        return rawValue
    }
}
