//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

extension CSVDecoder._Decoder {
    final class SingleValueContainer {
        let codingPath: [CodingKey]
        
        private let headers: [CSVHeader]
        private let rows: [String]
        
        required init(headers: [CSVHeader], rows: [String], codingPath: [CodingKey])
        {
            self.headers = headers
            self.rows = rows
            self.codingPath = codingPath
        }
    }
}

extension CSVDecoder._Decoder.SingleValueContainer: SingleValueDecodingContainer {
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
