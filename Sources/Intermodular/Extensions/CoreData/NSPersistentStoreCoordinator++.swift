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
    
    public func eraseAll() throws {
        for store in persistentStores {
            try remove(store)
            
            if let url = store.url {
                try FileManager.default.removeItem(at: url)
            }
        }
    }
}
