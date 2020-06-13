//
// Copyright (c) Vatsal Manot
//

import Concurrency
import CoreData
import Swallow

extension NSPersistentStoreCoordinator {
    public func entity(forName name: String) -> NSEntityDescription? {
        return managedObjectModel.entitiesByName[name]
    }
    
    public func destroyAll() throws {
        for store in persistentStores {
            try store.destroy()
        }
    }
}
