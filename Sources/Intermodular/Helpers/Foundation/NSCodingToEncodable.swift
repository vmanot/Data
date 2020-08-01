//
// Copyright (c) Vatsal Manot
//

import Foundation
import Runtime
import Swallow

public struct NSCodingToEncodable: Encodable {
    public let base: NSCoding

    public init(base: NSCoding) {
        self.base = base
    }

    public func encode(to encoder: Encoder) throws {
        base.encode(with: EncoderNSCodingAdaptor(base: encoder))
    }
}

public struct HashableNSCodingToEncodable: Encodable, Hashable {
    public let base: opaque_Hashable & NSCoding

    public init(base: opaque_Hashable & NSCoding) {
        self.base = base
    }

    public func encode(to encoder: Encoder) throws {
        base.encode(with: EncoderNSCodingAdaptor(base: encoder))
    }

    public func hash(into hasher: inout Hasher) {
        base.hash(into: &hasher)
    }
}
