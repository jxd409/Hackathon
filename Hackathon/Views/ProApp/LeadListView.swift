import Combine
import SwiftUI

struct LeadListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        List {
            Section("Requested Projects") {
                ForEach(viewModel.values.indices, id: \.self) { index in
                    if let value = viewModel.values[index] {
                        NavigationLink(destination: LeadDetailView(project: value.project,
                                                                   projectState: value.projectState)) {
                            Text(value.project.name)
                        }
                    }
                }
            }
        }
    }
}

struct LeadFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LeadListView()
    }
}
