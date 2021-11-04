import Combine

protocol GetCustomersUseCase {
    func getCustomers() -> Future <[Customer], ServiceError>
}
