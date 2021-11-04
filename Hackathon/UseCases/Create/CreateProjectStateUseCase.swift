protocol CreateProjectStateUseCase {
    @discardableResult
    func createProjectState(projectState: ProjectState) -> ProjectState
}
