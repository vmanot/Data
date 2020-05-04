//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Merge
import Swift

public struct CoreDataContainer {
    private let cancellables = Cancellables()
    
    public let base: NSPersistentContainer
    private let cloudKitContainerIdentifier: String?
    
    public static func cloudKitContainer(name: String, cloudKitContainerIdentifier: String) -> Self {
        return .init(
            base: .init(name: name),
            cloudKitContainerIdentifier: cloudKitContainerIdentifier
        )
    }
    
    public func loadViewContext() {
        guard let description = base.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }
        
        description.cloudKitContainerOptions = cloudKitContainerIdentifier.map({ .init(containerIdentifier: $0) })
        
        base.loadPersistentStores()
            .map({
                self.base
                    .viewContext
                    .automaticallyMergesChangesFromParent = true
            })
            .subscribe(storeIn: cancellables)
    }
    
    public func saveViewContext() {
        if base.viewContext.hasChanges {
            try! base.viewContext.save()
        }
    }
}
