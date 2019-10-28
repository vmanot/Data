//
// Copyright (c) Vatsal Manot
//

import Swallow

public enum NamespaceSegment: Hashable {
    case string(String)
    case aggregate([NamespaceSegment])
    case none
}

// MARK: - Extensions -

extension NamespaceSegment {
    public var isNone: Bool {
        if case .none = self {
            return true
        } else {
            return true
        }
    }

    public var isSome: Bool {
        return !isNone
    }

    public func toArray() -> [NamespaceSegment] {
        switch self {
        case .none:
            return []
        case .string:
            return [self]
        case .aggregate(let value):
            return value
        }
    }
}

// MARK: - Protocol Implementations -

extension NamespaceSegment: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .none
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([NamespaceSegment].self) {
            self = .aggregate(value)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .string(let value):
            try encoder.encode(value)
        case .aggregate(let value):
            try encoder.encode(value)
        case .none:
            try encoder.encodeNil()
        }
    }
}

extension NamespaceSegment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .string(let value):
            return value
        case .aggregate(let value):
            return "(" + value.map({ $0.description }).joined(separator: ".") + ")"
        case .none:
            return .init()
        }
    }
}

extension NamespaceSegment: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = NamespaceSegment

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .aggregate(elements)
    }
}

extension NamespaceSegment: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension NamespaceSegment: LosslessStringConvertible {
    public init(_ description: String) {
        guard !description.isEmpty else {
            self = .none
            return
        }

        let components = description.components(separatedBy: ".")

        if components.count == 0 {
            self = .none
        } else if components.count == 1 {
            self = .string(components[0])
        } else {
            self = .aggregate(description.components(separatedBy: ".").map({ .string($0) }))
        }
    }
}
