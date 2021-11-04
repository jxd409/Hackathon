import Foundation
import SwiftUI

struct CreateContractorView: View {
    @ObservedObject var viewModel = ViewModel()
    @FocusState var focusedField: Field?

    var body: some View {
        List {
            Section(header: Text("PROFILE")) {
                TextField("Enter Name", text: $viewModel.name)
                    .focused($focusedField, equals: .name)
                    .textContentType(.name)
                    .submitLabel(.next)
                
                TextField("Enter Portfolio URL", text: $viewModel.portfolioURL)
                    .focused($focusedField, equals: .portfolioURL)
                    .textContentType(.URL)
                    .submitLabel(.next)
                
                TextField("Enter Zipcode", text: $viewModel.zipcode)
                    .focused($focusedField, equals: .zipcode)
                    .textContentType(.postalCode)
                    .submitLabel(.done)
            }
            .onSubmit {
                switch focusedField {
                case .name:
                    focusedField = .portfolioURL
                case .portfolioURL:
                    focusedField = .zipcode
                default: break
                }
            }
            
            Section(header: Text("PROJECT TYPE")) {
                Toggle(ProjectType.residential.value, isOn: $viewModel.residential)
                Toggle(ProjectType.commercial.value, isOn: $viewModel.commercial)
            }
            
            Section {
                DatePicker("Lead Time", selection: $viewModel.selectedDate, displayedComponents: .date)
            }

        }
        .navigationTitle("Pro Profile")
        .toolbar {
            Button("Save") {
                viewModel.state = .saving
            }.disabled(!viewModel.canSave)
        }
    }
}

struct ProProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContractorView()
    }
}

extension CreateContractorView {
    enum Field {
        case name
        case portfolioURL
        case zipcode
    }
}
