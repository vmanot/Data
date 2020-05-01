//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow

open class CustomEncodingContainer {
    public let encoder: CustomEncoder

    public var codingPath: [CodingKey] {
        return encoder.codingPath
    }

    public init(encoder: CustomEncoder) {
        self.encoder = encoder
    }
}

open class CustomSingleValueEncodingContainer: CustomEncodingContainer, SingleValueEncodingContainer {
    public func encodeNil() throws {
        try encoder.encodeNil(in: self)
    }

    public func encode<T: Encodable>(_ value: T) throws {
        try encoder.encode(value, in: self)
    }
}

open class CustomUnkeyedEncodingContainer: CustomEncodingContainer, UnkeyedEncodingContainer {
    public var count: Int = 0

    public func encodeNil() throws {
        try encoder.encodeNil(in: self)

        count += 1
    }

    public func encode<T: Encodable>(_ value: T) throws {
        try encoder.encode(value, in: self)

        count += 1
    }

    public func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey>  {
        defer {
            count += 1
        }

        return .init(CustomKeyedEncodingContainer(encoder: CustomEncoderChild(parent: encoder, key: .unkeyedAccess(at: count))))
    }

    public func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        defer {
            count += 1
        }

        return CustomUnkeyedEncodingContainer(encoder: CustomEncoderChild(parent: encoder, key: .unkeyedAccess(at: count)))
    }

    public func superEncoder() -> Encoder {
        return CustomEncoderChild(
            parent: encoder,
            key: .super
        )
    }
}

open class CustomKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    public let encoder: CustomEncoder

    public var codingPath: [CodingKey] {
        return encoder.codingPath
    }

    public init(encoder: CustomEncoder) {
        self.encoder = encoder
    }

    public func encodeNil(forKey key: Key) throws {
        try encoder.encodeNil(forKey: key, at: self)
    }

    public func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
        try encoder.encode(value, forKey: key, in: self)
    }

    public func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey>  {
        return .init(CustomKeyedEncodingContainer<NestedKey>(encoder: CustomEncoderChild(parent: encoder, key: .key(key))))
    }

    public func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return CustomUnkeyedEncodingContainer(encoder: CustomEncoderChild(parent: encoder, key: .key(key)))
    }

    public func superEncoder() -> Encoder {
        return CustomEncoderChild(
            parent: encoder,
            key: .super
        )
    }

    public func superEncoder(forKey key: Key) -> Encoder {
        return CustomEncoderChild(
            parent: encoder,
            key: .keyedSuper(key)
        )
    }
}
