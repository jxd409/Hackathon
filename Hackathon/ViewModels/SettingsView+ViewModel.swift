import SwiftUI

extension SettingsView: ViewModel {

    class ViewModel: ObservableObject {

        // Injected
        let cache: Cache
        let logoutUseCase: LogoutUseCase

        init(cache: Cache = DIContainer.shared.resolve(),
             logoutUseCase: LogoutUseCase = DIContainer.shared.resolve()) {

            self.cache = cache
            self.logoutUseCase = logoutUseCase
        }

        func logout() {
            logoutUseCase.logout()
            cache.clear()
        }
    }
}
