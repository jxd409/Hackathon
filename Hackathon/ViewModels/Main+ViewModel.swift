import Combine
import SwiftUI

extension MainView: ViewModel {
    class ViewModel: ObservableObject {

        @Published var applicationType = SWApplication.colorSnap
        @Published var isLoggedIn: Bool = false
        @Published var modalIsActive: Bool = false
        @Published var modalView: AnyView? = nil {
            didSet {
                modalIsActive = modalView != nil
            }
        }

        var cancellables = Set<AnyCancellable>()

        // Injected
        let preferencesPublisher: PreferencesPublisher

        init(preferencesPublisher: PreferencesPublisher = DIContainer.shared.resolve()) {
            self.preferencesPublisher = preferencesPublisher

            preferencesPublisher.publisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] preferences in
                    self?.isLoggedIn = preferences?.contractorId != nil
                }
                .store(in: &cancellables)
        }
    }
}

extension MainView.ViewModel: ApplicationSwitcherUseCase {
    func switchApplication() {
        applicationType = applicationType == .colorSnap ? .proApp : .colorSnap
    }
}

extension MainView.ViewModel: ModalPresentationController {
    func presentViewModally<Modal: View>(view: Modal) {
        modalView = AnyView(view)
    }
}

