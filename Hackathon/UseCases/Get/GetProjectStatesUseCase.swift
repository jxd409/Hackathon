import Combine

protocol GetProjectStatesUseCase {
    func getProjectStates() -> Future <[ProjectState], ServiceError>
}
