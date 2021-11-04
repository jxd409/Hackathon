protocol CreateContractorUseCase {
    @discardableResult
    func createContractor(contractor: Contractor) -> Contractor
}
