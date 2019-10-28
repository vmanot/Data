//
// Copyright (c) Vatsal Manot
//

import Swift

public struct ExtendedSingleValueEncodingContainer: SingleValueEncodingContainer {
    private var parent: Encoder
    private var base: SingleValueEncodingContainer

    public init(_ base: SingleValueEncodingContainer, parent: Encoder) {
        self.parent = parent
        self.base = base
    }

    public var codingPath: [CodingKey] {
        return base.codingPath
    }

    public mutating func encodeNil() throws {
        return try base.encodeNil()
    }

    public mutating func encode(_ value: Bool) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int8) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int16) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int32) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int64) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt8) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt16) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt32) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt64) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Float) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Double) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: String) throws {
        return try base.encode(value)
    }

    public mutating func encode<T: Encodable>(_ value: T) throws {
        return try base.encode(value)
    }
}

public struct ExtendedUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    private var parent: Encoder
    private var base: UnkeyedEncodingContainer

    public init(_ base: UnkeyedEncodingContainer, parent: Encoder) {
        self.parent = parent
        self.base = base
    }

    public var codingPath: [CodingKey] {
        return base.codingPath
    }

    public var count: Int {
        return base.count
    }

    public mutating func encodeNil() throws {
        try base.encodeNil()
    }

    public mutating func encode(_ value: Bool) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int8) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int16) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int32) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Int64) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt8) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt16) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt32) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: UInt64) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Float) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: Double) throws {
        return try base.encode(value)
    }

    public mutating func encode(_ value: String) throws {
        return try base.encode(value)
    }

    public mutating func encode<T: Encodable>(_ value: T) throws  {
        return try base.encode(value)
    }

    // This is where the magic happens.

    public mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey>  {
        return .init(ExtendedKeyedEncodingContainer(base.nestedContainer(keyedBy: keyType), parent: parent))
    }

    public mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return ExtendedUnkeyedEncodingContainer(base.nestedUnkeyedContainer(), parent: parent)
    }

    public mutating func superEncoder() -> Encoder {
        return ExtendedEncoder(base.superEncoder())
    }
}

public struct ExtendedKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    private var base: KeyedEncodingContainer<Key>
    private var parent: Encoder

    public init(_ base: KeyedEncodingContainer<Key>, parent: Encoder) {
        self.parent = parent
        self.base = base
    }

    public var codingPath: [CodingKey] {
        return base.codingPath
    }

    public mutating func encodeNil(forKey key: Key) throws {
        return try base.encodeNil(forKey: key)
    }

    public mutating func encode(_ value: Bool, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int8, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int16, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int32, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Int64, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt8, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt16, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt32, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: UInt64, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Float, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: Double, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode(_ value: String, forKey key: Key) throws {
        return try base.encode(value, forKey: key)
    }

    public mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        return try base.encode(value, forKey: key)
    }

    // This is where the magic happens.

    public mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        return .init(ExtendedKeyedEncodingContainer<NestedKey>(base.nestedContainer(keyedBy: keyType, forKey: key), parent: parent))
    }

    public mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return ExtendedUnkeyedEncodingContainer(base.nestedUnkeyedContainer(forKey: key), parent: parent)
    }

    public mutating func superEncoder() -> Encoder {
        return ExtendedEncoder(base.superEncoder())
    }

    public mutating func superEncoder(forKey key: Key) -> Encoder {
        return ExtendedEncoder(base.superEncoder(forKey: key))
    }
}
