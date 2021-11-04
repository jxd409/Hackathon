import Foundation
import UIKit

public extension UIFont {
    // H1
    static var headingLarge: UIFont { UIFont(name: Fonts.extraBold, size: 24.0)! }

    // H2 - Capitalized & H3 - Sentance case
    static var headingMedium: UIFont { UIFont(name: Fonts.extraBold, size: 18.0)! }

    // H4
    static var subheadingLarge: UIFont { UIFont(name: Fonts.semiBold, size: 16.0)! }

    // H5
    static var subheadingSmall: UIFont { UIFont(name: Fonts.semiBold, size: 14.0)! }

    // Buttons
    static var subheadingSmallBold: UIFont { UIFont(name: Fonts.bold, size: 14.0)! }

    // Label Heading 1 - in both Primary Blue and Brand Text
    static var labelHeadingExtraBold: UIFont { UIFont(name: Fonts.extraBold, size: 12.0)! }

    // Label Heading 2 - in both Primary Blue and Brand Text
    static var labelHeadingBold: UIFont { UIFont(name: Fonts.bold, size: 12.0)! }

    // Body Copy - Large
    static var bodyCopyLarge: UIFont { UIFont(name: Fonts.regular, size: 14.0)! }

    // Body Copy - Small
    static var bodyCopySmall: UIFont { UIFont(name: Fonts.regular, size: 12.0)! }
}

extension UIFont {
    struct Fonts {
        static let extraBold = "OpenSans-ExtraBold"
        static let semiBold = "OpenSans-SemiBold"
        static let bold = "OpenSans-Bold"
        static let regular = "OpenSans-Regular"
    }
}
