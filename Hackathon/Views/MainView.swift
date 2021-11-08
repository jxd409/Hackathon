import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel: ViewModel = DIContainer.shared.resolve()

    var body: some View {
        
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.applicationType == .colorSnap {
                    ProjectListView()
                    NavigationLink(destination: CreateProjectView()) {
                        Text("Create new project")
                    }
                } else {
                    if viewModel.isLoggedIn {
                        LeadListView()
                    } else {
                        NavigationLink(destination: CreateContractorView()) {
                            Text("Create a Pro Profile")
                        }
                        NavigationLink(destination: SignInView(viewModel: .init())) {
                            Text("Sign In")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.applicationType.title)
            .modifier(HeaderModifier(model: .init()))

            .sheet(isPresented: $viewModel.modalIsActive) {
            } content: {
                viewModel.modalView
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
