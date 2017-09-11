import Foundation

public protocol StorageAware2 {
  /**
   Tries to retrieve the object from the storage.
   - Parameter key: Unique key to identify the object in the cache
   - Returns: Cached object or nil if not found
   */
  func object<T: Codable>(forKey key: String) throws -> T

  /**
   Get cache entry which includes object with metadata.
   - Parameter key: Unique key to identify the object in the cache
   - Returns: Object wrapper with metadata or nil if not found
   */
  func entry<T: Codable>(forKey key: String) throws -> Entry2<T>

  /**
   Removes the object by the given key.
   - Parameter key: Unique key to identify the object
   */
  func removeObject(forKey key: String) throws

  /**
   Saves passed object.
   - Parameter key: Unique key to identify the object in the cache
   - Parameter object: Object that needs to be cached
   */
  func setObject<T: Codable>(_ object: T, forKey key: String) throws

  /**
   Check if an object exist by the given key.
   - Parameter key: Unique key to identify the object
   */
  func existsObject<T: Codable>(forKey key: String, ofType type: T.Type) throws -> Bool

  /**
   Removes all objects from the cache storage.
   */
  func removeAll() throws

  /**
   Clears all expired objects.
   */
  func removeExpiredObjects() throws
}

public extension StorageAware2 {
  func object<T: Codable>(forKey key: String) throws -> T {
    return try entry(forKey: key).object
  }

  func existsObject<T: Codable>(forKey key: String, ofType type: T.Type) throws -> Bool {
    do {
      let _: T = try object(forKey: key)
      return true
    } catch {
      return false
    }
  }
}
