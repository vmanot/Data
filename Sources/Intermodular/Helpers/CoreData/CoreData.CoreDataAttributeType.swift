//
// Copyright (c) Vatsal Manot
//

import Foundation
import CoreData
import Swift

public protocol CoreDataAttributeType: CoreDataFieldCoder {
    
}

// MARK: - Implementation -

extension CoreDataAttributeType {
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

// MARK: - Implementations -

extension Bool: CoreDataAttributeType {
    
}

extension Data: CoreDataAttributeType {
    
}

extension Decimal: CoreDataAttributeType {
    
}

extension Double: CoreDataAttributeType {
    
}

extension Float: CoreDataAttributeType {
    
}

extension Int: CoreDataAttributeType {
    
}

extension Int8: CoreDataAttributeType {
    
}

extension Int16: CoreDataAttributeType {
    
}

extension Int32: CoreDataAttributeType {
    
}

extension Int64: CoreDataAttributeType {
    
}

extension NSNumber: CoreDataAttributeType {
    
}

extension UUID: CoreDataAttributeType {
    
}
