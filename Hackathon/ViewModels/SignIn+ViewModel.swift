import Combine
import SwiftUI

extension SignInView: ViewModel {

    class ViewModel: ObservableObject {

        @Published var name: String = ""

        var cancellables = Set<AnyCancellable>()

        // Injected
        let loginUseCase: LogInUseCase
        let getContractorsUseCase: GetContractorsUseCase

        init(getContractorsUseCase: GetContractorsUseCase = DIContainer.shared.resolve(),
             loginUseCase: LogInUseCase = DIContainer.shared.resolve()) {

            self.getContractorsUseCase = getContractorsUseCase
            self.loginUseCase = loginUseCase
        }

        func signIn() {

            getContractorsUseCase.getContractors()
                .receive(on: DispatchQueue.main)
                .replaceError(with: [])
                .sink { [weak self] contractors in
                    guard let self = self else { return }

                    let contractor = contractors.first(where: { $0.name == self.name } )

                    guard let id = contractor?.id else { return }

                    self.loginUseCase.login(accountId: id)
                }
                .store(in: &cancellables)
        }
    }
}
