import Combine

protocol GetProjectsUseCase {
    func getProjects() -> Future <[Project], ServiceError>
}
