//
// Copyright (c) Vatsal Manot
//

import Combine
import Concurrency
import Swallow

public protocol Database: class {
    associatedtype DatabaseChangeNotificationProducer: Publisher where DatabaseChangeNotificationProducer.Output == Void

    func listen() -> DatabaseChangeNotificationProducer
}

public protocol TransientDatabase: Database {
    associatedtype DatabaseCommitProducer: Publisher where DatabaseCommitProducer.Output == Void

    func commit() -> DatabaseCommitProducer
}
