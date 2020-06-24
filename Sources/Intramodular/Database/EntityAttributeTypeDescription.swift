//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Swift

public enum EntityAttributeTypeDescription {
    case undefined
    case integer16
    case integer32
    case integer64
    case decimal
    case double
    case float
    case string
    case boolean
    case date
    case binaryData
    case UUID
    case URI
    case transformable(className: String)
    case objectID
}
