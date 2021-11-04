import Foundation

protocol Preferences {
    var accountId: String? { get set }
    func clear()
}
