import Combine

protocol ProjectListPublisher {
    var value: [Project]? { get set }
    var published: Published<[Project]?> { get }
    var publisher: Published<[Project]?>.Publisher { get }
}

extension ValuePublisher: ProjectListPublisher where Value == [Project] {}

