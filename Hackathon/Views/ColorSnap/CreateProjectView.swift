//
//  CustomerProfileView.swift
//  HackathonLeadFinder
//
//  Created by Danielle Beben on 11/3/21.
//

import SwiftUI

struct CreateProjectView: View {

    @FocusState var focusedField: Field?
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        Form {
            Section(header: Text("PROFILE")) {
                TextField("Enter Project Name:", text: $viewModel.name)
                    .focused($focusedField, equals: .projectName)
                    .textContentType(.name)
                    .submitLabel(.next)
                
                TextField("Enter Zipcode:", text: $viewModel.zipCode)
                    .focused($focusedField, equals: .zipCode)
                    .textContentType(.postalCode)
                    .submitLabel(.done)
            }
            .onSubmit {
                switch focusedField {
                case .projectName:
                    focusedField = .projectName
                case .zipCode:
                    focusedField = .zipCode
                default: break
                }
            }
            
            Section(header: Text("PROJECT TYPE")) {
                Picker("Project Type", selection: $viewModel.projectType) {
                    Text("Commerical").tag(ProjectType.commercial)
                    Text("Residential").tag(ProjectType.residential)
                }
                .pickerStyle(.segmented)

            }
            
            Section(header: Text("Number of Rooms")) {
                Picker("# of Rooms", selection: $viewModel.numberOfRooms) {
                    ForEach((1...10), id: \.self) {
                        Text("\($0)")
                    }
                }
            }

            if let projectId = viewModel.projectId {
                Section(header: Text("Find a Contractor")) {
                    NavigationLink(destination: ContractorListView(viewModel: .init(projectId: projectId))) {
                        Text("see all contractors")
                    }
                }
            }
        }
        .toolbar {
            Button("Save") {
                viewModel.state = .saving
            }.disabled(!viewModel.canSave)
        }
        
        .navigationTitle("Create Project")
    }
}

extension CreateProjectView: ViewModel {

    class ViewModel: ObservableObject {

        enum State {
            case idle
            case saving
        }

        @Published var projectId: String? = nil
        @Published var name: String = ""
        @Published var zipCode: String = ""
        @Published var projectType = ProjectType.residential
        @Published var numberOfRooms = 1
        @Published var state = State.idle {
            didSet {
                switch state {
                case .idle: break
                case .saving: save()
                }
            }
        }

        var canSave: Bool {
            state != .saving && !name.isEmpty && !zipCode.isEmpty
        }




        let createProjectUseCase: CreateProjectUseCase

        init(createProjectUseCase: CreateProjectUseCase = DIContainer.shared.resolve(),
             project: Project? = nil) {
            self.createProjectUseCase = createProjectUseCase

            if let project = project {
                numberOfRooms = project.numberOfRooms
                name = project.name
                projectType = project.type
                zipCode = "\(project.zipCode)"
                projectId = project.id
            }
        }

        func save() {
            let project = Project(name: name,
                                  numberOfRooms: numberOfRooms,
                                  type: projectType,
                                  zipCode: Int(zipCode) ?? 0,
                                  id: projectId ?? UUID().uuidString)

            createProjectUseCase.createProject(project: project)

            projectId = project.id
            state = .idle
        }
    }
}


struct CustomerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView()
    }
}


extension CreateProjectView {
    enum Field {
        case projectName
        case rooms
        case zipCode
    }
}
