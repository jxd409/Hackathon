import SwiftUI

struct HeaderModifier: ViewModifier {
    
    @ObservedObject var model: HeaderModifier.ViewModel
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        model.state = .changeSettings
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        model.state = .changeApp
                    } label: {
                        Text("switch app")
                    }
                    .foregroundColor(.white)
                }
            }
    }
}
