//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Swallow

struct ManagedObjectModel {
    public let entities: [EntityDescription]
    
    public init(_ entity: () -> EntityDescription) {
        self.entities = [entity()]
    }
    
    public init(@ArrayBuilder<EntityDescription> entities: () -> [EntityDescription]) {
        self.entities = entities()
    }
}

extension ManagedObjectModel {
    public func toNSManagedObjectModel() -> NSManagedObjectModel {
        let result = NSManagedObjectModel()
        
        result.entities = entities.map({ $0.toNSEntityDescription() })
        
        return result
    }
}
