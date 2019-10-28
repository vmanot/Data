//
// Copyright (c) Vatsal Manot
//

import Swallow

public protocol DatabaseRecordMetadata: Hashable {
    associatedtype Record: DatabaseRecord
}

// MARK: - Concrete Implementations -

public struct NoDatabaseRecordMetadata<Record: DatabaseRecord>: DatabaseRecordMetadata {
    public init() {

    }
}
