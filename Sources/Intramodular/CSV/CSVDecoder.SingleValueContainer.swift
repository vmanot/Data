//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swallow

extension CSVDecoder._Decoder {
    final class SingleValueContainer {
        let codingPath: [CodingKey]
        
        private let headers: [CSVColumnHeader]
        private let rows: [String]
        
        required init(headers: [CSVColumnHeader], rows: [String], codingPath: [CodingKey])
        {
            self.headers = headers
            self.rows = rows
            self.codingPath = codingPath
        }
    }
}

extension CSVDecoder._Decoder.SingleValueContainer: SingleValueDecodingContainer {
    func decodeNil() -> Bool {
        return false
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        throw Never.Reason.irrational
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable, T: LosslessStringConvertible  {
        throw Never.Reason.irrational
    }
}
