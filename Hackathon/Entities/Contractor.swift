import Foundation
struct Contractor: Codable, Identifiable, Hashable {

    var id: String
    var canContact: Bool
    var leadTime: String
    var name: String
    var portfolio: String
    var zipCode: Int
    var projectTypes: [ProjectType]

    var startDate: Date? {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            return dateFormatter.date(from: leadTime)
    }

    enum CodingKeys: CodingKey {
        case canContact
        case leadTime
        case name
        case portfolio
        case zipCode
        case projectTypes
    }

    init(canContact: Bool,
         leadTime: String,
         name: String,
         portfolio: String,
         zipCode: Int,
         projectTypes: [ProjectType],
         id: String = UUID().uuidString) {

        self.canContact = canContact
        self.leadTime = leadTime
        self.name = name
        self.portfolio = portfolio
        self.zipCode = zipCode
        self.projectTypes = projectTypes
        self.id = id
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        canContact = try container.decode(Bool.self, forKey: CodingKeys.canContact)
        leadTime = try container.decode(String.self, forKey: CodingKeys.leadTime)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        portfolio = try container.decode(String.self, forKey: CodingKeys.portfolio)
        zipCode = try container.decode(Int.self, forKey: CodingKeys.zipCode)
        projectTypes = try container.decode([ProjectType].self, forKey: CodingKeys.projectTypes)

        id = container.codingPath.first!.stringValue
    }
}
