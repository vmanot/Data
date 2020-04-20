//
// Copyright (c) Vatsal Manot
//

import Swift

public struct CSVHeader: Codable {
    public var index: Int
    public var name: String?
    
    public init(index: Int, name: String? = nil) {
        self.index = index
        self.name = name
    }
}

extension CSVHeader {
    public mutating func incrementIndex(by x: Int?) {
        index += x ?? 0
    }
}

// MARK: - Protocol Implementations -

extension CSVHeader: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.index <= rhs.index
    }
}

extension CSVHeader: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.index == rhs.index
    }
}

extension CSVHeader: Hashable {
    public func hash(into hasher: inout Hasher) {
        if let name = name {
            hasher.combine(name)
        } else {
            hasher.combine(index)
        }
    }
}
