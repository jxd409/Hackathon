import Combine
import SwiftUI

struct ProjectListView: View {

    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List {
            Section(header: Text("My Projects")) {
                ForEach(viewModel.sortedProjects, id: \.self) { project in
                    NavigationLink(destination: CreateProjectView(viewModel: .init(project: project))) {
                        VStack (alignment: .leading, spacing: 5) {
                            Text(project.name)
                            if let state = viewModel.getState(project: project),
                               let contractor = viewModel.getContractor(projectState: state) {
                                Text("Status: \(contractor.name) \(state.projectStatus.rawValue)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: viewModel.loadData)
    }
}

extension ProjectListView: ViewModel {

    class ViewModel: ObservableObject {


        @Published var contractors = [Contractor]()
        var projects = [Project]() {
            didSet {
                sortedProjects = projects.sorted { $0.name < $1.name }
            }
        }
        @Published var sortedProjects = [Project]()
        @Published var projectStates = [ProjectState]()

        // Injected
        let getContractorUseCase: GetContractorsUseCase
        let getProjectsUseCase: GetProjectsUseCase
        let getProjectStatesUseCase: GetProjectStatesUseCase


        var cancellables = Set<AnyCancellable>()

        init(getContractorUseCase: GetContractorsUseCase = DIContainer.shared.resolve(),
             getProjectStatesUseCase: GetProjectStatesUseCase = DIContainer.shared.resolve(),
             getProjectsUseCase: GetProjectsUseCase = DIContainer.shared.resolve()) {

            self.getContractorUseCase = getContractorUseCase
            self.getProjectsUseCase = getProjectsUseCase
            self.getProjectStatesUseCase = getProjectStatesUseCase

            loadData()
        }

        func loadData() {
            getContractorUseCase.getContractors()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] contractors in
                    guard let self = self else { return }

                    self.contractors = contractors

                    self.getProjectStatesUseCase.getProjectStates()
                        .replaceError(with: [])
                        .receive(on: DispatchQueue.main)
                        .sink { projectStates in

                            self.projectStates = projectStates

                            self.getProjectsUseCase.getProjects()
                                .replaceError(with: [])
                                .receive(on: DispatchQueue.main)
                                .sink { projects in
                                    self.projects = projects

                                }.store(in: &self.cancellables)
                        }.store(in: &self.cancellables)
                }.store(in: &cancellables)
        }

        func getState(project: Project) -> ProjectState? {
            return projectStates.first(where: { $0.projectId == project.id })
        }

        func getContractor(projectState: ProjectState) -> Contractor? {
            return contractors.first(where: { $0.id == projectState.contractorId })
        }
    }
}
