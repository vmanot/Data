//
// Copyright (c) Vatsal Manot
//

import CoreData
import Swift

/// A CoreData field coder.
public protocol CoreDataFieldCoder {
    static func decodePrimitive<Key: CodingKey>(from _: NSManagedObject, forKey _: Key) throws -> Self
    static func decode<Key: CodingKey>(from _: NSManagedObject, forKey _: Key) throws -> Self

    func encodePrimitive<Key: CodingKey>(to _: NSManagedObject, forKey _: Key) throws
    func encode<Key: CodingKey>(to _: NSManagedObject, forKey _: Key) throws
}

// MARK: - Implementation -

extension RawRepresentable where RawValue: CoreDataFieldCoder, Self: CoreDataFieldCoder {
    public static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        try Self(rawValue: try RawValue.decodePrimitive(from: object, forKey: key)).unwrap()
    }

    public static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        try Self(rawValue: try RawValue.decode(from: object, forKey: key)).unwrap()
    }
    
    public func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        try rawValue.encodePrimitive(to: object, forKey: key)
    }
    
    public func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        try rawValue.encode(to: object, forKey: key)
    }
}
