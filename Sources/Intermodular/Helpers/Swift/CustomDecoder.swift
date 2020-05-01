//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow

open class CustomDecoder: Decoder {
    public var _codingPath: [CodingPathElement] {
        return []
    }
    
    public final var codingPath: [CodingKey] {
        return _codingPath
    }
    
    public let userInfo: [CodingUserInfoKey: Any] = [:]
    
    public init() {
        
    }
    
    open func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        return .init(CustomKeyedDecodingContainer(decoder: self))
    }
    
    open func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return CustomUnkeyedDecodingContainer(decoder: self)
    }
    
    open func singleValueContainer() throws -> SingleValueDecodingContainer {
        return CustomSingleValueDecodingContainer(decoder: self)
    }
    
    // MARK: - Customization Point -
    
    // MARK: Single Value Decoding
    
    open func decodeNil(in container: CustomSingleValueDecodingContainer) throws -> Bool {
        throw Never.Reason.abstract
    }
    
    open func decode<T: Decodable>(_ type: T.Type, in container: CustomSingleValueDecodingContainer) throws -> T {
        throw Never.Reason.abstract
    }
    
    // MARK: Unkeyed Decoding
    
    open func count(in container: CustomUnkeyedDecodingContainer) throws -> Int? {
        throw Never.Reason.abstract
    }
    
    open func isAtEnd(in container: CustomUnkeyedDecodingContainer) throws -> Bool {
        throw Never.Reason.abstract
    }
    
    open func decodeNil(in container: CustomUnkeyedDecodingContainer) throws -> Bool {
        throw Never.Reason.abstract
    }
    
    open func decode<T: Decodable>(_ type: T.Type, in container: CustomUnkeyedDecodingContainer) throws -> T {
        throw Never.Reason.abstract
    }
    
    // MARK: Keyed Decoding
    
    open func allKeys<Key: CodingKey>(in container: CustomKeyedDecodingContainer<Key>) throws -> [Key] {
        throw Never.Reason.abstract
    }
    
    public func contains<Key: CodingKey>(_ key: Key, in container: CustomKeyedDecodingContainer<Key>) throws -> Bool {
        throw Never.Reason.abstract
    }
    
    open func decodeNil<Key: CodingKey>(forKey key: CodingKey, in container: CustomKeyedDecodingContainer<Key>) throws -> Bool {
        throw Never.Reason.abstract
    }
    
    open func decode<T: Decodable, Key: CodingKey>(_ type: T.Type, forKey key: CodingKey, in container: CustomKeyedDecodingContainer<Key>) throws -> T {
        throw Never.Reason.abstract
    }
}

open class CustomDecoderChild: CustomDecoder {
    public let parent: CustomDecoder
    public let key: CodingPathElement
    
    public override var _codingPath: [CodingPathElement] {
        return parent._codingPath + key
    }
    
    public init(parent: CustomDecoder, key: CodingPathElement) {
        self.parent = parent
        self.key = key
    }
}
