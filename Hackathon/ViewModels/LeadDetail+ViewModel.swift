import SwiftUI

extension LeadDetailView {
    class ViewModel: ObservableObject {

        let updateProjectState: UpdateProjectStateUseCase

        init(updateProjectState: UpdateProjectStateUseCase = DIContainer.shared.resolve()) {
            self.updateProjectState = updateProjectState
        }

        func accept(project: Project, projectState: ProjectState) {
            var newProjectState = projectState
            newProjectState.projectStatus = .accepted

            updateProjectState.updateProjectState(projectState: newProjectState)
        }
    }
}
