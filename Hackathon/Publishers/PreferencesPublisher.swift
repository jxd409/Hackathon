import Combine

protocol PreferencesPublisher {
    var value: Preferences? { get set }
    var published: Published<Preferences?> { get }
    var publisher: Published<Preferences?>.Publisher { get }
}

extension ValuePublisher: PreferencesPublisher where Value == Preferences {}
