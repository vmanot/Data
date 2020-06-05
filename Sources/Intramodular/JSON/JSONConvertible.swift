//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

protocol JSONConvertible {
    func jsonValue() throws -> JSON
}

protocol JSONUnconditionalConvertible: JSONConvertible {
    func jsonValue() -> JSON
}

// MARK: - Concrete Implementations -

extension Array: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try .array(map({ try JSON(potentialJSONConvertible: $0) }))
    }
}

extension Bool: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .bool(self)
    }
}

extension ContiguousArray: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try .array(map({ try JSON(potentialJSONConvertible: $0) }))
    }
}

extension Dictionary: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try .dictionary(
            .init(uniqueKeysWithValues: map {
                (try cast($0.0) as String, try JSON(potentialJSONConvertible: $0.1))
            })
        )
    }
}

extension Double: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(self))
    }
}

extension Float: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(Double(self)))
    }
}

extension Int: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(self))
    }
}

extension Int16: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(self))
    }
}

extension Int32: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(self))
    }
}

extension Int64: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .number(.init(self))
    }
}

extension JSON: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return self
    }
}

extension Set: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try Array(self).jsonValue()
    }
}

extension String: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .string(self)
    }
}

extension NSArray: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try (self as [AnyObject]).jsonValue()
    }
}

extension NSDictionary: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try (self as Dictionary).jsonValue()
    }
}

extension NSNull: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return .null
    }
}

import Runtime

extension NSNumber: JSONConvertible {
    private func toSwiftNumber() throws -> Any {
        TODO.whole(.fix)
        if let value = self as? Bool {
            return value
        } else if let value = self as? Double {
            return value
        } else if let value = self as? Float {
            return value
        } else if let value = self as? Int {
            return value
        } else if let value = self as? Int8 {
            return value
        } else if let value = self as? Int16 {
            return value
        } else if let value = self as? Int32 {
            return value
        } else if let value = self as? Int64 {
            return value
        } else if let value = self as? UInt {
            return value
        } else if let value = self as? UInt8 {
            return value
        } else if let value = self as? UInt16 {
            return value
        } else if let value = self as? UInt32 {
            return value
        } else if let value = self as? UInt64 {
            return value
        } else {
            throw JSON.RuntimeError.irrepresentableNumber(self)
        }
    }

    func jsonValue() throws -> JSON {
        return try JSON(potentialJSONConvertible: try toSwiftNumber())
    }
}

extension NSSet: JSONConvertible {
    func jsonValue() throws -> JSON {
        return try (self as Set).jsonValue()
    }
}

extension NSString: JSONUnconditionalConvertible {
    func jsonValue() -> JSON {
        return (self as String).jsonValue()
    }
}

extension UInt: JSONConvertible {
    func jsonValue() throws -> JSON {
        return .number(try JSONNumber(exactly: self).unwrap())
    }
}

extension UInt16: JSONConvertible {
    func jsonValue() throws -> JSON {
        return .number(try JSONNumber(exactly: self).unwrap())
    }
}

extension UInt32: JSONConvertible {
    func jsonValue() throws -> JSON {
        return .number(try JSONNumber(exactly: self).unwrap())
    }
}

extension UInt64: JSONConvertible {
    func jsonValue() throws -> JSON {
        return .number(try JSONNumber(exactly: self).unwrap())
    }
}

// MARK: - Helpers -

extension JSON {
    init(potentialJSONConvertible value: Any) throws {
        self = try (try cast(value) as JSONConvertible).jsonValue()
    }
}
