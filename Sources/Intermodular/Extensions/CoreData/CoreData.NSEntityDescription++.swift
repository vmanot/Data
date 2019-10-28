//
// Copyright (c) Vatsal Manot
//

import CoreData
import Swallow

extension NSEntityDescription {
    public var allKeys: [AnyCodingKey] {
        return properties
            .map({ .init(stringValue: $0.name) })
            + (self.superentity?.allKeys ?? [])
    }
    
    public func contains<Key: CodingKey>(key: Key) -> Bool {
        return allKeys.contains(where: { $0.stringValue == key.stringValue })
    }
}
