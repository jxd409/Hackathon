import Combine

protocol ProjectStateListPublisher {
    var value: [ProjectState]? { get set }
    var published: Published<[ProjectState]?> { get }
    var publisher: Published<[ProjectState]?>.Publisher { get }
}

extension ValuePublisher: ProjectStateListPublisher where Value == [ProjectState] {}

