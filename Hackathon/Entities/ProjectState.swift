import Foundation

struct ProjectState: Codable, Identifiable, Hashable {

    var id: String
    var contractorId: String
    var projectId: String
    var projectStatus: ProjectStatus

    enum CodingKeys: CodingKey {
        case contractorId
        case projectId
        case projectStatus
    }

    init(contractorId: String,
         projectId: String,
         projectStatus: ProjectStatus,
         id: String = UUID().uuidString) {

        self.contractorId = contractorId
        self.projectId = projectId
        self.projectStatus = projectStatus
        self.id = id
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        contractorId = try container.decode(String.self, forKey: CodingKeys.contractorId)
        projectId = try container.decode(String.self, forKey: CodingKeys.projectId)
        projectStatus = try container.decode(ProjectStatus.self, forKey: CodingKeys.projectStatus)

        id = container.codingPath.first!.stringValue
    }
}
