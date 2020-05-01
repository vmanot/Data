//
// Copyright (c) Vatsal Manot
//

import Swift

public struct DecoderUnwrapper: Decodable {
    public let decoder: Decoder

    public init(from decoder: Decoder) throws {
        self.decoder = decoder
    }
}
