//
// Copyright (c) Vatsal Manot
//

import Compute
import Concurrency
import Combine
import Swift

public protocol IndirectKeyedEncodingContainer: KeyedEncodingContainerProtocol {
    func decode<T>(_ type: IndirectCodable<T>, forKeyPath: CodingKeyPath) -> Future<T, Error>
}

public enum IndirectDecodingError: Error {
    case unsupportedDecoder(Decoder)
}

public enum IndirectEncodingError: Error {
    case unsupportedEncoder(Encoder)
}

public class IndirectCodable<T>: Codable {
    public enum Payload {
        case unrealized
        case realized(T)
        case modified(T)
    }

    public private(set) var payload: Payload

    public init(payload: Payload) {
        self.payload = payload
    }

    public func setValue(_ value: T) {
        self.payload = .modified(value)
    }

    public required init(from decoder: Decoder) throws {
        throw IndirectDecodingError.unsupportedDecoder(decoder)
    }

    public func encode(to encoder: Encoder) throws {
        throw IndirectEncodingError.unsupportedEncoder(encoder)
    }
}

public class IndirectMember<T: Codable>: IndirectCodable<T> {

}

public class IndirectRelationshipToOne<T: Codable>: IndirectCodable<T> {

}

public class IndirectRelationshipToMany<T: Codable>: IndirectCodable<[T]> {

}
