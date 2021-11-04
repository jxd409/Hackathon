import Foundation

class SWCache: Cache {

    private var cacheDirectory: URL?
    private let fileManager = FileManager()
    private let localStorage = NSCache<NSString, CacheItem>()

    // a value of `0` indicates no limit
    init(countLimit: Int = 0, totalCostLimit: Int = 0) {
        createPersistentStoreage()
        localStorage.countLimit = countLimit
        localStorage.totalCostLimit = totalCostLimit
    }

    func add(_ value: Any, forKey key: String, expires: Date = .distantFuture, persist: Bool = true) {
        let key = SWCache.sanitizedKey(key)
        let cacheItem = CacheItem(value: value, expires: expires)
        localStorage.setObject(cacheItem, forKey: NSString(string: key))
        if persist {
            writeToDisk(cacheItem: cacheItem, forKey: key)
        }
    }

    func clear() {
        removeAllObjects()
    }

    func read<T: Any>(key: String) throws -> T? {
        let key = SWCache.sanitizedKey(key)
        if let cacheItem: CacheItem = localStorage.object(forKey: NSString(string: key)),
           cacheItem.expired == false {
            return cacheItem.value as? T
        }

        return try readFromDisk(forKey: key)
    }

    func readFromDisk<T: Any>(forKey key: String) throws -> T? {
        let key = SWCache.sanitizedKey(key)
        guard let url = cacheDirectory?.appendingPathComponent(key),
              let data = try? Data(contentsOf: url),
              let cacheItem = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? CacheItem else {
                  return nil
              }

        guard !cacheItem.expired else {
            removeFromDisk(key)
            throw CacheError.expired
        }

        return cacheItem.value as? T
    }

    func removeFromDisk(_ key: String) {
        let key = SWCache.sanitizedKey(key)
        guard let url = cacheDirectory?.appendingPathComponent(key) else { return }
        _ = try? fileManager.removeItem(at: url)
    }

    func writeToDisk(cacheItem: CacheItem, forKey key: String, expires: Date = .distantFuture) {
        let key = SWCache.sanitizedKey(key)
        guard let url = cacheDirectory?.appendingPathComponent(key) else { return }

        let dataToBeArchived = try? NSKeyedArchiver.archivedData(withRootObject: cacheItem, requiringSecureCoding: true)
        try? dataToBeArchived?.write(to: url)
    }

    private func allKeys() -> [String] {
        guard let cacheDirectory = cacheDirectory else {
            return []
        }

        let urls = try? fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
        return urls?.compactMap { $0.deletingPathExtension().lastPathComponent } ?? []
    }

    private func createPersistentStoreage() {
        guard let cacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }

        cacheDirectory = cacheUrl.appendingPathComponent(Constants.directory)
        try? fileManager.createDirectory(at: cacheDirectory!, withIntermediateDirectories: true, attributes: nil)
    }

    private func removeAllObjects() {
        localStorage.removeAllObjects()

        let keys = allKeys()
        keys.forEach(removeFromDisk)
    }

    static func sanitizedKey(_ key: String) -> String {
        return key.replacingOccurrences(of: "[^a-zA-Z0-9_]+", with: "-", options: .regularExpression, range: nil)
    }
}

extension SWCache {
    struct Constants {
        static let directory = "com.sherwin.proapp.cache/"
    }
}

extension SWCache {
    enum CacheError: Error {
        case expired
        case systemError
    }
}

