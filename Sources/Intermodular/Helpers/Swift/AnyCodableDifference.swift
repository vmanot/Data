//
// Copyright (c) Vatsal Manot
//

import Swift

public struct AnyCodableDifference<T: Codable>: Hashable {
    public let insertions: [AnyCodable]
    public let updates: [CodingKeyPath: AnyHashable]
    public var removals: [CodingKeyPath]
}
