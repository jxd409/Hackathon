extension SWEnvironment {
    var firebaseAPI: String {
        switch self {
        case .dev, .qa: return Constants.FirebaseAPI.QA
        case .prod: return Constants.FirebaseAPI.PRODUCTION
        }
    }
}
