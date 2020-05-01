//
// Copyright (c) Vatsal Manot
//

import Foundation
import Runtime
import Swallow
import Swift

public protocol DataEncodable: AnyProtocol {
    associatedtype DataEncodingStrategy
    
    func data(using _: DataEncodingStrategy) throws -> Data
}

public protocol DataEncodableWithDefaultStrategy: DataEncodable {
    static var defaultDataEncodingStrategy: DataEncodingStrategy { get }
}

public protocol DataDecodable: AnyProtocol {
    associatedtype DataDecodingStrategy
    
    init(data _: Data, using _: DataDecodingStrategy) throws
}

public protocol DataDecodableWithDefaultStrategy: DataDecodable {
    static var defaultDataDecodingStrategy: DataDecodingStrategy { get }
}

public typealias DataCodable = DataDecodable & DataEncodable
public typealias DataCodableWithDefaultStrategies = DataDecodableWithDefaultStrategy & DataEncodableWithDefaultStrategy

// MARK: - Extensions -

extension DataEncodableWithDefaultStrategy  {
    public func data() throws -> Data {
        return try data(using: Self.defaultDataEncodingStrategy)
    }
}

extension DataDecodableWithDefaultStrategy  {
    public init(data: Data) throws {
        try self.init(data: data, using: Self.defaultDataDecodingStrategy)
    }
}

// MARK: - Implementation Helpers -

extension DataEncodableWithDefaultStrategy where DataEncodingStrategy == Void {
    public static var defaultDataEncodingStrategy: DataEncodingStrategy {
        return
    }
}

extension DataDecodableWithDefaultStrategy where DataDecodingStrategy == Void {
    public static var defaultDataDecodingStrategy: DataDecodingStrategy {
        return
    }
}

extension DataEncodable where Self: ObjectiveCBridgee, Self.SwiftType: DataEncodable, Self.DataEncodingStrategy == Self.SwiftType.DataEncodingStrategy {
    public func data(using strategy: DataEncodingStrategy) throws -> Data {
        return try SwiftType
            ._conditionallyBridgeFromObjectiveC(self)
            .unwrap()
            .data(using: strategy)
    }
}

extension DataEncodable where Self: ObjectiveCBridgee, Self.SwiftType: DataEncodableWithDefaultStrategy, Self.DataEncodingStrategy == Self.SwiftType.DataEncodingStrategy {
    public static var defaultDataEncodingStrategy: DataEncodingStrategy {
        return SwiftType.defaultDataEncodingStrategy
    }
}

extension DataDecodable where Self: ObjectiveCBridgee, Self.SwiftType: DataDecodable, Self.DataDecodingStrategy == Self.SwiftType.DataDecodingStrategy {
    public init(data: Data, using strategy: DataDecodingStrategy) throws {
        self = try SwiftType(data: data, using: strategy)._bridgeToObjectiveC()
    }
}

extension DataDecodable where Self: ObjectiveCBridgee, Self.SwiftType: DataDecodableWithDefaultStrategy, Self.DataDecodingStrategy == Self.SwiftType.DataDecodingStrategy {
    public static var defaultDataDecodingStrategy: DataDecodingStrategy {
        return SwiftType.defaultDataDecodingStrategy
    }
}

public struct BinaryDataEncodingStrategy {
    
}

public struct BinaryDataDecodingStrategy {
    
}

extension BinaryInteger where Self: DataEncodable, Self.DataEncodingStrategy == BinaryDataEncodingStrategy {
    @_specialize(where Self == Int)
    @_specialize(where Self == Int8)
    @_specialize(where Self == Int16)
    @_specialize(where Self == Int32)
    @_specialize(where Self == Int64)
    @_specialize(where Self == UInt)
    @_specialize(where Self == UInt8)
    @_specialize(where Self == UInt16)
    @_specialize(where Self == UInt32)
    @_specialize(where Self == UInt64)
    @inlinable
    public func data(using strategy: DataEncodingStrategy) throws -> Data {
        TODO.whole(.rethink)
        return withUnsafeBytes(of: &trivialRepresentation.readOnly.value) {
            .init($0)
        }
    }
}

extension BinaryInteger where Self: DataDecodable, Self.DataDecodingStrategy == BinaryDataDecodingStrategy  {
    @_specialize(where Self == Int)
    @_specialize(where Self == Int8)
    @_specialize(where Self == Int16)
    @_specialize(where Self == Int32)
    @_specialize(where Self == Int64)
    @_specialize(where Self == UInt)
    @_specialize(where Self == UInt8)
    @_specialize(where Self == UInt16)
    @_specialize(where Self == UInt32)
    @_specialize(where Self == UInt64)
    @inlinable
    public init(data: Data, using strategy: DataDecodingStrategy) throws {
        TODO.whole(.complete)
        self = data.withUnsafeBytes({ $0.baseAddress!.assumingMemoryBound(to: Self.self).pointee })
    }
}
