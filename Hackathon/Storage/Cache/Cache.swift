import Foundation

protocol Cache {
    func add(_ value: Any, forKey key: String, expires: Date, persist: Bool)
    func clear()
    func read<T: Any>(key: String) throws -> T?
}

extension Cache {
    func add(_ value: Any, forKey key: String, persist: Bool) {
        add(value, forKey: key, expires: .distantFuture, persist: persist)
    }

    func add(_ value: Any, forKey key: String) {
        add(value, forKey: key, expires: .distantFuture, persist: true)
    }

    func add(_ value: Any, forKey key: String, expires: Date) {
        add(value, forKey: key, expires: expires, persist: true)
    }
}
