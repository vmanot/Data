//
// Copyright (c) Vatsal Manot
//

import Swift

extension Character: Codable {
    public func encode(to encoder: Encoder) throws {
        try String(self).encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        self.init(try String(from: decoder))
    }
}

extension UnicodeScalar: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try UnicodeScalar(try container.decode(UInt32.self))
            .unwrapOrThrow(DecodingError.dataCorruptedError(in: container, debugDescription: .init()))
    }
}
