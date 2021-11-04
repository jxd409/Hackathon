import Combine
import UIKit
import Firebase

class Configuration {

    static let shared = Configuration()

    func configure() {
        FirebaseApp.configure()
        setDependencies()
        setDefaultAppearanceForUIElements()
        initialize()
    }

    private func initialize() {
        UserDefaults.standard.update()
    }

    private func setDependencies() {

        let container = DIContainer.shared

        // utils
        container.add(SWLogger(), for: [Logger.self])

        // storage
        container.add(SWCache(), for: [Cache.self])
        container.add(UserDefaults.standard, for: [Preferences.self, LogInUseCase.self, LogoutUseCase.self])

        // publishers
        container.add(ValuePublisher<Preferences>(), for: [PreferencesPublisher.self])
        container.add(ValuePublisher<[Contractor]>(), for: [ContractorListPublisher.self])
        container.add(ValuePublisher<[Project]>(), for: [ProjectListPublisher.self])
        container.add(ValuePublisher<[Customer]>(), for: [CustomersListPublisher.self])
        container.add(ValuePublisher<[ProjectState]>(), for: [ProjectStateListPublisher.self])



        // services + interactors
        container.add(FirebaseService(), for: [CreateProjectUseCase.self,
                                               CreateCustomerUseCase.self,
                                               CreateContractorUseCase.self,
                                               CreateProjectStateUseCase.self,
                                               UpdateProjectUseCase.self,
                                               UpdateCustomerUseCase.self,
                                               UpdateContractorUseCase.self,
                                               UpdateProjectStateUseCase.self])

        container.add(FirebaseInteractor(), for: [GetProjectsUseCase.self,
                                                  GetCustomersUseCase.self,
                                                  GetContractorsUseCase.self,
                                                  GetProjectStatesUseCase.self])

        // controllers
        container.add(MainView.ViewModel(), for: [ModalPresentationController.self])

    }

    func setDefaultAppearanceForUIElements() {
        UINavigationBar.setDefaultAppearance()
    }
}
