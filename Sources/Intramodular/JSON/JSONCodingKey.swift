//
// Copyright (c) Vatsal Manot
//

import Swift

// A structure that allows an arbitrary `String` to be used as a coding key.
public struct JSONCodingKey: CodingKey {
    public var stringValue: String

    public init(stringValue: String) {
        self.stringValue = stringValue
    }

    public var intValue: Int?

    public init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
