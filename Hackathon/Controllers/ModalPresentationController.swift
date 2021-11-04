import SwiftUI

protocol ModalPresentationController {
    func presentViewModally<Modal: View>(view: Modal)
}
