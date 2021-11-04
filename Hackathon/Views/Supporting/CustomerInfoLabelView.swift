import SwiftUI

struct CustomerInfoLabelView: View {
    var title: String = ""
    var customerInfo: String = ""

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .foregroundColor(Color.gray)
            Text(customerInfo)
        }
    }
}
