import Foundation

extension UserDefaults: Preferences {


    var accountId: String? {
        get {
            string(forKey: Constants.Preferences.accountIdKey)
        }
        set {
            setValue(newValue, forKey: Constants.Preferences.accountIdKey)
            update()
        }
    }

    func update() {
        synchronize()

        var preferencesPublisher: PreferencesPublisher = DIContainer.shared.resolve()
        preferencesPublisher.value = self
    }

    func clear() {
        dictionaryRepresentation().keys.forEach { key in
            removeObject(forKey: key)
        }
        update()
    }
}

extension UserDefaults: LogoutUseCase {
    func logout() {
        clear()
    }
}

extension UserDefaults: LogInUseCase {
    func login(accountId: String) {
        self.accountId = accountId
    }
}
