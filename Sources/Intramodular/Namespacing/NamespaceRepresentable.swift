//
// Copyright (c) Vatsal Manot
//

import Swallow

public protocol NamespaceRepresentable: AnyProtocol {
    init?(namespace: Namespace)
    init?(namespaceSegment: NamespaceSegment)

    func toNamespace() -> Namespace
}

public protocol NamespaceSegmentRepresentable: NamespaceRepresentable {
    init?(namespaceSegment: NamespaceSegment)

    func toNamespaceSegment() -> NamespaceSegment
}

// MARK: - Implementation -

extension NamespaceRepresentable {
    public init?(namespaceSegment: NamespaceSegment) {
        self.init(namespace: Namespace(namespaceSegment))
    }
}

extension NamespaceSegmentRepresentable {
    public init?(namespace: Namespace) {
        guard let segment = namespace.singleSegment else {
            return nil
        }

        self.init(namespaceSegment: segment)
    }

    public func toNamespace() -> Namespace {
        return .init(toNamespaceSegment())
    }
}

// MARK: - Concrete Implementations -

extension AnyStringIdentifier: NamespaceSegmentRepresentable {
    public init?(namespaceSegment: NamespaceSegment) {
        guard case let .string(value) = namespaceSegment else {
            return nil
        }

        self.init(value)
    }

    public func toNamespaceSegment() -> NamespaceSegment {
        return .string(value)
    }
}
