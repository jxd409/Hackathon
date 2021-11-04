import Combine

protocol GetContractorsUseCase {
    func getContractors() -> Future <[Contractor], ServiceError>
}
