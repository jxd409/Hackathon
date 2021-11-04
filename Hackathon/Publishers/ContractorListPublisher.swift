import Combine

protocol ContractorListPublisher {
    var value: [Contractor]? { get set }
    var published: Published<[Contractor]?> { get }
    var publisher: Published<[Contractor]?>.Publisher { get }
}

extension ValuePublisher: ContractorListPublisher where Value == [Contractor] {}

