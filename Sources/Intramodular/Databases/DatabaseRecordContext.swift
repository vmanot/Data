//
// Copyright (c) Vatsal Manot
//

import Concurrency
import Swallow

public protocol DatabaseRecordContext: Hashable {
    associatedtype Record: DatabaseRecord
}

// MARK: - Concrete Implementations -

public struct NoDatabaseRecordContext<Record: DatabaseRecord>: DatabaseRecordContext {
    public init() {

    }
}
