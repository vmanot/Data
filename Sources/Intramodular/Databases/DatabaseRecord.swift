//
// Copyright (c) Vatsal Manot
//

import Combine
import Concurrency
import Foundation
import Swallow

public protocol DatabaseRecord: class, Hashable {
    associatedtype Database: RecordDatabase

    associatedtype `Type`: DatabaseRecordType = NoDatabaseRecordType<Self>
    associatedtype Context: DatabaseRecordContext = NoDatabaseRecordContext<Self>
    associatedtype Data: Codable
    associatedtype Metadata: DatabaseRecordMetadata = NoDatabaseRecordMetadata<Self>

    var container: Weak<Database> { get }

    var type: `Type` { get }
    var context: Context { get }
    var data: Data { get }
    var metadata: Metadata { get }
}

public protocol IdentifiableDatabaseRecord: DatabaseRecord, Identifiable where Identifier: NamespaceRepresentable {

}

// MARK: - Implementation -

extension DatabaseRecord where Context == NoDatabaseRecordContext<Self> {
    public var context: NoDatabaseRecordContext<Self> {
        return .init()
    }
}

extension DatabaseRecord where Metadata == NoDatabaseRecordMetadata<Self> {
    public var metadata: NoDatabaseRecordMetadata<Self> {
        return .init()
    }
}

extension DatabaseRecord where `Type` == NoDatabaseRecordType<Self> {
    public var type: `Type` {
        return .init()
    }
}
