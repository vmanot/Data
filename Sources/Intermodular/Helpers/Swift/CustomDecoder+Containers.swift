//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow

open class CustomDecodingContainer {
    public let decoder: CustomDecoder
    
    public var _codingPath: [CodingPathElement] {
        return decoder._codingPath
    }
    
    public var codingPath: [CodingKey] {
        return decoder.codingPath
    }
    
    public init(decoder: CustomDecoder) {
        self.decoder = decoder
    }
}

open class CustomSingleValueDecodingContainer: CustomDecodingContainer, SingleValueDecodingContainer {
    public func decodeNil() -> Bool {
        return try! decoder.decodeNil(in: self)
    }
    
    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        return try decoder.decode(type, in: self)
    }
}

open class CustomUnkeyedDecodingContainer: CustomDecodingContainer, UnkeyedDecodingContainer {
    public var count: Int? {
        return try! decoder.count(in: self)
    }
    
    public var isAtEnd: Bool {
        return try! decoder.isAtEnd(in: self)
    }
    
    public var currentIndex: Int = 0
    
    public func decodeNil() throws -> Bool {
        let result = try decoder.decodeNil(in: self)
        
        if result {
            currentIndex += 1
        }
        
        return result
    }
    
    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        let result = try decoder.decode(type, in: self)
        
        currentIndex += 1
        
        return result
    }
    
    public func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedDecodingContainer<NestedKey>  {
        defer {
            currentIndex += 1
        }
        
        return .init(CustomKeyedDecodingContainer(decoder: CustomDecoderChild(parent: decoder, key: .unkeyedAccess(at: currentIndex))))
    }
    
    public func nestedUnkeyedContainer() -> UnkeyedDecodingContainer {
        defer {
            currentIndex += 1
        }
        
        return CustomUnkeyedDecodingContainer(decoder: CustomDecoderChild(parent: decoder, key: .unkeyedAccess(at: currentIndex)))
    }
    
    public func superDecoder() -> Decoder {
        return CustomDecoderChild(
            parent: decoder,
            key: .super
        )
    }
}

open class CustomKeyedDecodingContainer<Key: CodingKey>: CustomDecodingContainer, KeyedDecodingContainerProtocol {
    public var allKeys: [Key] {
        return try! decoder.allKeys(in: self)
    }
    
    public func contains(_ key: Key) -> Bool {
        return try! decoder.contains(key, in: self)
    }
    
    public func decodeNil(forKey key: Key) throws -> Bool {
        return try decoder.decodeNil(forKey: key, in: self)
    }
    
    public func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        return try decoder.decode(type, forKey: key, in: self)
    }
    
    public func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedDecodingContainer<NestedKey>  {
        return .init(CustomKeyedDecodingContainer<NestedKey>(decoder: CustomDecoderChild(parent: decoder, key: .key(key))))
    }
    
    public func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedDecodingContainer {
        return CustomUnkeyedDecodingContainer(decoder: CustomDecoderChild(parent: decoder, key: .key(key)))
    }
    
    public func superDecoder() -> Decoder {
        return CustomDecoderChild(
            parent: decoder,
            key: .super
        )
    }
    
    public func superDecoder(forKey key: Key) -> Decoder {
        return CustomDecoderChild(
            parent: decoder,
            key: .keyedSuper(key)
        )
    }
}
