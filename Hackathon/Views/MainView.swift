import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel: ViewModel = DIContainer.shared.resolve()

    var body: some View {
        
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.isLoggedIn {
                    NavigationLink(destination: LeadListView()) {
                        Text("Show jobs available")
                    }
                } else {
                    NavigationLink(destination: CreateContractorView()) {
                        Text("Create a Pro Profile")
                    }
                    NavigationLink(destination: SignInView(viewModel: .init())) {
                        Text("Sign In")
                    }

                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pro App")
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
