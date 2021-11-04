import SwiftUI

extension CreateContractorView: ViewModel {
    class ViewModel: ObservableObject {

        enum State {
            case idle
            case saving
        }

        @Published var commercial: Bool = false
        @Published var residential: Bool = false
        @Published var name: String = ""
        @Published var portfolioURL: String = ""
        @Published var zipcode: String = ""
        @Published var selectedDate = Date()
        @Published var state = State.idle {
            didSet {
                switch state {
                case .idle: break
                case .saving: save()
                }
            }
        }

        var canSave: Bool {
            state != .saving && !name.isEmpty && !portfolioURL.isEmpty && !zipcode.isEmpty && (commercial || residential)
        }

        var projectTypes: [ProjectType] {
            var types = [ProjectType]()
            if residential {
                types.append(.residential)
            }
            if commercial {
                types.append(.commercial)
            }
            return types
        }


        // Injected
        let createContractorUseCase: CreateContractorUseCase
        var preferences: Preferences
        var preferencesPublisher: PreferencesPublisher

        init(createContractorUseCase: CreateContractorUseCase = DIContainer.shared.resolve(),
             preferences: Preferences = DIContainer.shared.resolve(),
             preferencesPublisher: PreferencesPublisher = DIContainer.shared.resolve()) {

            self.createContractorUseCase = createContractorUseCase
            self.preferences = preferences
            self.preferencesPublisher = preferencesPublisher
        }

        private func save() {
            let contractor = Contractor(canContact: true,
                                              leadTime: selectedDate.ISO8601Format(), // TODO: check format
                                              name: name,
                                              portfolio: portfolioURL,
                                              zipCode: Int(zipcode) ?? 0,
                                              projectTypes: projectTypes)

            createContractorUseCase.createContractor(contractor: contractor)

            preferences.contractorId = contractor.id

            state = .idle
        }

    }
}
