//
// Copyright (c) Vatsal Manot
//

import Compute
import Foundation
import Swallow

public struct CodingKeyPath: Hashable, ImplementationForwardingWrapper {
    public typealias Value = LinkedList<AnyCodingKey>
    
    public let value: Value
    
    public init(_ value: Value) {
        self.value = value
    }
}

// MARK: - Protocol Implementations -

extension CodingKeyPath: Codable {
    public init(from decoder: Decoder) throws {
        self.init(try .init(from: decoder))
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension CodingKeyPath: CustomStringConvertible {
    public var description: String {
        return value.map({ $0.stringValue }).joined(separator: ".")
    }
}

extension CodingKeyPath: SequenceInitiableSequence {
    public typealias Iterator = Value.Iterator
}
