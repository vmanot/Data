//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Swallow

@propertyWrapper
public struct CoreDataField<Value: CoreDataFieldCoder> {
    private let key: AnyStringKey
    
    public var wrappedValue: Value
    
    public init(key: String, defaultValue: Value) {
        self.key = .init(stringValue: key)
        self.wrappedValue = defaultValue
    }
        
    public static subscript<EnclosingSelf: NSManagedObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            try! Value.decode(from: object, forKey: object[keyPath: storageKeyPath].key)
        } set {
            try! newValue.encode(to: object, forKey: object[keyPath: storageKeyPath].key)
            
            object[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
}
