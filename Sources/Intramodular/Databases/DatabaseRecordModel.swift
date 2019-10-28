//
// Copyright (c) Vatsal Manot
//

import Concurrency
import Swallow

public protocol opaque_IdentifiableDatabaseRecordModel: Codable {
    static var databaseNamespace: Namespace { get }
    static var identifierCodingKey: AnyCodingKey { get }
}

public protocol IdentifiableDatabaseRecordModel: opaque_IdentifiableDatabaseRecordModel, DatabaseRecordAssociable, Identifiable where Identifier: Codable {
    /// The database namespace for this type.
    static var databaseNamespace: Namespace { get }

    /// The coding key for the identifier for this model.
    static var identifierCodingKey: AnyCodingKey { get }
}
