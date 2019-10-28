//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

extension JSON {
    public init(jsonObjectData data: Data) throws {
        guard !data.isEmpty else {
            self = .null
            return
        }

        self = try JSONDecoder().decode(JSON.self, from: data, allowFragments: true)
    }
    
    public init(jsonObject: Any?) throws {
        if let jsonObject = jsonObject, !(jsonObject is NSNull) {
            if let json = (((try? (jsonObject as? JSONConvertible)?.jsonValue()) as JSON??)), let _json = json {
                self = _json
            } else {
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                self = try JSONDecoder().decode(JSON.self, from: data, allowFragments: true)
            }
        } else {
            self = .null
        }
    }
    
    public func toJSONObject() throws -> Any? {
        if case .null = self {
            return nil
        } else if isTopLevelFragment {
            return rawValue
        } else {
            return try JSONSerialization.jsonObject(with: try Data(json: self), options: [])
        }
    }
}

extension Data {
    public init(json: JSON) throws {
        if json == .null {
            self = Data()
        } else if let topLevelFragmentData = json.topLevelFragmentData {
            self = topLevelFragmentData
        } else {
            self = try JSONEncoder().encode(json)
        }
    }

    public func toJSON() throws -> JSON {
        return try JSONDecoder().decode(JSON.self, from: self, allowFragments: true)
    }
}

extension UserDefaults {
    public func json(forKey key: String) -> JSON? {
        return data(forKey: key).flatMap({ try? .init(jsonObjectData: $0) })
    }

    public func setJSON(_ json: JSON, forKey key: String) throws {
        set(try json.toJSONData(), forKey: key)
    }

    public func setJSON(_ json: Encodable, forKey key: String) throws {
        set(try json.toJSONData(), forKey: key)
    }
}
