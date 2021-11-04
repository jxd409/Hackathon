import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var model: ViewModel

    var body: some View {
        VStack {
            Button("Logout >"){
                model.logout()
                dismiss()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model: .init())
    }
}
