import Combine
import SwiftUI

struct LeadListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
                
        List {
            ForEach(viewModel.projects, id:\.self) { project in
                NavigationLink(destination: LeadDetailView(project: project)) {
                    Text(project.name)
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
