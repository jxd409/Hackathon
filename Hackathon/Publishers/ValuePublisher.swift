import Combine

class ValuePublisher<Value>  {
    @Published var value: Value? = nil
    var published: Published<Value?> { _value }
    var publisher: Published<Value?>.Publisher { $value }
}
