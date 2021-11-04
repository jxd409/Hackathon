import Combine
import SwiftUI

extension LeadListView: ViewModel {

    class ViewModel: ObservableObject {

        @Published var projects = [Project]()

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

                    print(projects)

                    guard let self = self else { return }

                    getProjectStatesUseCase.getProjectStates()
                        .replaceError(with: [])
                        .receive(on: DispatchQueue.main)
                        .sink { projectStates in

                            let filteredProjectIds = projectStates.filter { projectState in
                                projectState.contractorId == self.preferences.accountId
                            }.map { $0.projectId }

                            print(filteredProjectIds)

                            let filteredProjects = projects.filter { project in
                                filteredProjectIds.contains(project.id)
                            }

                            print(filteredProjects)

                            self.projects = filteredProjects
                        }.store(in: &self.cancellables)

                }
                .store(in: &cancellables)

        }
    }
}
