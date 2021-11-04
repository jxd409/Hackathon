import SwiftUI

struct SignInView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            Section(header: Text("Log In")) {
                TextField("Enter userid", text: $viewModel.name)
                    .textContentType(.name)
                    .submitLabel(.done)

                Button("Sign In >"){
                    viewModel.signIn()
                }
            }
        }
        .padding()
    }
}

