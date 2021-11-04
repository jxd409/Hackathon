import SwiftUI

extension LeadDetailView {
    class ViewModel: ObservableObject {

        let preferences: Preferences
        let updateProjectState: UpdateProjectStateUseCase

        init(preferences: Preferences = DIContainer.shared.resolve(),
             updateProjectState: UpdateProjectStateUseCase = DIContainer.shared.resolve()) {

            self.preferences = preferences
            self.updateProjectState = updateProjectState
        }

        func accept(project: Project) {
            guard let contractorId = preferences.accountId else {
                return
            }

            let projectState = ProjectState(contractorId: contractorId,
                                            projectId: project.id,
                                            projectStatus: .accepted)

            updateProjectState.updateProjectState(projectState: projectState)

        }
    }
}
