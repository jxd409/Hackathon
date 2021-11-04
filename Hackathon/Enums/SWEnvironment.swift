enum SWEnvironment {
    case dev
    case qa
    case prod

    static var `default`: SWEnvironment {
        #if DEBUG
        .qa
        #else
        .prod
        #endif
    }
}
