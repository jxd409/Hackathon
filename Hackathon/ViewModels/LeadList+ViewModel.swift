import Combine
import SwiftUI

extension LeadListView: ViewModel {

    class ViewModel: ObservableObject {

        @Published var values = [(projectState: ProjectState, project: Project)]()

        let preferences: Preferences
        let getProjectsUseCase: GetProjectsUseCase
        let getProjectStatesUseCase: GetProjectStatesUseCase

        var cancellables = Set<AnyCancellable>()

        init(getProjectsUseCase: GetProjectsUseCase = DIContainer.shared.resolve(),
             getProjectStatesUseCase: GetProjectStatesUseCase = DIContainer.shared.resolve(),
             preferences: Preferences = DIContainer.shared.resolve()) {

            self.getProjectsUseCase = getProjectsUseCase
            self.getProjectStatesUseCase = getProjectStatesUseCase
            self.preferences = preferences

            getProjectsUseCase.getProjects()
                .sink { completion in
                    switch completion {
                    case .failure(let error): print(error)
                    case .finished: break
                    }
                } receiveValue: { [weak self] projects in

                    guard let self = self else { return }

                    getProjectStatesUseCase.getProjectStates()
                        .replaceError(with: [])
                        .receive(on: DispatchQueue.main)
                        .sink { projectStates in

                            let filteredProjectStates = projectStates.filter { projectState in
                                projectState.contractorId == self.preferences.contractorId
                            }

                            filteredProjectStates.forEach { projectState in
                                if let project = projects.first(where: { $0.id == projectState.projectId }) {
                                    self.values.append((projectState: projectState, project: project))
                                }
                            }

                        }.store(in: &self.cancellables)

                }
                .store(in: &cancellables)

        }
    }
}
