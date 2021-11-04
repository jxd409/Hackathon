import Combine
import SwiftUI

extension HeaderModifier: ViewModel {

    class ViewModel: ObservableObject {

        @Published var state = ViewModelState.idle {
            didSet {
                switch (state) {
                case .idle: break
                case .changeSettings: modalPresentationController.presentViewModally(view: SettingsView(model: .init()))
                case .changeApp: applicationSwitcherUseCase.switchApplication()
                }
            }
        }

        private var cancellable: AnyCancellable? = nil
        private let modalPresentationController: ModalPresentationController
        private let applicationSwitcherUseCase: ApplicationSwitcherUseCase

        init(applicationSwitcherUseCase: ApplicationSwitcherUseCase = DIContainer.shared.resolve(),
             modalPresentationController: ModalPresentationController = DIContainer.shared.resolve()) {

            self.applicationSwitcherUseCase = applicationSwitcherUseCase
            self.modalPresentationController = modalPresentationController
        }
    }
}

extension HeaderModifier.ViewModel {
    enum ViewModelState {
        case idle
        case changeSettings
        case changeApp
    }
}
