//
// Copyright (c) Vatsal Manot
//

import Compute
import Concurrency
import Swallow

public protocol DatabaseRecordAssociable: Codable {

}

public enum DatabaseRecordAssociated<Model: DatabaseRecordAssociable>: Codable {
    case local(Model)
    case remote(CodingKeyPath)

    public init(from decoder: Decoder) throws {
        throw DecodingError.dataCorrupted(.init(codingPath: []))
    }

    public func encode(to encoder: Encoder) throws {
        throw EncodingError.invalidValue(self, .init(codingPath: []))
    }
}
