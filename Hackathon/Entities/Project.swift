import Foundation
struct Project: Codable, Identifiable, Hashable {

    var id: String
    var name: String
    var numberOfRooms: Int
    var type: ProjectType
    var zipCode: Int

    enum CodingKeys: CodingKey {
        case name
        case numberOfRooms
        case type
        case zipCode
    }

    init(name: String,
         numberOfRooms: Int,
         type: ProjectType,
         zipCode: Int,
         id: String = UUID().uuidString) {

        self.name = name
        self.numberOfRooms = numberOfRooms
        self.type = type
        self.zipCode = zipCode
        self.id = id
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        numberOfRooms = try container.decode(Int.self, forKey: CodingKeys.numberOfRooms)
        type = try container.decode(ProjectType.self, forKey: CodingKeys.type)
        zipCode = try container.decode(Int.self, forKey: CodingKeys.zipCode)

        id = container.codingPath.first!.stringValue
    }
}
