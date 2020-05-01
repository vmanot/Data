//
// Copyright (c) Vatsal Manot
//

import Compute
import Swallow

open class CustomEncoder: Encoder {
    public var _codingPath: [CodingPathElement] {
        return []
    }

    public final var codingPath: [CodingKey] {
        return _codingPath
    }

    public let userInfo: [CodingUserInfoKey: Any] = [:]

    open func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        return .init(CustomKeyedEncodingContainer(encoder: self))
    }

    open func unkeyedContainer() -> UnkeyedEncodingContainer {
        return CustomUnkeyedEncodingContainer(encoder: self)
    }

    open func singleValueContainer() -> SingleValueEncodingContainer {
        return CustomSingleValueEncodingContainer(encoder: self)
    }

    // MARK: - Customization Point -

    // MARK: Single Value Encoding

    open func encodeNil(in container: CustomSingleValueEncodingContainer) throws {

    }

    open func encode<T: Encodable>(_ value: T, in container: CustomSingleValueEncodingContainer) throws {

    }

    // MARK: Unkeyed Encoding

    open func encodeNil(in container: CustomUnkeyedEncodingContainer) throws {

    }

    open func encode<T: Encodable>(_ value: T, in container: CustomUnkeyedEncodingContainer) throws {

    }

    // MARK: Keyed Encoding

    open func encodeNil<Key: CodingKey>(forKey key: CodingKey, at container: CustomKeyedEncodingContainer<Key>) throws {

    }

    open func encode<T: Encodable, Key: CodingKey>(_ value: T, forKey key: CodingKey, in container: CustomKeyedEncodingContainer<Key>) throws {

    }
}

open class CustomEncoderChild: CustomEncoder {
    public let parent: CustomEncoder
    public let key: CodingPathElement

    public override var _codingPath: [CodingPathElement] {
        return parent._codingPath + key
    }

    public init(parent: CustomEncoder, key: CodingPathElement) {
        self.parent = parent
        self.key = key
    }
}
