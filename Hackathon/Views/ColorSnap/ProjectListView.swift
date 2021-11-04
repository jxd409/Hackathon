import Combine
import SwiftUI

struct ProjectListView: View {

    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        List {
            Section(header: Text("My Projects")) {
                ForEach(viewModel.projects, id: \.self) { project in
                    NavigationLink(destination: CreateProjectView(viewModel: .init(project: project))) {
                        Text(project.name)
                    }
                }
            }
        }
    }
}

extension ProjectListView: ViewModel {

    class ViewModel: ObservableObject {

        @Published var projects = [Project]()

        let getProjectsUseCase: GetProjectsUseCase

        var cancellables = Set<AnyCancellable>()

        init(getProjectsUseCase: GetProjectsUseCase = DIContainer.shared.resolve()) {
            self.getProjectsUseCase = getProjectsUseCase


            getProjectsUseCase.getProjects()
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .sink { [weak self] projects in
                    self?.projects = projects
                }
                .store(in: &cancellables)
        }



    }
}
