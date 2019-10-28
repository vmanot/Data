//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import FoundationX
import Swallow
import Swift

@propertyWrapper
public struct CoreDataField<Value: CoreDataFieldCoder> {
    private let key: AnyStringKey
    
    public var wrappedValue: Value
    
    public var projectedValue: Self {
        self
    }
    
    public init(key: String, wrappedValue: Value) {
        self.key = .init(stringValue: key)
        self.wrappedValue = wrappedValue
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
