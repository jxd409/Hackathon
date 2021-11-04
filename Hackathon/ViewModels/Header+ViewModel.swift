import Combine
import SwiftUI

extension HeaderModifier: ViewModel {

    class ViewModel: ObservableObject {

        @Published var state = ViewModelState.idle {
            didSet {
                switch (state) {
                case .idle: break
                case .changeSettings: modalPresentationController.presentViewModally(view: SettingsView(model: .init()))
                }
            }
        }

        private var cancellable: AnyCancellable? = nil
        private let modalPresentationController: ModalPresentationController

        init(modalPresentationController: ModalPresentationController = DIContainer.shared.resolve()) {

            self.modalPresentationController = modalPresentationController
        }
    }
}

extension HeaderModifier.ViewModel {
    enum ViewModelState {
        case idle
        case changeSettings
    }
}
