class SWLogger: Logger {
    func log(_ message: String) {
        #if DEBUG
            print(message)
        #endif
    }
}
