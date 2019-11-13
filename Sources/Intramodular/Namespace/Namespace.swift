//
// Copyright (c) Vatsal Manot
//

import Swallow

/// Represents a namespace in a hierarchy-based system.
public struct Namespace: Codable, Hashable {
    public var segments: [NamespaceSegment]
    
    public static var none: Namespace {
        return .init([.none])
    }
    
    public init() {
        self.segments = []
    }
    
    public init(_ segment: NamespaceSegment) {
        self.segments = [segment]
    }
    
    public func join(_ other: Namespace) -> Namespace {
        appending(contentsOf: other)
    }
}

// MARK: - Extensions -

extension Namespace {
    public var singleSegment: NamespaceSegment? {
        guard count == 1 else {
            return nil
        }
        
        return self[0]
    }
    
    public var twoSegments: (NamespaceSegment, NamespaceSegment)? {
        guard count == 2 else {
            return nil
        }
        
        return (self[0], self[1])
    }
    
    public var isSingleNone: Bool {
        guard segments.count == 1 else {
            return false
        }
        
        return segments[0].isNone
    }
    
    public var isSingleSome: Bool {
        guard segments.count == 1 else {
            return false
        }
        
        return !segments[0].isNone
    }
}

// MARK: - Protocol Implementations -

extension Namespace: Collection {
    public var startIndex: Int {
        segments.startIndex
    }
    
    public var endIndex: Int {
        segments.endIndex
    }
    
    public subscript(_ index: Int) -> NamespaceSegment {
        segments[index]
    }
}

extension Namespace: CustomStringConvertible {
    public var description: String {
        segments.map({ $0.description }).joined(separator: ".")
    }
}

extension Namespace: ExtensibleSequence {
    public typealias Element = NamespaceSegment
    
    public mutating func insert(_ segment: NamespaceSegment) {
        segments.insert(segment)
    }
    
    public mutating func append(_ segment: NamespaceSegment) {
        segments.append(segment)
    }
    
    public func makeIterator() -> Array<NamespaceSegment>.Iterator {
        segments.makeIterator()
    }
}

extension Namespace: SequenceInitiableSequence {
    public init<S: Sequence>(_ source: S) where S.Element == Element {
        segments = .init(source)
    }
}

extension Namespace: LosslessStringConvertible {
    public init(_ description: String) {
        segments = NamespaceSegment(description).toArray()
    }
}
