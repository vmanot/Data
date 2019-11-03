//
// Copyright (c) Vatsal Manot
//

import CoreData
import Swift

open class CoreDataObject: NSManagedObject {
    open func deriveRealtimeAttributes() {
        
    }
    
    override open func awakeFromFetch() {
        super.awakeFromFetch()
        
        deriveRealtimeAttributes()
    }
    
    override open func willSave() {
        super.willSave()
        
        deriveRealtimeAttributes()
    }
    
    override open func willAccessValue(forKey key: String?) {
        super.willAccessValue(forKey: key)
    }
    
    open func defaultPrimitiveValue(forKey key: String) -> Any? {
        return nil
    }
    
    override open func primitiveValue(forKey key: String) -> Any? {
        if let result = super.primitiveValue(forKey: key) {
            return result
        } else if let result = defaultPrimitiveValue(forKey: key) {
            return result
        } else {
            return nil
        }
    }
}
