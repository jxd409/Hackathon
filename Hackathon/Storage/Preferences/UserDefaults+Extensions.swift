import Foundation

extension UserDefaults: Preferences {


    var contractorId: String? {
        get {
            string(forKey: Constants.Preferences.contractorId)
        }
        set {
            setValue(newValue, forKey: Constants.Preferences.contractorId)
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
    func contractorLogin(contractorId: String) {
        self.contractorId = contractorId
    }
}
