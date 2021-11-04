enum SWApplication {

    case colorSnap
    case proApp
}

extension SWApplication {
    var title: String {
        switch self {
        case .colorSnap: return "Color Snap"
        case .proApp: return "Pro App"
        }
    }
}
