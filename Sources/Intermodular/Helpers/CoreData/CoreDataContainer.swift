//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Merge
import Swift

public final class CoreDataContainer: ObservableObject {
    private let cancellables = Cancellables()
    
    public let base: NSPersistentContainer
    
    private let cloudKitContainerIdentifier: String?
    
    private init(
        base: NSPersistentContainer,
        cloudKitContainerIdentifier: String?
    ) {
        self.base = base
        self.cloudKitContainerIdentifier = cloudKitContainerIdentifier
    }
    
    public init(name: String) {
        self.base = NSPersistentContainer(name: name)
        self.cloudKitContainerIdentifier = nil
    }
    
    public static func cloudKitContainer(
        name: String,
        managedObjectModel: NSManagedObjectModel? = nil,
        cloudKitContainerIdentifier: String
    ) -> CoreDataContainer {
        if let managedObjectModel = managedObjectModel {
            return .init(
                base: NSPersistentCloudKitContainer(
                    name: name,
                    managedObjectModel: managedObjectModel
                ),
                cloudKitContainerIdentifier: cloudKitContainerIdentifier
            )
        } else {
            return .init(
                base: NSPersistentCloudKitContainer(name: name),
                cloudKitContainerIdentifier: cloudKitContainerIdentifier
            )
        }
    }
}

extension CoreDataContainer {
    public func loadViewContext() {
        guard let description = base.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }
        
        if let cloudKitContainerIdentifier = cloudKitContainerIdentifier {
            description.cloudKitContainerOptions = .init(containerIdentifier: cloudKitContainerIdentifier)
            
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }
        
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
    
    public func destroyAndRebuild() {
        try! base.persistentStoreCoordinator.destroyAll()
        
        base.loadPersistentStores().subscribe(storeIn: cancellables)
    }
}
