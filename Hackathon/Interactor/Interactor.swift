import Combine

class Interactor<Service> {
    let service: Service
    var cancellables = Set<AnyCancellable>()

    init(service: Service = DIContainer.shared.resolve()) {
        self.service = service
    }
}
