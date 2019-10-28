//
// Copyright (c) Vatsal Manot
//

import Swallow

public enum CoreDataError: Error {
    case entityNotFound(name: String)
}

public enum DatabaseError: Error {
    case recordNotFound(identifier: AnyIdentifier)
    case unknown
}
