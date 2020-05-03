//
// Copyright (c) Vatsal Manot
//

import CoreData
import Swift

///
/// A modern `NSManagedObject` subclass.
///
open class CoreDataObject: NSManagedObject {
    open func setupInitialAttributes() {
        
    }
    
    /// Derive and set any calculated attributes.
    ///
    /// This is typically done for optimization purposes.
    open func deriveAttributes() {
        
    }
    
    override open func awakeFromInsert() {
        super.awakeFromInsert()
        
        setupInitialAttributes()
        deriveAttributes()
    }
    
    override open func awakeFromFetch() {
        super.awakeFromFetch()
        
        deriveAttributes()
    }
    
    override open func willSave() {
        super.willSave()
        
        deriveAttributes()
    }
    
    override open func willAccessValue(forKey key: String?) {
        super.willAccessValue(forKey: key)
    }
    
    override public func willChangeValue(forKey key: String) {
        super.willChangeValue(forKey: key)
        
        objectWillChange.send()
    }
    
    /// Provide a fallback value for `primitiveValue(forKey:)`.
    open func primitiveDefaultValue(forKey key: String) -> Any? {
        return nil
    }
    
    override open func primitiveValue(forKey key: String) -> Any? {
        if let result = super.primitiveValue(forKey: key) {
            return result
        } else if let result = primitiveDefaultValue(forKey: key) {
            return result
        } else {
            return nil
        }
    }
}
