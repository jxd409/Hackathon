protocol CreateProjectUseCase {
    @discardableResult
    func createProject(project: Project) -> Project
}
