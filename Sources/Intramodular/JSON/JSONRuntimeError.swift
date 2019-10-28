//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

public enum JSONRuntimeError: Error {
    case noContainer
    case irrepresentableNumber(NSNumber)
    case noFallbackCovariantForSupertype(Any.Type)
    case stringEncodingError
    case unexpectedlyFoundNil(file: StaticString, function: StaticString, line: UInt)
    case isNotEmpty
}

// MARK: - Helpers -

extension Optional {
    public func unwrapOrThrowJSONRuntimeError(file: StaticString = #file, function: StaticString = #function, line: UInt = #line) throws -> Wrapped {
        return try unwrapOrThrow(JSONRuntimeError.unexpectedlyFoundNil(file: file, function: function, line: line))
    }
}
