import UIKit

extension UINavigationBar {
    static func setDefaultAppearance(backgroundColor: UIColor = .black) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          .font: UIFont.headingMedium]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
