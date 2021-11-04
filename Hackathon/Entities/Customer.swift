import Foundation
struct Customer: Codable, Identifiable, Hashable {

    var id: String
    var projectIds: [String]

    enum CodingKeys: CodingKey {
        case projectIds
    }

    init(projectIds: [String], id: String = UUID().uuidString) {
        self.projectIds = projectIds
        self.id = id
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        projectIds = try container.decode([String].self, forKey: CodingKeys.projectIds)
        id = container.codingPath.first!.stringValue
    }
}
