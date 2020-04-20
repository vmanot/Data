//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

@propertyWrapper
public struct LosslessNumber<N: Number>: Decodable, Equatable, Hashable {
    public let wrappedValue: N
    
    public init(wrappedValue: N) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        wrappedValue = try Result(
            try .init(from: decoder),
            or: try .lossless(from: try AnyNumber(from: decoder))
        ).unwrap()
    }
}

@propertyWrapper
public struct LosslessNumberRepresentable<T: RawRepresentable>: Decodable, Equatable, Hashable where T: Equatable & Hashable, T.RawValue: Number {
    public let wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        wrappedValue = try T(rawValue:
            try Result(
                try .init(from: decoder),
                or: try .lossless(from: try AnyNumber(from: decoder))
            ).unwrap()
        ).unwrap()
    }
}

@propertyWrapper
public struct OptionalLosslessNumber<N: Number>: Decodable, Equatable, Hashable {
    public let wrappedValue: N?
    
    public init(wrappedValue: N?) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.init(wrappedValue: nil)
    }
    
    public init(from decoder: Decoder) throws {
        guard (try? !decoder.decodeSingleValueNil()) ?? true else {
            wrappedValue = nil
            
            return
        }
        
        wrappedValue = try Result(
            try .init(from: decoder),
            or: try .lossless(from: try AnyNumber(from: decoder))
        ).unwrap()
    }
}
