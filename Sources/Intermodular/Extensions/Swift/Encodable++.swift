//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

extension Encodable {
    public func toObjectDecoder() throws -> Decoder {
        let wrapper = try ObjectDecoder().decode(
            DecoderUnwrapper.self, from:
            ObjectEncoder().encode(self)
        )
        
        return wrapper.value
    }
}

extension Encodable {
    public func toJSONData(prettyPrint: Bool = false) throws -> Data {
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .sortedKeys
        encoder.outputFormatting.formUnion(prettyPrint ? [.prettyPrinted] : [])
        
        return try encoder.encode(self, allowFragments: true)
    }
    
    public func toJSONString(prettyPrint: Bool = false) -> String? {
        return (try? toJSONData(prettyPrint: prettyPrint)).flatMap({ String(data: $0, encoding: .utf8) })
    }
}
