import Combine
import SwiftUI

struct ContractorListView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel

    var body: some View {

        List {
            ForEach(viewModel.contractors, id: \.self) { contractor in
                Button {
                    viewModel.selectContractor(contractor: contractor)
                    dismiss()
                } label: {
                    HStack {
                        VStack (alignment: .leading, spacing: 5) {
                            Text(contractor.name)
                                .font(.headline)
                            Text("Location: \(contractor.zipCode)")
                            Text("Available: \(contractor.leadTime)")
                        }
                        Spacer()
                        Image(systemName: "arrow.forward")
                    }
                }
                .foregroundColor(.black)
            }
        }

        .navigationTitle("Available Contractors")
    }
}

extension ContractorListView: ViewModel {

    class ViewModel: ObservableObject {

        @Published var contractors = [Contractor]()

        let createProjectStateUseCase: CreateProjectStateUseCase
        let getContractorsUseCase: GetContractorsUseCase
        let projectId: String

        var cancellables = Set<AnyCancellable>()

        init(projectId: String,
             createProjectStateUseCase: CreateProjectStateUseCase = DIContainer.shared.resolve(),
             getContractorsUseCase: GetContractorsUseCase = DIContainer.shared.resolve()) {

            self.createProjectStateUseCase = createProjectStateUseCase
            self.getContractorsUseCase = getContractorsUseCase
            self.projectId = projectId

            getContractorsUseCase.getContractors()
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .sink { [weak self] contractors in
                    self?.contractors = contractors
                }
                .store(in: &cancellables)

        }

        func selectContractor(contractor: Contractor) {

            let projectState = ProjectState(contractorId: contractor.id,
                                            projectId: projectId,
                                            projectStatus: .requested)

            createProjectStateUseCase.createProjectState(projectState: projectState)

        }
    }
}

//struct ProContractorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContractorListView()
//    }
//}
