import Combine
import SwiftUI

struct LeadListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
                
        List {
            ForEach(viewModel.values.indices, id: \.self) { index in
                if let value = viewModel.values[index] {
                    NavigationLink(destination: LeadDetailView(project: value.project,
                                                               projectState: value.projectState)) {
                        Text(value.project.name)
                    }
                }
            }
        }
        
        .navigationTitle("Job Finder")
    }
}

struct LeadFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LeadListView()
    }
}
