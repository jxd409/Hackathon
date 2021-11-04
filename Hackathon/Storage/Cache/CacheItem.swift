import Foundation

class CacheItem: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool { true }

    func encode(with coder: NSCoder) {
        coder.encode(value, forKey: "value")
        coder.encode(expires, forKey: "expires")
    }

    required init?(coder: NSCoder) {
        guard let value = coder.decodeObject(forKey: "value"),
              let expires = coder.decodeObject(forKey: "expires") as? Date else {
                  return nil
              }

        self.value = value as Any
        self.expires = expires
        super.init()
    }


    let expires: Date
    let value: Any

    var expired: Bool {
        return Date() > expires
    }

    init(value: Any, expires: Date) {
        self.value = value
        self.expires = expires
    }
}
