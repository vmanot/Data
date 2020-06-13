//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Swallow

@propertyWrapper
public struct CoreDataField<Value> {
    public let key: AnyStringKey
    public var wrappedValue: Value
    
    @usableFromInline
    let encodeImpl: (Value, NSManagedObject) throws -> Void
    
    @usableFromInline
    let decodeImpl: (NSManagedObject) throws -> Value
    
    @inlinable
    public static subscript<EnclosingSelf: NSManagedObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            try! object[keyPath: storageKeyPath].decodeImpl(object)
        } set {
            try! object[keyPath: storageKeyPath].encodeImpl(newValue, object)
            object[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
}

extension CoreDataField where Value: Codable {
    @inlinable
    public init(key: String, defaultValue: Value) {
        self.key = .init(stringValue: key)
        self.wrappedValue = defaultValue
        
        self.encodeImpl = { try _CodableToCoreDataFieldCoder($0).encode(to: $1, forKey: AnyStringKey(stringValue: key)) }
        self.decodeImpl = { try _CodableToCoreDataFieldCoder<Value>.decode(from: $0, forKey: AnyStringKey(stringValue: key)).value }
    }
    
    @inlinable
    public init<T: Codable>(key: String, defaultValue: Value = .none) where Value == Optional<T> {
        self.key = .init(stringValue: key)
        self.wrappedValue = defaultValue
        
        self.encodeImpl = { try _OptionalCodableToCoreDataFieldCoder($0).encode(to: $1, forKey: AnyStringKey(stringValue: key)) }
        self.decodeImpl = { try _OptionalCodableToCoreDataFieldCoder<T>.decode(from: $0, forKey: AnyStringKey(stringValue: key)).value }
    }
}

extension CoreDataField where Value: CoreDataFieldCoder {
    @inlinable
    public init(key: String, defaultValue: Value) {
        self.key = .init(stringValue: key)
        self.wrappedValue = defaultValue
        
        self.encodeImpl = { try $0.encode(to: $1, forKey: AnyStringKey(stringValue: key)) }
        self.decodeImpl = { try Value.decode(from: $0, forKey: AnyStringKey(stringValue: key)) }
    }
    
    @inlinable
    public init<T>(key: String) where Value == Optional<T> {
        self.init(key: key, defaultValue: .none)
    }
}

// MARK: - Auxiliary Implementation -

@usableFromInline
struct _CodableToCoreDataFieldCoder<T: Codable>: CoreDataFieldCoder {
    @usableFromInline
    let value: T
    
    @usableFromInline
    init(_ value: T) {
        self.value = value
    }
    
    @usableFromInline
    static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        .init(try ObjectDecoder().decode(T.self, from: object.primitiveValue(forKey: key.stringValue).unwrap()))
    }
    
    @usableFromInline
    static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        .init(try ObjectDecoder().decode(T.self, from: object.value(forKey: key.stringValue).unwrap()))
    }
    
    @usableFromInline
    func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        object.setPrimitiveValue(try ObjectEncoder().encode(value), forKey: key.stringValue)
    }
    
    @usableFromInline
    func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        object.setValue(try ObjectEncoder().encode(value), forKey: key.stringValue)
    }
}

@usableFromInline
struct _OptionalCodableToCoreDataFieldCoder<T: Codable>: CoreDataFieldCoder {
    @usableFromInline
    let value: T?
    
    @usableFromInline
    init(_ value: T?) {
        self.value = value
    }
    
    @usableFromInline
    static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        guard let primitiveValue = object.primitiveValue(forKey: key.stringValue) else {
            return .init(nil)
        }
        
        return .init(try ObjectDecoder().decode(T.self, from: primitiveValue))
    }
    
    @usableFromInline
    static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        guard let value = object.value(forKey: key.stringValue) else {
            return .init(nil)
        }
        
        return .init(try ObjectDecoder().decode(T.self, from: value))
    }
    
    @usableFromInline
    func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        guard let value = value else {
            return
        }
        
        object.setPrimitiveValue(try ObjectEncoder().encode(value), forKey: key.stringValue)
    }
    
    @usableFromInline
    func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        guard let value = value else {
            return
        }
        
        object.setValue(try ObjectEncoder().encode(value), forKey: key.stringValue)
    }
}
