//
// Copyright (c) Vatsal Manot
//

import Swallow

public protocol DatabaseRecordType: NamespaceRepresentable {

}

public struct NoDatabaseRecordType<Record: DatabaseRecord>: DatabaseRecordType {
    public init() {

    }

    public init?(namespace: Namespace) {
        guard namespace.isEmpty else {
            return nil
        }

        self.init()
    }

    public func toNamespace() -> Namespace {
        return Namespace()
    }
}
