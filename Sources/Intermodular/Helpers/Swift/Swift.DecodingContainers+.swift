//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

// MARK: - Decoding Containers -

public struct ExtendedSingleValueDecodingContainer: SingleValueDecodingContainer {
    private var parent: Decoder
    private var base: SingleValueDecodingContainer
    
    public init(_ base: SingleValueDecodingContainer, parent: Decoder) {
        self.parent = parent
        self.base = base
    }
    
    public var codingPath: [CodingKey] {
        return base.codingPath
    }
    
    public func decodeNil() -> Bool {
        return base.decodeNil()
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        return try base.decode(type)
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        return try base.decode(type)
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        return try base.decode(type)
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        return try base.decode(type)
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        return try base.decode(type)
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        return try base.decode(type)
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        return try base.decode(type)
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try base.decode(type)
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try base.decode(type)
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try base.decode(type)
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try base.decode(type)
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        return try base.decode(type)
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        return try base.decode(type)
    }
    
    public func decode(_ type: String.Type) throws -> String {
        return try base.decode(type)
    }
    
    // This is where the magic happens.
    
    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        return try base.decode(ExtendedDecodable<T>.self).value
    }
}

public struct ExtendedUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    private var parent: Decoder
    private var base: UnkeyedDecodingContainer
    
    public init(_ base: UnkeyedDecodingContainer, parent: Decoder) {
        self.parent = parent
        self.base = base
    }
    
    public var codingPath: [CodingKey] {
        return base.codingPath
    }
    
    public var count: Int? {
        return base.count
    }
    
    public var isAtEnd: Bool {
        return base.isAtEnd
    }
    
    public var currentIndex: Int {
        return base.currentIndex
    }
    
    public mutating func decodeNil() throws -> Bool {
        return try base.decodeNil()
    }
    
    public mutating func decode(_ type: Bool.Type) throws -> Bool {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Int.Type) throws -> Int {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Int8.Type) throws -> Int8 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Int16.Type) throws -> Int16 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Int32.Type) throws -> Int32 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Int64.Type) throws -> Int64 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: UInt.Type) throws -> UInt {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Float.Type) throws -> Float {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: Double.Type) throws -> Double {
        return try base.decode(type)
    }
    
    public mutating func decode(_ type: String.Type) throws -> String {
        return try base.decode(type)
    }
    
    // This is where the magic happens.
    
    public mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        return try base.decode(ExtendedDecodable<T>.self).value
    }
    
    public mutating func decodeIfPresent<T: Decodable>(_ type: T.Type) throws -> T? {
        return try base.decodeIfPresent(ExtendedDecodable<T>.self)?.value
    }
    
    public mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
        return .init(ExtendedKeyedDecodingContainer(try base.nestedContainer(keyedBy: type), parent: parent))
    }
    
    public mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return ExtendedUnkeyedDecodingContainer(try base.nestedUnkeyedContainer(), parent: parent)
    }
    
    public mutating func superDecoder() throws -> Decoder {
        return ExtendedDecoder(try base.superDecoder())
    }
}

public struct ExtendedKeyedDecodingContainer<T: CodingKey>: KeyedDecodingContainerProtocol {
    public typealias Key = T
    
    private var base: KeyedDecodingContainer<Key>
    private var parent: Decoder
    
    public init(_ base: KeyedDecodingContainer<Key>, parent: Decoder) {
        self.parent = parent
        self.base = base
    }
    
    public var codingPath: [CodingKey] {
        return base.codingPath
    }
    
    public var allKeys: [Key] {
        return base.allKeys
    }
    
    public func contains(_ key: Key) -> Bool {
        return base.contains(key)
    }
    
    public func decodeNil(forKey key: Key) throws -> Bool {
        return try base.decodeNil(forKey: key)
    }
    
    public func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try base.decode(type, forKey: key)
    }
    
    public func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try base.decode(type, forKey: key)
    }
    
    // This is where the magic happens.
    
    public func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        return try base.decode(ExtendedDecodable<T>.self, forKey: key).value
    }
    
    public func decodeIfPresent<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T?  {
        return try base.decodeIfPresent(ExtendedDecodable<T>.self, forKey: key)?.value
    }
    
    public func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey>  {
        return .init(ExtendedKeyedDecodingContainer<NestedKey>(try base.nestedContainer(keyedBy: type, forKey: key), parent: parent))
    }
    
    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return ExtendedUnkeyedDecodingContainer(try base.nestedUnkeyedContainer(forKey: key), parent: parent)
    }
    
    public func superDecoder() throws -> Decoder {
        return ExtendedDecoder(try base.superDecoder())
    }
    
    public func superDecoder(forKey key: Key) throws -> Decoder {
        return ExtendedDecoder(try base.superDecoder(forKey: key))
    }
}
