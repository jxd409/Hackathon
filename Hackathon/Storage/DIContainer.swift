import Foundation

protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component?
}

final class DIContainer {
    static let shared = DIContainer()

    private var storage = [ObjectIdentifier: Any]()

    func add<T: Any>(_ injectable: T, for types: [Any.Type]) {
        for t in types {
            let type: Any.Type = t.self
            let key = ObjectIdentifier(type)
            storage[key] = injectable
        }

        add(injectable) // add reference to own type
    }

    func add<T: Any>(_ injectable: T) {
        let key = ObjectIdentifier(T.self)
        storage[key] = injectable
    }

    func resolve<T: Any>() -> T {
        let key = ObjectIdentifier(T.self)

        guard let injectable = storage[key] as? T else {
            if storage[key] == nil {
                fatalError("\(T.self) has not been added as an injectable object.")
            } else {
                fatalError("\(String(describing: storage[key])) does not conform to \(T.self).")
            }
        }

        return injectable
    }
}
