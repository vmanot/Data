//
// Copyright (c) Vatsal Manot
//

import Foundation
import CoreData
import Swift

public protocol NSPrimitiveAttributeCoder: NSAttributeCoder {
    
}

// MARK: - Implementation -

extension NSPrimitiveAttributeCoder {
    public static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) -> Self {
        object.primitiveValue(forKey: key.stringValue) as! Self
    }
    
    public static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) -> Self {
        let key = key.stringValue
        
        object.willAccessValue(forKey: key)
        
        defer {
            object.didAccessValue(forKey: key)
        }
        
        return object.primitiveValue(forKey: key) as! Self
    }
    
    public func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) {
        return object.setPrimitiveValue(self, forKey: key.stringValue)
    }
    
    public func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) {
        let key = key.stringValue
        
        object.willChangeValue(forKey: key)
        
        defer {
            object.didChangeValue(forKey: key)
        }
        
        return object.setPrimitiveValue(self, forKey: key)
    }
}

// MARK: - Concrete Implementations -

extension Bool: NSPrimitiveAttributeCoder {
    
}

extension Character: NSPrimitiveAttributeCoder {
    public static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) -> Self {
        .init(String.decodePrimitive(from: object, forKey: key))
    }
    
    public static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) -> Self {
        .init(String.decode(from: object, forKey: key))
    }
    
    public func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) {
        stringValue.encodePrimitive(to: object, forKey: key)
    }
    
    public func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) {
        stringValue.encode(to: object, forKey: key)
    }
}

extension Data: NSPrimitiveAttributeCoder {
    
}

extension Decimal: NSPrimitiveAttributeCoder {
    
}

extension Double: NSPrimitiveAttributeCoder {
    
}

extension Float: NSPrimitiveAttributeCoder {
    
}

extension Int: NSPrimitiveAttributeCoder {
    
}

extension Int8: NSPrimitiveAttributeCoder {
    
}

extension Int16: NSPrimitiveAttributeCoder {
    
}

extension Int32: NSPrimitiveAttributeCoder {
    
}

extension Int64: NSPrimitiveAttributeCoder {
    
}

extension NSNumber: NSPrimitiveAttributeCoder {
    
}

extension Optional: NSAttributeCoder where Wrapped: NSAttributeCoder {
    public static func decodePrimitive<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        if object.primitiveValue(forKey: key.stringValue) == nil {
            return .none
        } else {
            return try Wrapped.decodePrimitive(from: object, forKey: key)
        }
    }
    
    public static func decode<Key: CodingKey>(from object: NSManagedObject, forKey key: Key) throws -> Self {
        if object.value(forKey: key.stringValue) == nil {
            return .none
        } else {
            return try Wrapped.decodePrimitive(from: object, forKey: key)
        }
    }
    
    public func encodePrimitive<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        if let value = self {
            try value.encodePrimitive(to: object, forKey: key)
        } else {
            object.setPrimitiveValue(nil, forKey: key.stringValue)
        }
    }
    
    public func encode<Key: CodingKey>(to object: NSManagedObject, forKey key: Key) throws {
        if let value = self {
            try value.encode(to: object, forKey: key)
        } else {
            object.setValue (nil, forKey: key.stringValue)
        }
    }
}

extension Optional: NSPrimitiveAttributeCoder where Wrapped: NSPrimitiveAttributeCoder {
    
}

extension String: NSPrimitiveAttributeCoder {
    
}

extension UUID: NSPrimitiveAttributeCoder {
    
}
