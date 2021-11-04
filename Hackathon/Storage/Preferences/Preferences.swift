import Foundation

protocol Preferences {
    var contractorId: String? { get set }
    func clear()
}
