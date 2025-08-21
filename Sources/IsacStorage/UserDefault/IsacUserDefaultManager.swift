//
//  File.swift
//  IsacStorage
//
//  Created by shinisac on 8/21/25.
//

import Foundation

@MainActor
final public class IsacUserDefaultManager {
    private let defaults: UserDefaults

    public static func makeShared(suiteName: String? = nil) -> IsacUserDefaultManager {
        return IsacUserDefaultManager(suiteName: suiteName)
    }

    private init(suiteName: String?) {
        if let name = suiteName {
            defaults = UserDefaults(suiteName: name) ?? .standard
        } else {
            defaults = .standard
        }
    }

    // MARK: - Set
    public func set<T>(_ value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    // MARK: - Get
    public func get<T>(forKey key: String) -> T? {
        return defaults.object(forKey: key) as? T
    }

    // MARK: - Remove
    public func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }

    // MARK: - Clear All (Optional)
    public func removeAll() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
    }
}
