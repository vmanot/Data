//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow
import Swift

extension _CSVDecoder {
    final class SingleValueContainer {
        // Internal
        let codingPath: [CodingKey]
        
        // Private
        private let headers: [CSVHeader]
        private let rows: [String]
        
        // MARK: Initialization
        
        required init(headers: [CSVHeader], rows: [String], codingPath: [CodingKey])
        {
            self.headers = headers
            self.rows = rows
            self.codingPath = codingPath
        }
    }
}

extension _CSVDecoder.SingleValueContainer: SingleValueDecodingContainer {
    func decodeNil() -> Bool {
        TODO.unimplemented
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        TODO.unimplemented
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable, T: LosslessStringConvertible  {
        TODO.unimplemented
    }
}
