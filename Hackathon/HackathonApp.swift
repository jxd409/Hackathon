import Combine
import SwiftUI

@main
struct HackathonApp: App {

    init() {
        Configuration.shared.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
