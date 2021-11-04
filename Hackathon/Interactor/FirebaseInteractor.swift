import Combine
import Foundation

class FirebaseInteractor: Interactor<FirebaseService>, GetContractorsUseCase {

    // Injected
    var customerListPublisher: CustomersListPublisher
    var contractorListPublisher: ContractorListPublisher
    var projectListPublisher: ProjectListPublisher
    var projectStateListPublisher: ProjectStateListPublisher

    init(contractorListPublisher: ContractorListPublisher = DIContainer.shared.resolve(),
         customerListPublisher: CustomersListPublisher = DIContainer.shared.resolve(),
         projectListPublisher: ProjectListPublisher = DIContainer.shared.resolve(),
         projectStateListPublisher: ProjectStateListPublisher = DIContainer.shared.resolve()) {

        self.contractorListPublisher = contractorListPublisher
        self.customerListPublisher = customerListPublisher
        self.projectListPublisher = projectListPublisher
        self.projectStateListPublisher = projectStateListPublisher
    }

    func getContractors() -> Future <[Contractor], ServiceError> {
        Future() { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.systemFailure))
            }

            self.service.getContractors()
                .decode(type: DecodedArray<Contractor>.self, decoder: JSONDecoder())
                .sink { completion in
                    print(completion)
                    switch completion {
                    case .failure(_): return promise(.failure(.systemFailure))
                    case .finished: break
                    }
                } receiveValue: { contractors in
                    self.contractorListPublisher.value = contractors.array
                    return promise(.success(contractors.array))
                }
                .store(in: &self.cancellables)
        }
    }
}

extension FirebaseInteractor: GetProjectsUseCase {
    func getProjects() -> Future <[Project], ServiceError> {
        Future() { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.systemFailure))
            }

            self.service.getProjects()
                .decode(type: DecodedArray<Project>.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return promise(.failure(.systemFailure))
                    case .finished: break
                    }
                } receiveValue: { projects in

                    self.projectListPublisher.value = projects.array
                    return promise(.success(projects.array))
                }
                .store(in: &self.cancellables)
        }
    }
}

extension FirebaseInteractor: GetCustomersUseCase {
    func getCustomers()-> Future <[Customer], ServiceError> {
        Future() { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.systemFailure))
            }

            self.service.getCustomers()
                .decode(type: DecodedArray<Customer>.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return promise(.failure(.systemFailure))
                    case .finished: break
                    }
                } receiveValue: { customers in
                    self.customerListPublisher.value = customers.array
                    return promise(.success(customers.array))
                }
                .store(in: &self.cancellables)
        }
    }
}

extension FirebaseInteractor: GetProjectStatesUseCase {
    func getProjectStates()-> Future <[ProjectState], ServiceError> {
        Future() { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.systemFailure))
            }

            self.service.getProjectStates()
                .decode(type: DecodedArray<ProjectState>.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        return promise(.failure(.systemFailure))
                    case .finished: break
                    }
                } receiveValue: { projectStates in
                    self.projectStateListPublisher.value = projectStates.array
                    return promise(.success(projectStates.array))
                }
                .store(in: &self.cancellables)
        }
    }
}
