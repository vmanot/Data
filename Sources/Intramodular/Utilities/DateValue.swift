//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

public protocol DateValueCodableStrategy {
    associatedtype RawValue: Codable
    
    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}

@propertyWrapper
public struct DateValue<Formatter: DateValueCodableStrategy>: Codable {
    private let value: Formatter.RawValue
    
    public var wrappedValue: Date
    
    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        self.value = Formatter.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.value = try Formatter.RawValue(from: decoder)
        self.wrappedValue = try Formatter.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

@propertyWrapper
public struct OptionalDateValue<Formatter: DateValueCodableStrategy>: Codable {
    private var value: Formatter.RawValue? = nil
    
    public var wrappedValue: Date?
    
    public init(wrappedValue: Date? = nil) {
        self.wrappedValue = wrappedValue
        self.value = wrappedValue.map(Formatter.encode)
    }
    
    public init(from decoder: Decoder) throws {
        do {
            guard try !decoder.decodeNil() else {
                return
            }
        } catch(_) {
            
        }
        
        self.value = try Formatter.RawValue(from: decoder)
        self.wrappedValue = try Formatter.decode(try Formatter.RawValue(from: decoder))
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
