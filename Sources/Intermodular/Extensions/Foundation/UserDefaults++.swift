//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swift

extension UserDefaults {
    public func jsonData(forKey key: String) -> JSON? {
        return data(forKey: key).flatMap({ try? .init(jsonObjectData: $0) })
    }
    
    public func setJSONData(_ json: JSON, forKey key: String) throws {
        set(try json.toJSONData(), forKey: key)
    }
}
