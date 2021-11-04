enum ProjectStatus: String, Codable {
    case none = "none"
    case requested = "requested"
    case accepted = "accepted"
    case rejected = "rejected"

    var value: String {
        return rawValue
    }
}
