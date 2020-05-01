//
// Copyright (c) Vatsal Manot
//

import CoreData
import Foundation
import Swift

public struct EntityAttributeDescription: EntityPropertyDescription {
    public private(set) var name: String
    public private(set) var isOptional: Bool = false
    public private(set) var isTransient: Bool = false
    public private(set) var type: EntityAttributeTypeDescription = .undefined
    public private(set) var allowsExternalBinaryDataStorage: Bool = false
    public private(set) var preservesValueInHistoryOnDeletion: Bool = false

    public init(name: String) {
        self.name = name
    }

    public func toNSAttributeDescription() -> NSAttributeDescription {
        let result = NSAttributeDescription()

        result.name = name
        result.isOptional = isOptional
        result.isTransient = isTransient

        switch type {
        case .undefined:
            result.attributeType = .undefinedAttributeType
        case .integer16:
            result.attributeType = .integer16AttributeType
        case .integer32:
            result.attributeType = .integer32AttributeType
        case .integer64:
            result.attributeType = .integer64AttributeType
        case .decimal:
            result.attributeType = .decimalAttributeType
        case .double:
            result.attributeType = .doubleAttributeType
        case .float:
            result.attributeType = .floatAttributeType
        case .string:
            result.attributeType = .stringAttributeType
        case .boolean:
            result.attributeType = .booleanAttributeType
        case .date:
            result.attributeType = .dateAttributeType
        case .binaryData:
            result.attributeType = .binaryDataAttributeType
        case .UUID:
            result.attributeType = .UUIDAttributeType
        case .URI:
            result.attributeType = .URIAttributeType
        case let .transformable(className):
            result.attributeType = .transformableAttributeType
            result.attributeValueClassName = className
        case .objectID:
            result.attributeType = .objectIDAttributeType
        }

        result.allowsExternalBinaryDataStorage = allowsExternalBinaryDataStorage
        result.preservesValueInHistoryOnDeletion = preservesValueInHistoryOnDeletion

        return result
    }

    public func toNSPropertyDescription() -> NSPropertyDescription {
        return toNSAttributeDescription()
    }
}

extension EntityAttributeDescription {
    public func `type`(_ value: EntityAttributeTypeDescription) -> EntityAttributeDescription {
        var result = self

        result.type = value

        return result
    }

    public func optional(_ value: Bool) -> EntityAttributeDescription {
        var result = self

        result.isOptional = value

        return result
    }

    public func allowsExternalBinaryDataStorage(_ value: Bool) -> EntityAttributeDescription {
        var result = self

        result.allowsExternalBinaryDataStorage = value

        return result
    }

    public func preservesValueInHistoryOnDeletion(_ value: Bool) -> EntityAttributeDescription {
        var result = self

        result.preservesValueInHistoryOnDeletion = value

        return result
    }
}

// MARK: - Helpers -

@dynamicMemberLookup
public struct EntityAttributeDescriptionBuilder {
    public init() {

    }

    public subscript(dynamicMember name: String) -> EntityAttributeDescription {
        EntityAttributeDescription(name: name)
    }
}
