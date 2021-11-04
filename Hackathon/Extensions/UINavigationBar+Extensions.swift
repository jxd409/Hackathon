import UIKit

extension UINavigationBar {
    static func setDefaultAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .bluePrimary
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                              .font: UIFont.headingMedium]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            appearance().isOpaque = true
            appearance().tintColor = .white
            appearance().barTintColor = .bluePrimary
            appearance().backgroundColor = .bluePrimary
            appearance().shadowImage = UIImage()
            appearance().isTranslucent = false
            appearance().titleTextAttributes = [.foregroundColor: UIColor.white,
                                                .font: UIFont.headingMedium]
        }
    }
}
