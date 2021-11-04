import Combine

protocol CustomersListPublisher {
    var value: [Customer]? { get set }
    var published: Published<[Customer]?> { get }
    var publisher: Published<[Customer]?>.Publisher { get }
}

extension ValuePublisher: CustomersListPublisher where Value == [Customer] {}

