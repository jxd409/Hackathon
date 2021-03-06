import SwiftUI

struct LeadDetailView: View {
    
    var project: Project
    var projectState: ProjectState

    var viewModel = ViewModel()
        
    var body: some View {
        List {
            Section(header: Text("Customer Info")) {
                CustomerInfoLabelView(title: "Name:", customerInfo: project.name)
                CustomerInfoLabelView(title: "Zipcode:", customerInfo: String(project.zipCode))
            }
            
            Section(header: Text("Project Info")) {
                CustomerInfoLabelView(title: "Number of Rooms:", customerInfo: String(project.numberOfRooms))
                CustomerInfoLabelView(title: "Project Types:", customerInfo: project.type.rawValue)
            }
            
            // TODO: alignment center
            Button("ACCEPT") {
                viewModel.accept(project: project, projectState: projectState)
            }
        }
        
        .navigationTitle("Project Details")
    }
}
